import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:little_cake_story/model/cake.dart';
import 'package:little_cake_story/model/user.dart';

class CakeDetailsScreen extends StatefulWidget {

  final User user;
  final CakeList cakeList;

  const CakeDetailsScreen({Key key, this.user, this.cakeList}) : super(key: key);

  @override
  _CakeDetailsScreenState createState() => _CakeDetailsScreenState();
}

class _CakeDetailsScreenState extends State<CakeDetailsScreen> {

  var text;
  Color buttonOnClick = Colors.red[200];
  bool hasBeenPressed1 = false, hasBeenPressed2 = false, hasBeenPressed3 = false, hasBeenPressed4 = false;
  bool enggLess = false;
  bool pressFavouriteColor = false, pressFavouriteIcon = false;
  double screenHeight,screenWidth;

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar:AppBar(
        title: Text('LITTLE CAKE STORY',style: TextStyle(fontFamily: 'Arial'),),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children:<Widget> [
            Container(
              alignment: Alignment.center,
              height: screenHeight/2.35,
              child:Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://javathree99.com/s271059/littlecakestory/images/product_cake/${widget.cakeList.cakeNo}.png",
                    ),),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      highlightColor: Colors.red,
                      icon: !pressFavouriteIcon ? 
                      Icon(Icons.favorite_outline,color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,) : 
                      Icon(Icons.favorite,color: Colors.red,),
                        onPressed: (){
                          setState(() {
                            pressFavouriteIcon = !pressFavouriteIcon;
                          });
                    }),
                  )
                ]
              ),

            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                // height: 500,
                width: 400,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color:Colors.grey[600],
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    )
                  ],
                  color: Theme.of(context).hoverColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: Row(
                        children:[
                          Wrap(
                            children: [
                              Container(
                              width: 250,
                              // color: Colors.grey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.cakeList.cakeName,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline6,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:[
                                      Text(widget.cakeList.rating,
                                      style: TextStyle(color:Colors.orange,fontSize: 14),),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star_half,color: Colors.orange,size: 20,),
                                    ]
                                  ),
                                  // SizedBox(height:20),
                                  Text("Code: "+widget.cakeList.cakeNo),
                                ],
                              ),
                            ),
                            ],
                          ),
                          Container(
                            width: 110,
                            // color: Colors.blue,
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children:[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("RM ",style: TextStyle(fontFamily: 'Calibri',fontSize: 14),),
                                    Text(widget.cakeList.offeredPrice == "0"
                                      ? widget.cakeList.oriPrice
                                      : widget.cakeList.offeredPrice,
                                    style:TextStyle(
                                        color:Colors.red[200],
                                        fontSize: 40,
                                        fontFamily: 'Calibri'),)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(widget.cakeList.offeredPrice == "0"
                                      ? ""
                                      : "RM "+widget.cakeList.offeredPrice,
                                    style:TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Calibri'),)
                                  ],
                                ),
                              ]
                            )
                          )
                        ]
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              widget.cakeList.slice == true 
                              ?  MaterialButton(
                                  height: 60,
                                  color: hasBeenPressed1 ? Colors.red[200] : Theme.of(context).highlightColor,
                                  splashColor: Colors.red[200],
                                  shape: CircleBorder(),
                                  child: Text("slice",style: Theme.of(context).textTheme.bodyText2,),
                                  onPressed: (){
                                    setState(() {
                                      hasBeenPressed1 = !hasBeenPressed1;
                                      if(hasBeenPressed1==true){
                                        hasBeenPressed2=false;
                                        hasBeenPressed3=false;
                                        hasBeenPressed4=false;

                                      }
                                    });
                                  }
                                )
                              : MaterialButton(onPressed: (){},),

                              widget.cakeList.inch_6 == true 
                              ? MaterialButton(
                                height: 60,
                                color: hasBeenPressed2 ? Colors.red[200] : Theme.of(context).highlightColor,
                                splashColor: Colors.red[200],
                                shape: CircleBorder(),
                                child: Text("6 inch",style: Theme.of(context).textTheme.bodyText2,),
                                onPressed: (){
                                  setState(() {
                                    hasBeenPressed2 = !hasBeenPressed2;
                                    if(hasBeenPressed2==true){
                                      hasBeenPressed1=false;
                                      hasBeenPressed3=false;
                                      hasBeenPressed4=false;
                                    }
                                  });
                                }
                              )
                              : MaterialButton(onPressed: (){},),

                              widget.cakeList.inch_8 == true 
                              ? MaterialButton(
                                height: 60,
                                color: hasBeenPressed3 ? Colors.red[200] : Theme.of(context).highlightColor,
                                splashColor: Colors.red[200],
                                shape: CircleBorder(),
                                child: Text("8 inch",style: Theme.of(context).textTheme.bodyText2,),
                                onPressed: (){
                                  setState(() {
                                    hasBeenPressed3 = !hasBeenPressed3;
                                    if(hasBeenPressed3==true){
                                      hasBeenPressed1=false;
                                      hasBeenPressed2=false;
                                      hasBeenPressed4=false;
                                    }
                                  });
                                }
                              )
                              : MaterialButton(onPressed: (){},),

                              widget.cakeList.inch_10 == true 
                              ? MaterialButton(
                                  height: 60,
                                  color: hasBeenPressed4 ? Colors.red[200] : Theme.of(context).highlightColor,
                                  splashColor: Colors.red[200],
                                  shape: CircleBorder(),
                                  child: Text("10 inch",style: Theme.of(context).textTheme.bodyText2,),
                                  onPressed: (){
                                    setState(() {
                                      hasBeenPressed4 = !hasBeenPressed4;
                                      if(hasBeenPressed4==true){
                                        hasBeenPressed1=false;
                                        hasBeenPressed2=false;
                                        hasBeenPressed3=false;
                                      }
                                    });
                                  }
                                )
                              : MaterialButton(onPressed: (){},),
                            ],
                          ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                        child: Row(
                          children:[
                            GestureDetector(
                              child:Container(
                                width: 120,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color:Colors.grey[600],
                                      spreadRadius: 0.5,
                                      blurRadius: 2,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                  color: enggLess ? Colors.green[600] : Theme.of(context).highlightColor,
                                ),
                                child: Row(
                                  children:[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 8, 5, 8),
                                      child:Image.asset("assets/images/eggless.png"),
                                    ),
                                    SizedBox(width: 10,),
                                    Text("Eggless"),
                                  ]
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  enggLess = !enggLess;
                                });
                              },
                            ),
                            SizedBox(width:15),
                            Container(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                              width: 225,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color:Colors.grey[600],
                                      spreadRadius: 0.5,
                                      blurRadius: 2,
                                      offset: Offset(0, 3),
                                  )
                                ],
                                color: Theme.of(context).highlightColor,
                              ),
                              child: TextField(
                                 decoration: InputDecoration(
                                  hintText: 'Message on Cake',
                                  hintStyle: Theme.of(context).textTheme.bodyText2,
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                          ]
                        ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: MaterialButton(
                        shape:RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(20),
                        ),
                        minWidth: 360,
                        height: 40,
                        child: Text('Add To Cart',
                        style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: 'Arial'),),
                        onPressed: (){
                          
                        },
                        color: Colors.red[200],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                      width: 390,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget> [
                          Text("Product Details",style:Theme.of(context).appBarTheme.textTheme.headline2,),
                          SizedBox(height: 5,),
                          Text("• "+ widget.cakeList.details,style:Theme.of(context).textTheme.bodyText2),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
          
        ),
    );
  }
}