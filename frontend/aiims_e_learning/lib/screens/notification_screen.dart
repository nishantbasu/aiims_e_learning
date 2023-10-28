import 'package:aiims_e_learning/screens/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aiims_e_learning/providers/models.dart';
import 'package:aiims_e_learning/providers/requests.dart';
import 'notificationview_screen.dart';

class NotificationScreen extends StatelessWidget {
  final String title;
  static String cc;
  static int video_loc_id;
  static String id = 'notification_screen';

  NotificationScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Notifications>>(
        future: fetchNotifications(http.Client(), LoginScreen.token),
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
  final List<Notifications> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          ListView.builder(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NotificationViewScreen(photos[index].details),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.notifications_active,
                        color: Colors.blue,
                        size: 40,
                      ),
                      title: Text(
                        photos[index].title,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
