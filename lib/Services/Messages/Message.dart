
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Message
{
  static  const  get_LoaderMessage = "Please wait...";
  static  const  get_NetworkConnectionMessage = "Network connection issue...";
  static  const  get_Document_name = "Select Document Mode";


  static  const  get_UploadDocumentTypeHint = "Note: Document size must be less than 1 mb and\nuse the pdf, png, jpg or jpeg.";



  static alert_dialogAppExit(BuildContext context)
  {
    /*var alertDialog = AlertDialog(
      content: Text("Are you sure, you want to exit ?",
        textAlign: TextAlign.center,),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [

        TextButton(onPressed: (){
          Navigator.of(context).pop();
        },
          child: Text("NO",
            textAlign: TextAlign.center,style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),

        SizedBox(width: 20.0),

        TextButton(onPressed: (){

          //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          exit(0);

        },
          child: Text("YES",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
      ],

    );
    showDialog(
        barrierDismissible:false ,
        context: context,
        builder: (BuildContext context) => alertDialog

    );*/

  }


}