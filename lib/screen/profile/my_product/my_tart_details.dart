import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:little_cake_story/model/tart.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:little_cake_story/screen/profile/my_product/my_tarts_list.dart';

class MyTartDetails extends StatefulWidget {

  final User user;
  final TartList tartList;
  const MyTartDetails({Key key, this.user, this.tartList}) : super(key: key);

  @override
  _MyTartDetailsState createState() => _MyTartDetailsState();
}

class _MyTartDetailsState extends State<MyTartDetails> {

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
                        MyTartsListScreen(tartList: widget.tartList,user: widget.user)));
          },
        ),
        title: Text('Tarts', style: TextStyle(fontFamily: 'Arial')),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.red[200],
            onPressed: () {
              _editDialog();
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: screenHeight / 2.35,
              child: CachedNetworkImage(
                imageUrl:
                    "https://javathree99.com/s271059/littlecakestory/images/product_tart/${widget.tartList.tartNo}.png",
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
                        widget.tartList.tartName,
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
                        "RM ${widget.tartList.oriPrice}",
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
                        "RM ${widget.tartList.offeredPrice}",
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
                        widget.tartList.rating,
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
                        widget.tartList.details,
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
                      hintText: widget.tartList.tartName,
                      labelText: 'Name',
                    ),
                  ),
                ),
                ListTile(
                  title: TextField(
                    controller: _oriPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: widget.tartList.oriPrice,
                      labelText: 'Original Price',
                    ),
                  ),
                ),
                ListTile(
                  title: TextField(
                    controller: _offeredPriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: widget.tartList.offeredPrice,
                      labelText: 'Offered Price',
                    ),
                  ),
                ),
                ListTile(
                  title: TextField(
                    controller: _ratingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: widget.tartList.rating,
                      labelText: 'Rating',
                    ),
                  ),
                ),
                ListTile(
                  title: TextField(
                    controller: _detailsController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: widget.tartList.details,
                      labelText: 'Details',
                    ),
                  ),
                )
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
        ? widget.tartList.tartName
        : _nameController.text.toString();
      
      oriPrice = (_oriPriceController.text.toString() == "")
        ? widget.tartList.oriPrice
        : _oriPriceController.text.toString();

      offeredPrice = (_offeredPriceController.text.toString() == "")
        ? widget.tartList.offeredPrice
        : _offeredPriceController.text.toString();

      rating = (_ratingController.text.toString() == "")
        ? widget.tartList.rating
        : _ratingController.text.toString();

      details = (_detailsController.text.toString() == "")
        ? widget.tartList.details
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
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/edit_tart.php"),
      body: {
        "tart_no":widget.tartList.tartNo,
        "tart_name":name,
        "original_price":oriPrice,
        "offered_price":offeredPrice,
        "rating":rating,
        "tart_detail":details,

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

              widget.tartList.tartName=name;
              widget.tartList.oriPrice=oriPrice;
              widget.tartList.offeredPrice=offeredPrice;
              widget.tartList.rating=rating;
              widget.tartList.details=details;
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

    print(widget.tartList.tartNo);

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text('Delete tart ?',style: Theme.of(context).textTheme.headline5),
          content: Text("Are you sure?",style: Theme.of(context).textTheme.bodyText1),
          actions: [
            TextButton(
              child:(Text('Yes',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                Navigator.of(context).pop();
                _deleteTart(widget.tartList.tartNo);
                Navigator.pushReplacement(
                  context,MaterialPageRoute(builder: (context)=> MyTartsListScreen(tartList: widget.tartList,user: widget.user))
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

  void _deleteTart(String tartNo) {
    print(tartNo);

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/delete_tart.php"),
      body: {
        "tart_no":widget.tartList.tartNo,
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