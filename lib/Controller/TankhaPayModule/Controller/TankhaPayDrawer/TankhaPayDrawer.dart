
//import 'dart:js';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Controller/LoginView/Controller/LoginOptionController.dart';
import 'package:contractjobs/Controller/LoginView/Controller/LoginViewController.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/RichText/RichTextClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//import 'package:qr_flutter/qr_flutter.dart';

import '../../../../Constant/CJAppFlowConstants.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../CustomView/CircleAvatar/CircleAvatar.dart';
import '../../../../Services/AESAlgo/Keys.dart';
import '../../../../Services/AESAlgo/encrypt.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceKey.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../Services/Messages/Message.dart';
import '../../../JoiningProfile/JoiningProfileModelClass/EmployeeKYCStatusModelClass.dart';
import '../../../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../TankhaPayPinNumber/TankhaPaySet4DigitPin.dart';
import '../TankhaPayBenefits/ThankhaPayViewBenefits/CommonViewTextClass.dart';
//import '../TankhaPayBenefits/ThankhaPayViewBenefits/ViewHtmlFileOnMobile.dart';
//import '../TankhaPayBenefits/ThankhaPayViewBenefits/ViewHtmlFileOnWeb.dart';
import '../ThankhaPayLeftSlider/FAQ/TankhaPayFAQ.dart';
import '../ThankhaPayLeftSlider/FAQ/TankhaPayFAQTabs.dart';
import '../ThankhaPayLeftSlider/Support/TankhaPayHelpSupport.dart';
import '../ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfile.dart';
import '../ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfileChild.dart';

class TankhaPayDrawer extends StatelessWidget
{
   const TankhaPayDrawer({Key? key,  this.liveModelObject,}) : super(key: key);
   //final selectRegistrationType;
   final VerifyOTP_ModelResponse? liveModelObject;

  static const borderColor= Color(0xffD3D3D3);
  static const buttonborderColor= Color(0xffCCCBCB);

   static BuildContext? context;

    @override
  Widget build(BuildContext context)
  {
    context=context;

    return Drawer(
      child: SingleChildScrollView(scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              icon: Icon(Icons.close),
              onPressed: ()
              {
                Navigator.pop(context);
              },
              iconSize: 30,
            ),
            buildHeader(context,liveModelObject!),
           // bannerHeader(context),
            buildMenuItems(context,getTheCompletedEmpCodeByLiveObject(liveModelObject!),liveModelObject!.data!.jsId,liveModelObject!.data!.empName,liveModelObject!),
          ],
        ),
      ),
    );
  }



}

