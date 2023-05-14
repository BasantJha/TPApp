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

import '../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../CustomView/CJHubCustomView/AutoLogout.dart';
import '../../../../CustomView/CJHubCustomView/palatte_Textstyle.dart';


Timer? _rootTimer;

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
      home: Insurance_PDFViewer(title: 'CJ Hub'),
    );
  }
}
class Insurance_PDFViewer extends StatefulWidget {
  Insurance_PDFViewer({Key? key, this.title,this.pdfURL}) : super(key: key);

  final String? title;
  final String? pdfURL;

  @override
  _Insurance_PDFViewer createState() => _Insurance_PDFViewer(this.pdfURL!);

}

class _Insurance_PDFViewer extends State<Insurance_PDFViewer> {


  bool _isLoading = true;
  String remotePDFpath = "";

  String pdfURL="";
  _Insurance_PDFViewer(String pdfURL)
  {
    this.pdfURL=pdfURL;

  }


  @override
  void initState() {
    super.initState();

    // load_PDFFile();

    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    });

    if(kIsWeb){

      // //print("This CJ Hub Web");

      AutoLogout.initializeTimer(context);

    }
    else{

      // //print('this is mobile App');

    }
  }

  void _handleUserInteraction([_]) {
    if (_rootTimer != null && !_rootTimer!.isActive) {
      // This means the user has been logged out
      return;
    }

    _rootTimer?.cancel();

    // //print("Insurance_PDFViewer resetTimer:");

    AutoLogout.initializeTimer(context);
  }

  @override
  Widget build(BuildContext context) {
    return
      Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handleUserInteraction,
        onPointerMove: _handleUserInteraction,
        onPointerUp: _handleUserInteraction,
        child:
      Scaffold(
        appBar: /*AppBar(leading: BackButton(
            color: Colors.black
        ), backgroundColor: Color(0xfff0f0f2),centerTitle: true,
          title: Image.asset(getCJHub_AppLogo,height: 90,width: 90,),
        ),*/ CJAppBar("", appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action 1type");
          Navigator.pop(context);

        })),
        body:
        new Container(
          // height: 200,
          //width: 300,
          decoration: Style_UploadInvestment_All_Border,
          padding: const EdgeInsets.all(20),

          child:Stack(
              children: <Widget>[
                _isLoading ? Center(child: CircularProgressIndicator(),)
                    : PDFView(
                  filePath: remotePDFpath,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: true,
                  pageFling: true,

                ),
              ]),

        ),

      )
      );
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    setState(() {
      _isLoading = true;
    });
    try {
      final url = pdfURL;
      final fileName = url.substring(url.lastIndexOf("/") + 1);
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

