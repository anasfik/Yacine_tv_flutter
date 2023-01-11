const express = require("express");
const app = express();
const cors = require("cors");
const { MongoClient, ObjectId } = require("mongodb");
const client = new MongoClient(
  "mongodb+srv://gwhyyy:gwhyyy@cluster0.ktg0sfb.mongodb.net/?retryWrites=true&w=majority"
);

app.use(express.json());
app.use(cors());

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET,PUT,PATCH,POST,DELETE");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept"
  );
  next();
});
const CategoriesCollection = client.db("main_db").collection("categories");
const adminsCollection = client.db("main_db").collection("admins");
const matchEventsCollection = client.db("main_db").collection("matchEvents");
const drawerMenuCollection = client.db("main_db").collection("drawerMenu");
const appSettingsCollection = client.db("main_db").collection("settings");

app.post("/login", async (req, res) => {
  const { username, password } = req.body;

  const adminDocument = await adminsCollection.findOne({
    username: username,
  });

  if (adminDocument === null) {
    res.status(404).send(
      JSON.stringify({
        status: 404,
        message: "username does not exist",
      })
    );
    return;
  } else {
    if (adminDocument.password === password) {
      res.status(200).send(
        JSON.stringify({
          status: 200,
          message: "Login successful",
        })
      );
    } else {
      res.status(401).send(
        JSON.stringify({
          status: 401,
          message: "Invalid password",
        })
      );
    }
  }
});
app.post("/categories", async (req, res) => {
  const categoryBody = req.body;
  if (checkCategoryBody(categoryBody)) {
    res.status(400).send(
      JSON.stringify({
        status: 400,
        message: "Bad Request",
      })
    );
    return;
  }

  try {
    const categoryBodyWithIdOnChannel = {
      ...categoryBody,
      channels: categoryBody.channels.map((channel) => {
        return {
          ...channel,
          _id: ObjectId(),
        };
      }),
    };

    const insertionResult = await CategoriesCollection.insertOne(
      categoryBodyWithIdOnChannel
    );
    console.log(insertionResult.insertedId + " inserted");
    res.status(200).send(
      JSON.stringify({
        status: 200,
        message: "Category inserted successfully",
        insertedId: insertionResult.insertedId,
        created_at: new Date(),
        channels_length: categoryBody.channels.length,
      })
    );
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.get("/categories", async (req, res) => {
  try {
    const categories = await CategoriesCollection.find().toArray();
    res.status(200).send(
      JSON.stringify({
        status: 200,
        message: "Categories fetched successfully",
        data: categories,
      })
    );
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.get("/categories/:id", async (req, res) => {
  try {
    const id = req.params.id;
    console.log(id);
    const category = await CategoriesCollection.findOne({
      _id: ObjectId(id),
    });

    if (category === null) {
      res.status(404).send(
        JSON.stringify({
          status: 404,
          message: "Not Found",
        })
      );
    } else {
      res.status(200).send(
        JSON.stringify({
          status: 200,
          message: "Category fetched successfully",
          data: category,
        })
      );
    }
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.put("/categories/:id", async (req, res) => {
  const categoryBody = req.body;
  if (checkCategoryBody(categoryBody)) {
    res.status(400).send(
      JSON.stringify({
        status: 400,
        message: "Bad Request",
      })
    );
    return;
  }

  try {
    const id = req.params.id;
    const updateResult = await CategoriesCollection.updateOne(
      { _id: ObjectId(id) },
      {
        $set: {
          category_title: categoryBody.category_title,
          updated_at: new Date(),
        },
      }
    );
    if (updateResult.modifiedCount === 0) {
      res.status(404).send(
        JSON.stringify({
          status: 404,
          message: "Not Found",
        })
      );
    } else {
      res.status(200).send(
        JSON.stringify({
          status: 200,
          message: "Category updated successfully",
          updatedId: id,
          updated_at: new Date(),
        })
      );
    }
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,

        message: "Internal Server Error",
      })
    );
  }
});

app.delete("/categories/:id", async (req, res) => {
  try {
    const id = req.params.id;
    const deleteResult = await CategoriesCollection.deleteOne({
      _id: ObjectId(id),
    });

    if (deleteResult.deletedCount === 0) {
      res.status(404).send(
        JSON.stringify({
          status: 404,
          message: "Not Found",
        })
      );

      return;
    }

    res.status(200).send(
      JSON.stringify({
        status: 200,
        message: "Category deleted successfully",
        deletedId: id,
      })
    );
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.delete("/categories", async (req, res) => {
  try {
    const deleteResult = await CategoriesCollection.deleteMany({});
    res.status(200).send(
      JSON.stringify({
        status: 200,
        message: "Categories deleted successfully",
        deletedCount: deleteResult.deletedCount,
      })
    );
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.post("/categories/:id/channels", async (req, res) => {
  const channelBody = req.body;
  if (checkChannelBody(channelBody)) {
    res.status(400).send(
      JSON.stringify({
        status: 400,
        message: "Bad Request",
      })
    );
    return;
  }

  try {
    const id = req.params.id;

    const insertionResult = await CategoriesCollection.updateOne(
      { _id: ObjectId(id) },
      { $push: { channels: { _id: ObjectId(), ...channelBody } } }
    );

    if (insertionResult.insertedId === null) {
      res.status(404).send(
        JSON.stringify({
          status: 404,
          message: "Not Found",
        })
      );

      return;
    }

    res.status(201).send(
      JSON.stringify({
        status: 201,
        message: "Channel created successfully",
        createdId: channelBody._id,
      })
    );
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.delete("/categories/:id/channels/:channelId", async (req, res) => {
  try {
    const id = req.params.id;
    const channelId = req.params.channelId;
    const deleteResult = await CategoriesCollection.updateOne(
      { _id: ObjectId(id) },
      { $pull: { channels: { _id: ObjectId(channelId) } } }
    );

    if (deleteResult.modifiedCount === 0) {
      res.status(404).send(
        JSON.stringify({
          status: 404,

          message: "Not Found",
        })
      );
    } else {
      res.status(200).send(
        JSON.stringify({
          status: 200,
          message: "Channel deleted successfully",
          deletedId: channelId,
        })
      );
    }
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.put("/categories/:id/channels/:channelId", async (req, res) => {
  const channelBody = req.body;
  if (checkChannelBody(channelBody)) {
    res.status(400).send(
      JSON.stringify({
        status: 400,
        message: "Bad Request",
      })
    );

    return;
  }

  try {
    const id = req.params.id;
    const channelId = req.params.channelId;

    const updateResult = await CategoriesCollection.updateOne(
      { _id: ObjectId(id), "channels._id": ObjectId(channelId) },
      { $set: { "channels.$": channelBody } }
    );

    if (updateResult.modifiedCount === 0) {
      res.status(404).send(
        JSON.stringify({
          status: 404,
          message: "Not Found",
        })
      );
    } else {
      res.status(200).send(
        JSON.stringify({
          status: 200,
          message: "Channel updated successfully",
          updatedId: channelId,
          updated_at: new Date(),
        })
      );
    }
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.get("/match_events", async (req, res) => {
  try {
    const matchEvents = await matchEventsCollection.find().toArray();
    res.status(200).send(
      JSON.stringify({
        status: 200,
        message: "Match Events fetched successfully",
        data: matchEvents,
      })
    );
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.get("/match_events/:id", async (req, res) => {
  try {
    const id = req.params.id;
    const matchEvent = await matchEventsCollection.findOne({
      _id: ObjectId(id),
    });

    if (matchEvent === null) {
      res.status(404).send(
        JSON.stringify({
          status: 404,
          message: "Not Found",
        })
      );
    } else {
      res.status(200).send(
        JSON.stringify({
          status: 200,
          message: "Match Event fetched successfully",
          data: matchEvent,
        })
      );
    }
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.post("/match_events", async (req, res) => {
  const matchEventBody = req.body;
  if (checkMatchEventBody(matchEventBody)) {
    res.status(400).send(
      JSON.stringify({
        status: 400,
        message: "Bad Request",
      })
    );
    return;
  }

  try {
    const insertResult = await matchEventsCollection.insertOne(matchEventBody);
    res.status(201).send(
      JSON.stringify({
        status: 201,
        message: "Match Event created successfully",
        createdId: insertResult.insertedId,
      })
    );
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.put("/match_events/:id", async (req, res) => {
  const matchEventBody = req.body;

  if (checkMatchEventBody(matchEventBody)) {
    res.status(400).send(
      JSON.stringify({
        status: 400,
        message: "Bad Request",
      })
    );
    return;
  }

  try {
    const id = req.params.id;
    const updateResult = await matchEventsCollection.updateOne(
      { _id: ObjectId(id) },
      { $set: matchEventBody }
    );
    if (updateResult.modifiedCount === 0) {
      res.status(404).send(
        JSON.stringify({
          status: 404,
          message: "Not Found",
        })
      );
    } else {
      res.status(200).send(
        JSON.stringify({
          status: 200,

          message: "Match Event updated successfully",

          updatedId: id,
        })
      );
    }
  } catch (error) {
    console.log(error);

    res.status(500).send(
      JSON.stringify({
        status: 500,

        message: "Internal Server Error",
      })
    );
  }
});

app.delete("/match_events/:id", async (req, res) => {
  try {
    const id = req.params.id;

    const deleteResult = await matchEventsCollection.deleteOne({
      _id: ObjectId(id),
    });

    if (deleteResult.deletedCount === 0) {
      res.status(404).send(
        JSON.stringify({
          status: 404,
          message: "Not Found",
        })
      );
    } else {
      res.status(200).send(
        JSON.stringify({
          status: 200,
          message: "Match Event deleted successfully",
          deletedId: id,
        })
      );
    }
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.delete("/match_events", async (req, res) => {
  try {
    const deleteResult = await matchEventsCollection.deleteMany({});
    res.status(200).send(
      JSON.stringify({
        status: 200,
        message: "Match Events deleted successfully",
        deletedCount: deleteResult.deletedCount,
      })
    );
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.get("/drawer_menu", async (req, res) => {
  try {
    const drawerMenu = await drawerMenuCollection.find().toArray();
    res.status(200).send(
      JSON.stringify({
        status: 200,
        message: "Drawer Menu fetched successfully",
        data: drawerMenu,
      })
    );
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.post("/drawer_menu", async (req, res) => {
  const drawerMenuItemBody = req.body;
  if (checkDrawerMenuItemBody(drawerMenuItemBody)) {
    res.status(400).send(
      JSON.stringify({
        status: 400,
        message: "Bad Request",
      })
    );
  }

  try {
    const insertResult = await drawerMenuCollection.insertOne(
      drawerMenuItemBody
    );
    res.status(201).send(
      JSON.stringify({
        status: 201,
        message: "Drawer Menu item created successfully",
        createdId: insertResult.insertedId,
      })
    );
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.put("/drawer_menu/:id", async (req, res) => {
  const drawerMenuItemBody = req.body;
  if (checkDrawerMenuItemBody(drawerMenuItemBody)) {
    res.status(400).send(
      JSON.stringify({
        status: 400,
        message: "Bad Request",
      })
    );
    return;
  }

  try {
    const id = req.params.id;
    const updateResult = await drawerMenuCollection.updateOne(
      { _id: ObjectId(id) },

      { $set: drawerMenuItemBody }
    );
    if (updateResult.modifiedCount === 0) {
      res.status(404).send(
        JSON.stringify({
          status: 404,
          message: "Not Found",
        })
      );
    } else {
      res.status(200).send(
        JSON.stringify({
          status: 200,
          message: "Drawer Menu item updated successfully",
          updatedId: id,
        })
      );
    }
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.delete("/drawer_menu/:id", async (req, res) => {
  try {
    const id = req.params.id;
    const deleteResult = await drawerMenuCollection.deleteOne({
      _id: ObjectId(id),
    });
    if (deleteResult.deletedCount === 0) {
      res.status(404).send(
        JSON.stringify({
          status: 404,
          message: "Not Found",
        })
      );
    } else {
      res.status(200).send(
        JSON.stringify({
          status: 200,
          message: "Drawer Menu item deleted successfully",
          deletedId: id,
        })
      );
    }
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.get("/all_channels", async (req, res) => {
  try {
    const allChannels = await CategoriesCollection.find()
      .project({
        channels: 1,
      })
      .toArray();
    res.status(200).send(
      JSON.stringify({
        status: 200,
        message: "All Channels fetched successfully",
        data: allChannels.flatMap((category) => category.channels),
      })
    );
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,

        message: "Internal Server Error",
      })
    );
  }
});

app.get("/app_settings", async (req, res) => {
  try {
    const appSettings = await appSettingsCollection.findOne({
      _id: ObjectId("settings"),
    });

    res.status(200).send(
      JSON.stringify({
        status: 200,
        message: "App Settings fetched successfully",
        data: appSettings,
      })
    );
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.put("/app_settings", async (req, res) => {
  const appSettingsBody = req.body;
  if (checkAppSettingsBody(appSettingsBody)) {
    res.status(400).send(
      JSON.stringify({
        status: 400,
        message: "Bad Request",
      })
    );

    return;
  }
  try {
    const ifExist = await appSettingsCollection.findOne({ _id: "settings" });

    console.log(ifExist);

    if (ifExist === null) {
      const insertResult = await appSettingsCollection.insertOne({
        _id: "settings",
        ...appSettingsBody,
      });
    } else {
      const updateResult = await appSettingsCollection.updateOne(
        { _id: "settings" },
        { $set: appSettingsBody }
      );
    }
    res.status(201).send(
      JSON.stringify({
        status: 201,
        message: "App Settings updated successfully",
      })
    );
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.get("/app_settings", async (req, res) => {
  try {
    const insertResult = await appSettingsCollection.findOne({
      _id: ObjectId("settings"),
    });
    res.status(200).send(
      JSON.stringify({
        status: 200,
        message: "App Settings fetched successfully",
        data: appSettings,
      })
    );
  } catch (error) {
    console.log(error);
    res.status(500).send(
      JSON.stringify({
        status: 500,
        message: "Internal Server Error",
      })
    );
  }
});

app.listen(8080, () => {
  console.log("Server is running on port 8080. Ready to accept requests!");
});

function checkCategoryBody(categoryBody) {
  return categoryBody.category_title === undefined;
}

function checkMatchEventBody(matchEventBody) {
  return (
    matchEventBody.first_team === undefined ||
    matchEventBody.first_team_logo === undefined ||
    matchEventBody.second_team === undefined ||
    matchEventBody.second_team_logo === undefined ||
    matchEventBody.cup_name === undefined ||
    matchEventBody.channel_name === undefined ||
    matchEventBody.channels_quality === undefined ||
    matchEventBody.commenter_name === undefined ||
    matchEventBody.date_of_match_with_time === undefined
  );
}

function checkDrawerMenuItemBody(drawerMenuItemBody) {
  return (
    drawerMenuItemBody.title === undefined ||
    drawerMenuItemBody.icon === undefined ||
    drawerMenuItemBody.link === undefined
  );
}

function checkChannelBody(channelBody) {
  return (
    channelBody.channel_name === undefined ||
    channelBody.channel_image === undefined ||
    channelBody.channel_stream_url === undefined ||
    channelBody.tags === undefined
  );
}

function checkAppSettingsBody(appSettingsBody) {
  return (
    appSettingsBody.show_ads === undefined ||
    appSettingsBody.admob_app_id === undefined ||
    appSettingsBody.admob_banner_id === undefined ||
    appSettingsBody.admob_interstitial_id === undefined ||
    appSettingsBody.show_share === undefined ||
    appSettingsBody.app_logo_cover === undefined ||
    appSettingsBody.app_version === undefined ||
    appSettingsBody.app_author === undefined ||
    appSettingsBody.app_email === undefined ||
    appSettingsBody.app_website === undefined ||
    appSettingsBody.app_privacy_policy === undefined
  );
}
