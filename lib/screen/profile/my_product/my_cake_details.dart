import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:little_cake_story/model/cake.dart';
import 'package:little_cake_story/model/user.dart';
import 'my_cake_list.dart';

class MyCakeDetails extends StatefulWidget {

  final User user;
  final CakeList cakeList;
  const MyCakeDetails({Key key, this.user, this.cakeList}) : super(key: key);

  @override
  _MyCakeDetailsState createState() => _MyCakeDetailsState();
}

class _MyCakeDetailsState extends State<MyCakeDetails> {

  double screenHeight, screenWidth;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _oriPriceController = new TextEditingController();
  TextEditingController _offeredPriceController = new TextEditingController();
  TextEditingController _ratingController = new TextEditingController();
  TextEditingController _detailsController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyCakeListScreen(cakeList: widget.cakeList,user: widget.user)));
          },
        ),
        title: Text('Cakes',style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: screenHeight / 2.35,
              child: CachedNetworkImage(
                imageUrl:
                    "https://javathree99.com/s271059/littlecakestory/images/product_cake/${widget.cakeList.cakeNo}.png",
              ),
            ),
            Container(
              child: Card(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.inventory),
                      title: Text(
                        widget.cakeList.cakeName,
                        style: TextStyle(fontSize: 20, fontFamily: 'Calibri'),
                      ),
                      subtitle: Text("Name"),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
                        child: Divider(
                          color: Colors.red[200],
                        )),
                    ListTile(
                      leading: Icon(Icons.money),
                      title: Text(
                        "RM ${widget.cakeList.oriPrice}",
                        style: TextStyle(fontSize: 20, fontFamily: 'Calibri'),
                      ),
                      subtitle: Text("Original Price"),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
                        child: Divider(
                          color: Colors.red[200],
                        )),
                    ListTile(
                      leading: Icon(Icons.money),
                      title: Text(
                        "RM ${widget.cakeList.offeredPrice}",
                        style: TextStyle(fontSize: 20, fontFamily: 'Calibri'),
                      ),
                      subtitle: Text("Offered Price"),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
                        child: Divider(
                          color: Colors.red[200],
                        )),
                    ListTile(
                      leading: Icon(Icons.star),
                      title: Text(
                        widget.cakeList.rating,
                        style: TextStyle(fontSize: 20, fontFamily: 'Calibri'),
                      ),
                      subtitle: Text("Rating"),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
                        child: Divider(
                          color: Colors.red[200],
                        )),
                    ListTile(
                      leading: Icon(Icons.list),
                      title: Text(
                        widget.cakeList.details,
                        style: TextStyle(fontSize: 16, fontFamily: 'Calibri',),
                      ),
                      subtitle: Text("Details"),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
                        child: Divider(
                          color: Colors.red[200],
                        )),
                    ListTile(
                      title: Text("Edit Size",
                        style: TextStyle(fontSize: 20,fontFamily: 'Calibri'),),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: (){
                          _editSizeDialog(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
              child: Container(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minWidth: screenWidth / 1.1,
                  height: screenHeight / 18,
                  child: Text(
                    'Delete',
                    style: TextStyle(
                        fontSize: 20, color: Colors.white, fontFamily: 'Arial'),
                  ),
                  onPressed: () {
                    _deleteDialog();
                  },
                  color: Colors.red[200],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _editDialog();
        },
        child:Icon(Icons.edit,
          color: Colors.white,
        )
      ),
    );
  }

  void _editDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Enter new information:',
                style: Theme.of(context).textTheme.headline6),
            content: Column(
              children: [
                ListTile(
                  title: TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)
                      ),
                      labelText: "Name:",
                      labelStyle: TextStyle(
                        color: Colors.red[200]
                      )
                    ),
                  ),
                ),
                ListTile(
                  title: TextField(
                    controller: _oriPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)
                      ),
                      labelText: "Original Price (RM):",
                      labelStyle: TextStyle(
                        color: Colors.red[200]
                      )
                    ),
                  ),
                ),
                ListTile(
                  title: TextField(
                    controller: _offeredPriceController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)
                      ),
                      labelText: "Offered Price:",
                      labelStyle: TextStyle(
                        color: Colors.red[200]
                      )
                    ),
                  ),
                ),
                ListTile(
                  title: TextField(
                    controller: _ratingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)
                      ),
                      labelText: "Rating:",
                      labelStyle: TextStyle(
                        color: Colors.red[200]
                      )
                    ),
                  ),
                ),
                ListTile(
                  title: TextField(
                    controller: _detailsController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)
                      ),
                      labelText: "Details:",
                      labelStyle: TextStyle(
                        color: Colors.red[200]
                      )
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: (Text('Submit',
                    style: Theme.of(context).textTheme.bodyText2)),
                onPressed: () {
                  _checkEditCake(_nameController.text.toString(),_oriPriceController.text.toString(),_offeredPriceController.text.toString(),_ratingController.text.toString(),_detailsController.text.toString());
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: (Text('Cancel',
                    style: Theme.of(context).textTheme.bodyText2)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _checkEditCake(String name, String oriPrice, String offeredPrice, String rating, String details) {

    if(name.isEmpty && oriPrice.isEmpty && offeredPrice.isEmpty && rating.isEmpty && details.isEmpty ){
      Fluttertoast.showToast(
        msg: "Do not have any update",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);

    }else{

      name = (_nameController.text.toString() == "")
        ? widget.cakeList.cakeName
        : _nameController.text.toString();
      
      oriPrice = (_oriPriceController.text.toString() == "")
        ? widget.cakeList.oriPrice
        : _oriPriceController.text.toString();

      offeredPrice = (_offeredPriceController.text.toString() == "")
        ? widget.cakeList.offeredPrice
        : _offeredPriceController.text.toString();

      rating = (_ratingController.text.toString() == "")
        ? widget.cakeList.rating
        : _ratingController.text.toString();

      details = (_detailsController.text.toString() == "")
        ? widget.cakeList.details
        : _detailsController.text.toString();

      _editCake(name,oriPrice,offeredPrice,rating,details);

    }

  }

  void _editCake(String name, String oriPrice, String offeredPrice, String rating, String details) {

    print(name);
    print(oriPrice);
    print(offeredPrice);
    print(rating);
    print(details);

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/edit_cake.php"),
      body: {
        "cake_no":widget.cakeList.cakeNo,
        "cake_name":name,
        "original_price":oriPrice,
        "offered_price":offeredPrice,
        "rating":rating,
        "cake_detail":details,

      }).then(
        (response){
          print(response.body); 

          if(response.body=="success"){

            Fluttertoast.showToast(
              msg: "Edit Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red[200],
              textColor: Colors.white,
              fontSize: 16.0);
            setState(() {

              widget.cakeList.cakeName=name;
              widget.cakeList.oriPrice=oriPrice;
              widget.cakeList.offeredPrice=offeredPrice;
              widget.cakeList.rating=rating;
              widget.cakeList.details=details;
            });

          }else{
            
            Fluttertoast.showToast(
              msg: "Edit Failed",
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

  Future<void> _editSizeDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context,setState){
            return AlertDialog(
              title: Text('Select New Cake Size',
                  style: Theme.of(context).textTheme.headline6),
              content: new Container(
                height: screenHeight/3,
                child: Column(
                  children: [
                    ListTile(
                      title: Text("slice",style: TextStyle(fontFamily: 'Calibri',)),
                      trailing: Checkbox(
                        activeColor: Colors.red[200],
                        value: widget.cakeList.slice,
                        onChanged: (value){
                          setState(() {
                            widget.cakeList.slice = value;
                            print(widget.cakeList.slice);
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text("6 inch",style: TextStyle(fontFamily: 'Calibri',)),
                      trailing: Checkbox(
                        activeColor: Colors.red[200],
                        value: widget.cakeList.inch_6,
                        onChanged: (value){
                          setState(() {
                            widget.cakeList.inch_6 = value;
                            print(widget.cakeList.inch_6);
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text("8 inch",style: TextStyle(fontFamily: 'Calibri',)),
                      trailing: Checkbox(
                        activeColor: Colors.red[200],
                        value: widget.cakeList.inch_8,
                        onChanged: (value){
                          setState(() {
                            widget.cakeList.inch_8 = value;
                            print(widget.cakeList.inch_8);
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text("10 inch",style: TextStyle(fontFamily: 'Calibri',)),
                      trailing: Checkbox(
                        activeColor: Colors.red[200],
                        value: widget.cakeList.inch_10,
                        onChanged: (value){
                          setState(() {
                            widget.cakeList.inch_10 = value;
                            print(widget.cakeList.inch_10);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: (Text('Submit',
                      style: Theme.of(context).textTheme.bodyText2)),
                  onPressed: () {
                    _editSize(widget.cakeList.slice, widget.cakeList.inch_6, widget.cakeList.inch_8, widget.cakeList.inch_10);
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: (Text('Cancel',
                      style: Theme.of(context).textTheme.bodyText2)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        });
  }

  void _editSize(bool slice, bool inch_6, bool inch_8, bool inch_10) {

    print(widget.cakeList.cakeNo);
    print(slice);
    print(inch_6);
    print(inch_8);
    print(inch_10);

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/edit_cake_size.php"),
      body: {
        "cake_no":widget.cakeList.cakeNo,
        "selected_slice":slice.toString(),
        "6_inch":inch_6.toString(),
        "8_inch":inch_8.toString(),
        "10_inch":inch_10.toString(),

      }).then(
        (response){
          print(response.body); 

          if(response.body=="success"){

            Fluttertoast.showToast(
              msg: "Edit Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red[200],
              textColor: Colors.white,
              fontSize: 16.0);
            setState(() {

              widget.cakeList.inch_6=inch_6;
              widget.cakeList.inch_8=inch_8;
              widget.cakeList.inch_10=inch_10;
            });

          }else{
            
            Fluttertoast.showToast(
              msg: "Edit Failed",
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

  void _deleteDialog() {

    print(widget.cakeList.cakeNo);

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text('Delete Cake?',style: Theme.of(context).textTheme.headline5),
          content: Text("Are you sure?",style: Theme.of(context).textTheme.bodyText1),
          actions: [
            TextButton(
              child:(Text('Yes',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                Navigator.of(context).pop();
                _deleteCake(widget.cakeList.cakeNo);
                Navigator.pushReplacement(
                  context,MaterialPageRoute(builder: (context)=> MyCakeListScreen(cakeList: widget.cakeList,user: widget.user))
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

  void _deleteCake(String cakeNo) {
    print(cakeNo);

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/delete_cake.php"),
      body: {
        "cake_no":widget.cakeList.cakeNo,
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

}