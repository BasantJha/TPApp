import 'dart:async';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../Constant/ValidationClass.dart';
import '../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../CustomView/CustomRow/AstricRow.dart';
import '../../../../CustomView/HintWidget/HintMessage.dart';
import '../../../../CustomView/TextField/TextFieldDecoration.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../Services/Messages/Message.dart';
import '../../../JoiningProfile/JoiningProfileModelClass/EmployeeAadhaarSendOTPModelClass.dart';
import '../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../Employer_KYCModelClass/Employer_AadhaarSendOTPModelClass.dart';
import '../Employer_KYCModelClass/Employer_GSTSendOTPModelClass.dart';
import '../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'Employer_JoinerHome.dart';

class EmployerGST_Verification extends StatefulWidget {
  const EmployerGST_Verification({Key? key, this.liveModelObj,}) : super(key: key);

  final Employer_VerifyMobileNoModelClass? liveModelObj;



  @override
  State<EmployerGST_Verification> createState() => _EmployerGST_Verification();
}

class _EmployerGST_Verification extends State<EmployerGST_Verification> {
  static const mediumDarkGreyColor = Color(0xff636363);
  static const forTressGreyColor = Color(0xffB8B8B8);

   String gstNo="";
  final employerGSTFormKey = GlobalKey<FormState>();

  bool visibility_EnterOTPUI = false;
  int start = 60;
  bool wait = true;
  bool resendotp = false;

  var checkHitApiStatus=1;
  bool btnStatus=false;
  String showErrorMessage="";
  String gstOTP="";
  Employer_GSTSendOTPModelClass?  employer_gstSendOTPModelClass;

