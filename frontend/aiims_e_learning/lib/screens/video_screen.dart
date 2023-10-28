import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:aiims_e_learning/screens/playlist_screen.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:aiims_e_learning/providers/url.dart';

class VideoScreen extends StatelessWidget {
  static String id = 'video_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new VideoScreenStatefulWidget(),
    );
  }
}

class VideoScreenStatefulWidget extends StatefulWidget {
  VideoScreenStatefulWidget({Key key}) : super(key: key);

  @override
  _VideoScreenStatefulWidgetState createState() =>
      _VideoScreenStatefulWidgetState();
}

class _VideoScreenStatefulWidgetState extends State<VideoScreenStatefulWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FlickManager flickManager;
  @override
  void initState() {
    String y = PlaylistScreen.cc.toString();
    String url = 'http://' + finurl + port + '/courses' + y + '/';
    super.initState();
    flickManager = new FlickManager(
      videoPlayerController: new VideoPlayerController.network(url),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  // Future<List<Questions>> _calculation = fetchQuestions(
  //     http.Client(),
  //     LoginScreen.token,
  //     CourseScreen.course_loc_id,
  //     PlaylistScreen.video_loc_id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(),
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: FlickVideoPlayer(flickManager: flickManager),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset('images/logo_1.png')
            ],
          ),
        )

        // Container(
        //   child: FutureBuilder<List<Questions>>(
        //     future: _calculation, // a previously-obtained Future<String> or null
        //     builder:
        //         (BuildContext context, AsyncSnapshot<List<Questions>> snapshot) {
        //       //print(snapshot.data[0].question);
        //       List<Widget> children;

        //       if (snapshot.hasData) {
        //         if (snapshot.data.isNotEmpty) {
        //           children = <Widget>[
        //             Padding(
        //               padding: const EdgeInsets.all(20.0),
        //               child: FlickVideoPlayer(flickManager: flickManager),
        //             ),
        //             SizedBox(
        //               height: 20,
        //             ),
        //             Image.asset('images/logo_1.png')

        //             //Positioned(top: 0.0, child: _children[_currentIndex])

        //             // Icon(
        //             //   Icons.check_circle_outline,
        //             //   color: Colors.green,
        //             //   size: 60,
        //             // ),
        //             // Padding(
        //             //     padding: const EdgeInsets.only(top: 16),
        //             //     child: Text('Hye! ${snapshot.data}',
        //             //         style: TextStyle(
        //             //             backgroundColor: Colors.white,
        //             //             color: Colors.brown)))
        //           ];
        //         } else {
        //           children = <Widget>[
        //             Padding(
        //               padding: const EdgeInsets.all(20.0),
        //               child: new FlickVideoPlayer(flickManager: flickManager),
        //             ),
        //             SizedBox(
        //               height: 20,
        //             ),
        //             Image.asset('images/logo_1.png')

        //             //Positioned(top: 0.0, child: _children[_currentIndex])

        //             // Icon(
        //             //   Icons.check_circle_outline,
        //             //   color: Colors.green,
        //             //   size: 60,
        //             // ),
        //             // Padding(
        //             //     padding: const EdgeInsets.only(top: 16),
        //             //     child: Text('Hye! ${snapshot.data}',
        //             //         style: TextStyle(
        //             //             backgroundColor: Colors.white,
        //             //             color: Colors.brown)))
        //           ];
        //         }
        //       } else if (snapshot.hasError) {
        //         children = <Widget>[
        //           Icon(
        //             Icons.error_outline,
        //             color: Colors.red,
        //             size: 60,
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.only(top: 16),
        //             child: Text('Error: ${snapshot.error}'),
        //           )
        //         ];
        //       } else {
        //         children = <Widget>[
        //           SizedBox(
        //             child: CircularProgressIndicator(),
        //             width: 60,
        //             height: 60,
        //           ),
        //           const Padding(
        //             padding: EdgeInsets.only(top: 16),
        //             child: Text('Awaiting result...'),
        //           )
        //         ];
        //       }
        //       return Column(
        //         children: children,
        //       );
        //     },
        //   ),
        // ),
        );
  }
}
