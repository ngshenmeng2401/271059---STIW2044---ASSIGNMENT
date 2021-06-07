import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:little_cake_story/model/product.dart';
import 'package:little_cake_story/screen/cart/cart_screen.dart';
import 'caterogries/cake_details.dart';
import 'product.dart';
import 'package:little_cake_story/model/user.dart';
import 'caterogries/category_list.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {

  final User user;
  final ProductList productList;
  const HomeScreen({Key key,this.user, this.productList}):super(key: key);
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
  double screenHeight,screenWidth;
  List _productList;
  String titleCenter = "Loading...";
  bool selected_slice, selected_6inch, selected_8inch, selected_10inch, selected_12inch;

  @override
  void initState() {
    super.initState();
    _loadCartQuantity();
    _loadBestSellingCake();
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
            padding: const EdgeInsets.fromLTRB(0, 15, 5, 0),
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
      body:SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget> [
              Container(
                height: 200,
                child: new Carousel(
                  boxFit: BoxFit.cover,
                  images: [
                    Image.asset('assets/images/little_cake_story.png'),
                    Image.asset('assets/images/happy_mother_day.png'),
                    Image.asset('assets/images/happy_father_day.png'),
                    Image.asset('assets/images/bento_cake_series.png'),
                  ],
                  autoplay: true,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds:1000),
                  dotColor: Colors.white,
                  dotIncreasedColor: Theme.of(context).accentColor,
                  dotSize: 7,
                  indicatorBgPadding: 2, 
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15,20,0,10),
                child: Text('Categories',style: Theme.of(context).textTheme.bodyText1,)
              ),
              CategoryList(user: widget.user,),
              Container(
                margin: const EdgeInsets.fromLTRB(15,20,0,10),
                child: Text('Best Selling Cakes',style: Theme.of(context).textTheme.bodyText1,)
              ),
              Container(
                height: screenHeight/2.6,
                child: Column(
                  children: [
                    _productList == null
                    ? Flexible(
                      child: Center(
                        child: Text(titleCenter)))
                    : Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _productList.length,
                        itemBuilder: (_,index){
                          return Padding(
                          padding: const EdgeInsets.all(10),
                            child: Hero(
                              tag:_productList[index]['product_no'],
                              child: InkWell(
                                onTap: (){
                                  _cakeDetails(index);
                                },
                                child: Container(
                                  height: screenHeight/2.6,
                                  width: screenWidth/2.74,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).hoverColor,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color:Colors.grey[600],
                                        spreadRadius: 1,
                                        blurRadius: 6,
                                        offset: Offset(1, 1),
                                      ),
                                    ]
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius:BorderRadius.only(
                                        topLeft:Radius.circular(5),
                                        topRight:Radius.circular(5),),
                                        child: CachedNetworkImage(
                                          imageUrl: "https://javathree99.com/s271059/littlecakestory/images/product/${_productList[index]['product_no']}.png",
                                          height: 150,width: 150,)), 
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
                            ),
                          );
                      }),
                    ),
                  ]
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15,20,0,10),
                child: Text('Best Selling Cakes',style: Theme.of(context).textTheme.bodyText1,)
              ),
              // Container(
              //   height: screenHeight/2.6,
              //   child: Column(
              //     children: [
              //       _productList == null
              //       ? Flexible(
              //         child: Center(
              //           child: Text(titleCenter)))
              //       : Flexible(
              //         child: ListView.builder(
              //           scrollDirection: Axis.horizontal,
              //           itemCount: _productList.length,
              //           itemBuilder: (_,index){
              //             return Padding(
              //             padding: const EdgeInsets.all(10),
              //               child: Hero(
              //                 tag:_productList[index]['product_no'],
              //                 child: InkWell(
              //                   onTap: (){
              //                     // Navigator.push(
              //                     //   context,MaterialPageRoute(builder: (context)=>ProductDetailsScreen()
              //                     //   )
              //                     // );
              //                   },
              //                   child: Container(
              //                     height: screenHeight/2.6,
              //                     width: screenWidth/2.74,
              //                     decoration: BoxDecoration(
              //                       color: Theme.of(context).hoverColor,
              //                       borderRadius: BorderRadius.circular(5),
              //                       boxShadow: [
              //                         BoxShadow(
              //                           color:Colors.grey[600],
              //                           spreadRadius: 1,
              //                           blurRadius: 6,
              //                           offset: Offset(1, 1),
              //                         ),
              //                       ]
              //                     ),
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: <Widget>[
              //                         ClipRRect(
              //                           borderRadius:BorderRadius.only(
              //                           topLeft:Radius.circular(5),
              //                           topRight:Radius.circular(5),),
              //                           child: CachedNetworkImage(
              //                             imageUrl: "https://javathree99.com/s271059/littlecakestory/images/product/${_productList[index]['product_no']}.png",
              //                             height: 150,width: 150,)), 
              //                         Padding(
              //                           padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
              //                           child: Text(_productList[index]['product_name'],
              //                               overflow: TextOverflow.ellipsis,
              //                               textAlign: TextAlign.left,
              //                               style: Theme.of(context).appBarTheme.textTheme.headline2),
              //                         ),
              //                         SizedBox(height: 6),
              //                         Row(
              //                           children: [
              //                             Padding(
              //                               padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              //                               child: Text(_productList[index]['offered_price'] == "0" 
              //                                 ? "RM ${_productList[index]['original_price']}"
              //                                 : "RM ${_productList[index]['offered_price']}",
              //                               style: TextStyle(fontSize:16,),),
              //                             ),
              //                             SizedBox(width:10),
              //                             Text(_productList[index]['offered_price'] == "0" 
              //                               ? ""
              //                               : "RM ${_productList[index]['original_price']}",
              //                               style: Theme.of(context).appBarTheme.textTheme.headline3,)
              //                           ],),
              //                         SizedBox(height:6),
              //                         Row(
              //                           children: [
              //                             Padding(
              //                               padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              //                               child: Text(_productList[index]['rating'],
              //                               style: TextStyle(fontSize:12,color: Colors.orange),),
              //                             ),
              //                             SizedBox(width: 5),
              //                             Icon(Icons.star,size: 16,color: Colors.orange),
              //                             Icon(Icons.star,size: 16,color: Colors.orange),
              //                             Icon(Icons.star,size: 16,color: Colors.orange),
              //                             Icon(Icons.star,size: 16,color: Colors.orange),
              //                             Icon(Icons.star_half,size: 16,color: Colors.orange),
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             );
              //         }),
              //       ),
              //     ]
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.fromLTRB(15,20,0,10),
                child: Text('New Products',style: Theme.of(context).textTheme.bodyText1,)
              ),
              Container(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Product()),
              ),
              
            ],
          ),
        ),
      )
    );
  }

  void _loadBestSellingCake(){

    print(widget.user.email);

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/load_best_selling_product.php"),
      body: {
        "email":widget.user.email,
      }).then(
        (response){
          if(response.body == "nodata"){
            titleCenter = "No data";
            return;
          }else{
            var jsondata = json.decode(response.body);
            _productList = jsondata["product"];
            titleCenter = "Contain Data";
            setState(() {});
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
    );

    Navigator.push(
      context,MaterialPageRoute(builder: (context)=> CakeDetailsScreen(productList:productList,user: widget.user,))
    );
  }
}

