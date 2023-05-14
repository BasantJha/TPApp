import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Employers/Controller/Employer_SignUp/Employer_Business_SignUpKYC.dart';
import 'package:contractjobs/Controller/Employers/Controller/Employer_SignUp/Employer_SignUpKYC.dart';
import 'package:contractjobs/Controller/JobSeekers/ModelClasses/CJCommonResponse.dart';
import 'package:contractjobs/Controller/Talents/ModelClasses/CJTalentCommonModelClass.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:contractjobs/CustomView/TextField/TextFieldDecoration.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../Constant/ValidationClass.dart';
import '../../../../CustomView/BoxDecoration/ContainerBoxDecoration.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../CustomView/HintWidget/HintMessage.dart';
import '../../../../CustomView/Messages/Validation_Messages.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../Services/Messages/Message.dart';
import '../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../Employers/Controller/Employer_KYC/Employer_JoinerHome.dart';
import '../Employers/Controller/Employer_KYCModelClass/Employer_KYCStatusModelClass.dart';
import '../Employers/Controller/Employer_KYCModelClass/Employer_StateModelClass.dart';
import '../Employers/Controller/Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import 'TEC_JoiningProfileDashboard.dart';

class TEC_JoiningProfileUpdate extends StatefulWidget
{
  const TEC_JoiningProfileUpdate({Key? key, this.liveModelObj}) : super(key: key);
  final VerifyOTP_ModelResponse? liveModelObj;

  @override
  State<TEC_JoiningProfileUpdate> createState() => _TEC_JoiningProfileUpdate();
}
//
class _TEC_JoiningProfileUpdate extends State<TEC_JoiningProfileUpdate>
{

  static const regularFontWeight = FontWeight.w400;
  static const mediumDarkGreyColor = Color(0xff636363);

  final updateProfile_FormKey = GlobalKey<FormState>();

  List<CommonStateList>? stateList;

  late String selectedValue;

  String name="", mobileNo="",stateId="", emailId="";
  String deviceId="",IPAddress="";

  TextEditingController empName_Controller = TextEditingController();
  TextEditingController mobileNo_Controller = TextEditingController();

  double topSpaceHeight=20;
  double spaceBetweenTitleandTextField=7;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBasicInfo();

    getServiceRequest_AllStatesList();
  }
  getBasicInfo()
  {

    empName_Controller.text=widget.liveModelObj!.data!.empName;
    mobileNo_Controller.text=widget.liveModelObj!.data!.empMobile;
    name=widget.liveModelObj!.data!.empName;;
    mobileNo=widget.liveModelObj!.data!.empMobile;


    Method.getDeviceId().then((value) => {
      deviceId=value,
      //print('show device id $value'),
    });

    Method.getIPAddress().then((value) => {
      IPAddress=value,
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor: whiteColor,
      appBar:CJAppBar(getEmployee_UpdateProfile, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),
      body: getResponsiveUI(),
      bottomNavigationBar: Padding(padding: EdgeInsets.only(left: elevatedButtonLeftRightPadding,right:elevatedButtonLeftRightPadding ),
        child: elevatedButtonBottomBar(),) ,
    );
  }

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
        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
        child:Form(
          key: updateProfile_FormKey,
          // autovalidateMode: AutovalidateMode.always,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // Center(child:getViewHintTextBlue(getEmployer_KYCCompanyDetailsHint),),

              SizedBox(height: topSpaceHeight),
              getAstricRow("Name"),
              SizedBox(height: spaceBetweenTitleandTextField),
              Container(
                  child: TextFormField(enabled: false,controller: empName_Controller,
                    /*maxLength: 10,
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp(r'[a-zA-Z\s]*'), allow: true)
                    ],
                    validator: validateToName,*/
                    onChanged: ( val) {

                    },
                    keyboardType: TextInputType.text,
                    cursorColor: mediumDarkGreyColor,
                    style: TextStyle(fontSize: medium_FontSize,color: darkGreyColor),
                    decoration: getTextFieldDecorationWithDisable(""),

                  )),

              SizedBox(height: topSpaceHeight),
              getAstricRow("Mobile Number"),
              SizedBox(height: spaceBetweenTitleandTextField),
              Container(
                child: TextFormField(enabled: false,controller: mobileNo_Controller,
                 /* maxLength: 10,
                  validator: validateToMobileNo,*/
                  onChanged: ( val) {
                    setState(() {
                      mobileNo = val!;
                    });
                  },
                  // initialValue: " ",
                  style: TextStyle(fontSize: medium_FontSize,color: darkGreyColor),
                  // controller: new TextEditingController(text: "+91"),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  decoration: getTextFieldDecorationWithDisable(''),
                  // onChanged: (value)
                  // {
                  //   int count=value.length;
                  //   print("show the input data $count");
                  // },
                ),
              ),

              SizedBox(height: topSpaceHeight),
              getAstricRow("Work Location"),
              SizedBox(height: spaceBetweenTitleandTextField),
              Container(
                child:
                stateDropDown('Select State', locationGrey_Icon, validateMsg_state),
              ),

              SizedBox(height:topSpaceHeight),
              getWithoutAstricRow("Email Address (Optional)"),
              SizedBox(height: spaceBetweenTitleandTextField),
              Container(
                  child: TextFormField(
                    onChanged: (value)
                    {
                      setState(()
                      {
                        emailId = value;

                        /* if (!validateToEmailId(value.toString()))
                        {
                          //return validateMsg_email;
                          CJSnackBar(context, validateMsg_email);
                        }*/
                      });
                    },
                    /*  validator: (value)
                    {
                      if (!validateToEmailId(value.toString()))
                      {
                        return validateMsg_email;
                      }
                    },*/
                    cursorColor: mediumDarkGreyColor,
                    style: TextStyle(),
                    decoration: getTextFieldDecoration("Enter Email Address"),
                  )),
              SizedBox(height: topSpaceHeight),



            ],
          ),
        ),

      ),
    );
  }
