const { hashPassword, comparePassword } = require("../common/handle_password");
const { generateToken } = require("../common/handle_token");
const User = require("../models/user_model");

const signUpUser = async (req, res, next) => {
  try {
    const { email, password, name } = req.body;

    //check email xem tồn tại chưa
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(404).json({
        status: "Fail",
        message: "User with same email already exists!",
      });
    }

    //Hash Password
    const passwordAfterHash = await hashPassword(password);

    //CreateUser 
    let user = await User.create({ name, password: passwordAfterHash, email });

    //send client
    res.status(201).json({
      status: "Success",
      data: user,
    });
  } catch (error) {
    res.status(500).json({message: error.message})
  }
};

const signInUser = async(req,res,next)=>{
    try {
     
      const {email, password} = req.body

    //Check co ton tai tai khoan khong
    const user = await User.findOne({email})

    //neu khong ton tai
    if(!user){
      return res.status(404).json({message: "Email or password is incorrect"})
    }

    //Xu li password
    const match = await comparePassword(password, user.password)
    
    //Neu password khong match
    if(!match){
      return res.status(404).json({message: "Email or password is incorrect"})
    }

    //provider token
    const token = await generateToken({id: user._doc._id})
    


    //Tra ve client
    res.status(200).json({token,...user._doc})

    } catch (error) {
      res.status(500).json({message: error.message})
    }
}

const getInfor = async(req, res, next) =>{
  try {
    res.status(200).json(req.user);
  } catch (error) {
    res.status(500).json({message: error.message})
  }
}

module.exports = { signUpUser, signInUser, getInfor };
