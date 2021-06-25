import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:http/http.dart' as http;
import 'manage_address_screen.dart';

class AddAddressScreen extends StatefulWidget {

  final User user;

  const AddAddressScreen({Key key, this.user}) : super(key: key);
  

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  
  int selectedButton;
  TextEditingController _placeController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _postCodeController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _stateController = new TextEditingController();
  double screenHeight, screenWidth;

  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(6.457510, 100.505455),
    zoom: 15,
  );
  GoogleMapController _googleMapController;

  @override
  void dispose() {

    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    
        return Scaffold(
          appBar:AppBar(
            title: Text('Insert Address',style: TextStyle(fontFamily: 'Arial')),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.pushReplacement(
                  context,MaterialPageRoute(builder: (context)=>ManageAddressScreen(user: widget.user))
                );
              },
            ),
          ),
          body:SingleChildScrollView(
            child:Column(
              children:[
                Container(
                  height: screenHeight/2.3,
                  color:Colors.white,
                  child: Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: true,
                        trafficEnabled: true,
                        initialCameraPosition: _initialCameraPosition,
                        onMapCreated: (controller) => _googleMapController = controller,
                      ),
                      // Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: FloatingActionButton(
                      //     backgroundColor: Colors.red[200],
                      //     foregroundColor: Colors.black,
                      //     onPressed:() => _googleMapController.animateCamera(
                      //       CameraUpdate.newCameraPosition(_initialCameraPosition)),
                      //       child: const Icon(Icons.center_focus_strong),),
                      // )
                    ]
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children:[
                      TextField(
                        controller: _placeController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).accentColor)
                          ),
                          labelText: 'Place',
                          labelStyle: TextStyle(
                            fontFamily: 'Calibri',
                            color: Colors.red[200]
                          )
                        ),
                      ),
                      TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).accentColor)
                          ),
                          labelText: 'Street Address',
                          labelStyle: TextStyle(
                            fontFamily: 'Calibri',
                            color: Colors.red[200]
                          )
                        ),
                      ),
                      TextField(
                        controller: _postCodeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).accentColor)
                          ),
                          labelText: 'Postal Code',
                          labelStyle: TextStyle(
                            fontFamily: 'Calibri',
                            color: Colors.red[200]
                          )
                        ),
                      ),
                      TextField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).accentColor)
                          ),
                          labelText: 'City',
                          labelStyle: TextStyle(
                            fontFamily: 'Calibri',
                            color: Colors.red[200]
                          )
                        ),
                      ),
                      TextField(
                        controller: _stateController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).accentColor)
                          ),
                          labelText: 'State',
                          labelStyle: TextStyle(
                            fontFamily: 'Calibri',
                            color: Colors.red[200]
                          )
                        ),
                      ),
                      SizedBox(height:15),
                      MaterialButton(
                        shape:RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(20),
                        ),
                        minWidth: screenWidth/1.1,
                        height: screenHeight/18,
                        child: Text('Submit',
                        style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: 'Arial'),),
                        onPressed: _addAddress,
                        color: Colors.red[200],
                      ),
                    ]
                  ),
                  
            ),
          ]
        ),
      ),
    );
  }

  _addAddress() {
    
    String _place = _placeController.text.toString();
    String _streetAddress = _addressController.text.toString();
    String _postalCode = _postCodeController.text.toString();
    String _city = _cityController.text.toString();
    String _state = _stateController.text.toString();
    String email = widget.user.email;

    if(_place.isEmpty &&_streetAddress.isEmpty && _postalCode.isEmpty && _city.isEmpty && _state.isEmpty ){
      Fluttertoast.showToast(
        msg: "Please fill in all textfield",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }
    else if(_place.isEmpty ){
      Fluttertoast.showToast(
        msg: "Place is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }
    else if(_streetAddress.isEmpty ){
      Fluttertoast.showToast(
        msg: "Street Address is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }else if(_postalCode.isEmpty ){
      Fluttertoast.showToast(
        msg: "Postal Code is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }else if(_city.isEmpty){
      Fluttertoast.showToast(
        msg: "City is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }else if(_state.isEmpty){
      Fluttertoast.showToast(
        msg: "State is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text('Add new address?',style: Theme.of(context).textTheme.headline5),
          content: Text("Are you sure?",style: Theme.of(context).textTheme.bodyText1),
          actions: [
            TextButton(
              child:(Text('Yes',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                _addAddressDatabase(_place,_streetAddress,_postalCode,_city,_state,email);
                Navigator.of(context).pop();
              },),
            TextButton(
              child: (Text('No',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                Navigator.of(context).pop();
              },),
          ],
        );
      });
    
  }

  void _addAddressDatabase(String place,String streetAddress, String postalCode, String city, String state, String email) {

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/add_address.php"),
      body: {
        "place":place,
        "streetAddress":streetAddress,
        "postalCode":postalCode,
        "city":city,
        "state":state,
        "email":email,
      }).then(
        (response){
          print(response.body);

          if(response.body=="success"){
            Fluttertoast.showToast(
            msg: "Add Address Success.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);
          }else{
            Fluttertoast.showToast(
            msg: "Add Address Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);
          }
      }
    );
  }

}