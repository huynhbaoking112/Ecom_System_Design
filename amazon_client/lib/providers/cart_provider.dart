

import 'package:amazon_client/models/cart_product.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier{

  CartProduct _cartProduct = CartProduct(id: "", allProduct: [], user_id: "");

  get catProduct => _cartProduct;

  void setCart(String cartJson){
    _cartProduct = CartProduct.fromJson(cartJson);
    notifyListeners();
  } 

  void setCartModel(CartProduct cartProducts){
    _cartProduct = cartProducts;
    notifyListeners();
  }


}