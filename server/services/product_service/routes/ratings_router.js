const express = require("express")
const { updateRatings } = require("../controllers/ratings_controller")
const ratingRouter = express.Router()



ratingRouter.route("/updateRating")
//updateRating
.post(updateRatings)




module.exports = ratingRouter
