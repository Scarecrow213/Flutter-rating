var fs = require("fs");

const mysql = require("mysql2");
  
const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  database: "studentdb",
  password: "ABCde123"
});

exports.avgStatistic = function(req, res) {
    console.log('>>> Call avgStatistic <<<'); 
    console.log(req.headers);
    console.log(req.body);
    if (!req.header('Authorization')) { 
        res.status(401).send();
        return;
    }
    var token = req.header('Authorization');
    var id = token.split(" ")[1];
    var stat = req.params.stat;
    var subject = req.body.subject;
    var student = req.body.student;
    var startDate = req.body.startDate;
    var endDate = req.body.endDate;

    var data = [id];
    var sql1 = "";
    console.log(`stat=${stat}`);
    if (stat.toUpperCase() == "AVG") sql1 = "SELECT AVG(rate) as stat FROM rating WHERE user_id=?";
    if (stat.toUpperCase() == 'MIN') sql1 = "SELECT MIN(rate) as stat FROM rating WHERE user_id=?";
    if (stat.toUpperCase() == 'MAX') sql1 = "SELECT MAX(rate) as stat FROM rating WHERE user_id=?";

    if(subject) {
        sql1 = sql1 + ` AND subject=?`; 
        data.push(subject);
    };
    if(student) {
        sql1 = sql1 + ` AND student=?`;
        data.push(student);
    };
    if(startDate && endDate) {
        sql1 = sql1 + ` AND date BETWEEN ? AND ?`;
        data.push(startDate);
        data.push(endDate);
    }

    console.log(sql1);

    connection.query(sql1, data, function(err, results) {
        console.log(results);
        if(err) {
            res.status(400).send(err); 
            return;
        }
        res.status(200).send(results[0]);
    });
    
}

