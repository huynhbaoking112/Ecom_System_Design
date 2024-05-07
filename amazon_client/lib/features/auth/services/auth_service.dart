import 'package:amazon_client/constants/error_handling.dart';
import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/constants/utils.dart';
import 'package:amazon_client/models/user.dart';
import 'package:flutter/material.dart';
import  'package:http/http.dart' as http;    


class AuthService{

  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name
  }) async {
    try {
      User user = User(
        address: "",
        name: name,
        id: "",
        password: password,
        token: "",
        type: "",
        email: email
      );

        http.Response res = await http.post(Uri.parse('$uri/user/api/signup'), body: user.toJson(), headers: <String,String>{
        'Content-Type': 'application/json'
      });
      
      httpErrorHandle(response: res, context: context, onSuccess: (){
        showSnackBar(context, 'Account created!');
      });

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

}