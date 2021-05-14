import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

  double screenHeight, screenWidth;
  Future <void> _launched;
  String _phone= "045790265";

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us", style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 150),
                height: screenHeight / 6,
                width: screenWidth / 1.4,
                decoration: BoxDecoration(
                    color: Theme.of(context).hoverColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Phone No: 04-5790265",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minWidth: screenWidth / 2,
                      height: screenHeight / 25,
                      child: Text(
                        'CALL',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'Arial'),
                      ),
                      onPressed: () 
                        {
                          setState(() {
                            _launched =_makePhoneCall('tel:$_phone');
                          });
                        },
                      color: Colors.red[200],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Container(
                height: screenHeight / 5,
                width: screenWidth / 1.4,
                decoration: BoxDecoration(
                    color: Theme.of(context).hoverColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Email: ",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      "shenmeng0124@gmail.com",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minWidth: screenWidth / 2,
                      height: screenHeight / 25,
                      child: Text(
                        'SEND EMAIL',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'Arial'),
                      ),
                      onPressed: () 
                        {
                          setState(() {
                            launch(_emailLauncher.toString());
                          });
                        },
                      color: Colors.red[200],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final Uri _emailLauncher = Uri(
    scheme: 'mailto',
    path: 'littlecakestory@javathree99.com',
    queryParameters: {
      'subject': 'Contact Us @ LittleCakeStory'
    }
  );
}
