import 'package:flutter/material.dart';

class NotificationSettingScreen extends StatefulWidget {
  @override
  _NotificationSettingScreenState createState() => _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {

  var _value1 = false,_value2 = false,_value3 = false,_value4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Notification Settings",style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget> [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                children: [
                  ListTile(
                    title: Text("Received Notification",style: Theme.of(context).appBarTheme.textTheme.headline2),
                    trailing: Switch(
                      value: _value1, 
                      onChanged: (value){
                        setState(() {
                        _value1=value;
                      });
                    }),
                  ),
                  ListTile(
                    title: Text("Received NewsLetter",style: Theme.of(context).appBarTheme.textTheme.headline2),
                    trailing: Switch(
                      value: _value2, 
                      onChanged: (value){
                        setState(() {
                        _value2=value;
                      });
                    }),
                  ),
                  ListTile(
                    title: Text("Received Offer Notification",style: Theme.of(context).appBarTheme.textTheme.headline2),
                    trailing: Switch(
                      value: _value3, 
                      onChanged: (value){
                        setState(() {
                        _value3=value;
                      });
                    }),
                  ),
                  ListTile(
                    title: Text("Received Update Notification",style: Theme.of(context).appBarTheme.textTheme.headline2),
                    trailing: Switch(
                      value: _value4, 
                      onChanged: (value){
                        setState(() {
                        _value4=value;
                      });
                    }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}