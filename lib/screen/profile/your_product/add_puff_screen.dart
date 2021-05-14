import 'package:flutter/material.dart';
import 'puffs_list.dart';

class AddPuffScreen extends StatefulWidget {
  @override
  _AddPuffScreenState createState() => _AddPuffScreenState();
}

class _AddPuffScreenState extends State<AddPuffScreen> {

  double screenHeight,screenWidth;

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          color: Colors.white,
          onPressed: (){
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context)=>PuffsListScreen())
          );
        }),
        title: Text('Add Puff',style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: screenHeight/2.35,
              // color:Colors.white10,
              child:Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/product1.jpg")),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.red[200],
                        shape: BoxShape.circle,
                      ),
                      child:IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(Icons.camera_alt_outlined,
                        color: Theme.of(context).appBarTheme.actionsIconTheme.color,
                        size:22,),
                        onPressed: (){
                        },)
                        ),
                      )
                ]
            ),
            ),
            SizedBox(height:10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  width: screenWidth/1.1,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey[600],
                        spreadRadius: 4,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      )
                    ],
                    color: Theme.of(context).hoverColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: TextField(
                          decoration: InputDecoration(
                            labelText: "Puff Code:",
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Name:",
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Original Price (RM):",
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Rating:",
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          decoration: InputDecoration(
                            labelText: "Details:",
                          ),
                        ),
                      ),
                      // ListTile(
                      //   title: TextField(
                      //     decoration: InputDecoration(
                      //       labelText: "Description:",
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  child:MaterialButton(
                    shape:RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(10),
                    ),
                    minWidth: screenWidth/1.1,
                    height: screenHeight/16,
                    child: Text('Submit',
                    style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'Arial'),),
                    onPressed: (){
                      print("submit");
                    },
                    color: Colors.red[200],
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}