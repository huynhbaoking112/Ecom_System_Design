const amqp = require("amqplib");
const { getElastic } = require("../../../shared/config/elasticsearch");
const amqplib_url = "amqp://user:password@localhost:5672";
const Product = require("../../../shared/models/product_model");
const { addDoc, deleteDoc, updateRating } = require("../utils/elastic_sync");

//Kết nối đến RabbitMQ server
const receivedHandleElatic = async (...args) => {
  try {
    const { productElastic } = getElastic();
    const client = await amqp.connect(amqplib_url);

    //tạo channel
    const channel = await client.createChannel();

    //tạo queue name
    const queueName = "elastic_search_queue";
    await channel.assertQueue(queueName, {
      //Backup queue vào disk
      durable: true,
    });
    for (i = 0; i < args.length; i++) {
      //bind
      await channel.assertExchange(args[i].exchangeName, args[i].exchangeType, {
        durable: true,
      });
      await channel.bindQueue(
        queueName,
        args[i].exchangeName,
        args[i].bindingKey
      );
    }


    console.log(
      `[Service handle Elastic] Waiting for messages `
    );

    await channel.consume(
      queueName,
      async (msg) => {
        //Lấy mess
        let mess = JSON.parse(msg.content.toString());

        //lấy loại mess
        let typeMess = mess.typeMess;

        //lấy data
        let data = mess.data;

        //Xử lí
        //Thêm product
        if (typeMess == "addProduct") {
          await addDoc(JSON.parse(data));
          channel.ack(msg);
          console.log("Add product success from Elastic service");
        }

        //Xóa product
        else if (typeMess == "deleteProduct") {
          await deleteDoc(JSON.parse(data)._id.toString());
          channel.ack(msg);
          console.log("Delete product success from Elastic service");
        }

        //Cập nhật ratings
        else if(typeMess=="updateRating"){
          await updateRating(JSON.parse(data))
          channel.ack(msg);
          console.log("Ratings product success from Elastic service");
        }

        //Xử lí message lạ
        else {
          channel.ack(msg);
          // throw new Error("Elastic Service nhận được Message lạ: "+msg.content)
        }
      },
      {
        //Kiểm soát trạng thái hoàn thành tin nhắn
        noAck: false,
      }
    );
  } catch (error) {
    handleErrorLog(error)
  }
};

module.exports = receivedHandleElatic;
