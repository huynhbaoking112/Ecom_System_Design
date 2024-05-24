import "dart:convert";

import "package:amazon_client/constants/error_handling.dart";
import "package:amazon_client/constants/utils.dart";
import "package:amazon_client/models/product.dart";
import "package:flutter/cupertino.dart";
import "package:http/http.dart" as http;

class SearchBar {
  static Future<List<Product>> searchProductBar(
      {required String searchKey, required BuildContext context}) async {
    List<Product> allProduct = [];
    try {

      http.Response res = await http.get(Uri.parse("http://localhost:8000/api/user/search/"+searchKey));

      httpErrorHandle(response: res, context: context, onSuccess: (){
        jsonDecode(res.body).forEach((e){
          allProduct.add(Product.fromJsonElastic(jsonEncode(e)));
        });
      });

    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return allProduct;
  }
}
