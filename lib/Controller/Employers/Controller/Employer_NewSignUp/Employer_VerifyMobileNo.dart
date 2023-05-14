import 'dart:async';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Employers/Controller/Employer_NewSignUp/Employer_SignUpNewBusiness.dart';
import 'package:contractjobs/Controller/Talents/ModelClasses/CJTalentCommonModelClass.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:contractjobs/Services/CJEmployerService/CJEmployerServiceKey.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import '../../../../Constant/CJAppFlowConstants.dart';
import '../../../../CustomView/AlertView/Alert.dart';
import '../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../CustomView/ContainerView/CustomContainer.dart';
import '../../../../CustomView/RichText/RichTextClass.dart';
import '../../../../CustomView/TextField/TextFieldDecoration.dart';
import '../../../../Services/AESAlgo/EncryptedMapBody.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/Messages/Message.dart';
import '../../../LoginView/Controller/LoginViewController.dart';
import '../EmployerModelClasses/EmployerSignUpModelClasses/EmployerSignUpModelClass.dart';
import '../Employer_KYC/Employer_JoinerHome.dart';
import '../Employer_TabBarController/Employer_TabBarController.dart';
import 'Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'package:http/http.dart'as http;

class Employer_VerifyMobileNo extends StatefulWidget
{
  const Employer_VerifyMobileNo({Key? key, required this.mobileNo, required this.userArriveFrom}) : super(key: key);
  final String mobileNo;
  final String userArriveFrom;

  @override
  State<Employer_VerifyMobileNo> createState() => _Employer_VerifyMobileNo(mobileNo,this.userArriveFrom);

}

class _Employer_VerifyMobileNo extends State<Employer_VerifyMobileNo>
{

  static const mediumDarkGreyColor = Color(0xff636363);
  static const greyColor = Color(0xffA3A3A3);
  int start = 60;
  bool wait = true;
  //bool resendotp = false;
 // String buttonName = "Resend OTP";

  final employerVerifyOTPFormKey = GlobalKey<FormState>();
  var otpLength=4;
  var otp="",userIP="";
  bool btnStatus=false;

  String resendOTPBTN = "Resend OTP";
  bool resendOTP = false;
  static const title = "By creating an account, you agree to TankhaPay's";

  var mobileNo="";
  var userArriveFrom;

  String deviceId="",notificationToken="";

  TextEditingController otpController = TextEditingController();


  _Employer_VerifyMobileNo(String mobileNo, String userArriveFrom)
  {
    this.mobileNo=mobileNo;
    this.userArriveFrom=userArriveFrom;
  }



  @override
  void initState() {
    super.initState();

    _getSignatureCode();
    _startListeningSms();
    loadBasicInfo();
    startTimer();
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
          createBodyWebApi_SignupVerifyOTP();
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
    Method.getIPAddress().then((value) => {
      userIP=value,
    });

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

    return Scaffold( backgroundColor: Colors.white,
      appBar: CJAppBar(getEmployer_ViewEmployer, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),
      body: getResponsiveUI(),
      bottomNavigationBar:getRichTextForLoginHint(title,context) ,

    );
  }
////
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
             /* Container(
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
                        createBodyWebApi_ResendOTP();
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
      createBodyWebApi_SignupVerifyOTP();
    }else
    {
      CJSnackBar(context, "Please enter the 4 digit OTP");
    }
  }

  /*-----------employer login web api start--------------*/
  createBodyWebApi_ResendOTP()
  {
    var mapObject=getEmployer_VerifyMobileNO_RequestBody(mobileNo,userIP);
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
          CJSnackBar(context, (commonResponse as CJTalentCommonModelClass).message!);
//

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

        }));
  }
/*--------------hit the login service request end---------------*/

  /*--------------hit the login service request start---------------*/
  createBodyWebApi_SignupVerifyOTP()
  {
    // Map getEmployer_SignUpInfo_RequestBody(String fullName,String mobileNo,String emailId,String pinCode,String deviceType,String userIP)

    var mapObject=getEmployer_VerifyOTP_RequestBody(mobileNo,otp,userIP);
    serviceRequest_SignUpVerifyOTP(mapObject);
  }

  serviceRequest_SignUpVerifyOTP(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_EmployerVerifyOTP,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          CJTalentCommonModelClass commonObject=commonResponse as CJTalentCommonModelClass;
          Employer_VerifyMobileNoModelClass modelObject=modelResponse as Employer_VerifyMobileNoModelClass;

          SharedPreference.setTankhaPay_UserId(modelObject.employerId);
          SharedPreference.setTankhaPay_UserType("Employer");

          /*--------15-2-2023 start-----------*/
          var checkPinNumber=modelObject!.pinNumber;
          if(checkPinNumber=="" || checkPinNumber==null)
          {
            SharedPreference.setTankhaPay_PinNumber("");
          }
          else
          {
            SharedPreference.setTankhaPay_PinNumber(checkPinNumber);
          }
          /*--------15-2-2023 end-----------*/

          checkTheEmployerStatus(commonObject,modelObject);

          saveNotificationToken(modelObject.employerId,"Employer");


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

  /*-----------22-12-2022 start--------------*/

  checkTheEmployerStatus(CJTalentCommonModelClass commonModelClass,Employer_VerifyMobileNoModelClass modelObject)
  {

    if(userArriveFrom==CJEMPLOYER_ArriveFROM_LOGIN) {

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
    else if(userArriveFrom==CJEMPLOYER_ArriveFROM_SIGNUP)
    {
      TalentNavigation().pushTo(context, Employer_SignUpNewBusiness(mobileNo: mobileNo));
      print("show the step 5");
    }
    else
    {

    }
  }

/*-----------14-12-2022 end--------------*/

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
