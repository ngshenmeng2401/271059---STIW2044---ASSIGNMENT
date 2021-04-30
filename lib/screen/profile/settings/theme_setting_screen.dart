import 'package:flutter/material.dart';
import 'package:little_cake_story/model/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSettingScreen extends StatefulWidget {
  
  @override
  _ThemeSettingScreenState createState() => _ThemeSettingScreenState();
}

class _ThemeSettingScreenState extends State<ThemeSettingScreen> {
  
  int selectedRadioTile;
  bool getTheme;
  SharedPreferences prefs;

  @override
  void initState() {
    loadPreference();
    super.initState();
    selectedRadioTile=0;
  }

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
                children:[
                  RadioListTile(
                    value: 1, 
                    groupValue: selectedRadioTile, 
                    title: Text("Dark Mode",style: Theme.of(context).textTheme.bodyText2),
                    subtitle: Text("The primary color will become black",style: Theme.of(context).textTheme.bodyText2),
                    onChanged: (value){
                      ThemeProvider themeProvider = Provider.of<ThemeProvider>(
                        context,
                        listen: false);
                        themeProvider.swapTheme();
                      selectedRadioTile=value;
                    },
                    activeColor: Colors.red[200],
                    selected: true,
                  ),
                  RadioListTile(
                    value: 2, 
                    groupValue: selectedRadioTile, 
                    title: Text("Light Mode",style: Theme.of(context).textTheme.bodyText2),
                    subtitle: Text("The primary color will become white",style: Theme.of(context).textTheme.bodyText2),
                    onChanged: (value){
                      ThemeProvider themeProvider = Provider.of<ThemeProvider>(
                        context,
                        listen: false);
                        themeProvider.swapTheme();
                      selectedRadioTile=value;
                    },
                    activeColor: Colors.red[200],
                    selected: true,
                  ),
                  RadioListTile(
                    value: 3, 
                    groupValue: selectedRadioTile, 
                    title: Text("System Default",style: Theme.of(context).textTheme.bodyText2,),
                    subtitle: Text("The primary color will base on system theme",style: Theme.of(context).textTheme.bodyText2),
                    onChanged: (value){
                      setState(() {
                        selectedRadioTile=value;
                      });
                    },
                    activeColor: Colors.red[200],
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

  getThemeMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    getTheme = prefs.getBool("isDarkTheme");
    return getTheme;
  }

  void _onChanged(value) {
    setState(() {
      selectedRadioTile=value;
      storePreference(value);
    });
  }

  Future<void> storePreference(value) async {
    prefs = await SharedPreferences.getInstance();
     
  }

  Future<void> loadPreference() async {
    prefs = await SharedPreferences.getInstance();
  }
}