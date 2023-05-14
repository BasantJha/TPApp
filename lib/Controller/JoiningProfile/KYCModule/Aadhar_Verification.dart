import 'dart:async';

import 'package:checkdigit/checkdigit.dart';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CJSnackBar/CJSnackBar.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../Constant/CJAppFlowConstants.dart';
import '../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../CustomView/BoxDecoration/ContainerBoxDecoration.dart';
import '../../../CustomView/CJHubCustomView/Method.dart';
import '../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../Services/Messages/Message.dart';
import '../../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../Talents/TalentNavigation/TalentNavigation.dart';
import '../JoiningProfileModelClass/EmployeeAadhaarSendOTPModelClass.dart';
import '../JoiningProfileModelClass/EmployeePANVerifyModelClass.dart';
import 'PAN_Verification.dart';

class Aadhar_Verification extends StatefulWidget {

  const Aadhar_Verification({Key? key, this.verifyOTP_ModelResponse, this.employeeAadharArriveFrom,}) : super(key: key);
  final VerifyOTP_ModelResponse? verifyOTP_ModelResponse;
  final String? employeeAadharArriveFrom;

  @override
  State<Aadhar_Verification> createState() => _Aadhar_Verification();
}

class _Aadhar_Verification extends State<Aadhar_Verification>
{
  static const raisinBlackColor = Color(0xff262626);
  static const dimGreyColor = Color(0xff6C6C6C);
  static const forTressGreyColor = Color(0xffB8B8B8);
  TextEditingController aadharcontrollerone = TextEditingController();
  TextEditingController aadharcontrollertwo = TextEditingController();
  TextEditingController aadharcontrollerthree = TextEditingController();
  bool isvisibleAadharNumber = true;
  String aadharnumber = " ";

  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  FocusNode nodeThree = FocusNode();

  FocusNode nodeoneotp = FocusNode();
  FocusNode nodetwootp = FocusNode();
  FocusNode nodethreeotp = FocusNode();
  FocusNode nodefourotp = FocusNode();
  FocusNode nodefiveotp = FocusNode();
  FocusNode nodesixotp = FocusNode();
  String showErrorMessage="";
  bool btnStatus=false;

  EmployerAadhaarSendOTPModelClass? aadhaarSendOTPModelClass;
  String aadhaarOTP="";

  @override
  void dispose() {
    super.dispose();

    nodeOne.dispose();
    nodeTwo.dispose();
    nodeThree.dispose();
    nodeoneotp.dispose();
    nodetwootp.dispose();
    nodethreeotp.dispose();
    nodefourotp.dispose();
    nodefiveotp.dispose();
    nodesixotp.dispose();
  }

  bool visibility_EnterOTPUI = false;

  int start = 60;
  bool wait = true;
  bool resendotp = false;

