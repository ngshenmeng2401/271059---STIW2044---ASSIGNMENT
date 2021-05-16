import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:little_cake_story/model/puff_list.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/profile/your_product/puff_details.dart';
import 'add_puff_screen.dart';

class PuffsListScreen extends StatefulWidget {

  final PuffList puffList;
  final User user;
  const PuffsListScreen({Key key, this.user, this.puffList}) : super(key: key);

  @override
  _PuffsListScreenState createState() => _PuffsListScreenState();
}

class _PuffsListScreenState extends State<PuffsListScreen> {

  List _puffList;
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;

  @override
  void initState() {

    super.initState();
    _loadPuff();
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar:AppBar(
        title: Text('Puffs',style: TextStyle(fontFamily: 'Arial')),
        actions: [
          IconButton(
              icon: Icon(Icons.add), 
              color: Colors.white,
              onPressed: (){
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context)=>AddPuffScreen(user: widget.user,))
                );
          }),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            _puffList == null 
            ? Flexible(
                child: Center(
                  child: Text(titleCenter)),
            )
            : Flexible(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: GridView.builder(
                      itemCount: _puffList.length,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: (screenWidth / screenHeight) /0.9),
                        itemBuilder: (BuildContext context, int index){
                          return Card(
                            child: InkWell(
                              onTap: (){
                                _puffDetails(index);
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
                                        imageUrl: "https://javathree99.com/s271059/littlecakestory/images/product_puff/${_puffList[index]['puff_no']}.png",
                                        height: 185,
                                        width: 185,)),
                                    Row(
                                      children:[
                                        Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                                        child: Text(_puffList[index]['puff_name'],
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
                                          child: Text("RM${_puffList[index]['original_price']}",
                                          style: TextStyle(fontSize:16,),),
                                        ),
                                        SizedBox(width:10),
                                        Text("RM${_puffList[index]['original_price']}",
                                          style: Theme.of(context).appBarTheme.textTheme.headline3,)
                                      ],),
                                    SizedBox(height:6),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          child: Text(_puffList[index]['rating'],
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

  void _loadPuff() {

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/load_puff.php"),
      body: {
        "email":widget.user.email,
      }).then(
        (response){
          if(response.body == "nodata"){
            titleCenter = "No data";
            return;
          }else{
            var jsondata = json.decode(response.body);
            _puffList = jsondata["puff"];
            titleCenter = "Contain Data";
            setState(() {});
            print(_puffList);
          }
      }
    );
  }

  void _puffDetails(int index) {
    print(_puffList[index]['bento_cake_no']);
    PuffList puffList = new PuffList(
      puffNo: _puffList[index]['puff_no'],
      puffName: _puffList[index]['puff_name'],
      oriPrice: _puffList[index]['original_price'],
      offeredPrice: _puffList[index]['offered_price'],
      rating: _puffList[index]['rating'],
      details: _puffList[index]['puff_detail'],
    );

    Navigator.pushReplacement(
      context,MaterialPageRoute(builder: (context)=> PuffDetails(puffList:puffList,user: widget.user,))
    );
  }
}