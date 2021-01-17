var fs = require("fs");

const mysql = require("mysql2");
  
const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  database: "studentdb",
  password: "ABCde123"
});


exports.createRating = function(req, res) {
    console.log('>>> Call createRating <<<');
    console.log(req.headers); 
    console.log(req.body); 
    if (!req.header('Authorization')) { 
        res.status(401).send();
        return;
    }
    var token = req.header('Authorization');
    var id = token.split(" ")[1];

    var ratingSubject = req.body.subject;
    var ratingRate = req.body.rating;
    var ratingStudent = req.body.student;
    var ratingDate = req.body.date;

    console.log(req.body.subject);

    var rating = [[ratingSubject, ratingRate, id, ratingStudent, ratingDate]];
    console.log(rating);
    const sql2 = `INSERT INTO rating(subject, rate, user_id, student, date) VALUES ?`;
    connection.query(sql2, [rating], function(error, results) {
        if(err) res.status(400).send(err);
            console.log(results);
            return;
        });
}



exports.deleteRating = function(req, res) { 
    console.log('>>> Call deleteRating <<<'); 
    console.log(req.headers); 
    console.log(req.params); 
    if (!req.header('Authorization')) { 
        res.status(401).send();
        return;
    }
    var id = req.params.id;
    const sql = "DELETE FROM rating WHERE id=?";
    const data = [id];

    connection.query(sql, [data], function(error, results) {
        if(err) res.status(400).send(err);
            console.log(results);
            return;
    });        
}



exports.getRating = function(req, res) {
    console.log('>>> Call getRaiting <<<'); 
    console.log(req.headers);
    if (!req.header('Authorization')) { 
        res.status(401).send();
        return;
    }
    var token = req.header('Authorization');
    var id = token.split(" ")[1];
    
    const sql = `SELECT * FROM rating WHERE user_id=?`;
    const filter = [id];
    connection.query(sql, filter, function(err, results) {
        if(err) res.status(400).send(err);
        res.status(200).send(results);
    });
}



exports.updateRating = function(req, res) { 
    console.log('>>> Call updateRating <<<'); 
    console.log(req.headers); 
    console.log(req.params); 
    if (!req.header('Authorization')) { 
        res.status(401).send();
        return;
    }
    var token = req.header('Authorization');
    var userId = token.split(" ")[1];
    var id = req.params.id;
    var ratingSubject = req.body.subject;
    var ratingRate = req.body.rating;
    var ratingStudent = req.body.student;
    var ratingDate = req.body.date;
 
    const sql = "UPDATE rating SET subject=? , rate=? , student=? , date=? WHERE id=?";
    const data = [ratingSubject, ratingRate, ratingStudent, ratingDate, id];
    connection.query(sql, [data], function(error, results) {
        if(error) console.log(error);
                    console.log(results);
    });        
}


/*exports.listRatings = function(req, res) {
    
}*/
 
