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
                                              width: screenWidth/2.5,
                                              child: Text(
                                                _cartList[index]['product_name'],
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context).textTheme.bodyText1,
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(left: 10),
                                              width: screenWidth/5,
                                              child: Text("RM "+ _cartList[index]['product_price'],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(left: 10),
                                              width: screenWidth/3.4,
                                              child: RichText(
                                                textAlign: TextAlign.left,
                                                text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(text: _cartList[index]['product_size'] == "No"
                                                    ? _cartList[index]['product_size'] 
                                                    : _cartList[index]['product_size'] ,style: TextStyle(fontSize: 16)),
                                                  TextSpan(text: _cartList[index]['eggless']=="false"
                                                    ? ""
                                                    : ",Eggless",style: TextStyle(fontSize: 16)),
                                                ]
                                              )),
                                            ),
                                            Container(
                                              width: screenWidth/3,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  IconButton(onPressed: (){
                                                    _updateCart(index,"remove");
                                                  }, 
                                                  icon: Icon(Icons.remove_circle_outline)),
                                                  Text(_cartList[index]['product_qty']),
                                                  IconButton(onPressed: (){
                                                    _updateCart(index,"add");
                                                  }, 
                                                  icon: Icon(Icons.add_circle_outline)),
                                                ],
                                              ),
                                            ),
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
                                                style: TextStyle(fontSize: 22),),
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

  
  void _updateCart(int index, String op) {

    quantity= int.parse(_cartList[index]['product_qty']);
    if (op == "add") {
      quantity++;
    }
    if (op == "remove") {
      quantity--;
      if (quantity == 0) {
        _deleteCartDialog(index);
        return;
      }
    }
    

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/update_cart.php"),
      body: {
        "product_no":_cartList[index]['product_no'],
        "email":widget.user.email,
        "product_price":_cartList[index]['product_price'],
        "quantity":quantity.toString(),

      }).then(
        (response){
          print(response.body);

          if(response.body=="success"){
            Fluttertoast.showToast(
            msg: "Cart Update",
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
            msg: "Failed",
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
        "product_no":_cartList[index]['product_no'],
        "email":widget.user.email,
        "product_price":_cartList[index]['product_price'],

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

    if(_cartList==null){
      Fluttertoast.showToast(
            msg: "Cart is empty",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);
    }
    else{
      Navigator.pushReplacement(
        context,MaterialPageRoute(builder: (context)=> PaymentScreen(user: widget.user,cart: cart,address:address,))
      );
    }
  }
}
