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

router.put('/update-client', async (req, res, _next) => {
	try {
		const payload = [
			req.body.clientId,
			req.body.firstName,
			req.body.firstLastName,
			req.body.secondLastName,
			req.body.rfc,
			req.body.curp,
		]

		const result = await db.updateClient(payload)
		res.json(result[0])
	} catch (error) {
		console.log(error);
		res.sendStatus(500)
	}
})

module.exports = router