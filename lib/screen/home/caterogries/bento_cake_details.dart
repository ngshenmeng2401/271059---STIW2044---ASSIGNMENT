import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:little_cake_story/model/bento_cake.dart';
import 'package:little_cake_story/model/user.dart';

class BentoCakeDetailsScreen extends StatefulWidget {

  final User user;
  final BentoCakeList bentoCakeList;

  const BentoCakeDetailsScreen({Key key, this.user, this.bentoCakeList}) : super(key: key);

  @override
  _BentoCakeDetailsScreenState createState() => _BentoCakeDetailsScreenState();
}

class _BentoCakeDetailsScreenState extends State<BentoCakeDetailsScreen> {

  bool pressFavouriteColor = false, pressFavouriteIcon = false;
  double screenHeight,screenWidth;
  double totalOriPrice = 0, totalOfferedPrice = 0;
  TextEditingController _messageController = new TextEditingController();

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
                          "https://javathree99.com/s271059/littlecakestory/images/product_bento_cake/${widget.bentoCakeList.bentoCakeNo}.png",
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
                                  Text(widget.bentoCakeList.bentoCakeName,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline6,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:[
                                      Text(widget.bentoCakeList.rating,
                                      style: TextStyle(color:Colors.orange,fontSize: 14),),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star_half,color: Colors.orange,size: 20,),
                                    ]
                                  ),
                                  // SizedBox(height:20),
                                  Text("No: "+widget.bentoCakeList.bentoCakeNo),
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
                                    Text(widget.bentoCakeList.offeredPrice == "0"
                                      ? widget.bentoCakeList.oriPrice
                                      : widget.bentoCakeList.offeredPrice,
                                    style:TextStyle(
                                        color:Colors.red[200],
                                        fontSize: 40,
                                        fontFamily: 'Calibri'),)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(widget.bentoCakeList.offeredPrice == "0"
                                      ? ""
                                      : "RM "+widget.bentoCakeList.oriPrice,
                                    style:Theme.of(context).appBarTheme.textTheme.headline3)
                                  ],
                                ),
                              ]
                            )
                          )
                        ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Divider( color:Theme.of(context).bottomNavigationBarTheme.unselectedItemColor)),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                      width: 390,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget> [
                          Text("Product Details",style:Theme.of(context).appBarTheme.textTheme.headline2,),
                          SizedBox(height: 5,),
                          Text(widget.bentoCakeList.details,style:Theme.of(context).textTheme.bodyText2),
                          
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
        },
        icon:Icon(Icons.shopping_cart,
          color: Colors.white,),
        label: Text("Add Cart",
          style: TextStyle(color:Colors.white,fontFamily: 'Calibri',fontSize: 16),),
      ),
    );
  }

}