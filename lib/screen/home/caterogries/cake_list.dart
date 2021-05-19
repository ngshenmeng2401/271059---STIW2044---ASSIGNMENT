import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:little_cake_story/model/cake.dart';
import 'package:little_cake_story/model/user.dart';

import 'cake_details.dart';

class CakeListScreen extends StatefulWidget {

  final User user;
  final CakeList cakeList;
  const CakeListScreen({Key key, this.user, this.cakeList}) : super(key: key);

  @override
  _CakeListScreenState createState() => _CakeListScreenState();
}

class _CakeListScreenState extends State<CakeListScreen> {

  List _cakeList;
  String titleCenter = "Loading...",searchText="Search";
  double screenHeight, screenWidth;
  bool selected_slice, selected_6inch, selected_8inch, selected_10inch, selected_12inch;
  TextEditingController _searchCakeController = new TextEditingController();
  int sortButton=1;
  // int _pageno = 1;
  // int pagenum = 0;

  @override
  void initState() {

    super.initState();
    _loadCake();
  }
  
  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        title: Text('Cakes',style: TextStyle(fontFamily: 'Arial')),
        actions: [
          IconButton(
              icon: Icon(Icons.list), 
              color: Colors.white,
              onPressed: (){
                _sortCakeDialog(context);
          }),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            _cakeList == null 
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
                            itemCount: _cakeList.length,
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
                                              imageUrl: "https://javathree99.com/s271059/littlecakestory/images/product_cake/${_cakeList[index]['cake_no']}.png",
                                              height: 185,
                                              width: 185,)),
                                          Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                                          child: Text(_cakeList[index]['cake_name'],
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: Theme.of(context).appBarTheme.textTheme.headline2),
                                          ), 
                                          SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                child: Text(_cakeList[index]['offered_price'] == "0" 
                                                ? "RM${_cakeList[index]['original_price']}"
                                                : "RM${_cakeList[index]['offered_price']}",
                                                style: TextStyle(fontSize:16,),),
                                              ),
                                              SizedBox(width:10),
                                              Text(_cakeList[index]['offered_price'] == "0" 
                                                ? ""
                                                : "RM${_cakeList[index]['original_price']}",
                                                style: Theme.of(context).appBarTheme.textTheme.headline3,)
                                            ],),
                                          SizedBox(height:6),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                child: Text(_cakeList[index]['rating'],
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
    );
  }

  void _loadCake() {

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/load_cake.php"),
      body: {
        "email":widget.user.email,
      }).then(
        (response){
          if(response.body == "nodata"){
            titleCenter = "No data";
            return;
          }else{
            var jsondata = json.decode(response.body);
            _cakeList = jsondata["cake"];
            titleCenter = "Contain Data";
            setState(() {});
            print(_cakeList);
          }
      }
    );
  }

  void _cakeDetails(int index) {

    _cakeList[index]['size_slice']=="true" 
      ? selected_slice=true
      : selected_slice=false;

    _cakeList[index]['size6_inch']=="true" 
      ? selected_6inch=true
      : selected_6inch=false;
    
    _cakeList[index]['size8_inch']=="true" 
      ? selected_8inch=true
      : selected_8inch=false;

    _cakeList[index]['size10_inch']=="true" 
      ? selected_10inch=true
      : selected_10inch=false;

    _cakeList[index]['size12_inch']=="true" 
      ? selected_12inch=true
      : selected_12inch=false;
    
    print(selected_12inch);

    print(_cakeList[index]['cake_no']);
    CakeList cakeList = new CakeList(
      cakeNo: _cakeList[index]['cake_no'],
      cakeName: _cakeList[index]['cake_name'],
      oriPrice: _cakeList[index]['original_price'],
      offeredPrice: _cakeList[index]['offered_price'],
      rating: _cakeList[index]['rating'],
      details: _cakeList[index]['cake_detail'],
      slice: selected_slice,
      inch_6: selected_6inch,
      inch_8: selected_8inch,
      inch_10: selected_10inch,
    );

    Navigator.push(
      context,MaterialPageRoute(builder: (context)=> CakeDetailsScreen(cakeList:cakeList,user: widget.user,))
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
                    _sortCakePrice(sortButton);
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

  void _sortCakePrice(int sortButton) {

    print(sortButton);

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/sort_cake_price.php"),
      body: {
        "email":widget.user.email,
        "sort_value":sortButton.toString(),
      }).then(
        (response){
          setState(() {
            var jsondata = json.decode(response.body);
            _cakeList = jsondata["cake"];
            FocusScope.of(context).requestFocus(new FocusNode());
          });
      }
    );
  }
  
}
