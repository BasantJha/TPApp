import 'dart:async';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/CJHubCustomView/Method.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../../Constant/ValidationClass.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../CustomView/CustomRow/AstricRow.dart';
import '../../../../CustomView/Messages/Validation_Messages.dart';
import '../../../../CustomView/TextField/TextFieldDecoration.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../Services/Messages/Message.dart';
import '../../../JoiningProfile/JoiningProfileModelClass/EmployeePANVerifyModelClass.dart';
import '../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../Employer_KYCModelClass/Employer_PanVerifyModelClass.dart';
import '../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_AreaOfWorkModelClass.dart';
import '../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_SignUpNewBusinessModelClass.dart';
import '../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'EmployerAadhaar_Verification.dart';
import 'EmployerGST_Verification.dart';
import 'Employer_JoinerHome.dart';

class Employer_PANVerification extends StatefulWidget {
  const Employer_PANVerification({Key? key, this.liveModelObj, this.aadhaarVerificationStatus, }) : super(key: key);
  final Employer_VerifyMobileNoModelClass? liveModelObj;
  final String? aadhaarVerificationStatus;


  @override
  State<Employer_PANVerification> createState() => _Employer_PANVerification();
}

class _Employer_PANVerification extends State<Employer_PANVerification>
{
  static const raisinBlackColor = Color(0xff262626);
  static const stormGreyColor = Color(0xff838282);
  static const dimGreyColor = Color(0xff6C6C6C);
  static const forTressGreyColor = Color(0xffB8B8B8);
  static const mediumDarkGreyColor = Color(0xff636363);

   String panNo="",deviceType="",IPAddress="";
  final panFormKey = GlobalKey<FormState>();

  String panStatus="";
  bool checkPANStatus_Visibility=false;
  bool btnStatus=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBasicInfo();
  }

  getBasicInfo()
  {
    SharedPreference.getEmpoyerPAN().then((value) => {
      panStatus=value,
      checkPANStatus(value)
      //print('show device id $value'),
    });

    Method.getIPAddress().then((value) => {
      IPAddress=value,

    });
    Method.getDeviceId().then((value) => {
      deviceType=value,

    });
  }
  checkPANStatus(String panStatus)
  {
    setState(() {
      if(panStatus=="Y")
      {
        checkPANStatus_Visibility=true;
      }
      else
      {
        checkPANStatus_Visibility=false;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreyColor,
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

  MainfunctionUi() {
    double topSpace = MediaQuery.of(context).size.height - 390;
    // print("show the top object $topSpace");

    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(top: topSpace),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: mainUILeftRightPadding,
                        bottom: mainUILeftRightPadding),
                    child: FloatingActionButton(
                      onPressed: () => Navigator.pop(context),
                      backgroundColor: Colors.transparent,
                      child: Image(image: AssetImage(TankhaPay_Icon_CloseCrossIcon)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(42.0),
                      topRight: Radius.circular(42.0),
                    )),
                child: Form(
                    key: panFormKey,
                    // autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        SizedBox(height:40),
                        Center(
                          child: getViewHintTextBlue(getTalent_PANHint),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 30.0),
                          child: Row(
                            children: [
                              Text(
                                "PAN Number",
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
                                      padding: EdgeInsets.only(left: 20),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        inputFormatters: <TextInputFormatter>[
                                          UpperCaseTxt()
                                        ],
                                        textCapitalization:
                                        TextCapitalization.characters,
                                        validator: validateToPan,
                                        onChanged: (val)
                                        {

                                        if (panFormKey.currentState!.validate())
                                        {
                                          setState(() {
                                            btnStatus=true;
                                            panNo = val;

                                          });

                                        }
                                        else
                                          {
                                            setState(() {
                                              btnStatus=false;
                                              panNo = val;

                                            });
                                          }
                                        },

                                        maxLength: 10,
                                        cursorColor: mediumDarkGreyColor,
                                        style: TextStyle(),
                                        decoration: getTextFieldDecoration('Enter PAN No.'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),


                                  Visibility(visible: checkPANStatus_Visibility,child:Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0,0,0,13),
                                        child: Image(
                                            image: AssetImage(checkGreen_Icon)),
                                      )) ,),

                                ],
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        elevatedButtonWithoutSkip(),
                        SizedBox(height: 10,)
                      ],
                    ))),
          ],
        ),
      ),
      // ),
    );
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
              onPressed: btnStatus ? btnAction:null,
              child: checkPANStatus_Visibility ? Text("Next",
                style: TextStyle(
                    fontWeight: bold_FontWeight,
                    color: whiteColor,
                    fontSize: ElevatedButtonTextFontWeight,
                    fontFamily: robotoFontFamily),
              ):Text(
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

  btnAction()
  {
    if(checkPANStatus_Visibility)
    {
      //TalentNavigation().pushTo(context, EmployerGST_Verification());

      TalentNavigation().pushTo(context, EmployerAadhaar_Verification(liveModelObj: widget.liveModelObj));


    }else
    {
      _submit();
    }
  }

  _submit()
  {
    if (panFormKey.currentState!.validate())
    {
      createBodyWebApi_VerifyPANNOForEmployer();
    }
  }

  createBodyWebApi_VerifyPANNOForEmployer()
  {
    //Map getEmployer_PANVerify_RequestBody(String panNo,String mobileNo,String deviceType,String IPAddress)
     var mapObject=getEmployer_PANVerify_RequestBody(panNo,widget.liveModelObj?.employerMobile!,deviceType,IPAddress);
     serviceRequestForEmployer(mapObject);
  }
////
  /*-----------employee login web api start--------------*/
  serviceRequestForEmployer(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequestFor_EmployerSignUp(mapObj,JG_ApiMethod_EmployerCommonRegistration,kEmployer_FLAG_KYCPAN,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          Employer_PanVerifyModelClass businessModelClass=modelResponse as Employer_PanVerifyModelClass;
          if((commonResponse as CJTalentCommonModelClass).statusCode==true)
          {
            checkPANStatus("Y");

            CJSnackBar(context, (commonResponse as CJTalentCommonModelClass).message!);

           /* TalentNavigation().pushTo(context,  ShowCaseWidget(
                builder: Builder(
                  builder: (context) => EmployerGST_Verification(liveModelObj: widget.liveModelObj,),
                )));
*/

            if(widget.aadhaarVerificationStatus=="Y")
              {
                TalentNavigation().pushTo(context, Employer_JoinerHome(liveModelObj: widget.liveModelObj,));

              }else
                {
                  Navigator.pop(context);
                  TalentNavigation().pushTo(context, EmployerAadhaar_Verification(liveModelObj: widget.liveModelObj,));
                }

          }

        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          checkPANStatus("N");


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
}



