import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../Constant/ConstantIcon.dart';
import '../../../../../../Constant/Constants.dart';
import '../../../../../Talents/TalentNavigation/TalentNavigation.dart';
import 'Employer_NewWorkPlaceCreateLeaveTemplate.dart';

String plusIcon = plus_Black_Icon;

Container createTheCustomLeaveTemplate(BuildContext context)
{
  return Container(
    height: 50,
    alignment: Alignment.center,
    padding: EdgeInsets.only(left: 8,right: 8),
    decoration: BoxDecoration(
      border: Border.all(
          color: darkGreyColor
      ),
      gradient: LinearGradient(
        colors: [
          Color(0xfffdfdfd),
          Color(0xffdddddd)
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    child:  InkWell(onTap: ()
    {
      TalentNavigation().pushTo(context, Employer_NewWorkPlaceCreateLeaveTemplate());

    },child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Create Custom Template",
          style: TextStyle(
              fontFamily: robotoFontFamily,
              fontSize: large_FontSize,
              fontWeight: normal_FontWeight,
              color: darkBlueColor
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Image.asset(plusIcon,height: 20,width: 20,),
      ],
    ),),
  );
}