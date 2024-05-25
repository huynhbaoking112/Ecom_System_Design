import 'dart:convert';

import 'package:amazon_client/constants/utils.dart';
import 'package:amazon_client/providers/user_provider.dart';
import 'package:flutter/material.dart';
import  'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';    



void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) async {
  switch(response.statusCode){
     case 201:
      onSuccess();
      break;
    case 200:
      onSuccess();
      break;
    case 404:
      showSnackBar(context, jsonDecode (response.body)['message']);
      break;
    case 400:
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("x-auth-token");
      Provider.of<UserProvider>(context, listen: false).resetUser();
      showSnackBar(context, jsonDecode (response.body)['message']);
      break;
    case 401:
      showSnackBar(context, jsonDecode (response.body)['message']);
      break;
    case 500:
      showSnackBar(context, jsonDecode (response.body)['message']);
      break;
    default:
      showSnackBar(context, jsonDecode (response.body)['message']);
      break;
  }
}