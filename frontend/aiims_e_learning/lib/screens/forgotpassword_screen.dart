import 'package:aiims_e_learning/screens/resetsent_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:aiims_e_learning/providers/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String id = 'forgotpassword_screen';
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
  };
  Future _submit() async {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();
    try {
      String x =
          await Provider.of<Auth>(context, listen: false).Authentication2(
        _authData['email'],
      );
      if (x == 'done') {
        Navigator.pushNamed(context, ResetsentScreen.id);
      } else if (x == 'email not found') {
        Fluttertoast.showToast(
            msg: "Email not in Database",
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
          'Submit',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Forgot Password',
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
        color: Colors.white,
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
                                'Enter Your Email',
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
