import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:contractjobs/Services/AESAlgo/encrypt.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../../../Constant/ValidationClass.dart';
import '../../../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../../../CustomView/Messages/Validation_Messages.dart';
import '../../../../../../../CustomView/TextField/TextFieldDecoration.dart';
import '../../../../../../../Services/AESAlgo/EncryptedMapBody.dart';
import '../../../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../../../Services/Messages/Message.dart';
import '../../../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../../../../EmployerModelClasses/EmployerAddEmployeeModelClass/LeaveTemplateModelClass.dart';
import '../../../../Employer_KYCModelClass/Employer_StateModelClass.dart';
import '../../../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../../../../Employer_TabBarController/Employer_TabBarController.dart';
import '../../Employer_NewWorkPlaceAttendance/Employer_NewWorkPlaceCreateLeaveTemplate.dart';
import '../Employer_FlexibleCalculator/Employer_FlexibleCalculator.dart';
import '../Employer_NewWorkPlaceAddCalculator.dart';
import '../Employer_NewWorkPlaceEmployee.dart';
import '../Employer_NewWorkPlaceEmployeeChild.dart';
import 'Employer_UpdateWorkPlaceAddCalculator.dart';


class Employer_NewWorkPlaceAddDOJ extends StatefulWidget
{
  const Employer_NewWorkPlaceAddDOJ({Key? key, this.liveModelObj, this.mapObj}) : super(key: key);
  final Employer_VerifyMobileNoModelClass? liveModelObj;
  final Map? mapObj;

  @override
  State<Employer_NewWorkPlaceAddDOJ> createState() => _Employer_NewWorkPlaceAddDOJ();
}

class _Employer_NewWorkPlaceAddDOJ extends State<Employer_NewWorkPlaceAddDOJ> {


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

  final TextEditingController stateController = TextEditingController();
  final TextEditingController leaveTemplateController = TextEditingController();



  bool showValue = false;
  String deviceId="",IPAddress="";
  List<CommonStateList>? stateList;


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
  final _formGlobalKey = GlobalKey<FormState>();
  String selectedStateName="",selectedStateId="";
  bool apiRequest=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("show the add calcultaor");

    getBasicInfo();

    getServiceRequest_AllStatesList();
    createBodyWebApi_leaveType();
  }
