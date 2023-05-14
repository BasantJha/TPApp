import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:universal_html/html.dart' as html;

import '../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CJ Hub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Insurance_WEB_PDFViewer(),
    );
  }
}

/// Represents Homepage for Navigation
class Insurance_WEB_PDFViewer extends StatefulWidget {
  Insurance_WEB_PDFViewer({Key? key, this.title,this.pdfURL}) : super(key: key);

  final String? title;
  final String? pdfURL;

  @override
  _Insurance_WEB_PDFViewer createState() => _Insurance_WEB_PDFViewer(this.pdfURL!);
}

class _Insurance_WEB_PDFViewer extends State<Insurance_WEB_PDFViewer> {

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  PdfViewerController? _pdfViewerController;

  final String _url = 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf';
  Uint8List? _pdfBytes;

   String pdfURL="";
  _Insurance_WEB_PDFViewer(String pdfURL)
  {
    this.pdfURL=pdfURL;
    // //print('This is PDF URL: $pdfURL');

  }


  @override
  void initState() {
    ///Get the PDF document as bytes
    // downloadFile(pdfURL);
    super.initState();
  }

  // Downloads the PDF from the URL
  /*void downloadFile(String url) {
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = "myDocument.pdf"; //in my case is .pdf
    anchorElement.click();
  }*/



  @override
  Widget build(BuildContext context) {
    /*Widget child = const Center(child: CircularProgressIndicator());
    if (_documentBytes != null) {
      child = SfPdfViewer.memory(
        ,
      );
    }*/
    return Scaffold(
      appBar: /*AppBar(leading: BackButton(
          color: Colors.black
      ), backgroundColor: Color(0xfff0f0f2),centerTitle: true,
        title: Image.asset(getCJHub_AppLogo,height: 90,width: 90,),
      ),*/ CJAppBar("", appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action 1type");
        Navigator.pop(context);

      })),
      body:  _pdfBytes == null ? Center(child: CircularProgressIndicator()) : SfPdfViewer.memory(
          _pdfBytes!),
    );
  }
}