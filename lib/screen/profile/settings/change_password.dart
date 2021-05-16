import 'package:flutter/material.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:little_cake_story/model/user.dart';

class ChangePasswordScreen extends StatefulWidget {
  final User user;
  const ChangePasswordScreen({Key key, this.user}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _currentpasswordController =
      new TextEditingController();
  TextEditingController _newpasswordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();
  bool hiddenPassword1 = true, hiddenPassword2 = true, hiddenPassword3 = true;
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password", style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).hoverColor,
                      borderRadius: BorderRadius.circular(20)),
                  height: screenHeight / 1.6,
                  width: screenWidth / 1.1,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(children: [
                            Text(
                              "Create A New Password",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Set your new password so you can login and access Little Cake Story",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ]),
                        ),
                        SizedBox(height: 40),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10),
                            ),
                            border:Border.all(
                              color:Colors.red[200],
                            )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Column(
                              children: [
                              TextField(
                                controller: _currentpasswordController,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.lock,
                                      color: Colors.red[200],
                                    ),
                                    labelText: 'Current Password',
                                    labelStyle: TextStyle(
                                        fontSize: 18, fontFamily: 'Calibri'),
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            hiddenPassword1 = !hiddenPassword1;
                                          });
                                        },
                                        child: Icon(hiddenPassword1
                                            ? Icons.visibility_off
                                            : Icons.visibility))),
                                obscureText: hiddenPassword1,
                              ),
                              SizedBox(height: 20),
                              TextField(
                                controller: _newpasswordController,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.lock,
                                      color: Colors.red[200],
                                    ),
                                    labelText: 'New Password',
                                    labelStyle: TextStyle(
                                        fontSize: 18, fontFamily: 'Calibri'),
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            hiddenPassword2 = !hiddenPassword2;
                                          });
                                        },
                                        child: Icon(hiddenPassword2
                                            ? Icons.visibility_off
                                            : Icons.visibility))),
                                obscureText: hiddenPassword2,
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 20, 0, 0),
                                  child: FlutterPasswordStrength(
                                    password: _newpasswordController.text,
                                    strengthCallback: (strength) {
                                      debugPrint(strength.toString());
                                    },
                                  )),
                              SizedBox(height: 20),
                              TextField(
                                controller: _confirmPasswordController,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.lock,
                                      color: Colors.red[200],
                                    ),
                                    labelText: 'Confirm Password',
                                    labelStyle: TextStyle(
                                        fontSize: 18, fontFamily: 'Calibri'),
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            hiddenPassword3 = !hiddenPassword3;
                                          });
                                        },
                                        child: Icon(hiddenPassword3
                                            ? Icons.visibility_off
                                            : Icons.visibility))),
                                obscureText: hiddenPassword3,
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 20, 0, 0),
                                  child: FlutterPasswordStrength(
                                    password: _confirmPasswordController.text,
                                    strengthCallback: (strength) {
                                      debugPrint(strength.toString());
                                    },
                                  )),
                              SizedBox(height: 20),
                            ]),
                          ),
                        ),
                      ])),
              SizedBox(height:30),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minWidth: screenWidth/1.1,
                height: screenHeight/18,
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                      fontSize: 18, color: Colors.white, fontFamily: 'Arial'),
                ),
                onPressed: _onReset,
                color: Colors.red[200],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _onReset() {
    String _currentPassword = _currentpasswordController.text.toString();
    String _newPassword = _newpasswordController.text.toString();
    String _confirmPassword = _confirmPasswordController.text.toString();

    if (_currentPassword.isEmpty &&
        _newPassword.isEmpty &&
        _confirmPassword.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill in all textfield",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[200],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_currentPassword.isEmpty) {
      Fluttertoast.showToast(
          msg: "Current Password is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[200],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_newPassword.isEmpty) {
      Fluttertoast.showToast(
          msg: "New Password is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[200],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_confirmPassword.isEmpty) {
      Fluttertoast.showToast(
          msg: "Confirm Password is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[200],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_newPassword != _confirmPassword ||
        _confirmPassword != _newPassword) {
      Fluttertoast.showToast(
          msg: "Both Password is different",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[200],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_currentPassword != widget.user.password) {
      Fluttertoast.showToast(
          msg: "Current Password is incorrect",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[200],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_newPassword == widget.user.password ||
        _confirmPassword == widget.user.password) {
      Fluttertoast.showToast(
          msg: "Please make a new DIFFERENT password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[200],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    // else{
    //   Fluttertoast.showToast(
    //     msg: "Success",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red[200],
    //     textColor: Colors.white,
    //     fontSize: 16.0);
    // }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text('Register new user?',
                style: Theme.of(context).textTheme.headline5),
            content: Text("Are you sure?",
                style: Theme.of(context).textTheme.bodyText1),
            actions: [
              TextButton(
                child:
                    (Text('Ok', style: Theme.of(context).textTheme.bodyText2)),
                onPressed: () {
                  _resetPassword(_newPassword, widget.user.email);
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

  void _resetPassword(String newpassword, String email) {
    print(email);
    print(newpassword);
    print("Success");

    http.post(
        Uri.parse(
            "https://javathree99.com/s271059/littlecakestory/php/resetpassword_user.php"),
        body: {
          "email": email,
          "newpassword": newpassword,
        }).then((response) {
      print(response.body);

      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Reset Success. Please check your email to vertify account.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Reset Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }
}
