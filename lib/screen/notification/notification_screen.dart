import 'package:flutter/material.dart';
import 'package:little_cake_story/model/user.dart';

class NotificationScreen extends StatelessWidget {
  final User user;
  const NotificationScreen({Key key,this.user}):super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('LITTLE CAKE STORY',style: TextStyle(fontFamily: 'Arial'),),
      ),
      body:Center(
        child: Text('Notification'),
      )
    );
  }
}