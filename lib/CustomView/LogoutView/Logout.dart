import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Controller/LoginView/Controller/LoginOptionController.dart';
import '../../Controller/Talents/TalentNavigation/TalentNavigation.dart';
import '../CJHubCustomView/SharedPreference.dart';

logout(BuildContext context)
{
  var alertDialog = AlertDialog(
    content: Text('Do you want to logout?',
      textAlign: TextAlign.left,),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0.0))
    ),
//
    actions: [

      TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("CANCEL",
        textAlign: TextAlign.center,style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
      SizedBox(width: 20.0),

      TextButton(onPressed: ()
      {
        /* setState(()
      {
        TalentNavigation().pushTo(context, LoginOptionController());

      });*/

        SharedPreference.setTankhaPay_PinNumber("");
        TalentNavigation().pushTo(context, LoginOptionController());

      },
        child: Text("OK",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
    ],

  );
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => alertDialog

  );
}