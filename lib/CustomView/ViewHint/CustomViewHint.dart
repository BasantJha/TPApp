

import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Padding getViewHintTextBlue(String viewHint)
{
 return Padding(padding: EdgeInsets.only(top: 10),child: Text(
    viewHint,
    style: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: viewHeadingFontweight,
      color: darkBlueColor,
      fontFamily: viewHeadingFontfamily,
    ),
  ),);
}
Padding getViewHintTextBlack(String viewHint)
{
  return Padding(padding: EdgeInsets.only(top: 10),
    child: Text(
      viewHint,textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: semiBold_FontWeight,
        fontSize: viewSubHeadingFontweight,
        color: Colors.black,
        fontFamily: viewHeadingFontfamily,
      ),
    ),);
}

Padding getViewHintTextDarkGray(String viewHint)
{
  return Padding(padding: EdgeInsets.only(top: 10),
    child: Text(
      viewHint,textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: semiBold_FontWeight,
        fontSize: viewSubHeadingFontweight,
        color: companyNameTextColor,
        fontFamily: viewHeadingFontfamily,
      ),
    ),);
}