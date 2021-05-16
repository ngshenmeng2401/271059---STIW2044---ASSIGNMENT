import 'package:flutter/material.dart';
import '../model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import '../model/theme.dart';
import 'register_screen.dart';
import 'bottom_navigation_bar.dart';

class LoginScreen extends StatefulWidget {

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  
  bool _rememberMe= false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  SharedPreferences preferences;
  ProgressDialog pr;
  double screenHeight, screenWidth;

  @override
  void initState() {
    loadPreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    pr = new ProgressDialog(context);
    pr.style(
      message: 'Login ...',
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
          title: Text('LITTLE CAKE STORY'),
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
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children:[
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                        icon:Icon(Icons.email,
                          color: Colors.red[200],),
                        labelText: 'Email',
                      ),
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock,
                          color: Colors.red[200]),
                          labelText: 'Password',
                        ),
                        obscureText: true,
                      ),                        
                    ]
                  ),
                ),
              ),
              Container(
                child: Column(
                  children:[
                    Container(
                      margin: EdgeInsets.fromLTRB(25,0,25,0),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Container(
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.red[200],
                                  value: _rememberMe,
                                  onChanged:(value){
                                  _onChanged(value);
                                }),
                                Text('Remember me',),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                GestureDetector(
                                  child:Text('Forgot Password ?',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                    fontSize: 16,
                                    color:Colors.red[300]),),
                                  onTap: _forgotPassword,
                                ) 
                              ],
                            ),
                          ),
                        ]
                      ),
                    ),
                    MaterialButton(
                      shape:RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(10),
                      ),
                      minWidth: screenWidth/1.15,
                      height: screenHeight/18,
                      child: Text('Login',
                      style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: 'Arial'),),
                      onPressed: (){
                        _onLogin();
                      },
                      color: Colors.red[200],
                    ),
                    SizedBox(height:10),
                    Container(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          GestureDetector(
                            child: Text('  SignUp',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[300]
                              ),
                              ),
                            onTap: _registerNewAccount,
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

    // pr.show();

    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();
    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/login_user.php"),
      body: {
        "email":_email,
        "password":_password,
      }).then(
        (response){
          print(response.body);
          if(response.body=="failed"){
            Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);
          }else{
            List userData = response.body.split(",");
            User user = new User(
              email: _email,
              password: _password,
              firstName: userData[1],
              lastName: userData[2],
              phoneNo: userData[3],
              dateReg: userData[4],
              rating: userData[5],
              credit: userData[6],
              status: userData[7]);
            Navigator.pushReplacement(
            context,MaterialPageRoute(builder: (context)=>BottomNavigationWidget(user:user,))
            );
          }
      }
    );
    
  }

  void _registerNewAccount() {
    Navigator.pushReplacement(
      context,MaterialPageRoute(builder: (context)=>RegistrationScreen())
    );
  }

  void _onChanged(bool value) {

    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();

    if(_email.isEmpty || _password.isEmpty){
      Fluttertoast.showToast(
        msg: "Email / Password is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0
    );
      return;
    }
    setState(() {
      print(_rememberMe);
      _rememberMe=value;
      storePreference(value,_email,_password);
    });
  }

  Future<void> storePreference(bool value, String email, String password) async{
    preferences = await SharedPreferences.getInstance();
    if(value==true){
      await preferences.setString("email", email);
      await preferences.setString("password", password);
      await preferences.setBool("rememberme", value);
      Fluttertoast.showToast(
        msg: "Email & Password stored",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0
      );
    return;
    }else{  
      await preferences.setString("email", '');
      await preferences.setString("password", '');
      await preferences.setBool("rememberme", value);
      Fluttertoast.showToast(
        msg: "Email & Password removed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 16.0
      );
      setState(() {
        _emailController.text="";
        _passwordController.text="";
        _rememberMe=false;
      });
      return;
    }
  }

  Future<void> loadPreference() async {
    preferences = await SharedPreferences.getInstance();
    String _email = preferences.getString("email")??'';
    String _password = preferences.getString("password")??'';
    _rememberMe= preferences.getBool("rememberme")??false;
    
    setState(() {
      _emailController.text=_email;
      _passwordController.text=_password;
    });
  }

  void _forgotPassword() {
    TextEditingController _useremailController = new TextEditingController();

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Forgot Your Password?',style: Theme.of(context).textTheme.headline5),
          content: new Container(
            height: screenHeight/8,
            child: Column(
              children: [
                Text('Enter your recovery email.',style: Theme.of(context).textTheme.bodyText1),
                TextField(
                  controller: _useremailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                  ),
                )
              ],),
          ),
          actions: [
            TextButton(
              child:(Text('Submit',style: Theme.of(context).textTheme.bodyText2)),
              onPressed: (){
                _resetPassword(_useremailController.text.toString());
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

  void _resetPassword(String emailreset) {

    print(emailreset);

    http.post(
      Uri.parse("https://javathree99.com/s271059/littlecakestory/php/forgot_password.php"),
      body: {
        "email":emailreset,
      }).then(
        (response){
          print(response.body);

          if(response.body=="success"){
            Fluttertoast.showToast(
            msg: "Password reset complete. Please check Your Email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[200],
            textColor: Colors.white,
            fontSize: 16.0);
            
          }else{
            Fluttertoast.showToast(
            msg: "Password reset failed",
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
