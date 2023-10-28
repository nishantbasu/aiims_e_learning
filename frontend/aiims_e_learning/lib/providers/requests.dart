import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:aiims_e_learning/providers/models.dart';
import 'url.dart';

Future<List<Courses>> fetchCourses(http.Client client, String authtoken) async {
  final url = 'http://' + finurl + port + '/courses/';
  ////////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    return compute(parseCourse, response.body);
  } catch (e) {
    print(e);
    return null;
  }
}

List<Courses> parseCourse(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Courses>((json) => Courses.fromJson(json)).toList();
}

Future<List<Faculties>> fetchFaculties(
    http.Client client, String authtoken) async {
  final url = 'http://' + finurl + port + '/faculty/';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    return compute(parseFaculty, response.body);
  } catch (e) {
    print(e);
    return null;
  }
}

List<Faculties> parseFaculty(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Faculties>((json) => Faculties.fromJson(json)).toList();
}

Future<List<Notifications>> fetchNotifications(
    http.Client client, String authtoken) async {
  final url = 'http://' + finurl + port + '/notification/';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    return compute(parseNotification, response.body);
  } catch (e) {
    print(e);
    return null;
  }
}

List<Notifications> parseNotification(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<Notifications>((json) => Notifications.fromJson(json))
      .toList();
}

Future<List<Videolists>> fetchVideoLists(
    http.Client client, String authtoken, int course_loc_id) async {
  String x = course_loc_id.toString();
  final url = 'http://' + finurl + port + '/courses/' + x + '/videos/';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    return compute(parseVideoLists, response.body);
  } catch (e) {
    print(e);
    return null;
  }
}

List<Videolists> parseVideoLists(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Videolists>((json) => Videolists.fromJson(json)).toList();
}

Future<List<QuizList>> fetchQuizLists(
    http.Client client, String authtoken, int course_loc_id) async {
  String x = course_loc_id.toString();
  final url = 'http://' + finurl + port + '/courses/' + x + '/quiz/';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    return compute(parseQuizLists, response.body);
  } catch (e) {
    print(e);
    return null;
  }
}

List<QuizList> parseQuizLists(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<QuizList>((json) => QuizList.fromJson(json)).toList();
}

Future<List<EvaluationList>> fetchEvaluationLists(
    http.Client client, String authtoken) async {
  final url = 'http://' + finurl + port + '/evaluation/';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    return compute(parseEvaluationLists, response.body);
  } catch (e) {
    print(e);
    return null;
  }
}

List<EvaluationList> parseEvaluationLists(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<EvaluationList>((json) => EvaluationList.fromJson(json))
      .toList();
}

Future<List<Pdflists>> fetchPdfLists(
    http.Client client, String authtoken, int course_loc_id) async {
  String x = course_loc_id.toString();
  final url = 'http://' + finurl + port + '/courses/' + x + '/e_library/';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    return compute(parsePdfLists, response.body);
  } catch (e) {
    print(e);
    return null;
  }
}

List<Pdflists> parsePdfLists(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Pdflists>((json) => Pdflists.fromJson(json)).toList();
}

// Future<List<Questions>> fetchQuestions(http.Client client, String authtoken,
//     int course_loc_id, int video_loc_id) async {
//   String x = course_loc_id.toString();
//   String y = video_loc_id.toString();
//   final url = 'http://' +
//       finurl +
//       port +
//       '/courses/' +
//       x +
//       '/videos/' +
//       y +
//       '/questions';
//   //////print(url);
//   final response = await http.get(
//     url,
//     headers: {
//       'Content-type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Token ' + authtoken
//     },
//   );

//   // Use the compute function to run parsePhotos in a separate isolate.
//   return compute(parseQuestions, response.body);
// }

// // A function that converts a response body into a List<Photo>.
// List<Questions> parseQuestions(String responseBody) {
//   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

//   return parsed.map<Questions>((json) => Questions.fromJson(json)).toList();
// }

Future<List<QuizQuestionList>> fetchQuizQuestions(http.Client client,
    String authtoken, int course_loc_id, int quiz_loc_id) async {
  String x = course_loc_id.toString();
  String y = quiz_loc_id.toString();
  final url =
      'http://' + finurl + port + '/courses/' + x + '/quiz/' + y + '/questions';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );

    return compute(parseQuizQuestions, response.body);
  } catch (e) {
    print(e);
    return null;
  }
}

List<QuizQuestionList> parseQuizQuestions(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<QuizQuestionList>((json) => QuizQuestionList.fromJson(json))
      .toList();
}

Future<List<EvaluationQuestionList>> fetchEvaluationQuestions(
    http.Client client, String authtoken, int quiz_loc_id) async {
  String y = quiz_loc_id.toString();
  final url = 'http://' + finurl + port + '/evaluation/' + y + '/questions/';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );

    return compute(parseEvaluationQuestions, response.body);
  } catch (e) {
    print(e);
    return null;
  }
}

List<EvaluationQuestionList> parseEvaluationQuestions(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<EvaluationQuestionList>(
          (json) => EvaluationQuestionList.fromJson(json))
      .toList();
}

