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

cmvDB.getClients = () => {
	return new Promise((resolve, reject) => {
		pool.query('CALL USPGetClients()', (error, result) => {
			if (error) return reject(error)

			return resolve(result)
		})
	})
}

module.exports = cmvDB