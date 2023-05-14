
import 'package:flutter/material.dart';

const TextStyle kHRA_Edit = TextStyle(
    fontSize: 12,
    color: Colors.black45
);
const TextStyle kHRA_Edit_value = TextStyle(
    fontSize: 12,
    color: Colors.black
);

const TextStyle profileDocumentText_value = TextStyle(
    fontSize: 16,
    color: Colors.black87
);
const TextStyle k80C_VI_Edit_value = TextStyle(
    fontSize: 13,
    color: Colors.black,
    fontWeight: FontWeight.bold
);


BoxDecoration Style_UploadInvestment_Top = BoxDecoration(
  shape: BoxShape.rectangle,
  border: Border(
    left: BorderSide(
        color: getFourHundredGreyColor(),
        width: 1.0,style: BorderStyle.solid
    ),right:BorderSide(
      color: getFourHundredGreyColor(),
      width: 1.0,style: BorderStyle.solid
  ),top:BorderSide(
      color: getFourHundredGreyColor(),
      width: 1.0,style: BorderStyle.solid
  ), ),
);
BoxDecoration Style_UploadInvestment_Bottom = BoxDecoration(
  shape: BoxShape.rectangle,
  border: Border(
    left: BorderSide(
        color: getFourHundredGreyColor(),
        width: 1.0,style: BorderStyle.solid
    ),right:BorderSide(
      color: getFourHundredGreyColor(),
      width: 1.0,style: BorderStyle.solid
  ),bottom:BorderSide(
      color: getFourHundredGreyColor(),
      width: 1.0,style: BorderStyle.solid
  ), ),
);
BoxDecoration Style_UploadInvestment_Inner = BoxDecoration(
  shape: BoxShape.rectangle,
  border: Border(
      left: BorderSide(
          color: getFourHundredGreyColor(),
          width: 1.0,style: BorderStyle.solid
      ),right:BorderSide(
      color: getFourHundredGreyColor(),
      width: 1.0,style: BorderStyle.solid
  ) ),
);

BoxDecoration Style_UploadInvestment_All_Border = BoxDecoration(
  shape: BoxShape.rectangle,
  border: Border.all(color: getThreeHundredGreyColor(),width: 1.0,style: BorderStyle.solid),
);


/*--------------3-12-2021 start use for chapter-VI view--------------------*/
const TextStyle VI_View_value = TextStyle(
    fontSize: 10,
    color: Colors.black
);
const TextStyle VI_View = TextStyle(
    fontSize: 10,
    color: Colors.black54
);
const TextStyle VI_View_black = TextStyle(
    fontSize: 10,
    color: Colors.black54
);

/*--------------3-12-2021 end use for chapter-VI view--------------------*/


BoxDecoration Style_KYC_details_Add_Edit = BoxDecoration(
  shape: BoxShape.rectangle,
  border: Border(
    left: BorderSide(
        color: Colors.grey,
        width: 1.0,style: BorderStyle.solid
    ),top:BorderSide(
      color: Colors.grey,
      width: 1.0,style: BorderStyle.solid
  ),bottom: BorderSide(
      color: Colors.grey,
      width: 1.0,style: BorderStyle.solid
  ), ),
);


/*----------------17-08-2022 Tax Projection TextStyle------------ */

TextStyle Tax_mainHeading() {
  return TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold);
}

TextStyle Tax_TableHeading(){
  return  TextStyle(fontSize: 10, color: Colors.white);
}

TextStyle Tax_TableSubHeading(){
  return TextStyle(fontSize: 10);
}

RoundedRectangleBorder TaxProjection_cardStyle = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10.0),
  side: BorderSide(
    color: getSixHundredGreyColor(),
    width: 0.5,
  ),
);

BoxDecoration Qr_code_BoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(5.0),
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 8.0,
      offset: Offset(0.0, 5.0),
    ),
  ],
);

Color getOneHundredGreyColor()
{
  return Color(0xFFF5F5F5);
}
Color getFourHundredGreyColor()
{
  return Color(0xFFBDBDBD);
}
Color getThreeHundredGreyColor()
{
  return Color(0xFFE0E0E0);
}
Color getSixHundredGreyColor()
{
  return Color(0xFF757575);
}

Color getTabBGGreyColor()
{
  return Color(0xffe6e6e6);
}

