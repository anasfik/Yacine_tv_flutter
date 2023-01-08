const express = require("express");
const app = express();
const { MongoClient, ObjectId } = require("mongodb");
const client = new MongoClient(
  "mongodb+srv://gwhyyy:gwhyyy@cluster0.ktg0sfb.mongodb.net/?retryWrites=true&w=majority"
);
const CategoriesCollection = client.db("main_db").collection("categories");
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
