import 'package:flutter/material.dart';
import './notification_setting_screen.dart';
import 'settings/theme_setting_screen.dart';
import './settings/about_screen.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Settings",style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget> [
            Card(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children:[
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text("Notifications"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context)=>NotificationSettingScreen())
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.lock),
                    title: Text("Change Password"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text("Change Language"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.format_paint),
                    title: Text("Change Theme"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context)=>ThemeSettingScreen())
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text("About "),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context)=>AboutScreen())
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.help),
                    title: Text("Help"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){

                    },
                  ),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}