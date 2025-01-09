CREATE DATABASE social_media_db;
USE social_media_db;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT,
    post_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id));

CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    comment_text TEXT,
    comment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id));

CREATE TABLE likes (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    like_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id));

CREATE TABLE hashtags (
    hashtag_id INT AUTO_INCREMENT PRIMARY KEY,
    hashtag VARCHAR(50) UNIQUE NOT NULL);

CREATE TABLE post_hashtags (
    post_id INT,
    hashtag_id INT,
    PRIMARY KEY (post_id, hashtag_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (hashtag_id) REFERENCES hashtags(hashtag_id));
-- Users
INSERT INTO users (username, email) VALUES 
('alice', 'alice@example.com'), 
('bob', 'bob@example.com'), 
('carol', 'carol@example.com'),
('david', 'david@example.com'),
('eva', 'eva@example.com'),
('frank', 'frank@example.com'),
('grace', 'grace@example.com'),
('henry', 'henry@example.com'),
('ivy', 'ivy@example.com'),
('jack', 'jack@example.com');

-- posts 
INSERT INTO posts (user_id, content) VALUES 
(1, 'Exploring the city! #travel'), 
(2, 'Just finished reading a great book. #reading'), 
(3, 'Learning SQL! #coding'),
(4, 'New recipe tried today! #cooking'),
(5, 'Mountain trekking adventure #nature'),
(6, 'Attended a tech meetup #networking'),
(7, 'Photographed the sunset #photography'),
(8, 'Practicing yoga daily #wellness'),
(9, 'Coding a new project #development'),
(10, 'Visited the museum #art');

-- Comments
INSERT INTO comments (post_id, user_id, comment_text) VALUES 
(1, 2, 'Looks amazing!'), 
(1, 3, 'Where is this?'), 
(2, 1, 'What book did you read?'),
(3, 4, 'SQL is fun!'),
(4, 5, 'Sounds delicious!'),
(5, 6, 'That looks challenging!'),
(6, 7, 'I was there too!'),
(7, 8, 'Beautiful shot!'),
(8, 9, 'Yoga is transformative!'),
(9, 10, 'What project are you working on?');

-- Likes
INSERT INTO likes (post_id, user_id) VALUES 
(1, 2), 
(1, 3), 
(2, 1), 
(3, 2),
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(8, 9),
(9, 10);

-- Hashtags
INSERT INTO hashtags (hashtag) VALUES 
('#travel'), 
('#reading'), 
('#coding'),
('#cooking'),
('#nature'),
('#networking'),
('#photography'),
('#wellness'),
('#development'),
('#art');

-- Post Hashtags
INSERT INTO post_hashtags (post_id, hashtag_id) VALUES 
(1, 10), 
(2, 9), 
(3, 8),
(4, 7),
(5, 6),
(6, 5),
(7, 4),
(8, 3),
(9, 2),
(10, 1);

SELECT * FROM users;
SELECT * FROM posts;
SELECT * FROM users WHERE username LIKE 'j%';
SELECT * FROM posts WHERE content LIKE '%Hello%';

-- Basic Data Retrieval
-- Retrieve All Posts by a User
SELECT p.post_id, p.content, p.post_date
FROM posts p
JOIN users u ON p.user_id = u.user_id
WHERE u.username = 'alice';
-- List All Comments on a Post:
SELECT c.comment_text, u.username, c.comment_date
FROM comments c
JOIN users u ON c.user_id = u.user_id
WHERE c.post_id = 1;
-- Top Hashtags Used in Posts:
SELECT h.hashtag, COUNT(ph.post_id) AS usage_count
FROM hashtags h
JOIN post_hashtags ph ON h.hashtag_id = ph.hashtag_id
GROUP BY h.hashtag
ORDER BY usage_count DESC;

-- User Engagement Analysis
-- Total Likes on a Post:
SELECT p.post_id, COUNT(l.like_id) AS total_likes
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
WHERE p.post_id = 1
GROUP BY p.post_id;

-- Most Active Users (by Number of Posts):
SELECT u.username, COUNT(p.post_id) AS post_count
FROM users u
JOIN posts p ON u.user_id = p.user_id
GROUP BY u.user_id
ORDER BY post_count DESC
LIMIT 5;

-- Identify Posts with No Comments:
SELECT p.post_id, p.content
FROM posts p
LEFT JOIN comments c ON p.post_id = c.post_id
WHERE c.comment_id IS NULL;

-- Popular Posts by Engagement (Likes + Comments):
SELECT p.post_id, p.content, 
       (COUNT(l.like_id) + COUNT(c.comment_id)) AS engagement_score
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
LEFT JOIN comments c ON p.post_id = c.post_id
GROUP BY p.post_id
ORDER BY engagement_score DESC
LIMIT 5;

-- Date-Based Analysis
-- Posts in a Specific Date Range:
SELECT post_id, content, post_date
FROM posts
WHERE post_date BETWEEN '2024-11-01' AND '2024-11-07';

-- Top Liked Posts in the Last 30 Days:
SELECT p.post_id, p.content, COUNT(l.like_id) AS total_likes
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
WHERE l.like_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY p.post_id
ORDER BY total_likes DESC;

-- Users Who Joined in the Past Year:
SELECT username, email, join_date
FROM users
WHERE join_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- Advanced Analysis
-- User Engagement Score (Posts + Comments + Likes):
SELECT u.username, 
       (COUNT(p.post_id) + COUNT(c.comment_id) + COUNT(l.like_id)) AS engagement_score
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
LEFT JOIN comments c ON u.user_id = c.user_id
LEFT JOIN likes l ON u.user_id = l.user_id
GROUP BY u.user_id
ORDER BY engagement_score DESC;

-- Find Most Commented Hashtags:
SELECT h.hashtag, COUNT(c.comment_id) AS total_comments
FROM hashtags h
JOIN post_hashtags ph ON h.hashtag_id = ph.hashtag_id
JOIN comments c ON ph.post_id = c.post_id
GROUP BY h.hashtag
ORDER BY total_comments DESC;
 
-- Top Hashtags Used by a Specific User:
SELECT h.hashtag, COUNT(ph.post_id) AS hashtag_usage
FROM posts p
JOIN post_hashtags ph ON p.post_id = ph.post_id
JOIN hashtags h ON ph.hashtag_id = h.hashtag_id
WHERE p.user_id = 1  -- Replace with specific user ID
GROUP BY h.hashtag
ORDER BY hashtag_usage DESC;

SELECT username, (SELECT COUNT(*) FROM posts WHERE user_id = u.user_id) AS post_count
FROM users u;
SELECT * FROM users WHERE user_id IN (SELECT user_id FROM posts WHERE post_date > '2024-01-01');


CREATE USER 'social_media_user'@'localhost' IDENTIFIED BY 'Complex@Password1';
GRANT ALL PRIVILEGES ON social_media_db.* TO 'social_media_user'@'localhost';
REVOKE INSERT ON social_media_db.* FROM 'social_media_user'@'localhost';
SELECT * FROM users WHERE email REGEXP '^[a-zA-Z0-9._%+-]+@example.com$';






