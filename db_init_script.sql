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

-- Create account types.
INSERT
INTO AccountType(id, name)
VALUES
(1, 'Ahorro'),
(2, 'Inversión');


-- Create testing clients.
INSERT
INTO Client(first_name, first_last_name, second_last_name, rfc, curp, created_at)
VALUES
('Antonio', 'Ochoa', 'Adame', 'AOOrfc123', 'AOOcurp123', '2021-07-01 08:30:22'),
('José', 'Ramírez', 'Salgado', 'JRSrfc123', 'JRScurp123', '2021-07-10 01:45:22'),
('Miguel', 'Pérez', 'Sánchez', 'MPSrfc123', 'MPScurp123', '2002-01-20 23:30:10'),
('Julia', 'Mendoza', 'Alvarado', 'JMArfc123', 'JMAcurp123', '2019-10-14 08:12:44');


-- Create testing accounts.
INSERT
INTO Account(client_id, account_type_id, current_balance)
VALUES
(1, 1, 10800.54),
(1, 2, 300123.12),
(2, 1, 421.54),
(3, 2, 123123.54);

-- Store procedures @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

DELIMITER $$
CREATE PROCEDURE USPGetClients()
BEGIN
	SELECT * FROM Client;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE USPGetClientAccounts(IN param_client_id INT)
BEGIN
	SELECT * FROM Account WHERE client_id = param_client_id;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE USPDeleteClient(IN param_client_id INT)
BEGIN
	DELETE FROM Client WHERE id = param_client_id;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE USPUpdateClient(
	IN param_client_id INT,
	IN param_first_name VARCHAR(100),
	IN param_first_last_name VARCHAR(100),
	IN param_second_last_name VARCHAR(100),
	IN param_rfc VARCHAR(13),
	IN param_curp VARCHAR(18)
)
USPUC: BEGIN
	-- Define local variables that are going to be use to update the client data.
	DECLARE local_client_id INT DEFAULT -1;
	DECLARE local_first_name VARCHAR(100);
	DECLARE local_first_last_name VARCHAR(100);
	DECLARE local_second_last_name VARCHAR(100);
	DECLARE local_rfc VARCHAR(13);
	DECLARE local_curp VARCHAR(18);

	-- Set all the local variables with the current client data.
	SELECT
		id,
		first_name,
		first_last_name,
		second_last_name,
		rfc,
		curp
	INTO
		local_client_id,
		local_first_name,
		local_first_last_name,
		local_second_last_name,
		local_rfc,
		local_curp
	FROM Client WHERE id = param_client_id;

	-- Do nothing if the client doesn't exist.
	IF (local_client_id = -1) THEN
		LEAVE USPUC;
	END IF;

	-- If the given parameters are not empty strings, then update the local
	-- variables with the given data.
	IF (param_first_name != '') THEN SET local_first_name = param_first_name; END IF;
	IF (param_first_last_name != '') THEN SET local_first_last_name = param_first_last_name; END IF;
	IF (param_second_last_name != '') THEN SET local_second_last_name = param_second_last_name; END IF;
	IF (param_rfc != '') THEN SET local_rfc = param_rfc; END IF;
	IF (param_curp != '') THEN SET local_curp = param_curp; END IF;

	-- Update the client with the local variables.
	UPDATE
		Client
	SET
		first_name = local_first_name,
		first_last_name = local_first_last_name,
		second_last_name = local_second_last_name,
		rfc = local_rfc,
		curp = local_curp
	WHERE id = param_client_id;
END$$
DELIMITER ;