import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:little_cake_story/screen/profile/settings/terms_of_service.dart';
import 'privacy_pilicy_screen.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

  double screenHeight, screenWidth;
  
  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title:Text("About",style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                child: Column(
                  children:[
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 20),
                      alignment: Alignment.center,
                      child: Image.asset('assets/images/logo2.png',
                      scale:4,),
                    ),
                    Container(
                      child: Column(
                        children:[
                          Text("Little Cake Story",style: Theme.of(context).textTheme.headline6,),
                          SizedBox(height:5),
                          Text("Version 1.0.0",style: Theme.of(context).textTheme.headline6,),
                        ]
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Column(
                        children:[
                          Card(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.update),
                                  title: Text("Check for Updates",style: Theme.of(context).textTheme.bodyText1,),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: (){
                                    checkUpdate();
                                  },
                                ),
                              ],
                            ),
                          )
                        ]
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top:180),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:[
                          GestureDetector(
                            child: Text('Terms of Service',
                              style:TextStyle(fontSize: 14,color: Colors.blue[200]),
                              textAlign: TextAlign.end,
                            ),
                            onTap: (){
                              Navigator.push(
                              context,MaterialPageRoute(builder: (context)=>TermsServiceScreen())
                              );  
                            },
                          ),
                          GestureDetector(
                            child: Text('Privacy Policy',
                              style:TextStyle(fontSize: 14,color: Colors.blue[200]),
                              textAlign: TextAlign.end,
                            ),
                            onTap: (){
                              Navigator.push(
                              context,MaterialPageRoute(builder: (context)=>PrivacyPolicyScreen())
                              );  
                            },
                          ),
                          Text("SM bhd",style:TextStyle(fontSize: 14,color: Colors.grey[400]),),
                          Text("Copyright© 2021-2021 Tencent",style:TextStyle(fontSize: 14,color: Colors.grey[400]),),
                          Text("All Rights Reserved",style:TextStyle(fontSize: 14,color: Colors.grey[400]),),
                        ]
                      ),
                    ),
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkUpdate() {
    Fluttertoast.showToast(
        msg: "No updates",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}