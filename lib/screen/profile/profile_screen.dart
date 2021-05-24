import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/cart/cart_screen.dart';
import 'package:little_cake_story/screen/profile/my_product/product_dashboard.dart';
import 'package:little_cake_story/screen/profile/payment_history/payment_history.dart';
import '../login_screen.dart';
import 'favourite/favourite.dart';
import 'settings/setting_screen.dart';
import 'edit_profile_screen.dart';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {

    super.initState();
    _loadCartQuantity();
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        title: Text('LITTLE CAKE STORY',style: TextStyle(fontFamily: 'Arial')),
        actions:<Widget> [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
            child: Container(
              width: 30,
              height: 10,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>CartScreen(user: widget.user,))
                  );
                },
                child: Stack(
                  children:<Widget> [
                    Icon(Icons.shopping_cart_outlined,
                      size: 28,
                      color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,),
                          color: Colors.red[300],
                          shape: BoxShape.circle),
                        child: Text(widget.user.qty,
                          style: TextStyle(fontSize: 12,color:Theme.of(context).bottomNavigationBarTheme.unselectedItemColor),
                          textAlign: TextAlign.center,)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
                              context, MaterialPageRoute(builder: (context)=>ProductMenu(user: widget.user,))
                            );
                          },
                        ),
                        ProfileMenu(
                          icon: Icon(Icons.favorite_outline),
                          text: "Favourite",
                          press: (){
                            Navigator.push(
                              context,MaterialPageRoute(builder: (context)=>FavouriteProductScreen(user: widget.user))
                            );
                          },
                        ),
                        ProfileMenu(
                          icon: Icon(Icons.history),
                          text: "Payment History",
                          press: (){
                            Navigator.push(
                              context,MaterialPageRoute(builder: (context)=>PaymentHistoryScreen(user: widget.user))
                            ); 
                          },
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
  void _loadCartQuantity(){

  http.post(
    Uri.parse("https://javathree99.com/s271059/littlecakestory/php/load_cart_quantity.php"),
    body: {
      "email":widget.user.email,
    }).then(
      (response){
        print(response.body);

        if(response.body=="nodata"){
        }
        else {
          widget.user.qty = response.body;
        }
      }
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

