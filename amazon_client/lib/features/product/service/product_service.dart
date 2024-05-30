import 'dart:convert';

import 'package:amazon_client/constants/error_handling.dart';
import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/constants/utils.dart';
import 'package:amazon_client/providers/cart_provider.dart';
import 'package:amazon_client/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductService {

  static addProductInCart({
    required BuildContext context,
    required String productId,
    required int quantity
  })async{
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
    try {

      http.Response res = await http.post(Uri.parse("$uri/api/user/usercart/product"),body: jsonEncode({
        "productId": productId,
        "quantity":quantity,
        "userId": userProvider.user.id
      }) ,headers: <String, String>{
        'Content-Type':"application/json",
        'x-auth-token': userProvider.user.token
      });

    httpErrorHandle(response: res, context: context, onSuccess: (){
        cartProvider.setCart(res.body);
        print(res.body);
        print(cartProvider.catProduct.allProduct.length);
        showSnackBar(context, "Add product in cart success");
    });

      
    } catch (e) {
       showSnackBar(context, e.toString());
    }
  }




  Future<double> getRatingProduct({
    required BuildContext context,
    required String productId
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    double? rating;
    try {  

    http.Response res = await http.get(Uri.parse("$uri/api/user/ratings/product/$productId"),headers: <String, String> {
      "Content-Type":"application/json",
      "x-auth-token": userProvider.user.token
    });

    httpErrorHandle(response: res, context: context, onSuccess: (){
      rating = jsonDecode(res.body)["value"] == null ? 1 :jsonDecode(res.body)["value"].toDouble();
    });


    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return rating??1;
  }

  void setRatingProduct({
    required BuildContext context,
    required double rating,
    required String productId
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {

      http.Response res = await http.post(Uri.parse("$uri/api/user/ratings/product/$productId"),body: jsonEncode({
        "ratings": rating,
        "user_id": userProvider.user.id,
        "product_id":productId
      }),headers: <String, String> {
      "Content-Type":"application/json",
      "x-auth-token": userProvider.user.token
    });       

    httpErrorHandle(response: res, context: context, onSuccess:(){
      showSnackBar(context, "Set ratings success");
    });

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

}
