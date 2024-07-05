const { default: axios } = require("axios");
const sendMessage = require("../../shared/common/sendmessage");
const { getConnect } = require("../../shared/config/create_exchange_channel");
const { getElastic } = require("../../shared/config/elasticsearch");
const { getRedis } = require("../../shared/config/redis_connect");
const Product = require("../../shared/models/product_model");
const UserCart = require("../../shared/models/user_cart_model");
const { handleErrorLog } = require("../../shared/common/write_log_if_err");

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
    handleErrorLog(error, next)
  }
};

const getProductWithSearchKey = async (req, res, next) => {
  const { name } = req.params;

  try {
    const { productElastic } = getElastic();

    const allProductWithSearch = await productElastic.search({
      index: "allpost",
      body: {
        size: 10,
        query: {
          bool: {
            should: [
              {
                wildcard: {
                  name: `*${name}*`,
                },
              },
              {
                wildcard: {
                  category: `*${name}*`,
                },
              },
              {
                "match": {
                  "name": {
                    "query": name,
                    "fuzziness": "AUTO"
                  }
                }
              },
              {
                "match": {
                  "category": {
                    "query": name,
                    "fuzziness": "AUTO"
                  }
                }
              }
            ],
          },
        },
      },
    });



    res.status(200).json(allProductWithSearch.hits.hits);
  } catch (error) {
    handleErrorLog(error, next)
  }
};

const getRatingProductWithId = async (req, res, next) => {
  const { productid } = req.params;
  try {

    //Sử dụng elasticSearch để tăng tốc độ truy vấn
    const { productElastic } = getElastic();
    const allProductWithSearch = await productElastic.search({
      index:"ratings",
      body:{
        query:{
          bool:{
            should:[
              {
                match: {
                  "product_id": productid
                }
              }
            ]
          }
        },
        aggs: {
          avg_ratings: {
            avg: {
              field: "ratings"
            }
          }
        }
      }
    });
    res.status(200).json(allProductWithSearch.aggregations.avg_ratings)
  } catch (error) {
    handleErrorLog(error, next)
  }
};


//XU LI TAI PRODUCT_SERVICE
const postRatingWithId =async (req, res, next)=>{
  try {

    // Gọi đến service product để update
    const result = await axios.post("http://localhost:7000/api/updateRating",req.body)
    res.status(result.status).json(result.data)
  } catch (error) {
    handleErrorLog(error, next)
  }
}





// XU LI TAI CART_SERVICE

const addProductToCart =  async(req, res, next) => {
  try {
    
    const result = await axios.post("http://localhost:7200/api/addcartofuser",{
      productId: req.body.productId,
      quantity: req.body.quantity,
      userId:req.user._id.toString()
    })
    res.status(result.status).json(result.data)
  } catch (error) {
    handleErrorLog(error, next)
  }
}

const getProductInCart = async (req, res, next)=>{
  try {
    const result = await axios.post("http://localhost:7200/api/cartofuser",{
      userId:req.user._id.toString()
    })
    res.status(result.status).json(result.data)
  } catch (error) {
    handleErrorLog(error, next)
  }
}


const deleteProduct =  async(req, res, next) => {
  try {
    let {productId}  = req.body
    const result = await axios.post("http://localhost:7200/api/deletecartofuser",{
      userId:req.user._id.toString(),
      productId
    })
    res.status(result.status).json(result.data)
  } catch (error) {
    handleErrorLog(error, next)
  }
}

const inanddeProduct = async (req, res, next)=>{
  try {
    let {productId, symbol}  = req.body
    const result = await axios.post("http://localhost:7200/api/increandecre",{
      userId:req.user._id.toString(),
      productId,
      symbol
    })
    res.status(result.status).json(result.data)
  } catch (error) {
    handleErrorLog(error, next)
  }
}
//---------------------------------------------------------


module.exports = {
  getProductWithCategory,
  getProductWithSearchKey,
  getRatingProductWithId,
  postRatingWithId,
  addProductToCart,
  getProductInCart,
  deleteProduct,
  inanddeProduct
};
