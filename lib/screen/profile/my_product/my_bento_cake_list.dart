import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:little_cake_story/model/bento_cake.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/profile/my_product/my_bento_cake_details.dart';
import 'add_bento_cake_screen.dart';

class MyBentoCakeListScreen extends StatefulWidget {

  final BentoCakeList bentoCakeList;
  final User user;
  const MyBentoCakeListScreen({Key key,this.user, this.bentoCakeList}):super(key: key);

  @override
  _MyBentoCakeListScreenState createState() => _MyBentoCakeListScreenState();
}

class _MyBentoCakeListScreenState extends State<MyBentoCakeListScreen> {

  List _bentoCakeList;
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;

  @override
  void initState() {

    super.initState();
    _loadMyBentoCake();
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        title: Text('Bento Cakes',style: TextStyle(fontFamily: 'Arial')),
        actions: [
          IconButton(
              icon: Icon(Icons.add), 
              color: Colors.white,
              onPressed: (){
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context)=>AddBentoCakeScreen(user: widget.user,))
                );
          }),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            _bentoCakeList == null 
            ? Flexible(
                child: Center(
                  child: Text(titleCenter)),
            )
            : Flexible(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: GridView.builder(
                      itemCount: _bentoCakeList.length,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: (screenWidth / screenHeight) /0.9),
                        itemBuilder: (BuildContext context, int index){
                          return Card(
                            child: InkWell(
                              onTap: (){
                                _bentoCakeDetails(index);
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
                                        imageUrl: "https://javathree99.com/s271059/littlecakestory/images/product_bento_cake/${_bentoCakeList[index]['bento_cake_no']}.png",
                                        height: 185,
                                        width: 185,)),
                                    Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                                    child: Text(_bentoCakeList[index]['bento_cake_name'],
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context).appBarTheme.textTheme.headline2),
                                    ), 
                                    SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          child: Text(_bentoCakeList[index]['offered_price'] =="0"
                                            ? "RM${_bentoCakeList[index]['original_price']}"
                                            : "RM${_bentoCakeList[index]['offered_price']}",
                                          style: TextStyle(fontSize:16,),),
                                        ),
                                        SizedBox(width:10),
                                        Text(_bentoCakeList[index]['offered_price'] =="0"
                                            ? ""
                                            : "RM${_bentoCakeList[index]['original_price']}",
                                          style: Theme.of(context).appBarTheme.textTheme.headline3,)
                                      ],),
                                    SizedBox(height:6),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          child: Text(_bentoCakeList[index]['rating'],
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
    );
  }

  void _loadMyBentoCake() {

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/load_my_bento_cake.php"),
      body: {
        "email":widget.user.email,
      }).then(
        (response){
          if(response.body == "nodata"){
            titleCenter = "No data";
            return;
          }else{
            var jsondata = json.decode(response.body);
            _bentoCakeList = jsondata["bentocake"];
            titleCenter = "Contain Data";
            setState(() {});
            print(_bentoCakeList);
          }
      }
    );
  }

  void _bentoCakeDetails(int index) {
    print(_bentoCakeList[index]['bento_cake_no']);
    BentoCakeList bentoCakeList = new BentoCakeList(
      bentoCakeNo: _bentoCakeList[index]['bento_cake_no'],
      bentoCakeName: _bentoCakeList[index]['bento_cake_name'],
      oriPrice: _bentoCakeList[index]['original_price'],
      offeredPrice: _bentoCakeList[index]['offered_price'],
      rating: _bentoCakeList[index]['rating'],
      details: _bentoCakeList[index]['bento_cake_detail'],
    );

    Navigator.pushReplacement(
      context,MaterialPageRoute(builder: (context)=> MyBentoCakeDetails(bentocakeList:bentoCakeList,user: widget.user,))
    );
  }
}