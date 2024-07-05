const express = require("express")
const app = express()
require("dotenv").config()


//middelWare
app.use(express.json())


//connect and create channel RabbitMQ 
const { createConnect } = require("../../shared/config/create_exchange_channel")
createConnect({exchangeName:'topic_update_ratings',exchangeType:'topic'},{exchangeName:"error_log", exchangeType:"fanout"})

//connect Database
const ConnectDB = require("../../shared/config/connect_db")
ConnectDB()


//Router
const ratingRouter = require("./routes/ratings_router")

//Use Router
app.use("/api",ratingRouter)




//Xử lí lỗi toàn cục
const errorGlobal = require("../../shared/middlewares/error_global")
app.use(errorGlobal)

app.listen(process.env.PORT, () => {
    console.log("Product Service running on port "+ process.env.PORT)
})