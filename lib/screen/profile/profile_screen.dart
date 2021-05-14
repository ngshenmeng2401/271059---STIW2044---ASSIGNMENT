import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/profile/payment/payment_selection.dart';
import '../login_screen.dart';
import 'settings/setting_screen.dart';
import 'edit_profile_screen.dart';
import 'your_product/product_list_screen.dart';

class ProfileScreen extends StatefulWidget {
  
  final User user;
  const ProfileScreen({Key key,this.user}):super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  double screenHeight, screenWidth;
  String pathAsset='assets/images/profile.png';
  File _image;
  TextEditingController _descCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        title: Text('LITTLE CAKE STORY',style: TextStyle(fontFamily: 'Arial')),
      ),
      body:Center(
        child:Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                      child: Column(
                        children:<Widget>[
                          Container(
                            height:screenHeight/6.5,
                            width: screenWidth/4,
                            child: Container(
                              child:Stack(
                                children:[
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
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        color: Colors.red[200],
                                        shape: BoxShape.circle,
                                      ),
                                      child:IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(Icons.edit_outlined,
                                        color: Theme.of(context).appBarTheme.actionsIconTheme.color,
                                        size:20,),
                                      onPressed: (){
                                        Navigator.pushReplacement(
                                          context,MaterialPageRoute(builder: (context)=>EditProfileScreen(user: widget.user))
                                        );
                                      },)
                                    ),
                                  )
                                ]
                              ),
                            )
                          ),
                          Container(
                            padding:const EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Column(
                              children:[
                                Text(widget.user.firstName+" "+widget.user.lastName,
                                style: Theme.of(context).textTheme.headline6,),
                                SizedBox(height:5),
                                Text(widget.user.email,
                                style: Theme.of(context).textTheme.bodyText2,),
                                SizedBox(height:5),
                                Text(widget.user.phoneNo,
                                style: Theme.of(context).textTheme.bodyText2,),
                              ]
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children:[
                         ProfileMenu(
                          icon: Icon(Icons.cake),
                          text: "Your Product",
                          press: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context)=>ProductDashboardScreen())
                            );
                          },
                        ),
                        ProfileMenu(
                          icon: Icon(Icons.favorite_outline),
                          text: "Favourite",
                          press: (){},
                        ),
                        ProfileMenu(
                          icon: Icon(Icons.payment),
                          text: "Payment",
                          press: (){
                            Navigator.pushReplacement(
                              context,MaterialPageRoute(builder: (context)=>PaymentSelectionScreen(user: widget.user,))
                            );
                          },
                        ), 
                        ProfileMenu(
                          icon: Icon(Icons.history),
                          text: "Payment History",
                          press: (){},
                        ), 
                        ProfileMenu(
                          icon: Icon(Icons.settings_outlined),
                          text: "Settings",
                          press: (){
                            Navigator.push(
                              context,MaterialPageRoute(builder: (context)=>SettingScreen(user: widget.user))
                            );  
                          },
                        ),
                        ProfileMenu(
                          icon: Icon(Icons.logout,color: Colors.red,),
                          text: "Logout",
                          press: (){
                            Navigator.pushReplacement(
                              context,MaterialPageRoute(builder: (context)=>LoginScreen())
                            );                    
                          },
                          hasNavigation: false,
                        ),
                      ]
                    ),
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
  final bool hasNavigation;
  final VoidCallback press;

  const ProfileMenu({
    Key key, 
    this.text, 
    this.icon, 
    this.press, 
    this.hasNavigation=true, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.fromLTRB(30, 10, 30,10),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Theme.of(context).hoverColor,
        onPressed: press,
        child: Row(
          children: <Widget>[
            SizedBox(width:10),
            icon,
            SizedBox(width: 15),
            Text(text,style: Theme.of(context).textTheme.bodyText1,),
            Spacer(),
            if (this.hasNavigation)
              Icon(
                Icons.keyboard_arrow_right,
              ),
          ],
        ),
      ),
    );
  }
}

