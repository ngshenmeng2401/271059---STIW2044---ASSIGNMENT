import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:little_cake_story/model/payment.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/cart/payment_complete.dart';
import 'package:http/http.dart' as http;

class PaymentSelectionScreen extends StatefulWidget {

  final User user;
  final Payment payment;
  const PaymentSelectionScreen({Key key, this.user, this.payment}) : super(key: key);

  @override
  _PaymentSelectionScreenState createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {

  String _dateTime, paymentMethod;
  int value = 0;
  final paymentSelectionList = [
    'Credit Card / Debit Card',
    'Online Transfer',
    'Cash on Delivery',
    'Paypal',
    'E Wallet',
  ];

  final paymentIcons = [
    Icons.credit_card,
    Icons.transfer_within_a_station,
    Icons.money_off,
    Icons.payment,
    Icons.account_balance_wallet,
  ];
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: TextStyle(fontFamily: 'Arial'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 30, 0),
            child: Text("Choose your payment method",
            style:TextStyle(fontSize: 28,height: 1.5,fontWeight: FontWeight.bold,letterSpacing: 1.2)),),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(10),
                color: Theme.of(context).hoverColor,
              ),
              padding: const EdgeInsets.all(20),
              height: screenHeight/1.8,
              child: ListView.separated(
                itemCount: paymentSelectionList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(paymentIcons[index]),
                    title: Text(paymentSelectionList[index],
                    style: TextStyle(fontFamily: 'Calibri',fontSize: 16),),
                    trailing: Radio(
                      activeColor: Colors.red[200],
                      value: index,
                      groupValue: value,
                      onChanged: (index) {
                        setState(() {
                          value = index;
                        });
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            ),
          ),
          SizedBox(height:30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minWidth: screenWidth/1.1,
            height: screenHeight/18,
            child: Text(
              'PAY',
              style: TextStyle(
                  fontSize: 18, color: Colors.white, fontFamily: 'Arial'),
            ),
            onPressed: () {
              _checkPaymentMethod();
            },
            color: Colors.red[200],
          ),
        ],
      ),
    );
  }

  void _checkPaymentMethod(){

    if(value == 0){
      paymentMethod = "Card Payment";
    }else if(value == 1){
      paymentMethod = "Online Transfer";
    }else if(value == 2){
      paymentMethod = "Cash";
    }else if(value == 3){
      paymentMethod = "Paypal";
    }else if(value == 4){
      paymentMethod = "E Wallet";
    }

    _makePayment(paymentMethod);
  }

  void _makePayment(String paymentMethod) {

    _dateTime = widget.payment.date + " " + widget.payment.time;
    print(_dateTime);
    print(widget.payment.message);
    print(widget.payment.address);
    print(widget.payment.totalPayment);
    print(widget.user.email);
    print(paymentMethod);

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/add_payment.php"),
      body: {
        "dateTime":_dateTime,
        "email":widget.user.email,
        "message":widget.payment.message,
        "address":widget.payment.address,
        "total_payment":widget.payment.totalPayment.toString(),
        "paymentMethod":paymentMethod,
        "item_qty":widget.user.qty,

      }).then(
        (response){
          print(response.body);

          if(response.body=="success"){
            Fluttertoast.showToast(
            msg: "Pay Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);

            setState(() {
              widget.user.qty = "0";
            });

          }
          else {
            Fluttertoast.showToast(
            msg: "Pay Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);

          }
        }
      );

    Navigator.pushReplacement(
      context,MaterialPageRoute(builder: (context)=>PaymentCompleteScreen(user: widget.user,))
    );
  }
}
