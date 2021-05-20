import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:little_cake_story/model/address_list.dart';
import 'package:little_cake_story/model/user.dart';
import 'map_screen.dart';
import 'package:http/http.dart' as http;
import 'add_address_screen.dart';
import 'edit_address.dart';

class ManageAddressScreen extends StatefulWidget {

  final AddressList addressList;
  final User user;
  const ManageAddressScreen({Key key, this.user, this.addressList}) : super(key: key);

  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {

  List useraddressList;
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;

  @override
  void initState() {

    super.initState();
    _loadAddress();
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        title: Text('Manage Address',style: TextStyle(fontFamily: 'Arial')),
        actions: [
          IconButton(
              icon: Icon(Icons.language), 
              color: Colors.white,
              onPressed: (){
                Navigator.push(
                  context, MaterialPageRoute(builder: (context)=>MapScreen())
                );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: screenHeight,
            width: screenWidth,
            child:Column(
              children:[
                useraddressList == null 
                ? Flexible(
                    child: Center(
                      child: Text(titleCenter)),
                )
                : Flexible(
                    child: Center(
                      child: GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: (screenWidth / screenHeight) /0.19,
                        children: List.generate(useraddressList.length, (index){
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child:Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(

                                    ),
                                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: ListTile(
                                      title: Text(useraddressList[index]['street_address'],style: TextStyle(fontSize:16,fontFamily:'Calibri'),),
                                      subtitle: RichText(
                                        text: TextSpan(
                                          children:<TextSpan>[
                                            TextSpan(text:useraddressList[index]['postal_code']+"\t",style: Theme.of(context).textTheme.bodyText2,),
                                            TextSpan(text:useraddressList[index]['city']+"\n",style: Theme.of(context).textTheme.bodyText2,),
                                            TextSpan(text:useraddressList[index]['state'],style: Theme.of(context).textTheme.bodyText2,),
                                          ]
                                        )),
                                      trailing: IconButton(
                                        onPressed: (){
                                          _editAddress(index);
                                        },
                                        icon:Icon(Icons.edit,
                                        color: Colors.red[200],)),
                                    ),
                                  ),
                                ],
                              )
                            ),
                          );
                        })
                      )
                      ),
                ),
              ]
            )
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context)=>AddAddressScreen(user: widget.user,))
          );
        },
        child:Icon(Icons.add,
          color: Colors.white,
        )
      ),
    );
  }

  void _loadAddress() {

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/load_address.php"),
      body: {
        "email":widget.user.email,
      }).then(
        (response){
          if(response.body == "nodata"){
            titleCenter = "No data";
            return;
          }else{
            var jsondata = json.decode(response.body);
            useraddressList = jsondata["address"];
            titleCenter = "Contain Data";
            setState(() {});
            print(useraddressList);
          }
      }
    );
  }

  void _editAddress(int index) {
    print(useraddressList[index]['address_no']);
    AddressList addressList = new AddressList(
      addressNo: useraddressList[index]['address_no'],
      streetAddress: useraddressList[index]['street_address'],
      postalCode: useraddressList[index]['postal_code'],
      city: useraddressList[index]['city'],
      state: useraddressList[index]['state'],
    );

    Navigator.pushReplacement(
      context,MaterialPageRoute(builder: (context)=> EditAddressScreen(addressList: addressList,user: widget.user,))
    );
  }
}