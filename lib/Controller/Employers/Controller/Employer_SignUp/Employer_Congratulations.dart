import 'package:flutter/material.dart';

import '../../../../Constant/ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../CustomView/ButtonDecoration/CustomButtonAction.dart';
import '../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../Employer_TabBarController/Employer_TabBarController.dart';

class Employer_Congratulations extends StatefulWidget {
  const Employer_Congratulations({Key? key}) : super(key: key);

  @override
  State<Employer_Congratulations> createState() => _Employer_CongratulationsState();
}

class _Employer_CongratulationsState extends State<Employer_Congratulations> {

  var selectRegistrationType;

  _Employer_CongratulationsState()
  {
    this.selectRegistrationType=selectRegistrationType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: whiteColor,
      appBar:CJAppBar(getEmployer_Business_SignUpTitle, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),
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

  MainfunctionUi(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: 190,),
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
            Text('Thanks for providing business details, Please wait for us to review your application. We will update you once the review is done. Ideally this process takes 24 to 48 working hours.',textAlign: TextAlign.center,
              style: TextStyle(fontFamily: robotoFontFamily,
                fontSize: 17,
                fontWeight: normal_FontWeight,
                color: textValueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Get Started >>", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");

      TalentNavigation().pushTo(context, Employer_TabBarController());

    }
    ));
  }
}
