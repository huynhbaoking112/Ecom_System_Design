const jwt = require("jsonwebtoken");

const generateToken =  (data) => {
  try {
    const token =  jwt.sign(data, "asdas123adasda", {expiresIn: '30d'});
    return token;
  } catch (error) {
    throw new Error(error.message)
  }
};


const verifyToken = (token) =>{
    try {
        var decoded = jwt.verify(token, 'asdas123adasda');

        if(!decoded){
            throw new Error("Phiên đăng nhập đã hết hạn vui lòng đăng nhập lại!")
        }

        return decoded;

    } catch (error) {
        throw new Error(error.message)
    }
}

module.exports = { generateToken , verifyToken};
