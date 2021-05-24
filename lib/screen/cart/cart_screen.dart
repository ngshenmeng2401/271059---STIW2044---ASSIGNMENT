import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:little_cake_story/model/address_list.dart';
import 'package:little_cake_story/model/cart.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/cart/payment_screen.dart';

class CartScreen extends StatefulWidget {

  final User user;
  final Cart cart;
  final Address address;
  const CartScreen({Key key, this.user, this.cart, this.address}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  String titleCenter = "Loading...",searchText="Search";
  List _cartList;
  int quantity =1;
  double screenHeight,screenWidth;
  double totalPrice, deliveryCharge;
  String size, eggless;

  @override
  void initState() {
    _loadCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LITTLE CAKE STORY',
          style: TextStyle(fontFamily: 'Arial'),
        ),
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).hoverColor,
        child: Row(
          children: [
            Expanded(
              child: Text("Total: RM " + totalPrice.toStringAsFixed(2),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            Expanded(
              child: MaterialButton(
                  color: Colors.red[200],
                  onPressed: () {
                    _cartData();
                    },
                  child: Text(
                    "Pay",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Calibri'),
                  )),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            _cartList == null 
            ? Flexible(
              child: Center(
                child:Image.asset('assets/images/empty_cart.png'),
              ))
            : Flexible(
              child: Container(
                child: Column(
                  children: [
                    Flexible(
                      child: ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: Container(
                            width: screenWidth/1.1,
                            height: screenHeight/5.6,
                            decoration: BoxDecoration(
                              color: Theme.of(context).hoverColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[600],
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(1, 1),
                                ),
                              ]),
                            child: Row(
                              children: <Widget>[
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: "https://javathree99.com/s271059/littlecakestory/images/product/${_cartList[index]['product_no']}.png",
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        child: Container(
                                          color: Colors.white70,
                                          width: screenWidth/3.38,
                                          height: screenHeight/30,
                                          child: Text(_cartList[index]['offered_price'] == "0" 
                                              ? "RM " +_cartList[index]['original_price']
                                              : "RM " +_cartList[index]['offered_price'],
                                            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(left: 10),
                                              width: screenWidth/2,
                                              child: Text(
                                                _cartList[index]['product_name'],
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context).textTheme.bodyText1,
                                              ),
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red[200],
                                                  size: 25,
                                                ),
                                                onPressed: () {
                                                  _deleteCartDialog(index);
                                                })
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.star,color: Colors.orange,size: 20,),
                                            Container(
                                            width: screenWidth/6,
                                            child: Text(_cartList[index]['rating'],
                                              style: TextStyle(
                                                    color: Colors.orange, fontSize: 18))),
                                            SizedBox(),
                                            Container(
                                              width: screenWidth/2.8,
                                              margin: const EdgeInsets.only(left:10),
                                              child: RichText(
                                                textAlign: TextAlign.right,
                                                text: TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(text:_cartList[index]['slice']=="true" 
                                                      ? "slice, "
                                                      : null),
                                                    TextSpan(text:_cartList[index]['6_inch']=="true" 
                                                      ? "6 inch, "
                                                      : null),
                                                    TextSpan(text:_cartList[index]['8_inch']=="true" 
                                                      ? "8 inch, "
                                                      : null),
                                                    TextSpan(text:_cartList[index]['10_inch']=="true" 
                                                      ? "10 inch, "
                                                      : null),
                                                    TextSpan(text:_cartList[index]['eggless']=="true" 
                                                      ? "Eggless"
                                                      : null),
                                                  ]
                                                ))
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: screenWidth/3.4,
                                              child: Text("Price (RM):",
                                              style: TextStyle(fontSize: 16))),
                                            Container(
                                              width:screenWidth/3.4,
                                              child: Text(_cartList[index]['total_price'],
                                                textAlign: TextAlign.end,
                                                style: TextStyle(fontSize: 20),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ])
                                
                              ]),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ))
          ],
        ),   
    ));
  }

  void _loadCart(){

    totalPrice = 0.00;

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/load_cart.php"),
      body: {
        "email":widget.user.email,
        
      }).then(
        (response){
          if(response.body == "Cart Empty"){
            titleCenter = "Cart Empty";
            return;
          }else{

            setState(() {
              var jsondata = json.decode(response.body);
              _cartList = jsondata["cart"];
              
              for(int index =0 ; index < _cartList.length; index++){

                totalPrice = double.parse(_cartList[index]['total_price']) + totalPrice;

              }
            });
            
            titleCenter = "Contain Data";
            print(_cartList);
          }
      }
    );
  }

  void _deleteCartDialog(index) {

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Delete this item ?"),
          actions: [
            TextButton(
              child:(Text('Yes',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                _deleteCart(index);
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

  void _deleteCart(int index) {

    print(_cartList[index]['cart_no']);

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/delete_cart.php"),
      body: {
        "cart_no":_cartList[index]['cart_no'],
        "email":widget.user.email,

      }).then(
        (response){
          print(response.body);

          if(response.body=="success"){
            Fluttertoast.showToast(
            msg: "Delete Cart Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);

            _loadCart();

          }
          else {
            Fluttertoast.showToast(
            msg: "Delete Cart Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);

          }
      }
    );
  }

  void _cartData() {

    Cart cart = new Cart(
      totalPrice: totalPrice,
    );

    Address address = new Address(
      streetAddress: "Street Address",
      postalCode: "Postal Code",
      city: "City",
      state: "State",
    );
    Navigator.pushReplacement(
      context,MaterialPageRoute(builder: (context)=> PaymentScreen(user: widget.user,cart: cart,address:address,))
    );
  }

}
