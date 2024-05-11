import 'dart:convert';

import 'package:amazon_client/constants/utils.dart';
import 'package:flutter/material.dart';
import  'package:http/http.dart' as http;    



void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}){
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