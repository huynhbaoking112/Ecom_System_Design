const sendMessage = require("../../shared/common/sendmessage");
const { getConnect } = require("../../shared/config/create_exchange_channel");
const { getRedis } = require("../../shared/config/redis_connect");
const Product = require("../../shared/models/product_model");




const getProductWithCategory = async (req, res, next) => {
    const {category} = req.query
    try {
        
        // Dùng redis để lấy
        const {productRedis} = getRedis();
        //Xem redis
        const productJson = await productRedis.get("allPost")
        
        let allProduct = []

        //Nếu redis không tồn tại, cung cấp data cho redis
        if(!productJson){
            let channel = getConnect()
             allProduct = await Product.find()
             await sendMessage({channel, exchangeName:"topic_update_datas",message:JSON.stringify({typeMess:"setProduct"}), route_key:"update.set"})  
            
        }
        // Nếu redis tồn tại lấy data từ redis
        else{
            allProduct = JSON.parse(productJson)
        }
        // Lọc category trả về cho client
        let categoryProduct = allProduct.filter((e) => e.category == category)
        return res.status(200).json(categoryProduct)
        

    } catch (error) {
        next(error)
    }
} 


const getProductWithSearchKey = async (req, res, next) =>  {
    
    const {name} = req.params

    try {
        
        let allProductWithSearch = await Product.find({
            name:{$regex: name, $options: "i"  }
        })

        
        res.status(200).json(allProductWithSearch)

    } catch (error) {
        next(error)
    }
}


module.exports = {getProductWithCategory, getProductWithSearchKey}