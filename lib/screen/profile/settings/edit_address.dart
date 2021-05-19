import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:little_cake_story/model/address_list.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:http/http.dart' as http;
import 'manage_address_screen.dart';
import 'package:progress_dialog/progress_dialog.dart';


class EditAddressScreen extends StatefulWidget {

  final User user;
  final AddressList addressList;

  const EditAddressScreen({Key key, this.addressList,this.user}) : super(key: key);

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {

  TextEditingController _addressController = new TextEditingController();
  TextEditingController _postCodeController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _stateController = new TextEditingController();
  ProgressDialog pr;
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    pr = new ProgressDialog(context);
    pr.style(
      message: 'Updating ...',
      borderRadius: 10.0,
      backgroundColor: Theme.of(context).hoverColor,
      progressWidget: Container(
      padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
        color: Colors.red[200], fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
        color: Colors.red[200], fontSize: 20.0, fontWeight: FontWeight.w600)
    );

    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushReplacement(
              context,MaterialPageRoute(builder: (context)=>ManageAddressScreen(addressList: widget.addressList,user: widget.user,))
            );
          },
        ),
            title: Text('Edit Address',style: TextStyle(fontFamily: 'Arial')),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      hintText: widget.addressList.streetAddress,
                    labelText: 'Street Address',
                    ),
                  ),
                  TextField(
                    controller: _postCodeController,
                    decoration: InputDecoration(
                      hintText: widget.addressList.postalCode,
                    labelText: 'Postal Code',
                    ),
                  ),
                  TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      hintText: widget.addressList.city,
                    labelText: 'City',
                    ),
                  ),
                  TextField(
                    controller: _stateController,
                    decoration: InputDecoration(
                      hintText: widget.addressList.state,
                    labelText: 'State',
                    ),
                  ),
                  SizedBox(height:20),
                  MaterialButton(
                    shape:RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).highlightColor),
                    borderRadius:BorderRadius.circular(20),
                    ),
                    minWidth: screenWidth/1.1,
                    height: screenHeight/18,
                    child: Text('Delete',
                    style: TextStyle(fontSize: 18,color: Colors.red[200],fontFamily: 'Arial'),),
                    onPressed: (){
                      _deleteDialog();
                    },
                    color: Theme.of(context).hoverColor,
                  ),
                  SizedBox(height:20),
                  MaterialButton(
                    shape:RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(20),
                    ),
                    minWidth: screenWidth/1.1,
                    height: screenHeight/18,
                    child: Text('Update',
                    style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: 'Arial'),),
                    onPressed:  (){
                      _onUpdate();
                    },
                    color: Colors.red[200],
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  void _deleteDialog() {
    print(widget.addressList.streetAddress);

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text('Delete Address?',style: Theme.of(context).textTheme.headline5),
          content: Text("Are you sure?",style: Theme.of(context).textTheme.bodyText1),
          actions: [
            TextButton(
              child:(Text('Yes',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                Navigator.of(context).pop();
                _deleteAddress(widget.addressList.addressNo);
                Navigator.pushReplacement(
                  context,MaterialPageRoute(builder: (context)=> ManageAddressScreen(addressList: widget.addressList,user: widget.user,))
                );
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

  void _deleteAddress(String addressNo) {
    print(addressNo);

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/delete_address.php"),
      body: {
        "addressno":widget.addressList.addressNo,
      }).then(
        (response){
          if(response.body == "success"){
            Fluttertoast.showToast(
              msg: "Delete Success.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red[200],
              textColor: Colors.white,
              fontSize: 16.0);
          }else{
            Fluttertoast.showToast(
              msg: "Delete Failed.",
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

  void _onUpdate() {

    setState(() {

      String _streetAddress = _addressController.text.toString();
      String _postalCode = _postCodeController.text.toString();
      String _city = _cityController.text.toString();
      String _state = _stateController.text.toString();

      if(_streetAddress.isEmpty && _postalCode.isEmpty && _city.isEmpty && _state.isEmpty ){
          Fluttertoast.showToast(
            msg: "Do not have any update",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);
        }
      else{
        _streetAddress = (_addressController.text.toString() == "") 
        ? widget.addressList.streetAddress
        : _addressController.text.toString();
      _postalCode = (_postCodeController.text.toString() == "")
        ? widget.addressList.postalCode
        : _postCodeController.text.toString();
      _city = (_cityController.text.toString() == "")
        ? widget.addressList.city
        : _cityController.text.toString();
      _state = (_stateController.text.toString() == "")
        ? widget.addressList.state
        : _stateController.text.toString();

      showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text('Upload Address?',style: Theme.of(context).textTheme.headline5),
          content: Text("Are you sure?",style: Theme.of(context).textTheme.bodyText1),
          actions: [
            TextButton(
              child:(Text('Yes',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                _updateAddress(_streetAddress,_postalCode,_city,_state);
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
      
    });
  }

  void _updateAddress(String streetAddress, String postalCode, String city, String state) {

    setState(() {
      http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/edit_address.php"),
      body: {
        "addressno":widget.addressList.addressNo,
        "streetAddress":streetAddress,
        "postalCode":postalCode,
        "city":city,
        "state":state,
      }).then(
        (response){
          print(response.body);

          if(response.body=="success"){
            Fluttertoast.showToast(
            msg: "Update Success.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);
          }else{
            Fluttertoast.showToast(
            msg: "Update Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);
          }

        widget.addressList.streetAddress=streetAddress;
        widget.addressList.postalCode=postalCode;
        widget.addressList.city=city;
        widget.addressList.state=state;
      }
      );
    });
  }

}