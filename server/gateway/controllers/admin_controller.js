const CustomError = require("../../shared/common/handle_error");
const { getRedis } = require("../../shared/config/redis_connect");
const Product = require("../../shared/models/product_model");
const sendMessage = require("../../shared/common/sendmessage");
const { getConnect } = require("../../shared/config/create_exchange_channel");

const addProduct = async (req, res, next) => {
    try {

        const {name, description, images, quantity, price, category} = req.body;

        //Tạo trên DB
        let  product =await Product.create({name, description, images, quantity,  price, category});

        //Cập nhật redis và elasticSearch     
        let channel = getConnect()
        await sendMessage({channel, exchangeName:"topic_update_datas",message:JSON.stringify({typeMess:"addProduct", data:JSON.stringify(product)}), route_key:"update.add"})

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
            let channel = getConnect()
            data = await Product.find()
            await sendMessage({channel, exchangeName:"topic_update_datas",message:JSON.stringify({typeMess:"setProduct"}), route_key:"update.set.redis"})
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
        let channel = getConnect()
        await sendMessage({channel, exchangeName:"topic_update_datas",message:JSON.stringify({typeMess:"deleteProduct", data:JSON.stringify(id)}), route_key:"update.delete"})
        
        //Cập nhật elasticSearch


        //Trả về client
        res.status(200).json({message: "Deleted Successfuly"})
    } catch (error) {
        next(error)
    }
}

module.exports = {addProduct, getProduct, deleteProduct}    