import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/Talent_SignUp/Talent_VerifyBankAccountDetails.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:contractjobs/CustomView/NavigationView/NavigationView.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../Constant/ValidationClass.dart';
import '../../CustomView/CJHubCustomView/Method.dart';
import '../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../CustomView/HintWidget/HintMessage.dart';
import '../../Services/AESAlgo/encrypt.dart';
import '../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../Services/Messages/Message.dart';
import '../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import 'JoiningProfileModelClass/EmployeeBankAccountVerifyModelClass.dart';
import 'JoiningProfileModelClass/EmployeeUANVerifyModelClass.dart';
import 'TEC_BankInfoVerifyDetails.dart';
import 'TEC_JoiningProfileDashboard.dart';


class TEC_BankInfoVerify extends StatefulWidget
{
  const TEC_BankInfoVerify({Key? key, this.verifyOTP_ModelResponse}) : super(key: key);
  final VerifyOTP_ModelResponse? verifyOTP_ModelResponse;

  @override
  State<TEC_BankInfoVerify> createState() => _TEC_BankInfoVerify();

}
//
class _TEC_BankInfoVerify extends State<TEC_BankInfoVerify> {
  final tecBankInfoFormKey = GlobalKey < FormState > ();

  final accNumberController = TextEditingController();
  final ifscController = TextEditingController();
  final AccHolderNameController = TextEditingController();

  String jsId="", bankNo="", ifscCode="", fullName="", createdBy="", ipAddress="",createdById="";

  final GlobalKey ifscCodeGlobalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBasicInfo();

    //var gg=getDecryptedData("pT/6xpgYRaiJKM1K52WpPseMUqKXfLcK6BqmbaBBWAM+FIbaebH286vGAGc8cZj8qCwsZhbtv64pikSG+rreKDdMI5m1aiE2VeIZufWgfuXhM9ZZRejrdzoH2HS9HLKUgi4QcWhhVFy1eO4TzSrIKGBsm/8ujAHHVg7XbsIk4GosNHzCbk4Z1hFtiiREeSc6R+fZWDO8aRDkyF+sK/l4tg==");
    //print("show the dec data $gg");
  }

  getBasicInfo()
  {
    Method.getIPAddress().then((value) => {
      ipAddress=value,
    });
    SharedPreference.getEmpId().then((value) => {
      createdById=value,
      //print('show device id $value'),
    });
    SharedPreference.getJSId().then((value) => {
      jsId=value,
      //print('show device id $value'),
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return(GestureDetector(onTap: ()
          {
            dismissTheFirstResponder();

          },child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CJAppBar(getTalent_VerifyYourBankAccountTitle, appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show the action type");
            Navigator.pop(context);
          })),

          body: getResponsiveUI(),
          //bottomNavigationBar: elevatedButtonBottomBar()

        ),)
    );
  }
  dismissTheFirstResponder()
  {
    FocusScope.of(context).requestFocus(new FocusNode());
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

  Container MainfunctionUi() {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: mainUILeftRightPadding, right: mainUILeftRightPadding),
          child: Form(
            key: tecBankInfoFormKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: getViewHintTextBlue(getTalent_VerifyBankDetailsHint),
                ),
                SizedBox(
                  height: 35,
                ),
                getAstricRow("Account Number"),
                SizedBox(height: spacingBetween_TextFieldandTextHeading),
                Column(
                  children: [
                    TextFormField(
                      maxLength: 18,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (value) {
                        //Validator
                      },
                      controller: accNumberController,
                      onChanged: (value) {
                        setState(()
                        {
                          bankNo = value;
                        });
                      },
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Enter a valid Account Number!';
                      //   }
                      //   return null;
                      // },
                      validator: validateToAccountNo,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        // prefixIcon: Icon(Icons.ac_unit),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                getAstricRowWithInfo("IFSC Code",context,ifscCodeGlobalKey,getIFSCCode_Hint),
                SizedBox(height: spacingBetween_TextFieldandTextHeading),
                Container(
                  child: TextFormField(
                    maxLength: 11,
                    inputFormatters: <TextInputFormatter>[
                      UpperCaseTxt()
                    ],
                    onFieldSubmitted: (value) {
                      //Validator
                    },
                    controller: ifscController,
                    onChanged: (value) {
                      ifscCode = value;
                    },
                    validator: validateToIFSC,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      // prefixIcon: Icon(Icons.ac_unit),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                getAstricRow("Account Holder Name"),
                SizedBox(height: spacingBetween_TextFieldandTextHeading),
                Container(
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      //Validator
                    },
                    controller: AccHolderNameController,
                    onChanged: (value) {
                      fullName = value;
                    },
                    validator: validateToName,
                    keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[A-Za-z ]")),
                      //UpperCaseTxt()
                    ],
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      // prefixIcon: Icon(Icons.ac_unit),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                elevatedButtonBottomBar()
              ],
            ),
          ),
        ),
      ),
    );

    //);
  }

  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Verify", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");

      // TalentNavigation().pushTo(context, Talent_VerifyBankAccountDetails());
      _submit();
    }
    )) ;

  }

  void _submit()
  {
    if (tecBankInfoFormKey.currentState!.validate())
    {
      createBodyWebApi_VerifyBankNoForEmployee();
    }
  }

  createBodyWebApi_VerifyBankNoForEmployee()
  {
    //(String jsId,String bankNo,String ifscCode,
    //     String fullName,String createdBy,String ipAddress)
    var mapObject=getCJHub_EmployeeKYCBankInfoVerify_RequestBody(widget.verifyOTP_ModelResponse!.data!.jsId,bankNo,ifscCode,fullName,ipAddress);
    serviceRequestForEmployee(mapObject);
  }
