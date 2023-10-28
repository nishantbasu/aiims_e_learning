import 'package:aiims_e_learning/screens/addinforum_screen.dart';
import 'package:aiims_e_learning/screens/discussion_screen.dart';
import 'package:aiims_e_learning/screens/course_screen.dart';
import 'package:aiims_e_learning/screens/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aiims_e_learning/providers/models.dart';
import 'package:aiims_e_learning/providers/requests.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashbaord_screen.dart';
import 'profile_screen.dart';
import 'portfolio_screen.dart';
import 'notification_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForumScreen extends StatelessWidget {
  final String title;
  static String cc;
  static int video_loc_id;
  static String id = 'forum_screen';

  ForumScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ForumList>>(
        future: fetchForumLists(http.Client(), LoginScreen.token),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<ForumList> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  final Future<Map<String, dynamic>> _calculation1 =
      fetchUser(http.Client(), LoginScreen.token);

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        elevation: 100,
        onPressed: () {
          Navigator.pushNamed(context, AddinforumScreen.id);
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: height * .2,
              width: width,
              child: Image(image: AssetImage('images/forum.jpg')),
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
                      text: 'Forum',
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
                    itemCount: photos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                              splashColor: Colors.blue,
                              onTap: () {
                                ForumScreen.video_loc_id = photos[index].id;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DiscussionScreen(
                                        topic: photos[index].topic,
                                        email: photos[index].email,
                                        name: photos[index].name,
                                        description: photos[index].description,
                                        date_created:
                                            photos[index].date_created),
                                  ),
                                );
                              },
                              child: ListTile(
                                tileColor: Colors.amber[50],
                                leading: Icon(Icons.message),
                                title: Text(
                                  photos[index].topic,
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                                subtitle: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(photos[index].name)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(photos[index]
                                            .date_created
                                            .substring(0, 10))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
