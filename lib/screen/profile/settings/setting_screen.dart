import 'package:flutter/material.dart';
import 'package:little_cake_story/model/user.dart';
import 'notification_setting_screen.dart';
import 'theme_setting_screen.dart';
import 'about_screen.dart';
import 'help_support_screen.dart';
import 'language_setting_screen.dart';
import 'change_password.dart';
import 'manage_address_screen.dart';

class SettingScreen extends StatefulWidget {

  final User user;

  const SettingScreen({Key key, this.user}) : super(key: key);

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
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children:[
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text("Notifications",style: Theme.of(context).textTheme.bodyText1,),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context)=>NotificationSettingScreen())
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text("Manage Address",style: Theme.of(context).textTheme.bodyText1,),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context)=>ManageAddressScreen(user: widget.user))
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.lock),
                    title: Text("Change Password",style: Theme.of(context).textTheme.bodyText1,),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context)=>ChangePasswordScreen(user: widget.user))
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text("Change Language",style: Theme.of(context).textTheme.bodyText1,),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context)=>LanguageSettingScreen())
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.format_paint),
                    title: Text("Change Theme",style: Theme.of(context).textTheme.bodyText1,),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context)=>ThemeSettingScreen())
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text("About",style: Theme.of(context).textTheme.bodyText1,),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context)=>AboutScreen())
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.help),
                    title: Text("Help & Support",style: Theme.of(context).textTheme.bodyText1,),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context)=>HelpSupportScreen())
                      );
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