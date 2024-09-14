const mysql = require("mysql2");

// Create a connection object
const db = mysql.createConnection({
  host: "127.0.0.1",
  // user: "accessapi",
  // password: "pw",
  user: "root",
  password: "",
  database: "sellness",
});

module.exports = { db };

// Connect to the database
// connection.connect((err) => {
//   if (err) {
//     console.error("Error connecting to the database:", err.stack);
//     return;
//   }
//   console.log("Connected to the database as id " + connection.threadId);
// });

// Example query
// connection.query("SELECT * FROM Threads", (err, results, fields) => {
//   if (err) throw err;
//   console.log(results);
// });

// Close the connection
// connection.end();