  var completeAadhaarNo="";
  var checkHitApiStatus=1;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: CJAppBar(getTalent_VerifyYourAadharNumberTitle, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),
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
   // double topSpace = MediaQuery.of(context).size.height - 360;
    double topSpace=1;
    // print("show the top object $topSpace");

    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            Container(
                decoration: containerRoundedDecoration,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: mainUILeftRightPadding,
                      right: mainUILeftRightPadding,
                      top: mainUILeftRightPadding),
                  child: Column(children: [
                    Center(
                      child: getViewHintTextBlue(getKYC_AadhaarHint),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          Text(
                            "Aadhaar Number",
                            style: TextStyle(
                                fontSize: small_FontSize,
                                fontFamily: robotoFontFamily,
                                color: raisinBlackColor,
                                fontWeight: semiBold_FontWeight),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: AadhaarInputView(
                                      controller: aadharcontrollerone,
                                      FocusNodeno: nodeOne,
                                      FocusNodeforward: nodeTwo,
                                      FocusNobackward: nodeOne)),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: AadhaarInputView(
                                      controller: aadharcontrollertwo,
                                      FocusNodeno: nodeTwo,
                                      FocusNodeforward: nodeThree,
                                      FocusNobackward: nodeOne)),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: AadhaarInputView(
                                      controller: aadharcontrollerthree,
                                      FocusNodeno: nodeThree,
                                      FocusNodeforward: nodeThree,
                                      FocusNobackward: nodeTwo)),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  height: 50,
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(bottom: 20.0),
                                    child: IconButton(
                                      onPressed: ()
                                      {
                                        setState(()
                                        {
                                          isvisibleAadharNumber =
                                          !isvisibleAadharNumber;
                                        });
                                      },
                                      icon: Icon(
                                        isvisibleAadharNumber
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: dimGreyColor,
                                      ),
                                    ),
                                  ))
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
                            padding: EdgeInsets.only(left: 10),
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
                        PinCodeTextField(
                            appContext: context,
                            length: 6,
                            cursorColor: lightBlueColor,
                            textStyle: TextStyle(
                                fontSize: medium_FontSize,
                                color: Color(0xff6C6C6C),
                                fontWeight: bold_FontWeight,
                                fontFamily: robotoFontFamily),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (String value)
                            {
                              aadhaarOTP=value;
                              if(aadhaarOTP.length==6)
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
                              print("show the otp $aadhaarOTP");
                            },
                            pinTheme: PinTheme(fieldHeight: 45,
                                fieldWidth: 35,
                                shape: PinCodeFieldShape.underline,
                                inactiveColor: darkGreyColor,
                                activeColor: lightBlueColor),
                          ),

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

                                          createBodyWebApi_SendAadhaarOTPForEmployee();
