import 'package:flutter/material.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/bottom_navigation_bar.dart';

class PaymentCompleteScreen extends StatefulWidget {

  final User user;

  const PaymentCompleteScreen({Key key, this.user}) : super(key: key);

  @override
  _PaymentCompleteScreenState createState() => _PaymentCompleteScreenState();
}

class _PaymentCompleteScreenState extends State<PaymentCompleteScreen> {
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Success',
          style: TextStyle(fontFamily: 'Arial'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Image.asset('assets/images/success.gif',width: 200,height: 200,),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
              child: Text(
                "Successfull",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 30),
              child: Text(
                "Your payment was done successfully",
                style: TextStyle(fontSize: 16),
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minWidth: screenWidth / 1.1,
              height: screenHeight / 18,
              child: Text(
                'OK',
                style: TextStyle(
                    fontSize: 18, color: Colors.white, fontFamily: 'Arial'),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,MaterialPageRoute(builder: (context)=>BottomNavigationWidget(user: widget.user))
                );
              },
              color: Colors.red[200],
            ),
          ],
        ),
      ),
    );
  }
}