Future<List<ForumList>> fetchForumLists(
    http.Client client, String authtoken) async {
  final url = 'http://' + finurl + port + '/forum/';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    return compute(parseForumLists, response.body);
  } catch (e) {
    print(e);
    return null;
  }
}

List<ForumList> parseForumLists(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ForumList>((json) => ForumList.fromJson(json)).toList();
}

Future<List<Discussion>> fetchDiscussionLists(
    http.Client client, String authtoken, int forum_loc_id) async {
  String x = forum_loc_id.toString();
  final url = 'http://' + finurl + port + '/forum/' + x + '/getDiscussion/';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    return compute(parseDiscussionLists, response.body);
  } catch (e) {
    print(e);
    return null;
  }
}

List<Discussion> parseDiscussionLists(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Discussion>((json) => Discussion.fromJson(json)).toList();
}

Future<String> fetchUser_Name(http.Client client, String authtoken) async {
  final url = 'http://' + finurl + port + '/auth/users/me/';
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    var m = jsonDecode(response.body);
    var k = m['username'];
    return k;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<int> fetchQuiz_id(
    http.Client client, String authtoken, int course_loc_id) async {
  String x = course_loc_id.toString();

  final url = 'http://' + finurl + port + '/courses/' + x + '/quiz/';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    var m = jsonDecode(response.body);
    var k = m[0]['id'];
    return k;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<int> fetchQuiz_courseid(
    http.Client client, String authtoken, int course_loc_id) async {
  String x = course_loc_id.toString();

  final url = 'http://' + finurl + port + '/courses/' + x + '/quiz/';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    var m = jsonDecode(response.body);
    var k = m[0]['course_name'];
    return k;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<int> fetchNumberofQuestions(
    http.Client client, String authtoken, int course_loc_id) async {
  String x = course_loc_id.toString();

  final url = 'http://' + finurl + port + '/courses/' + x + '/quiz/';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    var m = jsonDecode(response.body);
    var k = m[0]['number_of_questions'];
    return k;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<int> fetchUser_id(http.Client client, String authtoken) async {
  final url = 'http://' + finurl + port + '/auth/users/me/';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    var m = jsonDecode(response.body);
    int j = m['id'];

    return j;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<Map<String, dynamic>> fetchUser(
    http.Client client, String authtoken) async {
  final url = 'http://' + finurl + port + '/auth/users/me/';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    var m = jsonDecode(response.body);
    return m;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<List<UserList>> fetchUserLists(
    http.Client client, String authtoken) async {
  final url = 'http://' + finurl + port + '/auth/users/';
  //////print(url);
  try {
    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token ' + authtoken
      },
    );
    return compute(parseUserLists, response.body);
  } catch (e) {
    print(e);
    return null;
  }
}

List<UserList> parseUserLists(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<UserList>((json) => UserList.fromJson(json)).toList();
}

Future<bool> AddInForum(String name, int email, String topic,
    String description, String authtoken) async {
  try {
    var dio = Dio();
    dio.options.headers['Authorization'] = 'Token ' + authtoken;
    final url = 'http://' + finurl + port + '/forum/addInForum/';
    //////print(url);
    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['email'] = email;
    map['topic'] = topic;
    map['description'] = description;
    FormData formData = new FormData.fromMap(map);
    final response = await dio.post(
      url,
      data: formData,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Cant add in Forum!");
      return false;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<bool> AddInDiscussion(
    int forum_id, String discuss, String authtoken) async {
  try {
    var dio = Dio();
    dio.options.headers['Authorization'] = 'Token ' + authtoken;
    final url = 'http://' + finurl + port + '/forum/addInDiscussion/';
    //////print(url);
    var map = new Map<String, dynamic>();
    map['forum'] = forum_id;
    map['discuss'] = discuss;
    FormData formData = new FormData.fromMap(map);
    final response = await dio.post(
      url,
      data: formData,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Cant add in Discussion!");
      return false;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<bool> Logout(String authtoken) async {
  try {
    var dio = Dio();
    dio.options.headers['Authorization'] = 'Token ' + authtoken;
    final url = 'http://' + finurl + port + '/auth/token/logout/';
    //////print(url);
    final response = await dio.post(
      url,
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      print("Server error");
      return false;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<bool> PatchAttempt(int user_id, bool attempted, String authtoken) async {
  try {
    var dio = Dio();
    var user_id1 = user_id.toString();
    dio.options.headers['Authorization'] = 'Token ' + authtoken;
    final url =
        'http://' + finurl + port + '/auth/patchattempted/' + user_id1 + '/';
    //////print(url);
    final response = await dio.patch(
      url,
      data: {"evaluation_attempted": attempted},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Cant Update Attempts!");
      return false;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<bool> PatchMarks(int user_id, int marks, String authtoken) async {
  try {
    var dio = Dio();
    var user_id1 = user_id.toString();
    dio.options.headers['Authorization'] = 'Token ' + authtoken;
    final url =
        'http://' + finurl + port + '/auth/patchmarks/' + user_id1 + '/';
    //////print(url);
    final response = await dio.patch(
      url,
      data: {"evaluation_marks": marks},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print("Cant Update Marks");
      return false;
    }
  } catch (e) {
    print(e);
    return null;
  }
}
