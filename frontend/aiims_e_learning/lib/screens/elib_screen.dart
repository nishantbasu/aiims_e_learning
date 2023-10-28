import 'package:aiims_e_learning/screens/course_screen.dart';
import 'package:aiims_e_learning/screens/login_screen.dart';
import 'package:aiims_e_learning/screens/pdf_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aiims_e_learning/providers/models.dart';
import 'package:aiims_e_learning/providers/requests.dart';

class ELibScreen extends StatelessWidget {
  final String title;
  static String cc;
  static String id = 'elib_screen';

  ELibScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Pdflists>>(
        future: fetchPdfLists(
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
  final List<Pdflists> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                        ELibScreen.cc = photos[index].pdf;
                        Navigator.pushNamed(context, PdfScreen.id);
                      },
                      child: ListTile(
                        leading: Image(
                          image: AssetImage('images/libbook.jpg'),
                          fit: BoxFit.cover,
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
            ),
          )
        ],
      ),
    );
  }
}
