import 'dart:developer';

import 'package:amazon_client/common/widgets/button_custom.dart';
import 'package:amazon_client/common/widgets/text_field.dart';
import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/constants/utils.dart';
import 'package:amazon_client/features/auth/services/auth_service.dart';
import 'package:amazon_client/features/auth/support/enum_welcome.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
    //AuthService
  final AuthService authService = AuthService();
  
  //Value
  late TypeWelcome chooseValue;


  //TextController
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  //GlobalKey  FormField
  final GlobalKey<FormState> keyField = GlobalKey<FormState>();

  //signup function
  void signUpUser(){
     authService.signUpUser(context: context, email: emailController.text, password: passwordController.text, name: usernameController.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chooseValue = TypeWelcome.CREATE;
  }

  //dispose Controller
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
          
                //Create Radio
                ListTile(
                  tileColor: chooseValue == TypeWelcome.CREATE? GlobalVariables.backgroundColor: GlobalVariables.greyBackgroundCOlor,
                  title: Text(
                    "Create Account",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    onChanged: (value) {
                      setState(() {
                        chooseValue = TypeWelcome.CREATE;
                        print(chooseValue);
                      });
                    },
                    groupValue: TypeWelcome.CREATE,
                    value: chooseValue,
                    activeColor: GlobalVariables.secondaryColor,
                  ),
                ),
          
                //Form Create
                chooseValue == TypeWelcome.CREATE
                    ? Form(
                        key: keyField,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: GlobalVariables.backgroundColor,
                          child: Column(
                            children: [
                              //usernameField
                              TextFieldCustom(
                                pass: false,
                                controllerText: usernameController,
                                hintText: "Name",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập username';
                                  }
                                  if (value.length < 6) {
                                    return 'Vui lòng nhập ít nhất 6 ký tự';
                                  }
                                  return null;
                                },
                              ),
          
                              const SizedBox(
                                height: 10,
                              ),
          
                              //Email Field
                              TextFieldCustom(
                                pass: false,
                                controllerText: emailController,
                                hintText: "Email",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập email';
                                  }
                                  return null;
                                },
                              ),
          
                              const SizedBox(
                                height: 10,
                              ),
          
                              //Password
                              TextFieldCustom(
                                pass: true,
                                controllerText: passwordController,
                                hintText: "Password",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập mật khẩu';
                                  }
                                   if (value.length < 6) {
                                    return 'Vui lòng nhập ít nhất 6 ký tự';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 10,),

                              //Button Sign Up
                              MyButtonCustom(text: "Sign up", onPressedButton: (){
                                if(keyField.currentState!.validate()){
                                  signUpUser();
                                }
                              },)

                            ],
                          ),
                        ),
                      )
                    :
          
                    //Form SignIn
          
                    Form(
                        key: keyField,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: GlobalVariables.backgroundColor,
                          child: Column(
                            children: [
                            
                              //Email Field
                              TextFieldCustom(
                                pass: false,
                                controllerText: emailController,
                                hintText: "Email",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập email';
                                  }
                                  return null;
                                },
                              ),
          
                              const SizedBox(
                                height: 10,
                              ),
          
                              //Password
                              TextFieldCustom(
                                pass: true,
                                controllerText: passwordController,
                                hintText: "Password",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập mật khẩu';
                                  }
                                   if (value.length < 6) {
                                    return 'Vui lòng nhập ít nhất 6 ký tự';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 10,),

                              //Button Sign Up
                              MyButtonCustom(text: "Sign up", onPressedButton: (){},)

                            ],
                          ),
                        ),
                      ),
          
                //SignIn Radio
                ListTile(
                  tileColor: chooseValue == TypeWelcome.SIGNIN? GlobalVariables.backgroundColor: GlobalVariables.greyBackgroundCOlor,
                  title: Text(
                    "Sign-In",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    onChanged: (value) {
                      setState(() {
                        chooseValue = TypeWelcome.SIGNIN;
                        print(chooseValue);
                      });
                    },
                    groupValue: TypeWelcome.SIGNIN,
                    value: chooseValue,
                    activeColor: GlobalVariables.secondaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
