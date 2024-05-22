// Lấy thông tin từ redis rồi lọc tốc độ cao. Nếu thông tin chưa có thì tải toàn bộ product về redis
// Trước mỗi đường dẫn buộc lòng có middleware xác minh user


const express = require("express");
const { getProductWithCategory, getProductWithSearchKey } = require("../controllers/user_controller");
const { handleToken } = require("../../shared/middlewares/get_id_token");
const userRouter = express.Router();





//get product category sử dụng query -  product?category=...
userRouter.route("/product").get(handleToken ,getProductWithCategory)


//Get product with search key ( Sử dụng mongoose không dùng redis về nó có hỗ trợ biểu thức chính quy - Sau này nâng cấp elSearch thì áp dụng eLsearch )
userRouter.route("/search/:name").get(handleToken, getProductWithSearchKey)




module.exports = userRouter