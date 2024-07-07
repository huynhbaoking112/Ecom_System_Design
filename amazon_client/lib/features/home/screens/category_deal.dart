import 'package:amazon_client/common/widgets/loader.dart';
import 'package:amazon_client/common/widgets/star_common.dart';
import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/features/home/service/home_services.dart';
import 'package:amazon_client/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryDeal extends StatefulWidget {
  static const String routeName = "/category";

  String category;
  CategoryDeal({super.key, required this.category});

  @override
  State<CategoryDeal> createState() => _CategoryDealState();
}

class _CategoryDealState extends State<CategoryDeal> {
  //Get home service handle api
  HomeService homeService = HomeService();

  //List product with category
  List<Product>? allProductWithCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  // Get Data with api
  void getData() async {
    allProductWithCategory = await homeService.getProductWithCateGory(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient),
              ),
              title: Container(
                  alignment: Alignment.center,
                  child: Text(
                    widget.category,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                  ))),
        ),
        body: allProductWithCategory == null
            ? Loader()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    //Keep shopping for applications
                    Text(
                      "Keep shopping for Appliances",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //show all Product
                    Expanded(
                      child: GridView.builder(
                        itemCount: allProductWithCategory!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          mainAxisExtent: 270,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 2, color: Colors.black12)),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, "/productscreen", arguments: allProductWithCategory![index]);
                                },
                                child: Column(
                                  children: [
                                    //Image product
                                    Container(
                                      height: 190,
                                      padding: EdgeInsets.all(8),
                                      child: Image.network(
                                        allProductWithCategory![index].images[0],
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                
                                    const SizedBox(
                                      height: 10,
                                    ),
                                
                                    //Name product and price
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Column(
                                        children: [
                                          //Name product
                                          Text(
                                            allProductWithCategory![index].name,
                                            style: TextStyle(fontSize: 16),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //Price
                                              Text(
                                                allProductWithCategory![index]
                                                    .price
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.orangeAccent,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                
                                              //Rating
                                              StarCustom(numStar: 4,)
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ));
  }
}
