import 'app_theme.dart';
import 'package:flutter/material.dart';

class ResetsentScreen extends StatefulWidget {
  static String id = 'resetsent_screen';
  @override
  _ResetsentScreenState createState() => _ResetsentScreenState();
}

class _ResetsentScreenState extends State<ResetsentScreen> {
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
                          'Reset Mail Sent!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.check_circle_outline)
                      ]),
                  Text(
                    'Please Check Your Mail!',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
