import 'package:flutter/material.dart';

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
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Column(
                  children:[
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),

                      child: Image.asset('assets/images/logo2.png',
                      scale:5,),
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
}