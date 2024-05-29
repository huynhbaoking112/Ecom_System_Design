const sendMessage = require("../../../shared/common/sendmessage")
const { getConnect } = require("../../../shared/config/create_exchange_channel")
const Rating = require("../../../shared/models/ratings_model")

const updateRatings = async (req, res, next) =>{
 try {
     const {ratings, user_id, product_id} = req.body
     const keys = user_id.toString() + "_" + product_id.toString()

     //update  database
     const newRating = await Rating.findOneAndUpdate(
         {keys},
         {keys, ratings, user_id, product_id},
         {new:true, upsert:true}
        )

    //dung queue đồng bộ hóa ElasticSearch
    let channel = getConnect()
    await sendMessage({channel, exchangeName:"topic_update_ratings", message:JSON.stringify, message:JSON.stringify({typeMess:"updateRating", data:JSON.stringify(newRating)}), route_key:"elastic.rating"})

    // res.status(200).json(newRating)
    res.status(200).json()
 } catch (error) {
    next(error)
 }   
}



module.exports = {updateRatings}