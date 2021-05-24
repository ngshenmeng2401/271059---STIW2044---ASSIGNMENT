import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:little_cake_story/model/product.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsScreen extends StatefulWidget {

  final User user;
  final ProductList productList;
  const ProductDetailsScreen({Key key, this.user, this.productList}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  bool selectSlice = false, select6Inch = false, select8Inch = false, select10Inch = false;
  bool eggLess = false, pressFavouriteIcon ;
  double screenHeight,screenWidth;
  double totalOriPrice = 0, totalOfferedPrice = 0;
  TextEditingController _messageController = new TextEditingController();
  String cartQuantity, _message, status;
  SharedPreferences pref;

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar:AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: (){
        //     Navigator.pushReplacement(
        //       context,MaterialPageRoute(builder: (context)=> SearchScreen(user: widget.user,))
        //     );
        //   },
        // ),
        title: Text('LITTLE CAKE STORY',style: TextStyle(fontFamily: 'Arial'),),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children:<Widget> [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                    child: FavoriteButton(
                      iconColor: Colors.red,
                      iconDisabledColor: Colors.grey,
                      iconSize: 35.0,
                      valueChanged: (_isFavorite){
                        _selectFavourite(_isFavorite);
                      },
                    )
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
                                      SizedBox(width:10),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star,color: Colors.orange,size: 20,),
                                      Icon(Icons.star_half,color: Colors.orange,size: 20,),
                                    ]
                                  ),
                                  Text("No: "+widget.productList.productNo),
                                ],
                              ),
                            ),
                            ],
                          ),
                          Container(
                            width: 110,
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
                              widget.productList.slice == true 
                              ?  MaterialButton(
                                  height: 60,
                                  color: selectSlice ? Colors.red[200] : Theme.of(context).highlightColor,
                                  splashColor: Colors.red[200],
                                  shape: CircleBorder(),
                                  child: Text("slice",style: Theme.of(context).textTheme.bodyText2,),
                                  onPressed: (){                                      
                                    _sliceCake();                                    
                                  }
                                )
                              : Padding(padding: const EdgeInsets.all(0)),

                              widget.productList.inch_6 == true 
                              ? MaterialButton(
                                height: 60,
                                color: select6Inch ? Colors.red[200] : Theme.of(context).highlightColor,
                                splashColor: Colors.red[200],
                                shape: CircleBorder(),
                                child: Text("6 inch",style: Theme.of(context).textTheme.bodyText2,),
                                onPressed: (){
                                  _inch6Cake();
                                }
                              )
                              : Padding(padding: const EdgeInsets.all(0)),

                              widget.productList.inch_8 == true 
                              ? MaterialButton(
                                height: 60,
                                color: select8Inch ? Colors.red[200] : Theme.of(context).highlightColor,
                                splashColor: Colors.red[200],
                                shape: CircleBorder(),
                                child: Text("8 inch",style: Theme.of(context).textTheme.bodyText2,),
                                onPressed: (){
                                  _inch8Cake();
                                }
                              )
                              : Padding(padding: const EdgeInsets.all(0)),

                              widget.productList.inch_10 == true 
                              ? MaterialButton(
                                  height: 60,
                                  color: select10Inch ? Colors.red[200] : Theme.of(context).highlightColor,
                                  splashColor: Colors.red[200],
                                  shape: CircleBorder(),
                                  child: Text("10 inch",style: Theme.of(context).textTheme.bodyText2,),
                                  onPressed: (){
                                    _inch10Cake();
                                  }
                                )
                              : Padding(padding: const EdgeInsets.all(0)),
                            ],
                          ),
                      ),
                    ),
                    widget.productList.type == "Cake"
                    ? Container(
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
                                  color: eggLess ? Colors.green[600] : Theme.of(context).highlightColor,
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
                                _selectEggless();
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
                                controller: _messageController,
                                decoration: InputDecoration(
                                  hintText: 'Message on Cake',
                                  hintStyle: Theme.of(context).textTheme.bodyText2,
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                          ]
                        ),),
                    )
                    : Padding(padding: const EdgeInsets.all(0)),
                    widget.productList.type == "Cake"
                    ? Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Divider( color:Theme.of(context).bottomNavigationBarTheme.unselectedItemColor))
                    : Padding(padding: const EdgeInsets.all(0)),
                    widget.productList.type == "Cake"
                    ? Container(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total: ",style: TextStyle(fontSize: 24),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("RM\t\t"),
                              Text(widget.productList.offeredPrice == "0"
                                  ? totalOriPrice.toStringAsFixed(2)
                                  : totalOfferedPrice.toStringAsFixed(2),
                                style:TextStyle(
                                  color: Colors.red[200],
                                  fontSize: 28,
                                  fontFamily: 'Calibri'),)
                            ],
                          )
                        ],
                      ),
                    )
                    : Padding(padding: const EdgeInsets.all(0)),
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

  void _sliceCake() {

    setState(() {
      selectSlice = !selectSlice;
      if(selectSlice==true){
        select6Inch=false;
        select8Inch=false;
        select10Inch=false;
      }
        totalOriPrice = double.parse(widget.productList.oriPrice)/6;
        totalOfferedPrice = double.parse(widget.productList.offeredPrice)/6;
        print(totalOriPrice);
    });
  }

  void _inch6Cake() {
      
    setState(() {
      select6Inch = !select6Inch;
      if(select6Inch==true){
        selectSlice=false;
        select8Inch=false;
        select10Inch=false;
      }
        totalOriPrice = double.parse(widget.productList.oriPrice);
        totalOfferedPrice = double.parse(widget.productList.offeredPrice);
    });
  }

  void _inch8Cake() {

    setState(() {
      select8Inch = !select8Inch;
      if(select8Inch==true){
        selectSlice=false;
        select6Inch=false;
        select10Inch=false;
      }
        totalOriPrice = double.parse(widget.productList.oriPrice)*1.20;
        totalOfferedPrice = double.parse(widget.productList.offeredPrice)*1.20;
        print(totalOriPrice);
    });
  }

  void _inch10Cake() {
    setState(() {
      select10Inch = !select10Inch;
      if(select10Inch==true){
        selectSlice=false;
        select6Inch=false;
        select8Inch=false;
      }
        totalOriPrice = double.parse(widget.productList.oriPrice)*1.44;
        totalOfferedPrice = double.parse(widget.productList.offeredPrice)*1.44;
        print(totalOriPrice);
    });
  }

  void _selectEggless() {

    setState(() {
      eggLess = !eggLess;
      // print(eggLess);

      if(eggLess == true && selectSlice == true){

        totalOriPrice = double.parse(widget.productList.oriPrice)/6 *1.1;
        totalOfferedPrice = double.parse(widget.productList.offeredPrice)/6 *1.1;
        
      }else if(eggLess == false && selectSlice == true){

        totalOriPrice = double.parse(widget.productList.oriPrice)/6 ;
        totalOfferedPrice = double.parse(widget.productList.offeredPrice)/6 ;

      }
      
      if(eggLess == true && select6Inch == true){

        totalOriPrice = double.parse(widget.productList.oriPrice)*1.1;
        totalOfferedPrice = double.parse(widget.productList.offeredPrice)*1.1;
        
      }else if(eggLess == false && select6Inch == true){

        totalOriPrice = double.parse(widget.productList.oriPrice);
        totalOfferedPrice = double.parse(widget.productList.offeredPrice);

      }

      if(eggLess == true && select8Inch == true){

        totalOriPrice = double.parse(widget.productList.oriPrice)*1.20*1.1;
        totalOfferedPrice = double.parse(widget.productList.offeredPrice)*1.20*1.1;
        
      }else if(eggLess == false && select8Inch == true){

        totalOriPrice = double.parse(widget.productList.oriPrice)*1.20;
        totalOfferedPrice = double.parse(widget.productList.offeredPrice)*1.20;
        
      }
      
      if(eggLess == true && select10Inch == true){

        totalOriPrice = double.parse(widget.productList.oriPrice)*1.44*1.1;
        totalOfferedPrice = double.parse(widget.productList.offeredPrice)*1.44*1.1;
        
      }else if(eggLess == false && select10Inch == true){

        totalOriPrice = double.parse(widget.productList.oriPrice)*1.44;
        totalOfferedPrice = double.parse(widget.productList.offeredPrice)*1.44;
        
      }
    });
  }

  void _selectFavourite(dynamic _isFavorite) {

    print(_isFavorite);

    if(_isFavorite == true){


      // http.post(
      // Uri.parse("https://javathree99.com/s271059/littlecakestory/php/add_favourite.php"),
      // body: {
      //   "product_no":widget.productList.productNo,
      //   "email":widget.user.email,
      //   "status":_isFavorite.toString(),

      // }).then(
      //   (response){
      //     print(response.body);

      //     if(response.body=="success"){
      //       Fluttertoast.showToast(
      //       msg: "Success",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.red[200],
      //       textColor: Colors.white,
      //       fontSize: 16.0);

      //     }
      //     else {
      //     }
      //   }
      // );
    }else{

    }

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
    if(_messageController.text.toString() == ""){
      _message = "No";
    }else{
      _message = _messageController.text.toString();
    }
    print(widget.user.email);
    print(selectSlice);

    if (widget.productList.type == "Cake" && widget.productList.productNo.isNotEmpty && product_qty.isNotEmpty && widget.user.email.isNotEmpty && selectSlice== false && select6Inch== false && select8Inch== false && select10Inch== false && eggLess== false) {
    Fluttertoast.showToast(
    msg: "Please size of cake and whether the cake is eggless",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red[200],
    textColor: Colors.white,
    fontSize: 16.0);
    }
    else{

      print(_message);

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

}
