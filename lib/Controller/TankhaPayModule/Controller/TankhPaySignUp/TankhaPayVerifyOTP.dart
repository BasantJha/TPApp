import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import '../../../../Constant/CJAppFlowConstants.dart';
import '../../../../Constant/Constants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/AlertView/Alert.dart';
import '../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../CustomView/ButtonDecoration/CustomButtonAction.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../CustomView/ContainerView/CustomContainer.dart';
import '../../../../CustomView/RichText/RichTextClass.dart';
import '../../../../CustomView/TextField/TextFieldDecoration.dart';
import '../../../../CustomView/ViewHint/CustomViewHint.dart';
import '../../../../CustomView/ViewHint/ViewHintText.dart';
import 'package:contractjobs/Constant/ConstantIcon.dart';

import '../../../../Services/AESAlgo/EncryptedMapBody.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../Services/Messages/Message.dart';
import '../../../JoiningProfile/TEC_JoiningProfileDashboard.dart';
import '../../../Talents/ModelClasses/CJHubModelClasses/SendOTP_ModelResponse.dart';
import '../../../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../../Talents/ModelClasses/CJHubModelClasses/Verify_Mobile_ModelResponse.dart';
import '../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../../../TankhaPayPinNumber/TankhaPaySet4DigitPin.dart';
import '../TankhaPayTabBarController/TankhaPay_TabBarController.dart';
import 'TankhaPayCongratulations.dart';
import 'TankhaPayTermsandConditions.dart';
import 'package:http/http.dart'as http;

//
class TankhaPayVerifyOTP extends StatefulWidget
{
  const TankhaPayVerifyOTP({Key? key,  this.mobileNo}) : super(key: key);
  final String? mobileNo;

  @override
  State<TankhaPayVerifyOTP> createState() => _TankhaPayVerifyOTP();
}

class _TankhaPayVerifyOTP extends State<TankhaPayVerifyOTP>  {

  int start = 60;
  bool wait = true;
  bool resendOTP = false;
  String resendOTPBTN = "Resend OTP";

  static const mediumDarkGreyColor = Color(0xff636363);
  static const greyColor = Color(0xffA3A3A3);

  static const title = "By creating an account, you agree to TankhaPay's";

  Verify_Mobile_ModelResponse? verify_mobile_modelResponse;
  //SendOTP_ModelResponse? sendOTP_ModelResponse;
  VerifyOTP_ModelResponse? verifyOTP_ModelResponse;

  String deviceIPAddress="",otp="";

