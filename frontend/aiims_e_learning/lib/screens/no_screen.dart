import 'app_theme.dart';
import 'package:flutter/material.dart';

class NoScreen extends StatefulWidget {
  static String id = 'no_screen';
  final String message;

  NoScreen(this.message);
  @override
  _NoScreenState createState() => _NoScreenState(message);
}

class _NoScreenState extends State<NoScreen> {
  final String message;
  _NoScreenState(this.message);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: AppTheme.nearlyWhite,
        body: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          message,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ]),
          ),
        ),
      ),
    );
  }
}
