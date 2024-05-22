//* Lưu ý khi thao tác dữ liệu cần chỉnh cache redis


const express = require("express")
const app = express()
require("dotenv").config()


//middleWare
app.use(express.json())


//connect Database
//MongoDB
const ConnectDB = require("../../shared/config/connect_db")
ConnectDB();
// Kết nối redis
const { initRedis } = require("../../shared/config/redis_connect")
initRedis()


//Kết nối RabbitMQ và khởi tạo consumer
const receivedHandleRedis = require("./config/config_service")
receivedHandleRedis()



app.listen(5000, ()=>{
    console.log("Server running on port "+ process.env.PORT );
})



