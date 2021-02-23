import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdfViewer extends StatelessWidget {
  final String url;

  const pdfViewer({Key key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SfPdfViewer.network(
          url,
          enableDoubleTapZooming: true,
        ),
      ),
    );
  }
}