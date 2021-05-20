import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:little_cake_story/model/tart.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/profile/my_product/my_tart_details.dart';
import 'add_tart_screen.dart';

class MyTartsListScreen extends StatefulWidget {

  final User user;
  final TartList tartList;
  const MyTartsListScreen({Key key, this.user, this.tartList}) : super(key: key);

  @override
  _MyTartsListScreenState createState() => _MyTartsListScreenState();
}

class _MyTartsListScreenState extends State<MyTartsListScreen> {

  List _tartList;
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;

  @override
  void initState() {

    super.initState();
    _loadMyTarts();
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
            _tartList == null 
            ? Flexible(
                child: Center(
                  child: Text(titleCenter)),
            )
            : Flexible(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: GridView.builder(
                      itemCount: _tartList.length,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: (screenWidth / screenHeight) /0.9),
                        itemBuilder: (BuildContext context, int index){
                          return Card(
                            child: InkWell(
                              onTap: (){
                                _tartDetails(index);
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
                                  children: [
                                    ClipRRect(
                                      borderRadius:BorderRadius.only(
                                      topLeft:Radius.circular(10),
                                      topRight:Radius.circular(10),),
                                      child: CachedNetworkImage(
                                        imageUrl: "https://javathree99.com/s271059/littlecakestory/images/product_tart/${_tartList[index]['tart_no']}.png",
                                        height: 185,
                                        width: 185,)),
                                    Row(
                                      children:[
                                        Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                                        child: Text(_tartList[index]['tart_name'],
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context).appBarTheme.textTheme.headline2),
                                        ),
                                      ] 
                                    ), 
                                    SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          child: Text(_tartList[index]['offered_price'] == "0"
                                            ? "RM${_tartList[index]['original_price']}"
                                            : "RM${_tartList[index]['offered_price']}",
                                          style: TextStyle(fontSize:16,),),
                                        ),
                                        SizedBox(width:10),
                                        Text(_tartList[index]['offered_price'] == "0"
                                            ? ""
                                            : "RM${_tartList[index]['original_price']}",
                                          style: Theme.of(context).appBarTheme.textTheme.headline3,)
                                      ],),
                                    SizedBox(height:6),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          child: Text(_tartList[index]['rating'],
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
        onPressed: () {
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context)=>AddTartScreen(user: widget.user,))
          );
        },
        child:Icon(Icons.add,
          color: Colors.white,
        )
      ),
    );
  }

  void _loadMyTarts() {

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/load_my_tart.php"),
      body: {
        "email":widget.user.email,
      }).then(
        (response){
          if(response.body == "nodata"){
            titleCenter = "No data";
            return;
          }else{
            var jsondata = json.decode(response.body);
            _tartList = jsondata["tart"];
            titleCenter = "Contain Data";
            setState(() {});
            print(_tartList);
          }
      }
    );
  }

  void _tartDetails(int index) {
    print(_tartList[index]['tart_no']);
    TartList tartList = new TartList(
      tartNo: _tartList[index]['tart_no'],
      tartName: _tartList[index]['tart_name'],
      oriPrice: _tartList[index]['original_price'],
      offeredPrice: _tartList[index]['offered_price'],
      rating: _tartList[index]['rating'],
      details: _tartList[index]['tart_detail'],
    );

    Navigator.pushReplacement(
      context,MaterialPageRoute(builder: (context)=> MyTartDetails(tartList: tartList,user: widget.user,))
    );
  }
}