const UserCart = require("../../../shared/models/user_cart_model");
const Product = require("../../../shared/models/product_model");

const updateCart = async (req, res, next) => {
  try {
    //Lay id product va so luong  (lay them user id binh thuong se lay thong qua req.user)
    const { productId, quantity, userId } = req.body;

    //Tìm kiếm userCart
    let userCart = await UserCart.findOne({ user_id: userId });

    if (!userCart) {
      userCart = await UserCart.create({
        user_id: userId,
        allProduct: [{ product_id: productId, quantity }],
      });
    } else {
      //CheckXem có sản phẩm đó không
      const index = userCart.allProduct.findIndex(
        (e) => e.product_id.toString() == productId
      );
      if (index == -1) {
        userCart.allProduct.push({ product_id: productId, quantity });
      } else {
        userCart.allProduct[index].quantity += quantity;
      }
      await userCart.save();
    }


    res.status(200).json(userCart);
  } catch (error) {
    next(error);
  }
};

const getCart = async (req, res, next) => {
  try {
      const {userId} = req.body 


    let productCart = await UserCart.findOne({user_id:userId}).populate("allProduct.product_id")

      // Nếu giỏ hàng không tồn tại, tạo một giỏ hàng mới
    if (!productCart) {
      productCart = await  UserCart.create({ user_id: userId, allProduct: [] });
    }


    res.status(200).json(productCart)
  } catch (error) {
    next(error);
  }
};


const deleteProduct = async (req, res, next) => {
    try {

        let {userId, productId} = req.body
        let productCart = await UserCart.findOne({user_id:userId}).populate("allProduct.product_id")
        newProductCart = productCart.allProduct.filter((e)=>e.product_id._id.toString()!=productId)

        productCart.allProduct = newProductCart
        await productCart.save()

        res.status(200).json(productCart)
    } catch (error) {
        console.log(error.message);
        next(error)
    }
}

const inanddeProduct = async (req, res, next)=>{
  try {
    let {userId, productId, symbol} = req.body
    let productCart = await UserCart.findOne({user_id:userId}).populate("allProduct.product_id")
    newProductCart = productCart.allProduct 
    index = newProductCart.findIndex((e)=>{
      return  e.product_id._id.toString()==productId
    });

    if(symbol == "-"){

      newProductCart[index].quantity == 1 ?
      newProductCart.splice(index,1)
      :newProductCart[index].quantity--;
    }else{
      newProductCart[index].quantity++ 
    }


    productCart.allProduct = newProductCart
    await productCart.save()

    res.status(200).json(productCart)
  } catch (error) {
    console.log(error.message);
    next(error)
  }
}

module.exports = { updateCart, getCart, deleteProduct, inanddeProduct };


