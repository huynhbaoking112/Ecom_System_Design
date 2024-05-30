const mongoose = require("mongoose")


const CartItemSchema = new mongoose.Schema({
    quantity: {
        type: Number,
        default: 1
    },
    product_id:{
        type: mongoose.Schema.Types.ObjectId,
        ref: "Product",
        required: true
    }
})


const UserCartSchema = new mongoose.Schema({
    allProduct:{
        type: [CartItemSchema],
        default: []
    },
    user_id:{
        type: mongoose.Types.ObjectId,
        ref: "User",
        required: true
    }
})

CartItemSchema.index({user_id:1})

const UserCart = mongoose.model("UserCart", UserCartSchema)
module.exports = UserCart