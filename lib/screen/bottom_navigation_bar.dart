import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'search/search_screen.dart';
import 'cart/cart_screen.dart';
import 'profile/profile_screen.dart';
import '../model/user.dart';

class BottomNavigationWidget extends StatefulWidget {

  final User user;
  const BottomNavigationWidget({Key key, this.user}) : super(key: key);

  @override
  BottomNavigationWidgetState createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {

  int _currentIndex = 0;
  List <Widget> list;

  @override
  void initState() {
    list = [
      HomeScreen(),
      SearchScreen(),
      CartScreen(),
      ProfileScreen(user: widget.user,)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title:Text(
               'Home',
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            title:Text(
               'Search',
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            title:Text(
               'Cart',
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
            ),
            title:Text(
               'Me',
            )
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
            _currentIndex=index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
      
    );
  }
}
