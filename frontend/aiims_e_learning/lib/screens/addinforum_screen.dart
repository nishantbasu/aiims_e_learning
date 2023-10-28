import 'package:aiims_e_learning/screens/dashbaord_screen.dart';
import 'package:aiims_e_learning/screens/forum_screen.dart';
import 'package:aiims_e_learning/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:aiims_e_learning/providers/requests.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddinforumScreen extends StatelessWidget {
  static String id = 'addinforum_screen';
  static String name;
  static String topic;
  static String description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AddinforumScreenStateful(),
    );
  }
}

class AddinforumScreenStateful extends StatefulWidget {
  @override
  AddinforumScreenState createState() {
    return AddinforumScreenState();
  }
}

class AddinforumScreenState extends State<AddinforumScreenStateful> {
  Future _submit() async {
    try {
      bool x = await AddInForum(
          AddinforumScreen.name,
          DashboardScreen.email,
          AddinforumScreen.topic,
          AddinforumScreen.description,
          LoginScreen.token);

      if (x == true) {
        Navigator.pushNamed(context, ForumScreen.id);
      } else if (x == false) {
        Fluttertoast.showToast(
            msg: "Server Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Something Went Wrong!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {}
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Display Name',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter name';
                }
                AddinforumScreen.name = value;
                return null;
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.topic),
                labelText: 'Topic',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter topic';
                }
                AddinforumScreen.topic = value;
                return null;
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.description),
                labelText: 'Description',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter description';
                }
                AddinforumScreen.description = value;
                return null;
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _submit();
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
