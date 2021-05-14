import 'package:flutter/material.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/cart/cart_screen.dart';
import 'package:little_cake_story/screen/profile/payment/payment_complete.dart';

class PaymentSelectionScreen extends StatefulWidget {

  final User user;
  const PaymentSelectionScreen({Key key, this.user}) : super(key: key);

  @override
  _PaymentSelectionScreenState createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed: (){
            Navigator.pushReplacement(
              context,MaterialPageRoute(builder: (context) =>CartScreen()));
            },
          ),
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
              Navigator.pushReplacement(
                  context,MaterialPageRoute(builder: (context)=>PaymentCompleteScreen(user: widget.user,))
                );
            },
            color: Colors.red[200],
          ),
        ],
      ),
    );
  }
}
