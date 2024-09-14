const express = require("express");
const axios = require("axios");
const cors = require("cors");

require("dotenv").config();

const { db } = require("./db");

const app = express();

const corsOptions = {
  origin: "*", // Allow only requests from this origin
  methods: "GET,POST,PUT,DELETE", // Allow only these HTTP methods
  allowedHeaders: "Content-Type,Authorization", // Allow only these headers
  credentials: true, // Allow cookies to be sent with requests
};

// Middleware to parse JSON bodies
app.use(express.json());
app.use(cors(corsOptions));

// Replace this with your actual OpenAI API key
const OPENAI_API_KEY = process.env.OPENAI_API_KEY;

// Post a new message to Messages table
app.post("/update-thread", async (req, res) => {
  const { threadId, prompt, reply } = req.body;
  // console.log("ThreadId: ", threadId);
  // console.log("Reply: ", reply);
  // console.log("Reply: ", reply);

  const gptRes = await axios("http://localhost:4003/chat", {
    method: "POST",
    data: {
      message: `I have a prompt from a user, but I want to summarize it in 5 words or fewer
      to indicate the subject of the prompt. The summary doesn't need to be a proper sentence. Just make sure it prioritizes the nouns in the prompt. Please do so with this prompt:\n
      ${prompt}`,
    },
    //   message: `In less than 5 words, summarize the following prompt in the following format:\n
    //   Prompt: ${prompt}\n
    //   Format: WordA and WordB`,
    // },
  });

  console.log("Summarized body: ", gptRes.data.reply);
  const sqlQ = `UPDATE Threads SET lastQuestion = ?, lastResponse = ? WHERE id = "${threadId}"`;

  db.query(
    sqlQ,
    [gptRes.data.reply, reply.slice(0, 150)],
    (err, results, fields) => {
      if (err) {
        console.error("Error posting message to db:\n", err);
        res.status(500).json({ error: err });
      } else {
        // console.log(results);
        res.json({ status: "Successful db message post", results });
      }
      // console.log(results);
    }
  );
});

app.post("/add-message", async (req, res) => {
  const newMessage = req.body;
  // console.log("New Message: ", newMessage);

  const sqlQ = `INSERT INTO Messages (threadId, id, content, sender)
  VALUES
  ("${newMessage.threadId}", "${newMessage.id}", ?, "${newMessage.sender}")`;

  // console.log("Adding message:\n", sqlQ);

  db.query(sqlQ, [newMessage.content], (err, results, fields) => {
    if (err) {
      console.error("Error posting message to db:\n", err);
      res.status(500).json({ error: err });
    } else {
      // console.log(results);
      res.json({ status: "Successful db message post", results });
    }
    // console.log(results);
  });
});

// get messages by threadID
app.post("/messages", async (req, res) => {
  const { threadId } = req.body;
  // console.log("Pinged /messages for threadId: ", threadId);

  db.query(
    `SELECT * FROM Messages WHERE threadId = "${threadId}"`,
    (err, results, fields) => {
      if (err) {
        res.status(500).json({ error: err });
      } else {
        res.json(results);
      }
    }
  );
  ////////////////////
  // if (!message) {
  //   return res.status(400).json({ error: "Message is required" });
  // }
});

// get threadID by userID
app.post("/threads/:threadId", async (req, res) => {
  const { userId } = req.body;
  // console.log("Pinged /threads for userId: ", userId);

  const byThreadIdString =
    req.params.threadId != "all" ? ` AND id = "${req.params.threadId}"` : "";

  const sqlQ = `SELECT * FROM Threads WHERE userId = "${userId}"${byThreadIdString}`;
  // console.log("sqlQ (threads)\n", sqlQ);

  db.query(sqlQ, (err, results, fields) => {
    if (err) {
      res.status(500).json({ error: err });
    }
    // console.log("Threads response: \n", results);
    res.json(results);
  });
  ////////////////////
  // if (!message) {
  //   return res.status(400).json({ error: "Message is required" });
  // }
});

app.post("/chat", async (req, res) => {
  const { message } = req.body;
  // console.log("Message: ", message);

  if (!message) {
    return res.status(400).json({ error: "Message is required" });
  }

  try {
    const response = await axios.post(
      "https://api.openai.com/v1/chat/completions",
      {
        model: "gpt-3.5-turbo", // Or use 'gpt-4' if available
        messages: [{ role: "user", content: message }],
      },
      {
        headers: {
          Authorization: `Bearer ${OPENAI_API_KEY}`,
          "Content-Type": "application/json",
        },
      }
    );

    const chatResponse = response.data.choices[0].message.content;
    res.json({ reply: chatResponse });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to get response from ChatGPT" });
  }
});

app.listen(process.env.PORT ?? 4000, () => {
  console.log(`Server running at http://localhost:${process.env.PORT ?? 4000}`);
});