Widget bannerHeader(BuildContext context)
{
  return Container(
    child:  Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(Employer_Icon_Slider_StateBanner,height: 100,),
            ),
          ],
        ),

        SizedBox(
          height: 5,
        ),
      ],
    ),
    //),
  );
}
/*---------------camera and gallery functionality start-------------*/
/*Text getProfileName(String? userName)
{
  return Text(
    userName != "" && userName != null
        ? userName.toUpperCase()
        : "",
    style: TextStyle(fontSize: 50),
  );
}*/
Widget buildHeader(BuildContext context,VerifyOTP_ModelResponse modelObject)
{

  var empName=modelObject.data?.empName;
  if(empName=="" || empName==null)
    {
      empName="";
    }
  var mobile=modelObject.data?.empMobile;
  if(mobile=="" || mobile==null)
  {
    mobile="";
  }
  var panCard=modelObject.data?.empPancardNumber;
  if(panCard=="" || panCard==null)
  {
    panCard="";
  }
  var emailId=modelObject.data?.empEmail;

  if(emailId=="" || emailId==null)
  {
    emailId="";
  }

  var imageURL=modelObject.data?.empPhotoPath;

  print("show the imageURL $imageURL");
  print("show the empName $empName");

  var employeeName=getProfileEmpName(empName);

/*

  print("show empName name: $empName");
  print("show mobile name: $mobile");
  print("show panCard name: $panCard");
  print("show emailId name: $emailId");*/

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
              /* Expanded(
                flex: 1,
                child: Image.asset(Wipro_Icon),
              ),*/
              /*Stack(children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  child: imageURL == null || imageURL==""
                      ? getProfileName(employeeName)
                      :  Image.network(
                    imageURL!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ]),*/

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
//
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
                            child: Text(empName,
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
                    labelText('Mobile No:',  mobile),
                    labelText('PAN:',  panCard),
                    flexibleLabelTextEmail('Email:',  emailId),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: 15,
          )
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

RichText labelText(String label, String astrick)
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
         /* WidgetSpan(
              child: SizedBox(
                width: 3, // your of space
              )),*/
//
          TextSpan(
            text: astrick,
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
Widget buildMenuItems(BuildContext context,String empCode,String jsId,String empName,VerifyOTP_ModelResponse liveModelObject)
{
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: darkGreyColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          //menuItems(Talent_Name_SettingDrawer, Talent_Icon_SettingDrawer,context),
          menuItems(Talent_Name_ProfileDrawer, user_TankhaPay_Icon,context,empCode,jsId,empName),
          getPadding(),
        /*  menuItems(Talent_Name_SetPinDrawer, TankhaPay_SetPin_Icon,context,empCode,jsId,empName),
          getPadding(),*/
          menuItems(Talent_Name_FAQDrawer, faq_TankhaPay_Icon,context,empCode,jsId,empName),
          getPadding(),
          /*menuItems(Talent_Name_ChatDrawer, Talent_Icon_ChatDrawer,context),
          getPadding(),*/
          menuItems(Employer_Name_HelpAndSupportDrawer, help_TankhaPay_Icon,context,empCode,jsId,empName),
          getPadding(),
          /*menuItems(Employer_Name_PaymentSettingsDrawer, Employer_Icon_PaymentSettingsDrawer,context),
          getPadding(),*/
          menuItems(Talent_Name_TermsOfUseDrawer, Talent_Icon_TermsOfUseDrawer,context,empCode,jsId,empName),
          getPadding(),
          menuItems(Talent_Name_PrivacyPolicyDrawer, Talent_Icon_PrivacyPolicyDrawer,context,empCode,jsId,empName),
          getPadding(),
         /* menuItems(Talent_Name_VersionDrawer, Talent_Icon_VersionDrawer,context,empCode,jsId,empName),
          getPadding(),*/


          changePinMenuItems(Common_Name_ChangePinTab, Employer_Icon_PinChange,context,liveModelObject),
          getPadding(),

          menuItems(Talent_Name_LogoutDrawer, logout_TankhaPay_Icon,context,empCode,jsId,empName)
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


GestureDetector changePinMenuItems(String title,String image,BuildContext context,VerifyOTP_ModelResponse liveObject)
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
      TalentNavigation().pushTo(context, TankhaPaySet4DigitPin(verifyOTP_ModelResponse: liveObject,employerMobileNo: "",userArriveFrom: "EmployeeDrawer",));
    }

  },);

}
GestureDetector menuItems(String title,String image,BuildContext context,String empCode,String jsId,String empName)
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
    if(title==Talent_Name_ProfileDrawer)
      {
        TalentNavigation().pushTo(context, TankhaPayProfile(completedEmpCode: empCode,jsId: jsId,));
      }
    else if(title==Employer_Name_HelpAndSupportDrawer)
    {
      TalentNavigation().pushTo(context, TankhaPayHelpSupport(completedEmpCode: empCode,empName: empName,));
    }
    else if(title==Talent_Name_TermsOfUseDrawer)
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
    else if(title==Talent_Name_FAQDrawer)
    {
       TalentNavigation().pushTo(context, TankhaPayFAQTabs());
    }
    else if(title==Talent_Name_LogoutDrawer)
      {
        SharedPreference.setTankhaPay_PinNumber("");
        TalentNavigation().pushTo(context, LoginOptionController());

      }
//
  },);

}

view(BuildContext context,String fileName,String viewTitle)
{

  TalentNavigation().pushTo(context, CommonViewTextClass(showFileName:fileName,titleName: viewTitle,));

}
