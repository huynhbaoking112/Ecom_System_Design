const jwt = require("jsonwebtoken");
const CustomError = require("./handle_error");

const generateToken =  (data) => {
  try {
    const token =  jwt.sign(data, "asdas123adasda", {expiresIn: '30d'});
    return token;
  } catch (error) {
    throw new CustomError(error.message)
  }
};


const verifyToken = (token) =>{
    try {
      var decoded = jwt.verify(token, 'asdas123adasda');

        if(!decoded){
          throw new CustomError("Phiên đăng nhập đã hết hạn vui lòng đăng nhập lại!", 400)
        }

        return decoded;

    } catch (error) {
        throw new CustomError(error.message, error.statusCode)
    }
}

module.exports = { generateToken , verifyToken};