  bool btnStatus=false;
  String deviceId="",notificationToken="";

  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _getSignatureCode();
    _startListeningSms();
    startTimer();
    loadBasicInfo();
  }


  /*-----------auto fill otp 7-2-2023 start------------------*/
  _getSignatureCode() async
  {
    String? signature = await SmsVerification.getAppSignature();
    print("signature $signature");
  }

  /// listen sms
  _startListeningSms()
  {
    SmsVerification.startListeningSms().then((message)
    {
      setState(() {
        otp = SmsVerification.getCode(message, RegExp(r'\d+', multiLine: true));
        otpController.text = otp;
        if(otp.length == 4)
        {
          btnStatus = true;
          createBodyWebApi_VerifyOTP();
        }else
        {
          CJSnackBar(context, "Please enter the 4 digit OTP");
        }
      });
      print("OTP $otp");
    });
  }

  /*-----------auto fill otp 7-2-2023 end------------------*/

  loadBasicInfo()
  {
   /* Method.getIPAddress().then((value) => {
      userIP=value,
    });*/

    SharedPreference.getTankhaPay_NotificationToken().then((value) =>  {
      notificationToken=value,
      print('notificationToken $value'),
    });

    Method.getDeviceId().then((value) =>
    {
      deviceId = value,
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return (Scaffold(
      backgroundColor: Colors.white,
      appBar: CJAppBar(getEmployer_ViewEmployee, appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show the action type");
            Navigator.pop(context);
          })),
      body: getResponsiveUI(),
      bottomNavigationBar:getRichTextForLoginHint(title,context) ,
    ));
  }

  Responsive getResponsiveUI() {
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
        child: Padding(
          padding: EdgeInsets.only(left: mainUILeftRightPadding, right: mainUILeftRightPadding, top: 5),
          child: Column(
            children: [
              getTheTankhaPayGrayLogoContainer,
              SizedBox(height: 25,),
              Center(
                child: getViewHintTextBlue(getTalent_VerifyOTPHint),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'A text with One Time Password (OTP) has been sent to your mobile number: ${widget.mobileNo}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textFieldHeadingColor,
                    fontFamily: robotoFontFamily,
                    fontSize: small_FontSize,
                    fontWeight: normal_FontWeight,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              /*Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter OTP:',
                      style: TextStyle(
                        color: greyColor,
                        fontSize: large_FontSize,
                        fontWeight: normal_FontWeight,
                        fontFamily: robotoFontFamily,
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),*/
              Container(
                  child: TextFormField(controller: otpController,
                    cursorColor: mediumDarkGreyColor,
                    obscureText: true,
                    style: TextStyle(
                      color: textFieldHeadingColor,
                    ),
                    decoration: getTextFieldDecoration('Enter OTP'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                     maxLength: 4,
                     onChanged: (value)
                    {

                      otp=value;
                      if(otp.length==4)
                        {
                          btnStatus=true;
                        }
                      else
                        {
                          btnStatus=false;
                        }

                    },
                  )),
              SizedBox(
                height: 5,
              ),

              Container(padding: EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Visibility(
                    visible: wait,
                    child: Text('00:$start',
                        style: TextStyle(
                          fontSize: 16,
                          color: darkBlueColor,
                        )),
                  ),
                ),
              ),
              Container(padding: EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Visibility(
                    visible: resendOTP,
                    child:InkWell(onTap: ()
                      {
                        startTimer();
                        setState(()
                        {
                          start = 60;
                          wait = true;
                          resendOTPBTN = "Resend OTP";
                          resendOTP = false;
                          createBodyWebApi_SendOTP();
                        });
                      },child:Text(
                      resendOTPBTN,
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: large_FontSize,
                        fontWeight: normal_FontWeight,
                        fontFamily: robotoFontFamily,
                      ),
                    ) ,)
                 ,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              elevatedButtonBottomBar(),
              SizedBox(
                height: 30,
              ),

            ],
          ),
        ),
      ),
    );
  }

  void startTimer()
  {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer)
    {
      if (start == 0)
      {
        setState(()
        {
          timer.cancel();
          wait = false;
          resendOTP = true;
        });
      } else {
        setState(()
        {
          start--;
        });
      }
    });
  }

  Container elevatedButtonBottomBar()
  {

    return  Container(color: whiteColor,child:Padding(padding:
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
                "Proceed",
                style: TextStyle(fontWeight:bold_FontWeight,fontSize: ElevatedButtonTextFontWeight,fontFamily: robotoFontFamily),
              ),
            ))));

  }
  btnAction()
  {
    if(otp.length==4)
    {
      createBodyWebApi_VerifyOTP();
    }else
    {
      CJSnackBar(context, "Please enter the 4 digit OTP");
    }
  }

 /* sendOTP_WebApi()
  {
    Method.getDeviceId().then((value) => {

      deviceId=value,
      //print('show device id $value'),

    });

    Method.getIPAddress().then((value) => {

      deviceIPAddress=value,
      createBodyWebApi_SendOTP()

    });
  }*/
  /*--------------hit the login service request start---------------*/

  createBodyWebApi_SendOTP()
  {
    var mapObject=getCJHub_VerifyMobileNo_RequestBody(widget.mobileNo!);
    serviceRequest_SendOTP(mapObject);
  }

  serviceRequest_SendOTP(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.tankhaPayVerifyMobile_api,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          verify_mobile_modelResponse=success as Verify_Mobile_ModelResponse;
          if(verify_mobile_modelResponse?.statusCode==true)
          {

          }

        }, talentFailureBlock:<T>(failure)
        {
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

  createBodyWebApi_VerifyOTP()
  {
    var mapObject=getCJHub_VerifyOTP_RequestBody(widget.mobileNo!,otp);
    serviceRequest_VerifyOTP(mapObject);
  }
  serviceRequest_VerifyOTP(Map mapObj)
  {
    print("show 1the request12");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.tankhaPayVerifyOTP_api,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          verifyOTP_ModelResponse=success as VerifyOTP_ModelResponse;
          if(verifyOTP_ModelResponse?.statusCode==true)
          {

            SharedPreference.setTankhaPay_UserId(verifyOTP_ModelResponse!.data!.jsId);
            SharedPreference.setTankhaPay_UserType("Employee");

            /*--------14-2-2023 start-----------*/
            var checkPinNumber=verifyOTP_ModelResponse!.data!.empPin;
            if(checkPinNumber=="" || checkPinNumber==null)
              {
                SharedPreference.setTankhaPay_PinNumber("");
              }
            else
              {
                SharedPreference.setTankhaPay_PinNumber(checkPinNumber);
              }
            /*--------14-2-2023 end-----------*/

            String checkECStatus=verifyOTP_ModelResponse!.data!.ecStatus;

            if(checkECStatus==CJJOB_ECSTATUS)
            {
              TalentNavigation().pushTo(context, TankhaPay_TabBarController(liveModelObject: verifyOTP_ModelResponse,));
//
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

            saveNotificationToken(verifyOTP_ModelResponse!.data!.jsId,"Employee");

          }

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= failure as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            //CJSnackBar(context,commonObject!.message as String);

            showDialog(context: context, builder: (_)=>failedDialogMethod(context,commonObject!.message,redColor));

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
//
        }));
  }


/*--------------hit the login service request end---------------*/

  saveNotificationToken(String userId,String userType) async
  {

    var mapObj=Map();
    mapObj["user_id"]=userId;
    mapObj["user_type"]=userType;
    mapObj["device_id"]=deviceId;
    mapObj["token"]=notificationToken;

    print("show the notification map object $mapObj");

    try {
      final response = await http.post(
        Uri.parse(TankhaPay_SavePushNotificationTokenApi),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },

        body: getEncrypted_MapBody(mapObj),
      );

      print(response.statusCode);
      // //print('response.statusCode');

      if (response.statusCode == 200) {
        print(response.body);
        // //print("success");
      } else {

        print("failure");
        throw Exception('Failed to create get product.');
      }
    }
    catch (e) {
      // //print(e);
    }
  }

}
