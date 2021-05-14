import 'package:flutter/material.dart';
import 'add_bento_cake_screen.dart';

class BentoCakeListScreen extends StatefulWidget {
  @override
  _BentoCakeListScreenState createState() => _BentoCakeListScreenState();
}

class _BentoCakeListScreenState extends State<BentoCakeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Bento Cakes',style: TextStyle(fontFamily: 'Arial')),
        actions: [
          IconButton(
              icon: Icon(Icons.add), 
              color: Colors.white,
              onPressed: (){
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context)=>AddBentoCakeScreen())
                );
          }),
        ],
      ),
    );
  }
}