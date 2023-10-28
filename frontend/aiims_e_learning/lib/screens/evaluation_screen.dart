import 'package:aiims_e_learning/screens/dashbaord_screen.dart';
import 'package:aiims_e_learning/screens/login_screen.dart';
import 'package:aiims_e_learning/screens/no_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aiims_e_learning/providers/models.dart';
import 'package:aiims_e_learning/providers/requests.dart';
import 'quiz.dart';
import 'result.dart';
import 'dart:async';

class EvaluationScreen extends StatelessWidget {
  static String id = 'evaluation_screen';
  static int evaluation;
  static int number_of_questions;
  static int time_in_seconds;

  EvaluationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchUser(http.Client(), LoginScreen.token),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? snapshot.data['evaluation_attempted']
                  ? NoScreen('No quiz for you')
                  : PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final Map<String, dynamic> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new EvaluationScreenStatefulWidget(
        photos: photos,
      ),
    );
  }
}

class EvaluationScreenStatefulWidget extends StatefulWidget {
  final Map<String, dynamic> photos;

  EvaluationScreenStatefulWidget({Key key, this.photos}) : super(key: key);

  @override
  _EvaluationScreenStatefulWidgetState createState() =>
      _EvaluationScreenStatefulWidgetState(photos: photos);
}

class _EvaluationScreenStatefulWidgetState
    extends State<EvaluationScreenStatefulWidget> {
  int _counter = 0;
  StreamController<int> _events;

  final Map<String, dynamic> photos;
  _EvaluationScreenStatefulWidgetState({this.photos});
  @override
  void initState() {
    super.initState();
    _events = new StreamController<int>();
    _events.add(EvaluationScreen.time_in_seconds);
    _startTimer(EvaluationScreen.time_in_seconds);
  }

  Timer _timer;
  void _startTimer(int y) {
    _counter = y;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //setState(() {
      (_counter > 0) ? _counter-- : _timer.cancel();
      //});
      _events.add(_counter);
    });
  }

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void updateattempt(int i) async {
    if (i == 1) {
      var result =
          await PatchAttempt(DashboardScreen.email, true, LoginScreen.token);
    }
  }

  void updatemarks(int y) async {
    var result = await PatchMarks(DashboardScreen.email, y, LoginScreen.token);
  }

  void _answerQuestion(int score) async {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
      updateattempt(_questionIndex);
    });

    if (_questionIndex < EvaluationScreen.number_of_questions) {
      print('We have more questions!');
    } else {
      _startTimer(0);
      updatemarks(_totalScore);
      print('No more questions!');
    }
  }

  Future<List<EvaluationQuestionList>> _calculation = fetchEvaluationQuestions(
      http.Client(), LoginScreen.token, EvaluationScreen.evaluation);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: FutureBuilder<List<EvaluationQuestionList>>(
            future: _calculation,
            builder: (BuildContext context,
                AsyncSnapshot<List<EvaluationQuestionList>> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                if (snapshot.data.isNotEmpty) {
                  int a_length = snapshot.data.length;
                  EvaluationScreen.number_of_questions = a_length;
                  List<Map<String, Object>> a = List<Map<String, Object>>();

                  for (int i = 0; i < snapshot.data.length; i++) {
                    Map<String, Object> map1 = {
                      'questionText': snapshot.data[i].question,
                      'answers': [
                        {
                          'text': snapshot.data[i].option1,
                          'score': snapshot.data[i].answer == 1 ? 5 : 0
                        },
                        {
                          'text': snapshot.data[i].option2,
                          'score': snapshot.data[i].answer == 2 ? 5 : 0
                        },
                        {
                          'text': snapshot.data[i].option3,
                          'score': snapshot.data[i].answer == 3 ? 5 : 0
                        },
                        {
                          'text': snapshot.data[i].option4,
                          'score': snapshot.data[i].answer == 4 ? 5 : 0
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
                            ) //Quiz
                          : Result(_totalScore, _resetQuiz),
                    ),
                    StreamBuilder<int>(
                        stream: _events.stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<int> snapshot) {
                          return Text('00:${snapshot.data.toString()}');
                        })
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
      ),
    );
  }
}