////
  getBasicInfo()
  {
//
    selectedStateName=widget.mapObj!["employeeProfileUpdateStatus"];

    print("show the selectedStateName $selectedStateName ");
    //selectedStateName="DELHI";

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
      appBar: CJAppBar("Setup Salary",
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
          key: _formGlobalKey,
          // autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [


              SizedBox(height: 40),
              getAstricRow("Job Location"),
              SizedBox(height: 7),
              apiRequest ?Container(
                child: stateDropDown('Select Job Location', validateMsg_state)
              ):Container(),
              SizedBox(height: 20),

              getAstricRow("Job Role"),
              SizedBox(height: 7),
              Container(
                  child: TextFormField(

                    validator: validateToJobRole,
                    keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                    ],
                    onChanged: (value) {
                      designation = value;
                    },
                    cursorColor: textValueColor,
                    style: TextStyle(),
                    decoration: getTextFieldDecoration("Driver,Medical Assistant etc"),
                  )),
              SizedBox(height: 20),


              getAstricRow("Salary Start Date"),
              SizedBox(height: 7),
              Container(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp("[0-9/]"), allow: true),
                      LengthLimitingTextInputFormatter(10),
                      _DateFormatter(),
                    ],
                    validator:validateToJoiningDate,
                   /* validator: (value)
                    {
                      if (value == null || value.length == 0) {
                        return validateMsg_DateOfJoining;
                      }
                    },*/
                    onChanged: (value)
                    {
                      doj = value;
                    },
                    cursorColor: textValueColor,
                    style: TextStyle(),
                    decoration: getTextFieldDecoration("dd/mm/yyyy"),
                  )),

             /* SizedBox(height: 20),
              getAstricRow("Leave Template for Employee"),
              SizedBox(height: 7),*/
             /* Container(
                child: dropdownbutton(
                    'Select Leave Template', leavetemplate),
              ),*/

            /*  Container(
                  child: TextFormField(controller: leaveTemplateController,enabled: false,
                    //keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                    ],
                    onChanged: (value)
                    {
                    },
                    cursorColor: textValueColor,
                    style: TextStyle(),
                    decoration: getTextFieldDecoration(""),
                  )),*/
              SizedBox(height: 20),

              /*---------------24-2-2023 start-----------*/
           /*   InkWell(onTap: ()
              {
                print("show the leave template");
                pushTo(context,Employer_NewWorkPlaceCreateLeaveTemplate(liveModelObj: widget.liveModelObj,));

              },child:getTheCustomLeaveTemplateForAddEmployee
                ,),
*/

              /*---------------24-2-2023 end-----------*/

            ],
          ),
        ),
      ),
    );
  }


  dropdownbutton(String text, List list) {
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
      onChanged: (value)
      {
        leaveTemplateId = value!;
        print("show the leaveTemplateId $leaveTemplateId");
        FocusScope.of(context).requestFocus(FocusNode());

      },
      onSaved: (value) {
        selectedValue = value!;
        print("show the selectedValue $selectedValue");
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
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }


  stateDropDown(String text,  String validateText)
  {

    return DropdownButtonFormField2(

      value: selectedStateId,
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
      items: stateList?.map((item) => DropdownMenuItem<String>(
        value: item.id.toString(),
        child: Text(
          item.state!,
          style: const TextStyle(
              fontFamily: robotoFontFamily,
              color: textFieldHintTextColor,
              fontSize: medium_FontSize,
              fontWeight: normal_FontWeight),
        ),
      ))
          .toList(),
      onChanged: (value) {

        setState(() {
          selectedStateId=value!;
        });

        print("//show the state name $selectedStateId");

        FocusScope.of(context).requestFocus(FocusNode());

      },
      onSaved: (value) {
        selectedValue = value!;
        print("show the selectedValue $selectedValue");
      },
      validator: (value) {

        print("show the selected state name dd:$value");
        selectedStateId=value!;


        if (value == null || value.isEmpty) {
          return 'Please Select Job Location';
        }
      },
    );
  }

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




  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Continue",
        elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: () {
          _submit();
          // print("show the continue action");
        }));
  }
  _submit()
  {

    if (_formGlobalKey.currentState!.validate())
    {
      createBodyWebApi_EmployerAddEmployee();
    }
  }

  /*--------------hit the Add Employee service request start 17-12-2022..pratibha---------------*/
  createBodyWebApi_EmployerAddEmployee()
  {
    int i=0;
    for(i=0;i<stateList!.length;i++)
    {
      var searchStateId=stateList![i].id;
      if(searchStateId.toString()==selectedStateId)
      {
        selectedStateName=stateList![i].state!;
        break;
      }
    }

    var mainMapBody=Map();
    mainMapBody["jsId"]=getEncryptedData(widget.mapObj!["jsId"]);
    mainMapBody["dateOfJoining"]=doj;
    mainMapBody["jobRole"]=designation;
    mainMapBody["customerAccountId"]=getEncryptedData(widget.liveModelObj?.tpAccountId);
    mainMapBody["tpLeaveTemplateId"]=leaveTemplateId;
    mainMapBody["creatdBy"]=widget.liveModelObj?.tpAccountId;
    mainMapBody["createdbyIp"]=IPAddress;
    mainMapBody["minWageStateName"]=selectedStateName;

    print("show the request body $mainMapBody");


    /*------------------24-2-2023 start-----------------*/
    //setUpSalaryCalculatorBottomSheet(context,widget.liveModelObj,widget.mapObj!,mainMapBody);


    TalentNavigation().pushTo(context, ShowCaseWidget(
        builder: Builder(
          builder: (context) => Employer_FlexibleCalculator(liveModelObj:widget.liveModelObj,
              selectedSalaryCalculatorType:selectedSalaryCalculatorType,mapObj: widget.mapObj!,employeeAddObj:mainMapBody),
        )));

    /*------------------24-2-2023 end-----------------*/


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

    //EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj, JG_ApiMethod_EmployerLeaveTemplate,
        cjEmployerResponseBlock: CJEmployerResponseBlock(
            employerSuccessBlock: <T>(commonResponse, modelResponse) {
              // print("print leave model response $modelResponse");

             // EasyLoading.dismiss();
              LeaveTemplateModelClass leaveModel = modelResponse as LeaveTemplateModelClass;
              leaveTypeData(leaveModel);

            }, employerFailureBlock: <T>(commonResponse, failure) {
         // EasyLoading.dismiss();

          CJTalentCommonModelClass commonModelClass=failure as CJTalentCommonModelClass;
          if (commonModelClass?.message==null || commonModelClass?.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context, commonModelClass!.message!);
          }
        }));
  }

  leaveTypeData(leaveData)
  {
    if (leaveData.data!.length > 0) {
      setState(()
      {
        leaveTemplateList = leaveData.data!;

       // leaveTemplateController.text=leaveTemplateList![0].templatedesc!;
        leaveTemplateId = leaveTemplateList![0].templateid!.toString();


      });
    } else {}
  }

