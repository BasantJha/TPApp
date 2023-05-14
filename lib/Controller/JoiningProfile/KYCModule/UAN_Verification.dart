import 'dart:async';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/JoiningProfile/TEC_JoiningProfileDashboard.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CJSnackBar/CJSnackBar.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../Constant/ValidationClass.dart';
import '../../../Constant/CJAppFlowConstants.dart';
import '../../../CustomView/BoxDecoration/ContainerBoxDecoration.dart';
import '../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../CustomView/Messages/Validation_Messages.dart';
import '../../../CustomView/TextField/TextFieldDecoration.dart';
import '../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../Services/CJTalentsService/CJTalentServiceKey.dart';
import '../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../Services/Messages/Message.dart';
import '../../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../Talents/TalentNavigation/TalentNavigation.dart';
import '../JoiningProfileModelClass/EmployeePANVerifyModelClass.dart';
import '../JoiningProfileModelClass/EmployeeUANVerifyModelClass.dart';
//

enum SingingCharacter { panStatusNO, panStatusYES }

class UAN_Verification extends StatefulWidget
{
  const UAN_Verification({Key? key, this.verifyOTP_ModelResponse, this.employeeUANArriveFrom,}) : super(key: key);
  final VerifyOTP_ModelResponse? verifyOTP_ModelResponse;
  final String? employeeUANArriveFrom;

  @override
  State<UAN_Verification> createState() => _UAN_Verification();
}

class _UAN_Verification extends State<UAN_Verification>
{
  static const raisinBlackColor = Color(0xff262626);
  static const stormGreyColor = Color(0xff838282);
  static const dimGreyColor = Color(0xff6C6C6C);
  static const forTressGreyColor = Color(0xffB8B8B8);
  static const mediumDarkGreyColor = Color(0xff636363);

  String uan="";
  final uanFormKey = GlobalKey<FormState>();

  bool checkUANStatus_Visibility=false;
  String showErrorMessage="";
  bool btnStatus=true;

  SingingCharacter _character = SingingCharacter.panStatusYES;
  SingingCharacter _gstCharacter = SingingCharacter.panStatusYES;

  var uanTextEditController=TextEditingController();
  bool checkUANStatus=true;
  String uanStatusValue="Y";

  double uanHeight=450;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
    double topSpace = MediaQuery.of(context).size.height - uanHeight;
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
                    key: uanFormKey,
                    // autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        SizedBox(height:30),
                        Center(
                          child: getViewHintTextBlue(getTalent_UANHint),
                        ),

                        SizedBox(height:10),

                        Center(
                          child: getViewHintTextDarkGray(getTalent_UANSubHint),
                        ),

