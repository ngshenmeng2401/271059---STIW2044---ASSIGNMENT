import 'package:flutter/material.dart';
import 'add_puff_screen.dart';

class PuffsListScreen extends StatefulWidget {
  @override
  _PuffsListScreenState createState() => _PuffsListScreenState();
}

class _PuffsListScreenState extends State<PuffsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Puffs',style: TextStyle(fontFamily: 'Arial')),
        actions: [
          IconButton(
              icon: Icon(Icons.add), 
              color: Colors.white,
              onPressed: (){
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context)=>AddPuffScreen())
                );
          }),
        ],
      ),
    );
  }
}