import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:little_cake_story/model/payment.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/cart/payment_complete.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class PaymentSelectionScreen extends StatefulWidget {

  final User user;
  final Payment payment;
  const PaymentSelectionScreen({Key key, this.user, this.payment}) : super(key: key);

  @override
  _PaymentSelectionScreenState createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {

  String _dateTime, name;
  Completer<WebViewController> _controller = Completer<WebViewController>();
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    _dateTime = widget.payment.date + " " + widget.payment.time;
    name = widget.user.firstName + " " + widget.user.lastName;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: TextStyle(fontFamily: 'Arial'),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: WebView(
                  initialUrl:
                      'https://javathree99.com/s271059/littlecakestory/php/generate_bill.php?email=' +
                          widget.user.email +
                          '&phoneNo=' +
                          widget.user.phoneNo +
                          '&name=' +
                          name +
                          '&dateTime=' +
                          _dateTime +
                          '&message=' +
                          widget.payment.message +
                          '&address=' +
                          widget.payment.address +
                          '&item_qty=' +
                          widget.user.qty +
                          '&totalPayment=' +
                          widget.payment.totalPayment.toString(),
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
