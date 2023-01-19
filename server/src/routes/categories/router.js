const express = require("express");
const router = express.Router();
const { categoriesCollection } = require("../../MangoDB/db");
const ObjectId = require("mongodb").ObjectId;
const { checkCategoryBody, checkChannelBody } = require("./validation");

router.post("/", async (req, res) => {
  const categoryBody = req.body;
  if (checkCategoryBody(categoryBody)) {
    res.status(400).send({
      status: 400,
      message: "Bad Request",
    });
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

    const insertionResult = await categoriesCollection.insertOne(
      categoryBodyWithIdOnChannel
    );
    res.status(200).send({
      status: 200,
      message: "Category inserted successfully",
      insertedId: insertionResult.insertedId,
      created_at: new Date(),
      channels_length: categoryBody.channels.length,
    });
  } catch (error) {
    console.log(error);
    res.status(500).send({
      status: 500,
      message: "Internal Server Error",
    });
  }
});

router.get("/", async (req, res) => {
  try {
    const categories = await categoriesCollection.find().toArray();
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

router.get("/:id", async (req, res) => {
  try {
    const id = req.params.id;
    console.log(id);
    const category = await categoriesCollection.findOne({
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

router.put("/:id", async (req, res) => {
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
    const updateResult = await categoriesCollection.updateOne(
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

router.delete("/:id", async (req, res) => {
  try {
    const id = req.params.id;
    const deleteResult = await categoriesCollection.deleteOne({
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

router.delete("/", async (req, res) => {
  try {
    const deleteResult = await categoriesCollection.deleteMany({});
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

router.post("/categories/:id/channels", async (req, res) => {
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

    const insertionResult = await categoriesCollection.updateOne(
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

router.delete("/categories/:id/channels/:channelId", async (req, res) => {
  try {
    const id = req.params.id;
    const channelId = req.params.channelId;
    const deleteResult = await categoriesCollection.updateOne(
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

router.put("/:id/channels/:channelId", async (req, res) => {
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

    const updateResult = await categoriesCollection.updateOne(
      { _id: ObjectId(id), "channels._id": ObjectId(channelId) },
      { $set: { "channels.$": { _id: ObjectId(channelId), ...channelBody } } }
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


module.exports = router;
