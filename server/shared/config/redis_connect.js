const redis = require("redis");

let client = {},
  // Các trạng thái kết nối
  statusConnectRedis = {
    CONNECT: "connect",
    END: "end",
    RECONNECT: "reconnecting",
    ERROR: "error",
  };

// Hàm kiểm tra kết nốt Redis
const handleEventConnection = (connectionRedis, nameRedis) => {
  connectionRedis.on(statusConnectRedis.CONNECT, () => {
    console.log(`${nameRedis} - Connection status: connected`);
  });
  connectionRedis.on(statusConnectRedis.END, () => {
    console.log(`${nameRedis}  - Connection status: disconnected`);
  });
  connectionRedis.on(statusConnectRedis.RECONNECT, () => {
    console.log(`${nameRedis}  - Connection status: reconnecting`);
  });
  connectionRedis.on(statusConnectRedis.ERROR, (error) => {
    console.log(`${nameRedis}  - Connection status: ${error}`);
  });
};

const initRedis = () => {
  //Tạo kết nối
  const productRedis = redis.createClient({
    port: 6379,
  });

  //Hàm kiểm tra kết nối
  handleEventConnection(productRedis, "productRedis");

  //Đưa redis vào danh mục redis
  client.productRedis = productRedis;

  // Kết nối
  productRedis.connect();
};

const getRedis = () => {
  return client;
};

const closeRedis = () => {};

module.exports = {
  initRedis,
  getRedis,
  closeRedis,
};
