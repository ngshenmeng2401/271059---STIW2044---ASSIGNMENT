import 'package:flutter/material.dart';
import 'cake_list.dart';

class AddCakeScreen extends StatefulWidget {
  @override
  _AddCakeScreenState createState() => _AddCakeScreenState();
}

class _AddCakeScreenState extends State<AddCakeScreen> {

  double screenHeight,screenWidth;
  bool selected_6Inch=false,selected_8Inch=false,selected_10Inch=false,selected_12Inch=false;

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
            context, MaterialPageRoute(builder: (context)=>CakeListScreen())
          );
        }),
        title: Text('Add Cake',style: TextStyle(fontFamily: 'Arial')),
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
                  // height: 500,
                  width: 400,
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
                            labelText: "Cake Code:",
                            // hintText: "Cake Code"
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Cake Name:",
                            // hintText: "Cake Code"
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Original Price (RM):",
                            // hintText: "Cake Code"
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Rating:",
                            // hintText: "Cake Code"
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          decoration: InputDecoration(
                            labelText: "Cake Details:",
                            // hintText: "Cake Code"
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          decoration: InputDecoration(
                            labelText: "Cake Description:",
                            // hintText: "Cake Code"
                          ),
                        ),
                      ),
                      SizedBox(height:20),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 315, 0),
                        child: Text("Size",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontFamily: 'Calibri',fontSize:22),)),
                      ListTile(
                        title: Text("6 inch",style: TextStyle(fontFamily: 'Calibri',)),
                        trailing: Checkbox(
                          value: selected_6Inch,
                          onChanged: (value){
                            setState(() {
                              print(selected_6Inch);
                              selected_6Inch = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text("8 inch",style: TextStyle(fontFamily: 'Calibri',)),
                        trailing: Checkbox(
                          value: selected_8Inch,
                          onChanged: (value){
                            setState(() {
                              print(selected_8Inch);
                              selected_8Inch = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text("10 inch",style: TextStyle(fontFamily: 'Calibri',)),
                        trailing: Checkbox(
                          value: selected_10Inch,
                          onChanged: (value){
                            setState(() {
                              print(selected_10Inch);
                              selected_10Inch = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text("12 inch",style: TextStyle(fontFamily: 'Calibri',)),
                        trailing: Checkbox(
                          value: selected_12Inch,
                          onChanged: (value){
                            setState(() {
                              print(selected_12Inch);
                              selected_12Inch = value;
                            });
                          },
                        ),
                      ),
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