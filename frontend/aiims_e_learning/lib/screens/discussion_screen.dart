import 'package:aiims_e_learning/screens/forum_screen.dart';
import 'package:aiims_e_learning/screens/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aiims_e_learning/providers/models.dart';
import 'package:aiims_e_learning/providers/requests.dart';
import 'addindiscussion_screen.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DiscussionScreen extends StatelessWidget {
  final String topic;
  final int email;
  final String name;
  final String description;
  final String date_created;

  static String cc;
  static int video_loc_id;
  static String id = 'discussion_screen';

  DiscussionScreen(
      {Key key,
      this.topic,
      this.email,
      this.name,
      this.description,
      this.date_created})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Discussion>>(
        future: fetchDiscussionLists(
            http.Client(), LoginScreen.token, ForumScreen.video_loc_id),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(
                  photos: snapshot.data,
                  topic: topic,
                  email: email,
                  name: name,
                  description: description,
                  date_created: date_created)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final String topic;
  final int email;
  final String name;
  final String description;
  final String date_created;
  final List<Discussion> photos;

  PhotosList(
      {Key key,
      this.photos,
      this.topic,
      this.email,
      this.name,
      this.description,
      this.date_created})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        elevation: 100,
        onPressed: () {
          Navigator.pushNamed(context, AddindiscussionScreen.id);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.amber[50],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.forum),
                    title: Text(
                      topic,
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(description),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: Text(name),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: Text(date_created.substring(0, 10)),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: photos.length,
              itemBuilder: (BuildContext context, int index) {
                return TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.1,
                  endChild: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: 120,
                      ),
                      color: Colors.white,
                      child: Card(
                        color: Colors.blueGrey[50],
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.comment),
                              title: Text(photos[index].discuss),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  startChild: Container(
                    color: Colors.white,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