//
  stateDropDown(String text, String icon,  String validateText)
  {
    return DropdownButtonFormField2(
      // value: val,
        isExpanded: true,
        dropdownWidth: kIsWeb==true?webResponsive_TD_Width-40:MediaQuery.of(context).size.width-50,
        dropdownMaxHeight: 200,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: Offset(-40, -15),
        decoration: decorationimage(text, icon),

        buttonPadding: const EdgeInsets.only(left: 20, right: 20),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        items: stateList?.map((item) => DropdownMenuItem<String>(
          value: item.id.toString(),
          child: Text(
            item.state!,
            style: const TextStyle(
                fontFamily: robotoFontFamily,
                color: mediumDarkGreyColor,
                fontSize: large_FontSize,
                fontWeight: regularFontWeight),
          ),
        ))
            .toList(),
        onChanged: (value)
        {
          stateId=value!;
          print("show the state name $stateId");

          FocusScope.of(context).requestFocus(FocusNode());

        },
        onSaved: (value) {
          selectedValue = value!;
        },
        validator: (value)
        {
          print("show the value $value");

          stateId=value!;


          if (value == null || value.isEmpty)
          {
            return validateText;
          }
        }
    );
  }

  InputDecoration decorationimage(String hintimage, String Icon)
  {
    return InputDecoration(
      hintText: hintimage,
      hintStyle: TextStyle(
          color: mediumDarkGreyColor,
          fontSize: large_FontSize,
          fontWeight: regularFontWeight,
          fontFamily: robotoFontFamily),
      prefixIcon: Iconimg(Icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }

  Container Iconimg(String icon) {
    return Container(
      //padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
      margin: EdgeInsets.fromLTRB(11, 11, 11, 11),
      height: 5.0,
      width: 5.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(icon,),
        ),
      ),
    );
  }


  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Update Profile", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action 111");

      submit();
    }
    )) ;

  }

  submit()
  {
    if(stateId != "") {
      if (updateProfile_FormKey.currentState!.validate()) {
        print("show the continue action ${stateId+" "+name+" "+mobileNo}");

        createBodyWebApi_UpdateEmplpoyeeProfile();
      }
      else {
        print("show the continue action 2");

        CJSnackBar(context, "Please validate to the fields");
      }
    }else
      {
        CJSnackBar(context, "Please validate to the fields");

      }

  }



  /*--------------get the all states list----------------*/

  getServiceRequest_AllStatesList()
  {
    print("show 1the request2");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().getDataServiceRequest(JG_ApiMethod_GetAllStates,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          Employer_StateModelClass employer_stateModelClass=modelResponse as Employer_StateModelClass;
          print("show the data obj ${employer_stateModelClass.commonStateList}");

          if(employer_stateModelClass.commonStateList!.length>0)
          {
            print("show the data obj ${employer_stateModelClass.commonStateList}");

            setState(() {
              stateList=employer_stateModelClass.commonStateList!;
            });
          }
          else
          {
          }
        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass modelClass=modelResponse as CJTalentCommonModelClass;
          if (modelClass?.message==null || modelClass?.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context, modelClass!.message!);
          }
        }));
  }


  /*--------------hit the company details service request start---------------*/
  createBodyWebApi_UpdateEmplpoyeeProfile()
  {
    int i=0;
    String selectedStateName="";
    for(i=0;i<stateList!.length;i++)
    {
      var searchStateId=stateList![i].id;
      if(searchStateId.toString()==stateId)
      {
        selectedStateName=stateList![i].state!;
        break;
      }
    }


    var mapObject=getCJHub_KYCUpdateEmployeeProfile_RequestBody(widget.liveModelObj!.data!.jsId,IPAddress,widget.liveModelObj!.data!.empCode,selectedStateName,emailId);
    serviceRequest_UpdateEmplpoyeeProfile(mapObject);

  }


  /*-----------employee login web api start--------------*/
  serviceRequest_UpdateEmplpoyeeProfile(Map mapObj)
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.TankhaPay_Update_EmployeeProfile,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          print("show sucess");

          CJTalentCommonModelClass commonModelClass=success as CJTalentCommonModelClass;
          CJSnackBar(context, commonModelClass.message!);

          TalentNavigation().pushTo(context, TEC_JoiningProfileDashboard(verifyOTP_ModelResponse: widget.liveModelObj ,));

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();
          print("show failure");

          CJTalentCommonModelClass commonModelClass=failure as CJTalentCommonModelClass;
          if (commonModelClass.message==null || commonModelClass.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context, commonModelClass.message!);
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
  }////

}

