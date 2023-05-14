import 'package:flutter/cupertino.dart';

import '../Constant/Constants.dart';

Container companyNameContainerBottomSheet()
{
  return Container(
      padding: EdgeInsets.only(bottom: 10,top: 5),
      height: 50,
      color: whiteColor,
      alignment: Alignment.center,
      child: Column(
        children: [
          Text("from",
            style: TextStyle(
                fontFamily: robotoFontFamily,
                letterSpacing: 2,
                fontStyle: FontStyle.italic,
                fontSize: medium_FontSize,
                color: companyNameTextColor
            ),
          ),
          Text("AKAL INFORMATION SYSTEMS LTD.",
            style: TextStyle(
                fontFamily: robotoFontFamily,
                fontSize: medium_FontSize,
                letterSpacing: 2,
                fontWeight: normal_FontWeight,
                color: companyNameTextColor
            ),
          ),
        ],
      )
  );
}