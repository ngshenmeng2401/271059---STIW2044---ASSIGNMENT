import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('LITTLE CAKE STORY',style: TextStyle(fontFamily: 'Arial'),),
      ),
      body:Center(
        child: Text('Cart'),
      )
    );
  }
}