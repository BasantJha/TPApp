import 'package:flutter/cupertino.dart';

import '../../../Constant/Constants.dart';

richText(String number)
{
   const stormGreyColor = Color(0xff838282);

  String lastDigit = " ";
  /*for (var i = 6; i < number.length; i++)
  {
    lastDigit += number[i];
  }*/
  return RichText(
      text: TextSpan(
          text: 'OTP Was Sent on Registered Mobile Number',
          style: TextStyle(
              color: stormGreyColor,
              fontFamily: robotoFontFamily,
              fontWeight: normal_FontWeight,
              fontSize: medium_FontSize,
              letterSpacing: 0,
              height: 1),
          children: <InlineSpan>[
            TextSpan(
              text: lastDigit,
              style: TextStyle(
                  color: stormGreyColor,
                  fontFamily: robotoFontFamily,
                  fontWeight: normal_FontWeight,
                  fontSize: medium_FontSize,
                  letterSpacing: 0,
                  height: 1),
            )
          ]));
}