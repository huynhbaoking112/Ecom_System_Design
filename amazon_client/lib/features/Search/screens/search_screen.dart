import 'package:amazon_client/common/widgets/loader.dart';
import 'package:amazon_client/common/widgets/star_common.dart';
import 'package:amazon_client/constants/global_variables.dart';
import 'package:amazon_client/features/Search/services/search_service.dart';
import 'package:amazon_client/features/home/widgets/address_location.dart';
import 'package:amazon_client/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search-product";

  String searchKey;

  SearchScreen({super.key, required this.searchKey});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //Search Controller
  TextEditingController searchController = TextEditingController();

  //All product
  List<Product>? allProduct;

  //Service
  SearchService searchService = SearchService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataAfterSearch();
  }

  void getDataAfterSearch() async {
    allProduct = await searchService.getProductWithSearchKey(
        searchKey: widget.searchKey, context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Search Bar
              Expanded(
                child: Container(
                  height: 42,
                  margin: EdgeInsets.only(left: 15),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(7),
                    //Search
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {
                            if (searchController.text.isNotEmpty) {
                              Navigator.pushNamed(
                                  context, SearchScreen.routeName,
                                  arguments: searchController.text);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.only(top: 10),
                        hintText: "Search Amazon.in",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 1)),
                      ),
                    ),
                  ),
                ),
              ),

              //Icon Mic
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.mic,
                  size: 28,
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          //Delivery to address location
          AddressLocation(),

          //AllProdcuct with key search
          allProduct==null ? Loader()  :Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 150,
                    mainAxisSpacing: 10,
                    crossAxisCount: 1),
                itemCount: allProduct!.length,
                itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, "/productscreen", arguments: allProduct![index]);
                      },
                      child: Row(
                        children: [
                          
                          //Image
                          Container(
                            height: double.infinity,
                            child: Image.network(allProduct![index].images[0], width: 150, fit: BoxFit.fitHeight,),
                          ),
                      
                          const SizedBox(width: 15,),
                      
                          //Infor
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                      
                              //Name
                              Text(allProduct![index].name,style: TextStyle(fontSize: 20) , maxLines: 2, overflow: TextOverflow.ellipsis),
                              
                              const SizedBox(height: 5,),
                      
                              //star
                              StarCustom(numStar: 4),
                      
                              const SizedBox(height: 5,),
                              //price
                              Text("\$${allProduct![index].price}", style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20
                              ),),
                              
                              const SizedBox(height: 5,),
                      
                              //Eligble for FREE Shipping
                              Text("Eligible for FREE Shipping"),
                              
                              //In stock
                              Text("In stock", style: TextStyle(color: Colors.blue.shade700),)
                            ],
                          )
                      
                        ],
                      ),
                    ),
                  );
                },),
          )
        ],
      ),
    );
  }
}
