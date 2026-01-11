CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    genre_id INT,
    release_year INT,
    duration INT, -- minutes
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    genre_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE ratings (
    id SERIAL PRIMARY KEY,
    movie_id INT NOT NULL,
    user_id INT NOT NULL,
    rating NUMERIC(2,1) CHECK (rating BETWEEN 1 AND 5),
    rated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    UNIQUE (movie_id, user_id)
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO genres (genre_name) VALUES
('Action'),
('Drama'),
('Comedy'),
('Sci-Fi');

INSERT INTO users (username) VALUES
('alex'),
('maria'),
('john'),
('sophia');

INSERT INTO movies (title, genre_id, release_year, duration) VALUES
('Fast Run', 1, 2022, 120),
('Broken Dreams', 2, 2021, 140),
('Laugh Out', 3, 2020, 95),
('Future World', 4, 2023, 130);

INSERT INTO ratings (movie_id, user_id, rating) VALUES
(1, 1, 4.5),
(1, 2, 4.0),
(2, 2, 3.5),
(2, 3, 4.2),
(3, 1, 3.8),
(4, 4, 4.7),
(4, 1, 4.9);

SELECT g.genre_name AS genre,
       ROUND(AVG(r.rating), 2) AS avg_rating
FROM genres g
JOIN movies m ON g.id = m.genre_id
JOIN ratings r ON m.id = r.movie_id
GROUP BY g.genre_name;

SELECT title, release_year
FROM movies
WHERE release_year >= 2022;

SELECT title
FROM movies
WHERE id IN (
    SELECT movie_id
    FROM ratings
    GROUP BY movie_id
    HAVING AVG(rating) > 4.5
);
