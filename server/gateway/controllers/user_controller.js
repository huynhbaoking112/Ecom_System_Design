const sendMessage = require("../../shared/common/sendmessage");
const { getConnect } = require("../../shared/config/create_exchange_channel");
const { getElastic } = require("../../shared/config/elasticsearch");
const { getRedis } = require("../../shared/config/redis_connect");
const Product = require("../../shared/models/product_model");

const getProductWithCategory = async (req, res, next) => {
  const { category } = req.query;
  try {
    // Dùng redis để lấy
    const { productRedis } = getRedis();
    //Xem redis
    const productJson = await productRedis.get("allPost");

    let allProduct = [];

    //Nếu redis không tồn tại, cung cấp data cho redis
    if (!productJson) {
      let channel = getConnect();
      allProduct = await Product.find();
      await sendMessage({
        channel,
        exchangeName: "topic_update_datas",
        message: JSON.stringify({ typeMess: "setProduct" }),
        route_key: "update.set.redis",
      });
    }
    // Nếu redis tồn tại lấy data từ redis
    else {
      allProduct = JSON.parse(productJson);
    }
    // Lọc category trả về cho client
    let categoryProduct = allProduct.filter((e) => e.category == category);
    return res.status(200).json(categoryProduct);
  } catch (error) {
    next(error);
  }
};

const getProductWithSearchKey = async (req, res, next) => {
  const { name } = req.params;

  try {
   
    const { productElastic } = getElastic();
    const allProductWithSearch = await productElastic.search({
      index: "allpost",
      body: {
        "size": 10, 
        "query": {
          bool: {
            should: [
              {
                wildcard: {
                    name: `*${name}*`
                }
            },
            {
                wildcard: {
                    category: `*${name}*`
                }
            }
            // {
            //   "match": {
            //     "name": {
            //       "query": "k",
            //       "fuzziness": "AUTO"
            //     }
            //   }
            // },
            // {
            //   "match": {
            //     "category": {
            //       "query": "mobiles",
            //       "fuzziness": "AUTO"
            //     }
            //   }
            // }
            ]
        }
        }
      }
    });
    // console.log(allProductWithSearch.hits.hits);
    res.status(200).json(allProductWithSearch.hits.hits)
  } catch (error) {
    next(error);
  }
};

module.exports = { getProductWithCategory, getProductWithSearchKey };
