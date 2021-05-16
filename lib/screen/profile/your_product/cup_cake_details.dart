import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:little_cake_story/model/cup_cake_list.dart';
import 'package:little_cake_story/model/user.dart';
import 'package:http/http.dart' as http;
import 'cup_cake_list.dart';

class CupCakeDetails extends StatefulWidget {

  final User user;
  final CupCakeList cupCakeList;
  const CupCakeDetails({Key key, this.user, this.cupCakeList}) : super(key: key);

  @override
  _CupCakeDetailsState createState() => _CupCakeDetailsState();
}

class _CupCakeDetailsState extends State<CupCakeDetails> {

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
                        CupCakeListScreen(cupCakeList: widget.cupCakeList,user: widget.user)));
          },
        ),
        title: Text('Cup Cakes', style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: screenHeight / 2.35,
              child: CachedNetworkImage(
                imageUrl:
                    "https://javathree99.com/s271059/littlecakestory/images/product_cup_cake/${widget.cupCakeList.cupCakeNo}.png",
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
                      title: Text(
                        widget.cupCakeList.cupCakeName,
                        style: TextStyle(fontSize: 20, fontFamily: 'Calibri'),
                      ),
                      subtitle: Text("Name"),
                      trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editNameDialog();
                          }),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
                        child: Divider(
                          color: Colors.red[200],
                        )),
                    ListTile(
                      title: Text(
                        "RM ${widget.cupCakeList.oriPrice}",
                        style: TextStyle(fontSize: 20, fontFamily: 'Calibri'),
                      ),
                      subtitle: Text("Original Price"),
                      trailing:
                          IconButton(icon: Icon(Icons.edit), 
                          onPressed: () {
                            _editOriPriceDialog();
                          }),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
                        child: Divider(
                          color: Colors.red[200],
                        )),
                    ListTile(
                      title: Text(
                        "RM ${widget.cupCakeList.offeredPrice}",
                        style: TextStyle(fontSize: 20, fontFamily: 'Calibri'),
                      ),
                      subtitle: Text("Offered Price"),
                      trailing:
                          IconButton(icon: Icon(Icons.edit), 
                          onPressed: () {
                            _editOfferedPriceDialog();
                          }),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
                        child: Divider(
                          color: Colors.red[200],
                        )),
                    ListTile(
                      title: Text(
                        widget.cupCakeList.rating,
                        style: TextStyle(fontSize: 20, fontFamily: 'Calibri'),
                      ),
                      subtitle: Text("Rating"),
                      trailing:
                          IconButton(icon: Icon(Icons.edit), 
                          onPressed: () {
                            _editRatingDialog();
                          }),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
                        child: Divider(
                          color: Colors.red[200],
                        )),
                    ListTile(
                      title: Text(
                        widget.cupCakeList.details,
                        style: TextStyle(fontSize: 16, fontFamily: 'Calibri',),
                      ),
                      subtitle: Text("Details"),
                      trailing:
                          IconButton(icon: Icon(Icons.edit), 
                          onPressed: () {
                            _editDetailsDialog();
                          }),
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

  void _editNameDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter new name.',
                style: Theme.of(context).textTheme.headline6),
            content: new Container(
              child: TextField(
                controller: _nameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: widget.cupCakeList.cupCakeName,
                  labelText: 'Name',
                ),
              ),
            ),
            actions: [
              TextButton(
                child: (Text('Submit',
                    style: Theme.of(context).textTheme.bodyText2)),
                onPressed: () {
                  _editName(_nameController.text.toString());
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

  void _editName(String name) {

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/edit_cup_cake_name.php"),
      body: {
        "cup_cake_no":widget.cupCakeList.cupCakeNo,
        "name":name,
      }).then(
        (response){
          print(response.body);

          if(response.body=="success"){

            _showSuccessToast();
            
            setState(() {
              widget.cupCakeList.cupCakeName=name;
            });

          }else{
            
            _showFailedToast();

          }

        }
      );
  }
  
  void _editOriPriceDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter New Original Price',
                style: Theme.of(context).textTheme.headline6),
            content: new Container(
              child: TextField(
                controller: _oriPriceController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: widget.cupCakeList.oriPrice,
                  labelText: 'Original Price',
                ),
              ),
            ),
            actions: [
              TextButton(
                child: (Text('Submit',
                    style: Theme.of(context).textTheme.bodyText2)),
                onPressed: () {
                  _editOriginalPrice(_oriPriceController.text.toString());
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

  void _editOriginalPrice(String oriPrice) {

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/edit_cup_cake_oriPrice.php"),
      body: {
        "cup_cake_no":widget.cupCakeList.cupCakeNo,
        "oriPrice":oriPrice,
      }).then(
        (response){
          print(response.body);

          if(response.body=="success"){

            _showSuccessToast();

             setState(() {
              widget.cupCakeList.oriPrice=oriPrice;
            });
            
          }else{
            
            _showFailedToast();

          }
      }
    );
  }

  void _editOfferedPriceDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter new offered price.',
                style: Theme.of(context).textTheme.headline6),
            content: new Container(
              child: TextField(
                controller: _offeredPriceController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: widget.cupCakeList.offeredPrice,
                  labelText: 'Offered Price',
                ),
              ),
            ),
            actions: [
              TextButton(
                child: (Text('Submit',
                    style: Theme.of(context).textTheme.bodyText2)),
                onPressed: () {
                  _editOfferedPrice(_offeredPriceController.text.toString());
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

  void _editOfferedPrice(String offeredPrice) {

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/edit_cup_cake_offeredPrice.php"),
      body: {
        "cup_cake_no":widget.cupCakeList.cupCakeNo,
        "offeredPrice":offeredPrice,
      }).then(
        (response){
          print(response.body);

          if(response.body=="success"){

            _showSuccessToast();

            setState(() {
              widget.cupCakeList.offeredPrice=offeredPrice;
            });
            
          }else{
            
            _showFailedToast();

          }
      }
    );
  }

  void _editRatingDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter new rating.',
                style: Theme.of(context).textTheme.headline6),
            content: new Container(
              child: TextField(
                controller: _ratingController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: widget.cupCakeList.rating,
                  labelText: 'Rating',
                ),
              ),
            ),
            actions: [
              TextButton(
                child: (Text('Submit',
                    style: Theme.of(context).textTheme.bodyText2)),
                onPressed: () {
                  _editRating(_ratingController.text.toString());
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

  void _editRating(String rating) {

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/edit_cup_cake_rating.php"),
      body: {
        "cup_cake_no":widget.cupCakeList.cupCakeNo,
        "rating":rating,
      }).then(
        (response){
          print(response.body);

          if(response.body=="success"){

            _showSuccessToast();

            setState(() {
              widget.cupCakeList.rating=rating;
            });
            
          }else{
            
            _showFailedToast();

          }
      }
    );
  }

  void _editDetailsDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter new details.',
                style: Theme.of(context).textTheme.headline6),
            content: new Container(
              child: TextField(
                controller: _detailsController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: widget.cupCakeList.details,
                  labelText: 'Details',
                ),
              ),
            ),
            actions: [
              TextButton(
                child: (Text('Submit',
                    style: Theme.of(context).textTheme.bodyText2)),
                onPressed: () {
                  _editDetails(_detailsController.text.toString());
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

  void _editDetails(String details) {

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/edit_cup_cake_details.php"),
      body: {
        "cup_cake_no":widget.cupCakeList.cupCakeNo,
        "details":details,
      }).then(
        (response){
          print(response.body);

          if(response.body=="success"){

            _showSuccessToast();

            setState(() {
              widget.cupCakeList.details=details;
            });
            
          }else{
            
            _showFailedToast();

          }
      }
    );
  }

  void _showSuccessToast() {

    Fluttertoast.showToast(
      msg: "Edit Success",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red[200],
      textColor: Colors.white,
      fontSize: 16.0);
  }

  void _showFailedToast() {

    Fluttertoast.showToast(
      msg: "Edit Failed",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red[200],
      textColor: Colors.white,
      fontSize: 16.0);
  }

  void _deleteDialog() {

    print(widget.cupCakeList.cupCakeNo);

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text('Delete Cup Cake?',style: Theme.of(context).textTheme.headline5),
          content: Text("Are you sure?",style: Theme.of(context).textTheme.bodyText1),
          actions: [
            TextButton(
              child:(Text('Yes',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                Navigator.of(context).pop();
                _deleteCupCake(widget.cupCakeList.cupCakeNo);
                Navigator.pushReplacement(
                  context,MaterialPageRoute(builder: (context)=> CupCakeListScreen(cupCakeList: widget.cupCakeList,user: widget.user))
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

  void _deleteCupCake(String cupCakeNo) {
    print(cupCakeNo);

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/delete_cup_cake.php"),
      body: {
        "cup_cake_no":widget.cupCakeList.cupCakeNo,
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