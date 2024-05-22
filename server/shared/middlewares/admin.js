const CustomError = require("../common/handle_error");

const checkAdmin = async (req, res, next) => {
    try {
        const user = req.user
        if(user.type == 'user' || user.type == 'seller'){
            throw new CustomError("You are not an admin!", 401)
        }
        next()
    } catch (error) {
        next(error)
    }
};



module.exports = {checkAdmin}