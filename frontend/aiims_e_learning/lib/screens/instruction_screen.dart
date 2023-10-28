import 'package:aiims_e_learning/screens/dashbaord_screen.dart';
import 'package:aiims_e_learning/screens/evaluation_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';
import 'package:flutter/material.dart';

class InstructionScreen extends StatefulWidget {
  static String id = 'instruction_screen';
  static String instuctions;

  @override
  _InstructionScreenState createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
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
          body: Column(
            children: <Widget>[
              SizedBox(
                height: height / 7,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
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
                        DashboardScreen.instructions,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              MaterialButton(
                  child: Text(
                    'Start the test',
                    style: GoogleFonts.portLligatSans(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pushNamed(context, EvaluationScreen.id);
                  })
            ],
          )),
    );
  }
}
