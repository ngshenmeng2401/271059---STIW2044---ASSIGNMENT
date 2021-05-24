import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:little_cake_story/model/product.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/cart/cart_screen.dart';
import 'package:http/http.dart' as http;
import 'package:little_cake_story/screen/search/product_details.dart';

class SearchScreen extends StatefulWidget {

  final User user;
  final ProductList productList;
  const SearchScreen({Key key,this.user, this.productList}):super(key: key);
  
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List _productList;
  String titleCenter = "Loading...",searchText="Search", cartQuantity ="0", searchProduct;
  double screenHeight, screenWidth;
  bool selected_slice, selected_6inch, selected_8inch, selected_10inch, selected_12inch;
  TextEditingController _searchController = new TextEditingController();
  int sortButton=1;

  @override
  void initState() {

    super.initState();
    _loadProduct();
    _loadCartQuantity();
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        title: Text('LITTLE CAKE STORY',style: TextStyle(fontFamily: 'Arial'),),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
            child: Container(
              width: 30,
              height: 10,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>CartScreen(user: widget.user,))
                  );
                },
                child: Stack(
                  children:<Widget> [
                    Icon(Icons.shopping_cart_outlined,
                      size: 28,
                      color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,),
                          color: Colors.red[300],
                          shape: BoxShape.circle),
                        child: Text(widget.user.qty,
                          style: TextStyle(fontSize: 12,color:Theme.of(context).bottomNavigationBarTheme.unselectedItemColor),
                          textAlign: TextAlign.center,)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child:Column(
          children:[
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.search,color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,),
                onPressed: (){
                  
                },
              ),
              title: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                hintText: "Search",hintStyle:TextStyle(fontSize:18,fontFamily: 'Calibri'),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: (){
                  _searchProduct(_searchController.text.toString());
                  // _searchController.clear();
                },
              ),
            ),
            _productList == null 
            ? Flexible(
                child: Center(
                  child: Text(titleCenter)),
            )
            : Flexible(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: GridView.builder(
                            itemCount: _productList.length,
                            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: (screenWidth / screenHeight) /0.9),
                              itemBuilder: (BuildContext context, int index){
                                return Card(
                                  child: InkWell(
                                    onTap: (){
                                      _cakeDetails(index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).hoverColor,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            color:Colors.grey[600],
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(1, 1),
                                          ),
                                        ]
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:BorderRadius.only(
                                            topLeft:Radius.circular(10),
                                            topRight:Radius.circular(10),),
                                            child: CachedNetworkImage(
                                              imageUrl: "https://javathree99.com/s271059/littlecakestory/images/product/${_productList[index]['product_no']}.png",
                                              height: 185,
                                              width: 185,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                new Transform.scale(
                                                  scale: 0.5,
                                                  child:
                                                    CircularProgressIndicator(color: Colors.red[200],)),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      new Icon(
                                                Icons.broken_image,
                                                size: screenWidth / 3,)
                                              ),
                                          ),
                                          Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                                          child: Text(_productList[index]['product_name'],
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context).appBarTheme.textTheme.headline2),
                                          ), 
                                          SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                child: Text(_productList[index]['offered_price'] == "0" 
                                                ? "RM ${_productList[index]['original_price']}"
                                                : "RM ${_productList[index]['offered_price']}",
                                                style: TextStyle(fontSize:16,),),
                                              ),
                                              SizedBox(width:10),
                                              Text(_productList[index]['offered_price'] == "0" 
                                                ? ""
                                                : "RM ${_productList[index]['original_price']}",
                                                style: Theme.of(context).appBarTheme.textTheme.headline3,)
                                            ],),
                                          SizedBox(height:6),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                child: Text(_productList[index]['rating'],
                                                style: TextStyle(fontSize:12,color: Colors.orange),),
                                              ),
                                              SizedBox(width: 5),
                                              Icon(Icons.star,size: 16,color: Colors.orange),
                                              Icon(Icons.star,size: 16,color: Colors.orange),
                                              Icon(Icons.star,size: 16,color: Colors.orange),
                                              Icon(Icons.star,size: 16,color: Colors.orange),
                                              Icon(Icons.star_half,size: 16,color: Colors.orange),
                                            ],
                                          ),                                 
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            )
          ]
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red[200],
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context)=>CartScreen(user: widget.user,))
          );
        },
        icon:Icon(Icons.shopping_cart,
          color: Colors.white,),
        label: Text(widget.user.qty,
          style: TextStyle(color:Colors.white,fontFamily: 'Calibri',fontSize: 16),),
      ),
    );
  }

  void _loadProduct() {


    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/load_product.php"),
      body: {
        "email":widget.user.email,

      }).then(
        (response){
          if(response.body == "nodata"){
            titleCenter = "No data";
            cartQuantity="0";
            return;
          }else{
            titleCenter = "Contain Data";
            setState(() {
              var jsondata = json.decode(response.body);
              _productList = jsondata["product"];
              cartQuantity = widget.user.qty;
            });
            print(_productList);
          }
      }
    );
  }

  void _searchProduct(String searchProduct){

    print(searchProduct);

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/load_product.php"),
      body: {
        "email":widget.user.email,
        "name":searchProduct,

      }).then(
        (response){
          if(response.body == "nodata"){
            titleCenter = "No data";
            cartQuantity="0";
            return;
          }else{
            titleCenter = "Contain Data";
            setState(() {
              var jsondata = json.decode(response.body);
              _productList = jsondata["product"];
              cartQuantity = widget.user.qty;
            });
            FocusScope.of(context).requestFocus(new FocusNode());
            print(_productList);
          }
      }
    );

  }

  void _loadCartQuantity(){

  http.post(
    Uri.parse("https://javathree99.com/s271059/littlecakestory/php/load_cart_quantity.php"),
    body: {
      "email":widget.user.email,
    }).then(
      (response){
        print(response.body);

        if(response.body=="nodata"){
        }
        else {
          widget.user.qty = response.body;
        }
      }
    );
  }

  void _cakeDetails(int index) {

    _productList[index]['slice']=="true" 
      ? selected_slice=true
      : selected_slice=false;

    _productList[index]['size6_inch']=="true" 
      ? selected_6inch=true
      : selected_6inch=false;
    
    _productList[index]['size8_inch']=="true" 
      ? selected_8inch=true
      : selected_8inch=false;

    _productList[index]['size10_inch']=="true" 
      ? selected_10inch=true
      : selected_10inch=false;

    _productList[index]['size12_inch']=="true" 
      ? selected_12inch=true
      : selected_12inch=false;
    
    print(selected_12inch);

    print(_productList[index]['product_no']);
    ProductList productList = new ProductList(
      productNo: _productList[index]['product_no'],
      productName: _productList[index]['product_name'],
      oriPrice: _productList[index]['original_price'],
      offeredPrice: _productList[index]['offered_price'],
      rating: _productList[index]['rating'],
      details: _productList[index]['product_detail'],
      slice: selected_slice,
      inch_6: selected_6inch,
      inch_8: selected_8inch,
      inch_10: selected_10inch,
      type: _productList[index]['type'],
    );

    Navigator.push(
      context,MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productList: productList,user: widget.user,))
    );
  }

}