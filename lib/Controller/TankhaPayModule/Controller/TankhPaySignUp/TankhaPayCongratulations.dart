import 'package:contractjobs/Controller/JoiningProfile/TEC_JoiningProfileDashboard.dart';
import 'package:flutter/material.dart';

import '../../../../Constant/CJAppFlowConstants.dart';
import '../../../../Constant/ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../CustomView/ButtonDecoration/CustomButtonAction.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../CustomView/ContainerView/CustomContainer.dart';
import '../../../Employers/Controller/Employer_TabBarController/Employer_TabBarController.dart';
import '../../../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../TankhaPayTabBarController/TankhaPay_TabBarController.dart';

class TankhaPayCongratulations extends StatefulWidget
{
  const TankhaPayCongratulations({Key? key,this.selectRegistrationType, this.verifyOTP_ModelResponse}) : super(key: key);
  final String? selectRegistrationType;
  final VerifyOTP_ModelResponse? verifyOTP_ModelResponse;

  @override
  State<TankhaPayCongratulations> createState() => _TankhaPayCongratulations();
}

class _TankhaPayCongratulations extends State<TankhaPayCongratulations> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //getEmployeeEC_TECType();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: whiteColor,
      /*  appBar:CJAppBar(getEmployer_Business_SignUpTitle, appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action type");
          Navigator.pop(context);
        })),*/
        body: getResponsiveUI(),
        //bottomNavigationBar: elevatedButtonBottomBar()
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
    return SingleChildScrollView(child: Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(child: Column(
          children: [

            SizedBox(height: 70),
            getTheTankhaPayGrayLogoContainer,
            SizedBox(height: 70),
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
            Text('Your account has been\nsuccessfully created!',textAlign: TextAlign.center,
              style: TextStyle(fontFamily: robotoFontFamily,
                fontSize: 17,
                fontWeight: normal_FontWeight,
                color: textValueColor,
              ),
            ),
            SizedBox(height: 50,),
            elevatedButtonBottomBar()
          ],
        ),),
      ),
    ),);
  }

 /* getEmployeeEC_TECType()
  {
    SharedPreference.getEC_STATUS().then((value) =>  {
      print('show emp ecstatus $value'),
      EC_TECSTATUS=value,

    });
  }*/

  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Continue >>", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the 1 continue action");
      if(widget.verifyOTP_ModelResponse!.data!.ecStatus==CJJOB_ECSTATUS)
        {
          TalentNavigation().pushTo(context, TankhaPay_TabBarController(liveModelObject: widget.verifyOTP_ModelResponse,));
        }
      else if(widget.verifyOTP_ModelResponse!.data!.ecStatus==CJJOB_TECSTATUS)
        {
          TalentNavigation().pushTo(context, TEC_JoiningProfileDashboard(verifyOTP_ModelResponse: widget.verifyOTP_ModelResponse,));
        }
        else
          {

          }
//
    }
    ));
  }
}


