import 'screen/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'model/user.dart';

class MainScreen extends StatefulWidget {

  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('LITTLE CAKE STORY',style: TextStyle(fontFamily: 'Arial'),),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // DrawerHeader(
            //   child: Text('Header'),
            //   decoration: BoxDecoration(
            //     color: Colors.blue[600],
            //   ),),
            UserAccountsDrawerHeader(
              accountName: Text(widget.user.firstName+" "+widget.user.lastName), 
              accountEmail: Text(widget.user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).platform == TargetPlatform.android
                                  ? Colors.blueAccent
                                  :Colors.white,
                                  child: Text(widget.user.email
                                              .toString()
                                              .substring(0,1)
                                              .toUpperCase(),
                                              style: TextStyle(fontSize:40)),
                                  backgroundImage: AssetImage("assets/images/profile.png",),
                                              
              ),),
            ListTile(
              title: Text("Home"),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Notification"),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                context,MaterialPageRoute(builder: (context)=>SearchScreen())
                );
              },
            ),
            ListTile(
              title: Text("Feeds"),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Cart"),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("User Profile"),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),),
      body: SingleChildScrollView(
        child:Column(
          children: [
            Text(widget.user.firstName+ " " + widget.user.lastName),
            Text(widget.user.email),
            Text(widget.user.dateReg),
            Text(widget.user.rating),
            Text(widget.user.credit),
            Text(widget.user.status),

          ],
        )
      ),
    );
  }
}