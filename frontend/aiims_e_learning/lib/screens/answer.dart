import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;
  final Color answercolor;

  Answer(this.selectHandler, this.answerText, this.answercolor);

  bool pressAttention = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Container(
          height: height / 12,
          width: double.infinity,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            padding: EdgeInsets.all(15),
            highlightColor: answercolor,
            color: Colors.blue,
            textColor: Colors.white,
            child: Scrollbar(
                child: SingleChildScrollView(child: Text(answerText))),
            onPressed: () {
              selectHandler();
            },
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
