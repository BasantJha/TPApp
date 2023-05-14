// import 'dart:ffi';

import 'dart:convert';

import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/CJSnackBar/CJSnackBar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:http/http.dart' as http;

import '../../../../../../Constant/Constants.dart';
import '../../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../EmployerModelClasses/EmployerAttendanceModelClass/Employer_newWorkPlaceCreateLeaveTemplateModelClass/Employer_newWorkPlaceCreateLeaveTemplateModelClass.dart';
import '../../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'Employer_NewWorkPlaceLeaveSettingAttendance.dart';



const TankhaPay_Icon_CloseCrossIcon = "assets/icons/tankha_cross_icon.png";
const txtstyle = TextStyle(color: lightBlueColor);

// List leavelist = ["CL", "ML"];

const NODs = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "12",
  "13",
  "14",
  "15",
  "16",
];
const carryF = ["Y", "N"];

final children = [];

class Employer_NewWorkPlaceCreateLeaveTemplate extends StatefulWidget {

  const Employer_NewWorkPlaceCreateLeaveTemplate({super.key, this.liveModelObj});
  final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  State<Employer_NewWorkPlaceCreateLeaveTemplate> createState() => _Employer_NewWorkPlaceCreateLeaveTemplate();
}
//
class _Employer_NewWorkPlaceCreateLeaveTemplate extends State<Employer_NewWorkPlaceCreateLeaveTemplate>

{
  var leavelist = [];
  bool _Sunvalue = false;
  bool _Monvalue = false;
  bool _Tuevalue = false;
  bool _Wedvalue = false;
  bool _Thurvalue = false;
  bool _Frivalue = false;
  bool _Satvalue = false;


  final templateDetails_FormKey = GlobalKey<FormState>();

  var weekCjeckBoxSide = BorderSide(color: Colors.grey, width: 0.8);
  var weekCheckColor = Colors.green;
  var weekActiveColor = Colors.grey[200];
  var weekCheckDensity = VisualDensity(horizontal: -4, vertical: -4);

  bool term1 = false;
  bool term2 = false;
  bool term3 = false;
  String calender_Year = "Calender Year";
  String absent_is_equal_to_loss_of_Pay = "N";
  String? attendance_approval_required_for_payout = "N";

  var type_leave_count = 1;

  String? LLfirst;
  String? NODfirst;
  String? CFfirst;
  String? LLSecond;
  String? NODSecond;
  String? CFSecond;
  String? LLThird;
  String? NODThird;
  String? CFThird;

  List leaveType = [];
  List noOfDays = [];
  List carryForward = [];

  String leaveTypeFirst = "";
  String noOfDaysFirst = "1";
  String carryForwardFirst = "Y";
  String leaveTypeSecond = "";
  String noOfDaysSecond = "1";
  String carryForwardSecond = "Y";
  String leaveTypeThird = "";
  String noOfDaysThird = "1";
  String carryForwardThird = "Y";


