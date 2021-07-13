const express = require('express')
const router = express.Router()
const db = require('../db')

router.get('/get-clients', async (_req, res, _next) => {
	try {
		const result = await db.getClients()
		res.json(result[0])
	} catch (error) {
		console.log(error);
		res.sendStatus(500)
	}
})

module.exports = router