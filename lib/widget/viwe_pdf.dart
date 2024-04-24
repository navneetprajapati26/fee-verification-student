import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ViewPDF extends StatefulWidget {
  final String url;

  ViewPDF({required this.url});

  @override
  _ViewPDFState createState() => _ViewPDFState();
}

class _ViewPDFState extends State<ViewPDF> {
  String? pathPDF = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFromUrl();
  }

  _loadFromUrl() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var data = await http.get(Uri.parse(widget.url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdf.pdf");

      File urlFile = await file.writeAsBytes(bytes);
      setState(() {
        pathPDF = urlFile.path;
        _isLoading = false;
      });
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return  _isLoading
          ? Center(child: CircularProgressIndicator())
          : PDFView(
        filePath: pathPDF!,
        autoSpacing: true,
        enableSwipe: true,
        pageSnap: true,
        swipeHorizontal: true,
        nightMode: false,
    );
  }
}