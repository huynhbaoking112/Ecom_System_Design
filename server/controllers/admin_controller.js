const CustomError = require("../common/handle_error");
const { getRedis } = require("../config/redis_connect");
const Product = require("../models/product_model");


const addProduct = async (req, res, next) => {
    try {
        const {name, description, images, quantity, price, category} = req.body;

        let  product =await Product.create({name, description, images, quantity,  price, category});
        

        //Cập nhật redis        
        const {productRedis} = getRedis()
        let allProduct = await productRedis.get("allPost")
        allProducts =  JSON.parse(allProduct);
        allProducts.push(product)
        await productRedis.setEx("allPost", 3600, JSON.stringify(allProducts))


        // Trả về client
        res.status(200).json(product)

    } catch (error) {
       next(error)
    }
}


const getProduct = async (req, res, next) =>{
    try {

        let {productRedis } =  getRedis();
    
        let data = await productRedis.get("allPost");

        if(!data){
            data = await Product.find()
            await productRedis.setEx("allPost", 3600, JSON.stringify(data))
            return res.json(data)
        }

        res.status(200).json(JSON.parse(data))
        
    } catch (error) {
        next(error)
    }
}


const deleteProduct = async (req, res, next) => {
    try {

        //Xóa productId
        const {id} = req.body
        await Product.findByIdAndDelete(id)

        //Cập nhật redis
        const {productRedis} = getRedis()
        let allProduct = await productRedis.get("allPost")
        allProducts =  JSON.parse(allProduct);
        let newData = allProducts.filter((pro) => pro._id != id )
        await productRedis.setEx("allPost", 3600, JSON.stringify(newData))


        //Trả về client
        res.status(200).json({message: "Deleted Successfuly"})
    } catch (error) {
        next(error)
    }
}

module.exports = {addProduct, getProduct, deleteProduct}    