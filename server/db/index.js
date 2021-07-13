const mysql = require('mysql')

const pool = mysql.createPool({
	connectionLimit: 10,
	user: process.env.CMV_DB_USER || 'test',
	password: process.env.CMV_DB_PASSWORD || 'test123',
	database: process.env.CMV_DB_DATABASE || 'cmv_db',
	host: process.env.CMV_DB_HOST || 'localhost',
	port: process.env.CMV_DB_PORT || '3306',
})

const cmvDB = {}

const executeQuery = (queryString, valuesArray = []) => {
		return new Promise((resolve, reject) => pool.query(
			queryString,
			valuesArray,
			(error, result) => error ? reject(error) : resolve(result)
		)
	)
}

cmvDB.getClients = () => executeQuery('CALL USPGetClients()')

cmvDB.getClientAccounts = (valuesArray) => executeQuery('CALL USPGetClientAccounts(?)', valuesArray)

cmvDB.deleteClient = (valuesArray) => executeQuery('CALL USPDeleteClient(?)', valuesArray)

cmvDB.updateClient = (valuesArray) => executeQuery('CALL USPUpdateClient(?, ?, ?, ?, ?, ?)', valuesArray)

module.exports = cmvDB