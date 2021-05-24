import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:little_cake_story/model/address_list.dart';
import 'package:little_cake_story/model/cart.dart';
import 'package:little_cake_story/model/payment.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/cart/select_address.dart';
import 'cart_screen.dart';
import 'payment_selection.dart';

class PaymentScreen extends StatefulWidget {

  final User user;
  final Cart cart;
  final Address address;
  final Payment payment;
  const PaymentScreen({Key key, this.user, this.cart, this.address, this.payment}) : super(key: key);
  
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  double screenHeight,screenWidth;
  String titleCenter = "Loading...",searchText="Search";
  String _address, _message = "No Any Message";
  List _cartList;
  double totalPrice, deliveryCharge;
  TextEditingController _messageController = new TextEditingController();
  String _setTime, _setDate, _selectedDate = "Date", _selectedTime = "Time";
  String _hour, _minute, _time, dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    _loadCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          color: Colors.white,
          onPressed: (){
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context)=>CartScreen(user: widget.user,))
          );
        }),
        title: Text(
          'Payment',
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
                    _makePayment();
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).hoverColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  width: screenWidth/1.05,
                  height: screenHeight/6.5,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined,color: Colors.red,),
                            Text("Delivery Address",
                            style: TextStyle(fontSize: 14,),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: ListTile(
                            title: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: widget.user.firstName+ " " + widget.user.lastName + " | ",style: TextStyle(fontSize: 16,)),
                                  TextSpan(text: "(+6) "+widget.user.phoneNo,style: TextStyle(fontSize: 16,)),
                                ]
                              )),
                            subtitle: Text(widget.address.streetAddress == "Street Address" && widget.address.city == "City" && widget.address.postalCode == "Postal Code" && widget.address.state == "State"
                              ? "Please choose your address"
                              : widget.address.streetAddress + " " + widget.address.city + " " + widget.address.postalCode + " " + widget.address.state
                            ),
                            trailing: IconButton(
                              onPressed: (){
                                Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context)=>SelectAddressScreen(user: widget.user,))
                                );
                              }, 
                              icon: Icon(Icons.keyboard_arrow_right)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              Container(
                // color: Colors.white60,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Text("LITTLE CAKE STORY",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20),),
                        )]
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      height: screenHeight/2.45,
                      width: screenWidth/1.05,
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
                                          width: screenWidth/2,
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
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft: Radius.circular(10),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: "https://javathree99.com/s271059/littlecakestory/images/product/${_cartList[index]['product_no']}.png",
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: Container(
                                                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                                      width: screenWidth/1.7,
                                                      // color: Colors.blue,
                                                      child: Text(_cartList[index]['product_name'],
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(fontSize:20)),
                                                    )),
                                                  Flexible(
                                                    flex: 1,
                                                    child: Container(
                                                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                                      width: screenWidth/1.7,
                                                      // color: Colors.red,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: TextStyle(fontSize:18),
                                                          children: <TextSpan>[
                                                            TextSpan(text:_cartList[index]['slice']=="1" 
                                                              ? "slice, "
                                                              : null),
                                                            TextSpan(text:_cartList[index]['6_inch']=="1" 
                                                              ? "6 inch, "
                                                              : null),
                                                            TextSpan(text:_cartList[index]['8_inch']=="1" 
                                                              ? "8 inch, "
                                                              : null),
                                                            TextSpan(text:_cartList[index]['10_inch']=="1" 
                                                              ? "10 inch, "
                                                              : null),
                                                            TextSpan(text:_cartList[index]['eggless']=="1" 
                                                              ? "Eggless"
                                                              : null),
                                                          ]
                                                        ))
                                                    )),
                                                  Flexible(
                                                    flex: 1,
                                                    child: Container(
                                                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                                      width: screenWidth/1.7,
                                                      // color: Colors.yellow,
                                                      child: Text("RM " +_cartList[index]['total_price'],
                                                      style: TextStyle(fontSize: 20),),
                                                    )),
                                                ],
                                              ),
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
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: TextField(
                  cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
                  controller: _messageController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).accentColor)
                    ),
                    labelText: "Message",labelStyle: TextStyle(color:Theme.of(context).accentColor),
                    hintText: "Please leave a message"
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Select Delivery Date: ",style: TextStyle(fontSize: 16),),
                          InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              width: screenWidth/3,
                              height: screenHeight/24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Theme.of(context).highlightColor),
                              child: TextFormField(
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller: _dateController,
                                onSaved: (String val) {
                                  _setDate = val;
                                },
                                decoration: InputDecoration(
                                    disabledBorder:
                                        UnderlineInputBorder(borderSide: BorderSide.none),
                                    contentPadding: EdgeInsets.only(bottom: 15.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Select Delivery Time: ",style: TextStyle(fontSize: 16),),
                          InkWell(
                            onTap: () {
                              print(_timeController.text.toString());
                              _selectTime(context);
                            },
                            child: Container(
                              width: screenWidth/3,
                              height: screenHeight/24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Theme.of(context).highlightColor),
                              child: TextFormField(
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                                onSaved: (String val) {
                                  _setTime = val;
                                },
                                enabled: false,
                                keyboardType: TextInputType.text,
                                controller: _timeController,
                                decoration: InputDecoration(
                                    disabledBorder:
                                        UnderlineInputBorder(borderSide: BorderSide.none),
                                    contentPadding: EdgeInsets.only(bottom: 15.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(widget.user.qty == "1" 
                        ? "Order Total (${widget.user.qty} item) :"
                        : "Order Total (${widget.user.qty} items) :",
                        style: TextStyle(fontSize:18),),
                    ),
                    Container(
                      child: Text("RM" + totalPrice.toStringAsFixed(2),
                      style: TextStyle(fontSize:20, color: Colors.red),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  void _makePayment() {

    if(_messageController.text.toString() == ""){
      _message = "-";
    }else{
      _message = _messageController.text.toString();
    }

    _selectedDate = _dateController.text.toString();
    _selectedTime = _timeController.text.toString();
    _address = widget.address.streetAddress + ", " + widget.address.postalCode + ", " + widget.address.city + ", " + widget.address.state;

    if(_address == "Street Address, Postal Code, City, State"){
      Fluttertoast.showToast(
        msg: "Please choose a delivery address",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
    }else if(_selectedDate == "Date" || _selectedTime == "Time"){
      Fluttertoast.showToast(
        msg: "Please select the delivery date & time",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
    }

    else{
     
      print(_selectedDate);
      print(_selectedTime);
      print(totalPrice);
      print(_message);
      print(_address);
    
      Payment payment = new Payment(
        address: _address,
        message: _message,
        totalPayment: totalPrice,
        date: _selectedDate,
        time: _selectedTime,
      );

      Navigator.push(
        context, MaterialPageRoute(builder: (context)=>PaymentSelectionScreen(user: widget.user,payment: payment,))
      );
    }
  }
}