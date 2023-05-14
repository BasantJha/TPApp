import 'dart:convert';

import 'package:contractjobs/CustomView/CJSnackBar/CJSnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart'as http;

//import 'package:web/Model_Class/GetProfileDetailsJS_ModelResponse.dart';


import '../../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../ModelClasses/CJHubModelClasses/GetProfileDetailsJS_ModelResponse.dart';



void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: primaryColor
  ));
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CJ Hub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: profile_personalDetails_edit(title: 'CJ Hub'),
    );
  }
}
class profile_personalDetails_edit extends StatefulWidget {

  profile_personalDetails_edit({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _profile_personalDetails_edit createState() => _profile_personalDetails_edit();
}

// ignore: camel_case_types
class _profile_personalDetails_edit extends State<profile_personalDetails_edit> {

  String _selectedDate = 'Select date';
  String strDateOfBirth = "Select date";


  bool _visible = true;
  bool _Maritalvisible = true;
  bool femaleVal = false;
  bool maleVal = false;
  bool marriedVal = false;
  bool un_marriedVal = false;


  String complete_JSId="";
  GetProfileDetailsJS_ModelResponse? profileDetailsJS_ModelResponse;

  String empName="",empEmailId="",empDateOfBirth="Select date",empGender="",empMaritalStatus="",
      empMobileNo="",empEmergencyContactNo="",empCurrentAddress="",empPermanentAddress="",
      empFatherName="",bloodRelationName="";

  var empName_Controller=TextEditingController();
  var empEmailId_Controller=TextEditingController();
  var empMobileNo_Controller=TextEditingController();
  var empEmergencyContactNo_Controller=TextEditingController();

  var empCurrentAddress_Controller=TextEditingController();
  var empPermanentAddress_Controller=TextEditingController();
  var empFatherName_Controller=TextEditingController();

  String selectedGenderType="";
  String selectedMaritalStatus="";
  bool saveLockButton_VisibilityStatus=true;

  String errorMsg_MobileNumber="";


  String email="";
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _validate = false;
  bool checkEmailIdStatus=false;

  GlobalKey<FormState> formkeyMobileNo = GlobalKey<FormState>();
  bool checkMobileStatus_bool=false;


  String emailId_ErrorMsg="";
  String mobileNumber_ErrorMsg="";

  /*-------------9-2-2022 start------------*/
  List listItem_SalutationType =["Mr.","Ms.","Mrs."];
  String select_SalutationType="Mr.";

  List listItem_BloodRelationType =["Father","Mother","Brother","Sister","Husband","Wife"];
  String select_BloodRelationType="Father";


  //Emergency Contact Relation

  /*-------------9-2-2022 end------------*/

  String KYCStatusCode="",panCardStatus="",aadhaarCardStatus="";
  bool empNameEnableStatus=true;
  Color empNameColor = Colors.white;
  bool permanentAddressEnableStatus=true;
  Color permanentAddressColor = Colors.white;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //getBasicInfo();
  }

  Future<void> _selectDate(BuildContext context) async
  {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (d != null)
      setState(() {
        _selectedDate = new DateFormat.yMd("en_US").format(d);
        String datePattern = "MM/dd/yyyy";

        var birthDate = DateFormat(datePattern).parse(_selectedDate);
        var outputFormat=  DateFormat("dd/MM/yyyy");
        empDateOfBirth= outputFormat.format(birthDate);
        //print("Date of birth: $empDateOfBirth");

      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white,
        appBar:CJAppBar(getCJHUB_TEC_PersonalDetails, appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action type");
          Navigator.pop(context);
          saveProfilePersonalDetails("1", "false");
        })),


        body: WillPopScope(
          child: SingleChildScrollView(
            child: Column(children: <Widget>[

              create_headingContainer("Update Personal Details" ),//heading

              create_Select_Saluations(), //select salutations

              create_Full_name(), //Emp_Name

              create_EmailID(), //Emp_emailId

              create_DOB(), //Emp_DOB

              create_Gender(), //Emp_Gender

              create_MartialStatus(), //Emp_Maritalstatus

              create_MobileNo(), //Emp_MobileNo.

              create_BloodRelation_name(), //blood Relation Name

              create_EmergencyNo(), //Emp_EmergencyNo.


              create_CurrrentAddress(), //Emp_Address

              create_PermanentAddress(), //Emp_PermanentAddress

              create_Father_Husband(), //Emp_Father/Husband


              /*---------------10-1-2022 START-------------*/
              Visibility(visible: saveLockButton_VisibilityStatus,
                child:Container(
                  // color: Colors.red,
                  child: create_Save_Lock_Buttons(),
                ),
              ),
              /*---------------10-1-2022 START-------------*/
              create_BottomGap(),


            ]),

          ),
          onWillPop: () async
          {
            saveProfilePersonalDetails("1","false");
          return  Message.alert_dialogAppExit(context);

          } ,

          //            onWillPop: () async => false,
        )
    );
  }

