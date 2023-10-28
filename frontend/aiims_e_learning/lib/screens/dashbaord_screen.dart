import 'package:aiims_e_learning/screens/evaluation_screen.dart';
import 'package:aiims_e_learning/screens/forum_screen.dart';
import 'package:aiims_e_learning/screens/course_screen.dart';
import 'package:aiims_e_learning/screens/game_screen.dart';
import 'package:aiims_e_learning/screens/instruction_screen.dart';
import 'package:aiims_e_learning/screens/notification_screen.dart';
import 'package:aiims_e_learning/screens/portfolio_screen.dart';
import 'package:http/http.dart' as http;
import 'package:aiims_e_learning/providers/requests.dart';
import 'package:aiims_e_learning/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'no_screen.dart';

class DashboardScreen extends StatelessWidget {
  static String id = 'dashboard_screen';
  static int email;
  static String userid;
  static String loginemail;
  static List<Map<String, String>> a;
  static String instructions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new DashboardStatefulWidget(),
    );
  }
}

class DashboardStatefulWidget extends StatefulWidget {
  DashboardStatefulWidget({Key key}) : super(key: key);

  @override
  _DashboardStatefulWidgetState createState() =>
      _DashboardStatefulWidgetState();
}

class _DashboardStatefulWidgetState extends State<DashboardStatefulWidget> {
  @override
  void initState() {
    funcThatMakesAsyncCall();
    super.initState();
  }

  void nav(int x) {
    if (x == 1) {
      Navigator.pushNamed(context, CourseScreen.id);
    } else if (x == 2) {
      Navigator.pushNamed(context, ForumScreen.id);
    } else if (x == 3) {
      Navigator.pushNamed(context, PortfolioScreen.id);
    } else {}
  }

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
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> _calculation =
    fetchUser(http.Client(), LoginScreen.token);

  Future funcThatMakesAsyncCall() async {
    var result = await fetchUser_id(http.Client(), LoginScreen.token);
    var result1 = await fetchEvaluationLists(http.Client(), LoginScreen.token);
    setState(() {
      if (result != null) {
        DashboardScreen.email = result;
      } else {
        DashboardScreen.email = null;
      }

      if (result1 != null && result1.isNotEmpty) {
        EvaluationScreen.evaluation = result1[0].id;
        EvaluationScreen.time_in_seconds = result1[0].time_in_seconds;
        DashboardScreen.instructions = result1[0].instructions;
      } else {
        EvaluationScreen.evaluation = null;
        EvaluationScreen.time_in_seconds = null;
        DashboardScreen.instructions = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: Drawer(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _calculation,
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
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        height: height,
        width: width,
        child: FutureBuilder<Map<String, dynamic>>(
          future: _calculation,
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              String na = snapshot.data['first_name'].toString();
              String na1;
              if (na.length > 6) {
                na1 = na.substring(0, 6) + '.';
              } else {
                na1 = na;
              }
              children = <Widget>[
                new Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    height: height * .25,
                    width: width,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      text: 'Hye ' + na1,
                                      style: GoogleFonts.portLligatSans(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, NotificationScreen.id);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.notifications_rounded,
                                          size: 40, color: Colors.white),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, ProfileScreen.id);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'images/dashboard.jpg')),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  child: new Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    width: width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                              height: 120,
                              child:
                                  Image(image: AssetImage('images/idea.png'))),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              elevation: 20,
                              shadowColor: Colors.blue,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, CourseScreen.id);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const ListTile(
                                      trailing: Image(
                                          image:
                                              AssetImage('images/courses.jpg')),
                                      title: Text(
                                        'Courses',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                          'Explore from Variety of Courses\nand Videos'),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        TextButton(
                                          child: Icon(Icons.arrow_right),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, CourseScreen.id);
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              elevation: 20,
                              shadowColor: Colors.blue,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, ForumScreen.id);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const ListTile(
                                      trailing: Image(
                                          image:
                                              AssetImage('images/library.jpg')),
                                      title: Text(
                                        'Forum',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                          'Ask as well as,\nAnswer Queries.'),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        TextButton(
                                          child: Icon(Icons.arrow_right),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, ForumScreen.id);
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              elevation: 20,
                              shadowColor: Colors.blue,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PortfolioScreen.id);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const ListTile(
                                      trailing: Image(
                                          image:
                                              AssetImage('images/faculty.jpg')),
                                      title: Text(
                                        'Faculty',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle:
                                          Text('Know about your,\nInstructor.'),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        TextButton(
                                          child: Icon(Icons.arrow_right),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, PortfolioScreen.id);
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              elevation: 20,
                              shadowColor: Colors.blue,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, ColorGame.id);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const ListTile(
                                      trailing: Image(
                                          image:
                                              AssetImage('images/courses.jpg')),
                                      title: Text(
                                        'Game',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text('Learn, \nWhile Playing.'),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        TextButton(
                                          child: Icon(Icons.arrow_right),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, CourseScreen.id);
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              elevation: 20,
                              shadowColor: Colors.blue,
                              child: InkWell(
                                onTap: () {
                                  if (DashboardScreen.instructions == null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NoScreen('No Evaluation'),
                                      ),
                                    );
                                  } else {
                                    Navigator.pushNamed(
                                        context, InstructionScreen.id);
                                  }
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const ListTile(
                                      trailing: Image(
                                          image:
                                              AssetImage('images/courses.jpg')),
                                      title: Text(
                                        'Evaluation',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle:
                                          Text('Evaluate, \nWhat You Learned.'),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        TextButton(
                                          child: Icon(Icons.arrow_right),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, InstructionScreen.id);
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
