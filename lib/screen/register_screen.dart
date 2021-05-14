import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;
import '../Password_Strength/flutter_password_strength.dart';

class RegistrationScreen extends StatefulWidget {
    
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _phoneNoController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();
  bool hiddenPassword1 = true , hiddenPassword2 = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        title: Text('LITTLE CAKE STORY',style: TextStyle(fontFamily: 'Arial'),),
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(80,30,80,10),
              child: Image.asset('assets/images/logo2.png',
              scale: 0.5,),
              ),
              SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.fromLTRB(25,10,25,5),
              decoration: BoxDecoration(
                border: Border.all(
                color:Colors.red[200]
                ),
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Column(
                  children:[
                    TextField(
                      controller: _firstNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                      icon:Icon(Icons.email,
                      color: Colors.red[200],),
                      labelText: 'First Name',
                      ),
                    ),
                    TextField(
                      controller: _lastNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                      icon:Icon(Icons.people,
                      color: Colors.red[200],),
                      labelText: 'Last Name',
                      ),
                    ),
                    TextField(
                      controller: _phoneNoController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                      icon:Icon(Icons.phone,
                      color: Colors.red[200],),
                      labelText: 'Phone No',
                      ),
                    ),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                      icon:Icon(Icons.people,
                      color: Colors.red[200],),
                      labelText: 'Email',
                      ),
                    ),
                    Column(
                      children: [
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock,
                            color: Colors.red[200],),
                            labelText: 'Password',
                            suffixIcon:GestureDetector(
                              onTap: (){
                                setState(() {
                                  hiddenPassword1 =! hiddenPassword1;
                                });
                              },
                              child: Icon(
                                hiddenPassword1 ? Icons.visibility_off : Icons.visibility))
                          ),
                          obscureText: hiddenPassword1,
                          onChanged: (value) {
                            setState(() {
                            });
                          },
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
                            child: FlutterPasswordStrength(
                            password: _passwordController.text,
                            strengthCallback: (strength) {
                              debugPrint(strength.toString());
                              },
                            )),
                      ],
                    ),
                    Column(
                      children:[
                        TextField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock,
                            color: Colors.red[200],),
                            labelText: 'Confirm Password',
                            suffixIcon:GestureDetector(
                              onTap: (){
                                setState(() {
                                  hiddenPassword2 =! hiddenPassword2;
                                });
                              },
                              child: Icon(
                                hiddenPassword2 ? Icons.visibility_off : Icons.visibility))
                          ),
                          obscureText: hiddenPassword2,
                          onChanged: (value) {
                            setState(() {
                            });
                          },
                        ),
                        Padding(
                        padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
                        child: FlutterPasswordStrength(
                        password: _confirmPasswordController.text,
                        strengthCallback: (strength) {
                          debugPrint(strength.toString());
                          },
                        )),    
                      ]
                    )                 
                  ]
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25,10,25,5),
              child: Column(
                children:[
                  MaterialButton(
                    shape:RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(10),
                    ),
                    minWidth: 360,
                    height: 40,
                    child: Text('Create Account',
                    style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: 'Arial'),),
                    onPressed: _onRegister,
                    color: Colors.red[200],
                  ),
                  SizedBox(height:10),
                  Container(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        GestureDetector(
                          child: Text('  Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[300]),
                            ),
                          onTap: _onLogin,
                        ),
                      ],)
                  )
                ]
              ),
            ),
          ],)
      ),
    );
  }
                
  void _onLogin() {
    Navigator.pushReplacement(
      context,MaterialPageRoute(builder: (context)=>LoginScreen())
    );
  }


  void _onRegister() {
    String _firstname = _firstNameController.text.toString();
    String _lastname = _lastNameController.text.toString();
    String _phoneno = _phoneNoController.text.toString();
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();
    String _confirmPassword = _confirmPasswordController.text.toString();

    if(_firstname.isEmpty && _lastname.isEmpty && _phoneno.isEmpty && _email.isEmpty && _password.isEmpty && _confirmPassword.isEmpty){
      Fluttertoast.showToast(
        msg: "Please fill in all textfield",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }else if(_firstname.isEmpty || _lastname.isEmpty){
      Fluttertoast.showToast(
        msg: "Name is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }else if(_phoneno.isEmpty ){
      Fluttertoast.showToast(
        msg: "Phone No is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }else if(_email.isEmpty){
      Fluttertoast.showToast(
        msg: "Email is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }else if(_password.isEmpty || _confirmPassword.isEmpty){
      Fluttertoast.showToast(
        msg: "Password is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }else if( _password!=_confirmPassword || _confirmPassword!=_password){
      Fluttertoast.showToast(
        msg: "Both Password is different",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0);
      return;
    }
    //checking the data intergrity
    
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text('Register new user?',style: Theme.of(context).textTheme.headline5),
          content: Text("Are you sure?",style: Theme.of(context).textTheme.bodyText1),
          actions: [
            TextButton(
              child:(Text('Ok',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                _resgisterUser(_firstname,_lastname,_phoneno,_email,_password);
                Navigator.of(context).pop();
              },),
            TextButton(
              child: (Text('Cancel',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                Navigator.of(context).pop();
              },),
          ],
        );
      });
  }

  void _resgisterUser(String firstname,String lastname,String phoneno,String email, String password) {

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/register_user.php"),
      body: {
        "firstname":firstname,
        "lastname":lastname,
        "phoneno":phoneno,
        "email":email,
        "password":password,
      }).then(
        (response){
          print(response.body);

          if(response.body=="success"){
            Fluttertoast.showToast(
            msg: "Registration Success. Please check your email to vertify account.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);
          }else{
            Fluttertoast.showToast(
            msg: "Registration Failed",
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