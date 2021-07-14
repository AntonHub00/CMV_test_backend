const express = require('express')
const apiRouter = require('./routes')

const app = express()

app.use(express.json())

app.use((req, res, next) => {
    res.append('Access-Control-Allow-Origin', ['*'])
    res.append('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE')
    res.append('Access-Control-Allow-Headers', 'Content-Type')
    next()
})

app.use('/cmv/api/', apiRouter)

const PORT = process.env.CMV_DB_PORT || 3000

app.listen(PORT, () => {
	console.log(`Server running on ${PORT}`)
})