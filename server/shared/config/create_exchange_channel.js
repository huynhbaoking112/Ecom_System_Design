
const amqplib_url = "amqp://user:password@localhost:5672";
const amqp = require('amqplib');

//Luư trữ kết nối
let allChannel = {}


//Kết nối đến RabbitMQ server
const createConnect = async()=>{
    try {
    
        const client = await amqp.connect(amqplib_url)

        //tạo channel
        const channel = await client.createChannel()

        // Khai báo Exchange
        const exchangeName = 'topic_update_datas';
        const exchangeType = 'topic';

        //bind          
         await channel.assertExchange(exchangeName, exchangeType, {
        durable: true
        })

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