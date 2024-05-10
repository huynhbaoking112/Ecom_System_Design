import 'dart:io';

import 'package:amazon_client/common/widgets/button_custom.dart';
import 'package:amazon_client/common/widgets/text_field.dart';
import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/constants/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  //product
  TextEditingController productController = TextEditingController();

  //price
  TextEditingController descriptionController = TextEditingController();

  //des
  TextEditingController priceController = TextEditingController();

  //quantity
  TextEditingController quantityController = TextEditingController();

  //ListDropDown
  List<String> allCategory = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion",
  ];

  //value dropdown
  String valueChoose = "Mobiles";

  //dispose
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  //ChooseImageFiles
  List<File> allFileChoose = [];

  void chooseFile() async {
    List<File> res = await pickImages();
    setState(() {
      allFileChoose = res;
    });
  }

  void deleteChooseImage(int index){
   setState(() {
      allFileChoose.removeAt(index);
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Container(
                alignment: Alignment.center,
                child: Text(
                  "Add Product",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                ))),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),

                //Select Product Image
                //Nếu list chứa hình ảnh
                allFileChoose.isNotEmpty
                    ? DottedBorder(
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        radius: Radius.circular(10),
                        dashPattern: [10, 4],
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: 160,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: allFileChoose.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  //Image choose
                                  Image.file(
                                    File(allFileChoose[index].path),
                                    height: 150,
                                    width: 120,
                                    fit: BoxFit.fitHeight,
                                  ),

                                  //deleteChoose
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap:() => deleteChooseImage(index),
                                      child: Icon(Icons.cancel)),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    //Nếu list không chứa hình ảnh
                    : GestureDetector(
                        onTap: chooseFile,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          strokeCap: StrokeCap.round,
                          radius: Radius.circular(10),
                          dashPattern: [10, 4],
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Icon Folder
                                Icon(
                                  Icons.folder_copy_outlined,
                                  size: 40,
                                ),

                                const SizedBox(
                                  height: 10,
                                ),

                                //Text Select Product Image
                                Text(
                                  "Select Product Images",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                const SizedBox(
                  height: 10,
                ),

                //product name
                TextFieldCustom(
                    controllerText: productController,
                    hintText: 'Product Name',
                    pass: false,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Vui lòng nhập Product Name';
                      }
                      return null;
                    }),

                const SizedBox(
                  height: 10,
                ),

                //description field
                TextFieldCustom(
                  controllerText: productController,
                  hintText: 'Description',
                  pass: false,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Vui lòng nhập Description';
                    }
                    return null;
                  },
                  maxLines: 7,
                ),

                const SizedBox(
                  height: 10,
                ),

                //Price field
                TextFieldCustom(
                    controllerText: productController,
                    hintText: 'Price',
                    pass: false,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Vui lòng nhập Price';
                      }
                      if (double.tryParse(val) == null) {
                        return 'Price phải là một số';
                      }
                      return null;
                    }),

                const SizedBox(
                  height: 10,
                ),

                //Quantity field
                TextFieldCustom(
                    controllerText: productController,
                    hintText: 'Quantity',
                    pass: false,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Vui lòng nhập Quantity';
                      }
                      if (int.tryParse(val) == null) {
                        return 'Quantity phải là số nguyên';
                      }
                      return null;
                    }),

                const SizedBox(
                  height: 10,
                ),

                //Dropdown
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(width: 1, color: Colors.grey.shade800)),
                  child: DropdownButton(
                      value: valueChoose,
                      items: allCategory.map((e) {
                        return DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400),
                            ));
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          valueChoose = newVal!;
                        });
                      }),
                ),

                const SizedBox(
                  height: 10,
                ),

                //Button
                MyButtonCustom(text: "Shell", onPressedButton: () {}),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
