import 'model/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return runApp(ChangeNotifierProvider(
    child: MyApp(),
    create:(BuildContext context) =>
      ThemeProvider(isDarkMode: prefs.getBool("isDarkTheme")),
  ));
}
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context,themeProvider,child){
        return MaterialApp(
        title: 'LITTLE CAKE STORY',
        theme: themeProvider.getTheme,
        home: SplashScreen()
        );
      },
    );
  }
}


