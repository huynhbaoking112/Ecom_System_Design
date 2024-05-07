const mongoose = require("mongoose")



const UserSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true
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

    password:{
        type: String,
        required: true,
        validate:{
            validator:(val)=>{
                return val.length>6;
            },
            message:"Please enter a long password"
        }
    },
     
    address:{
        type: String,
        default: '',
    },

    type:{
        type: String,
        default: 'user',
    },



},{
    timestamps:true
})



const User = mongoose.model("User", UserSchema)

module.exports = User