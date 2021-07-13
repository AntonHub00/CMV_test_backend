DROP DATABASE IF EXISTS cmv_db;

CREATE DATABASE cmv_db CHARACTER SET utf8 COLLATE utf8_general_ci;

USE cmv_db;

CREATE TABLE Client(
   id INT AUTO_INCREMENT,
   first_name VARCHAR(100) NOT NULL,
   first_last_name VARCHAR(100) NOT NULL,
   second_last_name VARCHAR(100) NOT NULL,
   rfc VARCHAR(13) NOT NULL,
   curp VARCHAR(18) NOT NULL,
   created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (id)
) ENGINE=INNODB;

CREATE TABLE AccountType(
   id INT,
   name VARCHAR(100) NOT NULL,
   PRIMARY KEY (id)
) ENGINE=INNODB;

CREATE TABLE Account(
   id INT AUTO_INCREMENT,
   client_id INT,
   account_type_id INT,
   current_balance DOUBLE DEFAULT 0.0,
   created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
   last_transaction DATETIME DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (id),
   FOREIGN KEY (client_id) REFERENCES Client (id) ON UPDATE CASCADE ON DELETE CASCADE, -- Delete account if client is deleted (business logic).
   FOREIGN KEY (account_type_id) REFERENCES AccountType (id) ON UPDATE CASCADE ON DELETE NO ACTION
) ENGINE=INNODB;