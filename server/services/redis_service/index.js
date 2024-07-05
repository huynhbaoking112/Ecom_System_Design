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
receivedHandleRedis({exchangeName:'topic_update_datas', exchangeType:'topic', bindingKey: "update.#"})
const { createConnect } = require("../../shared/config/create_exchange_channel")
createConnect({exchangeName:"error_log", exchangeType:"fanout"})



app.listen(4000, ()=>{
    console.log("Server running on port "+ process.env.PORT );
})



