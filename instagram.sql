CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    caption TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE likes (
    id SERIAL PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE (post_id, user_id) -- prevents duplicate likes
);

INSERT INTO users (username, email)
VALUES
('alex', 'alex@gmail.com'),
('maria', 'maria@gmail.com'),
('john', 'john@gmail.com'),
('sophia', 'sophia@gmail.com');

INSERT INTO posts (user_id, caption)
VALUES
(1, 'Morning vibes ☀️'),
(1, 'Coffee first ☕'),
(2, 'Travel diaries ✈️'),
(3, 'Workout time 💪');

INSERT INTO likes (post_id, user_id)
VALUES
(1, 2), -- maria likes alex's post
(1, 3), -- john likes alex's post
(2, 2), -- maria likes alex's second post
(3, 1), -- alex likes maria's post
(3, 3), -- john likes maria's post
(4, 1); -- alex likes john's post

SELECT * FROM users;
SELECT * FROM posts;
SELECT * FROM likes;

SELECT users.username, COUNT(likes.id) AS total_likes
FROM users
JOIN posts ON users.id = posts.user_id
JOIN likes ON posts.id = likes.post_id
GROUP BY users.username;

