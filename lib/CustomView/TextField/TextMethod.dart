
import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/cupertino.dart';



Text getTextHeading(String heading)
{
  return Text(heading,
    style: TextStyle(
      fontWeight: bold_FontWeight,
      fontSize: textFieldHeadingFontWeight,
    ),
  );
}
Text getTextSubHeading(String subHeading)
{
  return Text(subHeading,
    style: TextStyle(
      fontWeight: bold_FontWeight,
      fontSize: textFieldHeadingFontWeight,
    ),
  );
}