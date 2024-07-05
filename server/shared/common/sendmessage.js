
const amqplib_url = "amqp://user:password@localhost:5672";
const amqp = require('amqplib');

//Kết nối đến RabbitMQ server
const sendMessage = async ({channel, exchangeName ,message, route_key})=>{
    try {
    
    await channel.publish(exchangeName, route_key, Buffer.from(message), {
        persistent: true,
        expiration: (24*60*60*1000).toString()
    })
    console.log("Send message to queue success with route_key "+ route_key);
    } catch (error) {
        console.log(error);
    }
}

module.exports = sendMessage