import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../Constant/ValidationClass.dart';
import '../../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../../CustomView/Messages/Validation_Messages.dart';
import '../../../../../../CustomView/TextField/TextFieldDecoration.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../../Services/Messages/Message.dart';
import '../../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../EmployerModelClasses/EmployerAddEmployeeModelClass/LeaveTemplateModelClass.dart';
import '../../../EmployerModelClasses/EmployerSignUpModelClasses/EmployerSignUpModelClass.dart';
import '../../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../Employer_NewWorkPlaceAttendance/Employer_NewWorkPlaceCreateLeaveTemplate.dart';
import '../Employer_NewWorkPlaceTabs.dart';
import 'Employer_NewWorkPlaceAddCalculator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Employer_NewWorkPlaceEmployee.dart';
import 'Employer_NewWorkPlaceEmployeeChild.dart';

class Employer_NewWorkPlaceAddEmployee extends StatefulWidget
{
  const Employer_NewWorkPlaceAddEmployee({Key? key, this.liveModelObj}) : super(key: key);
  final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  State<Employer_NewWorkPlaceAddEmployee> createState() => _Employer_NewWorkPlaceAddEmployee();
}

class _Employer_NewWorkPlaceAddEmployee extends State<Employer_NewWorkPlaceAddEmployee> {


  String name = "";
  String mobile = "";
  String monthlySalary = '';
  String doj = '';
  String designation = '';
  String emailValue = '';


  String createdby = "1";
  String createdip = "localhost";

  String leaveTemplateId = "";
  List salary_structure = [];

  final TextEditingController monthlySalaryController = TextEditingController();

  bool showValue = false;
  String deviceId="",IPAddress="";

  List<Data>? leaveTemplateList;
  String leavetemplatevalue = 'New Delhi';
  List<String> leavetemplate = [
    'New Delhi',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  late String selectedValue;
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("show the add calcultaor");

    getBasicInfo();
   createBodyWebApi_leaveType();
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
    return Scaffold(
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
////
  SingleChildScrollView MainfunctionUi() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Form(
          key: _form,
          // autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              getAstricRow("Employee Name"),
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
                decoration: getTextFieldDecoration("Employee Name"),
              )),
              SizedBox(height: 20),
              getAstricRow("Mobile Number"),
              SizedBox(height: 7),
              Container(
                child: TextFormField(
                  validator: validateToMobileNo,
                  onChanged: (val) {
                    setState(() {
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
              getAstricRow("Monthly Salary"),
              SizedBox(height: 7),
              Container(
                  child: TextFormField(
                controller: monthlySalaryController,
                readOnly: true,
                // enabled: false,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.length == 0) {
                    return validateMsg_MonthlySalary;
                  }
                },
                onChanged: (value) {
                  monthlySalary = monthlySalaryController.text;
                },

                cursorColor: textValueColor,
                style: TextStyle(),
                decoration: getTextFieldDecorationWithSuffixIcon(
                    monthly_salary_Icon, "Enter Monthly Salary", context),
              )),
              SizedBox(height: 20),
              getAstricRow("Date of Joining"),
              SizedBox(height: 7),
              Container(
                  child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter(RegExp("[0-9/]"), allow: true),
                  LengthLimitingTextInputFormatter(10),
                  _DateFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.length == 0) {
                    return validateMsg_DateOfJoining;
                  }
                },
                onChanged: (value) {
                  doj = value;
                },
                cursorColor: textValueColor,
                style: TextStyle(),
                decoration: getTextFieldDecoration("dd/mm/yyyy"),
              )),
              SizedBox(height: 20),
              getAstricRow("Leave Template for Employee"),
              SizedBox(height: 7),
              Container(
                child: dropdownbutton(
                    'Select Leave Template', leavetemplatevalue, leavetemplate),
              ),
              InkWell(onTap: ()
                {
                  print("show the leave template");
                  pushTo(context,Employer_NewWorkPlaceCreateLeaveTemplate(liveModelObj: widget.liveModelObj,));

                },child:getTheCustomLeaveTemplateForAddEmployee
              ,),

              //SizedBox(height: 40),
              getWithoutAstricRow("Designation (Optional)"),
              SizedBox(height: 7),
              Container(
                  child: TextFormField(
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                ],
                onChanged: (value) {
                  designation = value;
                },
                cursorColor: textValueColor,
                style: TextStyle(),
                decoration: getTextFieldDecoration("Enter Designation"),
              )),
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

