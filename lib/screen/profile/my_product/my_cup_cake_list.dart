import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:little_cake_story/model/product.dart';
import 'package:little_cake_story/model/user.dart';
import 'add_cup_cake_screen.dart';
import 'my_cup_cake_details.dart';

class MyCupCakeListScreen extends StatefulWidget {

  final User user;
  final ProductList productList;
  const MyCupCakeListScreen({Key key, this.user, this.productList}) : super(key: key);

  @override
  _MyCupCakeListScreenState createState() => _MyCupCakeListScreenState();
}

class _MyCupCakeListScreenState extends State<MyCupCakeListScreen> {

  List _productList;
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;
  String type = "CupCake";

  @override
  void initState() {

    super.initState();
    _loadMyCupCake();
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        title: Text('Cup Cakes',style: TextStyle(fontFamily: 'Arial')),
      ),
      body: Center(
        child: Column(
          children: [
            _productList == null 
            ? Flexible(
                child: Center(
                  child: Text(titleCenter)),
            )
            : Flexible(
                child: Center(
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
                                _cupCakeDetails(index);
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
                                        placeholder: (context, url) =>
                                          new Transform.scale(
                                            scale: 0.5,
                                            child:
                                              CircularProgressIndicator(color: Colors.red[200],)),
                                        errorWidget:
                                            (context, url, error) =>
                                                new Icon(
                                          Icons.broken_image,
                                          size: screenWidth / 3,))),
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
                                            ? "RM${_productList[index]['original_price']}"
                                            : "RM${_productList[index]['offered_price']}",
                                          style: TextStyle(fontSize:16,),),
                                        ),
                                        SizedBox(width:10),
                                        Text(_productList[index]['offered_price'] == "0"
                                            ? ""
                                            : "RM${_productList[index]['original_price']}",
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
              )
            )
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[200],
        onPressed: () {
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context)=>AddCupCakeScreen(user: widget.user,))
          );
        },
        child:Icon(Icons.add,
          color: Colors.white,
        )
      ),
    );
  }

  void _loadMyCupCake() {

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/load_other_product.php"),
      body: {
        "email":widget.user.email,
        "type":type,
        
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

  void _cupCakeDetails(int index) {
    print(_productList[index]['product_no']);
    ProductList productList = new ProductList(
      productNo: _productList[index]['product_no'],
      productName: _productList[index]['product_name'],
      oriPrice: _productList[index]['original_price'],
      offeredPrice: _productList[index]['offered_price'],
      rating: _productList[index]['rating'],
      details: _productList[index]['product_detail'],
    );

    Navigator.pushReplacement(
      context,MaterialPageRoute(builder: (context)=> MyCupCakeDetails(productList:productList,user: widget.user,))
    );
  }
}