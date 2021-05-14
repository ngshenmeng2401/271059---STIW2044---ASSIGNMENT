import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSettingScreen extends StatefulWidget {
  
  @override
  _LanguageSettingScreenState createState() => _LanguageSettingScreenState();
}

class _LanguageSettingScreenState extends State<LanguageSettingScreen> {

  int selectedButton=0;
  
  SharedPreferences prefs;

    @override
  void initState() {
    loadPreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Language Setting",style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child:Column(
                children:[
                  ListTile(
                    title: Text("BAHASA MELAYU",style: Theme.of(context).textTheme.bodyText1),
                    trailing: Radio(
                      activeColor: Colors.red[200],
                      value: 1,
                      groupValue: selectedButton, 
                      onChanged: (value){
                        setState(() {
                          selectedButton=value;
                        });
                      },
                    ),
                    selected: true,
                  ),
                  ListTile(
                    title: Text("简体中文",style: Theme.of(context).textTheme.bodyText1),
                    trailing: Radio(
                      activeColor: Colors.red[200],
                      value: 2,
                      groupValue: selectedButton, 
                      onChanged: (value){
                        setState(() {
                          selectedButton=value;
                        });
                      },
                    ),
                    selected: true,
                  ),
                  ListTile(
                    title: Text("ENGLISH",style: Theme.of(context).textTheme.bodyText1),
                    trailing: Radio(
                      activeColor: Colors.red[200],
                      value: 3,
                      groupValue: selectedButton, 
                      onChanged: (value){
                        setState(() {
                        selectedButton=value;
                        });
                      },
                    ),
                    selected: true,
                  ),
                  ListTile(
                    title: Text("தமிழ்",style: Theme.of(context).textTheme.bodyText1),
                    trailing: Radio(
                      activeColor: Colors.red[200],
                      value: 4,
                      groupValue: selectedButton, 
                      onChanged: (value){
                        setState(() {
                        selectedButton=value;
                        });
                      },
                    ),
                    selected: true,
                  ),
                ]
              )
            )    
          ],
        ),
      ),
    );
  }

  // void _onChanged(int value,int selectedButton){
  //   setState(() {
  //     selectedButton=value;
  //     print(selectedButton);
  //   });
  // }

  Future<void> storePreference(int value,int selectedButton) async {
    prefs = await SharedPreferences.getInstance();
    
  }

  Future<void> loadPreference() async {
    prefs = await SharedPreferences.getInstance();
    selectedButton=prefs.getInt("language")??selectedButton;
  }
}