////
  /*-----------employee login web api start--------------*/
  serviceRequestForEmployee(Map mapObj)
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.verify_BankAccount_Number,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          print("show sucess");

          EmployeeBankAccountVerifyModelClass bankDetailsObj=success as EmployeeBankAccountVerifyModelClass;


          TalentNavigation().pushTo(context, TEC_BankInfoVerifyDetails(verifyOTP_ModelResponse: widget.verifyOTP_ModelResponse,bankAccountDetailsObj:bankDetailsObj ,));


          /* CJTalentCommonModelClass commonModelClass=success as CJTalentCommonModelClass;
          if(commonModelClass.statusCode==true)
          {
            print("show sucess1");
            TalentNavigation().pushTo(context, TEC_JoiningProfileDashboard(verifyOTP_ModelResponse: widget.verifyOTP_ModelResponse,));
          }*/

        }, talentFailureBlock:<T>(failure)
        {
          //SharedPreference.setEmpoyeeUAN("N");

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

/*
 Container  MainfunctionUi1()
  {
    return Container(
      child: SingleChildScrollView(child: Padding(padding: EdgeInsets.only(left:mainUILeftRightPadding,right: mainUILeftRightPadding ),
        child:Form(key: tecBankInfoFormKey,child: Column(
          children: <Widget>[

            SizedBox(height: 5,),
            Center(child:getViewHintTextBlue(getTalent_VerifyBankDetailsHint),),
            SizedBox(height: 35,),

            getAstricRow("Account Number"),
            SizedBox(height: spacingBetween_TextFieldandTextHeading),
            Column(
              children: [
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (value) {
                    //Validator
                  },
                  validator: (value){
                    if (value!.isEmpty)
                    {
                      return 'Enter a valid Account Number!';
                    }
                    return null;
                  },
                  onChanged: (value)
                  {
                    bankNo=value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    // prefixIcon: Icon(Icons.ac_unit),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            getAstricRow("IFSC"),

            Padding(padding: EdgeInsets.only(left: 15),child: getAstricRowWithInfo("IFSC Code",context,ifscCodeGlobalKey,getIFSCCode_Hint),),

            SizedBox(height: spacingBetween_TextFieldandTextHeading),
            Container(
              child: TextFormField(
                onFieldSubmitted: (value) {
                  //Validator
                },
                validator: (value){
                  if (value!.isEmpty) {
                    return 'Enter a valid IFSC Code!';
                  }
                  return null;
                },
                onChanged: (value)
                {
                  ifscCode=value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  // prefixIcon: Icon(Icons.ac_unit),
                ),
              ),
            ),
            SizedBox(height: 30),
            getAstricRow("Account Holder Name"),
            SizedBox(height: spacingBetween_TextFieldandTextHeading),
            Container(
              child: TextFormField(
                onFieldSubmitted: (value) {
                  //Validator
                },
                validator: (value){
                  if (value!.isEmpty) {
                    return 'Enter a valid Account Holder Name!';
                  }
                  return null;
                },
                onChanged: (value)
                {
                  fullName=value;
                },
                keyboardType: TextInputType.emailAddress,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[A-Za-z ]")),
                ],
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  // prefixIcon: Icon(Icons.ac_unit),
                ),
              ),
            ),
            SizedBox(height: 30),

            elevatedButtonBottomBar()

          ],
        ),) ,),),

    );

    //);
  }

 */