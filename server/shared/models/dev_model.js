const mongoose = require("mongoose")


const DevSchema = new mongoose.Schema({
    name:{
        type:String,
        required: true
    },
    position:{
        type:String,
        required:true
    },
    email:{
        type:String,
        required:true,
        trim: true,
        validate:{
            validator:(val) =>{
                const re =  /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return val.match(re);
            },
            message: 'Please enter a valid email address'
        }
    },
    phoneNumber:{
        type:Number,
        required:true
    }
},{
    timestamps:true
})

DevSchema.index({email:1})

const Dev = mongoose.model("Dev", DevSchema)

module.exports = Dev