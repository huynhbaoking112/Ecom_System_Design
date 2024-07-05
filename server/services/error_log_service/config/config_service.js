const amqp = require("amqplib");
const amqplib_url = "amqp://user:password@localhost:5672";
const { NotiOfDev } = require("../utils/error_noti");
const ErrorMod = require("../../../shared/models/log_error.model");

//Kết nối đến RabbitMQ server
const receivedHandleErrorLog = async (...args) => {
  try {

    const client = await amqp.connect(amqplib_url);

    //tạo channel
    const channel = await client.createChannel();

    //tạo queue name
    const queueName = "error_log_queue";
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
      `[Service handle Error Log] Waiting for messages `
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
        //Lỗi 
        if (typeMess == "errorOfApp") {

          //Ghi vào DB error log
          await ErrorMod.create({message:data})
          //Bắn message đến dev thông qua email-Nodemailer (phoneNumber)
          await NotiOfDev(JSON.stringify(data))

          channel.ack(msg);
          console.log("Handle error success");
          
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
    console.log(error);
  }
};

module.exports = receivedHandleErrorLog;
