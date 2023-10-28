import 'package:aiims_e_learning/screens/activationsent_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:aiims_e_learning/providers/auth.dart';

String pass1;

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  bool _showPassword = false;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'name': '',
    're_password': '',
    'phone': ''
  };
  Future _submit() async {
    if (!_formkey.currentState.validate()) {
      //invalid
      return;
    }
    _formkey.currentState.save();
    try {
      String x = await Provider.of<Auth>(context, listen: false)
          .Authentication1(_authData['email'], _authData['password'],
              _authData['name'], _authData['re_password'], _authData['phone']);
      if (x == 'Good') {
        Navigator.pushNamed(context, ActivationsentScreen.id);
      } else if (x == 'Bad') {
        Fluttertoast.showToast(
            msg: "Doesn't satisfies Username-Password Constraints",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Server Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
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
          'Sign Up',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Sign Up',
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
                                'Name',
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
                                  if (value.isEmpty) {
                                    return 'Mandatory Field';
                                  }
                                },
                                onSaved: (value) {
                                  _authData['name'] = value;
                                },
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Email',
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
                                    return 'Invalid Email';
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
                                'Phone number',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                style: TextStyle(color: Colors.grey),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true),
                                validator: (value) {
                                  if (value.isEmpty || !(value.length == 10)) {
                                    return 'Invalid Phone number';
                                  }
                                },
                                onSaved: (value) {
                                  _authData['phone'] = value;
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
                                  if (value.isEmpty || value.length < 8) {
                                    return 'Password is too short';
                                  } else {
                                    pass1 = value;
                                  }
                                },
                                onSaved: (value) {
                                  _authData['password'] = value;
                                },
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Confirm Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                obscureText: true,
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
                                  if (value.isEmpty ||
                                      value.length < 8 ||
                                      !(value == pass1)) {
                                    return 'Password not matching';
                                  }
                                },
                                onSaved: (value) {
                                  _authData['re_password'] = value;
                                },
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          _submitButton(),
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
