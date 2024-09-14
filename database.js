// Get the client
const mysql = require("mysql2");

// Create the connection to database
const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "sellness",
});

// A simple SELECT query
connection.query("SELECT * from `messages`", function (err, results, fields) {
  if (err) {
    console.log(err);
    return;
  }
  console.log("results\n", results); // results contains rows returned by server
  console.log("fields\n", fields); // fields contains extra meta data about results, if available
});

// Using placeholders
// connection.query(
//   'SELECT * FROM `table` WHERE `name` = ? AND `age` > ?',
//   ['Page', 45],
//   function (err, results) {
//     console.log(results);
//   }
// );
