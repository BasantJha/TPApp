import 'package:flutter/material.dart';

import '../../../../Constant/ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../CustomView/ButtonDecoration/CustomButtonAction.dart';
import '../../../../CustomView/ContainerView/CustomContainer.dart';
import '../../../LoginView/Controller/LoginOptionController.dart';
import '../../../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../../../TankhaPayPinNumber/TankhaPaySet4DigitPin.dart';
import '../Employer_KYC/Employer_JoinerHome.dart';
import '../Employer_TabBarController/Employer_TabBarController.dart';

class Employer_NewCongratulations extends StatefulWidget {
  const Employer_NewCongratulations({Key? key, required this.message,required this.mobileNo/* , required this.registrationType, required this.registrationStatus, required this.userType,*/}) : super(key: key);

 final String message;
  final String mobileNo;
  /*final String registrationType;
  final String registrationStatus;
  final String userType;*/

  @override
  State<Employer_NewCongratulations> createState() => _Employer_NewCongratulations();
}

class _Employer_NewCongratulations extends State<Employer_NewCongratulations> {

  //
/*
  var selectRegistrationType;

  _Employer_NewCongratulations(selectRegistrationType)
  {
    this.selectRegistrationType=selectRegistrationType;
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: whiteColor,
      /* appBar:CJAppBar(getEmployer_Business_SignUpTitle, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),*/
      body: getResponsiveUI(),
      // bottomNavigationBar: elevatedButtonBottomBar()
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

  MainfunctionUi(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [

            SizedBox(height: 30),

            getTheTankhaPayGrayLogoContainer,
            SizedBox(height: 70),

            //SizedBox(height: 190,),
            RichText(text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Congratulations!',
                    style:  TextStyle(
                      fontWeight:bold_FontWeight,
                      color: textValueColor,
                      fontSize: 20,
                      fontFamily: viewHeadingFontfamily,
                    ),
                  ),
                  WidgetSpan(
                    child: Image.asset(congratulations_Icon),
                    // Icon(Icons.add, size: 14),
                  ),
                ]
            )
            ),
            SizedBox(height: 15,),
            Text(widget.message,textAlign: TextAlign.center,
              style: TextStyle(fontFamily: robotoFontFamily,
                fontSize: large_FontSize,
                fontWeight: normal_FontWeight,
                color: textValueColor,
              ),
            ),
            SizedBox(height: 50),

            elevatedButtonBottomBar()
          ],
        ),
      ),
    );
  }

  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Continue >>", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");

      /*---------------15-2-2023 start------------*/
      //TalentNavigation().pushTo(context, LoginOptionController());

      TalentNavigation().pushTo(context, TankhaPaySet4DigitPin(verifyOTP_ModelResponse: VerifyOTP_ModelResponse(),employerMobileNo: widget.mobileNo,));

      /*---------------15-2-2023 end------------*/

    }
    ));
  }
}
