import 'dart:convert';

import 'package:amazon_client/constants/error_handling.dart';
import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/constants/utils.dart';
import 'package:amazon_client/providers/cart_provider.dart';
import 'package:amazon_client/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';

class CartService {

   static inAndDeProduct(
      {required BuildContext context, required String productId, required String symbol}) async {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    try {
       //Lấy data
      http.Response res = await http.post(
          Uri.parse("$uri/api/user/increandecre/product"),
          body: jsonEncode({
            "productId":productId,
            "symbol":symbol
          })
          ,
          headers: <String, String>{
            'Content-Type': "application/json",
            'x-auth-token': userProvider.user.token
          });

      //Xử lí trả về
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            cartProvider.setCart(res.body);
          });

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static deleteProduct(
      {required BuildContext context, required String productId}) async {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    try {
       //Lấy data
      http.Response res = await http.post(
          Uri.parse("$uri/api/user/deletedusercart/product"),
          body: jsonEncode({
            "productId":productId
          })
          ,
          headers: <String, String>{
            'Content-Type': "application/json",
            'x-auth-token': userProvider.user.token
          });

      //Xử lí trả về
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            cartProvider.setCart(res.body);
            showSnackBar(context, "Product delete success");
          });

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get new infor of all product in cart
  static getInFor({required BuildContext context}) async {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    try {
      //Lấy data
      http.Response res = await http.get(
          Uri.parse("$uri/api/user/usercart/product"),
          headers: <String, String>{
            'Content-Type': "application/json",
            'x-auth-token': userProvider.user.token
          });

      //Xử lí trả về
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            cartProvider.setCart(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