//
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
                    elevatedButtonBottomBar(),
                  ]),
                )),
          ],
        ),
      ),
    );
  }
  Widget AadhaarInputView({FocusNodeno, FocusNodeforward, FocusNobackward, required TextEditingController controller})
  {
    return Container(
      height: 70,
      child: TextField(
        controller: controller,
        obscureText: isvisibleAadharNumber,
        keyboardType: TextInputType.number,
        maxLength: 4,
        autofocus: true,
        focusNode: FocusNodeno,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value)
        {
          if (value.length == 4)
          {
            FocusScope.of(context).requestFocus(FocusNodeforward);
          }
          validateToTheAadhaarNumber();
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: " ",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
        //style: TextStyle(fontSize: 15),
      ),
    );
  }
  validateToTheAadhaarNumber()
  {
    completeAadhaarNo = aadharcontrollerone.text +
        aadharcontrollertwo.text +
        aadharcontrollerthree.text;

    if(verhoeff.validate(completeAadhaarNo))
    {
      setState(() {
        showErrorMessage="";
        if (completeAadhaarNo.length == 12)
        {
          checkHitApiStatus=1;
          btnStatus=true;
        }
      });
    }
    else
    {
      setState(() {
        showErrorMessage="Enter Valid Aadhaar Number";
        btnStatus=false;
        checkHitApiStatus=1;

      });
    }
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



  elevatedButtonBottomBar()
  {
    return Container(color: whiteColor,child:Padding(padding:
    EdgeInsets.only(
        bottom: elevatedButtonBottomPadding,top: elevatedButtonTopPadding),

        child:Container(height: ElevatedButtonHeight,width: ElevatedButtonWidth,color: whiteColor,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ElevatedButtonBgBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ) // NEW
              ),
              onPressed: btnStatus ? sendAadhaarOTP :null,
              child: Text(
                "Continue >>",
                style: TextStyle(fontWeight:bold_FontWeight,fontSize: ElevatedButtonTextFontWeight,fontFamily: robotoFontFamily),
              ),
            ))));
  }

  sendAadhaarOTP()
  {
    if(checkHitApiStatus==1) {
      if (completeAadhaarNo.length == 12) {
        createBodyWebApi_SendAadhaarOTPForEmployee();
      }
      else {
        CJSnackBar(context, "Enter Valid Aadhaar Number");
      }
    }else if(checkHitApiStatus==2)
      {
        createBodyWebApi_VerifyAadhaarOTPForEmployee();
      }
    else
      {
        CJSnackBar(context, "server error!");
      }
  }

  createBodyWebApi_SendAadhaarOTPForEmployee()
  {
    var mapObject=getCJHub_EmployeeKYCAadharSendOTP_RequestBody(widget.verifyOTP_ModelResponse!.data!.jsId,completeAadhaarNo);
    serviceRequestForSendAadhaarOTPEmployee(mapObject);
  }
  serviceRequestForSendAadhaarOTPEmployee(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.verify_Aadhaar_Number,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          print("show sucess");

           aadhaarSendOTPModelClass=success as EmployerAadhaarSendOTPModelClass;
          if(aadhaarSendOTPModelClass?.statusCode==true)
          {
            print("show sucess1");
            setState(()
            {
              visibility_EnterOTPUI = true;
              btnStatus=false;
            });
          }

        }, talentFailureBlock:<T>(failure)
        async {
          //SharedPreference.setEmpoyeePAN("N");

          EasyLoading.dismiss();
          print("show failure");

          setState(()
          {
            visibility_EnterOTPUI = false;
          });
          CJTalentCommonModelClass commonObject= failure as CJTalentCommonModelClass;
          String? message=commonObject?.message;

          if (message==null || message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            /*----------17-2-2023 START--------*/
            if(commonObject.aadharVerificationStatus==TankhaPay_Aadhaar_NR)
            {
              await EmployeeAadharNotResponding().showBottomSheetAadharSkipMethod(context,message!,widget.verifyOTP_ModelResponse,widget.employeeAadharArriveFrom!);

            }
            else
            {
              CJSnackBar(context,commonObject!.message as String);
            }
            /*----------17-2-2023 END--------*/
          }
        }, talentHandleExceptionBlock: <T>(handleException)
        async {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= handleException as CJTalentCommonModelClass;
          String? message=commonObject?.message;

          if (message==null || message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {

            /*----------17-2-2023 START--------*/
            if(commonObject.aadharVerificationStatus==TankhaPay_Aadhaar_NR)
            {
              await EmployeeAadharNotResponding().showBottomSheetAadharSkipMethod(context,message!,widget.verifyOTP_ModelResponse,widget.employeeAadharArriveFrom!);

            }
            else
            {
              CJSnackBar(context,commonObject!.message as String);
            }
            /*----------17-2-2023 END--------*/

          }

        }
        ));
  }

  createBodyWebApi_VerifyAadhaarOTPForEmployee()
  {
    var aadhaarClientId=aadhaarSendOTPModelClass?.data?.clientId;
    var mapObject=getCJHub_EmployeeKYCAadharVerifyOTP_RequestBody(aadhaarClientId!,aadhaarOTP,widget.verifyOTP_ModelResponse!.data!.jsId,widget.verifyOTP_ModelResponse!.data!.empMobile,completeAadhaarNo);
    serviceRequestForVerifyAadhaarOTPEmployee(mapObject);
  }
  serviceRequestForVerifyAadhaarOTPEmployee(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.verify_Aadhaar_OTP,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          print("show sucess");

          EmployerAadhaarSendOTPModelClass aadhaarSendOTPModelClass=success as EmployerAadhaarSendOTPModelClass;
          if(aadhaarSendOTPModelClass.statusCode==true)
          {
            print("show sucess1");

            CJSnackBar(context,aadhaarSendOTPModelClass!.message as String);

            if(widget.employeeAadharArriveFrom==TankhaPay_EmployeeHome)
              {
                Navigator.pop(context);
              }
            else
              {
                TalentNavigation().pushTo(context, PAN_Verification(verifyOTP_ModelResponse: widget.verifyOTP_ModelResponse,));
              }

          }

        }, talentFailureBlock:<T>(failure)
        async {
          //SharedPreference.setEmpoyeePAN("N");

          print("aadhaar api 3");

          EasyLoading.dismiss();
          print("show failure");

          CJTalentCommonModelClass commonObject= failure as CJTalentCommonModelClass;
          String? message=commonObject?.message;

          if (message==null || message=="")
          {
            CJSnackBar(context, "server  error!");
          }else {
            /*----------17-2-2023 START--------*/

            print("aadhaar api 33");

            if(commonObject.aadharVerificationStatus==TankhaPay_Aadhaar_NR)
            {
              print("aadhaar api 333");

              await EmployeeAadharNotResponding().showBottomSheetAadharSkipMethod(context,message!,widget.verifyOTP_ModelResponse,widget.employeeAadharArriveFrom!);

            }
            else
            {
              CJSnackBar(context,commonObject!.message as String);
            }
            /*----------17-2-2023 END--------*/
          }
        }, talentHandleExceptionBlock: <T>(handleException)
        async {
          EasyLoading.dismiss();
          CJTalentCommonModelClass commonObject= handleException as CJTalentCommonModelClass;
          var message=commonObject?.message;

          print("aadhaar api 4");

          if (message==null || message=="")
          {
            CJSnackBar(context, "server  error!");
          }else {

            print("aadhaar api 44");
//
            /*----------17-2-2023 START--------*/
            if(commonObject.aadharVerificationStatus==TankhaPay_Aadhaar_NR)
            {
              print("aadhaar api 444");


              String? userArriveFrom="";
              if(widget.employeeAadharArriveFrom=="" || widget.employeeAadharArriveFrom==null)
                {
                  userArriveFrom="";
                }
              else
                {
                  userArriveFrom=widget.employeeAadharArriveFrom;
                }


              await EmployeeAadharNotResponding().showBottomSheetAadharSkipMethod(context,message,widget.verifyOTP_ModelResponse,userArriveFrom!);

            }
            else
            {
              CJSnackBar(context,commonObject!.message as String);
            }
            /*----------17-2-2023 END--------*/

          }

        }));
  }


}
class EmployeeAadharNotResponding
{
  Future<Future> showBottomSheetAadharSkipMethod(BuildContext context,String message,VerifyOTP_ModelResponse? liveModelObj,String employeeAadharArriveFrom)
  async {

    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context)
      {
        return Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                color: Colors.transparent,
                // padding: EdgeInsets.only(top: topSpace),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: mainUILeftRightPadding,
                          bottom: mainUILeftRightPadding),
                      child: FloatingActionButton(
                        onPressed: () => Navigator.pop(context),
                        backgroundColor: Colors.white,
                        child: Image(
                            image: AssetImage(TankhaPay_Icon_CloseCrossIcon)),
                      ),
                    ),
                  ],
                ),
              ),
              /*-----use below--*/
              Container(
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      )),
                  child: SizedBox(
                    // height: 530,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Wrap(
                          direction: Axis.vertical,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [

                            SizedBox(height: 20,),
                            Text(
                              "Aadhar Verification",
                              style: TextStyle(
                                  color: blackColor,
                                  fontSize: 20,
                                  fontWeight: semiBold_FontWeight,fontFamily: robotoFontFamily
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                          ],
                        ),//

                        Container(padding: EdgeInsets.only(left: 20,right: 20),child: Row(children:
                        [Flexible(child: Text(message,
                          style: TextStyle(overflow: TextOverflow.visible,
                            color: blackColor,
                            fontSize: medium_FontSize,
                            fontWeight: FontWeight.w500,
                          ),textAlign: TextAlign.center,
                        ))],),),


                        Container(padding: EdgeInsets.only(left: 20,right: 20,bottom: 30,top: 30),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                          InkWell(onTap: ()
                          {
                            Navigator.pop(context);

                          },child: Text(
                            "Try Again",
                            style: TextStyle(
                                color: darkBlueColor,
                                fontWeight: bold_FontWeight,fontSize: large_FontSize
                            ),
                          ),),
                          InkWell(onTap: ()
                          {
                            if(employeeAadharArriveFrom==TankhaPay_EmployeeHome)
                              {
                                Navigator.pop(context);
                              }
                            else
                              {
                                TalentNavigation().pushTo(context, PAN_Verification(verifyOTP_ModelResponse: liveModelObj,aadharVerificationStatus: TankhaPay_Aadhaar_NR,));
//
                              }


                          },child: Text(
                            "Skip for now",
                            style: TextStyle(decoration: TextDecoration.underline,
                                color: blackColor,
                                fontWeight: bold_FontWeight,fontSize: large_FontSize
                            ),
                          ),)

                        ],),)
//

                      ],
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

}

