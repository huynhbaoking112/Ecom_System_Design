//* Lưu ý khi thao tác dữ liệu cần chỉnh elasticSearch


const express = require("express")
const app = express()
require("dotenv").config()


//middleWare
app.use(express.json())


//connect Database
//MongoDB
const ConnectDB = require("../../shared/config/connect_db")
ConnectDB();


//Kết nối RabbitMQ và khởi tạo consumer
const receivedHandleErrorLog = require("./config/config_service")
receivedHandleErrorLog({exchangeName:"error_log", exchangeType:"fanout", bindingKey: ""})



app.listen(process.env.PORT, ()=>{
    console.log("Server running on port "+ process.env.PORT );
})



