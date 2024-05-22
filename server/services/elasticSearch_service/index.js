//* Lưu ý khi thao tác dữ liệu cần chỉnh cache redis


const express = require("express")
const app = express()
require("dotenv").config()


//middleWare
app.use(express.json())



//ElasticSearch
const {connectElastic} = require("../../config/elasticsearch")
connectElastic()

//Kết nối RabbitMQ và khởi tạo consumer


app.listen(5000, ()=>{
    console.log("Server running on port "+ process.env.PORT );
})



