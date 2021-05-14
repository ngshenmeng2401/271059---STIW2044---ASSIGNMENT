import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {

  final product_code;
  final product_name;
  final product_picture;
  final product_old_price;
  final product_new_price;

  const ProductDetailsScreen({
    Key key, 
    this.product_code,
    this.product_name, 
    this.product_picture, 
    this.product_old_price, 
    this.product_new_price}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

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
        actions:<Widget> [
          
          ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children:<Widget> [
            Container(
              alignment: Alignment.center,
              height: screenHeight/2.35,
              // color:Colors.white10,
              child:Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(widget.product_picture)),
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
                                  Text(widget.product_name,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline6,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:[
                                      Text("4.5\t\t",
                                      style: TextStyle(color:Colors.orange,fontSize: 14),),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star_half,color: Colors.orange,size: 20,),
                                    ]
                                  ),
                                  // SizedBox(height:20),
                                  Text("SKU:CKBR01")
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
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: "RM",style: Theme.of(context).textTheme.bodyText2),
                                      TextSpan(text: "${widget.product_new_price}",
                                      style:TextStyle(
                                        color:Colors.red[200],
                                        fontSize: 40,
                                        fontFamily: 'Calibri')),
                                    ]
                                )),
                                RichText(
                                  text: TextSpan(
                                    children:<TextSpan> [
                                      TextSpan(text: "25% OFF ",style: Theme.of(context).textTheme.bodyText2),
                                      TextSpan(text: "RM${widget.product_old_price}",
                                        style:Theme.of(context).appBarTheme.textTheme.headline3,),
                                    ]
                                  )
                                )
                              ]
                            )
                          )
                        ]
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MaterialButton(
                                height: 60,
                                color: hasBeenPressed1 ? Colors.red[200] : Theme.of(context).highlightColor,
                                splashColor: Colors.red[200],
                                shape: CircleBorder(),
                                child: Text("6 inch",style: Theme.of(context).textTheme.bodyText2,),
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
                              ),
                              MaterialButton(
                                height: 60,
                                color: hasBeenPressed2 ? Colors.red[200] : Theme.of(context).highlightColor,
                                splashColor: Colors.red[200],
                                shape: CircleBorder(),
                                child: Text("8 inch",style: Theme.of(context).textTheme.bodyText2,),
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
                              ),
                              MaterialButton(
                                height: 60,
                                color: hasBeenPressed3 ? Colors.red[200] : Theme.of(context).highlightColor,
                                splashColor: Colors.red[200],
                                shape: CircleBorder(),
                                child: Text("10 inch",style: Theme.of(context).textTheme.bodyText2,),
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
                              ),
                              MaterialButton(
                                height: 60,
                                color: hasBeenPressed4 ? Colors.red[200] : Theme.of(context).highlightColor,
                                splashColor: Colors.red[200],
                                shape: CircleBorder(),
                                child: Text("12 inch",style: Theme.of(context).textTheme.bodyText2,),
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
                              ),
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
                          Text("• Type - Cream",style:Theme.of(context).textTheme.bodyText2),
                          SizedBox(height: 5,),
                          Text("• Shape - Round",style:Theme.of(context).textTheme.bodyText2),
                          SizedBox(height: 5,),
                          Text("• Flavour - Vanila",style:Theme.of(context).textTheme.bodyText2),
                          SizedBox(height: 10,),
                          Text("Product Description",style:Theme.of(context).appBarTheme.textTheme.headline2),
                          SizedBox(height: 5,),
                          Wrap(
                            children: [
                              Text("Vanilla cake is a vanila sponge cake with a flower and some decoration. This is a perfect cake to be ordered. Vanilla Cake consists of several layers of vanilla sponge cake sandwiched with whipped cream and fruits. It is decorated with additional whipped cream, fake flower and vanilla shavings. Everyone loves a rich vanilla cake crammed with cream, krisch and cherries.",
                              style:Theme.of(context).textTheme.bodyText2,
                              textAlign: TextAlign.justify,),]),
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