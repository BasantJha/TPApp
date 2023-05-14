

import 'package:contractjobs/Constant/CJAppFlowConstants.dart';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Employers/Controller/Employer_SignUp/Employer_SignUpHome.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeeker_SignUp/JobSeeker_SignUpRole.dart';
import 'package:contractjobs/Controller/Talents/Controller/CJHubInsuranceModule/insurance_addInsurancePolicy.dart';
import 'package:contractjobs/Controller/Talents/Controller/Talent_SignUp/Talent_KYCDetails.dart';
import 'package:contractjobs/Controller/Talents/Controller/Talent_SignUp/Talent_UserProfile.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/RichText/RichTextClass.dart';
import 'package:contractjobs/CustomView/TextField/TextFieldDecoration.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceBody.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceKey.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceRequest.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceURL.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../Constant/ValidationClass.dart';
import '../../../CustomView/AlertView/Alert.dart';
import '../../../CustomView/CJHubCustomView/Method.dart';
import '../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../CustomView/ContainerView/CustomContainer.dart';
import '../../../CustomView/Method.dart';
import '../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../Services/Messages/Message.dart';
import '../../Employers/Controller/EmployerModelClasses/EmployerSignUpModelClasses/EmployerSignUpModelClass.dart';
import '../../Employers/Controller/Employer_NewSignUp/Employer_SignUpNewInfo.dart';
import '../../Employers/Controller/Employer_NewSignUp/Employer_VerifyMobileNo.dart';
import '../../JoiningProfile/TEC_JoiningProfileDashboard.dart';
import '../../Talents/ModelClasses/CJHubModelClasses/Verify_Mobile_ModelResponse.dart';
import '../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../TankhaPayModule/Controller/TankhPaySignUp/TankhaPayCongratulations.dart';
import '../../TankhaPayModule/Controller/TankhPaySignUp/TankhaPayVerifyOTP.dart';
import 'LoginOptionController.dart';

class LoginViewController extends StatefulWidget
{

   LoginViewController({required this.employeeRoleType,required this.navigationTitle, required this.title, required this.subTitle});
   final String employeeRoleType;
   final String navigationTitle;
   final String title;
   final String subTitle;

   @override
  _LoginViewController createState() => _LoginViewController(employeeRoleType,navigationTitle,title,subTitle);

}
class _LoginViewController extends State<LoginViewController>
{
   bool showRegistrationTypeVisibility=false;
   bool checkEmployerRegistrationStatus=false;

   String employeeRoleType="",navigationTitle="",title="",subTitle="";
   bool btnStatus=false;

   _LoginViewController(String employeeRoleType, String navigationTitle, String title,String subTitle)
  {
    this.employeeRoleType=employeeRoleType;
    this.navigationTitle=navigationTitle;
    this.title=title;
    this.subTitle=subTitle;

    if(employeeRoleType==CJBENEFICIARY)
    {
      showRegistrationTypeVisibility=false;
    }
    else if(employeeRoleType==CJJOBSEEKER)
    {

    }
    else if(employeeRoleType==CJJOBGIVER)
    {
      showRegistrationTypeVisibility=true;
    }
  }

