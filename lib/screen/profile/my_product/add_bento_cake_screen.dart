import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/profile/my_product/my_bento_cake_list.dart';

class AddBentoCakeScreen extends StatefulWidget {

  final User user;
  const AddBentoCakeScreen({Key key, this.user}) : super(key: key);

  @override
  _AddBentoCakeScreenState createState() => _AddBentoCakeScreenState();
}

class _AddBentoCakeScreenState extends State<AddBentoCakeScreen> {

  double screenHeight,screenWidth;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  TextEditingController _ratingController = new TextEditingController();
  TextEditingController _detailsController = new TextEditingController();
  File _image;
  String pathAsset='assets/images/cake.jpg';

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
            context, MaterialPageRoute(builder: (context)=>MyBentoCakeListScreen(user: widget.user,))
          );
        }),
        title: Text('Add Bento Cake',style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: screenHeight/2.35,
              child:Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                        image: _image == null ? AssetImage(pathAsset) : FileImage(_image),
                        fit: BoxFit.scaleDown,
                        )
                      ),
                    ),
                    ),
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
                          _onPictureSelectionDialog();
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
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Name:",
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Original Price (RM):",
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          controller: _ratingController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Rating:",
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          controller: _detailsController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: "Details:",
                          ),
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
                      borderRadius:BorderRadius.circular(20),
                    ),
                    minWidth: screenWidth/1.1,
                    height: screenHeight/16,
                    child: Text('Add',
                    style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'Arial'),),
                    onPressed: (){
                      onAddProduct();
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

  void onAddProduct() {

    String _name = _nameController.text.toString();
    String _price = _priceController.text.toString();
    String _rating = _ratingController.text.toString();
    String _details = _detailsController.text.toString();

    if(_image==null && _name.isEmpty && _price.isEmpty && _rating.isEmpty && _details.isEmpty ){
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
    else if(_name.isEmpty ){
      Fluttertoast.showToast(
        msg: "Name is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }else if(_price.isEmpty ){
      Fluttertoast.showToast(
        msg: "Price is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }else if(_rating.isEmpty){
      Fluttertoast.showToast(
        msg: "Rating is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }else if(_details.isEmpty){
      Fluttertoast.showToast(
        msg: "Details is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }else if(_image==null ){
      Fluttertoast.showToast(
        msg: "Please select photo",
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
          title: Text('Add new product?',style: Theme.of(context).textTheme.headline5),
          content: Text("Are you sure?",style: Theme.of(context).textTheme.bodyText1),
          actions: [
            TextButton(
              child:(Text('Yes',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                _addProduct(_name,_price,_rating,_details,widget.user.email);
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
            width: screenWidth/5,
            height: screenHeight/5.5,
            child: Column(
              children:<Widget> [
                ListTile(
                  leading: Icon(Icons.camera_alt_outlined),
                  title: Text("Camera",style: TextStyle(fontSize: 18,fontFamily: 'Calibri'),),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => 
                  {Navigator.pop(context), _chooseCamera()},
                ),
                SizedBox(height:5),
                ListTile(
                  leading: Icon(Icons.photo_album_outlined),
                  title: Text("Gallery",style: TextStyle(fontSize: 18,fontFamily: 'Calibri'),),
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
    setState(() {});
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

  void _addProduct(String name, String price, String rating, String details,String email) {
    
    String base64Image = base64Encode(_image.readAsBytesSync());
    print(base64Image);
    // print(name);
    // print(price);
    // print(rating);
    // print(details);
    // print(email);

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/add_bento_cake.php"),
      body: {
        "name":name,
        "price":price,
        "rating":rating,
        "details":details,
        "email":email,
        "encoded_string":base64Image,
      }).then(
        (response){
          print(response.body);

          if(response.body=="success"){
            Fluttertoast.showToast(
            msg: "Add Product Success.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);
          }else{
            Fluttertoast.showToast(
            msg: "Add Product Failed",
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