  Container create_headingContainer(String value){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,20,0,0),
        child: Row(
          children: [
            SizedBox(
              width: 20.0,
              height: 20.0,
              child: Image.asset(getCJHub_LineIcon,
              ),
            ),
            SizedBox(
                width: 1.0),

            Text(value,
              style: TextStyle(color: Colors.black,fontSize: 15),),
          ],
        ),
      ),
    );
  }

  Container create_Select_Saluations() {
    return  Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              // decoration: Style_UploadInvestment_Inner,
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child:showTextNameWithAstrict("Select Salutation"),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    width: double.maxFinite,
                    height: 46,
                    padding: EdgeInsets.fromLTRB(10,0,10,0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    child:DropdownButton(
                      // hint: Text('Select'),
                      icon: Icon(Icons.arrow_drop_down),
                      dropdownColor: Colors.white,
                      underline: DropdownButtonHideUnderline(child: Container()),
                      iconSize: 25,
                      isExpanded: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: select_SalutationType,
                      onChanged: (newValue){
                        setState(() {
                          select_SalutationType!=newValue;

                        });
                      },
                      items: listItem_SalutationType.map((valueItem)
                      {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),

            ),
          ],
        )
    );
  }




  Container create_Full_name() {
    return  Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              // decoration: Style_UploadInvestment_Inner,
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child:showTextNameWithAstrict("Name as per Aadhaar Card"),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    height: 70,
                    child: TextFormField(controller: empName_Controller,
                      enabled: empNameEnableStatus,
                      maxLength: 100,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                      ],

                      decoration: InputDecoration(
                        fillColor: empNameColor,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.only(
                            top: 5, left: 10),
                        hintText: "Name as per Aadhaar Card",
                        border:
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0)),
                      ),
                      onChanged: (value)
                      {
                        empName=value;
                      },


                    ),
                  ),

                ],
              ),

            ),
          ],
        )
    );
  }

  Container create_EmailID() {
    return  Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              // decoration: Style_UploadInvestment_Inner,
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child:showTextNameWithAstrict("Email Id"),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    height: 70,
                    child:Form(
                      key: formkey,
                      child: TextFormField(controller: empEmailId_Controller,
                        maxLength: 100,
                        validator: validateEmail,
                        keyboardType: TextInputType.text,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z @ .]")),
                        ],
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: EdgeInsets.only(
                              top: 5, left: 10),
                          hintText: "email",
                          border:
                          OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2.0)),
                        ),
                        onChanged: (value)
                        {
                          empEmailId=value;

                        },


                      ),
                    ),
                  ),

                ],
              ),

            ),
          ],
        )
    );
  }


  String? validateEmail(String? value)
  {
    String patttern = r"^[a-zA-Z0-9.!#$%&'+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)$";
    RegExp regExp = new RegExp(patttern);
    if (value!.length == 0) {
      emailId_ErrorMsg="Email Id is Required";
      return emailId_ErrorMsg;
    }
    else if (!regExp.hasMatch(value!)) {
      emailId_ErrorMsg="Enter a valid email address";

      return emailId_ErrorMsg;
    }
    return null;
  }
  void checkvalidateEmailId()
  {
    if (formkey.currentState!.validate())
    {
      // No any error in validation
      checkEmailIdStatus=true;
      formkey.currentState!.save();

    }
    else
    {
      // validation error
      checkEmailIdStatus=false;
      setState(() {
        _validate = true;
      });
    }
  }

  String validateMobile(String? value)
  {
    //String patttern = r'(^[0-9]*$)';
    String patttern = r"^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[6789]\d{9}$";

    RegExp regExp = new RegExp(patttern);
    if (value!.length == 0) {
      mobileNumber_ErrorMsg="Mobile Number is Required";
      return mobileNumber_ErrorMsg;
    } else if(value!.length != 10)
    {
      mobileNumber_ErrorMsg="Mobile number must be 10 digits";
      return mobileNumber_ErrorMsg;

    }else if (!regExp.hasMatch(value))
    {
      mobileNumber_ErrorMsg="Please enter valid mobile number";
      return mobileNumber_ErrorMsg;
    }
    return "null";
  }

  void validateMobileNumber()
  {
    if (formkeyMobileNo.currentState!.validate())
    {
// No any error in validation
      checkMobileStatus_bool=true;
      formkeyMobileNo.currentState!.save();
    }
    else
    {
// validation error
      setState(()
      {
        checkMobileStatus_bool=false;

      });
    }
  }

  Container create_DOB() {
    return  Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child:showTextNameWithAstrict("Date Of Birth") ,
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    height: 50,
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.grey),
                              left: BorderSide(width: 1.0, color: Colors.grey),
                              right: BorderSide(width: 1.0, color: Colors.grey),
                              bottom: BorderSide(width: 1.0, color: Colors.grey),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              InkWell(

                                child:
                                Text(
                                    empDateOfBirth,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black)
                                ),

                                onTap: (){
                                  _selectDate(context);
                                },
                              ),
                              MaterialButton(
                                  minWidth: 5,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed:()
                                  {
                                    _selectDate(context);
                                  },
                                  child: Text('')
                              ),

                            ],
                          ),
                        )
                    ),
                  ),

                ],
              ),

            ),
          ],
        )
    );
  }

  Container create_Gender() {
    return  Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,

              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child:showTextNameWithAstrict("Gender"),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    height: 70,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: new BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey,
                            width: 1.0,
                            style: BorderStyle.solid)
                    ),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.4,
                            // height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                create_Gap(),

                                Text(
                                  "Female",textAlign: TextAlign.center,
                                  style: new TextStyle(fontSize: 12.0),
                                ),

                                Checkbox(
                                  activeColor: Colors.amber,
                                  value: femaleVal,
                                  onChanged: (bool? value)
                                  {
                                    selectedGenderType="Female";
                                    setState(()
                                    {
                                      //_visible=!_visible;
                                      femaleVal = value!;
                                      maleVal = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),),

                        Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.4,
                            // color: Colors.greenAccent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                create_Gap(),

                                Text(
                                  "Male",textAlign: TextAlign.center,
                                  style: new TextStyle(fontSize: 12.0),
                                ),

                                Checkbox(
                                  activeColor: Colors.amber,
                                  value: maleVal,
                                  onChanged: (bool? value)
                                  {
                                    selectedGenderType="Male";

                                    setState(()
                                    {
                                      // _visible=!_visible;
                                      maleVal = value!;
                                      femaleVal = false;
                                    });
                                  },
                                ),

                              ],
                            ),
                          ),)



                      ],
                    ),

                  ),

                ],
              ),

            ),
          ],
        )
    );
  }
  Container create_MartialStatus() {
    return  Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,

              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child:showTextNameWithAstrict("Marital Status"),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    height: 70,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: new BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey,
                            width: 1.0,
                            style: BorderStyle.solid)
                    ),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.4,
                            // height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                create_Gap(),

                                Text(
                                  "Married",textAlign: TextAlign.center,
                                  style: new TextStyle(fontSize: 12.0),
                                ),

                                Checkbox(
                                  activeColor: Colors.amber,
                                  value: marriedVal,
                                  onChanged: (bool? value) {

                                    selectedMaritalStatus="Married";
                                    setState(() {
                                      //_Maritalvisible=!_Maritalvisible;
                                      marriedVal = value!;
                                      un_marriedVal= false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),),

                        Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.4,
                            // color: Colors.greenAccent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                create_Gap(),

                                Text(
                                  "Un-Married",textAlign: TextAlign.center,
                                  style: new TextStyle(fontSize: 12.0),
                                ),

                                Checkbox(
                                  activeColor: Colors.amber,
                                  value: un_marriedVal,
                                  onChanged: (bool? value)
                                  {

                                    selectedMaritalStatus="Single";
                                    setState(()
                                    {
                                      // _Maritalvisible=!_Maritalvisible;
                                      un_marriedVal = value!;
                                      marriedVal = false;
                                    });
                                  },
                                ),

                              ],
                            ),
                          ),)



                      ],
                    ),

                  ),

                ],
              ),

            ),
          ],
        )
    );
  }

  Container create_MobileNo() {
    return  Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Mobile No",style: TextStyle(color: primaryColor,fontSize: 13),),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    height: 50,
                    child: TextField(controller: empMobileNo_Controller,
                      enabled: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        fillColor: Colors.black12,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.only(
                            top: 5, left: 10),
                        hintText: "mobile no",
                        border:
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0)),
                      ),

                    ),
                  ),

                ],
              ),

            ),
          ],
        )
    );
  }

  Container create_EmergencyNo() {
    return  Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child:showTextNameWithAstrict("Emergency Contact (with blood relation)"),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    height: 70,
                    child:Form(
                        key: formkeyMobileNo,
                        child: TextFormField(controller: empEmergencyContactNo_Controller,
                          validator: validateMobile,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],

                          decoration: InputDecoration(
                            //errorText: errorMsg_MobileNumber,
                            //labelText: errorMsg_MobileNumber,
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 5, left: 10),
                            hintText: "mobile no",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            empEmergencyContactNo=value;

                          },

                        )),
                  ),

                ],
              ),

            ),
          ],
        )
    );
  }

  Container create_BloodRelation_name() {
    return  Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              // decoration: Style_UploadInvestment_Inner,
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child:showTextNameWithAstrict("Emergency Contact Relation"),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    width: double.maxFinite,
                    height: 46,
                    padding: EdgeInsets.fromLTRB(10,0,10,0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    child:DropdownButton(
                      // hint: Text('Select'),
                      icon: Icon(Icons.arrow_drop_down),
                      dropdownColor: Colors.white,
                      underline: DropdownButtonHideUnderline(child: Container()),
                      iconSize: 25,
                      isExpanded: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: select_BloodRelationType,
                      onChanged: (newValue){
                        setState(() {
                          select_BloodRelationType!=newValue;

                        });
                      },
                      items: listItem_BloodRelationType.map((valueItem)
                      {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                  ),

                ],
              ),

            ),
          ],
        )
    );
  }


  Container create_CurrrentAddress() {
    return  Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child:showTextNameWithAstrict("Current Address/Residental Address"),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    height: 80,
                    child: TextField(controller: empCurrentAddress_Controller,
                      maxLength: 500,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z /,.-]")),
                      ],
                      maxLines: 2,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.only(
                            top: 10, left: 10),
                        hintText: "address",
                        border:
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0)),
                      ),
                      onChanged: (value)
                      {
                        empCurrentAddress=value;
                        checkEmpCurrentAddress(value);
                      },

                    ),
                  ),

                ],
              ),

            ),
          ],
        )
    );
  }

  checkEmpCurrentAddress(String acNo)
  {
    if(acNo.length>1) {
      var comma = acNo.split(",,");
      var forwardslash = acNo.split("//");
      var dots = acNo.split("..");
      var dash = acNo.split("--");
      String zeroCheck = acNo.substring(0, 2);

      if (comma.length>1 || forwardslash.length>1 || dots.length>1 || dash.length>1 || zeroCheck=="00")
      {
        empCurrentAddress_Controller.text=acNo;
        empCurrentAddress=acNo;

        //print(('show true $acNo'));
        show_OKAlert("Enter Valid Current Address");

      }
      else
      {
        empCurrentAddress=acNo;
        //print(('show false $acNo'));

      }
    }
  }
  Container create_PermanentAddress() {
    return  Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child:showTextNameWithAstrict("Permanent Address"),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    height: 80,
                    child: TextField(controller: empPermanentAddress_Controller,
                      enabled: permanentAddressEnableStatus,
                      maxLength: 500,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z /,.-]")),
                      ],
                      maxLines: 2,
                      decoration: InputDecoration(
                        fillColor: permanentAddressColor,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.only(
                            top: 10, left: 10),
                        hintText: "address",
                        border:
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0)),
                      ),
                      onChanged: (value)
                      {
                        empPermanentAddress=value;

                        checkEmpPermanentAddress(value);
                      },

                    ),
                  ),

                ],
              ),

            ),
          ],
        )
    );
  }

  checkEmpPermanentAddress(String acNo)
  {
    if(acNo.length>1) {
      var comma = acNo.split(",,");
      var forwardslash = acNo.split("//");
      var dots = acNo.split("..");
      var dash = acNo.split("--");
      String zeroCheck = acNo.substring(0, 2);

      if (comma.length>1 || forwardslash.length>1 || dots.length>1 || dash.length>1 || zeroCheck=="00")
      {
        empPermanentAddress_Controller.text=acNo;
        empPermanentAddress=acNo;

        //print(('show true $acNo'));
        show_OKAlert("Enter Valid Permanent Address");

      }
      else
      {
        empPermanentAddress=acNo;

        //print(('show false $acNo'));

      }
    }
  }
  Container create_Father_Husband() {
    return  Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20,bottom: 30),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child:showTextNameWithAstrict("Father/Husband"),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    height: 80,
                    child: TextField(controller: empFatherName_Controller,
                      maxLength: 100,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                      ],
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.only(
                            top: 5, left: 10),
                        hintText: "Father/Husband",
                        border:
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0)),
                      ),
                      onChanged: (value)
                      {
                        empFatherName=value;
                      },

                    ),
                  ),

                ],
              ),

            ),
          ],
        )
    );
  }


  Container create_Save_Lock_Buttons()
  {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only( top: 17),
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(0.0),
              ),
              padding: const EdgeInsets.only(left: 40, right: 40,bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(
                    width: 100,
                    height: 35,
                    decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: new BorderRadius.circular(5.0),
                        border: Border.all(color: primaryColor,
                            width: 1.0,
                            style: BorderStyle.solid)
                    ),
                    child: Material(
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(5.0),
                      color: primaryColor,
                      child:MaterialButton(
                          minWidth: 50,
                          // height: 10,
                          onPressed: ()
                          {
                            validateToTheFields("1");
                          },
                          child: Text('Save as Draft',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 13))
                      ),
                    ),
                  ),

                  Container(
                    width: 100,
                    height: 35,
                    decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: new BorderRadius.circular(5.0),
                        border: Border.all(color: primaryColorLightBlue,
                            width: 1.0,
                            style: BorderStyle.solid)
                    ),
                    child:  Material(
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(5.0),
                      color: primaryColorLightBlue,
                      child:MaterialButton(
                          minWidth: 50,
                          // height: 10,
                          onPressed: ()
                          {
                            validateToTheFields("2");

                          },
                          child: Text('Submit',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 13))
                      ),
                    ),
                  ),

                ],
              ),

            ),
          ],
        )
    );
  }

  SizedBox create_Gap(){
    return SizedBox(
      height: 2,
    );
  }

  SizedBox create_BottomGap(){
    return SizedBox(
      height: 15,
    );
  }

  show_SaveandLock_Alert(String message)
  {
    var alertDialog = AlertDialog(
      content: Text(message,
        textAlign: TextAlign.left,),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [

        TextButton(onPressed: ()
        {
          Navigator.of(context).pop();

          saveProfilePersonalDetails("2","true");

        },

          child: Text("YES",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
        TextButton(onPressed: ()
        {
          Navigator.of(context).pop();

        },

          child: Text("NO",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
      ],

    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }
/*------------load default data 17-1-20222 start------------------*/

  setEmpName(String obj)
  {
    setState(() {
      empName_Controller.text=obj;
      empName=obj;
    });
  }
  setEmpEmailId(String obj)
  {
    setState(() {
      empEmailId_Controller.text=obj;
      empEmailId=obj;
    });
  }
  setEmpDateOfBirth(String obj)
  {
    setState(() {
      empDateOfBirth=obj;

    });
  }
  setEmpGender(String obj)
  {
    setState(() {
      empGender=obj;
      selectedGenderType=obj;

      if(obj.trim()=="Male")
      {
        maleVal=true;
        femaleVal=false;
      }
      else
      {
        maleVal=false;
        femaleVal=true;
      }
    });
  }
  setEmpMobileNo(String obj)
  {
    setState(() {
      empMobileNo_Controller.text=obj;
      empMobileNo=obj;
    });
  }
  setEmpAddress(String obj)
  {
    /*setState(() {
      empPermanentAddress_Controller.text=obj;
      empPermanentAddress=obj;


    });*/
  }
  setEmpAadhaarCardPermanentAddress(String obj)
  {
    setState(() {
      empPermanentAddress_Controller.text=obj;
      empPermanentAddress=obj;


    });
  }

  setEmpFatherHusbandName(String obj)
  {
    setState(() {
      empFatherName_Controller.text=obj;
      empFatherName=obj;
    });
  }


  showTextNameWithAstrict(String textName)
  {
    return Text.rich(
      TextSpan(
        text: textName,
        children: <InlineSpan>[
          TextSpan(
            text: '*',
            style: TextStyle(color: Colors.red,fontSize: 13),
          ),
        ],
        style: TextStyle(color: primaryColor,fontSize: 13),
      ),
    );
  }
  /*------------load default data 17-1-20222 end------------------*/

  getBasicInfo()
  {

    //String dec=getDecryptedData("yzfrzfVGgvjH4mV8YpDXqcwHgwrXN/6ywgbeZ3HXxFCGJFjVyjzViycm7Ithz+O8");
    ////print('show the new key $dec');

    SharedPreference.getKYC_STATUSCode().then((value) =>  {
      KYCStatusCode=value
    });

    SharedPreference.getPANCard_STATUS().then((value) =>  {
      panCardStatus=value
    });
    SharedPreference.getAadhaarCard_STATUS().then((value) =>  {
      aadhaarCardStatus=value
    });


    SharedPreference.getEmpName().then((value) =>  {
      setEmpName(value)
    });
    SharedPreference.getEmpEmailId().then((value) =>  {
      setEmpEmailId(value)
    });
    SharedPreference.getEmpDateOfBirth().then((value) =>  {
      setEmpDateOfBirth(value)
    });
    SharedPreference.getEmpGender().then((value) =>  {
      setEmpGender(value)
    });
    SharedPreference.getEmpMobileNo().then((value) =>  {
      setEmpMobileNo(value)
    });
    SharedPreference.getEmpAddress().then((value) =>  {
      setEmpAddress(value)
    });

    SharedPreference.getEmp_AadhaarCard_PermanentAddress().then((value) =>  {
      setEmpAadhaarCardPermanentAddress(value)
    });
    SharedPreference.getEmp_AadhaarCard_FatherName().then((value) =>  {
      setEmpFatherHusbandName(value)
    });



    String mobileNumber_key="",jsId_key="",empCode="",
        empDateOfBirth_key="";

    SharedPreference.getEmpMobileNo().then((value) =>  {
      mobileNumber_key=value,
      //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpCode().then((value) =>  {
      empCode=value,
      //print('show emp empCode $value'),
    });

    SharedPreference.getJSId().then((value) =>  {
      jsId_key=value,
      //print('show emp jsId $value'),
    });


    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth_key=value,
      //print('show emp name2 $value'),
      complete_JSId = mobileNumber_key+"CJHUB"+jsId_key+"-"+empCode+"CJHUB"+empDateOfBirth_key,
      //print('show complete_JSId $complete_JSId'),

      getProfilePersonalDetails()

    });

  }

  getProfilePersonalDetails() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.get_PersonalDetails),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'js_id': getEncrypted_EmpCode(complete_JSId),
        },
      );

      //print(response.statusCode);
      if (response.statusCode == 200)
      {

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        profileDetailsJS_ModelResponse = GetProfileDetailsJS_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(profileDetailsJS_ModelResponse!.statusCode==true)
        {

          /*  var empGender;
          var espivStatus;
          var empMaritalStatus;*/

          if(profileDetailsJS_ModelResponse!.data!.length>0) {
            setState(()
            {

              select_SalutationType=profileDetailsJS_ModelResponse!.data![0].empSalutations;
              if(select_SalutationType==""||select_SalutationType==null)
              {
                select_SalutationType="Mr.";
              }

//*-----------------25-3-2022 start-------------------*/
              if(empName == "" || empName == null)
              {
                empName=profileDetailsJS_ModelResponse!.data![0].empName;
                empName_Controller.text =
                    profileDetailsJS_ModelResponse!.data![0].empName;
              }
              if(KYCStatusCode=="0")
              {
                empNameEnableStatus=true;
                empNameColor = Colors.white;
              }
              else
              {
                empNameEnableStatus=false;
                empNameColor = Colors.black12;
              }


              if(KYCStatusCode=="2" || KYCStatusCode=="3")
              {
                permanentAddressEnableStatus=false;
                permanentAddressColor = Colors.black12;
              }
              else
              {
                permanentAddressEnableStatus=true;
                permanentAddressColor = Colors.white;
              }

//*-----------------25-3-2022 end-------------------*/

              var profileObj=profileDetailsJS_ModelResponse!.data![0];

              empEmailId=profileObj.empEmail;
              empEmailId_Controller.text =
                  profileObj.empEmail;


              empMobileNo=profileObj.empMobile;
              empMobileNo_Controller.text =
                  profileObj.empMobile;

              select_BloodRelationType=profileObj.empEmeConBloodRelName;
              if(select_BloodRelationType==""||select_BloodRelationType==null)
              {
                select_BloodRelationType="Father";
              }


              empEmergencyContactNo=profileObj.empEmergencyContact;
              empEmergencyContactNo_Controller.text =
                  profileObj.empEmergencyContact;

              empCurrentAddress=profileObj.empResidentialAddress;
              empCurrentAddress_Controller.text =
                  profileObj.empResidentialAddress;

              //print('show empCurrentAddress $empCurrentAddress');

              if(KYCStatusCode=="2" || KYCStatusCode=="3")
              {

                var getPerAddress=profileObj.empAddress;
                if(empPermanentAddress=="" || empPermanentAddress==null)
                {
                  empPermanentAddress=getPerAddress;
                  empPermanentAddress_Controller.text = getPerAddress;
                }
                else
                {
                  if(getPerAddress=="" || getPerAddress==null)
                  {
                    empPermanentAddress=getPerAddress;
                    empPermanentAddress_Controller.text = getPerAddress;
                  }
                }



                if(empDateOfBirth=="" || empDateOfBirth==null)
                {
                  empDateOfBirth=profileObj.empDob;
                  empDateOfBirth =
                      profileObj.empDob;
                }

              }
              else
              {

                empDateOfBirth=profileObj.empDob;
                empDateOfBirth =
                    profileObj.empDob;


                empPermanentAddress=profileObj.empAddress;
                empPermanentAddress_Controller.text =
                    profileObj.empAddress;
              }



              /*------3-8-2022 start---------*/

              /*------5-8-2022 start---------*/

              var getFatherName=profileObj.empFatherName;
              if(empFatherName=="" || empFatherName==null)
              {
                empFatherName=getFatherName;
                empFatherName_Controller.text = getFatherName;
              }
              else
              {
                if(getFatherName=="" || getFatherName==null)
                {
                  empFatherName=getFatherName;
                  empFatherName_Controller.text = getFatherName;
                }
              }
/*------5-8-2022 end---------*/
               /*------3-8-2022 end---------*/

              if(profileObj.espivStatus=="2")
              {
                /*---use for hide the save and lock button--*/
                saveLockButton_VisibilityStatus=false;
              }


              if(KYCStatusCode=="2" || KYCStatusCode=="3")
              {
                if(selectedGenderType=="" || selectedGenderType==null)
                {
                  selectedGenderType=profileObj.empGender;

                }
              }
              else
              {
                selectedGenderType=profileObj.empGender;
              }

              if(selectedGenderType=="Female")
              {
                //Female
                femaleVal=true;
                maleVal=false;
              }
              else
              {
                //Male
                femaleVal=false;
                maleVal=true;
              }

              selectedMaritalStatus=profileObj.empMaritalStatus;
              if(selectedMaritalStatus=="Married")
              {
                //Married
                marriedVal=true;
                un_marriedVal=false;

              }
              else
              {
                //Single
                marriedVal=false;
                un_marriedVal=true;
              }

            });
          }

        }
        else
        {
          if (profileDetailsJS_ModelResponse!.message==null || profileDetailsJS_ModelResponse!.message=="")
          {
            show_OKAlert("server error!");

          }else {
            show_OKAlert(profileDetailsJS_ModelResponse!.message!);
          }
        }

        EasyLoading.dismiss();


      } else {

        EasyLoading.dismiss();

        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      //print(e);
    }
  }

  bool removeTheWhitespace(String spaceValue)
  {
    String output = spaceValue.trim();
    if(output=='')
    {
      return true;
    }
    else
    {
      return false;

    }

  }

