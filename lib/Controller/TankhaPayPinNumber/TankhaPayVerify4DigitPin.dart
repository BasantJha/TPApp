import 'dart:convert';
import 'dart:ui';

import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/CustomView/CJSnackBar/CJSnackBar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
//import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart'as http;
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../Services/AESAlgo/encrypt.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../Services/Messages/Message.dart';
import '../../Constant/CJAppFlowConstants.dart';
import '../../CustomView/AlertView/Alert.dart';
import '../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../Employers/Controller/Employer_KYC/Employer_JoinerHome.dart';
import '../Employers/Controller/Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../Employers/Controller/Employer_NewSignUp/Employer_SignUpNewBusiness.dart';
import '../Employers/Controller/Employer_TabBarController/Employer_TabBarController.dart';
import '../JoiningProfile/TEC_JoiningProfileDashboard.dart';
import '../LoginView/Controller/LoginOptionController.dart';
import '../LoginView/Controller/LoginViewController.dart';
import '../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../Talents/TalentNavigation/TalentNavigation.dart';
import '../TankhaPayModule/Controller/TankhPaySignUp/TankhaPayTermsandConditions.dart';
import '../TankhaPayModule/Controller/TankhaPayTabBarController/TankhaPay_TabBarController.dart';
import 'TankhaPayPinMethod.dart';
import 'TankhaPaySet4DigitPin.dart';

/*
void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff00BFFF)
  ));
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CJ Hub',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: TankhaPayVerify4DigitPin(title: 'CJ Hub'),
    );
  }
}*/
class TankhaPayVerify4DigitPin extends StatefulWidget
{

  TankhaPayVerify4DigitPin({Key? key}) : super(key: key);

  @override
  _TankhaPayVerify4DigitPin createState() => _TankhaPayVerify4DigitPin();

}

class _TankhaPayVerify4DigitPin extends State<TankhaPayVerify4DigitPin> {

  String fourDigitPinNumber="";
  String headingType="Enter 4 digit pin";
  String showErrorMessage="Enter 4 digit  pin";

  bool generatePin_Visibility=true;

  String txt_regeneratePin="Forgot Pin";

  TextEditingController textEditingController = TextEditingController();
  String mobileNo="",checkUserType="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadBasicData();
  }
  loadBasicData()
  {
    //print("show the decrypted pin mobile number ${getDecryptedData("b4VMbaU+POPFhjBAMexr/XytXMg+R7oT3yJbl4D1fA0=")}");

    SharedPreference.getTankhaPay_PinNumber().then((mobileNumber) =>  {
    mobileNo=mobileNumber,
      print("show the mobileNumber mobileNumber $mobileNumber")
  });

    SharedPreference.getTankhaPay_UserType().then((userType)=>{
      checkUserType=userType,
      print("show the  checkUserType $checkUserType")

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CJAppBarBgBlueWithoutBackButton("", appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show 1the action 1type");
          Navigator.pop(context);
        })),

        backgroundColor: Colors.white,


        body: WillPopScope(
            child: Responsive(
              mobile: mainFunction_UI(),
              tablet: Center(
                child: Container(
                  width: flutterWeb_tabletWidth,
                  child: mainFunction_UI(),
                ),
              ),
              desktop: Container(
                width: flutterWeb_desktopWidth,
                child: mainFunction_UI(),
              ),
            ),
            onWillPop: ()
            {
              return  Message.alert_dialogAppExit(context);

            }
        )

    );
  }

  Column mainFunction_UI()
  {
    return  Column(
      children: [

        CirclesBackground(
          circles: getCircleInfoForHome,
          child: ListTile(
            title: Text(
              getCJHUB_SetFourDigitPinNumberTitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: largeExcel_FontSize,fontFamily: robotoFontFamily,fontWeight: bold_FontWeight,color: whiteColor),
            ),
          ),
        ),

        SizedBox(
          height: 50,
        ),

        create_SetHeadingContainer(),
        create_PinBox(),

        generatePin_Visibility==true?create_GenerateContainer():Container(),

        create_height(),
        create_Button(),

        //getTheCustomColumn()
      ],
    );

