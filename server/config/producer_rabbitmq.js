
const amqplib_url = "amqp://user:password@localhost:5672";
const amqp = require('amqplib');

//Kết nối đến RabbitMQ server
const sendMessage = async ({message, route_key})=>{
    try {
        console.log(message);
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


    console.log(`[API get way] send messages with reoute key ${route_key}`);

    await channel.publish(exchangeName, route_key, Buffer.from(message), {
        persistent: true
    })

    // client.close()

    } catch (error) {
        console.log(error);
    }
}

module.exports = sendMessage