import 'dart:async';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CJHubCustomView/SharedPreference.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../Constant/ValidationClass.dart';
import '../../../Constant/CJAppFlowConstants.dart';
import '../../../CustomView/BoxDecoration/ContainerBoxDecoration.dart';
import '../../../CustomView/CJHubCustomView/Method.dart';
import '../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../CustomView/Messages/Validation_Messages.dart';
import '../../../CustomView/TextField/TextFieldDecoration.dart';
import '../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../Services/Messages/Message.dart';
import '../../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../Talents/ModelClasses/CJHubModelClasses/Verify_Mobile_ModelResponse.dart';
import '../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../Talents/TalentNavigation/TalentNavigation.dart';
import '../../TankhaPayModule/Controller/TankhPaySignUp/TankhaPayVerifyOTP.dart';
import '../JoiningProfileModelClass/EmployeePANVerifyModelClass.dart';
import 'UAN_Verification.dart';

class PAN_Verification extends StatefulWidget
{

  const PAN_Verification({Key? key, this.verifyOTP_ModelResponse, this.aadharVerificationStatus,}) : super(key: key);
  final VerifyOTP_ModelResponse? verifyOTP_ModelResponse;
  final String? aadharVerificationStatus;

  @override
  State<PAN_Verification> createState() => _PAN_Verification();
}

class _PAN_Verification extends State<PAN_Verification>
{
  static const raisinBlackColor = Color(0xff262626);
  static const stormGreyColor = Color(0xff838282);
  static const dimGreyColor = Color(0xff6C6C6C);
  static const forTressGreyColor = Color(0xffB8B8B8);
  static const mediumDarkGreyColor = Color(0xff636363);

  late String panNo;
  final panFormKey = GlobalKey<FormState>();

  String panStatus="",panOptedStatus="";
  bool checkPANStatus_Visibility=false;
  bool btnStatus=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   // getBasicInfo();

  }

  /*getBasicInfo()
  {
    SharedPreference.getEmpoyeePAN().then((value) => {
      panStatus=value,
      checkPANStatus(value)
      //print('show device id $value'),
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

      checkPANStatus_Visibility=false;

    });

  }*/

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
                                              panOptedStatus="Y";
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
                        elevatedButtonWithSkip(),
                        SizedBox(height: 10,)
                      ],
                    ))),
          ],
        ),
      ),
      // ),
    );
  }


  elevatedButtonWithSkip(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: SizedBox(
              height: 50,
              width: 120,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: btnStatus ? btnAction:null,

                  label:  checkPANStatus_Visibility ? Text("Next",
                    style: TextStyle(
                        fontWeight: bold_FontWeight,
                        color: whiteColor,
                        fontSize: ElevatedButtonTextFontWeight,
                        fontFamily: robotoFontFamily),
                  ):Text("Continue",
                    style: TextStyle(
                        fontWeight: bold_FontWeight,
                        color: whiteColor,
                        fontSize: ElevatedButtonTextFontWeight,
                        fontFamily: robotoFontFamily),
                  ),

                  icon: Image.asset(RightArrow_Icon,color: whiteColor),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: lightBlueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(15),
                      )),
                ),
              ),
            ),
          ),
         /*----------------17-2-2023 start-------------*/
         widget.aadharVerificationStatus==TankhaPay_Aadhaar_NR?Container():ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                shadowColor: whiteColor,
                backgroundColor: whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
            onPressed: ()
            {

            },
            child: InkWell(onTap: ()
              {
                //Navigator.pop(context);
                //reachToUANView();

                panNo="";
                panOptedStatus="N";
                createBodyWebApi_VerifyPANNOForEmployee();

              },child: Text(
              "SKIP",
              style: TextStyle(
                  fontWeight: bold_FontWeight,
                  fontSize: ElevatedButtonTextFontWeight,
                  fontFamily: robotoFontFamily,
                  color: blackColor),
            ),),
          ),
          /*----------------17-2-2023 end-------------*/

        ],
      ),
    );
  }

  btnAction()
  {
    if(checkPANStatus_Visibility)
    {
      reachToUANView();

    }else
    {
      _submit();
    }
  }

  _submit()
  {
    if (panFormKey.currentState!.validate())
    {

      createBodyWebApi_VerifyPANNOForEmployee();
    }
  }

  createBodyWebApi_VerifyPANNOForEmployee()
  {
    var mapObject=getCJHub_EmployeeKYCPAN_RequestBody(widget.verifyOTP_ModelResponse!.data!.jsId,panNo,panOptedStatus);
    serviceRequestForEmployee(mapObject);
  }
//
  /*-----------employee login web api start--------------*/
  serviceRequestForEmployee(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.verify_PAN_Number,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          print("show sucess");

          EmployeePANVerifyModelClass panVerifyModelClass=success as EmployeePANVerifyModelClass;
          if(panVerifyModelClass.statusCode==true)
          {
            CJSnackBar(context,panVerifyModelClass!.message as String);

            print("show sucess1");
            //checkPANStatus("Y");
            //SharedPreference.setEmpoyeePAN("Y");
            reachToUANView();
          }

        }, talentFailureBlock:<T>(failure)
        {
          //SharedPreference.setEmpoyeePAN("N");

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
  reachToUANView()
  {
    TalentNavigation().pushTo(context, UAN_Verification(verifyOTP_ModelResponse: widget.verifyOTP_ModelResponse,));

  }
}
