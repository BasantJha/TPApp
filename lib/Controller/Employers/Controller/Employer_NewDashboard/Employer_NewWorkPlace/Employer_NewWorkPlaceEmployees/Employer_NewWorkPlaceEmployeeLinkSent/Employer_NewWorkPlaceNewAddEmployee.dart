import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../../../Constant/ValidationClass.dart';
import '../../../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../../../CustomView/Messages/Validation_Messages.dart';
import '../../../../../../../CustomView/TextField/TextFieldDecoration.dart';
import '../../../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../../../Services/Messages/Message.dart';
import '../../../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../../EmployerModelClasses/EmployerAddEmployeeModelClass/LeaveTemplateModelClass.dart';
import '../../../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../../Employer_NewWorkPlaceAttendance/Employer_NewWorkPlaceCreateLeaveTemplate.dart';
import '../Employer_NewWorkPlaceAddCalculator.dart';
import '../Employer_NewWorkPlaceEmployee.dart';
import '../Employer_NewWorkPlaceEmployeeChild.dart';


class Employer_NewWorkPlaceNewAddEmployee extends StatefulWidget
{
  const Employer_NewWorkPlaceNewAddEmployee({Key? key, this.liveModelObj}) : super(key: key);
  final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  State<Employer_NewWorkPlaceNewAddEmployee> createState() => _Employer_NewWorkPlaceNewAddEmployee();
}

class _Employer_NewWorkPlaceNewAddEmployee extends State<Employer_NewWorkPlaceNewAddEmployee> {


  String name = "", lastName="";
  String mobile = "";
  String emailValue = '';


  String createdby = "1";
  String createdip = "localhost";

  String leaveTemplateId = "";
  List salary_structure = [];

  final TextEditingController monthlySalaryController = TextEditingController();

  bool showValue = false;
  String deviceId="",IPAddress="";

  final addEmployeeGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("show the add calcultaor");

    getBasicInfo();
  }

  getBasicInfo()
  {
    /* Method.getDeviceId().then((value) => {
      deviceId=value,
      //print('show device id $value'),
    });
*/

    Method.getIPAddress().then((value) => {
      IPAddress=value,
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(onTap: ()
      {
        dismissTheFirstResponder();

      },child: Scaffold(
      backgroundColor: whiteColor,
      appBar: CJAppBar(getEmployer_AddEmployeeTitle,
          appBarBlock: AppBarBlock(appBarAction: () {
            // print("show the action type");
            Navigator.pop(context);
          })),
      body: getResponsiveUI(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 70, right: 70),
        child: elevatedButtonBottomBar(),
      ),
    ),);
  }
  dismissTheFirstResponder()
  {
    FocusScope.of(context).requestFocus(new FocusNode());
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
////
  SingleChildScrollView MainfunctionUi() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Form(
          key: addEmployeeGlobalKey,
          // autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              getAstricRow("Employee First Name"),
              SizedBox(height: 7),
              Container(
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp(r'[a-zA-Z\s]*'),
                          allow: true)
                    ],
                    validator: validateToName,
                    onChanged: (val) {
                      setState(() {
                        name = val;
                      });
                    },
                    keyboardType: TextInputType.text,
                    cursorColor: textValueColor,
                    style: TextStyle(),
                    decoration: getTextFieldDecoration("Employee First Name"),
                  )),
              SizedBox(height: 20),

              getAstricRow("Employee Last Name"),
              SizedBox(height: 7),
              Container(
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp(r'[a-zA-Z\s]*'),
                          allow: true)
                    ],
                    validator: validateToLastName,
                    onChanged: (val) {
                      setState(() {
                        lastName = val;
                      });
                    },
                    keyboardType: TextInputType.text,
                    cursorColor: textValueColor,
                    style: TextStyle(),
                    decoration: getTextFieldDecoration("Employee Last Name"),
                  )),

              SizedBox(height: 20),
              getAstricRow("Mobile Number"),
              SizedBox(height: 7),
              Container(
                child: TextFormField(
                  validator: validateToMobileNo,
                  onChanged: (val) {
                    setState(()
                    {

                      if(val.length==10)
                      {
                        dismissTheFirstResponder();
                      }else
                      {
                      }

                      mobile = val!;
                    });
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  decoration: getTextFieldDecoration('Enter Mobile Number'),
                ),
              ),
              SizedBox(height: 20),

              getWithoutAstricRow("Email Address (Optional)"),
              SizedBox(height: 7),
              Container(
                  child: TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9@a-zA-Z.]")),
                    ],
                    onChanged: (value) {
                      emailValue = value;
                    },
                    validator: validateEmailForAddEmployee,
                    cursorColor: textValueColor,
                    style: TextStyle(),
                    decoration: getTextFieldDecoration("Enter Email Address"),
                  )),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }


  _submit()
  {

    if (addEmployeeGlobalKey.currentState!.validate()) {
      createBodyWebApi_EmployerAddEmployee();
    }
  }

  Container elevatedButtonBottomBar() {
    return CJElevatedBlueButton("Add Employee",
        elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: () {
          _submit();
          // print("show the continue action");
        }));
  }
//
  /*--------------hit the Add Employee service request start 17-12-2022..pratibha---------------*/
  createBodyWebApi_EmployerAddEmployee()
  {

    name=name.trim()+" "+lastName.trim();
    var mapObject = getEmployer_NewAddEmployee_RequestBody(name,mobile,emailValue,widget.liveModelObj?.tpAccountId,widget.liveModelObj?.employerId, widget.liveModelObj?.tpLeadId,widget.liveModelObj?.employerId,IPAddress);
    serviceRequest_AddEmployee(mapObject);
  }
//
  serviceRequest_AddEmployee(Map mapObj)
  {
//
    String token=widget.liveModelObj?.token;

    print("show the chandra mohan token $token");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequestForAddEmployee(mapObj, JG_ApiMethod_UpdateAddEmployee,token,
        cjEmployerResponseBlock: CJEmployerResponseBlock(
            employerSuccessBlock: <T>(commonResponse, modelResponse)
            {

              EasyLoading.dismiss();

              CJTalentCommonModelClass commonModelClass=commonResponse as CJTalentCommonModelClass;
              if (commonModelClass?.message==null || commonModelClass?.message=="")
              {
                CJSnackBar(context, "server error!");
              }else {
                CJSnackBar(context, commonModelClass!.message!);
              }

              Navigator.pop(context,[Employer_NewWorkPlaceEmployee()]);

            }, employerFailureBlock: <T>(commonResponse, failure) {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonModelClass=failure as CJTalentCommonModelClass;
          if (commonModelClass?.message==null || commonModelClass?.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context, commonModelClass!.message!);
          }

        }));
  }

/*-----------17-12-2022 end--------------*/



}