//
  }

  /*-------------start 05-06-2022--------------*/
  Center create_SetHeadingContainer(){
    return Center(
      child:  Container(
        width: 300,
        // color: Colors.yellow,
        padding: const EdgeInsets.only(left: 30,right: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(headingType,
              style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
            ),            ],
        ),
      ),
    );
  }
  /*------------end 05-06-2022--------------------*/

  Container create_PinBox(){
    return Container(

      width: MediaQuery.of(context).size.width*1,
      // color: Colors.lightGreen,
      padding: const EdgeInsets.only(left: 20,right: 20),

      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          PinCodeTextField(
            length: 4,
            obscureText: true,
            autoFocus: true,
            // animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 50,
              activeFillColor: Colors.white,
            ),
            animationDuration: const Duration(milliseconds: 300),
            // backgroundColor: Colors.blue.shade50,
            enableActiveFill: true,
            controller: textEditingController,
            onCompleted: (v)
            {
              if(fourDigitPinNumber=="" || fourDigitPinNumber==null)
              {
                Method.snackBar_OkText(context, showErrorMessage);
              }else
              {
                checkEnterInputNumber();
              }

            },
            onChanged: (output)
            {
              setState(() {
                fourDigitPinNumber=output;
              });
            },
            beforeTextPaste: (text) {
              return true;
            },
            appContext: context,
          ),
        ],
      ),
    );
  }

  Center create_GenerateContainer()
  {
    return Center(
      child: Container(
        width: 300,
        // color: Colors.yellow,
        padding: const EdgeInsets.only(left: 5,right: 30,top: 10),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: txt_regeneratePin,recognizer: TapGestureRecognizer()
                    ..onTap = ()
                    {
                      /* setState(() {
                         headingType="Generate 4 digit pin";
                         generatePin_Visibility=false;
                       });*/

                      TalentNavigation().pushTo(context, LoginOptionController());

                    },
                    style: TextStyle(color: primaryColor,fontSize: 15,fontWeight: FontWeight.bold),

                  ),
                ],
              ),
            ),

          ],
        ),

      ),
    );
  }

  Padding create_Button(){
    return Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              elevation: 0.0,
              borderRadius: BorderRadius.circular(17.0),
              color: darkBlueColor,
              child:MaterialButton(
                  minWidth: 250,
                  height: 50,
                  padding: EdgeInsets.only(left:20,right: 20),
                  onPressed: () {

                    if(fourDigitPinNumber=="" || fourDigitPinNumber==null)
                    {

                      Method.snackBar_OkText(context, showErrorMessage);

                    }else
                    {
                      checkEnterInputNumber();
                    }

                  },
                  child: Text('Confirm',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,fontSize: 18))

              ),
            ),
          ],
        )
    );
  }

  SizedBox create_height(){
    return SizedBox(
      height: 30,
    );
  }

  checkEnterInputNumber()
  {
    if(fourDigitPinNumber.length==4)
    {
      if(mobileNo != "")
        {
          if(checkUserType=="Employee")
            {
              //use for employee
              String getMobileNo=getDecryptedTankhaPayMobileNo(mobileNo);
              createBodyWebApi_Verify4DigitPinApiRequest(createTheTankhaPayEmployeePin(getMobileNo,fourDigitPinNumber));
            }
          else
            {
              //use for employer
              String getMobileNo=getDecryptedEmployerMobileNo(mobileNo);
              createBodyWebApi_EmployerVerify4DigitPinApiRequest(createTheEmployerPin(getMobileNo,fourDigitPinNumber));

            }
        }
    }
    else
    {
      Method.snackBar_OkText(context, "Enter 4 digit  pin");
    }
  }

  /*-----------use for employee 14-2-2023 start-----------*/
  createBodyWebApi_Verify4DigitPinApiRequest(String employeePinNumber)
  {
    var mapObject=getCJHub_Verify4DigitPin_RequestBody(employeePinNumber);
    serviceRequestForVerify4DigitPinApiRequest(mapObject);
  }
  serviceRequestForVerify4DigitPinApiRequest(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");
    ///
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.verifyTankhaPay_4DigitPinNumber,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {

          EasyLoading.dismiss();
          VerifyOTP_ModelResponse  verifyOTP_ModelResponse=success as VerifyOTP_ModelResponse;
          if(verifyOTP_ModelResponse?.statusCode==true)
          {

            String checkECStatus=verifyOTP_ModelResponse!.data!.ecStatus;
            if(checkECStatus==CJJOB_ECSTATUS)
            {
              TalentNavigation().pushTo(context, TankhaPay_TabBarController(liveModelObject: verifyOTP_ModelResponse,));
            }
            else if(checkECStatus==CJJOB_TECSTATUS)
            {

              //TankhaPayTermsandConditions
              if(verifyOTP_ModelResponse!.data!.termsConditionsAccepted=="N")
              {
                //use for terms and conditions N then employee reach to the TankhaPayTermsandConditions
                TalentNavigation().pushTo(context, TankhaPayTermsandConditions(verifyOTP_ModelResponse: verifyOTP_ModelResponse,));

              }
              else
              {
                /*----------------14-2-2023 start-----------------*/
                //use for terms and conditions Y then employee reach to the TEC_JoiningProfileDashboard
                //TalentNavigation().pushTo(context, TEC_JoiningProfileDashboard(verifyOTP_ModelResponse: verifyOTP_ModelResponse,));

                String employeePinNumber=verifyOTP_ModelResponse!.data!.empPin;
                if(employeePinNumber=="" || employeePinNumber==null)
                {
                  TalentNavigation().pushTo(context, TankhaPaySet4DigitPin(verifyOTP_ModelResponse: verifyOTP_ModelResponse,employerMobileNo: "",));
                }else
                {
                  TalentNavigation().pushTo(context, TEC_JoiningProfileDashboard(verifyOTP_ModelResponse: verifyOTP_ModelResponse,));
                }

                /*----------------14-2-2023 end-----------------*/

              }
            }
            else
            {

            }

          }

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();
          CJTalentCommonModelClass commonObject= failure as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }
        }, talentHandleExceptionBlock: <T>(handleException)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= handleException as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }

        }));
  }
  /*-----------use for employee 14-2-2023 end-----------*/


  /*---------------use for employer 15-2-2023 start-------------------*/

  createBodyWebApi_EmployerVerify4DigitPinApiRequest(String employeePinNumber)
  {
    var mapObject=getEmployer_Verify4DigitPin_RequestBody(employeePinNumber);
    serviceRequestForEmployerVerify4DigitPinApiRequest(mapObject);
  }
  serviceRequestForEmployerVerify4DigitPinApiRequest(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");
    ///
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_VerifyEmployer_4DigitPinNumber,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          CJTalentCommonModelClass commonObject=commonResponse as CJTalentCommonModelClass;
          Employer_VerifyMobileNoModelClass modelObject=modelResponse as Employer_VerifyMobileNoModelClass;

          checkTheEmployerStatus(commonObject,modelObject);


        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
//
          CJTalentCommonModelClass commonObject=commonResponse as CJTalentCommonModelClass;

          print("show the verify message ${commonObject.message}");
          if (commonObject?.message==null || commonObject?.message=="")
          {
            CJSnackBar(context, "server  error!");
          }else
          {
            CJSnackBar(context, commonObject.message!);
          }

        }));
  }


  checkTheEmployerStatus(CJTalentCommonModelClass commonModelClass,Employer_VerifyMobileNoModelClass modelObject)
  {

//
      var registrationStatus=modelObject.employerStatus!;
      var registrationType=modelObject.signupFlag!;
      var mobileNo=modelObject.employerMobile!;
      var message=commonModelClass.message!;


      print("show the verify mobile no $mobileNo");

      print("show the registration type $registrationStatus");

      if (registrationStatus == kEmployer_STATUS_SIGNUP &&
          registrationType == kEmployer_FLAG_SU) {

        TalentNavigation().pushTo(
            context, Employer_SignUpNewBusiness(mobileNo: mobileNo));
      }
      else if (registrationStatus == kEmployer_STATUS_SIGNUP &&
          registrationType == kEmployer_FLAG_BI) {
        /*--show the pending status(show the alert message and text type BLUE color)----*/
        Navigator.pop(context,[LoginViewController(employeeRoleType: "", navigationTitle: "", title: "", subTitle: "")]);
        showDialog(context: context, builder: (_)=>failedDialogMethod(context,message,blackColor));

      }
      else if (registrationStatus == kEmployer_STATUS_AV) {
        /*--manage the account verify  status(user fill the KYC)----*/


        TalentNavigation().pushTo(context, Employer_JoinerHome(liveModelObj: modelObject,));

        showDialog(context: context, builder: (_)=>successDialogMethod(context,message));

        print("show the step 4");
      }
      else if (registrationStatus == kEmployer_STATUS_KYC ||
          registrationStatus == kEmployer_STATUS_CD ||
          registrationStatus == kEmployer_STATUS_EA) {
        /* --USER REACH TO THE Employer joiner home manage the status(2,3,4)----*/

        TalentNavigation().pushTo(context, Employer_JoinerHome(liveModelObj: modelObject,));
        print("show the step 4");
      }
      else if (registrationStatus == kEmployer_STATUS_REJECT) {
        /* --when employer  account rejected then(show the alert message and text type red color)----*/
        Navigator.pop(context,[LoginViewController(employeeRoleType: "", navigationTitle: "", title: "", subTitle: "")]);
        showDialog(context: context, builder: (_)=>failedDialogMethod(context,message,redColor));

      }
      else if (registrationStatus >= kEmployer_STATUS_SP) {
        /* --employer login successfully then user reach to the main dashboard----*/
        TalentNavigation().pushTo(
            context, Employer_TabBarController(liveModelObj: modelObject,));
      }
      else {
        print("show the load data");
        alertViewWithoutAction(context, message, redColor);
      }

  }

 /*---------------use for employer 15-2-2023 end-------------------*/

//
}