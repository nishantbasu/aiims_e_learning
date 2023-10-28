import 'package:aiims_e_learning/screens/dashbaord_screen.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Score and Certificate will be mailed', //'$resultScore',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            child: Text(
              'Go Back!',
            ),
            textColor: Colors.blue,
            onPressed: () =>
                Navigator.popAndPushNamed(context, DashboardScreen.id),
          ),
        ],
      ),
    );
  }
}
