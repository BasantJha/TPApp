
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constant/Constants.dart';
import '../AlertView/Alert.dart';

CJSnackBar(BuildContext context,String msg)
{

  var snackBar = SnackBar(
    content: Text(msg),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);

  //showDialog(context: context, builder: (_)=>successDialogMethodForAllMessages(context,msg));

}