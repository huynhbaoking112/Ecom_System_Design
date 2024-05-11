const Product = require("../models/product_model");


const addProduct = async (req, res, next) => {
    try {
        const {name, description, images, quantity, price, category} = req.body;

        let  product =await Product.create({name, description, images, quantity,  price, category});

        res.status(200).json(product)


    } catch (error) {
        res.status(500).json({message: error.message})
    }
}


const getProduct = async (req, res, next) =>{
    try {
        
        let allProducts = await  Product.find();

        res.status(200).json(allProducts);
        
    } catch (error) {
        res.status(500).json({message: error.message})
    }
}

module.exports = {addProduct, getProduct}    