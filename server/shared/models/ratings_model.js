const mongoose = require("mongoose")


const RatingsSchema = new mongoose.Schema({
    keys:{
        type: String,
        required: true,
        unique: true
    },
    ratings: {
        type: Number,
        required: true
    },
    user_id:{
        type: String,
        required: true,
    },
    product_id:{
        type: String,
        required: true,
    }
},{
    timestamps: true,
})

//Đánh index để tìm kiếm
RatingsSchema.index({keys: 1})


const Rating = mongoose.model("Rating", RatingsSchema)
module.exports = Rating