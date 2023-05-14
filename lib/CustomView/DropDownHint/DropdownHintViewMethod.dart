

import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/cupertino.dart';

getDropDownHintViewMethod(String hintText)
{
  return Text(hintText,
    style: TextStyle(
      color: textFieldHintTextColor,
      fontSize: 16.0,
    ),
  );
}