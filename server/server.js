const express = require('express')
const apiRouter = require('./routes')

const app = express()

app.use(express.json())
app.use('/cmv/api/', apiRouter)

const PORT = process.env.CMV_DB_PORT || 3000

app.listen(PORT, () => {
	console.log(`Server running on ${PORT}`)
})