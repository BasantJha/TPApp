import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Employers/Controller/Employer_TabBarController/Employer_TabBarController.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Employer_Business_SignUpKYC extends StatefulWidget
{
  const Employer_Business_SignUpKYC({Key? key}) : super(key: key);

  @override
  State<Employer_Business_SignUpKYC> createState() => _Employer_Business_SignUpKYC();
}

class _Employer_Business_SignUpKYC extends State<Employer_Business_SignUpKYC>
{

  static const mediumDarkGreyColor = Color(0xff636363);


  var selectRegistrationType;
  _Employer_Business_SignUpKYC()
  {
    print("show the business info kyc status $selectRegistrationType");
    this.selectRegistrationType=selectRegistrationType;
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor: whiteColor,
      appBar:CJAppBar(getEmployer_Business_SignUpTitle, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),
      body: getResponsiveUI(),
      bottomSheet: elevatedButtonWithDotBottomBar(),
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

  SingleChildScrollView MainfunctionUi()
  {
    return SingleChildScrollView(
      child: Container(
        height: 700,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(child:getViewHintTextBlue(getEmployer_Business_SignUpPanGSTHint),),

            SizedBox(height: 45),
            getAstricRow("GST Number"),

            SizedBox(height: 7),
            Container(
              //padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: TextField(
                  // maxLength: 15,
                  cursorColor: mediumDarkGreyColor,
                  style: TextStyle(),
                  decoration:
                  decoration('07AAECR2971C1Z5', gst_Grey_Icon, checkGreen_Icon),
                )),
            SizedBox(height: 20),
            getAstricRow("PAN Number"),

            SizedBox(height: 7),
            Container(
              //padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: TextField(
                  // maxLength: 10,
                  cursorColor: mediumDarkGreyColor,
                  style: TextStyle(),
                  decoration:
                  decoration('BOPPM4264E', pan_Grey_Icon, checkGreen_Icon),
                )),
            SizedBox(height:90),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Congratulations!",
                    style: TextStyle(
                      color: darkBlueColor,
                      fontWeight: normal_FontWeight,
                      fontFamily: robotoFontFamily,
                      fontSize: large_FontSize,
                    ),
                  ),
                  SizedBox(width: 8),
                  Image(image: AssetImage(congratulations_Icon))
                ],
              ),
            ),
            SizedBox(height: 18),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Registration is now complete. Get started to find the best matches for all your contractual needs!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: blackColor,
                      fontWeight: normal_FontWeight,
                      fontFamily: robotoFontFamily,
                      fontSize: small_FontSize,
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  InputDecoration decoration(String hinttext, String preFixIcon, String suffixIcon)
  {
    return InputDecoration(
      prefixIcon: Image(
        image: AssetImage(preFixIcon),
      ),
      suffixIcon: Image(width: 6,height: 6,
        image: AssetImage(suffixIcon),
      ),
      hintText: hinttext,
      hintStyle: TextStyle(
          fontFamily: robotoFontFamily,
          color: darkGreyColor,
          fontSize: large_FontSize,
          fontWeight: normal_FontWeight),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: lightGreyColor, width: 1.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }

  Container elevatedButtonWithDotBottomBar()
  {
    return CJElevatedBlueButtonWithDotJobSeeker("Get Started >>", 3,elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action 1");
      TalentNavigation().pushTo(context, Employer_TabBarController());

    }
    )) ;

  }
}

