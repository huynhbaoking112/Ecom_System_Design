// Lấy thông tin từ redis rồi lọc tốc độ cao. Nếu thông tin chưa có thì tải toàn bộ product về redis
// Trước mỗi đường dẫn buộc lòng có middleware xác minh user


const express = require("express");
const {inanddeProduct ,deleteProduct, getProductWithCategory, getProductWithSearchKey, getRatingProductWithId, postRatingWithId, addProductToCart, getProductInCart } = require("../controllers/user_controller");
const { handleToken } = require("../../shared/middlewares/get_id_token");
const userRouter = express.Router();





//get product category sử dụng query -  product?category=...
userRouter.route("/product").get(handleToken ,getProductWithCategory)


//Get product with search key ( Sử dụng mongoose không dùng redis về nó có hỗ trợ biểu thức chính quy - Sau này nâng cấp elSearch thì áp dụng eLsearch )
userRouter.route("/search/:name").get(handleToken, getProductWithSearchKey)


userRouter.route("/ratings/product/:productid")
//get product ratings
.get(handleToken, getRatingProductWithId )
// .get( getRatingProductWithId )
//post ratings 
.post(handleToken, postRatingWithId )
// .post(postRatingWithId )


//User Cart
userRouter.route("/usercart/product")
//Add product to cart
.post(handleToken, addProductToCart)
// .post(addProductToCart)


//get allProduct in cart
.get(handleToken, getProductInCart)
// .get(getProductInCart)


//delete product in cart
userRouter.route("/deletedusercart/product")
.post(handleToken, deleteProduct)

//incre and decre product in cart
userRouter.route("/increandecre/product")
.post(handleToken, inanddeProduct)




module.exports = userRouter