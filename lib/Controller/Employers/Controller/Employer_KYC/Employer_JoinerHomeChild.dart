import 'package:contractjobs/Controller/Talents/Controller/CJHubInsuranceModule/insuranceStatus_ModelResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../Constant/ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';

class CJEmployerHomeModelClass
{
  String name;
  String profile;
  String image;
  String selectedViewType;
  bool status;
  String userType;
  bool verifyStatus;

  CJEmployerHomeModelClass({required this.name, required this.profile, required this.image,
    required this.selectedViewType,required this.status,required this.userType,required this.verifyStatus});
}


var getEmployerJoinerHomeChildList=[
//
  CJEmployerHomeModelClass(
      name: "KYC Verification",
      profile: "Add your GSTIN and PAN number to complete KYC verification",
      image: Employer_Icon_GreyOne,
      selectedViewType: CJEMPLOYER_KYCVerification,
      status: true,userType:kEmployer_USERTYPE_Individual,
      verifyStatus: false),
  CJEmployerHomeModelClass(
      name: "Business Details",
      profile: "Add your business details",
      image: Employer_Icon_GreyTwo,
      selectedViewType:CJEMPLOYER_SetUpCompanyDetails,
      status: false,userType:kEmployer_USERTYPE_Individual,verifyStatus: false),
  CJEmployerHomeModelClass(
      name: "Accept Terms and Conditions",
      profile: "Read and Accept Terms & Conditions to continue using the app",
      image: Employer_Icon_GreyThree,
      selectedViewType: CJEMPLOYER_EmployerTermsandConditions,
      status: false,userType:kEmployer_USERTYPE_Individual,verifyStatus: false),
  CJEmployerHomeModelClass(
      name: "Add Starting Balance",
      profile: "Add your payment",
      image: Employer_Icon_GreyFour,
      selectedViewType: CJEMPLOYER_EmployerAddStartingBalance,
      status: false,userType:kEmployer_USERTYPE_Individual,verifyStatus: false),
];

var getDefaultBtn =
   Directionality(
    textDirection: TextDirection.rtl,
    child: ElevatedButton.icon(
      onPressed:() {},
      label: Text(
        "Click Here",
        style: TextStyle(
            fontWeight: bold_FontWeight,
            fontSize: medium_FontSize,
            fontFamily: robotoFontFamily),
      ),
      icon: Image.asset(
          doubleRightArrow_White_Icon),
      style: ElevatedButton.styleFrom(
          backgroundColor: darkGreyColor,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(30),
          )),
    ),
  );

