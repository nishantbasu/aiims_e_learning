import 'package:aiims_e_learning/screens/elib_screen.dart';
import 'package:aiims_e_learning/screens/no_screen.dart';
import 'package:aiims_e_learning/screens/playlist_screen.dart';
import 'package:aiims_e_learning/screens/quiz_screen.dart';
import 'app_theme.dart';
import 'package:flutter/material.dart';
import 'package:aiims_e_learning/providers/requests.dart';
import 'package:http/http.dart' as http;
import 'package:aiims_e_learning/screens/login_screen.dart';
import 'package:aiims_e_learning/screens/course_screen.dart';

class CourseNavigationScreen extends StatefulWidget {
  static String id = 'course_navigation';
  static int quiz_loc_id;
  static int number_of_questions;
  static int retrieved_courseid;
  @override
  _CourseNavigationScreenState createState() => _CourseNavigationScreenState();
}

class _CourseNavigationScreenState extends State<CourseNavigationScreen> {
  @override
  void initState() {
    funcThatMakesAsyncCall();

    super.initState();
  }

  Future funcThatMakesAsyncCall() async {
    var result = await fetchQuiz_id(
        http.Client(), LoginScreen.token, CourseScreen.course_loc_id);
    var result1 = await fetchNumberofQuestions(
        http.Client(), LoginScreen.token, CourseScreen.course_loc_id);
    var result2 = await fetchQuiz_courseid(
        http.Client(), LoginScreen.token, CourseScreen.course_loc_id);
    setState(() {
      if (result != null) {
        CourseNavigationScreen.quiz_loc_id = result;
      } else {
        CourseNavigationScreen.quiz_loc_id = null;
      }
      if (result1 != null) {
        CourseNavigationScreen.number_of_questions = result1;
      } else {
        CourseNavigationScreen.number_of_questions = null;
      }
      if (result2 != null) {
        CourseNavigationScreen.retrieved_courseid = result2;
      } else {
        CourseNavigationScreen.retrieved_courseid = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: AppTheme.nearlyWhite,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              child: Column(
            children: <Widget>[
              InkWell(
                splashColor: Colors.blue,
                onTap: () {
                  Navigator.pushNamed(context, ELibScreen.id);
                },
                child: const ListTile(
                  leading: Image(
                      image: AssetImage('images/library2.jpg'),
                      fit: BoxFit.contain),
                  title: Text(
                    'Library',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                splashColor: Colors.blue,
                onTap: () {
                  Navigator.pushNamed(context, PlaylistScreen.id);
                },
                child: const ListTile(
                  leading: Image(
                    image: AssetImage('images/videos.jpg'),
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    'Videos',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                splashColor: Colors.blue,
                onTap: () {
                  if (CourseNavigationScreen.quiz_loc_id == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoScreen('No Quiz'),
                      ),
                    );
                  } else {
                    Navigator.pushNamed(context, QuizScreen.id);
                  }
                },
                child: const ListTile(
                  leading: Image(
                      image: AssetImage('images/test.jpg'), fit: BoxFit.cover),
                  title: Text(
                    'Test',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
