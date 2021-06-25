import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:little_cake_story/model/address_list.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/cart/payment_screen.dart';
import 'package:http/http.dart' as http;

class SelectAddressScreen extends StatefulWidget {

  final Address addressList;
  final User user;
  const SelectAddressScreen({Key key, this.user, this.addressList}) : super(key: key);

  @override
  _SelectAddressScreenState createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          color: Colors.white,
          onPressed: (){
            _backButton();
        }),
        title: Text('Manage Address',style: TextStyle(fontFamily: 'Arial')),
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
                        childAspectRatio: (screenWidth / screenHeight) /0.2,
                        children: List.generate(useraddressList.length, (index){
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child:Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      _selectAddress(index);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: ListTile(
                                        title: Text(useraddressList[index]['place'],style: TextStyle(fontSize:20,fontFamily:'Calibri'),),
                                        subtitle: RichText(
                                          text: TextSpan(
                                            children:<TextSpan>[
                                              TextSpan(text:useraddressList[index]['street_address']+"\t",style: Theme.of(context).textTheme.bodyText2,),
                                              TextSpan(text:useraddressList[index]['postal_code']+"\t",style: Theme.of(context).textTheme.bodyText2,),
                                              TextSpan(text:useraddressList[index]['city']+"\n",style: Theme.of(context).textTheme.bodyText2,),
                                              TextSpan(text:useraddressList[index]['state'],style: Theme.of(context).textTheme.bodyText2,),
                                            ]
                                          )),
                                      ),
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

  void _selectAddress(int index) {

    print(useraddressList[index]['street_address']);
    print(useraddressList[index]['postal_code']);
    print(useraddressList[index]['city']);
    print(useraddressList[index]['state']);

    Address address = new Address(
      streetAddress: useraddressList[index]['street_address'],
      postalCode: useraddressList[index]['postal_code'],
      city: useraddressList[index]['city'],
      state: useraddressList[index]['state'],
    );

    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context)=>PaymentScreen(user: widget.user,address:address))
    );
  }

  void _backButton() {

    Address address = new Address(
      streetAddress: "Street Address",
      postalCode: "Postal Code",
      city: "City",
      state: "State",
    );

    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context)=>PaymentScreen(user: widget.user,address: address,))
    );
  }
}