import 'package:aiims_e_learning/providers/auth.dart';
import 'package:aiims_e_learning/screens/activationsent_screen.dart';
import 'package:aiims_e_learning/screens/discussion_screen.dart';
import 'package:aiims_e_learning/screens/elib_screen.dart';
import 'package:aiims_e_learning/screens/evaluation_screen.dart';
import 'package:aiims_e_learning/screens/forgotpassword_screen.dart';
import 'package:aiims_e_learning/screens/course_screen.dart';
import 'package:aiims_e_learning/screens/game_screen.dart';
import 'package:aiims_e_learning/screens/instruction_screen.dart';
import 'package:aiims_e_learning/screens/notificationview_screen.dart';
import 'package:aiims_e_learning/screens/portfolio_screen.dart';
import 'package:aiims_e_learning/screens/resetsent_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:aiims_e_learning/screens/video_screen.dart';
import 'package:aiims_e_learning/screens/registration_screen.dart';
import 'package:aiims_e_learning/screens/playlist_screen.dart';
import 'screens/login_screen.dart';
import 'screens/video_screen.dart';
import 'screens/registration_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'screens/dashbaord_screen.dart';
import 'screens/coursenavigation_screen.dart';
import 'screens/pdf_screen.dart';
import 'screens/forum_screen.dart';
import 'screens/addinforum_screen.dart';
import 'screens/addindiscussion_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/no_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Auth(),
      child: MaterialApp(
        title: 'Splash Screen',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Splash(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      backgroundColor: Colors.lightBlue[200],
      navigateAfterSeconds: new MainScreen(),
      image: Image.asset('images/logo_1.png'),
      title: Text(
        "E-Learning App,\nBio-Medical-Waste\nManagement\nAIIMS Bhubaneswar",
        style: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      loadingText: Text(
        "Welcome",
        style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ),
      photoSize: 100.0,
      loaderColor: Colors.white,
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: AppTheme.textTheme,
        ),
        initialRoute: LoginScreen.id,
        routes: {
          VideoScreen.id: (context) => VideoScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          DashboardScreen.id: (context) => DashboardScreen(),
          PlaylistScreen.id: (context) => PlaylistScreen(),
          ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
          PortfolioScreen.id: (context) => PortfolioScreen(),
          ELibScreen.id: (context) => ELibScreen(),
          ActivationsentScreen.id: (context) => ActivationsentScreen(),
          ResetsentScreen.id: (context) => ResetsentScreen(),
          DashboardScreen.id: (context) => DashboardScreen(),
          CourseScreen.id: (context) => CourseScreen(),
          DiscussionScreen.id: (context) => DiscussionScreen(),
          CourseNavigationScreen.id: (context) => CourseNavigationScreen(),
          PdfScreen.id: (context) => PdfScreen(),
          VideoScreen.id: (context) => VideoScreen(),
          ForumScreen.id: (context) => ForumScreen(),
          AddinforumScreen.id: (context) => AddinforumScreen(),
          AddindiscussionScreen.id: (context) => AddindiscussionScreen(),
          QuizScreen.id: (context) => QuizScreen(),
          NoScreen.id: (context) => NoScreen('null'),
          NotificationScreen.id: (context) => NotificationScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          NotificationViewScreen.id: (context) => NotificationViewScreen(null),
          ColorGame.id: (context) => ColorGame(),
          EvaluationScreen.id: (context) => EvaluationScreen(),
          InstructionScreen.id: (context) => InstructionScreen(),
        },
      ),
    );
  }
}
