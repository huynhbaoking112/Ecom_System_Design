
const amqplib_url = process.env.RABBITMQURL;
const amqp = require('amqplib');

//Luư trữ kết nối
let allChannel = {}


//Kết nối đến RabbitMQ server
const createConnect = async(...args)=>{
    try {
    
        const client = await amqp.connect(amqplib_url)

        //tạo channel
        const channel = await client.createChannel()


        //bind          
        for(i = 0; i< args.length; i++){
             await channel.assertExchange(args[i].exchangeName, args[i].exchangeType, {
            durable: true
            })
        }

        console.log(`Create connect RabbitMQ server and create channel completed`);

        allChannel.channel = channel

    } catch (error) {
        console.log(error.message);
    }
}


//Trả về kết nối
const getConnect = ()=>{
    return allChannel.channel
}


module.exports = {
    getConnect,
    createConnect
}