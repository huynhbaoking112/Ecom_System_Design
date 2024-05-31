const express = require("express")
const { getCart, updateCart, deleteProduct, inanddeProduct } = require("../controllers/cart_controller")
const CartRouter = express.Router()


CartRouter.route("/cartofuser")
//getCartOfUser
.post(getCart)

CartRouter.route("/addcartofuser")
//Add product in cart
.post(updateCart)

CartRouter.route("/increandecre")
//Add product in cart
.post(inanddeProduct)


CartRouter.route("/deletecartofuser")
//Delete product in cart
.post(deleteProduct)





module.exports = CartRouter