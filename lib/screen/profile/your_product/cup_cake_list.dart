import 'package:flutter/material.dart';
import 'add_cup_cake_screen.dart';

class CupCakeListScreen extends StatefulWidget {
  @override
  _CupCakeListScreenState createState() => _CupCakeListScreenState();
}

class _CupCakeListScreenState extends State<CupCakeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Cup Cakes',style: TextStyle(fontFamily: 'Arial')),
        actions: [
          IconButton(
              icon: Icon(Icons.add), 
              color: Colors.white,
              onPressed: (){
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context)=>AddCupCakeScreen())
                );
          }),
        ],
      ),
    );
  }
}