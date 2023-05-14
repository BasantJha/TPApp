import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:contractjobs/CustomView/CJHubCustomView/palatte_Textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:contractjobs/Constant/CJHub_ConstantIcon.dart';

import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';

//import 'package:/CustomView/CJHubCustomView/palatte_Textstyle.dart';




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
      home: UploadInvestmentProof_Image_View(title: 'CJ Hub'),
    );
  }
}
class UploadInvestmentProof_Image_View extends StatefulWidget {

  UploadInvestmentProof_Image_View({Key? key, this.title,this.urlStr}) : super(key: key);

  final String? title;
  final String? urlStr;

  @override
  _UploadInvestmentProof_Image_View createState() => _UploadInvestmentProof_Image_View(urlStr!);
}

class _UploadInvestmentProof_Image_View extends State<UploadInvestmentProof_Image_View> {
  // This widget is the root of your application.

  bool _isLoading = true;
  String urlStr="";

  _UploadInvestmentProof_Image_View(String urlStr)
  {
    this.urlStr=urlStr;
  }

  @override
  void initState() {
    super.initState();

  }

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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*1,
              decoration: Style_UploadInvestment_All_Border,
              padding: const EdgeInsets.all(20),
              child:  Image.network(
                urlStr!,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress)
                {
                  if (loadingProgress! == null)
                  {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress!.expectedTotalBytes != null
                          ? loadingProgress!.cumulativeBytesLoaded /
                          loadingProgress!.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),

            ),
            onWillPop: () async => false,
            /*onWillPop: ()
            {
              Message.alert_dialogAppExit(context);

            } ,*/
          )


      );
  }

}