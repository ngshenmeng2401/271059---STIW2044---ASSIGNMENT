import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'notification_screen.dart';
import 'cart_screen.dart';
import 'me_screen.dart';
import 'user.dart';

class BottomNavigationWidget extends StatefulWidget {

  final User user;

  const BottomNavigationWidget({Key key, this.user}) : super(key: key);

  @override
  BottomNavigationWidgetState createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {

  int _currentIndex = 0;
  List <Widget> list = List();

  @override
  void initState() {
    list
      ..add(HomeScreen())
      ..add(NotificationScreen())
      ..add(CartScreen())
      ..add(MeScreen());
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
              Icons.alarm,
            ),
            title:Text(
               'Notification',
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
