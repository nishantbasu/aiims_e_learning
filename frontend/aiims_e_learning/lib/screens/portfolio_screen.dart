import 'package:aiims_e_learning/providers/models.dart';
import 'package:http/http.dart' as http;
import 'package:aiims_e_learning/providers/requests.dart';
import 'package:aiims_e_learning/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aiims_e_learning/providers/url.dart';
import 'dashbaord_screen.dart';
import 'profile_screen.dart';
import 'notification_screen.dart';
import 'forum_screen.dart';
import 'course_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PortfolioScreen extends StatelessWidget {
  static String id = 'portfolio_screen';
  static const String _title = 'Flutter Code Sample';
  static int course_loc_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new PortfolioScreenStatefulWidget(),
    );
  }
}

class PortfolioScreenStatefulWidget extends StatefulWidget {
  PortfolioScreenStatefulWidget({Key key}) : super(key: key);

  @override
  _PortfolioScreenStatefulWidgetState createState() =>
      _PortfolioScreenStatefulWidgetState();
}

class _PortfolioScreenStatefulWidgetState
    extends State<PortfolioScreenStatefulWidget> {
  int y;
  int l = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future _submit10() async {
    try {
      bool x = await Logout(LoginScreen.token);

      if (x == true) {
        Navigator.pushNamed(context, LoginScreen.id);
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
    } catch (e) {}
  }

  List cardtextList = [];
  List cardidList = [];
  List cardList = [];
  List descriptionList = [];

  showAlert(BuildContext context, String photo_url, String faculty_name,
      String about, String specialization) {
    String url = 'http://' + finurl + port + '/courses' + photo_url + '/';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: <Widget>[
              Image.network(
                url,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              Text(faculty_name),
              Text(specialization)
            ],
          ),
          content: Text(
            '\n' + about,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Map<String, dynamic>> _calculation1 =
      fetchUser(http.Client(), LoginScreen.token);

  Future<List<Faculties>> _calculation =
      fetchFaculties(http.Client(), LoginScreen.token);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: Drawer(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _calculation1,
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(
                    snapshot.data['first_name'],
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text(
                    snapshot.data['email'],
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? Colors.blue
                            : Colors.white,
                    child: Text(
                      snapshot.data['first_name'][0],
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Home",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  tileColor: Colors.blue,
                  onTap: () {
                    Navigator.pushNamed(context, DashboardScreen.id);
                  },
                ),
                ListTile(
                  title: Text(
                    "Courses",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  tileColor: Colors.blue,
                  onTap: () {
                    Navigator.pushNamed(context, CourseScreen.id);
                  },
                ),
                ListTile(
                  title: Text(
                    "Forum",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  tileColor: Colors.blue,
                  onTap: () {
                    Navigator.pushNamed(context, ForumScreen.id);
                  },
                ),
                ListTile(
                  title: Text(
                    "Faculty",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  tileColor: Colors.blue,
                  onTap: () {
                    Navigator.pushNamed(context, PortfolioScreen.id);
                  },
                ),
                ListTile(
                  title: Text(
                    "Profile",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  tileColor: Colors.blue,
                  onTap: () {
                    Navigator.pushNamed(context, ProfileScreen.id);
                  },
                ),
                ListTile(
                  title: Text(
                    "Notifications",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  tileColor: Colors.blue,
                  onTap: () {
                    Navigator.pushNamed(context, NotificationScreen.id);
                  },
                ),
                ListTile(
                  title: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  tileColor: Colors.blue,
                  onTap: () {
                    _submit10();
                  },
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
      appBar: new AppBar(),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
        child: FutureBuilder<List<Faculties>>(
          future: _calculation,
          builder:
              (BuildContext context, AsyncSnapshot<List<Faculties>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    height: height * .2,
                    width: width,
                    child: Image(image: AssetImage('images/crap.jpg')),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  height: (height * .6872) - 30,
                  width: width,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: height / 20,
                      ),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Instructors',
                            style: GoogleFonts.portLligatSans(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: InkWell(
                                    splashColor: Colors.blue,
                                    onTap: () {
                                      showAlert(
                                          context,
                                          snapshot.data[index].photo,
                                          snapshot.data[index].faculty_name,
                                          snapshot.data[index].about,
                                          snapshot.data[index].specialization);
                                    },
                                    child: ListTile(
                                      tileColor: Colors.white,
                                      title: Text(
                                        snapshot.data[index].faculty_name,
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Icon(Icons.person),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            );
          },
        ),
      ),
    );
  }
}
