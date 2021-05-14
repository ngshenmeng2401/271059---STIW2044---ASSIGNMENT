import 'package:flutter/material.dart';
import 'package:little_cake_story/model/user.dart';

class SearchScreen extends StatefulWidget {
  final User user;
  const SearchScreen({Key key,this.user}):super(key: key);
  
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        title: Text('LITTLE CAKE STORY',style: TextStyle(fontFamily: 'Arial'),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child:Column(
            children:[
              ListTile(
                leading: Icon(Icons.search,color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,),
                title: TextField(
                  decoration: InputDecoration(
                  hintText: "Search",hintStyle:TextStyle(fontSize:18,fontFamily: 'Calibri'),
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: null,

                ),
              )
            ]
          )
        ),
      ),
    );
  }
}