import 'package:aiims_e_learning/providers/models.dart';
import 'package:aiims_e_learning/screens/coursenavigation_screen.dart';
import 'package:aiims_e_learning/screens/resultquiz.dart';
import 'package:http/http.dart' as http;
import 'package:aiims_e_learning/providers/requests.dart';
import 'package:aiims_e_learning/screens/login_screen.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter/material.dart';
import 'course_screen.dart';
import 'quiz.dart';
import 'result.dart';

class QuizScreen extends StatelessWidget {
  static String id = 'quiz_screen';
  static int number_of_questions;
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
  int y;
  int l = 0;
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List cardtextList = [];
  List cardidList = [];
  List cardList = [];
  List descriptionList = [];

  Future<List<QuizQuestionList>> _calculation = fetchQuizQuestions(
      http.Client(),
      LoginScreen.token,
      CourseScreen.course_loc_id,
      CourseNavigationScreen.quiz_loc_id);

  var _questionIndex = 0;
  var _totalScore = 0;
  var _answercolor = Colors.blue;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    print(score);
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
      if (score == 0) {
        _answercolor = Colors.red;
      } else {
        _answercolor = Colors.green;
      }
    });
    if (_questionIndex < QuizScreen.number_of_questions) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
        child: FutureBuilder<List<QuizQuestionList>>(
          future: _calculation,
          builder: (BuildContext context,
              AsyncSnapshot<List<QuizQuestionList>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              if (CourseNavigationScreen.retrieved_courseid ==
                  CourseScreen.course_loc_id) {
                int a_length = snapshot.data.length;
                QuizScreen.number_of_questions = a_length;
                List<Map<String, Object>> a = List<Map<String, Object>>();

                for (int i = 0; i < snapshot.data.length; i++) {
                  Map<String, Object> map1 = {
                    'questionText': snapshot.data[i].question,
                    'answers': [
                      {
                        'text': snapshot.data[i].option1,
                        'score': snapshot.data[i].answer == 1 ? 5 : 0,
                        'answercolor': snapshot.data[i].answer == 1
                            ? Colors.green
                            : Colors.red
                      },
                      {
                        'text': snapshot.data[i].option2,
                        'score': snapshot.data[i].answer == 2 ? 5 : 0,
                        'answercolor': snapshot.data[i].answer == 2
                            ? Colors.green
                            : Colors.red
                      },
                      {
                        'text': snapshot.data[i].option3,
                        'score': snapshot.data[i].answer == 3 ? 5 : 0,
                        'answercolor': snapshot.data[i].answer == 3
                            ? Colors.green
                            : Colors.red
                      },
                      {
                        'text': snapshot.data[i].option4,
                        'score': snapshot.data[i].answer == 4 ? 5 : 0,
                        'answercolor': snapshot.data[i].answer == 4
                            ? Colors.green
                            : Colors.red
                      },
                    ],
                  };
                  a.add(map1);
                }
                children = <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: _questionIndex < a_length
                        ? Quiz(
                            answerQuestion: _answerQuestion,
                            questionIndex: _questionIndex,
                            questions: a,
                            answercolor: _answercolor,
                          )
                        : ResultQuiz(_totalScore, _resetQuiz),
                  ),
                ];
              } else {
                children = <Widget>[Center(child: Text('No Questions'))];
              }
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
