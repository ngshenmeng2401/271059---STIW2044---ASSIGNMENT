import 'package:flutter/material.dart';
import 'add_tart_screen.dart';

class TartsListScreen extends StatefulWidget {
  @override
  _TartsListScreenState createState() => _TartsListScreenState();
}

class _TartsListScreenState extends State<TartsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Tarts',style: TextStyle(fontFamily: 'Arial')),
        actions: [
          IconButton(
              icon: Icon(Icons.add), 
              color: Colors.white,
              onPressed: (){
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context)=>AddTartScreen())
                );
          }),
        ],
      ),
    );
  }
}