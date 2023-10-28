import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'url.dart';
import 'package:uuid/uuid.dart';

class Auth with ChangeNotifier {
  String auth_token;
  Future<String> Authentication(String email, String password) async {
    try {
      final url = 'http://' + finurl + port + '/auth/token/login/';
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        auth_token = responseData['auth_token'];
        notifyListeners();
        return auth_token;
      } else {
        print("Not authenticated");

        return "Not authenticated";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> Authentication1(String email, String password, String name,
      String re_password, String phone) async {
    try {
      var uuid = Uuid();
      String username = uuid.v1();
      final url = 'http://' + finurl + port + '/auth/users/';
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'username': username,
          'first_name': name,
          're_password': re_password,
          'phone': phone,
          'is_active': true,
          'evaluation_attempted': false,
          'evaluation_marks': 0,
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
      );
      if (response.statusCode == 201) {
        notifyListeners();
        return 'Good';
      } else {
        return 'Bad';
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> Authentication2(String email) async {
    try {
      final url = 'http://' + finurl + port + '/auth/users/reset_password/';
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
      );
      if (response.statusCode == 204) {
        notifyListeners();
        return 'done';
      } else if (response.statusCode == 400) {
        return 'email not found';
      } else {
        return 'server error';
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
