const express = require("express");
const { handleToken } = require("../../shared/middlewares/get_id_token");
const { checkAdmin } = require("../../shared/middlewares/admin");
const { addProduct, getProduct, deleteProduct } = require("../controllers/admin_controller");
const adminRouter = express.Router();



//Lưu ý luôn cài 2 middleware để check admin
//Add product
adminRouter.route("/admin/add-product").post( addProduct)
// adminRouter.route("/admin/add-product").post(handleToken, checkAdmin, addProduct)


//get product
adminRouter.route("/admin/get-product")
.get(getProduct)
// adminRouter.route("/admin/get-product")
// .get(handleToken, checkAdmin, getProduct)
//DeleteProduct
.post(deleteProduct)
// .post(handleToken, checkAdmin, deleteProduct)


module.exports = adminRouter;



    