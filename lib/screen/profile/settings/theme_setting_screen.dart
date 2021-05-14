import 'package:flutter/material.dart';
import 'package:little_cake_story/model/theme.dart';
import 'package:provider/provider.dart';

class ThemeSettingScreen extends StatefulWidget {
  
  @override
  _ThemeSettingScreenState createState() => _ThemeSettingScreenState();
}

class _ThemeSettingScreenState extends State<ThemeSettingScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:Text("Theme Setting",style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child:Column(
                children:<Widget>[
                  Consumer<ThemeNotifier>(
                    builder:(context, notifier, child)=> ListTile(
                      title: Text("Dark Mode",style: Theme.of(context).textTheme.bodyText1),
                      subtitle: Text("The primary color will become dark",style: Theme.of(context).textTheme.bodyText2),
                      trailing: Radio<bool>(
                        activeColor: Colors.red[200],
                        value: true,
                        groupValue: notifier.darkTheme, 
                        onChanged: (value){
                          notifier.toggleDarkTheme();
                        },
                      ),
                      selected: true,
                  ),
                    ),
                  Consumer<ThemeNotifier>(
                    builder:(context, notifier, child)=> ListTile(
                      title: Text("Light Mode",style: Theme.of(context).textTheme.bodyText1),
                      subtitle: Text("The primary color will become white",style: Theme.of(context).textTheme.bodyText2),
                      trailing: Radio<bool>(
                        activeColor: Colors.red[200],
                        value: false,
                        groupValue: notifier.darkTheme, 
                        onChanged: (value){
                          notifier.toggleLightTheme();
                        },
                      ),
                      selected: true,
                    ),
                  ),
                  ListTile(
                    title: Text("System Default",style: Theme.of(context).textTheme.bodyText1),
                    subtitle: Text("The primary color will base on system theme",style: Theme.of(context).textTheme.bodyText2),
                    trailing: Radio(
                      value: null,
                      groupValue: false, 
                      onChanged: (value){
                      },
                    ),
                    selected: false,
                  ),
                  // Consumer<ThemeNotifier>(
                  //   builder:(context, notifier, child)=> ListTile(
                  //     title: Text("Dark Mode",style: Theme.of(context).textTheme.bodyText1),
                  //     subtitle: Text("The primary color will become dark",style: Theme.of(context).textTheme.bodyText2),
                  //     trailing: Switch(
                  //       activeColor: Colors.red[200],
                  //       value: notifier.darkTheme, 
                  //       onChanged: (value){
                  //         notifier.toggleTheme();
                  //       }),
                  //     selected: true,
                  //   ),
                  // ),
                ]
              )
            )
          ],
        ),
      ),
    );
  }

}