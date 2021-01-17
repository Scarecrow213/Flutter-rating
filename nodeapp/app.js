var express = require("express");
var bodyParser = require("body-parser");
var fs = require("fs");


const flutterController = require("./controllers/login.js");
const crudController = require("./controllers/crud.js");
const statController = require("./controllers/statistic.js");

var app = express();
var jsonParser = bodyParser.json();

app.use(express.static(__dirname + "/public"));
app.use(jsonParser);

// получение списка данных (users API)
app.post("/login1", flutterController.login1);
app.post("/register1", flutterController.register1);

// Raitings API
app.post("/rating", crudController.createRating);
app.delete("/rating/:id", crudController.deleteRating);
app.get("/rating", crudController.getRating);
app.put("/rating/:id", crudController.updateRating);

app.post("/statistics/:stat", statController.avgStatistic);

app.get("/ratings", crudController.listRatings);

app.listen(3000, function(){
    console.log("Сервер ожидает подключения на 3000 порту...");
});