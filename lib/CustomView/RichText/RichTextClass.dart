//import 'dart:js';

import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../Constant/CJAppFlowConstants.dart';
import '../../Controller/Employers/Controller/Employer_KYC/Employer_JoinerHome.dart';
import '../../Controller/Employers/Controller/Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../../Controller/Talents/TalentNavigation/TalentNavigation.dart';
import '../../Controller/TankhaPayModule/Controller/TankhaPayBenefits/ThankhaPayViewBenefits/CommonViewTextClass.dart';
import '../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../Services/CJTalentsService/CJTalentServiceKey.dart';

Container getRichTextForLoginHint(String title,BuildContext context)
{

 return Container(width: double.infinity,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: RichText(textAlign: TextAlign.center,
        text: TextSpan(
          text: '$title\n',
          style: new TextStyle(fontFamily: viewHeadingFontfamily,fontWeight: normal_FontWeight,
            fontSize: 10.0,
            color: appBarTitleForegroundColor,
          ),
          children: <TextSpan>[

            TextSpan(text: "Terms & Conditions ",style: TextStyle(fontFamily: viewHeadingFontfamily,fontWeight: normal_FontWeight,color: lightBlueColor,
              fontSize: 13.0,),recognizer: TapGestureRecognizer()..onTap=()
            {
              view(context,kTankhaPay_Benefit_CategoryType_TermsOfUse,CJThankhaPay_TermsOfUse);

            }),

            TextSpan(text: "and ",style: TextStyle(fontFamily: viewHeadingFontfamily,fontWeight: normal_FontWeight,color: appBarTitleForegroundColor,
              fontSize: 10.0,)),

            TextSpan(text: "Privacy Policy",style: TextStyle(fontFamily: viewHeadingFontfamily,fontWeight: normal_FontWeight,color: lightBlueColor,
              fontSize: 13.0,),recognizer: TapGestureRecognizer()..onTap=()
            {
              view(context,kTankhaPay_Benefit_CategoryType_PrivacyPolicy,CJThankhaPay_PrivacyPolicy);

            }),
           /* TextSpan(text: " of Contract Jobs ",style: TextStyle(fontFamily: viewHeadingFontfamily,fontWeight: normal_FontWeight,color: appBarTitleForegroundColor,
              fontSize: 10.0,))*/
          ],
        ),
      ),
    ),
  );

}

view(BuildContext context,String fileName,String viewTitle)
{

  TalentNavigation().pushTo(context, CommonViewTextClass(showFileName:fileName,titleName: viewTitle,));

}

performAction()
{

}
Container getRichTextForRegistration()
{

  return Container(width: double.infinity,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: RichText(textAlign: TextAlign.center,
        text: TextSpan(
          text: '',
          style: new TextStyle(fontFamily: viewHeadingFontfamily,fontWeight: normal_FontWeight,
            fontSize: 10.0,
            color: appBarTitleForegroundColor,
          ),
          children: <TextSpan>[

            TextSpan(text: "Create a new account on TankhaPay. ",
                style: TextStyle(fontFamily: viewHeadingFontfamily,
                  fontWeight: normal_FontWeight,color: appBarTitleForegroundColor,
              fontSize: 12.0,)),

            TextSpan(text: "Register Now",
                style: TextStyle(fontFamily: viewHeadingFontfamily,
                  fontWeight: normal_FontWeight,color: lightBlueColor,
              fontSize: 14.0,)),

            /* TextSpan(text: " of Contract Jobs ",style: TextStyle(fontFamily: viewHeadingFontfamily,fontWeight: normal_FontWeight,color: appBarTitleForegroundColor,
              fontSize: 10.0,))*/
          ],
        ),
      ),
    ),
  );

}

Container getRichTextForRegistrationEmployerNotRegister()
{

  return Container(width: double.infinity,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: RichText(textAlign: TextAlign.center,
        text: TextSpan(
          text: '',
          style: new TextStyle(fontFamily: viewHeadingFontfamily,fontWeight: normal_FontWeight,
            fontSize: 10.0,
            color: appBarTitleForegroundColor,
          ),
          children: <TextSpan>[

            TextSpan(text: "Phone number not registered. Please ",
                style: TextStyle(fontFamily: viewHeadingFontfamily,
                  fontWeight: normal_FontWeight,color: blackColor,
                  fontSize: 12.0,)),

            TextSpan(text: "register",
                style: TextStyle(fontFamily: viewHeadingFontfamily,decoration: TextDecoration.underline,
                  fontWeight: normal_FontWeight,color: darkBlueColor,
                  fontSize: 14.0,)),

             TextSpan(text: " as an employer to start using TankhaPay ",
                 style: TextStyle(fontFamily: viewHeadingFontfamily,fontWeight: normal_FontWeight,color: blackColor,
              fontSize: 12.0,))
          ],
        ),
      ),
    ),
  );

}
Container getRichTextForLoginOption(String heading,String subHeading,Color textColorCode)
{

  return Container(
    //color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(1.0),
      child: RichText(textAlign: TextAlign.left,
        text: TextSpan(
          text: heading,
          style: new TextStyle(fontFamily: viewHeadingFontfamily,fontWeight: bold_FontWeight,
            fontSize: medium_FontSize,
            color: textColorCode,
          ),
          children: <TextSpan>[
            TextSpan(text: "\n",style: TextStyle(fontSize: 5)),

            TextSpan(text: "\n$subHeading",style: TextStyle(fontWeight: FontWeight.normal,fontFamily: viewHeadingFontfamily,
              color: textColorCode,
              fontSize: smallLess_FontSize,)),
          ],
        ),
      ),
    ),
  );

}

RichText getRichTextForTalentProfileSlide(String field, String value) {
  return RichText(
    text: TextSpan(
        text: field,
        style: TextStyle(
          color: Colors.black,
          fontWeight: semiBold_FontWeight,
          fontFamily: viewHeadingFontfamily,
        ),
        children: [
          TextSpan(
              text: value,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ))
        ]),
  );
}