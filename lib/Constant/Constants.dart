
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'CJAppFlowConstants.dart';


//////
const TankhaPayURL=TankhaPayAppURL_S;

/*---------Employer Attendance small icon width height---------*/
const Employer_SmallIcon_W_H=13.0;

/*---------CJHub app color code start(18-11-2022)-------*/
const oneHunGreyColor = Color(0xFFF5F5F5);
const twoHunGreyColor = Color(0xFFEEEEEE);
const threeHunGreyColor = Color(0xFFE0E0E0);
const fourHunGreyColor = Color(0xFFBDBDBD);
const sixHunGreyColor = Color(0xFF757575);

const primaryColor = Color(0xff32AAE0);
const primaryColorLightBlue = Color(0xFF03A9F4);

const bannerColor = Color(0xffffe5e5);
const bannerTextColor = Color(0xffFF7F7F);
const radiobuttonColor = Colors.orange;

const addInsuranceCardColor = Color(0xffDFECF2);

const addDarkGrayColor = Color(0xFF9E9E9E);
const addLightGrayColor = Color(0xFFBDBDBD);
const addBlackColor = Color(0x8A000000);
const Qr_heading = Color(0xFF99C9EC);

const lightGreenColor = Color(0xFFD5EEC7);


/*---------CJHub app color code end-------*/



  const lightBlueColor = Color(0xff33B8FD);
  const darkBlueColor = Color(0xff199ADB);

  const lightGreyColor = Color(0xffF5F5F5);
  const darkGreyColor = Color(0xffC1C1C1);

  const greenColor = Color(0xff1BAD03);
  const redColor = Color(0xffd50000);

const darkPurpleColor = Color(0xff21A3BD);



  const whiteColor = Color(0xffffffff);
  const blackColor = Colors.black;
  const menuTextColor = Color(0xff8D8D8D);

  const companyNameTextColor = Color(0xff5D5B5C);



   const webResponsive_TD_Width = 370.0;
   const mainUILeftRightPadding=15.0;

  const appBarTitleFontWeight = 16.0;
  const appBarTitleForegroundColor = Colors.black;
  const appBarBackButtonColor = Colors.black;
  //const robotoFontFamily = "Roboto";
  const robotoFontFamily = "Poppins";


  const spacingBetween_TextFieldandTextHeading=5.0;
  const viewHeadingFontweight = 18.0;
  const viewSubHeadingFontweight = 14.0;
  const viewHeadingFontfamily = "Poppins";

  const textFieldHeadingFontWeight = 14.0;
  const textFieldHeadingColor = Color(0xff000000);

  const textFieldHintTextColor = Color(0xff636363);
  //const textFieldBorderColor = Color(0xffF9F9F9);
  const textFieldBorderColor = Color(0xffF0F0F0);


 //const textFieldBorderColor = Color(0xffEBEBEB);

 const textFieldFontWeightType = FontWeight.w500;

const elevatedButtonLeftRightPaddingTankhaPay=80.0;

const elevatedButtonLeftRightPadding=80.0;
 const elevatedButtonBottomPadding=20.0;
 const elevatedButtonTopPadding=5.0;

 const ElevatedButtonHeight = 55.0;
 const ElevatedButtonWidth = 331.0;
 const ElevatedButtonBgBlueColor = Color(0xff33b8fd);
 const ElevatedButtonTextFontWeight = 14.0;

 const ElevatedButtonBgGrayColor = Color(0xffE8E8E8);
 const ElevatedButtonTextColorDarkGray = Color(0xff676566);


 const textKeyColor = Color(0xff33B8FD);
 const textKeyFontWeight = 15.0;
 const textValueColor = Color(0xff636363);
 const textValueFontWeight = 15.0;

/*---------------into slide UI ------------------*/

const introHeadingFontSize = 18.0;
const introSubHeadingFontSize = 13.0;
const introScreenBottomPadding = EdgeInsets.fromLTRB(30, 15, 30, 10);

/*---------------into slide UI ------------------*/

const billingLabelFontWeight = FontWeight.normal;
const billingLabelFontSize = 14.0;

/*--------------------7-10-2022 start----------------------*/

 const listTitle_FontSize=16.0;
 const listSubTitle_FontSize=13.0;

 const bold_FontWeight=FontWeight.bold;
 const semiBold_FontWeight=FontWeight.w600;
 const normal_FontWeight=FontWeight.w500;
 const largeExcel_FontSize=18.0;
 const large_FontSize=16.0;
 const medium_FontSize=14.0;
 const small_FontSize=12.0;
 const smallLess_FontSize=10.0;


 const kEmployerRegistrationType_Home=0;
 const kEmployerRegistrationType_Business=1;




/*
Text("All Your transactions in",
style: TextStyle(fontSize: 12,color: Color(0xff292926),
fontFamily: robotoFontFamily,
fontWeight: FontWeight.w600

*/


/*-------Start-------login screen width for tablet and desktop---------------*/

const  login_tabletWidth = 300.0;
const  login_desktopWidth = 300.0;

/*-------end-------login screen width for tablet and desktop---------------*/


/*-------Start-------profile screen width for tablet and desktop---------------*/

const  profile_tabletWidth = 0.85;
const  profile_desktopWidth = 0.7;

/*-------end-------profile screen width for tablet and desktop---------------*/


/*-------Start-------salary status screen width for tablet and desktop---------------*/
const  salaryStatus_tabletWidth = 400.0;
const  salaryStatus_desktopWidth = 400.0;

/*-------end-------salary status screen width for tablet and desktop---------------*/


/*-------Start-------salary slip screen width for tablet and desktop---------------*/
const  salarySlip_tabletWidth = 400.0;
const  salarySlip_desktopWidth = 400.0;

/*-------end-------salary slip screen width for tablet and desktop---------------*/


/*-------Start-------salary slip details screen width for tablet and desktop---------------*/
const  salarySlipDetails_tabletWidth = 0.85;
const  salarySlipDEtails_desktopWidth = 0.7;

/*-------end-------salary slip details screen width for tablet and desktop---------------*/


/*-------Start-------profile screen width for tablet and desktop---------------*/

const  investmentDeclaration_tabletWidth = 0.85;
const  investmentDeclaration_desktopWidth = 0.7;

/*-------end-------profile screen width for tablet and desktop---------------*/

/*-------Start-------insurance screen width for tablet and desktop---------------*/
const  insurance_tabletWidth = 400.0;
const  insurance_desktopWidth = 400.0;

const  insurance_addInsurancePolicy_tabletWidth = 600.0;
const  insurance_addInsurancePolicy_desktopWidth = 600.0;

/*-------end-------insurance screen width for tablet and desktop---------------*/

/*-------Start-------Support screen width for tablet and desktop---------------*/

const  support_tabletWidth = 0.85;
const  support_desktopWidth = 0.7;

/*-------end-------Support screen width for tablet and desktop---------------*/



/*------------------Responsive width of whole flutter web App-start----------------*/

const  flutterWeb_tabletWidth = 400.0;
const  flutterWeb_desktopWidth = 400.0;

/*------------------Responsive width of whole flutter web App-stop----------------*/
//
const GALLERY="GALLERY";
const CAMERA="CAMERA";