/*-----------26-12-2022 end--------------*/

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
            stateList=employer_stateModelClass.commonStateList!;

            int i=0;
              for(i=0;i<stateList!.length;i++)
              {
                var searchStateName=stateList![i].state;
                print("show the searchStateName searchStateName $searchStateName");

                if(searchStateName.toString().toUpperCase()==selectedStateName.toUpperCase())
                {
                  selectedStateId=stateList![i].id!.toString();
                  break;
                }
              }

              print("show the selectedStateId selectedStateId $selectedStateId");

            setState(() {

              selectedStateId=selectedStateId;
              apiRequest=true;
              stateList=stateList;
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

/*----------------------------- BottomSheet Code Start Salary Calculator -----------------------------------*/
var dateRadioValue = 0;
var selectedSalaryCalculatorType=Employee_FixedGrossSalary; //default fixed gross salary
String Talent_close_Icon = "assets/tankhapayicons/close_cross_icon.png";

setUpSalaryCalculatorBottomSheet(BuildContext context,Employer_VerifyMobileNoModelClass? liveModelObj, Map mapObj,Map employeeAddObj)
{
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter state)
          {
            return SingleChildScrollView(
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.transparent,
                      // padding: EdgeInsets.only(top: topSpace),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 15.0,
                                bottom: 15.0),
                            child: FloatingActionButton(
                              onPressed: () => Navigator.pop(context),
                              backgroundColor: Colors.white,
                              child: Image(
                                  image: AssetImage(Talent_close_Icon)),
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
                            )
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 25,horizontal: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: Text("Salary Calculator",
                                  style: TextStyle(
                                      color: blackColor,
                                      fontFamily: robotoFontFamily,
                                      fontSize: large_FontSize,
                                      fontWeight: bold_FontWeight
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15,bottom: 20,top: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Text("Select salary calculations for your employee based on any one of the options below:",
                                          style: TextStyle(
                                              fontFamily: robotoFontFamily,
                                              fontWeight: bold_FontWeight,
                                              fontSize: medium_FontSize
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                //padding: EdgeInsets.only(left: 20, right: 20),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: 0,
                                        groupValue: dateRadioValue,
                                        activeColor: Colors.blue,
                                        onChanged: (value) {

                                          print("show the dateRadioValue1 $value");
                                          selectedSalaryCalculatorType=Employee_FixedGrossSalary;

                                          state(()
                                          {
                                            dateRadioValue = int.parse(value.toString());
                                            print("show the dateRadioValue $dateRadioValue");
                                          });
                                        },),
                                      SizedBox(width: 5),
                                      Text('Based On in-hand Salary (Employer takes full\nsocial security responsibility)',
                                        style: TextStyle(
                                            fontSize: small_FontSize,
                                            fontFamily: robotoFontFamily,color: companyNameTextColor,
                                            fontWeight: bold_FontWeight
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: 1,
                                        groupValue: dateRadioValue,
                                        activeColor: Colors.blue,
                                        onChanged: (value) {

                                          print("show the dateRadioValue1 $value");
                                          selectedSalaryCalculatorType=Employee_CostToEmployee;

                                          state(()
                                          {
                                            dateRadioValue = int.parse(value.toString());
                                            print("show the dateRadioValue $dateRadioValue");

                                          });
                                        },),
                                      SizedBox(width: 5),
                                      Text('Based on cost to employer (Social security\nresponsibility can be shared between employer\nand employee)',
                                        style: TextStyle(
                                            fontSize: small_FontSize,
                                            fontFamily: robotoFontFamily,color: companyNameTextColor,
                                            fontWeight: bold_FontWeight
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Padding(padding: EdgeInsets.only(top: 20,bottom: 10),child:  Center(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: darkBlueColor,
                                      //elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15.0)),
                                      minimumSize: Size(170, 60),
                                    ),
                                    onPressed: ()
                                    {


                                      Navigator.pop(context);
                                      TalentNavigation().pushTo(context, ShowCaseWidget(
                                          builder: Builder(
                                            builder: (context) => Employer_UpdateWorkPlaceAddCalculator(liveModelObj:liveModelObj,
                                              selectedSalaryCalculatorType:selectedSalaryCalculatorType,mapObj: mapObj,employeeAddObj:employeeAddObj),
                                          )));


                                    },
                                    child: Text("Continue",
                                      style: TextStyle(
                                          fontSize: large_FontSize,color: whiteColor,
                                          fontWeight: normal_FontWeight,
                                          fontFamily: robotoFontFamily
                                      ),
                                    )
                                ),
                              ),)
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            );
          }
      );
    },
  );
}
