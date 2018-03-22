DROP TABLE castings;
DROP TABLE stars;
DROP TABLE movies;

CREATE TABLE stars (
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE movies (
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(255),
  genre VARCHAR(255),
  rating INT
);

CREATE TABLE castings (
  id SERIAL8 PRIMARY KEY,
  movie_id INT8 REFERENCES movies(id) ON DELETE CASCADE,
  star_id INT8 REFERENCES stars(id) ON DELETE CASCADE,
  fee FLOAT(24)
);
