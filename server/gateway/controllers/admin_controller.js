const CustomError = require("../../shared/common/handle_error");
const { getRedis } = require("../../shared/config/redis_connect");
const Product = require("../../shared/models/product_model");
const {getElastic} = require("../../shared/config/elasticsearch");
const addDoc = require("../../shared/common/elastic_sync");
const sendMessage = require("../../shared/common/sendmessage");
const { getConnect } = require("../../shared/config/create_exchange_channel");

const addProduct = async (req, res, next) => {
    try {

        const {name, description, images, quantity, price, category} = req.body;

        //Tạo trên DB
        let  product =await Product.create({name, description, images, quantity,  price, category});

        //Cập nhật redis        
        const {productRedis} = getRedis()
        let allProduct = await productRedis.get("allPost")

        let channel = getConnect()
        if(allProduct){
            //Sử dụng queue đồng bộ dữ liệu
            await sendMessage({channel, exchangeName:"topic_update_datas",message:JSON.stringify({typeMess:"addProduct", data:JSON.stringify(product)}), route_key:"update.add"})
        }else{
            //Sử dụng rabbitMQ chuyển giao cập nhật data cho redis
            await sendMessage({channel, exchangeName:"topic_update_datas",message:JSON.stringify({typeMess:"setProduct", data:JSON.stringify(product)}), route_key:"update.set"})
        }



        // Đồng bộ dữ liệu cho elasticSearch - Dùng rabbitMQ
        addDoc(product)

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
            //Vì data không hỗ trợ logic tiếp theo nên không cần đồng bộ nó bằng await
            productRedis.setEx("allPost", 3600, JSON.stringify(data))
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

        let channel = getConnect()
        if(allProduct){ 
            allProducts =  JSON.parse(allProduct);
            let newData = allProducts.filter((pro) => pro._id != id )
            productRedis.setEx("allPost", 3600, JSON.stringify(newData))    
        }else{
             //Sử dụng rabbitMQ chuyển giao cập nhật data cho redis
             await sendMessage({channel, exchangeName:"topic_update_datas",message:JSON.stringify({typeMess:"setProduct", data:JSON.stringify(product)}), route_key:"update.set"})
            }


        //Trả về client
        res.status(200).json({message: "Deleted Successfuly"})
    } catch (error) {
        next(error)
    }
}

module.exports = {addProduct, getProduct, deleteProduct}    