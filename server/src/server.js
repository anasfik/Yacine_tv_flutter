const express = require("express");
const app = express();
const { MongoClient, ObjectId } = require("mongodb");
const client = new MongoClient(
  "mongodb+srv://gwhyyy:gwhyyy@cluster0.ktg0sfb.mongodb.net/?retryWrites=true&w=majority"
);
const CategoriesCollection = client.db("main_db").collection("categories");
const matchEventsCollection = client.db("main_db").collection("matchEvents");
const drawerMenuCollection = client.db("main_db").collection("drawerMenu");

app.use(express.json());

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
    const insertionResult = await CategoriesCollection.insertOne(categoryBody);
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
      { $set: categoryBody }
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
          channels_length: categoryBody.channels.length,
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

app.listen(8080, () => {
  console.log("Server is running on port 8080. Ready to accept requests!");
});

function checkCategoryBody(categoryBody) {
  return (
    categoryBody.category_title === undefined ||
    categoryBody.channels === undefined ||
    typeof categoryBody.channels !== "object"
  );
}

function checkMatchEventBody(matchEventBody) {
  return (
    matchEventBody.first_team === undefined ||
    matchEventBody.first_team_logo === undefined ||
    matchEventBody.second_team === undefined ||
    matchEventBody.cup_name === undefined ||
    matchEventBody.channel_name === undefined ||
    matchEventBody.channels_quality === undefined ||
    matchEventBody.commenter_name === undefined ||
    matchEventBody.date_of_match_with_time === undefined ||
    matchEventBody.is_playing === undefined
  );
}

function checkDrawerMenuItemBody(drawerMenuItemBody) {
  return (
    drawerMenuItemBody.title === undefined ||
    drawerMenuItemBody.icon === undefined ||
    drawerMenuItemBody.link === undefined
  );
}
