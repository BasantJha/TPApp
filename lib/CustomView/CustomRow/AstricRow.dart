

import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../HintWidget/HintWidget.dart';

Row getAstricRow(String textType)
{
  return Row(
      children: [
        Text(textType,
          style: TextStyle(fontFamily: robotoFontFamily,
              fontWeight: bold_FontWeight,
              fontSize: 13
          ),
          textAlign: TextAlign.left,
        ),
        Text(
          ' *',
          style: TextStyle(
              fontWeight: bold_FontWeight,
              fontSize: 13,
              color: Colors.red
          ),
          textAlign: TextAlign.left,
        )
      ]
  );
}

Row getWithoutAstricRow(String textType)
{
  return Row(
      children: [
        Text(textType,
          style: TextStyle(fontFamily: robotoFontFamily,
              fontWeight: bold_FontWeight,
              fontSize: 13
          ),
          textAlign: TextAlign.left,
        ),
        /*Text(
          ' *',
          style: TextStyle(
              fontWeight: bold_FontWeight,
              fontSize: 13,
              color: Colors.red
          ),
          textAlign: TextAlign.left,
        )*/
      ]
  );
}
getKYCAstricRow(String textType)
{
  return Padding(
    padding: const EdgeInsets.only(left:30),
    child: Row(
        children: [
          Text(textType,
            style: TextStyle(fontFamily: robotoFontFamily,
                fontWeight: bold_FontWeight,
                fontSize: 13
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            ' *',
            style: TextStyle(
                fontWeight: bold_FontWeight,
                fontSize: 13,
                color: Colors.red
            ),
            textAlign: TextAlign.left,
          )
        ]
    ),
  );
}

Row getAstricRowWithInfo(String heading,BuildContext context,GlobalKey globalKey,String hintText)
{
  return Row(
      children: [
       /* Padding(padding: EdgeInsets.only(left: 20)),*/
        Text(heading,
          style: TextStyle(fontFamily: robotoFontFamily,
              fontWeight: bold_FontWeight,
              fontSize: 13
          ),
          textAlign: TextAlign.left,
        ),
        Text(
          ' *',
          style: TextStyle(
              fontWeight: bold_FontWeight,
              fontSize: 13,
              color: Colors.red
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(width: 5,),

       HintWidget(globalKey: globalKey,title: "",description: hintText,child:InkWell(onTap: ()
       {

         WidgetsBinding.instance.addPostFrameCallback((_) =>
             ShowCaseWidget.of(context)
                 .startShowCase([globalKey]));

       },child:  CircleAvatar(
         radius: 10,
         backgroundColor: Colors.cyan[400],
         child: Text(
           "i",
           style: TextStyle(
               color: whiteColor,
               fontSize: small_FontSize,
               fontStyle: FontStyle.italic),
         ),
       ),) )


      ]
  );
}


/*
Row getCalculatorHealthBenefitWithInfo(String heading,BuildContext context,GlobalKey globalKey,String hintText)
{
  return Row(
      children: [
        */
/* Padding(padding: EdgeInsets.only(left: 20)),*//*

       */
/* Text(heading,
          style: TextStyle(fontFamily: robotoFontFamily,
              fontWeight: bold_FontWeight,
              fontSize: 13
          ),
          textAlign: TextAlign.left,
        ),*//*


        Flexible(
            child:  Text(heading,
              style: TextStyle(
                  color: check_ESIC==""?greenColor:darkGreyColor,
                  fontWeight: normal_FontWeight,
                  fontFamily: robotoFontFamily,
                  fontSize: medium_FontSize
              ),
            )
        ),

        SizedBox(width: 5,),

        HintWidget(globalKey: globalKey,title: "",description: hintText,child:InkWell(onTap: ()
        {

          WidgetsBinding.instance.addPostFrameCallback((_) =>
              ShowCaseWidget.of(context)
                  .startShowCase([globalKey]));

        },child:  CircleAvatar(
          radius: 15,
          backgroundColor: Colors.cyan[400],
          child: Text(
            "i",
            style: TextStyle(
                color: whiteColor,
                fontSize: small_FontSize,
                fontStyle: FontStyle.italic),
          ),
        ),) )


      ]
  );
}
*/