  final GlobalKey gstGlobalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: CJAppBar(getTalent_VerifyYourGSTNumberTitle, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),
      backgroundColor: whiteColor,
      body: getResponsiveUI(),
    );
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

  MainfunctionUi()
  {
    //double topSpace = MediaQuery.of(context).size.height - 390;
    // print("show the top object $topSpace");

    return SingleChildScrollView(
      child: Container(
        color: whiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            Container(
                child:Padding(
            padding: EdgeInsets.only(
            left: mainUILeftRightPadding,
            right: mainUILeftRightPadding,
            top: mainUILeftRightPadding),

          child: Form(
                    key: employerGSTFormKey,
                    // autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        SizedBox(height:60),
                        /*Center(
                          child: getViewHintTextBlue(getEmployer_GSTHint),
                        ),
                        SizedBox(
                          height: 40,
                        ),*/
                        //getKYCAstricRow('GST Number'),

                        Padding(padding: EdgeInsets.only(left: 20),child: getAstricRowWithInfo("GSTIN",context,gstGlobalKey,getGSTIN_Hint),),

                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20,right: 20),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        inputFormatters: <TextInputFormatter>[
                                          UpperCaseTxt()
                                        ],
                                        textCapitalization:
                                        TextCapitalization.characters,
                                        validator: validateToGst,
                                        onChanged: ( val)
                                        {
                                          checkHitApiStatus=1;
                                          if (employerGSTFormKey.currentState!.validate())
                                          {
                                            // TalentNavigation().pushTo(context, UAN());
                                            setState(() {
                                              btnStatus=true;
                                              gstNo = val;
//
                                            });
                                          }
                                          else
                                            {
                                              setState(() {
                                                btnStatus=false;
                                                gstNo = val;

                                              });
                                            }

                                        },
                                        maxLength: 15,
                                        cursorColor: mediumDarkGreyColor,
                                        style: TextStyle(),
                                        decoration: getTextFieldDecorationWithPrefixIcon(gstn_Grey_Icon,'Enter GSTIN'),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            )),

                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(showErrorMessage,style: TextStyle(color: Colors.red,fontSize: 12),),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: visibility_EnterOTPUI,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 30),
                                child: Row(
                                  children: [
                                    Text(
                                      "Enter OTP",
                                      style: TextStyle(
                                          fontSize: small_FontSize,
                                          fontFamily: robotoFontFamily,
                                          color: blackColor,
                                          fontWeight: semiBold_FontWeight),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text("OTP Was Sent on Registered Mobile Number",style: TextStyle(
                                    color: darkGreyColor,
                                    fontFamily: robotoFontFamily,
                                    fontWeight: normal_FontWeight,
                                    fontSize: medium_FontSize,
                                    letterSpacing: 0,
                                    height: 1),),
                              ),
                              /*Expanded(child: */PinCodeTextField(
                                appContext: context,
                                length: 4,
                                cursorColor: lightBlueColor,
                                textStyle: TextStyle(
                                    fontSize: large_FontSize,
                                    color: Color(0xff6C6C6C),
                                    fontWeight: normal_FontWeight,
                                    fontFamily: robotoFontFamily),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (String value)
                                {
                                  gstOTP=value;
                                  if(gstOTP.length==4)
                                  {
                                    setState(() {
                                      checkHitApiStatus=2;
                                      btnStatus=true;
                                    });
                                  }
                                  else
                                  {
                                    setState(() {
                                      checkHitApiStatus=2;
                                      btnStatus=false;
                                    });
                                  }
                                  print("show the otp $gstOTP");
                                },
                                pinTheme: PinTheme(fieldHeight: 45,
                                    fieldWidth: 35,
                                    shape: PinCodeFieldShape.underline,
                                    inactiveColor: darkGreyColor,
                                    activeColor: lightBlueColor),
                              )/*)*/,
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Visibility(
                                          visible: wait,
                                          child: Container(
                                            // color: Colors.greenAccent,
                                            width: 80,
                                            height: 25,
                                            child: Align(
                                                alignment:
                                                Alignment.centerRight,
                                                child: Text(
                                                  'Expires in $start Second',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color:
                                                      forTressGreyColor,
                                                      fontFamily:
                                                      robotoFontFamily,
                                                      fontSize:
                                                      medium_FontSize,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                      bold_FontWeight,
                                                      height: 1),
                                                )),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                        visible: resendotp,
                                        child: Container(
                                          height: 30,
                                          child: TextButton(
                                            onPressed: ()
                                            {
                                              // var aadharnumber = aadharcontrollerone.text.toString() + aadharcontrollertwo.text.toString() + aadharcontrollerthree.text.toString();
                                              // print("Aadhar Number : {$aadharnumber}");

                                              setState(()
                                              {
                                                start = 60;
                                                wait = true;
                                                resendotp = false;
                                              });
                                              startTimer();

                                              createBodyWebApi_SendGSTOTPForEmployer();

                                            },
                                            child: Text(
                                              "Resend OTP",
                                              style: TextStyle(
                                                color: darkBlueColor,
                                                fontSize: medium_FontSize,
                                                fontWeight: bold_FontWeight,
                                                fontFamily: robotoFontFamily,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        elevatedButtonWithoutSkip(),
                      ],
                    )
                ))
            ),

          ],
        ),
      ),
      // ),
    );
  }
  void startTimer()
  {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
          resendotp = true;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  elevatedButtonWithoutSkip()
  {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 15),
          SizedBox(
            height: 50,
            width: 160,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                // elevation: 0,
                // shadowColor: whiteColor,
                  backgroundColor: lightBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
              ),
              onPressed: btnStatus ? sendGSTOTP:null,
              child: Text(
                "Submit",
                style: TextStyle(
                    fontWeight: bold_FontWeight,
                    color: whiteColor,
                    fontSize: ElevatedButtonTextFontWeight,
                    fontFamily: robotoFontFamily),
              ),
            ),

          ),
          // ),
        ],
      ),
    );
  }

  sendGSTOTP()
  {
    if(checkHitApiStatus==1) {
      if (gstNo.length == 15)
      {
        createBodyWebApi_SendGSTOTPForEmployer();
      }
      else {
        CJSnackBar(context, "Enter Valid Aadhaar Number1");
      }
    }else if(checkHitApiStatus==2)
    {
      createBodyWebApi_VerifyGSTOTPForEmployer();
    }
    else
    {
      CJSnackBar(context, "server error!");
    }
  }

  _submit()
  {
    if (employerGSTFormKey.currentState!.validate())
    {
      // TalentNavigation().pushTo(context, UAN());
    }
  }

  createBodyWebApi_SendGSTOTPForEmployer()
  {//
    var mapObject=getEmployer_KYC_GSTSendOTP_RequestBody(widget.liveModelObj?.employerId!,gstNo);
    serviceRequestForSendGSTOTPEmployer(mapObject);
  }
  serviceRequestForSendGSTOTPEmployer(Map mapObj)
  {
    print("show 1the1 request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_GSTSendOTP,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          print("show sucess");

            employer_gstSendOTPModelClass=modelResponse as Employer_GSTSendOTPModelClass;

          CJTalentCommonModelClass commonModelClass=commonResponse as CJTalentCommonModelClass;
          if(commonModelClass?.statusCode==true)
          {
            print("show sucess1");
            setState(()
            {
              visibility_EnterOTPUI = true;
              btnStatus=false;
            });
          }

        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          print("show failure");

          setState(()
          {
            visibility_EnterOTPUI = false;
          });
          CJTalentCommonModelClass commonModelClass=commonResponse as CJTalentCommonModelClass;

          if (commonModelClass!.message==null || commonModelClass!.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonModelClass!.message as String);
          }

        }));
  }

  createBodyWebApi_VerifyGSTOTPForEmployer()
  {
    var gstClientId=employer_gstSendOTPModelClass!.clientId;
    var mapObject=getEmployer_KYC_GSTVerifyOTP_RequestBody(gstClientId!,gstOTP,widget.liveModelObj?.employerId!,gstNo);
    serviceRequestForVerifyGSTOTPEmployer(mapObject);

  }
  serviceRequestForVerifyGSTOTPEmployer(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);


    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_GSTVerifyOTP,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          print("show sucess");

          CJTalentCommonModelClass gstOTPVerify=commonResponse as CJTalentCommonModelClass;
          if(gstOTPVerify.statusCode==true)
          {
            print("show sucess1");
            CJSnackBar(context, gstOTPVerify.message!);

            TalentNavigation().pushTo(context, Employer_JoinerHome(liveModelObj: widget.liveModelObj,));

          }


        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          print("show failure");

          CJTalentCommonModelClass gstOTPVerify=commonResponse as CJTalentCommonModelClass;
          if (gstOTPVerify.message==null || gstOTPVerify.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,gstOTPVerify.message as String);
          }

        }));
  }
}

