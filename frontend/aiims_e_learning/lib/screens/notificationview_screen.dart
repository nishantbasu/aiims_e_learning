import 'app_theme.dart';
import 'package:flutter/material.dart';

class NotificationViewScreen extends StatefulWidget {
  static String id = 'notificationview_screen';
  final String message;

  NotificationViewScreen(this.message);
  @override
  _NotificationViewScreenState createState() =>
      _NotificationViewScreenState(message);
}

class _NotificationViewScreenState extends State<NotificationViewScreen> {
  final String message;
  _NotificationViewScreenState(this.message);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: AppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: AppTheme.nearlyWhite,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            height: height * 0.7,
            width: width * 0.9,
            padding: const EdgeInsets.only(top: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                message,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
