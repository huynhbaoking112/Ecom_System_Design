const amqp = require("amqplib")
const {getRedis} = require("../../../shared/config/redis_connect")
const amqplib_url = "amqp://user:password@localhost:5672";
const Product = require("../../../shared/models/product_model");
const { handleErrorLog } = require("../../../shared/common/write_log_if_err");
const { getElastic } = require("../../../shared/config/elasticsearch");


//Kết nối đến RabbitMQ server
const receivedHandleRedis = async (...args)=>{
    try {
    const {productRedis} = getRedis()   
    const client = await amqp.connect(amqplib_url)

    //tạo channel
    const channel = await client.createChannel()

    //taoj queue name
    const queueName = 'redis_caches_queue'
    await channel.assertQueue(queueName,{
        //Backup queue vào disk
        durable:true
    })

    for(i=0 ; i< args.length; i++){
        //bind
        await channel.assertExchange(args[i].exchangeName, args[i].exchangeType, {
            durable: true
        })
        await channel.bindQueue(queueName, args[i].exchangeName, args[i].bindingKey)
    }


    console.log(`[Service handle redis] Waiting for messages `);

    await channel.consume(queueName,async (msg)=>{

        // console.log(`[Service handle redis] Received message: ${msg.content.toString()}`);
        let mess = JSON.parse(msg.content.toString()) 

        //lấy loại mess
        let typeMess = mess.typeMess

        //lấy data 
        let data = mess.data

        //Xử lí
        //Thêm product
        if(typeMess=="addProduct"){
            //Thêm vào Key allProduct
            let allProduct = await productRedis.get("allPost")
            if(allProduct){
                allProducts =  JSON.parse(allProduct);
                allProducts.push(JSON.parse(data))
                await productRedis.setEx("allPost", 3600, JSON.stringify(allProducts))
                console.log("Add product success from Redis service");
            }else{
                allProduct = await Product.find()
                await productRedis.setEx("allPost", 3600, JSON.stringify(allProduct))
                console.log("Set product success from Redis service");
            }

            // Xóa key  Category
             await productRedis.del(JSON.parse(data).category)
            console.log("Delete category key success from Redis service");

            
            channel.ack(msg)

        }

        //Set category trên redis
        else if(typeMess == "setCategory"){
            // let allProductWithCategory =  await Product.find({category:data})
            const {productElastic} = getElastic()
            let allProductWithCategory = await productElastic.search({
              index:"allpost",
              size:1000,
              body: {
                query: {
                  "match": {
                    "category": "Mobiles"
                  }
                }
              }
            })
            await productRedis.setEx(data, 3600, JSON.stringify(allProductWithCategory))
            channel.ack(msg)
            console.log("Set category success from Redis Service");   
        }

        //Set Product trên redis
        else if(typeMess == "setProduct"){
            let allProduct = await Product.find()
            await productRedis.setEx("allPost", 3600, JSON.stringify(allProduct))
            channel.ack(msg)
            console.log("Set product success from Redis Service");   
        }

        //Xóa product
        else if(typeMess == "deleteProduct"){

            //Xóa trên allPost
            let allProduct = await productRedis.get("allPost")
            if(allProduct){
                allProducts =  JSON.parse(allProduct);
                newAllProducts = allProducts.filter((e)=>e._id!=JSON.parse(data)._id.toString())
                await productRedis.setEx("allPost", 3600, JSON.stringify(newAllProducts))
                console.log("Delete product success from Redis Service");   
            }else{
                let allProduct = await Product.find()
                await productRedis.setEx("allPost", 3600, JSON.stringify(allProduct))
                console.log("Set product success from Redis Service");               
            }

            //Xóa key category
            await productRedis.del(JSON.parse(data).category.toString())
            channel.ack(msg)
        }
        //Xử lí message lạ
        else{
            channel.ack(msg)
            throw new Error("Redis Service nhận được Message lạ: "+msg.content)
        }


    },{
        //Kiểm soát trạng thái hoàn thành tin nhắn
        noAck: false
    })

    } catch (error) {
        channel.ack(msg)
        handleErrorLog(error)
    }
}



module.exports = receivedHandleRedis