import 'package:flutter/material.dart';
import 'package:aiims_e_learning/providers/requests.dart';
import 'package:http/http.dart' as http;
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  static String id = 'profile_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Future<Map<String, dynamic>> _calculation =
      fetchUser(http.Client(), LoginScreen.token);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(),
      backgroundColor: Colors.white,
      body: Container(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _calculation,
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                SizedBox(
                  height: 120,
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue,
                  child: Text(
                    snapshot.data['first_name'][0],
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'SourceSansPro',
                    color: Colors.blue,
                    letterSpacing: 2.5,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                  width: 200,
                  child: Divider(
                    color: Colors.teal[100],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                      color: Colors.blue,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        title: Text(
                          snapshot.data['first_name'],
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'BalooBhai',
                              fontSize: 20.0),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                      color: Colors.blue,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        title: Text(
                          snapshot.data['email'],
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'BalooBhai',
                              fontSize: 20.0),
                        ),
                      )),
                ),
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ];
            }
            return Column(
              children: children,
            );
          },
        ),
      ),
    );
  }
}
