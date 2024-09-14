-- Create the database
DROP DATABASE IF EXISTS sellness;

CREATE DATABASE IF NOT EXISTS sellness;
USE sellness;

-- Create the Threads table
CREATE TABLE IF NOT EXISTS Threads (
    userId VARCHAR(50) NOT NULL,
    id VARCHAR(50) PRIMARY KEY,
    -- id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    threadType VARCHAR(50) NOT NULL,
    lastQuestion TEXT NOT NULL,
    lastResponse TEXT NOT NULL
);

-- Create the Messages table
CREATE TABLE IF NOT EXISTS Messages (
    threadId VARCHAR(50),
    id VARCHAR(50) PRIMARY KEY,
    -- id INT AUTO_INCREMENT PRIMARY KEY,
    -- id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    content TEXT NOT NULL,
    sender VARCHAR(50) NOT NULL,
    FOREIGN KEY (threadId) REFERENCES Threads(id) ON DELETE CASCADE
);


-- {
--     "userId": "evan-2301",
--     "id": "thread-id-146",
--     "createdAt": "Sep 3, 2024 6:30 PM",
--     "updatedAt": "Sep 3, 2024 6:50 PM",
--     "threadType": "Finance",
--     "lastQuestion": "How to Budget",
--     "lastResponse": "You can use YNAB to budget your expenses..."
--   },
-- Insert sample data into Threads table
INSERT INTO Threads (userId, id, createdAt, updatedAt, threadType, lastQuestion, lastResponse)
VALUES
('evan-1', 'thread-id-1', '2024-08-01 18:30:00', '2024-08-01 21:30:00', 'Habit', 'Productivity and wellness more text here.', 'Keep track of your daily habits in the app.');
INSERT INTO Threads (userId, id, createdAt, updatedAt, threadType, lastQuestion, lastResponse)
VALUES
('dave-3298', 'thread-id-2', '2024-08-02 18:30:00', '2024-08-02 21:30:00', 'Habit', "Dave\'s Productivity and wellness", 'Keep track of Daves daily habits in the app...');
INSERT INTO Threads (userId, id, createdAt, updatedAt, threadType, lastQuestion, lastResponse)
VALUES
('dave-3298', 'thread-id-3', '2024-08-03 18:30:00', '2024-08-03 21:30:00', 'Finance', 'Save Daves Money', 'Keep track of Daves budget in the app.');
INSERT INTO Threads (userId, id, createdAt, updatedAt, threadType, lastQuestion, lastResponse)
VALUES
('evan-1', 'thread-id-4', '2024-08-04 18:30:00', '2024-08-04 21:30:00', 'Health', 'Stay healthy', 'Track your health by doing all the good things for health.');
INSERT INTO Threads (userId, id, createdAt, updatedAt, threadType, lastQuestion, lastResponse)
VALUES
('evan-1', 'thread-id-5', '2024-08-05 18:30:00', '2024-08-05 21:30:00', 'Finance', 'Budget and Savings', 'Track you finances by doing x y and z.');
INSERT INTO Threads (userId, id, createdAt, updatedAt, threadType, lastQuestion, lastResponse)
VALUES
('evan-1', 'thread-id-6', '2024-08-05 18:30:00', '2024-08-05 21:30:00', 'Fitness', 'Get fit', 'Track you fitness.');
INSERT INTO Threads (userId, id, createdAt, updatedAt, threadType, lastQuestion, lastResponse)
VALUES
('evan-1', 'thread-id-7', '2024-08-05 18:30:00', '2024-08-05 21:30:00', 'Relationship', 'Overall improvement', 'Get better at scheduling.');
INSERT INTO Threads (userId, id, createdAt, updatedAt, threadType, lastQuestion, lastResponse)
VALUES
('evan-1', 'thread-id-8', '2024-08-05 18:30:00', '2024-09-09 21:30:00', 'Sales', 'How to Sell', 'How to pitch.');

-- Insert sample data into Messages table

-- {
--     "threadId": "thread-id-146",
--     "id": "message-id-293418",
--     "createdAt": "Sep 3, 2024 7:30 PM",
--     "content": "This is the 2nd message from the Finance thread",
--     "sender": "bot" | 'user'
--   },

-- Thread 1 Messages (Evan)
INSERT INTO Messages (threadId, id, createdAt, content, sender)
VALUES
('thread-id-1', 'message-id-001', '2024-09-03 19:30:00', 'This is the 1st message in the Habit thread for Evan', 'user');
INSERT INTO Messages (threadId, id, createdAt, content, sender)
VALUES
('thread-id-1', 'message-id-002', '2024-09-03 20:32:00', 'This is the 3rd message in the Habit thread for Evan', 'bot');
INSERT INTO Messages (threadId, id, createdAt, content, sender)
VALUES
('thread-id-1', 'message-id-003', '2024-09-03 20:30:00', 'This is the 2nd message in the Habit thread for Evan', 'bot');
-- Thread 2 Messages (Dave)
INSERT INTO Messages (threadId, id, createdAt, content, sender)
VALUES
('thread-id-2', 'message-id-004', '2024-09-03 13:30:00', 'This is the 1st message in the Habit thread for Dave', 'bot');
-- Thread 3 Messages (Dave)
INSERT INTO Messages (threadId, id, createdAt, content, sender)
VALUES
('thread-id-3', 'message-id-005', '2024-09-03 13:30:00', 'This is the 1st message in the Finance thread for Dave', 'user');
-- Thread 4 Messages (Evan)
INSERT INTO Messages (threadId, id, createdAt, content, sender)
VALUES
('thread-id-4', 'message-id-006', '2024-09-03 11:30:00', 'This is the 1st message in the Health thread for Evan', 'user');
INSERT INTO Messages (threadId, id, createdAt, content, sender)
VALUES
('thread-id-4', 'message-id-007', '2024-09-03 12:30:00', 'This is the 2nd BOT message in the Health thread for Evan', 'bot');
INSERT INTO Messages (threadId, id, createdAt, content, sender)
VALUES
('thread-id-4', 'message-id-008', '2024-09-03 16:30:00', 'This is the 4th message in the Health thread for Evan', 'user');
INSERT INTO Messages (threadId, id, createdAt, content, sender)
VALUES
('thread-id-4', 'message-id-009', '2024-09-03 13:30:00', 'This is the 3rd message in the Health thread for Evan', 'user');
-- Thread 5 Messages (Evan)
INSERT INTO Messages (threadId, id, createdAt, content, sender)
VALUES
('thread-id-5', 'message-id-014', '2024-09-03 18:30:00', 'This is the 5th message in the Finance thread for Evan', 'bot');
INSERT INTO Messages (threadId, id, createdAt, content, sender)
VALUES
('thread-id-5', 'message-id-012', '2024-09-03 13:30:00', 'This is the 3rd message in the Finance thread for Evan', 'bot');
INSERT INTO Messages (threadId, id, createdAt, content, sender)
VALUES
('thread-id-5', 'message-id-013', '2024-09-03 16:30:00', 'This is the 4th message in the Finance thread for Evan', 'user');
INSERT INTO Messages (threadId, id, createdAt, content, sender)
VALUES
('thread-id-5', 'message-id-011', '2024-09-03 12:30:00', 'This is the 2nd message in the Finance thread for Evan', 'user');
INSERT INTO Messages (threadId, id, createdAt, content, sender)
VALUES
('thread-id-5', 'message-id-010', '2024-09-03 11:30:00', 'This is the 1st message in the Finance thread for Evan', 'user');
