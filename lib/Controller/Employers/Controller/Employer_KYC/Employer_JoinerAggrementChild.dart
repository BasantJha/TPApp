import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/material.dart';



showSnackBar(context, snackmsg, color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      /* action: SnackBarAction(
          label: "OK",
          textColor: Colors.white,
          onPressed: () {},
        ),*/
      content: Text(
        snackmsg,
        style: TextStyle(fontSize: 14),
      )));
}

var dataNotFoundText=Center(child: Text(
  'data not found',textAlign: TextAlign.center,
  style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: robotoFontFamily),
),);
//