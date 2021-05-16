import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_screen.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:cached_network_image/cached_network_image.dart';


class EditProfileScreen extends StatefulWidget {

  final User user;

  const EditProfileScreen({Key key, this.user}) : super(key: key);
  
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _phoneNoController = new TextEditingController();
  double screenHeight, screenWidth;
  String pathAsset='assets/images/profile.png';
  File _image;

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushReplacement(
              context,MaterialPageRoute(builder: (context)=>ProfileScreen(user: widget.user,))
            );
          },
        ),
        title: Text('Edit Profile',style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
        child:Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              children:[
                Container(
                  height:screenHeight/6.5,
                  width: screenWidth/4,
                  child: Container(
                    child:Stack(
                      children:[
                        Container(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          height: screenHeight/5,
                          width: screenWidth/4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color:Theme.of(context).appBarTheme.actionsIconTheme.color),
                            image: DecorationImage(
                            image: _image == null ? AssetImage(pathAsset) : FileImage(_image),
                            fit: BoxFit.scaleDown,
                            )
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.red[200],
                              shape: BoxShape.circle,
                            ),
                            child:IconButton(
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.camera_alt_outlined,
                              color: Theme.of(context).appBarTheme.actionsIconTheme.color,
                              size:18,),
                              onPressed: (){
                                _onPictureSelectionDialog();
                              },)
                          ),
                        )
                      ]
                    ),
                  )
                ),
                SizedBox(height:50),
                Container(
                  height:screenHeight/3,
                  width: screenWidth/1,
                  child: Column(
                    children:[
                      TextField(
                        controller: _firstNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: widget.user.firstName,
                          labelText: 'First Name',
                        ),
                      ),
                      TextField(
                        controller: _lastNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: widget.user.lastName,
                          labelText: 'Last Name',
                        ),
                      ),
                      TextField(
                        controller: _phoneNoController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: widget.user.phoneNo,
                          labelText: 'Phone No',
                        ),
                      ),
                    ]
                  ),
                ),
                Container(
                  child: Row(
                    children:[
                      MaterialButton(
                        shape:RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(10),
                        ),
                        minWidth: 370,
                        height: 40,
                        child: Text('Update Profile',
                        style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: 'Arial'),),
                        onPressed: onUpdate,
                        color: Colors.red[200],
                      ),
                    ]
                  ),
                ),
              ]
            ),
          ),
        ),
      )
    );
  }

  void onUpdate() {

    String _firstname = _firstNameController.text.toString();
    String _lastname = _lastNameController.text.toString();
    String _phoneno = _phoneNoController.text.toString();

    if(_firstname.isEmpty && _lastname.isNotEmpty && _phoneno.isNotEmpty ){

      _firstname=widget.user.firstName;

      _showConfirmMessage( _firstname, _lastname, _phoneno);

    }else if(_firstname.isNotEmpty && _lastname.isEmpty && _phoneno.isNotEmpty ){

      _lastname=widget.user.lastName;

      _showConfirmMessage( _firstname, _lastname, _phoneno);

    }else if(_firstname.isNotEmpty && _lastname.isNotEmpty && _phoneno.isEmpty){

      _phoneno=widget.user.phoneNo;
      
      _showConfirmMessage( _firstname, _lastname, _phoneno);

    }else if(_firstname.isNotEmpty && _lastname.isNotEmpty && _phoneno.isNotEmpty){

      _showConfirmMessage( _firstname, _lastname, _phoneno);

    }else if(_firstname.isEmpty && _lastname.isEmpty && _phoneno.isNotEmpty){

      _firstname=widget.user.firstName;
      _lastname=widget.user.lastName;
      _showConfirmMessage( _firstname, _lastname, _phoneno);

    }else if(_firstname.isNotEmpty && _lastname.isEmpty && _phoneno.isEmpty){

      _lastname=widget.user.lastName;
      _phoneno=widget.user.phoneNo;
      _showConfirmMessage( _firstname, _lastname, _phoneno);

    }else if(_firstname.isEmpty && _lastname.isNotEmpty && _phoneno.isEmpty){

      _firstname=widget.user.firstName;
      _phoneno=widget.user.phoneNo;
      _showConfirmMessage( _firstname, _lastname, _phoneno);

    }else if(_firstname.isEmpty && _lastname.isEmpty && _phoneno.isEmpty){

      _firstname=widget.user.firstName;
      _lastname=widget.user.lastName;
      _phoneno=widget.user.phoneNo;
      _showConfirmMessage( _firstname, _lastname, _phoneno);
    }
      
  }

  void _showConfirmMessage(String _firstname, String _lastname, String _phoneno){

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text('Update Profile?',style: Theme.of(context).textTheme.headline5),
          content: Text("Are you sure?",style: Theme.of(context).textTheme.bodyText1),
          actions: [
            TextButton(
              child:(Text('Yes',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                _updateProfile(_firstname,_lastname,_phoneno,widget.user.email);
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

  void _onPictureSelectionDialog() {

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: new Container(
            padding: EdgeInsets.all(0),
            width: screenWidth/4,
            height: screenHeight/5.5,
            child: Column(
              children:<Widget> [
                ListTile(
                  title: Text("Take a Photo from Camera",style: TextStyle(fontSize: 16),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => 
                  {Navigator.pop(context), _chooseCamera()},
                ),
                SizedBox(height:5),
                ListTile(
                  title: Text("Choose a Photo from Gallery",style: TextStyle(fontSize: 16),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () =>
                  {Navigator.pop(context), _chooseGallery()},
                ),
                
              ],
            ),
          ),
        );
      });
  }

  Future<void> _chooseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 1000,
    );
    
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    _cropImage();
  }

  Future<void> _chooseGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 1000,
    );
    
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    _cropImage();
  }

  void _cropImage() async {

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: _image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop your image',
          toolbarColor: Colors.red[200],
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: Colors.red[200],
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      )
    );

    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _updateProfile(String firstname, String lastname, String phoneno,String email) {

    String base64Image = base64Encode(_image.readAsBytesSync());
    print(email);
    print(firstname);
    print(lastname);
    print(phoneno);
    print(base64Image);

    setState(() {
      http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/edit_profile.php"),
      body: {
        "email":email,
        "firstname":firstname,
        "lastname":lastname,
        "phoneno":phoneno,
        "encoded_string": base64Image
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

        widget.user.firstName=firstname;
        widget.user.lastName=lastname;
        widget.user.phoneNo=phoneno;
        
      }
    );
    });
  }

}