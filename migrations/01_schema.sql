DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS properties CASCADE;
DROP TABLE IF EXISTS reservations CASCADE;
DROP TABLE IF EXISTS property_reviews CASCADE;

CREATE TABLE users (
  id SERIAL PRIMARY KEY NOT NULL, -- PRIMARY KEY
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE properties (
  id SERIAL PRIMARY KEY NOT NULL, -- PRIMARY KEY
  owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE, -- FOREIGN KEY

  title VARCHAR(255) NOT NULL,
  description TEXT,
  thumbnail_photo_url VARCHAR(255) NOT NULL,
  cover_photo_url VARCHAR(255) NOT NULL,
  cost_per_night INTEGER NOT NULL DEFAULT 0,
  parking_spaces INTEGER NOT NULL DEFAULT 0,
  number_of_bathrooms INTEGER NOT NULL DEFAULT 0,
  number_of_bedrooms INTEGER NOT NULL DEFAULT 0,

  country VARCHAR(255) NOT NULL,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  province VARCHAR(255) NOT NULL,
  post_code VARCHAR(255) NOT NULL,

  active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE reservations (
  id SERIAL PRIMARY KEY NOT NULL, -- PRIMARY KEY
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  property_id INTEGER REFERENCES properties(id) ON DELETE CASCADE, -- FOREIGN KEY,
  guest_id INTEGER REFERENCES users(id) ON DELETE CASCADE -- FOREIGN KEY
);

CREATE TABLE property_reviews (
  id SERIAL PRIMARY KEY NOT NULL, -- PRIMARY KEY
  guest_id INTEGER REFERENCES users(id) ON DELETE CASCADE, -- FOREIGN KEY
  property_id INTEGER REFERENCES properties(id) ON DELETE CASCADE, -- FOREIGN KEY,
  reservation_id INTEGER REFERENCES reservations(id) ON DELETE CASCADE, -- FOREIGN KEY,
  rating SMALLINT NOT NULL DEFAULT 0,
  message TEXT
);
-- make sure you are in the correct directly first and that your psql session is initiated in respective directory
-- \c database_name to connect to database
-- run the file against the database at least once per table,
---- \i migrations/01_schema.sql
-- ensure all tables exist in the database by typing \d at the psql prompt