const { getConnect } = require("../config/create_exchange_channel");
const sendMessage = require("./sendmessage");

const handleErrorLog = async(error, next) => {
    let channel = getConnect();
    await sendMessage({
        channel,
        exchangeName:"error_log",
        message:JSON.stringify({typeof:"errorOfApp", data:err.message}),
        route_key:""
      })
      next?next(error):null;
}


module.exports = {handleErrorLog}