const express = require("express")
const Router = express.Router()
const {signUpUser, signInUser, getInfor} = require("../controllers/auth_controller")
const { handleToken } = require("../../shared/middlewares/get_id_token")

//sign up
Router.route("/api/signup").post(signUpUser)

//sign in
Router.route("/api/signin").post(signInUser)


//get infor user
Router.route("/api/getInforWithToken").get(handleToken, getInfor);




module.exports = Router