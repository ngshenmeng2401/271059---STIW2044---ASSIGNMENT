import 'package:flutter/material.dart';
import 'add_cake_screen.dart';

class CakeListScreen extends StatefulWidget {
  @override
  _CakeListScreenState createState() => _CakeListScreenState();
}

class _CakeListScreenState extends State<CakeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Cakes',style: TextStyle(fontFamily: 'Arial')),
        actions: [
          IconButton(
              icon: Icon(Icons.add), 
              color: Colors.white,
              onPressed: (){
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context)=>AddCakeScreen())
                );
          }),
        ],
      ),
    );
  }
}
