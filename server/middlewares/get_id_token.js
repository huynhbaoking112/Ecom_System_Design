const { verifyToken } = require("../common/handle_token");
const User = require("../models/user_model");

const handleToken = async (req,res,next)=>{

   try {
    
    const token = req.headers['x-auth-token'];
    
    //Giai ma token
    const data = verifyToken(token);
    
    //Check nguoi dung co ton tai khong
    const user = await User.findById(data.id)

    //Neu nguoi dung khong ton tai
    if(!user){
        throw new Error("Phiên đăng nhập đã hết hạn vui lòng đăng nhập lại")
    }

    //Hoàn tất xác minh 
    req.user = {token,...user._doc}

    next();
   } catch (error) {
    res.status(404).json({message: error.message})
   }


}



module.exports = {handleToken}