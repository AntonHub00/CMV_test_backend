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

router.get('/get-client-accounts/:clientId', async (req, res, _next) => {
	try {
		const result = await db.getClientAccounts([req.params.clientId])
		res.json(result[0])
	} catch (error) {
		console.log(error);
		res.sendStatus(500)
	}
})

router.delete('/delete-client/:clientId', async (req, res, _next) => {
	try {
		const result = await db.deleteClient([req.params.clientId])
		res.json(result[0])
	} catch (error) {
		console.log(error);
		res.sendStatus(500)
	}
})

module.exports = router