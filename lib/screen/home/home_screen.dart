import 'package:flutter/material.dart';
import 'package:little_cake_story/model/user.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key key,this.user}):super(key: key);
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('LITTLE CAKE STORY',style: TextStyle(fontFamily: 'Arial'),),
      ),
      body:Center(
        child: Text('HOME'),
      )
    );
  }
}