import 'package:aiims_e_learning/screens/course_screen.dart';
import 'package:aiims_e_learning/screens/video_screen.dart';
import 'package:aiims_e_learning/screens/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aiims_e_learning/providers/models.dart';
import 'package:aiims_e_learning/providers/requests.dart';

class PlaylistScreen extends StatelessWidget {
  final String title;
  static String cc;
  static int video_loc_id;
  static String id = 'playlist_screen';

  PlaylistScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Videolists>>(
        future: fetchVideoLists(
            http.Client(), LoginScreen.token, CourseScreen.course_loc_id),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Videolists> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: photos.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      InkWell(
                        splashColor: Colors.blue,
                        onTap: () {
                          PlaylistScreen.cc = photos[index].video;
                          PlaylistScreen.video_loc_id = photos[index].id;

                          Navigator.pushNamed(context, VideoScreen.id);
                        },
                        child: ListTile(
                          leading: Image(
                            image: AssetImage('images/play.png'),
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            photos[index].title,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
