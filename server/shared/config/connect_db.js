const mongoose = require("mongoose")
const connectDB = ()=>{
    mongoose.connect(process.env.MONGODB_URI).then(()=>{
        console.log('DB connect success');
    }).catch((e)=>{console.log("DB connect fail with "+ e);})
}


module.exports = connectDB