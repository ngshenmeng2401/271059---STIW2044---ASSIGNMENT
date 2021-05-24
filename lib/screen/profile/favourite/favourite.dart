import 'package:flutter/material.dart';
import 'package:little_cake_story/model/user.dart';

class FavouriteProductScreen extends StatefulWidget {

  final User user;
  const FavouriteProductScreen({Key key, this.user}) : super(key: key);

  @override
  _FavouriteProductScreenState createState() => _FavouriteProductScreenState();
}

class _FavouriteProductScreenState extends State<FavouriteProductScreen> {

  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        title: Text('Favourite',style: TextStyle(fontFamily: 'Arial')),

      ),
    );
  }
}