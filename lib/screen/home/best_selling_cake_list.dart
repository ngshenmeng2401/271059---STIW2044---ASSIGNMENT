import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:little_cake_story/model/best_selling_product.dart';
import 'package:little_cake_story/model/product.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/home/text_1.dart';

// List<BestSellingProduct> productList =[
//   BestSellingProduct(code:"CKRV01",name:"Chinese Birthday Cake",image: "assets/images/product1.jpg",rating: 4.5,oldprice: 119,newprice: 89),
//   BestSellingProduct(code:"CKRV02",name:"Birthday Cake 1",image: "assets/images/product2.jpg",rating: 4.5,oldprice: 109,newprice: 89),
//   BestSellingProduct(code:"CKRV03",name:"Birthday Cake 2",image: "assets/images/product3.jpg",rating: 4.5,oldprice: 129,newprice: 99),
//   BestSellingProduct(code:"CKRV04",name:"Birthday Cake 3",image: "assets/images/product4.jpg",rating: 4.5,oldprice: 139,newprice: 99),
//   BestSellingProduct(code:"CKRV05",name:"Happy Mother Day Cake",image: "assets/images/product5.jpg",rating: 4.5,oldprice: 119,newprice: 89),
// ];

class BestSellingCakeList extends StatelessWidget {

  final User user;
  final ProductList productList;
  const BestSellingCakeList({Key key, this.user, this.productList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double screenHeight,screenWidth;
    List _productList;
    String titleCenter = "Loading...";
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Container(
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
                        // Navigator.push(
                        //   context,MaterialPageRoute(builder: (context)=>ProductDetailsScreen()
                        //   )
                        // );
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
    );
  }
}