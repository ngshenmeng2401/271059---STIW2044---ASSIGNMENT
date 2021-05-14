import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title:Text("Contact Us",style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 100,
                ),
                height: screenHeight/2.4,
                width: screenWidth/1.4,
                decoration: BoxDecoration(
                  color: Theme.of(context).hoverColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    GestureDetector(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 10,),
                          Icon(Icons.email_outlined),
                          SizedBox(width: 20,),
                          Text("shenmeng0124@gmail.com",style: Theme.of(context).textTheme.bodyText1,),
                        ],
                      ),
                      onTap: (){},
                    ),
                    SizedBox(height:30),
                    GestureDetector(
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Icon(Icons.phone),
                          SizedBox(width: 20,),
                          Text("0123510295",style: Theme.of(context).textTheme.bodyText1),
                        ],
                      ),
                      onTap: (){
                        
                      },
                    ),
                    SizedBox(height:30),
                    GestureDetector(
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Icon(Icons.location_on_outlined),
                          SizedBox(width: 20,),
                          Text("Sintok, 06010 Bukit Kayu \nHitam, Kedah",style: Theme.of(context).textTheme.bodyText1),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}