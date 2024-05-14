import 'dart:convert';

import 'package:amazon_client/constants/error_handling.dart';
import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/constants/utils.dart';
import 'package:amazon_client/models/product.dart';
import 'package:amazon_client/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeService {
  Future<List<Product>> getProductWithCateGory(
      {required BuildContext context, required String category}) async {
    UserProvider userProvider = Provider.of(context, listen: false);
    List<Product> allProduct = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/user/product?category=$category'), headers: {
        'Content-Type': "application/json",
        "x-auth-token" : userProvider.user.token 
      });

      //Xử lí lỗi
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            jsonDecode(res.body).forEach(
                (e) => allProduct.add(Product.fromJson(jsonEncode(e))));
            showSnackBar(context, "Alll product with category: $category");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return allProduct;
  }
}
