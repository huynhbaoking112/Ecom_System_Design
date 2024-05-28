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
// Kết nối redis
const { connectElastic } = require("../../shared/config/elasticsearch")
connectElastic()


//Kết nối RabbitMQ và khởi tạo consumer
const receivedHandleElatic = require("./config/config_service")
receivedHandleElatic({exchangeName:"topic_update_datas", exchangeType:"topic", bindingKey: "update.*"},{exchangeName:"topic_update_ratings", exchangeType:"topic", bindingKey: "update.*"})



app.listen(5000, ()=>{
    console.log("Server running on port "+ process.env.PORT );
})



