const express = require("express")
const app = express()
require("dotenv").config()


//middleWare
app.use(express.json())



//connect mongoose
const ConnectDB = require("./config/connect_db")
ConnectDB();



//Router
const authRouter = require("./routes/auth_router")
const adminRouter = require("./routes/admin_router")


//Use Router
app.use("/user", authRouter)
app.use("/api", adminRouter)



app.listen(process.env.PORT, ()=>{
    console.log("Server running on port "+ process.env.PORT );
})