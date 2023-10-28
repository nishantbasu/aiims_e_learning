import 'package:aiims_e_learning/screens/elib_screen.dart';
import 'package:flutter/material.dart';
import 'package:aiims_e_learning/providers/url.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class PdfScreen extends StatefulWidget {
  static String id = 'pdf_screen';
  PdfScreen({Key key}) : super(key: key);

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  String y;
  String url;
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    y = ELibScreen.cc.toString();
    url = 'http://' + finurl + port + '/courses' + y + '/';
    loadDocument();
  }

  loadDocument() async {
    var result = await PDFDocument.fromURL(url);
    if (result != null) {
      document = result;
    } else {
      document = null;
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
                document: document,
                zoomSteps: 1,
              ),
      ),
    );
  }
}
