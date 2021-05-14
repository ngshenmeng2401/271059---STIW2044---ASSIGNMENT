import 'package:flutter/material.dart';
import 'faq_screen.dart';
import 'contact_us_screen.dart';

class HelpSupportScreen extends StatefulWidget {
  @override
  _HelpSupportScreenState createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Help & Support",style: TextStyle(fontFamily: 'Arial')),
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
                    leading: Icon(Icons.question_answer_outlined),
                    title: Text("FAQ",style: Theme.of(context).textTheme.bodyText1,),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context)=>FAQScreen())
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.contact_phone),
                    title: Text("Contact Us",style: Theme.of(context).textTheme.bodyText1,),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context)=>ContactUsScreen())
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