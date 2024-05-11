import 'package:amazon_client/common/widgets/loader.dart';
import 'package:amazon_client/features/Admin/screens/add_product_screen.dart';
import 'package:amazon_client/features/Admin/services/admin_service.dart';
import 'package:amazon_client/features/account/widgets/single_product.dart';
import 'package:amazon_client/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  //Admin service
  AdminServices adminServices = AdminServices();

  //list my product
  List<Product>? allProduct;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProduct();
  }

  //get all product
  void getAllProduct() async {
    allProduct = await adminServices.getAllProduct(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return allProduct == null
        ? Loader()
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Container(
              width: 65,
              height: 65,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddProductScreen.routeName);
                },
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
                backgroundColor: Colors.teal[300],
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                tooltip: 'Add a Product',
              ),
            ),
            body: Container(
              padding: EdgeInsets.only(top: 20, bottom: 40, left: 5, right: 5),
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: allProduct!.length,
                // padding: EdgeInsets.all(5),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10, left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Image product
                          Container(
                              child: SingleProduct(
                                  url: allProduct![index].images[0])),

                          const SizedBox(
                            height: 3,
                          ),

                          //Name and button delete
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(
                                    allProduct![index].name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
