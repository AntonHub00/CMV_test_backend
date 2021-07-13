DROP DATABASE IF EXISTS cmv_db;

-- Database definition @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

CREATE DATABASE cmv_db CHARACTER SET utf8 COLLATE utf8_general_ci;

USE cmv_db;

-- Tables definition @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

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

-- Init data @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

-- Create account types
INSERT
INTO AccountType(id, name)
VALUES
(1, 'Ahorro'),
(2, 'Inversión');


-- Create testing clients
INSERT
INTO Client(first_name, first_last_name, second_last_name, rfc, curp, created_at)
VALUES
('Antonio', 'Ochoa', 'Adame', 'AOOrfc123', 'AOOcurp123', '2021-07-01 08:30:22'),
('José', 'Ramírez', 'Salgado', 'JRSrfc123', 'JRScurp123', '2021-07-10 01:45:22'),
('Miguel', 'Pérez', 'Sánchez', 'MPSrfc123', 'MPScurp123', '2002-01-20 23:30:10'),
('Julia', 'Mendoza', 'Alvarado', 'JMArfc123', 'JMAcurp123', '2019-10-14 08:12:44');


-- Create testing accounts
INSERT
INTO Account(client_id, account_type_id, current_balance)
VALUES
(1, 1, 10800.54),
(1, 2, 300123.12),
(2, 1, 421.54),
(3, 2, 123123.54);
