import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:little_cake_story/model/product.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/cart/cart_screen.dart';

import 'tart_details.dart';

class TartListScreen extends StatefulWidget {

  final User user;
  final ProductList productList;
  const TartListScreen({Key key, this.user, this.productList}) : super(key: key);

  @override
  _TartListScreenState createState() => _TartListScreenState();
}

class _TartListScreenState extends State<TartListScreen> {

  List _productList;
  String titleCenter = "Loading...",searchText="Search";
  double screenHeight, screenWidth;
  int sortButton=1;
  String type = "Tart";

  @override
  void initState() {

    super.initState();
    _loadTart();
    _loadCartQuantity();
  }
  
  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        title: Text('Tarts',style: TextStyle(fontFamily: 'Arial')),
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
        ),
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

  void _loadTart() {

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

    print(_productList[index]['product_no']);
    ProductList productList = new ProductList(
      productNo: _productList[index]['product_no'],
      productName: _productList[index]['product_name'],
      oriPrice: _productList[index]['original_price'],
      offeredPrice: _productList[index]['offered_price'],
      rating: _productList[index]['rating'],
      details: _productList[index]['product_detail'],
      type: _productList[index]['type'],
    );
    Navigator.push(
      context,MaterialPageRoute(builder: (context)=> TartDetailsScreen(productList:productList,user: widget.user,))
    );
  }

  Future<void> _sortCakeDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context,setState){
            return AlertDialog(
              title: Text('Sort By',
                  style: Theme.of(context).textTheme.headline6),
              content: new Container(
                height: screenHeight/4,
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Default",style: TextStyle(fontFamily: 'Calibri',)),
                      trailing: Radio(
                        activeColor: Colors.red[200],
                        value: 1,
                        groupValue: sortButton,
                        onChanged: (value){
                          setState((){
                            sortButton = value;
                            print(sortButton);
                          });
                        },
                      )
                    ),
                    ListTile(
                      title: Text("Price: Low to High",style: TextStyle(fontFamily: 'Calibri',)),
                      trailing: Radio(
                        activeColor: Colors.red[200],
                        value: 2,
                        groupValue: sortButton,
                        onChanged: (value){
                          setState((){
                            sortButton = value;
                            print(sortButton);
                          });
                        },
                      )
                    ),
                    ListTile(
                      title: Text("Price: High to Low",style: TextStyle(fontFamily: 'Calibri',)),
                      trailing: Radio(
                        activeColor: Colors.red[200],
                        value: 3,
                        groupValue: sortButton,
                        onChanged: (value){
                          setState((){
                            sortButton = value;
                            print(sortButton);
                          });
                        },
                      )
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: (Text('OK',
                      style: Theme.of(context).textTheme.bodyText2)),
                  onPressed: () {
                    _sortTartPrice(sortButton,);
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: (Text('Cancel',
                      style: Theme.of(context).textTheme.bodyText2)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        });
  }

  void _sortTartPrice(int sortButton) {

    print(sortButton);

    if(sortButton == 1){
      _loadTart();
    }
    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/sort_other_product_price.php"),
      body: {
        "email":widget.user.email,
        "sort_value":sortButton.toString(),
        "type":type,
        
      }).then(
        (response){
          setState(() {
            var jsondata = json.decode(response.body);
            _productList = jsondata["product"];
            FocusScope.of(context).requestFocus(new FocusNode());
          });
      }
    );
  }
  
}