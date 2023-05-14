import 'package:contractjobs/Controller/Talents/Controller/CJHubTECModule/CJHubTECView/Profile_Document.dart';
import 'package:contractjobs/CustomView/CJSnackBar/CJSnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constant/CJAppFlowConstants.dart';
import '../../Constant/ConstantIcon.dart';
import '../../Constant/Constants.dart';
import '../Talents/Controller/CJHubTECModule/CJHubTECView/KYC_details_Add_Edit.dart';
import '../Talents/Controller/CJHubTECModule/CJHubTECView/profile_personalDetails_edit.dart';
import '../Talents/Controller/CJHubTECModule/TECPANAadhaarVerifyView/AadhaarCardView.dart';
import '../Talents/Controller/CJHubTECModule/TECPANAadhaarVerifyView/PanCardView.dart';
import '../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../Talents/TalentNavigation/TalentNavigation.dart';
import 'KYCModule/Aadhar_Verification.dart';
import 'KYCModule/PAN_Verification.dart';
import 'TEC_BankInfoVerify.dart';
import 'TEC_JoiningProfileDashboard.dart';

class CJJoiningProfile {
  String title;
  String subTitle;
  String logoIcon;
  String actionStatus;
  String kycStatus;
  String kycAAPPUU;


  CJJoiningProfile({required this.title, required this.subTitle, required this.logoIcon,required this.actionStatus, required this.kycStatus,required this.kycAAPPUU});
}
//Note:: kycAAPPUU:"0" default (1-> for Aadhaar, 2-> for PAN, 3-> UAN Verification)
var cjJoiningProfileList=[
  CJJoiningProfile(
      title: "Update your Profile",
      subTitle: "Update your personal details",
      logoIcon: JoiningProfile_Icon_UpdateDetails,
      actionStatus:CJJoiningProfile_UpdatePersonalDetails,
      kycStatus:"N",
      kycAAPPUU:"0" ),
  CJJoiningProfile(
      title: "Update KYC Details",
      subTitle: "Verify your KYC Documents Aadhar, PAN Card",
      logoIcon: JoiningProfile_Icon_UpdateKYC,
      actionStatus: CJJoiningProfile_UpdateKYC,
       kycStatus:"N",
       kycAAPPUU:"0"),
  CJJoiningProfile(
      title: "Update Bank Details",
      subTitle: "Verify your bank accounts",
      logoIcon: JoiningProfile_Icon_UpdateBankDetails,
      actionStatus: CJJoiningProfile_UpdateBankDetails,
      kycStatus:"N",kycAAPPUU:"0"),
  /*CJJoiningProfile(
      title: "Update Documents",
      subTitle: "Upload Relieving / Experience Letter, Latest Salary Slip or Bank Statement",
      logoIcon: JoiningProfile_Icon_UpdateDocument,
      actionStatus: CJJoiningProfile_UpdateDocuments),*/
];

Widget cjJoiningProfileCardTemplate(List<CJJoiningProfile> cjJoiningProfileList,
    cjJoiningObj,int selectedIndex,BuildContext context,VerifyOTP_ModelResponse? verifyOTP_ModelResponse)
{
   const profileTitleColor = Color(0xff107A9D);
   const profileSubTitleColor = Color(0xff282828);
   const downColor2 = Color(0xffE0E0D4);
   var kycStatus_Visibility=false;

   if(cjJoiningProfileList[selectedIndex].kycStatus=="N")
     {
       //N
       kycStatus_Visibility=false;
     }
   else
     {
       //Y
       kycStatus_Visibility=true;
     }


   return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Card(
      //elevation: 12,
        margin: EdgeInsets.all(15),
        color: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: downColor2),
                gradient: LinearGradient(
                  colors: [Color(0xffF6F6F6), Color(0xffE0E0D4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                                "${cjJoiningObj.title}",

                                style: TextStyle(
                                  color: profileTitleColor,
                                  fontWeight: bold_FontWeight,
                                  fontFamily: robotoFontFamily,
                                  fontSize: listTitle_FontSize,
                                )
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
                              child: Text(
                                  "${cjJoiningObj.subTitle}",

                                  style: TextStyle(
                                    color: profileSubTitleColor,
                                    fontWeight: normal_FontWeight,
                                    fontFamily: robotoFontFamily,
                                    fontSize: listSubTitle_FontSize,
                                  )
                              ),
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                            child: kycStatus_Visibility ? Container(
                              height: 35,

                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Image.asset(checkGreen_Icon),
                              ),
                            ):Container(
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff12ADDD),
                                    Color(0xff0F8FB6),
                                    Color(0xff0C708E)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ElevatedButton.icon(
                                  onPressed: ()
                                  {
                                    print("show the response");
                                    var selectedObj=cjJoiningProfileList[selectedIndex];
                                    var actionType=selectedObj.actionStatus;
                                    if(actionType==CJJoiningProfile_UpdatePersonalDetails)
                                    {
                                      TalentNavigation().pushTo(context, profile_personalDetails_edit());
                                    }
                                    else if(actionType==CJJoiningProfile_UpdateKYC)
                                    {
                                      //TalentNavigation().pushTo(context, PanCardView(USER_ARRIVE_FROM_STATUS:""));
                                      //TalentNavigation().pushTo(context, AadhaarCardView(title: "",USER_ARRIVE_FROM_STATUS:""));

                                      //TalentNavigation().pushTo(context,Aadhar_Verification());

                                      TalentAnimationNavigation().pushBottomToTop(context, Aadhar_Verification(verifyOTP_ModelResponse: verifyOTP_ModelResponse,));

                                      //TalentAnimationNavigation().pushBottomToTop(context, PAN_Verification());

                                    }
                                    else if(actionType==CJJoiningProfile_UpdateBankDetails)
                                    {
                                      //TalentNavigation().pushTo(context, KYC_details_Add_Edit());
                                      TalentNavigation().pushTo(context, TEC_BankInfoVerify(verifyOTP_ModelResponse: verifyOTP_ModelResponse,));


                                    }
                                    else if(actionType==CJJoiningProfile_UpdateDocuments)
                                    {
                                      //TalentNavigation().pushTo(context, Profile_Document());
                                      CJSnackBar(context, "comming soon");
                                    }
                                    else
                                    {

                                    }

                                  },
                                  label: Text(
                                    "Click Here",

                                    style: TextStyle(
                                        fontWeight: bold_FontWeight,
                                        fontSize: medium_FontSize,fontFamily: robotoFontFamily),
                                  ),
                                  icon: Image.asset(
                                      doubleRightArrow_White_Icon),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(top:35),
                        Image(
                            image: AssetImage("${cjJoiningObj.logoIcon}"),
                            width: 70,
                            height: 70),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
  );
}

