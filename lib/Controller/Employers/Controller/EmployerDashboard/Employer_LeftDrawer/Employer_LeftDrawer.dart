
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/CustomView/RichText/RichTextClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../CustomView/CircleAvatar/CircleAvatar.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceKey.dart';
import '../../../../LoginView/Controller/LoginOptionController.dart';
import '../../../../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../../../../TankhaPayModule/Controller/TankhaPayBenefits/ThankhaPayViewBenefits/CommonViewTextClass.dart';
import '../../../../TankhaPayModule/Controller/ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfileChild.dart';
import '../../../../TankhaPayPinNumber/TankhaPaySet4DigitPin.dart';
import '../../Employer_NewDashboard/Employer_NewProfile/Employer_NewProfile.dart';
import '../../Employer_NewDashboard/Employer_NewWorkPlace/Employer_NewWorkPlaceAttendance/Employer_NewWorkPlaceCreateLeaveTemplate.dart';
import '../../Employer_NewDashboard/Employer_NewWorkPlace/Employer_NewWorkPlaceAttendance/Employer_NewWorkPlaceLeaveSettingAttendance.dart';
import '../../Employer_NewDashboard/Employer_PayoutSetting/Employer_PayoutSetting.dart';
import '../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'Employer_Contact_Card.dart';
//
class EmployerNavigation_Drawer extends StatelessWidget
{
  const EmployerNavigation_Drawer({Key? key, this.liveModelObj}) : super(key: key);
  final Employer_VerifyMobileNoModelClass? liveModelObj;

  static const borderColor= Color(0xffD3D3D3);
  static const buttonborderColor= Color(0xffCCCBCB);

  @override
  Widget build(BuildContext context)
  {
    context=context;

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            IconButton(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              icon: Icon(Icons.close),
              onPressed: ()
              {
                Navigator.pop(context);
              },
              iconSize: 30,
            ),
            buildHeader(context,liveModelObj!),

            buildMenuItems(context,liveModelObj!),

            bannerHeader(context,liveModelObj!.supportNumber),
          ],
        ),
      ),
    );
  }
}

Widget bannerHeader(BuildContext context,String supportNo)
{
  return Employer_Contact_Card(supportNo:supportNo ,);
}
Widget buildHeader(BuildContext context,Employer_VerifyMobileNoModelClass liveObject)
{

  var userType=liveObject.userType;

  var empName=liveObject.employerName;
  if(empName=="" || empName==null)
  {
    empName="";
  }
  var companyName=liveObject.companyName;
  if(companyName=="" || companyName==null)
  {
    companyName="";
  }


  var panNo=liveObject.panNo;
  if(panNo=="" || panNo==null)
  {
    panNo="";
  }

  var gstNO=liveObject.gstinNo;
  if(gstNO=="" || gstNO==null)
  {
    gstNO="";
  }

  var emailId=liveObject.employerEmail;

  if(emailId=="" || emailId==null)
  {
    emailId="";
  }

  var imageURL=liveObject.profilePhotoPath;
  var employeeName=getProfileEmpName(empName);


  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: darkGreyColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child:  Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [

              SizedBox(
                width: 5,
              ),

              SizedBox(child:  CircleAvatar(
                radius: 40,
                child: imageURL == null || imageURL==""
                    ? getProfileName(employeeName)
                    :  ClipOval(child: Image.network(
                  imageURL!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),),
              ),),
              SizedBox(
                width: 5,
              ),

              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              userType==kEmployer_USERTYPE_Business?companyName:empName,
                              style: TextStyle(
                                overflow: TextOverflow.visible,
                                fontSize: medium_FontSize,
                                fontWeight: bold_FontWeight,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          //Image.asset(Verification_Icon),
                          ImageIcon(
                            AssetImage(Verification_Icon),
                            color: Color(0xff38B9FB),
                            size: medium_FontSize,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    userType==kEmployer_USERTYPE_Business?labelText('GSTIN:', gstNO):Container(),
                    labelText('PAN:', panNo),
                    flexibleLabelTextEmail(
                        'Email:', emailId),
                  ],
                ),
              ),
            ],
          ),


          SizedBox(
            height: 25,
          ),
        ],
      ),
    ),
  );
}
Padding flexibleLabelTextEmail(String label, String astrick) {
  return Padding(
    padding: const EdgeInsets.only(right: 16.0),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: small_FontSize,
            fontWeight: FontWeight.bold,
            color: blackColor,
            fontFamily: viewHeadingFontfamily,
          ),
        ),
        SizedBox(
          width: 3,
        ),
        Flexible(
          child: Text(
            astrick,
            style: TextStyle(
              overflow: TextOverflow.visible,
              color: Colors.black.withOpacity(0.9),
              fontWeight: textFieldFontWeightType,
              fontSize: small_FontSize,
              fontFamily: viewHeadingFontfamily,
            ),
          ),
        )
      ],
    ),
  );
}

