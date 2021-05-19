import 'package:flutter/material.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/profile/my_product/my_cake_list.dart';
import 'package:little_cake_story/screen/profile/my_product/my_puff_list.dart';
import 'package:little_cake_story/screen/profile/my_product/my_tarts_list.dart';

import 'my_bento_cake_list.dart';
import 'my_cup_cake_list.dart';

class ProductMenu extends StatefulWidget {

  final User user;
  const ProductMenu({Key key, this.user}) : super(key: key);

  @override
  _ProductMenuState createState() => _ProductMenuState();
}

class _ProductMenuState extends State<ProductMenu> {

  double screenHeight, screenWidth;
  
  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        title: Text('Category',style: TextStyle(fontFamily: 'Arial')),),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          child: Column(
            children: [
              ProductDashboardList(
                name: "Bento Cake",
                image: "assets/images/bento_cake_menu.jpg",
                press: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>MyBentoCakeListScreen(user: widget.user,))
                  );
                },
              ),
              ProductDashboardList(
                name: "Cake",
                image: "assets/images/cake_menu.jpg",
                press: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>MyCakeListScreen(user: widget.user,))
                  );
                },
              ),
              ProductDashboardList(
                name: "Cream Puff",
                image: "assets/images/puff_menu.webp",
                press: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>MyPuffsListScreen(user: widget.user,))
                  );
                },
              ),
              ProductDashboardList(
                name: "Cup Cake",
                image: "assets/images/cup_cake_menu.jpg",
                press: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>MyCupCakeListScreen(user: widget.user,))
                  );
                },
              ),
              ProductDashboardList(
                name: "Tart",
                image: "assets/images/tart_menu.jpg",
                press: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>MyTartsListScreen(user: widget.user,))
                  );
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}

class ProductDashboardList extends StatelessWidget {

  final String name;
  final String image;
  final Color color;
  final VoidCallback press;

  const ProductDashboardList({Key key, this.name, this.image, this.color, this.press}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    double screenHeight, screenWidth;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: InkWell(
        highlightColor: Theme.of(context).highlightColor,
        onTap: press,
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          height: screenHeight/5,
          width: screenWidth,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(image,
                  fit: BoxFit.cover,),
                ),
              ),
              Container(
                height: screenHeight/5,
                decoration: BoxDecoration(
                  color:Colors.black38,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Center(
                child: Text(name,
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'Calibri',
                  fontWeight: FontWeight.bold,
                  color: Colors.white)
                )),
            ],
          ),
        ),
            ),
    );
  }
}
