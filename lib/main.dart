import 'model/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/splash_screen.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
} 

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier(),),
      ],
        child: Consumer<ThemeNotifier>(
          builder: (context,ThemeNotifier notifier,child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'LITTLE CAKE STORY',
            theme: notifier.darkTheme ? CustomTheme.darktheme : CustomTheme.lighttheme,
            home: SplashScreen()
          );
        },
      ),
    );
  }
}