-- Allow root to connect from any host
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;
FLUSH PRIVILEGES;

-- Create a new database

CREATE DATABASE IF NOT EXISTS my_database;

-- Switch to the new database

USE my_database;

-- Create a new table
CREATE TABLE users (

   id INT AUTO_INCREMENT PRIMARY KEY,

   name VARCHAR(100) NOT NULL,

   email VARCHAR(100) NOT NULL UNIQUE,

   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

-- Insert some sample data into the table

INSERT INTO users (name, email) VALUES

('Alice Smith', 'alice@example.com'),

('Bob Johnson', 'bob@example.com'),

('Charlie Brown', 'charlie@example.com');	