  var dropdownBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    border: Border.all(color: Colors.grey),
    color: Colors.white, //<-- SEE HERE
  );

  var dropdownmargin = EdgeInsets.symmetric(vertical: 5);
  var dropdownpadding = EdgeInsets.symmetric(horizontal: 5);

  var dropdowntextStyle = TextStyle(
    fontSize: 12,
    color: blackColor,
  );

  List selectedDay = [];

  var termCheckBoxscale = 1.0;
  var termCheckboxcheckcolor = Colors.green;
  var termCheckBoxactiveColor = Colors.grey[100];
  var termCheckBoxBorderSide = BorderSide(color: Colors.grey, width: 0.8);
  TextEditingController controllerTemplateName = TextEditingController();
  bool ApiHitStatus = true;


  Map<dynamic,List<dynamic>> dataOfDropDown = {};






  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    createServiceBodyfor_getLeaveType();
  }

  @override
  Widget build(BuildContext context)
  {
    double topSpace = MediaQuery.of(context).size.height - 732;

    final children = <Widget>[];
    for (var i = 0; i < type_leave_count; i++)
    {
      children.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Wrap(
                  children: [
                    leaveTypeTile("Type"),
                    if(i == 0)
                      Container(
                        margin: dropdownmargin,
                        height: 20,
                        padding: dropdownpadding,
                        decoration: dropdownBoxDecoration,
                        child: DropdownButton2<String>(
                          offset: Offset(0, -5),
                          dropdownMaxHeight: 150,
                          style: dropdowntextStyle,
                          iconSize: 15,
                          isDense: true,
                          isExpanded: true,
                          // elevation: 0,
                          value: LLfirst,
                          onChanged: (String? newValue) {
                            setState(() {
                              LLfirst = newValue!;
                              leaveTypeFirst = newValue;
                              print("1st Dropdown Data $leaveTypeFirst");
                            });
                          },
                          items: leavelist
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    else if(i == 1)
                      Container(
                        margin: dropdownmargin,
                        height: 20,
                        padding: dropdownpadding,
                        decoration: dropdownBoxDecoration,
                        child: DropdownButton2<String>(
                          offset: Offset(0, -5),
                          dropdownMaxHeight: 150,
                          style: dropdowntextStyle,
                          iconSize: 15,
                          isDense: true,
                          isExpanded: true,
                          // elevation: 0,
                          value: LLSecond,
                          onChanged: (String? newValue) {
                            setState(() {
                              if(leaveTypeFirst == newValue)
                              {
                                CJSnackBar(context, "This leaveType is Already Selected");
                              }
                              else
                              {
                                LLSecond = newValue!;
                                leaveTypeSecond = newValue;
                                print("leave Type second $leaveTypeSecond");
                              }
                            });
                          },
                          items: leavelist
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    else
                      Container(
                        margin: dropdownmargin,
                        height: 20,
                        padding: dropdownpadding,
                        decoration: dropdownBoxDecoration,
                        child: DropdownButton2<String>(
                          offset: Offset(0, -5),
                          dropdownMaxHeight: 150,
                          style: dropdowntextStyle,
                          iconSize: 15,
                          isDense: true,
                          isExpanded: true,
                          // elevation: 0,
                          value: LLThird,
                          onChanged: (String? newValue) {
                            setState(() {
                              if(leaveTypeFirst == newValue || leaveTypeSecond == newValue)
                              {
                                CJSnackBar(context, "This leaveType is Already Selected");
                              }
                              else
                              {
                                LLThird = newValue!;
                                leaveTypeThird = newValue;
                                print("leave Type second $leaveTypeSecond");
                              }
                            });
                          },
                          items: leavelist
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                        ),
                      )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Wrap(
                  children: [
                    leaveTypeTile("No.of Days"),
                    if(i == 0)
                      Container(
                        margin: dropdownmargin,
                        height: 20,
                        padding: dropdownpadding,
                        decoration: dropdownBoxDecoration,
                        child: DropdownButton2<String>(
                          offset: Offset(0, -5),
                          dropdownMaxHeight: 150,
                          style: dropdowntextStyle,
                          iconSize: 15,
                          isDense: true,
                          isExpanded: true,
                          // elevation: 0,
                          value: NODfirst,
                          // borderRadius: BorderRadius.circular(5),
                          onChanged: (String? newValue) {
                            setState(() {
                              NODfirst = newValue!;
                              noOfDaysFirst = newValue;
                              print("No of Days first $noOfDaysFirst");
                            });
                          },
                          items: NODs.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                        ),
                      )
                    else if(i == 1)
                      Container(
                        margin: dropdownmargin,
                        height: 20,
                        padding: dropdownpadding,
                        decoration: dropdownBoxDecoration,
                        child: DropdownButton2<String>(
                          offset: Offset(0, -5),
                          dropdownMaxHeight: 150,
                          style: dropdowntextStyle,
                          iconSize: 15,
                          isDense: true,
                          isExpanded: true,
                          // elevation: 0,
                          value: NODSecond,
                          // borderRadius: BorderRadius.circular(5),
                          onChanged: (String? newValue) {
                            setState(() {
                              NODSecond = newValue!;
                              noOfDaysSecond = newValue;
                              print("No of Days Second $noOfDaysSecond");
                            });
                          },
                          items: NODs.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                        ),
                      )
                    else
                      Container(
                        margin: dropdownmargin,
                        height: 20,
                        padding: dropdownpadding,
                        decoration: dropdownBoxDecoration,
                        child: DropdownButton2<String>(
                          offset: Offset(0, -5),
                          dropdownMaxHeight: 150,
                          style: dropdowntextStyle,
                          iconSize: 15,
                          isDense: true,
                          isExpanded: true,
                          // elevation: 0,
                          value: NODThird,
                          // borderRadius: BorderRadius.circular(5),
                          onChanged: (String? newValue) {
                            setState(() {
                              NODThird = newValue!;
                              noOfDaysThird = newValue;
                              print("No of Days Second $noOfDaysThird");
                            });
                          },
                          items: NODs.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                        ),
                      )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Wrap(
                  children: [
                    leaveTypeTile("Carry Forward"),
                    if(i == 0)
                      Container(
                        margin: dropdownmargin,
                        height: 20,
                        padding: dropdownpadding,
                        decoration: dropdownBoxDecoration,
                        child: DropdownButton2<String>(
                          offset: Offset(0, -5),
                          dropdownMaxHeight: 150,
                          style: dropdowntextStyle,
                          iconSize: 15,
                          isDense: true,
                          isExpanded: true,
                          // elevation: 0,
                          value: CFfirst,
                          focusColor: Colors.white,
                          // borderRadius: BorderRadius.circular(5),
                          onChanged: (String? newValue) {
                            setState(() {
                              CFfirst = newValue!;
                              carryForwardFirst = newValue;
                            });
                          },
                          items: carryF.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                        ),
                      )
                    else if(i == 1)
                      Container(
                        margin: dropdownmargin,
                        height: 20,
                        padding: dropdownpadding,
                        decoration: dropdownBoxDecoration,
                        child: DropdownButton2<String>(
                          offset: Offset(0, -5),
                          dropdownMaxHeight: 150,
                          style: dropdowntextStyle,
                          iconSize: 15,
                          isDense: true,
                          isExpanded: true,
                          // elevation: 0,
                          value: CFSecond,
                          focusColor: Colors.white,
                          // borderRadius: BorderRadius.circular(5),
                          onChanged: (String? newValue) {
                            setState(() {
                              CFSecond = newValue!;
                              carryForwardSecond = newValue;
                              print("carryForward Second $carryForwardSecond");
                            });
                          },
                          items: carryF.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                        ),
                      )
                    else
                      Container(
                        margin: dropdownmargin,
                        height: 20,
                        padding: dropdownpadding,
                        decoration: dropdownBoxDecoration,
                        child: DropdownButton2<String>(
                          offset: Offset(0, -5),
                          dropdownMaxHeight: 150,
                          style: dropdowntextStyle,
                          iconSize: 15,
                          isDense: true,
                          isExpanded: true,
                          // elevation: 0,
                          value: CFThird,
                          focusColor: Colors.white,
                          // borderRadius: BorderRadius.circular(5),
                          onChanged: (String? newValue) {
                            setState(() {
                              CFThird = newValue!;
                              carryForwardThird = newValue;
                              print("carryForward Second $carryForwardThird");
                            });
                          },
                          items: carryF.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                        ),
                      )
                  ],
                ),
              ),
            ),
            // (i > 0)
            //     ? IconButton(
            //         icon: Icon(Icons.close),
            //         onPressed: () {},
            //       )
            //     : SizedBox()
          ],
        ),
      ));
    }
    return Scaffold(
      backgroundColor: whiteColor,

      appBar: CJAppBar(getEmployer_AttendanceYearlyCreateLeaveTemplate,
          appBarBlock: AppBarBlock(appBarAction: () {
            // print("show the action type");
            Navigator.pop(context);
          })),

      body: ApiHitStatus == true
          ? SingleChildScrollView(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child:  Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(
                  "Create Leave Template",
                  style: TextStyle(
                    fontSize: 20,
                    color: lightBlueColor,
                    fontWeight: semiBold_FontWeight,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                  key: templateDetails_FormKey,
                  child: Padding(padding: EdgeInsets.only(left: 10,right: 10),child: TextFormField(
                    enabled: true,
                    textAlign: TextAlign.center,
                    controller: controllerTemplateName,
                    validator:   (value){
                      if(value!.isEmpty)
                        return 'Enter Template Name';
                      else if(RegExp(r'^[^\S\r\n](?:[^\S\r\n]+[^\S\r\n])*$').hasMatch(value))
                        return "Please Enter Valid Template Name";
                    },
                    //getTemplateNameValidate,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: "Enter Template Name",
                      hintStyle: TextStyle(
                        color: darkGreyColor,
                        fontSize: medium_FontSize,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: darkGreyColor),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),)
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                title: Text(
                  "Weekly Off",
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: bold_FontWeight,
                  ),
                ),
                subtitle: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: darkGreyColor,
                    ),
                  ),
                  margin:
                  EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "Sun",
                                style: txtstyle,
                              ),
                              Checkbox(
                                side: weekCjeckBoxSide,
                                checkColor: weekCheckColor,
                                activeColor: weekActiveColor,
                                visualDensity: weekCheckDensity,
                                value: _Sunvalue,
                                onChanged: (value) {
                                  // print(" hello  - $_value");
                                  setState(() {
                                    _Sunvalue = value!;
                                    if(_Sunvalue == true && !selectedDay.contains("Sunday"))
                                    {
                                      selectedDay.add("Sunday");
                                    }
                                    else if(_Sunvalue == false && selectedDay.contains("Sunday"))
                                    {
                                      selectedDay.remove("Sunday");
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "Mon",
                                style: txtstyle,
                              ),
                              Checkbox(
                                side: weekCjeckBoxSide,
                                checkColor: weekCheckColor,
                                activeColor: weekActiveColor,
                                visualDensity: weekCheckDensity,
                                value: _Monvalue,
                                onChanged: (value) {
                                  // print(" hello  - $_value");
                                  setState(() {
                                    _Monvalue = value!;
                                    if(_Monvalue == true && !selectedDay.contains("Monday"))
                                    {
                                      selectedDay.add("Monday");
                                    }
                                    else if(_Monvalue == false && selectedDay.contains("Monday"))
                                    {
                                      selectedDay.remove("Monday");
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "Tue",
                                style: txtstyle,
                              ),
                              Checkbox(
                                side: weekCjeckBoxSide,
                                checkColor: weekCheckColor,
                                activeColor: weekActiveColor,
                                visualDensity: weekCheckDensity,
                                value: _Tuevalue,
                                onChanged: (value) {
                                  // print(" hello  - $_value");
                                  setState(() {
                                    _Tuevalue = value!;
                                    if(_Tuevalue == true && !selectedDay.contains("Tuesday"))
                                    {
                                      selectedDay.add("Tuesday");
                                    }
                                    else if(_Tuevalue == false && selectedDay.contains("Tuesday"))
                                    {
                                      selectedDay.remove("Tuesday");
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "Wed",
                                style: txtstyle,
                              ),
                              Checkbox(
                                side: weekCjeckBoxSide,
                                checkColor: weekCheckColor,
                                activeColor: weekActiveColor,
                                visualDensity: weekCheckDensity,
                                value: _Wedvalue,
                                onChanged: (value) {
                                  // print(" hello  - $_value");
                                  setState(() {
                                    _Wedvalue = value!;
                                    if( _Wedvalue == true && !selectedDay.contains("Wednesday"))
                                    {
                                      selectedDay.add("Wednesday");
                                    }
                                    else if( _Wedvalue == false && selectedDay.contains("Wednesday"))
                                    {
                                      selectedDay.remove("Wednesday");
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "Thur",
                                style: txtstyle,
                              ),
                              Checkbox(
                                side: weekCjeckBoxSide,
                                checkColor: weekCheckColor,
                                activeColor: weekActiveColor,
                                visualDensity: weekCheckDensity,
                                value: _Thurvalue,
                                onChanged: (value) {
                                  // print(" hello  - $_value");
                                  setState(() {
                                    _Thurvalue = value!;
                                    if(_Thurvalue == true && !selectedDay.contains("Thursday"))
                                    {
                                      selectedDay.add("Thursday");
                                    }
                                    else if(_Thurvalue == false && selectedDay.contains("Thursday"))
                                    {
                                      selectedDay.remove("Thursday");
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "Fri",
                                style: txtstyle,
                              ),
                              Checkbox(
                                side: weekCjeckBoxSide,
                                checkColor: weekCheckColor,
                                activeColor: weekActiveColor,
                                visualDensity: weekCheckDensity,
                                value: _Frivalue,
                                onChanged: (value) {
                                  // print(" hello  - $_value");
                                  setState(() {
                                    _Frivalue = value!;
                                    if(_Frivalue == true && !selectedDay.contains("Friday"))
                                    {
                                      selectedDay.add("Friday");
                                    }
                                    else if(_Frivalue == false && selectedDay.contains("Friday"))
                                    {
                                      selectedDay.remove("Friday");
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "Sat",
                                style: txtstyle,
                              ),
                              Checkbox(
                                side: weekCjeckBoxSide,
                                checkColor: weekCheckColor,
                                activeColor: weekActiveColor,
                                visualDensity: weekCheckDensity,
                                value: _Satvalue,
                                onChanged: (value) {
                                  // print(" hello  - $_value");
                                  setState(() {
                                    _Satvalue = value!;
                                    if(_Satvalue == true && !selectedDay.contains("Saturday"))
                                    {
                                      selectedDay.add("Saturday");
                                    }
                                    else if(_Satvalue == false && selectedDay.contains("Saturday"))
                                    {
                                      selectedDay.remove("Saturday");
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text(
                  "Types of Leaves (Yearly)",
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: bold_FontWeight,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: children,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          if (type_leave_count < leavelist.length) {
                            setState(() {
                              print("LeaveTypeFirst $leaveTypeFirst");
                              if(leaveTypeFirst == "CL")
                              {
                                print("Inside when LlFirst is equal to LLSecond");
                                setState(() {
                                  leaveTypeSecond = "ML";
                                  LLSecond = "ML";
                                  noOfDaysSecond = noOfDaysSecond;
                                  carryForwardSecond = carryForwardSecond;
                                });
                              }
                              else{
                                setState(() {
                                  leaveTypeSecond = "CL";
                                  LLSecond = "CL";
                                  noOfDaysSecond = noOfDaysSecond;
                                  carryForwardSecond = carryForwardSecond;
                                });
                              }
                              type_leave_count++;
                            });
                          }
                          print("LLSecond :$LLSecond");
                          print("LLFirst : $LLfirst");
                        },
                        child: Text(
                          "Add +",
                          style: TextStyle(
                            color: blackColor,
                            fontWeight: bold_FontWeight,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: termCheckBoxscale,
                                  child: Checkbox(
                                    checkColor: termCheckboxcheckcolor,
                                    activeColor: termCheckBoxactiveColor,
                                    side: termCheckBoxBorderSide,
                                    value: term1,
                                    onChanged: (val) {
                                      setState(() {
                                        term1 = val!;
                                        if (term1 == true) {
                                          setState(() {
                                            absent_is_equal_to_loss_of_Pay =
                                            "Y";
                                          });
                                        } else {
                                          absent_is_equal_to_loss_of_Pay =
                                          "N";
                                        }
                                      });
                                      print("term1 $term1");
                                    },
                                  ),
                                ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                Expanded(
                                    child: checkboxtitle(
                                        "Absent is equal to loss of pay")),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: termCheckBoxscale,
                                  child: Checkbox(
                                    checkColor: termCheckboxcheckcolor,
                                    activeColor: termCheckBoxactiveColor,
                                    side: termCheckBoxBorderSide,
                                    value: term2,
                                    onChanged: (val) {
                                      setState(() {
                                        term2 = val!;
                                        if (term2 == true) {
                                          setState(() {
                                            attendance_approval_required_for_payout = "Y";
                                          });
                                        } else {
                                          attendance_approval_required_for_payout = "N";
                                        }
                                      });
                                      print("term 2 $term2");
                                    },
                                  ),
                                ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                Expanded(
                                    child: checkboxtitle(
                                        "Attendance approval is required for payout")),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: termCheckBoxscale,
                                  child: Checkbox(
                                    checkColor: termCheckboxcheckcolor,
                                    activeColor: termCheckBoxactiveColor,
                                    side: termCheckBoxBorderSide,
                                    value: term3,
                                    onChanged: (val) {
                                      setState(() {
                                        term3 = val!;
                                      });
                                      print("term 3 $term3");
                                      if (term3 == true) {
                                        setState(() {
                                          calender_Year =
                                          "Financial Year";
                                        });
                                      } else {
                                        setState(() {
                                          calender_Year = "Calender Year";
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                    child: checkboxtitle(
                                        "Use Financial Year instead of Calendar Year")),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
          : Container(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: lightBlueColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              minimumSize: Size(180, 47),
            ),
            onPressed: () {

              validateToTheFields();


            },
            child: Text(
              "Create Template",
              style: TextStyle(
                color: whiteColor,
                fontSize: large_FontSize,
                fontWeight: bold_FontWeight,
              ),
            )),
      ),
    );
  }





  Text leaveTypeTile(String title)
  {
    return Text(
      title,
      style: TextStyle(
        fontSize: small_FontSize,
        color: lightBlueColor,
      ),
    );
  }

  Text checkboxtitle(String title)
  {
    return Text(
      title,
      style: TextStyle(
        fontSize: 12,
        color: blackColor,
      ),
    );
  }

  Expanded weekCheckBox(String Week, bool _value)
  {
    return Expanded(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            Week,
          ),
          Checkbox(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            value: _value,
            onChanged: (value) {
              print(" hello  - $_value");
              setState(() {
                _value = value!;
              });
            },
          ),
        ],
      ),
    );
  }


  validateToTheFields()
  {
    if (templateDetails_FormKey.currentState!.validate())
    {
      // TalentAnimationNavigation().pushBottomToTop(context, Employer_SignUpNewBusiness());
      //TalentNavigation().pushTo(context, Employer_SignUpNewBusiness());
      createServiceBodyFor_saveNewLeaveTemplate();
    }
  }
  createServiceBodyfor_getLeaveType()
  {

    var default_templateId = widget.liveModelObj!.tpAccountId;
    var mapObj = getLeaveType_RequestBody(default_templateId);
    serviceRequestFunction_getLeaveType(mapObj);
  }

  serviceRequestFunction_getLeaveType(Map mapObj)
  {
    {
      print("show the request2");
      print("show the request object $mapObj");

      EasyLoading.show();

      CJEmployerServiceRequest().postDataServiceRequestFor_EmployerSignUp(mapObj, Employer_NewWorkPlace_ApiMethod_createLeavetemplate_getLeaveType,kEmployer_LeaveSetting_GETLeadType,
          cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
          {
            print("Inside Success Block of getLeaveType");
            Employer_newWorkPlaceCreateLeaveTemplateModelClass modelclasss = modelResponse as Employer_newWorkPlaceCreateLeaveTemplateModelClass;

            for(var i =0;i<modelclasss.data!.length;i++)
            {
              setState(() {
                leavelist.add(modelclasss.data![i].leavetype.toString());
              });
            }

            LLfirst = leavelist[0].toString();
            NODfirst = NODs[0].toString();
            CFfirst = carryF[0].toString();
            LLSecond = leavelist[1].toString();
            NODSecond = NODs[0].toString();
            CFSecond = carryF[0].toString();
            setState(() {
              ApiHitStatus = true;
              EasyLoading.dismiss();
              if(type_leave_count == 1)
              {
                leaveTypeFirst = LLfirst!;
                noOfDaysFirst = noOfDaysFirst;
                carryForwardFirst = "Y";
              }
            });
          }, employerFailureBlock:<T>(commonResponse,modelResponse)
          {

            EasyLoading.dismiss();


            CJTalentCommonModelClass commonModelObj=commonResponse as CJTalentCommonModelClass;
            if (commonModelObj?.message==null || commonModelObj?.message=="")
            {
              CJSnackBar(context, "server 1 error!");
            }else {
              CJSnackBar(context, commonModelObj!.message!);
            }

          }));

    }
  }

  createServiceBodyFor_saveNewLeaveTemplate()
  {

    String customeraccountid = widget.liveModelObj?.tpAccountId;

    String offDays = "";
    for(var i =0;i<selectedDay.length;i++)
    {
      var char;
      if(i == selectedDay.length-1)
      {
        char ="";
      }
      else
      {
        char = ",";
      }
      offDays =  offDays +"${selectedDay[i]}$char";
    }
    print("Off Days $offDays");
    if(leaveTypeThird != "")
    {
      for(var i = 0; i<=2;i++)
      { var dataLeaveType;
      var dataNoOfDays;
      var dataCarryForward;
      if(i == 0)
      {
        dataLeaveType = LLfirst;
        dataNoOfDays = noOfDaysFirst;
        dataCarryForward = carryForwardFirst;
      }
      else if(i == 1)
      {
        dataLeaveType = LLSecond;
        dataNoOfDays = noOfDaysSecond;
        dataCarryForward = carryForwardSecond;
      }
      else
      {
        dataLeaveType = LLThird;
        dataNoOfDays = noOfDaysThird;
        dataCarryForward = carryForwardThird;
      }
      leaveType.add(dataLeaveType);
      noOfDays.add(dataNoOfDays);
      carryForward.add(dataCarryForward);
      }
    }
    else if(leaveTypeThird == "" && (leaveTypeSecond != "" && leaveTypeFirst != ""))
    {
      for(var i = 0; i<2;i++)
      {
        var dataLeaveType;
        var dataNoOfDays;
        var dataCarryForward;
        if(i == 0)
        {
          dataLeaveType = LLfirst;
          dataNoOfDays = noOfDaysFirst;
          dataCarryForward = carryForwardFirst;
        }
        else if(i == 1)
        {
          dataLeaveType = LLSecond;
          dataNoOfDays = noOfDaysSecond;
          dataCarryForward = carryForwardSecond;
        }
        leaveType.add(dataLeaveType);
        noOfDays.add(dataNoOfDays);
        carryForward.add(dataCarryForward);
      }}
    else if(leaveTypeSecond == "" && leaveTypeFirst != "")
    {
      leaveType.add(leaveTypeFirst);
      noOfDays.add(noOfDaysFirst);
      carryForward.add(carryForwardFirst);
    }
    else
    {
      leaveType.add(leaveTypeFirst);
      noOfDays.add(noOfDaysFirst);
      carryForward.add(carryForwardFirst);
    }
    List leaveTypeList = [];
    if(leaveType.length == noOfDays.length && noOfDays.length == carryForward.length)
    {
      for(var i = 0;i<leaveType.length;i++)
      {
        leaveTypeList.add({
          "days" : "${noOfDays[i]}",
          "typecode": "${leaveType[i]}",
          "is_carry_forward" : "${carryForward[i]}"
        });
      }
    }
    else
    {
      CJSnackBar(context, "Data Not Entered Correctly");
    }
    print("LeaveTypeList $leaveTypeList");
    Map<String,dynamic> createTemplateMapObj = {"templateid": "","templatedesc":"${controllerTemplateName.text}","leave_details":{"leave_type": leaveTypeList,"leaves_calender":"${calender_Year}","weekly_off_days":"${selectedDay.length}","weekly_off_days_name":"$offDays","absent_is_equal_to_loss_of_pay":"${absent_is_equal_to_loss_of_Pay}","attendance_approval_required_for_payout":"${attendance_approval_required_for_payout}"}};

    var mapObj = getSaveNewTemplate_RequestBody(customeraccountid,createTemplateMapObj);
    if(selectedDay.isNotEmpty)
      serviceRequestFunction_saveLeaveTemplate(mapObj);
    else
      CJSnackBar(context, "Please Select Weekly Off Days");
  }

  serviceRequestFunction_saveLeaveTemplate(Map mapObj)
  {
    print("show the request2");
    print("show the request object $mapObj");

    //EasyLoading.show();

    CJEmployerServiceRequest().postDataServiceRequestFor_EmployerSignUp(mapObj, Employer_NewWorkPlace_Attendance_ApiMethod_savenewTemplate,kEmployer_LeaveSetting_AddNewTemplate,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonModelObj=commonResponse as CJTalentCommonModelClass;
          CJSnackBar(context, commonModelObj!.message!);

          setState(() {
            leaveType.clear();
            noOfDays.clear();
            carryForward.clear();

            //ApiHitStatus = true;
            //EasyLoading.dismiss();
          });

          Navigator.pop(context,[Employer_NewWorkPlaceLeaveSettingAttendance()]);



        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {

          EasyLoading.dismiss();


          CJTalentCommonModelClass commonModelObj=commonResponse as CJTalentCommonModelClass;
          if (commonModelObj?.message==null || commonModelObj?.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context, commonModelObj!.message!);
          }


        }));

  }

}




