const express = require("express");
const { handleToken } = require("../middlewares/get_id_token");
const { checkAdmin } = require("../middlewares/admin");
const { addProduct, getProduct, deleteProduct } = require("../controllers/admin_controller");
const adminRouter = express.Router();



//Lưu ý luôn cài 2 middleware để check admin
//Add product
adminRouter.route("/admin/add-product").post(handleToken, checkAdmin, addProduct)


//get product
adminRouter.route("/admin/get-product")
.get(handleToken, checkAdmin, getProduct)
//DeleteProduct
.post(handleToken, checkAdmin, deleteProduct)


module.exports = adminRouter;



    