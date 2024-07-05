import 'package:amazon_client/providers/cart_provider.dart';
import 'package:amazon_client/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';






class AccountService{

static void signOutUser({required BuildContext context}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('x-auth-token');
  Provider.of<UserProvider>(context, listen: false).resetUser();
  Provider.of<CartProvider>(context, listen: false).resetCart();
}



}