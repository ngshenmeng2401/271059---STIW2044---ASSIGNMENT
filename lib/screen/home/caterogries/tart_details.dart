import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:little_cake_story/model/product.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:http/http.dart' as http;

class TartDetailsScreen extends StatefulWidget {

  final User user;
  final ProductList productList;
  const TartDetailsScreen({Key key, this.user, this.productList}) : super(key: key);

  @override
  _TartDetailsScreenState createState() => _TartDetailsScreenState();
}

class _TartDetailsScreenState extends State<TartDetailsScreen> {

  bool selectSlice = false, select6Inch = false, select8Inch = false, select10Inch = false;
  bool eggLess = false, pressFavouriteIcon = false;
  String cartQuantity, _message = "No";
  double screenHeight,screenWidth;
  double totalOriPrice = 0, totalOfferedPrice = 0;

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar:AppBar(
        title: Text('Tart',style: TextStyle(fontFamily: 'Arial'),),
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
                          "https://javathree99.com/s271059/littlecakestory/images/product/${widget.productList.productNo}.png",
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
                                  Text(widget.productList.productName,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline6,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:[
                                      Text(widget.productList.rating,
                                      style: TextStyle(color:Colors.orange,fontSize: 14),),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star_half,color: Colors.orange,size: 20,),
                                    ]
                                  ),
                                  // SizedBox(height:20),
                                  Text("No: "+widget.productList.productNo),
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
                                    Text(widget.productList.offeredPrice == "0"
                                      ? widget.productList.oriPrice
                                      : widget.productList.offeredPrice,
                                    style:TextStyle(
                                        color:Colors.red[200],
                                        fontSize: 40,
                                        fontFamily: 'Calibri'),)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(widget.productList.offeredPrice == "0"
                                      ? ""
                                      : "RM "+widget.productList.oriPrice,
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
                          Text(widget.productList.details,style:Theme.of(context).textTheme.bodyText2),
                          
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
        backgroundColor: Colors.red[200],
        onPressed: () {
          _addToCartDialog();
        },
        icon:Icon(Icons.shopping_cart,
          color: Colors.white,),
        label: Text("Add Cart",
          style: TextStyle(color:Colors.white,fontFamily: 'Calibri',fontSize: 16),),
      ),
    );
  }
  void _addToCartDialog() {

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: RichText(text: TextSpan(
            children:<TextSpan>[
              TextSpan(text: "Add ",style: Theme.of(context).textTheme.bodyText1),
              TextSpan(text: widget.productList.productName,style: TextStyle(fontSize: 20,color: Colors.red[200])),
              TextSpan(text: " to cart ?",style: Theme.of(context).textTheme.bodyText1),
            ] 
          )),
          actions: [
            TextButton(
              child:(Text('Yes',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                _addToCart();
                Navigator.of(context).pop();
              },),
            TextButton(
              child: (Text('No',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                Navigator.of(context).pop();
              },),
          ],
        );
      });
  }

  void _addToCart() {

    String product_qty = "1";
    print(widget.user.email);
    print(selectSlice);
    print(select6Inch);
    print(select8Inch);
    print(select10Inch);
    print(eggLess);

    http.post(
    Uri.parse("https://javathree99.com/s271059/littlecakestory/php/add_cart.php"),
    body: {
      "product_no":widget.productList.productNo,
      "user_qty":product_qty,
      "email":widget.user.email,
      "selectSlice":selectSlice.toString(),
      "select6Inch":select6Inch.toString(),
      "select8Inch":select8Inch.toString(),
      "select10Inch":select10Inch.toString(),
      "eggLess":eggLess.toString(),
      "message":_message,

    }).then(
      (response){
        print(response.body);

        if(response.body=="failed"){
          Fluttertoast.showToast(
          msg: "Add Into Cart Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[200],
          textColor: Colors.white,
          fontSize: 16.0);
        }
        else {
          Fluttertoast.showToast(
          msg: "Add Into Cart Sucess",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[200],
          textColor: Colors.white,
          fontSize: 16.0);

          List respond = response.body.split(",");
          setState(() {
            cartQuantity = respond[1];
            widget.user.qty = cartQuantity;
          });

        }
      }
    );
  }
}