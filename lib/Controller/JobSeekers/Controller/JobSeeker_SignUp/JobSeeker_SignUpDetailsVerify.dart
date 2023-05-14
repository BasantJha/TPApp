import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeeker_TabBarController/JobSeeker_TabBarController.dart';
import 'package:contractjobs/Controller/Talents/Controller/Talent_SignUp/Talent_VerifyBankAccount.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';

class JobSeeker_SignUpDetailsVerify extends StatefulWidget
{

  const JobSeeker_SignUpDetailsVerify({Key? key}) : super(key: key);

  @override
  _JobSeeker_SignUpDetailsVerify createState() => _JobSeeker_SignUpDetailsVerify();

}

class _JobSeeker_SignUpDetailsVerify extends State<JobSeeker_SignUpDetailsVerify> {

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        body: getResponsiveUI(),
        bottomNavigationBar: elevatedButtonBottomBar()
    );
  }

  Responsive getResponsiveUI()
  {
    return Responsive(
      mobile: MainfunctionUi(),
      tablet: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(),
        ),
      ),
      desktop: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(),
        ),
      ),
    );
  }
  Container MainfunctionUi()
  {
    return Container( color: whiteColor,height:MediaQuery.of(context).size.height,
      child: SingleChildScrollView(child: Column(
        children: [
          SizedBox(height: 40),

          Center(child:getViewHintTextBlue(getJobSeeker_SignUpDetailsVerifiedHint),),

          SizedBox(height: 30),
          Text('Your profile has been successfully\ncreated',textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.normal,
              fontSize: 14,color: blackColor,
              fontFamily: viewHeadingFontfamily,

              //fontWeight: bold_FontWeight,
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            height: 150,
            width: 150,
            child:Image.asset(Talent_SP_GIF) /*Image.network('https://tenor.com/view/verified-verified-instagram-verified-blue-gif-26305004.gif')*/,
          ),
          Container(
            //width:500,
            margin: EdgeInsets.all(30),
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Your profile is only 25% complete. Please complete your profile to find the best roles as per your requirements.',textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: robotoFontFamily,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),


        ],
      ),),
    );
  }

  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Let's Explore Jobs", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");

      TalentNavigation().pushTo(context, JobSeeker_TabBarController());
    }
    ));
  }



}
