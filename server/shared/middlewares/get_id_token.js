const { verifyToken } = require("../common/handle_token")
const User = require("../../shared/models/user_model");
const CustomError = require("../common/handle_error");

const handleToken = async (req,res,next)=>{ 

   try {
       const token = req.headers['x-auth-token'];
       if(!token){
        throw new CustomError("Vui lòng đăng nhập", 403)
       }

       //Giai ma token
       const data = verifyToken(token);
    
    //Check nguoi dung co ton tai khong
    const user = await User.findById(data.id)

    //Neu nguoi dung khong ton tai
    if(!user){
        throw new CustomError("Phiên đăng nhập đã hết hạn vui lòng đăng nhập lại", 404)
    }

    //Hoàn tất xác minh 
    req.user = {token,...user._doc}

    next();
   } catch (error) {
    next(error)
   }


}



module.exports = {handleToken}