import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTheme {
  static ThemeData get darktheme {
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.red[100],
        focusColor: Colors.red[100],
        fontFamily: 'Georgia',
        textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: Colors.blueGrey[400], 
            cursorColor: Colors.blueGrey[300],
            selectionColor: Colors.blueGrey[300] ),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 96.0, fontFamily: 'Calibri', color: Colors.red[100]),
          headline2: TextStyle(fontSize: 60.0, fontFamily: 'Calibri', color: Colors.red[100]),
          headline3: TextStyle(fontSize: 48.0, fontFamily: 'Calibri', color: Colors.red[200]),
          headline4: TextStyle(fontSize: 34.0, fontFamily: 'Calibri', color: Colors.red[200]),
          headline5: TextStyle(fontSize: 24.0, fontFamily: 'Calibri', color: Colors.white),
          headline6: TextStyle(fontSize: 20.0, fontFamily: 'Calibri', color: Colors.white),
          bodyText1: TextStyle(fontSize: 18.0, fontFamily: 'Calibri', color: Colors.white),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Calibri', color: Colors.white),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.red[100],
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.red[200],
          unselectedItemColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          textTheme: TextTheme(
          headline1: TextStyle(fontSize: 42.0, color: Colors.red[200]),
          headline6: TextStyle(fontSize: 20.0,fontFamily: 'Arial', color: Colors.red[200]),
          bodyText2: TextStyle(fontSize: 14.0, color: Colors.red[200]),
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.white
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusColor: Colors.red[200],
          fillColor: Colors.red[200],
        ),
        iconTheme: IconThemeData(
          color: Colors.red[200],
        ),
        hoverColor:Colors.blue, 
        dividerTheme: DividerThemeData(
          thickness: 1.2,
          color: Colors.white,
        )
        
      );
        
        
  }

  static ThemeData get lighttheme {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red[200],
        accentColor: Colors.red[200],
        focusColor: Colors.red[200],
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.blueGrey[300], 
          cursorColor: Colors.blueGrey[300],
          selectionColor: Colors.blueGrey[200]),
        fontFamily: 'Georgia',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 96.0, fontFamily: 'Calibri', color: Colors.black),
          headline2: TextStyle(fontSize: 60.0, fontFamily: 'Calibri', color: Colors.black),
          headline3: TextStyle(fontSize: 48.0, fontFamily: 'Calibri', color: Colors.black),
          headline4: TextStyle(fontSize: 34.0, fontFamily: 'Calibri', color: Colors.red[200]),
          headline5: TextStyle(fontSize: 24.0, fontFamily: 'Calibri', color: Colors.black),
          headline6: TextStyle(fontSize: 20.0, fontFamily: 'Calibri', color: Colors.black),
          bodyText1: TextStyle(fontSize: 18.0, fontFamily: 'Calibri', color: Colors.black),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Calibri', color: Colors.black),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.red[200],
          
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.red[200],
          unselectedItemColor: Colors.black,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red[200],
            textTheme: TextTheme(
            headline1: TextStyle(fontSize: 30.0, color: Colors.white),
            headline6: TextStyle(fontSize: 20.0,fontFamily: 'Arial',color: Colors.white),
            bodyText2: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
          
          actionsIconTheme: IconThemeData(
            color: Colors.black
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.red[200],
        ),
        dividerTheme: DividerThemeData(
          thickness: 1.2,
          color: Colors.grey[400],
        ),
        

      );

  }
}

  class ThemeProvider extends ChangeNotifier{
    ThemeData _selectedTheme;

    ThemeData light = CustomTheme.lighttheme;
    ThemeData dark = CustomTheme.darktheme;

    ThemeProvider({bool isDarkMode}){
      _selectedTheme= isDarkMode ? dark : light;
    }

    Future<void> swapTheme() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (_selectedTheme == dark) {
        _selectedTheme = light;
        prefs.setBool("isDarkTheme", false);
      } else {
        _selectedTheme = dark;
        prefs.setBool("isDarkTheme", true);
      }
      notifyListeners();
    } 


    ThemeData get getTheme => _selectedTheme;

  }