   String mobileNumber="",userIP="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadBasicInfo();
  }

   loadBasicInfo()
   {
     Method.getIPAddress().then((value) => {
       userIP=value,

     });
   }
  @override
  Widget build(BuildContext context)
  {
//
   return WillPopScope(onWillPop: ()
   {
     return  Message.alert_dialogAppExit(context);

   }, child:GestureDetector(onTap: ()
     {
       dismissTheFirstResponder();
     },child: Scaffold(backgroundColor: Colors.white,

     appBar: CJAppBar(navigationTitle, appBarBlock: AppBarBlock(appBarAction: ()
     {
       print("show the action type");
       Navigator.pop(context);
     })),
     body: Responsive(
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
     ),
     //bottomNavigationBar:companyNameContainerBottomSheet() ,


   ),));
  }
   dismissTheFirstResponder()
   {
     FocusScope.of(context).requestFocus(new FocusNode());
   }

  SingleChildScrollView  MainfunctionUi()
  {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
           SizedBox(height: 40),
          getTheTankhaPayGrayLogoContainer,

          checkEmployerRegistrationStatus==true?SizedBox(height: 0):SizedBox(height: 80),
          Visibility(visible: checkEmployerRegistrationStatus,child: InkWell(onTap: ()
          {
            TalentNavigation().pushTo(context, Employer_SignUpNewInfo());
          },child:getRichTextForRegistrationEmployerNotRegister() ,)),

          Padding(
            padding:  EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  child: TextFormField(initialValue: " ",maxLength: 10,
                    obscureText: false,
                    style: TextStyle(fontSize: 18,color: Colors.black),
                   // controller: new TextEditingController(text: "+91"),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    autofocus: kIsWeb ? true : false, // auto focus set for Web and mobile (21-07-2022)
                    decoration: getLoginTextFieldDecoration(),
                    //validator: validateToMobileNo,
                    onChanged: (value)
                    {
                      int count=value.length;
                      print("show the input data $count");


                      setState(() {

                        mobileNumber=value;
                        if(mobileNumber.length==10)
                        {
                          dismissTheFirstResponder();
                          btnStatus=true;
                        }else
                        {
                          btnStatus=false;
                        }

                        //use for the employer not register
                          checkEmployerRegistrationStatus=false;

                      });


                    },
                  ),
                ),
                SizedBox(height: 10,),
                Container(child: getRichTextForLoginHint("By proceeding, you agree to TankhaPay's",context),),
                SizedBox(height: 5,),

//
               Container(color: whiteColor,child:Padding(padding:
            EdgeInsets.only(left: 1,right: 1,
            bottom: elevatedButtonBottomPadding,top: elevatedButtonTopPadding),

            child:Container(height: ElevatedButtonHeight,width: ElevatedButtonWidth,color: whiteColor,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ElevatedButtonBgBlueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ) // NEW
                  ),
                  onPressed: btnStatus ? btnAction:null,
                  child: Text(
                    "Send Code",
                    style: TextStyle(fontWeight:bold_FontWeight,fontSize: ElevatedButtonTextFontWeight,fontFamily: robotoFontFamily),
                  ),
                )))),


                Visibility(visible: showRegistrationTypeVisibility,child: InkWell(onTap: ()
                {
                  //TalentNavigation().pushTo(context, Employer_SignUpHome());
                  TalentNavigation().pushTo(context, Employer_SignUpNewInfo());

//


                },child:getRichTextForRegistration() ,))


              ],
            ),
          ),
        ],
      ),
    );
  }
   btnAction()
   {

     if(employeeRoleType==CJBENEFICIARY)
     {
       /*---------use for the Beneficiary Registration-----------*/
       //TalentNavigation().pushTo(context, Talent_UserProfile());

       /*--------Tankha Pay Verify OTP----------*/
       if(mobileNumber.length==10)
       {
         createBodyWebApi_VerifyMobileNoForEmployee();

       }
       else
       {
         CJSnackBar(context, "Please enter the 10 digit mobile number");
       }
       /*--------Tankha Pay Verify OTP----------*/

     }
     else if(employeeRoleType==CJJOBSEEKER)
     {
       /*---------use for the Jobseeker Registration-----------*/
       TalentNavigation().pushTo(context, JobSeeker_SignUpRole());
     }
     else if(employeeRoleType==CJJOBGIVER)
     {
       /*---------use for the JobGiver Registration-----------*/

       if(mobileNumber.length==10)
       {
         createBodyWebApi_EmployerVerifyMobileNo();

       }
       else
       {
         CJSnackBar(context, "Please enter the 10 digit mobile number");
       }

     }
     else
     {

     }
   }


   /*--------------hit the login service request start---------------*/

   createBodyWebApi_VerifyMobileNoForEmployee()
   {
     var mapObject=getCJHub_VerifyMobileNo_RequestBody(mobileNumber);
     serviceRequestForEmployee(mapObject);
   }

   /*-----------employee login web api start--------------*/
   serviceRequestForEmployee(Map mapObj)
   {
     print("show 1the request2");
     print("show the request object $mapObj");

     EasyLoading.show(status: Message.get_LoaderMessage);

     CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.tankhaPayVerifyMobile_api,
         cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
         {
           EasyLoading.dismiss();
           print("show the login response1");


           Verify_Mobile_ModelResponse verify_mobile_modelResponseObj=success as Verify_Mobile_ModelResponse;
           if(verify_mobile_modelResponseObj.statusCode==true)
           {
             print("show the login response2");

             SharedPreference.setTankhaPay_PinNumber("");
             TalentNavigation().pushTo(context, TankhaPayVerifyOTP(mobileNo: mobileNumber ,));
           }

         }, talentFailureBlock:<T>(failure)
         {
           EasyLoading.dismiss();

           EasyLoading.dismiss();
           CJTalentCommonModelClass commonObject= failure as CJTalentCommonModelClass;
           if (commonObject.message==null || commonObject.message=="")
           {
             CJSnackBar(context, "server 1 error!");
           }else {
             CJSnackBar(context,commonObject!.message as String);
           }
         }, talentHandleExceptionBlock: <T>(handleException)
         {
           EasyLoading.dismiss();

           CJTalentCommonModelClass commonObject= handleException as CJTalentCommonModelClass;
           if (commonObject.message==null || commonObject.message=="")
           {
             CJSnackBar(context, "server 1 error!");
           }else {
             CJSnackBar(context,commonObject!.message as String);
           }

         }));
   }

   /*-----------employer login web api start--------------*/
   createBodyWebApi_EmployerVerifyMobileNo()
   {
     var mapObject=getEmployer_VerifyMobileNO_RequestBody(mobileNumber,userIP);
     serviceRequestForEmployer(mapObject);
   }

   serviceRequestForEmployer(Map mapObj)
   {
     print("show 1the request2");
     print("show the request object $mapObj");

     EasyLoading.show(status: Message.get_LoaderMessage);

     CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_EmployerVerifyMobileNo,
         cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
         {



           EasyLoading.dismiss();
          // CJSnackBar(context, (commonResponse as CJTalentCommonModelClass).message!);

           setState(() {
             checkEmployerRegistrationStatus=false;
           });

           SharedPreference.setTankhaPay_PinNumber("");
           TalentAnimationNavigation().pushBottomToTop(context, Employer_VerifyMobileNo(mobileNo: mobileNumber,userArriveFrom: CJEMPLOYER_ArriveFROM_LOGIN,));


         }, employerFailureBlock:<T>(commonResponse,modelResponse)
         {
           EasyLoading.dismiss();

           CJTalentCommonModelClass modelObject=commonResponse as CJTalentCommonModelClass;
           print("show the verify message ${modelObject.message}");
           if (modelObject?.message==null || modelObject?.message=="")
           {
             CJSnackBar(context, "server  error!");
           }else
           {
             CJSnackBar(context, modelObject!.message!);
           }

           /*--------23-2-2023 start-----------*/
          /* if(modelObject.message.toString().contains("not registered"))
             {
               setState(() {
                 checkEmployerRegistrationStatus=true;
               });
             }*/

           if(modelObject.registrationFlag=="0")
             {
               TalentNavigation().pushTo(context, Employer_SignUpNewInfo());

             }
           /*--------23-2-2023 end-----------*/



         }));
   }
  /*--------------hit the login service request end---------------*/

}