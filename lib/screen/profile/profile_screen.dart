import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:little_cake_story/model/theme.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:provider/provider.dart';
import '../login_screen.dart';
import 'settings/setting_screen.dart';

class MeScreen extends StatefulWidget {
  final User user;
  const MeScreen({Key key,this.user}):super(key: key);

  @override
  _MeScreenState createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {

  double screenHeight, screenWidth;
  String pathAsset='assets/images/profile.png';
  File _image;
  TextEditingController _descCtrl = new TextEditingController();
  final List<String> title = <String>['Payment','Payment History','Setting','Logout'];

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        title: Text('LITTLE CAKE STORY'),
        actions: [
          IconButton(
              icon: Icon(Icons.brightness_6), 
              color: Colors.white,
              onPressed: (){
                ThemeProvider themeProvider = Provider.of<ThemeProvider>(
                  context,
                  listen: false);
                  themeProvider.swapTheme();
              })
        ],
      ),
      body:Center(
        child:Container(

            child: SingleChildScrollView(
              child: Column(
                children:[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Column(
                        children:[
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                height:screenHeight/5,
                                width: screenWidth/4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color:Theme.of(context).appBarTheme.actionsIconTheme.color),
                                  image: DecorationImage(
                                    image: _image == null ? AssetImage(pathAsset) : FileImage(_image),
                                    fit: BoxFit.scaleDown,
                                  )
                                ),
                              ),
                              Container(
                                // color: Colors.blue,
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Text(widget.user.firstName+" "+widget.user.lastName,
                                style: TextStyle(fontSize:24),),
                              ),
                              Container(
                                height:screenHeight/6,
                                // color: Colors.blue,
                                width: screenWidth/13,
                                  child:Stack(
                                    alignment: Alignment.topRight,
                                    children:[
                                      Container(
                                        child:IconButton(
                                          icon: Icon(Icons.edit),
                                          tooltip: "Edit Profile",
                                          onPressed: (){

                                          },
                                        )
                                      )
                                    ]
                                  )
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 30, 0),
                            child: Column(
                              children: [
                                Row(
                                  children:<Widget>[
                                  Icon(Icons.phone),
                                  SizedBox(width: 20,),
                                  Text(widget.user.phoneNo),
                                  ]
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children:<Widget>[
                                  Icon(Icons.email),
                                  SizedBox(width: 20,),
                                  Text(widget.user.email),
                                  ]
                                )
                              ],
                              
                            ),
                          ),
                        ]
                      ),
                    ) ,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 2,color: Theme.of(context).dividerTheme.color),
                              right: BorderSide(width: 2,color: Theme.of(context).dividerTheme.color),
                              bottom: BorderSide(width: 2,color: Theme.of(context).dividerTheme.color),
                            )
                          ),
                          child: Column(
                            children:[
                              Text("1400",style: Theme.of(context).textTheme.headline4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[
                                  // Icon(Icons.account_balance_wallet,),
                                  Text(
                                    "Wallet",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ]
                              )
                            ]
                          )
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 2,color: Theme.of(context).dividerTheme.color),
                              left: BorderSide(width: 2,color: Theme.of(context).dividerTheme.color),
                              bottom: BorderSide(width: 2,color: Theme.of(context).dividerTheme.color),
                            )
                          ),
                          child: Column(
                            children:[
                              Text("12",style: Theme.of(context).textTheme.headline4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[
                                  // Icon(Icons.event_note,),
                                  Text(
                                    "Orders",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ]
                              )
                            ]
                          )
                        ),
                      ]
                    ),
                  ),
                  ProfileMenu(
                    icon: Icon(Icons.favorite),
                    text: "Favourite",
                    press: (){},
                  ),
                  ProfileMenu(
                    icon: Icon(Icons.payment),
                    text: "Payment",
                    press: (){},
                  ), 
                  ProfileMenu(
                    icon: Icon(Icons.history),
                    text: "Payment History",
                    press: (){},
                  ), 
                  ProfileMenu(
                    icon: Icon(Icons.settings),
                    text: "Settings",
                    press: (){
                      Navigator.push(
                        context,MaterialPageRoute(builder: (context)=>SettingScreen())
                      );  
                    },
                  ),
                  Divider(),
                  ProfileMenu(
                    icon: Icon(Icons.logout,color: Colors.red,),
                    text: "Logout",
                    press: (){
                      Navigator.pushReplacement(
                        context,MaterialPageRoute(builder: (context)=>LoginScreen())
                      );                    
                    },
                  ), 
                ]
              ),
            ),
        )
      )
    );
  }
}

class ProfileMenu extends StatelessWidget {

  final String text;
  final Icon icon;
  final VoidCallback press;

  const ProfileMenu({
    Key key, 
    @required this.text, 
    @required this.icon, 
    @required this.press, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: FlatButton(
        height: 20,
        // highlightColor:Colors.grey[400] ,
        splashColor: Colors.grey[400],
        padding: EdgeInsets.all(20),
        onPressed: press,
        child: Row(
          children: [
            icon,
            SizedBox(width:20),
            Expanded(
              child: Text(text,
              style:Theme.of(context).textTheme.bodyText1
            )),
          ],
        ),

      ),
    );
  }
}

