import 'package:aiims_e_learning/providers/models.dart';
import 'package:aiims_e_learning/screens/coursenavigation_screen.dart';
import 'package:http/http.dart' as http;
import 'package:aiims_e_learning/providers/requests.dart';
import 'package:aiims_e_learning/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashbaord_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';
import 'forum_screen.dart';
import 'portfolio_screen.dart';
import 'package:aiims_e_learning/providers/url.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CourseScreen extends StatelessWidget {
  static String id = 'course_screen';
  static const String _title = 'Flutter Code Sample';
  static int course_loc_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new CourseScreenStatefulWidget(),
    );
  }
}

class CourseScreenStatefulWidget extends StatefulWidget {
  CourseScreenStatefulWidget({Key key}) : super(key: key);

  @override
  _CourseScreenStatefulWidgetState createState() =>
      _CourseScreenStatefulWidgetState();
}

class _CourseScreenStatefulWidgetState
    extends State<CourseScreenStatefulWidget> {
  @override
  void initState() {
    funcThatMakesAsyncCall();
    super.initState();
  }

  List<Map<String, String>> a;
  bool awaitresult = false;

  Future funcThatMakesAsyncCall() async {
    var result1 = await fetchCourses(http.Client(), LoginScreen.token);

    List<Map<String, String>> b = [];
    for (int i = 0; i < result1.length; i++) {
      Map<String, String> x = {};
      x[result1[i].course_name.toString()] = result1[i].thumbnail.toString();
      b.add(x);
    }

    setState(() {
      a = b;
    });
  }

  int y;
  int l = 0;

  int _currentIndex = 0;

  List cardtextList = [];
  List cardidList = [];
  List cardList = [];
  List descriptionList = [];
  String thumb;

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

  Widget _entryField(String title, int id1) {
    String title1;
    if (title.length > 10) {
      title1 = title.substring(0, 10) + '..';
    }
    y = id1;
    String thumbnail;
    int index;
    for (int i = 0; i < a.length; i++) {
      if (a[i].containsKey(title)) {
        index = i;
      }
    }
    thumbnail = a[index][title];

    String url = 'http://' + finurl + port + '/courses' + thumbnail + '/';
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(32)),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
              0.3,
              1
            ],
            colors: [
              Colors.white,
              Colors.white,
            ]),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 8.0, left: 0, right: 0, bottom: 0),
            child: Image.network(
              url,
              height: 160.0,
              fit: BoxFit.cover,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height / 7,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(32))),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      title1,
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.blueGrey,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Future<List<Courses>> _calculation =
      fetchCourses(http.Client(), LoginScreen.token);
  Future<Map<String, dynamic>> _calculation1 =
      fetchUser(http.Client(), LoginScreen.token);

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
      backgroundColor: Colors.white,
      body: Container(
        child: FutureBuilder<List<Courses>>(
          future: _calculation,
          builder:
              (BuildContext context, AsyncSnapshot<List<Courses>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  height: height * .2,
                  width: width,
                  child: Image(
                      image: AssetImage('images/cours.png'), fit: BoxFit.cover),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    height: height * 0.5,
                    width: width,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'Course Explorer',
                                style: GoogleFonts.portLligatSans(
                                  textStyle:
                                      Theme.of(context).textTheme.headline4,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (l != 0) {
                                CourseScreen.course_loc_id = l;
                              } else {
                                CourseScreen.course_loc_id = y;
                              }

                              Navigator.pushNamed(
                                  context, CourseNavigationScreen.id);
                            },
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: 500,
                                autoPlay: false,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                pauseAutoPlayOnTouch: true,
                                aspectRatio: 2.0,
                                onPageChanged: (index, reason) {
                                  l = snapshot.data[index].id;
                                  thumb = snapshot.data[index].thumbnail;
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                              ),
                              items: snapshot.data.map((card) {
                                return Builder(builder: (BuildContext context) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        top: 50, left: 8, right: 8, bottom: 40),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(32))),
                                    height: MediaQuery.of(context).size.height *
                                        0.30,
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      elevation: 20,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      color: Colors.yellow,
                                      child: _entryField(card.course_name,
                                          snapshot.data[0].id),
                                    ),
                                  );
                                });
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
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
