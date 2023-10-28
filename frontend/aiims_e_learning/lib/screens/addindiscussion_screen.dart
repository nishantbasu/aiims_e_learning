import 'package:aiims_e_learning/screens/forum_screen.dart';
import 'package:aiims_e_learning/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:aiims_e_learning/providers/requests.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddindiscussionScreen extends StatelessWidget {
  static String id = 'addindiscussion_screen';
  static String discuss;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AddindiscussionScreenStateful(),
    );
  }
}

class AddindiscussionScreenStateful extends StatefulWidget {
  @override
  AddindiscussionScreenState createState() {
    return AddindiscussionScreenState();
  }
}

class AddindiscussionScreenState extends State<AddindiscussionScreenStateful> {
  Future _submit() async {
    try {
      bool x = await AddInDiscussion(ForumScreen.video_loc_id,
          AddindiscussionScreen.discuss, LoginScreen.token);

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
                icon: Icon(Icons.comment),
                labelText: 'Your Comment',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Comments';
                }
                AddindiscussionScreen.discuss = value;
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
