//* Lưu ý khi thao tác dữ liệu cần chỉnh cache redis


const express = require("express")
const app = express()
require("dotenv").config()


//middleWare
app.use(express.json())

//connect and create channel RabbitMQ
const { createConnect } = require("../shared/config/create_exchange_channel")
createConnect()

//connect Database
//MongoDB
const ConnectDB = require("../shared/config/connect_db")
ConnectDB();
//Redis
const initRedis = require("../shared/config/redis_connect")
initRedis.initRedis()
//ElasticSearch
const {connectElastic} = require("../shared/config/elasticsearch")
connectElastic()



//Router
const authRouter = require("./routes/auth_router")
const adminRouter = require("./routes/admin_router")
const userRouter = require("./routes/user_router")
//Use Router
app.use("/user", authRouter)
app.use("/api", adminRouter)
app.use("/api/user", userRouter)



//Xử lí lỗi toàn cục 
const errorGloblal = require("../shared/middlewares/error_global")
app.use(errorGloblal)


app.listen(process.env.PORT, ()=>{
    console.log("Server running on port "+ process.env.PORT );
})



