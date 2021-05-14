import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'product.dart';
import 'package:little_cake_story/model/user.dart';
import 'category_list.dart';
import 'best_selling_cake_list.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key key,this.user}):super(key: key);
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        flexibleSpace: Container(
          height:50,
        ),
        title: Text('LITTLE CAKE STORY',style: TextStyle(fontFamily: 'Arial'),),
      ),
      body:SingleChildScrollView(
        child: Center(
          child: Column(
            children:<Widget> [
              Container(
                height: 200,
                child: new Carousel(
                  boxFit: BoxFit.cover,
                  images: [
                    Image.asset('assets/images/little_cake_story.png'),
                    Image.asset('assets/images/happy_mother_day.png'),
                    Image.asset('assets/images/happy_father_day.png'),
                    Image.asset('assets/images/bento_cake_series.png'),
                  ],
                  autoplay: true,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds:1000),
                  dotColor: Colors.white,
                  dotIncreasedColor: Theme.of(context).accentColor,
                  dotSize: 7,
                  indicatorBgPadding: 2, 
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0,20,300,10),
                child: Text('Categories',style: Theme.of(context).textTheme.bodyText1,)
              ),
              HorizontalList(),
              Container(
                margin: const EdgeInsets.fromLTRB(0,20,235,10),
                child: Text('Most Selling Cakes',style: Theme.of(context).textTheme.bodyText1,)
              ),
              BestSellingCakeList(),
              Container(
                margin: const EdgeInsets.fromLTRB(0,20,275,10),
                child: Text('New Products',style: Theme.of(context).textTheme.bodyText1,)
              ),
              Container(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Product()),
              ),
              
            ],
          ),
        ),
      )
    );
  }
}

