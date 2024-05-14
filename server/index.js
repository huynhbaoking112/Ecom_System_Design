//* Lưu ý khi thao tác dữ liệu cần chỉnh cache redis


const express = require("express")
const app = express()
require("dotenv").config()


//middleWare
app.use(express.json())



//connect Database
//MongoDB
const ConnectDB = require("./config/connect_db")
ConnectDB();
//Redis
const initRedis = require("./config/redis_connect")
initRedis.initRedis()


//Router
const authRouter = require("./routes/auth_router")
const adminRouter = require("./routes/admin_router")
const userRouter = require("./routes/user_router")
//Use Router
app.use("/user", authRouter)
app.use("/api", adminRouter)
app.use("/api/user", userRouter)



//Xử lí lỗi toàn cục 
const errorGloblal = require("./middlewares/error_global")
app.use(errorGloblal)


app.listen(process.env.PORT, ()=>{
    console.log("Server running on port "+ process.env.PORT );
})



