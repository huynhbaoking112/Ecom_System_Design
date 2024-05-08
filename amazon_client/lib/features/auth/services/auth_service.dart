import 'dart:convert';
import 'dart:io';

import 'package:amazon_client/constants/error_handling.dart';
import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/constants/utils.dart';
import 'package:amazon_client/features/home/screens/home_screen.dart';
import 'package:amazon_client/models/user.dart';
import 'package:amazon_client/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signInUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/user/api/signin'),
          body: json.encode({'email': email, 'password': password}),
          headers: <String, String>{'Content-Type': 'application/json'});

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', json.decode(res.body)['token']);
            Navigator.pushNamed(context, HomePage.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  void getUserData({
    required BuildContext context
  }) async {
    try {
      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = await prefs.getString("x-auth-token");

      if(token == null){
          return;
      }

      http.Response res = await http.get(Uri.parse('$uri/user/api/getInforWithToken'), headers: <String, String>{
        'Content-Type':"application/json",
        "x-auth-token" : token 
      }); 

      httpErrorHandle(response: res, context: context, onSuccess: () async {
        Provider.of<UserProvider>(context, listen: false).setUser(res.body);
        Navigator.pushNamed(context, HomePage.routeName);
      });

    } catch (e) {
      showSnackBar(context, e.toString());
    }

  }


  



  void signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    try {
      User user = User(
          address: "",
          name: name,
          id: "",
          password: password,
          token: "",
          type: "",
          email: email);

      http.Response res = await http.post(Uri.parse('$uri/user/api/signup'),
          body: user.toJson(),
          headers: <String, String>{'Content-Type': 'application/json'});

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Account created!');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