RichText labelText(String label, String Value)
{
  return RichText(
    text: TextSpan(
        text: label,
        style: TextStyle(
          fontSize: small_FontSize,
          fontWeight: FontWeight.bold,
          color: blackColor,
          fontFamily: viewHeadingFontfamily,
        ),
        children: [
          WidgetSpan(
              child: SizedBox(
                width: 3, // your of space
              )),
          TextSpan(
            text: Value,
            style: TextStyle(
              color: Colors.black.withOpacity(0.9),
              fontWeight: textFieldFontWeightType,
              fontSize: small_FontSize,
              fontFamily: viewHeadingFontfamily,
            ),
          )
        ]),
  );
}
Widget buildMenuItems(BuildContext context,Employer_VerifyMobileNoModelClass liveObject)
{
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: darkGreyColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
        /*  menuItems(Talent_Name_SettingDrawer, Talent_Icon_SettingDrawer,context),
          getPadding(),*/
          /*menuItems(Talent_Name_ChatDrawer, Talent_Icon_ChatDrawer,context),
          getPadding(),*/
         /* menuItems(Employer_Name_HelpAndSupportDrawer, Employer_Icon_HelpAndSupportDrawer,context),
          getPadding(),*/
       /* leaveManagementMenuItems(Employer_Name_LeaveManagementDrawer, Employer_Icon_PaymentSettingsDrawer,context,liveObject),
          getPadding(),*/

          /* getPadding(),
          menuItems(Talent_Name_VersionDrawer, Talent_Icon_VersionDrawer,context),*/

          //Payout Setting


          profileMenu(Common_Name_ProfileTab, Employer_Icon_ProfileIconGrey,context,liveObject),

          getPadding(),
          profileMenu(Common_Name_PayoutSettingTab, Employer_Icon_ProfileIconGrey,context,liveObject),

          getPadding(),
          changePinMenuItems(Common_Name_ChangePinTab, Employer_Icon_PinChange,context,liveObject),

          getPadding(),
          menuItems(Talent_Name_TermsOfUseDrawer, Talent_Icon_TermsOfUseDrawer,context),
          getPadding(),
          menuItems(Talent_Name_PrivacyPolicyDrawer, Talent_Icon_PrivacyPolicyDrawer,context),

          getPadding(),
          menuItems(Talent_Name_LogoutDrawer, Talent_Icon_VersionDrawer,context)

        ],
      ),
    ),
  );
}


Padding getPadding()
{
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 13),
    child: Divider(
      height: 1,
      thickness: 1,
    ),
  );
}


GestureDetector changePinMenuItems(String title,String image,BuildContext context,Employer_VerifyMobileNoModelClass liveObject)
{
  return GestureDetector(child:ListTile(
    //visualDensity: VisualDensity(horizontal: 0, vertical: -0),
    leading: ImageIcon(
      AssetImage(image),
      color: menuTextColor,
    ),
    title: Text(
      title,
      style: TextStyle(
          color: menuTextColor,
          fontFamily: robotoFontFamily,fontSize: 14
      ),
    ),
  ) ,onTap: ()
  {

    if(title==Common_Name_ChangePinTab)
    {
      //Employer_NewWorkPlaceCreateLeaveTemplate
      TalentNavigation().pushTo(context, TankhaPaySet4DigitPin(verifyOTP_ModelResponse: VerifyOTP_ModelResponse(),employerMobileNo: liveObject.employerMobile,userArriveFrom: "EmployerDrawer",));
    }

  },);

}

//
GestureDetector profileMenu(String title,String image,BuildContext context,Employer_VerifyMobileNoModelClass liveModelObj)
{
  return GestureDetector(child:ListTile(
    //visualDensity: VisualDensity(horizontal: 0, vertical: -0),
    leading: ImageIcon(
      AssetImage(image),
      color: darkGreyColor,
    ),
    title: Text(
      title,
      style: TextStyle(
          color: menuTextColor,
          fontFamily: robotoFontFamily,fontSize: 14
      ),
    ),
  ) ,onTap: ()
  {

     if(title==Common_Name_ProfileTab)
    {
      TalentNavigation().pushTo(context, Employer_NewProfile(liveModelObj: liveModelObj));
    }
    else if(title==Common_Name_PayoutSettingTab)
    {
      TalentNavigation().pushTo(context, Employer_PayoutSetting(liveModelObj: liveModelObj));

    }

  },);

}

GestureDetector menuItems(String title,String image,BuildContext context/*,Widget showView*/)
{
  return GestureDetector(child:ListTile(
    //visualDensity: VisualDensity(horizontal: 0, vertical: -0),
    leading: ImageIcon(
      AssetImage(image),
      color: menuTextColor,
    ),
    title: Text(
      title,
      style: TextStyle(
          color: menuTextColor,
          fontFamily: robotoFontFamily,fontSize: 14
      ),
    ),
  ) ,onTap: ()
  {

     if(title==Talent_Name_TermsOfUseDrawer)
    {
    view(context,kTankhaPay_Benefit_CategoryType_TermsOfUse,CJThankhaPay_TermsOfUse);
    }
    else if(title==Talent_Name_PrivacyPolicyDrawer)
    {
    view(context,kTankhaPay_Benefit_CategoryType_PrivacyPolicy,CJThankhaPay_PrivacyPolicy);
    }
    else if(title==Talent_Name_VersionDrawer)
    {
    // TalentNavigation().pushTo(context, ThankhaPayProfile());
    }
     else if(title==Talent_Name_LogoutDrawer)
    {
      SharedPreference.setTankhaPay_PinNumber("");
      TalentNavigation().pushTo(context, LoginOptionController());
    }
     else
       {

       }

  },);

}
view(BuildContext context,String fileName,String viewTitle)
{

  TalentNavigation().pushTo(context, CommonViewTextClass(showFileName:fileName,titleName: viewTitle,));

}