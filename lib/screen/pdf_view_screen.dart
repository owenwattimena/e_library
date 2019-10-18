import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
// import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

// import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewScreen extends StatefulWidget {
  final String pdfUrl;

  const PdfViewScreen({Key key, this.pdfUrl}) : super(key: key);
  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  PDFDocument _document;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    showEbook();
  }

  showEbook() async {
    _document = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {
      this._isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF View'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PDFViewer(
              document: _document,
            ),
    );
  }
}