  InputDecoration getTextFieldDecorationWithSuffixIcon<T>(String iconName, String hintText, BuildContext context)
  {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(fontFamily: robotoFontFamily,
        color: Colors.grey,
        fontWeight: bold_FontWeight,
      ),
      suffixIcon: Container(
        height: 30.0,
        width: 30.0,
        child: IconButton(
          icon: Image.asset(iconName),
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Employer_NewWorkPlaceAddCalculator(liveModelObj: widget.liveModelObj,)))
                .then((value) {
              setState(() {
                salary_structure.clear();
                salary_structure.add(value[2]);
                monthlySalaryController.text = value[1];
              });
            });
          },
        ),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 2.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  dropdownbutton(String text, String val, List list) {
    return DropdownButtonFormField2(

      // value: val,
      isExpanded: true,
      dropdownWidth: kIsWeb==true?webResponsive_TD_Width-40:MediaQuery.of(context).size.width-50,

      dropdownMaxHeight: 200,
      scrollbarRadius: const Radius.circular(40),
      scrollbarThickness: 6,
      scrollbarAlwaysShow: true,
      offset: Offset(-15, -15),
      decoration: decorationimage(text),
      buttonPadding: const EdgeInsets.only(left: 18, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: leaveTemplateList
          ?.map((item) => DropdownMenuItem<String>(
                value: item.templateid.toString(),
                child: Text(
                  item.templatedesc!,
                  style: const TextStyle(
                      fontFamily: robotoFontFamily,
                      color: textFieldHintTextColor,
                      fontSize: medium_FontSize,
                      fontWeight: normal_FontWeight),
                ),
              ))
          .toList(),
      onChanged: (value) {
        leaveTemplateId = value!;
        FocusScope.of(context).requestFocus(FocusNode());

      },
      onSaved: (value) {
        selectedValue = value!;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Select Leave Template';
        }
        return null;
      },
    );
  }

  InputDecoration decorationimage(String hintimage) {
    return InputDecoration(
      hintText: hintimage,
      hintStyle: TextStyle(
          color: textFieldHintTextColor,
          fontSize: large_FontSize,
          fontWeight: normal_FontWeight,
          fontFamily: robotoFontFamily),
      // prefixIcon: Iconimg(Icon),
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
          image: AssetImage(
            icon,
          ),
        ),
      ),
    );
  }
//
  pushTo<T>(BuildContext context,navigateView)
  {
    Navigator.push(context, MaterialPageRoute(builder: (_)=>

        Responsive(
            mobile: navigateView,
            tablet: Center(
              child: Container(
                width: webResponsive_TD_Width,
                child: navigateView,
              ),
            ),

            desktop: Center(
              child: Container(
                width: webResponsive_TD_Width,
                child: navigateView,
              ),
            )
        )
    )
    ).then((value)
    {
      createBodyWebApi_leaveType();
    });
  }


  _submit()
  {

    if (_form.currentState!.validate()) {
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

  /*--------------hit the Add Employee service request start 17-12-2022..pratibha---------------*/
  createBodyWebApi_EmployerAddEmployee()
  {
    var salary = monthlySalaryController.text;
    var mapObject = getEmployer_AddEmployee_RequestBody(name,mobile,salary,doj,
        designation,emailValue,widget.liveModelObj?.tpAccountId,widget.liveModelObj?.employerId,
        widget.liveModelObj?.tpLeadId,widget.liveModelObj?.employerId,IPAddress,salary_structure,leaveTemplateId);
    serviceRequest_AddEmployee(mapObject);
  }

  serviceRequest_AddEmployee(Map mapObj)
  {

    String token=widget.liveModelObj?.token;

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequestForAddEmployee(mapObj, JG_ApiMethod_AddEmployee,token,
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

  /*--------------hit the leave template service request start 26-12-2022..pratibha---------------*/

  createBodyWebApi_leaveType()
  {

    var mapObject = getEmployer_LeaveTemplate_RequestBody(widget.liveModelObj?.tpAccountId);
    serviceRequest_leaveType(mapObject);
  }

  serviceRequest_leaveType(Map mapObj) {
    // print("show 1the request2");
     print("show the request object leave $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj, JG_ApiMethod_EmployerLeaveTemplate,
        cjEmployerResponseBlock: CJEmployerResponseBlock(
            employerSuccessBlock: <T>(commonResponse, modelResponse) {
          // print("print leave model response $modelResponse");

          EasyLoading.dismiss();
          LeaveTemplateModelClass leaveModel = modelResponse as LeaveTemplateModelClass;
          leaveTypeData(leaveModel);

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

  leaveTypeData(leaveData){
    if (leaveData.data!.length > 0) {
      setState(() {
        leaveTemplateList = leaveData.data!;
      });
    } else {}
  }

/*-----------26-12-2022 end--------------*/

}


class _DateFormatter extends TextInputFormatter
{
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;
    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(cText) > 3) {
        // Remove char
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      // Days cannot be greater than 31
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        // Remove char
        cText = cText.substring(0, 1);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if (cLen == 4) {
      // Can only be 0 or 1
      if (int.parse(cText.substring(3, 4)) > 1) {
        // Remove char
        cText = cText.substring(0, 3);
      }
    } else if (cLen == 5 && pLen == 4) {
      // Month cannot be greater than 12
      int mm = int.parse(cText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        // Remove char
        cText = cText.substring(0, 4);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if ((cLen == 3 && pLen == 4) || (cLen == 6 && pLen == 7)) {
      // Remove / char
      cText = cText.substring(0, cText.length - 1);
    } else if (cLen == 3 && pLen == 2) {
      if (int.parse(cText.substring(2, 3)) > 1) {
        // Replace char
        cText = cText.substring(0, 2) + '/';
      } else {
        // Insert / char
        cText =
            cText.substring(0, pLen) + '/' + cText.substring(pLen, pLen + 1);
      }
    } else if (cLen == 6 && pLen == 5) {
      // Can only be 1 or 2 - if so insert a / char
      int y1 = int.parse(cText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        // Replace char
        cText = cText.substring(0, 5) + '/';
      } else {
        // Insert / char
        cText = cText.substring(0, 5) + '/' + cText.substring(5, 6);
      }
    } else if (cLen == 7) {
      // Can only be 1 or 2
      int y1 = int.parse(cText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        // Remove char
        cText = cText.substring(0, 6);
      }
    } else if (cLen == 8) {
      // Can only be 19 or 20
      int y2 = int.parse(cText.substring(6, 8));
      if (y2 < 19 || y2 > 20) {
        // Remove char
        cText = cText.substring(0, 7);
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}