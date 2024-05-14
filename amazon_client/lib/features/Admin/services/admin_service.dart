import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:amazon_client/constants/error_handling.dart';
import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/constants/utils.dart';
import 'package:amazon_client/features/Admin/screens/add_product_screen.dart';
import 'package:amazon_client/features/Admin/screens/admin_screen.dart';
import 'package:amazon_client/models/product.dart';
import 'package:amazon_client/models/user.dart';
import 'package:amazon_client/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminServices {

  //Sell Product
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary =
          CloudinaryPublic('duv6xglto', 'uiia2tcr', cache: false);
      List<String> imageUrls = [];

      List<CloudinaryResponse> uploadedImages = await cloudinary.multiUpload(
        images.map((image) async {
          return await CloudinaryFile.fromFile(image.path, folder: name);
        }).toList(),
      );

      imageUrls = uploadedImages.map((e) => e.secureUrl).toList();

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);

      http.Response res = await http.post(
          Uri.parse('$uri/api/admin/add-product'),
          body: product.toJson(),
          headers: <String, String>{
            'Content-Type': "application/json",
            "x-auth-token": userProvider.user.token
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product Added Successfully');
            Navigator.pushNamed(context, AdminScreen.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<ByteData> convertByteData(File file) async {
    Uint8List bytes = await file.readAsBytesSync();
    ByteData byteData = await ByteData.view(bytes.buffer);
    return byteData;
  }


  //Get all product
  Future<List<Product>> getAllProduct({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> allProduct = [];

    try {
    
      http.Response res = await http.get(
          Uri.parse('$uri/api/admin/get-product'),
          headers: <String, String>{
            'Content-Type': "application/json",
            "x-auth-token": userProvider.user.token
          });


     httpErrorHandle(response: res, context: context, onSuccess: (){
      for(int i = 0; i < jsonDecode(res.body).length; i++){
        allProduct.add( Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
      }
    });

    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return allProduct;
  }


  //Delete product
  void deleteProduct({
    required BuildContext context,
    required Product product,
    required Function onSuccess
  }) async {
    try {
      UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(Uri.parse("$uri/api/admin/get-product"), body: jsonEncode({"id": product.id}), headers: <String, String>{
        'Content-Type':"application/json",
        "x-auth-token": userProvider.user.token
      });

      httpErrorHandle(response: res, context: context, onSuccess: (){
        onSuccess();
      });

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }




}