                        SizedBox(height:15),

                        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                          Radio(
                            value: SingingCharacter.panStatusNO,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value)
                            {
                              setState(()
                              {
                                _character = value!;
                                print("show the business value $_character");

                                uanHeight=390;

                                  checkUANStatus=false;
                                  btnStatus=true;

                                uanTextEditController.text="";

                                //reachToJoiningProfileView();

                              });
                            },
                          ),
                          Text('No',style: TextStyle(fontSize: medium_FontSize,fontFamily: robotoFontFamily),),
                          SizedBox(width:25),

                          Radio(
                            value: SingingCharacter.panStatusYES,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value)
                            {
                              setState(()
                              {
                                _character = value!;

                                checkUANStatus=true;
                                uanHeight=450;

                                /*--------17-2-2023 start------*/
                                //btnStatus=false;

                                btnStatus=true;

                                /*--------17-2-2023 end------*/


                                print("show the individaul value $_character");
                                // print("show the individaul GSTStatus $GSTStatus");

                              });
                            },
                          ),
                          Text('Yes',style: TextStyle(fontSize: medium_FontSize,fontFamily: robotoFontFamily))],),

                        SizedBox(
                          height: 40,
                        ),
                        checkUANStatus==true?Container(
                          padding: EdgeInsets.only(left: 30.0),
                          child: Row(
                            children: [
                              Text(
                                "UAN Number",
                                style: TextStyle(
                                    fontSize: small_FontSize,
                                    fontFamily: robotoFontFamily,
                                    color: raisinBlackColor,
                                    fontWeight: semiBold_FontWeight),
                              ),
                            ],
                          ),
                        ):Container(),
                        SizedBox(
                          height: 10,
                        ),
                        checkUANStatus==true?Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20,right: 16),
                                      child: TextFormField(controller: uanTextEditController,enabled: checkUANStatus ? true:false,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        keyboardType: TextInputType.number,
                                        textCapitalization:
                                        TextCapitalization.characters,
                                        validator: (value)
                                        {
                                          if (value == null || value.length == 0)
                                          {
                                            return validateMsg_UanNumber;
                                          }

                                        },
                                        onChanged: (value)
                                        {
                                          uan=value;

                                          print("show the uan no $value");
                                         /* if(UANValidatorClass().validateUAN(value!))
                                          {
                                            print("show 1the uan no true $value");
                                            setState(() {
                                              btnStatus=true;
                                            });

                                          }
                                          else
                                          {
                                            setState(() {
                                              btnStatus=false;
                                            });
                                            print("show the uan no false $value");

                                            // validateMsg_UanNumber;
                                          }*/

                                        },
                                        maxLength: 12,
                                        cursorColor: mediumDarkGreyColor,
                                        style: TextStyle(),
                                        decoration: getTextFieldDecoration('Enter UAN Number'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                /*  Visibility(visible: checkUANStatus_Visibility,child:Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0,0,0,13),
                                        child: Image(
                                            image: AssetImage(checkGreen_Icon)),
                                      )) ,),       */                         ],
                              ),
                            )):Container(height: 20,),

                        SizedBox(
                          height: 30,
                        ),
                        elevatedButtonWithSkip(),
                        SizedBox(height: 25,)
                      ],
                    ))),
          ],
        ),
      ),
      // ),
    );
  }

  elevatedButtonWithSkip()
  {
    return Container(
      //padding: EdgeInsets.all(10),
      child: Container(
          child:Container(
            height: 50,
            width: 120,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                onPressed: btnStatus ? btnAction :null,

                label:  Text("Continue",
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
          )
      ),
    );
  }


  btnAction()
  {
    if(checkUANStatus==false)
      {
        //use for UAN Number (NO)
       // reachToJoiningProfileView();
        uanStatusValue="N";
        uan="";
        createBodyWebApi_VerifyUANNOForEmployee();

      }else
        {
          print("show the uan value $uan");
          uanStatusValue="Y";
          if(uan == "")
            {
              uan=TankhaPay_UANIsOpted;
              createBodyWebApi_VerifyUANNOForEmployee();
              print("show the opted");

            }
          else
            {
              //use for UAN Number (YES)
              _submit();
              print("show the uan number");

            }

        }


  }//
  _submit()
  {
    if (uanFormKey.currentState!.validate())
    {
      if(UANValidatorClass().validateUAN(uan))
      {
        createBodyWebApi_VerifyUANNOForEmployee();
      }
      else
        {
          CJSnackBar(context, "Enter the Valid UAN Number");
        }
    }

  }

  createBodyWebApi_VerifyUANNOForEmployee()
  {
    var mapObject=getCJHub_EmployeeKYCUAN_RequestBody(widget.verifyOTP_ModelResponse!.data!.jsId,uan,widget.verifyOTP_ModelResponse!.data!.empCode,uanStatusValue);
    serviceRequestForEmployee(mapObject);
  }
//
  /*-----------employee login web api start--------------*/
  serviceRequestForEmployee(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequestFor_UANandAddress(mapObj, WebApi.verify_UANNumber_and_UpdateProfileAddress,kTankhaPay_KYCUAN_ActionValue,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          print("show sucess");

          CJTalentCommonModelClass uanVerifyModelClass=success as CJTalentCommonModelClass;
          if(uanVerifyModelClass.statusCode==true)
          {

            CJSnackBar(context,uanVerifyModelClass!.message as String);

            reachToJoiningProfileView();
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

  reachToJoiningProfileView()
  {
    if(widget.employeeUANArriveFrom==TankhaPay_EmployeeHome)
      {
        Navigator.pop(context);
      }
    else
      {
        TalentNavigation().pushTo(context, TEC_JoiningProfileDashboard(verifyOTP_ModelResponse: widget.verifyOTP_ModelResponse,));
      }

  }

}


/*elevatedButtonWithSkip1(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: SizedBox(
              height: 50,
              width: 120,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: btnStatus ? btnAction :null,

                  label:  checkUANStatus_Visibility ? Text("Next",
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
          ElevatedButton(
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
                Navigator.pop(context);
                reachToJoiningProfileView();

              },child: Text(
              "SKIP",
              style: TextStyle(
                  fontWeight: bold_FontWeight,
                  fontSize: ElevatedButtonTextFontWeight,
                  fontFamily: robotoFontFamily,
                  color: blackColor),
            ),),
          ),
        ],
      ),
    );
  }*/