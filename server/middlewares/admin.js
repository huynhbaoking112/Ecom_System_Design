const checkAdmin = async (req, res, next) => {
    try {
        const user = req.user
        if(user.type == 'user' || user.type == 'seller'){
            return res.status(401).json({message: "You are not an admin!"})
        }
        next()
    } catch (error) {
        res.status(404).json({message: error.message})
    }
};



module.exports = {checkAdmin}