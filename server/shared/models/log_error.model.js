const mongoose = require("mongoose")




const ErrorSchema = new mongoose.Schema({
    message:{
        type: String,
        required:true
    }
})


const ErrorMod = mongoose.model("Error", ErrorSchema)

module.exports = ErrorMod