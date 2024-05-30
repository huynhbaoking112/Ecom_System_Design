const express = require("express")
const app = express()
require("dotenv").config()




//middelWare
app.use(express.json())

//connect and create channel RabbitMQ 


//connect Database
const ConnectDB = require("../../shared/config/connect_db")
ConnectDB()


// //Router
const CartRouter = require("./routes/cart_router")

// //Use Router
app.use("/api",CartRouter)


//Xử lí lỗi toàn cục
const errorGlobal = require("../../shared/middlewares/error_global")
app.use(errorGlobal)





app.listen(process.env.PORT, ()=>{
    console.log("Cart service running on: "+ process.env.PORT);
})