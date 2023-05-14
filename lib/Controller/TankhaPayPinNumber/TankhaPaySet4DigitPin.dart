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
import '../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../JoiningProfile/TEC_JoiningProfileDashboard.dart';
import '../LoginView/Controller/LoginOptionController.dart';
import '../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../Talents/TalentNavigation/TalentNavigation.dart';
import 'TankhaPayPinMethod.dart';


class TankhaPaySet4DigitPin extends StatefulWidget
{
  TankhaPaySet4DigitPin({Key? key, this.verifyOTP_ModelResponse, this.employerMobileNo, this.userArriveFrom}) : super(key: key);

  final VerifyOTP_ModelResponse? verifyOTP_ModelResponse;
  final String? employerMobileNo;
  final String? userArriveFrom;

  @override
  _TankhaPaySet4DigitPin createState() => _TankhaPaySet4DigitPin();

}

class _TankhaPaySet4DigitPin extends State<TankhaPaySet4DigitPin> {

  String fourDigitPinNumber="";
  String headingType="Generate 4 digit pin";
  String showErrorMessage="Enter 4 digit  pin";

  TextEditingController textEditingController = TextEditingController();

  String checkUserType="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("show the decrypted pin mobile number ${getDecryptedData("b4VMbaU+POPFhjBAMexr/XytXMg+R7oT3yJbl4D1fA0=")}");
    getUserType();
  }
  getUserType()
  {
    SharedPreference.getTankhaPay_UserType().then((userType){
      checkUserType=userType;

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CJAppBarBgBlueForHTMLView("", appBarBlock: AppBarBlock(appBarAction: ()
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
      //
      print("show the checkUserType $checkUserType");
      if(checkUserType=="Employee")
        {
          //use for the employee
          createBodyWebApi_Save4DigitPinApiRequest(createTheTankhaPayEmployeePin(widget.verifyOTP_ModelResponse!.data!.empMobile,fourDigitPinNumber));
        }
      else
        {
          //use for the employer employerMobileNo 15-2-2023

          createBodyWebApi_EmployerSave4DigitPinApiRequest(createTheEmployerPin(widget.employerMobileNo!,fourDigitPinNumber));
        }
    }
    else
    {
      Method.snackBar_OkText(context, "Enter 4 digit  pin");
    }
  }

  /*------------------14-2-2023 start-----------------*/
  createBodyWebApi_Save4DigitPinApiRequest(String employeePinNumber)
  {
    print("show 1the request2");

    var mapObject=getCJHub_Set4DigitPin_RequestBody(employeePinNumber);
    serviceRequestForSave4DigitPinApiRequest(mapObject,getEncryptedData(employeePinNumber));
  }
  serviceRequestForSave4DigitPinApiRequest(Map mapObj,String empPinNum)
  {
    print("show 1the request2");
    print("show the request object $mapObj");
    ///
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.setTankhaPay_4DigitPinNumber,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();

          print("show the success response");

          CJTalentCommonModelClass commonObject=success as CJTalentCommonModelClass;
          CJSnackBar(context,commonObject!.message as String);

          /*---------14-2-2023 start-------------*/

          SharedPreference.setTankhaPay_PinNumber(empPinNum);
          widget.verifyOTP_ModelResponse!.data!.empPin=empPinNum;

          if(widget.userArriveFrom=="EmployeeDrawer")
          {
            //user arrive from the left drawer means change the pin number
            Navigator.pop(context);

            setState(() {
              textEditingController.text="";
              fourDigitPinNumber="";
            });

          }
          else
          {
            //user arrive from the TankhaPayTermsandConditions
            TalentNavigation().pushTo(context, TEC_JoiningProfileDashboard(verifyOTP_ModelResponse: widget.verifyOTP_ModelResponse,));

          }
          /*---------14-2-2023 end-------------*/


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
  /*------------------14-2-2023 end-----------------*/

  /*------------------15-2-2023 start-----------------*/
  createBodyWebApi_EmployerSave4DigitPinApiRequest(String employerPinNumber)
  {
    print("show 1the request decrypted data ${getDecryptedData("Z82Jnsa/1RfVI2Cq47RSkv4/YxhxHWjYGvjE63tebEk=")}");

    var mapObject=getEmployer_Set4DigitPin_RequestBody(employerPinNumber);
    serviceRequestForEmployerSave4DigitPinApiRequest(mapObject,getEncryptedData(employerPinNumber));
  }
  serviceRequestForEmployerSave4DigitPinApiRequest(Map mapObj,String empPinNum)
  {
    print("show 1the request2");
    print("show the request object $mapObj");
    ///
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_SetEmployer_4DigitPinNumber,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          CJTalentCommonModelClass commonObject=commonResponse as CJTalentCommonModelClass;

          CJSnackBar(context,commonObject!.message as String);
          SharedPreference.setTankhaPay_PinNumber(empPinNum);

          if(widget.userArriveFrom=="EmployerDrawer")
            {
              //user arrive from the employer left drawer means change the pin number
              Navigator.pop(context);
              setState(() {
                textEditingController.text="";
                fourDigitPinNumber="";
              });
            }
          else
            {
              //user arrive from the Employer_NewCongratulations
              TalentNavigation().pushTo(context, LoginOptionController());
            }

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
//
  /*------------------15-2-2023 end-----------------*/

}