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
                  SwitchListTile(
                    activeColor: Colors.red[200],
                    contentPadding: const EdgeInsets.all(0),
                    value: _value1,
                    title: Text("Received Notification"), 
                    secondary: Icon(null),
                    onChanged: (value){
                      print(_value1);
                      setState(() {
                        _value1=value;
                      });
                    }
                  ),
                  SwitchListTile(
                    activeColor: Colors.red[200],
                    contentPadding: const EdgeInsets.all(0),
                    value: _value2,
                    title: Text("Received NewsLetter"), 
                    secondary: Icon(null),
                    onChanged: (value){
                      print(_value2);
                      setState(() {
                        _value2=value;
                      });
                    }
                  ),
                  SwitchListTile(
                    activeColor: Colors.red[200],
                    contentPadding: const EdgeInsets.all(0),
                    value: _value3,
                    title: Text("Received Offer Notification"), 
                    secondary: Icon(null),
                    onChanged: (value){
                      print(_value3);
                      setState(() {
                        _value3=value;
                      });
                    }
                  ),
                  SwitchListTile(
                    activeColor: Colors.red[200],
                    contentPadding: const EdgeInsets.all(0),
                    value: _value4,
                    title: Text("Received Update Notification"), 
                    secondary: Icon(null),
                    onChanged: (value){
                      print(_value4);
                      setState(() {
                        _value4=value;
                      });
                    }
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