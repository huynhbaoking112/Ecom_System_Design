const bcrypt = require("bcrypt")


const hashPassword =async (currentPassword)=>{
    const passAfterHash = await bcrypt.hash(currentPassword, 10)
    return passAfterHash;
}

const comparePassword = async (currentPass, dbPass)=>{
    const match = await bcrypt.compare(currentPass, dbPass)
    return match;
}


module.exports = {hashPassword, comparePassword}