/*----------------------18-2-2022 start-----------------------*/
  validateToTheFields(String esvStatus)
  {

    if(empName.trim().length>=3)
    {
      checkvalidateEmailId();
      if(checkEmailIdStatus==true)
      {
        if(empDateOfBirth != "")
        {
          if (maleVal != false || femaleVal != false)
          {
            if (marriedVal != false || un_marriedVal != false)
            {
              if(esvStatus=="1")
              {
                /*-------------use for save the records 18-2-2022-------------*/
                checkTheEmergencyMobileNo(esvStatus);
              }
              else
              {
                /*-------------use for save & lock the records 18-2-2022-------------*/
                validateMobileNumber();
                if (checkMobileStatus_bool == true)
                {
                  if(empEmergencyContactNo != empMobileNo)
                  {

                    if (empCurrentAddress
                        .trim()
                        .length >= 3) {
                      if (empPermanentAddress
                          .trim()
                          .length >= 3) {
                        if (empFatherName
                            .trim()
                            .length >= 3) {
                          show_SaveandLock_Alert(
                              "Do you want to submit? You can't edit your profile data after save & lock.");
                        }
                        else {
                          show_OKAlert(
                              "Enter Complete Father/Husband Name");
                        }
                      }
                      else {
                        show_OKAlert("Enter Complete Permanent Address");
                      }
                    }
                    else {
                      show_OKAlert("Enter Complete Current Address");
                    }

                  }
                  else
                  {
                    show_OKAlert("Emergency contact number can't be same as primary mobile number.");

                  }


                }
                else {
                  show_OKAlert(mobileNumber_ErrorMsg);
                }
              }

            }
            else {
              show_OKAlert("Select Marital Status");
            }
          }
          else {
            show_OKAlert("Select Gender Type");
          }
        }
        else
        {
          show_OKAlert("Please Select The Date Of Birth");
        }
      }
      else
      {
        show_OKAlert(emailId_ErrorMsg);
      }
    }
    else
    {
      show_OKAlert("Enter Name as per Aadhaar Card");
    }
  }

  /*------------22-2-2022 start----------------*/
  checkTheEmergencyMobileNo(String esvStatus)
  {
    int  gg=empFatherName.length;
    //print('show length $gg');

    if(empEmergencyContactNo != "")
    {
      validateMobileNumber();
      if (checkMobileStatus_bool == true)
      {
        if(empEmergencyContactNo != empMobileNo)
        {
          checkTheDefaultFieldValidation(esvStatus);
        }
        else
        {
          show_OKAlert("Emergency contact number can't be same as primary mobile number.");

        }
      }
      else
      {
        show_OKAlert(mobileNumber_ErrorMsg);
      }
    }
    else
    {
      show_OKAlert("Enter Emergency contact number.");

    }
  }

  checkTheDefaultFieldValidation(String esvStatus)
  {

    if (empCurrentAddress.length == 0 || empCurrentAddress
        .trim()
        .length >= 3) {
      if (empPermanentAddress.length == 0 || empPermanentAddress
          .trim()
          .length >= 3) {
        if (empFatherName.length == 0 || empFatherName
            .trim()
            .length >= 3) {
          saveProfilePersonalDetails(esvStatus,"true");
        }
        else {
          show_OKAlert("Enter Complete Father/Husband Name");
        }
      }
      else {
        show_OKAlert("Enter Complete Permanent Address");
      }
    }
    else {
      show_OKAlert("Enter Complete Current Address");
    }

  }

  /*------------22-2-2022 end----------------*/

  /*----------------------18-2-2022 end-----------------------*/

  saveProfilePersonalDetails(String esvStatus,String loaderStatus) async
  {
    //print("show panCardStatus $panCardStatus");
    //print("show panCardStatus new $panCardStatus");

    //print("show aadhaarCardStatus $aadhaarCardStatus");

    //print("show salutaion $select_SalutationType");
    String getid=getEncrypted_EmpCode(complete_JSId);
    //print("show salutaion $select_SalutationType");
    //print("show getEncrypted_EmpCode $getid");

    if(loaderStatus=="true") {
      EasyLoading.show(status: Message.get_LoaderMessage);
    }

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.save_PersonalDetails),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'js_id': getEncrypted_EmpCode(complete_JSId),
          'emp_salutations': select_SalutationType,
          'emp_name': empName,
          'emp_email': empEmailId,
          'emp_dob': empDateOfBirth,
          'emp_gender': selectedGenderType,
          'emp_father_name': empFatherName,
          'emp_residential_address': empCurrentAddress,
          'emp_marital_status': selectedMaritalStatus,
          'emp_address': empPermanentAddress,
          'emp_emergency_contact': empEmergencyContactNo,
          'espiv_status': esvStatus,
          'emp_eme_con_blood_rel_name': select_BloodRelationType,
          'panCardStatus': panCardStatus,
          'aadhaarCardStatus':aadhaarCardStatus

        },
      );


      //print(response.statusCode);
      if (response.statusCode == 200)
      {

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        profileDetailsJS_ModelResponse = GetProfileDetailsJS_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(profileDetailsJS_ModelResponse!.statusCode==true)
        {

          SharedPreference.setEmpGender(selectedGenderType);
          SharedPreference.setEmpAddress(empCurrentAddress);
          SharedPreference.setEmp_AadhaarCard_PermanentAddress(empPermanentAddress);

          SharedPreference.setEmpFatherName(empFatherName);
          SharedPreference.setEmpDateOfBirth(empDateOfBirth);
          SharedPreference.setEmpEmailId(empEmailId);
          SharedPreference.setEmpName(empName);



          setState(() {
            if(esvStatus=="2")
            {
              /*---use for hide the save and lock button--*/
              saveLockButton_VisibilityStatus=false;
            }
          });

          if(loaderStatus=="true") {
            show_SuccessAlert(profileDetailsJS_ModelResponse!.message!);
          }
        }
        else
        {
          if (profileDetailsJS_ModelResponse!.message==null || profileDetailsJS_ModelResponse!.message=="")
          {
            if(loaderStatus=="true") {
              show_OKAlert("server error!");
            }

          }else
          {
            if(loaderStatus=="true") {
              show_OKAlert(profileDetailsJS_ModelResponse!.message!);
            }
          }
        }

        if(loaderStatus=="true") {
          EasyLoading.dismiss();
        }


      } else {

        if(loaderStatus=="true") {
          EasyLoading.dismiss();
        }


        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      //print(e);
    }
  }

  show_OKAlert(String message)
  {
    /*------SnackBar-----21-07-2022--------start-----------*/

    CJSnackBar(context, message);

/*

    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
*/

    /*-----SnackBar------21-07-2022--------end-----------*/


  }

  show_SuccessAlert(String message)
  {
    var alertDialog = AlertDialog(
      content: Text(message,
        textAlign: TextAlign.left,),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [

        TextButton(onPressed: () {
          Navigator.of(context).pop();

          /*-----------19-11-2022(use)--------*/
/*
          Navigator.push(context, MaterialPageRoute(builder: (_)=>

          Responsive(
              mobile: bottom(),
              tablet: Center(
                child: Container(
                  width: flutterWeb_tabletWidth,
                  child: bottom(),
                ),
              ),
              desktop: Center(
                child: Container(
                  width: flutterWeb_desktopWidth,
                  child: bottom(),
                ),
              ))
              // bottom()

          ));
*/

        },

          child: Text("OK",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
      ],

    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => alertDialog
    );
  }


}