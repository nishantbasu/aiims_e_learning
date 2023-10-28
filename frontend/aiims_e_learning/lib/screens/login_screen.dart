import 'package:aiims_e_learning/providers/auth.dart';
import 'package:aiims_e_learning/screens/forgotpassword_screen.dart';
import 'dashbaord_screen.dart';
import 'package:aiims_e_learning/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  static String token;
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  bool _showPassword = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  Future _submit() async {
    DashboardScreen.loginemail = _authData['email'];
    if (!_formkey.currentState.validate()) {
      //invalid
      return;
    }
    _formkey.currentState.save();
    try {
      String x = await Provider.of<Auth>(context, listen: false)
          .Authentication(_authData['email'], _authData['password']);

      if (x == null) {
        Fluttertoast.showToast(
            msg: "Server Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (x == 'Not authenticated') {
        Fluttertoast.showToast(
            msg: "Wrong Email or Password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        LoginScreen.token = x;
        Navigator.pushNamed(context, DashboardScreen.id);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.blue, Colors.blue])),
      child: MaterialButton(
        onPressed: () {
          _submit();
        },
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            },
            child: Text(
              'Register',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Login',
        style: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formkey,
      child: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            new Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              height: height * .3,
              width: width,
              child: Center(child: _title()),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: height * .35,
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Email Id',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                obscureText: false,
                                style: TextStyle(color: Colors.grey),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true),
                                validator: (value) {
                                  if (value.isEmpty ||
                                      !EmailValidator.validate(value)) {
                                    return 'invalid email';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  _authData['email'] = value;
                                },
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                obscureText: !this._showPassword,
                                style: TextStyle(color: Colors.grey),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: this._showPassword
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() => this._showPassword =
                                          !this._showPassword);
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty || value.length < 5) {
                                    return 'Password is too short';
                                  }
                                },
                                onSaved: (value) {
                                  _authData['password'] = value;
                                },
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          _submitButton(),
                          MaterialButton(
                            onPressed: () => {
                              Navigator.pushNamed(
                                  context, ForgotPasswordScreen.id)
                            },
                            child: Text('Forgot Password ?',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(height: height * .01),
                          _createAccountLabel(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
