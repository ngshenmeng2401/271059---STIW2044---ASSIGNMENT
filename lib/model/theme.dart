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
          headline2: TextStyle(fontSize: 38.0, fontFamily: 'Calibri', color: Colors.red[200]),
          headline3: TextStyle(fontSize: 14.0, fontFamily: 'Calibri', color: Colors.black,decoration: TextDecoration.lineThrough),
          headline4: TextStyle(fontSize: 36.0, fontFamily: 'Calibri', color: Colors.red[200]),
          headline5: TextStyle(fontSize: 24.0, fontFamily: 'Calibri', color: Colors.white),
          headline6: TextStyle(fontSize: 20.0, fontFamily: 'Calibri', color: Colors.white),
          bodyText1: TextStyle(fontSize: 18.0, fontFamily: 'Calibri', color: Colors.white),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Calibri', color: Colors.white),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.red[100],
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[900],
          selectedItemColor: Colors.red[200],
          unselectedItemColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          textTheme: TextTheme(
          headline1: TextStyle(fontSize: 42.0, color: Colors.red[200]),
          headline2: TextStyle(fontSize: 16.0, fontFamily: 'Calibri', color: Colors.white),
          headline3: TextStyle(fontSize: 14.0, fontFamily: 'Calibri', color: Colors.black,decoration: TextDecoration.lineThrough),
          headline4: TextStyle(fontSize: 36.0, fontFamily: 'Calibri', color: Colors.red[200]),
          headline5: TextStyle(fontSize: 24.0, fontFamily: 'Calibri', color: Colors.white),
          headline6: TextStyle(fontSize: 20.0,fontFamily: 'Arial', color: Colors.red[200]),
          bodyText2: TextStyle(fontSize: 14.0, color: Colors.red[200]),
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusColor: Colors.red[200],
          fillColor: Colors.red[200],
        ),
        iconTheme: IconThemeData(
          color: Colors.red[200],
        ),
        highlightColor: Colors.grey[700],
        hoverColor:Colors.grey[800], 
        dividerTheme: DividerThemeData(
          thickness: 1.2,
          color: Colors.white54,
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
          headline2: TextStyle(fontSize: 38.0, fontFamily: 'Calibri', color: Colors.red[200]),
          headline3: TextStyle(fontSize: 14.0, fontFamily: 'Calibri', color: Colors.black,decoration: TextDecoration.lineThrough),
          headline4: TextStyle(fontSize: 36.0, fontFamily: 'Calibri', color: Colors.red[200]),
          headline5: TextStyle(fontSize: 24.0, fontFamily: 'Calibri', color: Colors.black),
          headline6: TextStyle(fontSize: 20.0, fontFamily: 'Calibri', color: Colors.black),
          bodyText1: TextStyle(fontSize: 18.0, fontFamily: 'Calibri', color: Colors.black),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Calibri', color: Colors.black),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.red[200],
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[300],
          selectedItemColor: Colors.red[200],
          unselectedItemColor: Colors.black,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red[200],
            textTheme: TextTheme(
            headline1: TextStyle(fontSize: 30.0, fontFamily: 'Calibri', color: Colors.white),
            headline2: TextStyle(fontSize: 16.0, fontFamily: 'Calibri', color: Colors.black),
            headline3: TextStyle(fontSize: 14.0, fontFamily: 'Calibri', color: Colors.black,decoration: TextDecoration.lineThrough),
            headline4: TextStyle(fontSize: 36.0, fontFamily: 'Calibri', color: Colors.red[200]),
            headline5: TextStyle(fontSize: 24.0, fontFamily: 'Calibri', color: Colors.black),
            headline6: TextStyle(fontSize: 20.0, fontFamily: 'Calibri', color: Colors.white),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Calibri', color: Colors.white),
          ),
          
          actionsIconTheme: IconThemeData(
            color: Colors.white
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.red[200],
        ),
        highlightColor: Colors.grey[200],
        hoverColor:Colors.grey[200],
        dividerTheme: DividerThemeData(
          thickness: 1.2,
          color: Colors.grey[400],
        ),
        
      );

  }
}

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;
  
  ThemeNotifier() {
    _darkTheme = false;
    _loadFromPrefs();
  }

  toggleDarkTheme() {
    _darkTheme = true;
    _saveToPrefs();
    notifyListeners();
  }

  toggleLightTheme() {
    _darkTheme = false;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if(_prefs == null)
      _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs()async {
    await _initPrefs();
    _prefs.setBool(key, _darkTheme);
  }

}