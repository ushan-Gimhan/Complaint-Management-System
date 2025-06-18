CREATE DATABASE complaint_db;

use complaint_db;

CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       name VARCHAR(100) NOT NULL,
                       email VARCHAR(100) UNIQUE NOT NULL,
                       password VARCHAR(30),
                       role VARCHAR(50)
);

CREATE TABLE complaints (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            userID INT NOT NULL,
                            date DATE DEFAULT CURRENT_DATE,
                            subject VARCHAR(255) NOT NULL,
                            description VARCHAR(100) NOT NULL,
                            status VARCHAR(50) DEFAULT 'Pending',
                            remark VARCHAR(255),
                            FOREIGN KEY (userID) REFERENCES users(id) ON DELETE CASCADE
);
