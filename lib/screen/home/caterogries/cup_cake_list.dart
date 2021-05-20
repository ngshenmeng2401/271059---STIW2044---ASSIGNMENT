import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:little_cake_story/model/cup_cake.dart';
import 'package:little_cake_story/model/user.dart';

import 'cup_cake_details.dart';

class CupCakeListScreen extends StatefulWidget {

  final User user;
  final CupCakeList cupCakeList;

  const CupCakeListScreen({Key key, this.user, this.cupCakeList}) : super(key: key);

  @override
  _CupCakeListScreenState createState() => _CupCakeListScreenState();
}

class _CupCakeListScreenState extends State<CupCakeListScreen> {

  List _cupCakeList;
  String titleCenter = "Loading...",searchText="Search";
  double screenHeight, screenWidth;
  TextEditingController _searchCakeController = new TextEditingController();
  int sortButton=1;

  @override
  void initState() {

    super.initState();
    _loadCupCake();
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
            _cupCakeList == null 
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
                            itemCount: _cupCakeList.length,
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
                                              imageUrl: "https://javathree99.com/s271059/littlecakestory/images/product_cup_cake/${_cupCakeList[index]['cup_cake_no']}.png",
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
                                          child: Text(_cupCakeList[index]['cup_cake_name'],
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context).appBarTheme.textTheme.headline2),
                                          ), 
                                          SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                child: Text(_cupCakeList[index]['offered_price'] == "0" 
                                                ? "RM ${_cupCakeList[index]['original_price']}"
                                                : "RM ${_cupCakeList[index]['offered_price']}",
                                                style: TextStyle(fontSize:16,),),
                                              ),
                                              SizedBox(width:10),
                                              Text(_cupCakeList[index]['offered_price'] == "0" 
                                                ? ""
                                                : "RM ${_cupCakeList[index]['original_price']}",
                                                style: Theme.of(context).appBarTheme.textTheme.headline3,)
                                            ],),
                                          SizedBox(height:6),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                child: Text(_cupCakeList[index]['rating'],
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
        onPressed: () {
          _sortCakeDialog(context);
        },
        icon:Icon(Icons.list,
          color: Colors.white,),
        label: Text("Sort",
          style: TextStyle(color:Colors.white,fontFamily: 'Calibri',fontSize: 16),),
      ),
    );
  }

  void _loadCupCake() {

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/load_cup_cake.php"),
      body: {
        "email":widget.user.email,
      }).then(
        (response){
          if(response.body == "nodata"){
            titleCenter = "No data";
            return;
          }else{
            var jsondata = json.decode(response.body);
            _cupCakeList = jsondata["cupcake"];
            titleCenter = "Contain Data";
            setState(() {});
            print(_cupCakeList);
          }
      }
    );
  }

  void _cakeDetails(int index) {

    print(_cupCakeList[index]['cake_no']);
    CupCakeList cupCakeList = new CupCakeList(
      cupCakeNo: _cupCakeList[index]['cup_cake_no'],
      cupCakeName: _cupCakeList[index]['cup_cake_name'],
      oriPrice: _cupCakeList[index]['original_price'],
      offeredPrice: _cupCakeList[index]['offered_price'],
      rating: _cupCakeList[index]['rating'],
      details: _cupCakeList[index]['cup_cake_detail'],
    );
    Navigator.push(
      context,MaterialPageRoute(builder: (context)=> CupCakeDetailsScreen(cupCakeList:cupCakeList,user: widget.user,))
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
                    _sortCupCakePrice(sortButton);
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

  void _sortCupCakePrice(int sortButton) {

    print(sortButton);

    if(sortButton == 1){
      _loadCupCake();
    }
    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/sort_cup_cake_price.php"),
      body: {
        "email":widget.user.email,
        "sort_value":sortButton.toString(),
      }).then(
        (response){
          setState(() {
            var jsondata = json.decode(response.body);
            _cupCakeList = jsondata["cupcake"];
            FocusScope.of(context).requestFocus(new FocusNode());
          });
      }
    );
  }
  
}