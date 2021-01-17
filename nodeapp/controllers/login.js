var fs = require("fs");

const mysql = require("mysql2");
  
const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  database: "studentdb",
  password: "ABCde123"
});


exports.login1 = function(req, res) {
    console.log('>>> Call login1 <<<'); 
    console.log(req.body); 
    var userLogin = req.body.email;
    var userPassword = req.body.password;

    const sql = `SELECT id FROM users WHERE login=? AND password=?`;
    const filter = [userLogin, userPassword];
    connection.query(sql, filter, function(error, result) {
        if(error || result.length == 0) {
            var err =  JSON.parse('{"error":"Some error"}');
            res.status(401).send(err);
            return;
        }
        var num = result[0].id;
        res.status(200).send('{"token":'+num+'}');
    });
}

exports.register1 = function(req, res) {
    console.log('>>> Call register1 <<<'); 
    console.log(req.body); 
    if(!req.body) return res.sendStatus(400);
    var userName = req.body.name;
    var userLogin = req.body.email;
    var userPassword = req.body.password;

    const sql = `SELECT id FROM users WHERE login=?`;
    const filter = [userLogin];
    connection.query(sql, filter, function(error, result) {
        if (result.length == 0)
        {
            var usr = [[userLogin, userPassword, userName]];
            console.log(usr);
            const sql2 = `INSERT INTO users(login, password, name) VALUES ?`;
 
            connection.query(sql2, [usr], function(error, results) {
                if(error) res.status(401).send(error);
                    console.log(results);
                    const sql = `SELECT id FROM users WHERE login=? AND password=?`;
                    const filter = [userLogin, userPassword];
                    connection.query(sql, filter, function(error, result) {
                        if(error || result.length == 0) {
                            var err =  JSON.parse('{"Error":"Error"}');
                            res.status(401).send(err);
                            return;
                        }
                        var num = result[0].id;
                        res.status(200).send('{"token":'+num+'}');
                    });
            });
        }

        else
        {
            var error =  JSON.parse('{"Error":"Error"}');
            res.status(401).send(error);
            return;
        }
    });
}