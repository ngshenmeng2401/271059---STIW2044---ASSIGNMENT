import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:little_cake_story/model/user.dart';

class PaymentHistoryScreen extends StatefulWidget {

  final User user;

  const PaymentHistoryScreen({Key key, this.user}) : super(key: key);
  @override
  _PaymentHistoryScreenState createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {

  List _paymentList;
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;
  final df = new DateFormat('dd-MM-yyyy hh:mm a');

  @override
  void initState() {

    super.initState();
    _loadPaymentHistory();
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        title: Text('Payment History',style: TextStyle(fontFamily: 'Arial')),
      ),
      body: Center(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          child:Column(
            children:[
              _paymentList == null 
              ? Flexible(
                  child: Center(
                    child: Text(titleCenter)),
              )
              : Flexible(
                  child: Center(
                    child: GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: (screenWidth / screenHeight) /0.19,
                      children: List.generate(_paymentList.length, (index){
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: ListTile(
                                    title: Text(_paymentList[index]['payment_id'] + ".  " + _paymentList[index]['payment_method'],style: TextStyle(fontSize:20,fontFamily:'Calibri'),),
                                    subtitle: RichText(
                                      text: TextSpan(
                                        children:<TextSpan>[
                                          TextSpan(text:"RM: " +_paymentList[index]['total_payment']+"\t\t\t\t",style: TextStyle(fontSize: 16),),
                                          TextSpan(text:_paymentList[index]['item']+" item\n",style: TextStyle(fontSize: 16),),
                                          TextSpan(text:df.format(DateTime.parse(_paymentList[index]['date_time'])),style: TextStyle(fontSize: 16),)
                                        ]
                                      )),
                                    trailing: IconButton(
                                      onPressed: (){
                                      },
                                      icon:Icon(Icons.delete,
                                      color: Colors.red[200],)),
                                  ),
                                ),
                              ],
                            )
                          ),
                        );
                      })
                    )
                    ),
              ),
            ]
          )
        ),
      ),
    );
  }

  void _loadPaymentHistory() {

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/load_payment_history.php"),
      body: {
        "email":widget.user.email,
      }).then(
        (response){
          if(response.body == "nodata"){
            titleCenter = "No data";
            return;
          }else{
            var jsondata = json.decode(response.body);
            _paymentList = jsondata["payment_history"];
            titleCenter = "Contain Data";
            setState(() {});
            print(_paymentList);
          }
      }
    );
  }
}