const amqp = require("amqplib")
const {getRedis} = require("../../../shared/config/redis_connect")
const amqplib_url = "amqp://user:password@localhost:5672";
const Product = require("../../../shared/models/product_model");


//Kết nối đến RabbitMQ server
const receivedHandleRedis = async ()=>{
    try {
    const {productRedis} = getRedis()   
    const client = await amqp.connect(amqplib_url)

    //tạo channel
    const channel = await client.createChannel()

    //taoj queue name
    const queueName = 'redis_caches_queue'
    const bindingKey = "update.*"

    // Khai báo Exchange
    const exchangeName = 'topic_update_datas';
    const exchangeType = 'topic';

    //bind
    await channel.assertExchange(exchangeName, exchangeType, {
        durable: true
    })
    await channel.assertQueue(queueName,{
        //Backup queue vào disk
        durable:true
    })
    await channel.bindQueue(queueName, exchangeName, bindingKey)

    console.log(`[Service handle redis] Waiting for messages with binding key ${bindingKey}`);

    await channel.consume(queueName,async (msg)=>{

        // console.log(`[Service handle redis] Received message: ${msg.content.toString()}`);
        let mess = JSON.parse(msg.content.toString()) 

        //lấy loại mess
        let typeMess = mess.typeMess

        //lấy data 
        let data = mess.data

        //Xử lí
        if(typeMess=="addProduct"){
            let allProduct = await productRedis.get("allPost")
            allProducts =  JSON.parse(allProduct);
            allProducts.push(JSON.parse(data))
            await productRedis.setEx("allPost", 3600, JSON.stringify(allProducts))
            channel.ack(msg)
            console.log("Add product success");
        }
        else if(typeMess == "setProduct"){
            let allProduct = await Product.find()
            await productRedis.setEx("allPost", 3600, JSON.stringify(allProduct))
            channel.ack(msg)
            console.log("Set product success");
        }
        else{
            channel.ack(msg)
            // throw new Error("Message lạ")
        }


    },{
        //Kiểm soát trạng thái hoàn thành tin nhắn
        noAck: false
    })

    } catch (error) {
        console.log(error);
    }
}



module.exports = receivedHandleRedis