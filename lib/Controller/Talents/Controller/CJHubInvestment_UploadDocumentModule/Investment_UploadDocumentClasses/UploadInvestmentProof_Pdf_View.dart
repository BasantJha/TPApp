import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJHubCustomView/palatte_Textstyle.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff00BFFF)
  ));
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
      home: UploadInvestmentProof_Pdf_View(title: 'CJ Hub'),
    );
  }
}
class UploadInvestmentProof_Pdf_View extends StatefulWidget {

  UploadInvestmentProof_Pdf_View({Key? key, this.title,this.urlStr}) : super(key: key);

  final String? title;
  final String? urlStr;

  @override
  _UploadInvestmentProof_Pdf_View createState() => _UploadInvestmentProof_Pdf_View(urlStr!);
}

class _UploadInvestmentProof_Pdf_View extends State<UploadInvestmentProof_Pdf_View> {
  // This widget is the root of your application.

  PDFDocument? _pdf;
  bool? _isLoading = true;
  String? urlStr;

  // PDFDocument _pdf;
  Uint8List? _documentBytes;
  String remotePDFpath = "";


  _UploadInvestmentProof_Pdf_View(String urlStr)
  {

    this.urlStr=urlStr;
  }
  ///Get the PDF document as bytes.


  @override
  void initState() {
    super.initState();

    // load_PDFFile();

    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    });
  }

  /* void load_PDFFile() async
  {
    setState(() {
      _isLoading = true;
    });
    // Load the pdf file from the internet
    //print('show pdf url $urlStr');
    _pdf = await PDFDocument.fromURL(urlStr);

    setState(() {
      _isLoading = false;
    });
  }
*/

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: /*AppBar(leading: BackButton(

              onPressed: () => Navigator.of(context).pop(),
              color: Colors.black
          ), backgroundColor: Color(0xfff0f0f2),centerTitle: true,
            title: Image.asset(getCJHub_AppLogo,height: 90,width: 90,),
          ),*/
          CJAppBar("", appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show the action 1type");
            Navigator.pop(context);

          })),

          body: WillPopScope(
            child: new Container(
              // height: 200,
              //width: 300,
              decoration: Style_UploadInvestment_All_Border,
              padding: const EdgeInsets.all(20),

              child:Stack(
                  children: <Widget>[
                    _isLoading! ? Center(child: CircularProgressIndicator(),)
                        : PDFView(
                      filePath: remotePDFpath,
                      enableSwipe: true,
                      swipeHorizontal: false,
                      autoSpacing: true,
                      pageFling: true,

                    ),
                  ]),

            ),

            onWillPop: () async => false,
            /*onWillPop: ()
            {
              Message.alert_dialogAppExit(context);

            } ,*/

          )

      );
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    setState(() {
      _isLoading = true;
    });
    try {
      final url = urlStr;
      final fileName = url!.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error downloading pdf file!');
    }
    setState(() {
      _isLoading = false;
    });
    return completer.future;
  }

}