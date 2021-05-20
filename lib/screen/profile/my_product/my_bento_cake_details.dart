import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:little_cake_story/model/bento_cake.dart';
import 'package:little_cake_story/model/user.dart';
import 'my_bento_cake_list.dart';

class MyBentoCakeDetails extends StatefulWidget {

  final User user;
  final BentoCakeList bentocakeList;
  const MyBentoCakeDetails({Key key, this.user, this.bentocakeList}) : super(key: key);

  @override
  _MyBentoCakeDetailsState createState() => _MyBentoCakeDetailsState();
}

class _MyBentoCakeDetailsState extends State<MyBentoCakeDetails> {

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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyBentoCakeListScreen(bentoCakeList: widget.bentocakeList,user: widget.user)));
          },
        ),
        title: Text('Bento Cakes', style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: screenHeight / 2.35,
              child: CachedNetworkImage(
                imageUrl:
                    "https://javathree99.com/s271059/littlecakestory/images/product_bento_cake/${widget.bentocakeList.bentoCakeNo}.png",
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
                        widget.bentocakeList.bentoCakeName,
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
                        "RM ${widget.bentocakeList.oriPrice}",
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
                        "RM ${widget.bentocakeList.offeredPrice}",
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
                        widget.bentocakeList.rating,
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
                        widget.bentocakeList.details,
                        style: TextStyle(fontSize: 16, fontFamily: 'Calibri',),
                      ),
                      subtitle: Text("Details"),
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
                  _checkEditBentoCake(_nameController.text.toString(),_oriPriceController.text.toString(),_offeredPriceController.text.toString(),_ratingController.text.toString(),_detailsController.text.toString());
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

  void _checkEditBentoCake(String name, String oriPrice, String offeredPrice, String rating, String details) {

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
        ? widget.bentocakeList.bentoCakeName
        : _nameController.text.toString();
      
      oriPrice = (_oriPriceController.text.toString() == "")
        ? widget.bentocakeList.oriPrice
        : _oriPriceController.text.toString();

      offeredPrice = (_offeredPriceController.text.toString() == "")
        ? widget.bentocakeList.offeredPrice
        : _offeredPriceController.text.toString();

      rating = (_ratingController.text.toString() == "")
        ? widget.bentocakeList.rating
        : _ratingController.text.toString();

      details = (_detailsController.text.toString() == "")
        ? widget.bentocakeList.details
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
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/edit_bento_cake.php"),
      body: {
        "bento_cake_no":widget.bentocakeList.bentoCakeNo,
        "bento_cake_name":name,
        "original_price":oriPrice,
        "offered_price":offeredPrice,
        "rating":rating,
        "bento_cake_detail":details,

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

              widget.bentocakeList.bentoCakeName=name;
              widget.bentocakeList.oriPrice=oriPrice;
              widget.bentocakeList.offeredPrice=offeredPrice;
              widget.bentocakeList.rating=rating;
              widget.bentocakeList.details=details;
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

    print(widget.bentocakeList.bentoCakeNo);

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text('Delete Bento Cake?',style: Theme.of(context).textTheme.headline5),
          content: Text("Are you sure?",style: Theme.of(context).textTheme.bodyText1),
          actions: [
            TextButton(
              child:(Text('Yes',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                Navigator.of(context).pop();
                _deleteBentoCake(widget.bentocakeList.bentoCakeNo);
                Navigator.pushReplacement(
                  context,MaterialPageRoute(builder: (context)=> MyBentoCakeListScreen(bentoCakeList: widget.bentocakeList,user: widget.user))
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

  void _deleteBentoCake(String bentoCakeNo) {
    print(bentoCakeNo);

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/delete_bento_cake.php"),
      body: {
        "bento_cake_no":widget.bentocakeList.bentoCakeNo,
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