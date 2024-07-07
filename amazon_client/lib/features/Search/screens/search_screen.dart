import 'package:amazon_client/common/widgets/loader.dart';
import 'package:amazon_client/common/widgets/searchBar.dart';
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


  
  //--- Inifinite Scroll loading new Data

  //page search
  int page = 1;

  bool isLoading = false;

  bool fullData = false;

  ScrollController  _scrollController = ScrollController();
    
  getNewData() async {

    if(fullData){
      return;
    }

    setState(() {
      isLoading = true;
    });

     List<Product>? newData = await searchService.getProductWithSearchKey(searchKey: widget.searchKey, context: context, page: ++page);

     if(newData.isNotEmpty){
      allProduct?.addAll(newData);
     }
    
    setState(() {
      isLoading = false;
      fullData = newData.isEmpty;
    });

  }



//------------------------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataAfterSearch();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !isLoading){
        getNewData();
      }
    });
  }

  void getDataAfterSearch() async {
    allProduct = await searchService.getProductWithSearchKey(
        searchKey: widget.searchKey, context: context, page: page);
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: Column(
          children: [

            //Search Bar
            SearchBarTitle(),

            //Delivery to address location
            AddressLocation(),
      
            //AllProdcuct with key search
            allProduct==null ? Center(child: Loader())  :Expanded(
              child: Stack(
                children: [
                  GridView.builder(
                controller: _scrollController,
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
                  if(isLoading)...[
                    Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                  ]
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
