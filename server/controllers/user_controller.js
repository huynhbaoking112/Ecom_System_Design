const { getRedis } = require("../config/redis_connect");
const Product = require("../models/product_model");




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
             allProduct = await Product.find()
            await productRedis.setEx("allPost", 3600, JSON.stringify(allProduct))   
            
        }
        // Nếu redis tồn tại lấy data cho redis
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
        // console.log(allProductWithSearch);
        
        res.status(200).json(allProductWithSearch)

    } catch (error) {
        next(error)
    }
}


module.exports = {getProductWithCategory, getProductWithSearchKey}