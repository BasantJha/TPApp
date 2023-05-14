import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:http/http.dart'as http;

import '../../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../ModelClasses/CJHubModelClasses/KYC_details_ModelResponse.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff00BFFF)
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
      home: KYC_details_Add_Edit(title: 'CJ Hub'),
    );
  }
}
class KYC_details_Add_Edit extends StatefulWidget {

  KYC_details_Add_Edit({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _KYC_details_Add_Edit createState() => _KYC_details_Add_Edit();
}

class _KYC_details_Add_Edit extends State<KYC_details_Add_Edit> {
  // This widget is the root of your application.
  String _selectedDate = 'Select date';
  //String strDateOfJoining = "Select date";

  double txtFields_Height=70;


  String complete_JSId="";


  KYC_details_ModelResponse? kyc_details_modelResponse;
  String dateOfJoining="",fullName="",panCardNumber="",aadharCardNumber="",
      bankAccountNumber="",confirmBankAccountNumber="",bankBranch="",ifscCode="",bankName="",pfNumber="",uanNumber="",
      esicNumber="";

  var txtController_fullName = TextEditingController();
  var txtController_panCardNumber = TextEditingController();
  var txtController_aadharCardNumber = TextEditingController();
  var txtController_bankAccountNumber = TextEditingController();
  var txtController_confirmBankAccountNumber = TextEditingController();

  var txtController_bankBranch = TextEditingController();
  var txtController_ifscCode = TextEditingController();
  var txtController_bankName= TextEditingController();
  var txtController_pfNumber = TextEditingController();
  var txtController_uanNumber = TextEditingController();
  var txtController_esicNumber = TextEditingController();

  bool saveLockButton_VisibilityStatus=true;



  GlobalKey<FormState> ifscCode_FormKey = GlobalKey<FormState>();
  bool ifscCode_FormKey_bool=false;
  String ifscCode_ErrorMsg="";

  GlobalKey<FormState> pancard_FormKey = GlobalKey<FormState>();
  bool pancard_FormKey_bool=false;
  String pancard_ErrorMsg="";

/*------24-3-2022 start---------*/

  String KYCStatusCode="",panCardStatus="",aadhaarCardStatus="";
  bool empNameEnableStatus=true,panCardEnableStatus=true;
  Color empNameColor = Colors.white;
  Color panCardColor = Colors.white;

/*------24-3-2022 end---------*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBasicInfo();
  }



  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2222),
    );
    if (d != null)
      setState(() {
        _selectedDate = new DateFormat.yMd("en_US").format(d);
        String datePattern = "MM/dd/yyyy";

        var birthDate = DateFormat(datePattern).parse(_selectedDate);
        var outputFormat=  DateFormat("dd/MM/yyyy");
        dateOfJoining= outputFormat.format(birthDate);
        //print("Date of joining: $dateOfJoining");

      });
  }


  String? validate_IFSCCode(String? value)
  {

    String patttern = r"^[A-Z]{4}0[A-Z0-9]{6}$";

    RegExp regExp = new RegExp(patttern);
    if (value!.length == 0) {
      ifscCode_ErrorMsg="Enter IFSC code";
      return ifscCode_ErrorMsg;
    }
    else if(value!.length != 11)
    {
      ifscCode_ErrorMsg="Enter valid IFSC code";
      return ifscCode_ErrorMsg;

    }else if (!regExp.hasMatch(value))
    {
      ifscCode_ErrorMsg="Enter valid IFSC code";
      return ifscCode_ErrorMsg;
    }
    return null;
  }

  void validateIFSCCodeStatus()
  {
    if (ifscCode_FormKey.currentState!.validate())
    {
// No any error in validation
      ifscCode_FormKey_bool=true;
      ifscCode_FormKey.currentState!.save();
    }
    else
    {
// validation error
      setState(()
      {
        ifscCode_FormKey_bool=false;

      });
    }
  }

  String? validate_Pancard(String? value)
  {

    String patttern = r"[A-Z]{5}[0-9]{4}[A-Z]{1}";

    RegExp regExp = new RegExp(patttern);
    if (value!.length == 0) {
      pancard_ErrorMsg="Enter PAN Card";
      return pancard_ErrorMsg;
    }
    else if(value!.length != 10)
    {
      pancard_ErrorMsg="Enter valid PAN Card";
      return pancard_ErrorMsg;

    }else if (!regExp.hasMatch(value))
    {
      pancard_ErrorMsg="Enter valid PAN Card";
      return pancard_ErrorMsg;
    }
    return null;
  }

  void validatePancardStatus()
  {
    if (pancard_FormKey.currentState!.validate())
    {
// No any error in validation
      pancard_FormKey_bool=true;
      pancard_FormKey.currentState!.save();
    }
    else
    {
// validation error
      setState(()
      {
        pancard_FormKey_bool=false;

      });
    }
  }

  @override
  Widget build(BuildContext context)

  {


    return Scaffold(
        backgroundColor: Colors.white,
        appBar:CJAppBar(getCJHUB_TEC_BankDetails, appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action type");
          Navigator.pop(context);
          save_KYC_Details("1", "false");
        })),


        body: WillPopScope(
          child: SingleChildScrollView(
            child: Column(children: <Widget>[

              create_headingContainer("Update KYC Details" ), //heading


              create_DateOfJoining(),    //Emp_Joining

              create_Full_name(),

              create_PANCardNo(),     //Emp_panCardNo

              create_BankName(),     //Emp_BankName

              create_BankAccountNo(),  //Emp_bankAccountNo

              create_confirmBankAccountNo(), //Emp_ConfrimAccount

              create_IFSC_Code(), //Emp_IfscCode

              create_ESICNumber(), //Emp_ESICNumber

              create_UANNumber(), //Emp_UAN



              create_Gap(),
              create_Gap(),
              create_Gap(),
              create_Gap(),



              Visibility(visible: saveLockButton_VisibilityStatus,
                child:Container(
                  child: create_Save_Lock_Buttons(),
                ),
              ),

              create_BottomGap(),



            ]),
          ),
          /*onWillPop: ()
          {
            save_KYC_Details("1", "false");
            Message.alert_dialogAppExit(context);

          } ,*/
          onWillPop: () async => false,
        )
    );
  }



  Container create_headingContainer(String value){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,20,0,20),
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

  Container create_DateOfJoining() {
    return   Container(
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
                      child: Text("Date Of Joining",style: TextStyle(color: primaryColor,fontSize: 13),),
                    ),
                  ),

                  SizedBox(
                    height: 3,
                  ),

                  Container(
                    height: txtFields_Height-20,
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.black12,
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
                                    dateOfJoining,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black)
                                ),

                                onTap: (){

                                  //_selectDate(context);
                                },
                              ),
                              MaterialButton(
                                  minWidth: 5,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed:() {
                                    //_selectDate(context);
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
                    child: TextFormField(controller: txtController_fullName,
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
                        fullName=value;

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

  Container create_PANCardNo() {
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
                      child: showTextNameWithAstrict("PAN Card"),
                    ),
                  ),

                  SizedBox(
                    height: 3,
                  ),

                  Container(
                    height: txtFields_Height,
                    child:Form(
                        key: pancard_FormKey,
                        child: TextFormField(
                          controller: txtController_panCardNumber,
                          validator: validate_Pancard,
                          enabled: panCardEnableStatus,
                          maxLength: 10,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),

                          ],
                          decoration: InputDecoration(
                            fillColor: panCardColor,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 5, left: 10),
                            hintText: "pan card no",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            panCardNumber=value;
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


  Container create_BankAccountNo() {
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
                      child: showTextNameWithAstrict("Bank Account Number"),
                    ),
                  ),

                  SizedBox(
                    height: 3,
                  ),

                  Container(
                    height: txtFields_Height,
                    child: TextField(
                      controller: txtController_bankAccountNumber,
                      maxLength: 18,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      obscureText: false,
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
                        hintText: "bank account no",
                        border:
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0)),
                      ),
                      onChanged: (value)
                      {
                        bankAccountNumber=value;

                        //checkBankAccountNo(value);

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

  Container create_confirmBankAccountNo() {
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
                        child: showTextNameWithAstrict("Confirm Bank Account\nNumber"),
                      ),
                    ),

                    SizedBox(
                      height: 3,
                    ),

                    Container(
                      height: txtFields_Height,
                      child: TextField(
                        controller: txtController_confirmBankAccountNumber,
                        maxLength: 18,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        obscureText: true,
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
                          hintText: "confrim bank account no",
                          border:
                          OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2.0)),
                        ),
                        onChanged: (value)
                        {
                          confirmBankAccountNumber=value;
                        },
                      ),
                    ),

                  ],
                )
            ),
          ],
        )
    );
  }

  Container create_IFSC_Code() {
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
                      child: showTextNameWithAstrict("IFSC Code"),
                    ),
                  ),

                  SizedBox(
                    height: 3,
                  ),

                  Container(

                      height: txtFields_Height,
                      child:Form(
                        key: ifscCode_FormKey,
                        child: TextFormField(
                          controller: txtController_ifscCode,
                          validator: validate_IFSCCode,

                          maxLength: 11,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9A-z]")),
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
                            hintText: "ifsc code",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            ifscCode=value;
                          },
                        ),
                      )),


                ],
              ),
            ),
          ],
        )
    );
  }

  Container create_BankName() {
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
                        child: showTextNameWithAstrict("Bank Name"),
                      ),
                    ),

                    SizedBox(
                      height: 3,
                    ),

                    Container(
                      height: txtFields_Height,
                      child: TextFormField(
                        controller: txtController_bankName,
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
                          hintText: "bank name",
                          border:
                          OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2.0)),
                        ),
                        onChanged: (value)
                        {
                          bankName=value;
                        },

                      ),
                    ),

                  ],
                )
            ),
          ],
        )
    );
  }

  Container create_UANNumber() {
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
                      child: Text("UAN Number",style: TextStyle(color: primaryColor,fontSize: 13),),
                    ),
                  ),

                  SizedBox(
                    height: 3,
                  ),

                  Container(

                    height: txtFields_Height,
                    child: TextField(
                      controller: txtController_uanNumber,
                      maxLength: 12,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
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
                        hintText: "uan number",
                        border:
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0)),
                      ),
                      onChanged: (value)
                      {
                        uanNumber=value;
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

  Container create_ESICNumber() {
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
                        child: Text("ESIC Number",style: TextStyle(color: primaryColor,fontSize: 13),),
                      ),
                    ),

                    SizedBox(
                      height: 3,
                    ),

                    Container(
                      height: txtFields_Height,
                      child: TextField(
                        controller: txtController_esicNumber,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
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
                          hintText: "esic number",
                          border:
                          OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2.0)),
                        ),
                        onChanged: (value)
                        {
                          esicNumber=value;
                        },
                      ),
                    ),

                  ],
                )
            ),
          ],
        )
    );
  }

/*  checkBankAccountNo(String acNo)
  {
    if(acNo.length>1)
    {
      String acno = acNo.substring(0, 2);
      if (acno == "00")
      {
        txtController_bankAccountNumber.text=acno;
        bankAccountNumber=acNo;

        //print(('show true $acno'));
        show_OKAlert("Enter Valid Bank A/C Number");

      }
      else
      {
        bankAccountNumber=acNo;

        //print(('show false $acno'));

      }
    }
  }*/


  /*-------------4-4-2022 start---old code start-----------*/
  /* Container create_DateOfJoining_Full_name() {
    return  Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [


                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: Text("\nDate Of Joining",style: TextStyle(color: primaryColor,fontSize: 13),),
                        ),
                      ),

                      SizedBox(
                        height: 3,
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        height: txtFields_Height-20,
                        child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.black12,
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
                                        dateOfJoining,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black)
                                    ),

                                    onTap: (){
                                      *//*--------19-2-2022 start dateofjoining read only discuss with yatendra sir-------*//*

                                      //_selectDate(context);
                                    },
                                  ),
                                  MaterialButton(
                                      minWidth: 5,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed:() {
                                        *//*--------19-2-2022 start dateofjoining read only discuss with yatendra sir-------*//*
                                        //_selectDate(context);
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
                  Column(
                    children: [


                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: showTextNameWithAstrict("Name as per Aadhaar\nCard"),
                          //child:  Text("Name as per Aadhaar Card",style: TextStyle(color: primaryColor,fontSize: 13),),

                        ),
                      ),

                      SizedBox(
                        height: 3,
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        height: txtFields_Height,
                        child: TextField(controller: txtController_fullName,
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
                            fullName=value;
                          },

                        ),
                      ),



                    ],
                  )



                ],
              ),

            ),
          ],
        )
    );
  }

  checkBankAccountNo(String acNo)
  {
    if(acNo.length>1) {
      String acno = acNo.substring(0, 2);
      if (acno == "00")
      {
        txtController_bankAccountNumber.text=acno;
        bankAccountNumber=acNo;

        //print(('show true $acno'));
        show_OKAlert("Enter Valid Bank A/C Number");

      }
      else
        {
          bankAccountNumber=acNo;

        //print(('show false $acno'));

      }
    }
  }

  Container create_BankAccountNo_confirmBankAccountNo() {
    return  Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10,top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: showTextNameWithAstrict("Bank Account\nNumber"),
                        ),
                      ),

                      SizedBox(
                        height: 3,
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        height: txtFields_Height,
                        child: TextField(controller: txtController_bankAccountNumber,
                          maxLength: 18,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          obscureText: false,
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
                            hintText: "bank account no",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            bankAccountNumber=value;

                            checkBankAccountNo(value);

                          },
                        ),
                      ),


                    ],
                  ),
                  Column(
                    children: [

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: showTextNameWithAstrict("Confirm Bank Account\nNumber"),
                        ),
                      ),

                      SizedBox(
                        height: 3,
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        height: txtFields_Height,
                        child: TextField(controller: txtController_confirmBankAccountNumber,
                          maxLength: 18,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          obscureText: true,
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
                            hintText: "confrim bank account no",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            confirmBankAccountNumber=value;
                          },
                        ),
                      ),

                    ],
                  )

                ],
              ),

            ),
          ],
        )
    );
  }

  Container create_PanCard_BankName() {
    return  Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10,top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [


                  Column(
                    children: [


                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: showTextNameWithAstrict("PAN Card"),
                        ),
                      ),

                      SizedBox(
                        height: 3,
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        height: txtFields_Height,
                        child:Form(
                            key: pancard_FormKey,
                            child: TextFormField(controller: txtController_panCardNumber,
                              validator: validate_Pancard,
                              enabled: panCardEnableStatus,
                              maxLength: 10,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.characters,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),

                              ],
                              decoration: InputDecoration(
                                fillColor: panCardColor,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 5, left: 10),
                                hintText: "pan card no",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),
                              onChanged: (value)
                              {
                                panCardNumber=value;
                              },

                            )),
                      ),

                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: showTextNameWithAstrict("Bank Name"),
                        ),
                      ),

                      SizedBox(
                        height: 3,
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        height: txtFields_Height,
                        child: TextFormField(controller: txtController_bankName,
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
                            hintText: "bank name",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            bankName=value;
                          },

                        ),
                      ),

                    ],
                  )





                ],
              ),

            ),
          ],
        )
    );
  }

  Container create_IFSCCode_ESICNumber() {
    return  Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10,top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: showTextNameWithAstrict("IFSC Code"),
                        ),
                      ),

                      SizedBox(
                        height: 3,
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        height: txtFields_Height,
                        child:Form(
                          key: ifscCode_FormKey,
                        child: TextFormField(controller: txtController_ifscCode,
                          validator: validate_IFSCCode,

                          maxLength: 11,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9A-z]")),
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
                            hintText: "ifsc code",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            ifscCode=value;
                          },
                        ),
                      )),


                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: Text("ESIC Number",style: TextStyle(color: primaryColor,fontSize: 13),),
                        ),
                      ),

                      SizedBox(
                        height: 3,
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        height: txtFields_Height,
                        child: TextField(controller: txtController_esicNumber,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
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
                            hintText: "esic number",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            esicNumber=value;
                          },
                        ),
                      ),

                    ],
                  )


                ],
              ),

            ),
          ],
        )
    );
  }

  Container create_UANNumber() {
    return  Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10,top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: Text("UAN Number",style: TextStyle(color: primaryColor,fontSize: 13),),
                        ),
                      ),

                      SizedBox(
                        height: 3,
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        height: txtFields_Height,
                        child: TextField(controller: txtController_uanNumber,
                          maxLength: 12,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
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
                            hintText: "uan number",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            uanNumber=value;
                          },
                        ),
                      ),

                    ],
                  ),
                  *//*Column(
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: Text("ESIC Number",style: TextStyle(color: primaryColor,fontSize: 13),),
                        ),
                      ),

                      SizedBox(
                        height: 3,
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        height: txtFields_Height,
                        child: TextField(controller: txtController_esicNumber,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
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
                            hintText: "esic number",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            esicNumber=value;
                          },
                        ),
                      ),

                    ],
                  )*//*

                ],
              ),

            ),
          ],
        )
    );
  }*/


  /*-------------4-4-2022 start---old code end-----------*/





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
              padding: const EdgeInsets.only(left: 40, right: 40),
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

  SizedBox create_BottomGap(){
    return SizedBox(
      height: 25,
    );
  }
  SizedBox create_Gap(){
    return SizedBox(
      height: 5,
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
          save_KYC_Details("2","true");

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
  loadEmpName(String name)
  {
    setState(() {
      fullName=name;
      txtController_fullName.text=name;
    });
  }
  loadPanCard(String panCard)
  {
    setState(() {
      panCardNumber=panCard;
      txtController_panCardNumber.text=panCard;
    });
  }
  getBasicInfo()
  {

    SharedPreference.getKYC_STATUSCode().then((value) =>  {
      KYCStatusCode=value,
    });

    SharedPreference.getPANCard_STATUS().then((value) =>  {
      panCardStatus=value
    });
    SharedPreference.getAadhaarCard_STATUS().then((value) =>  {
      aadhaarCardStatus=value
    });

    SharedPreference.getEmpPanCardNumber().then((value) =>  {
      loadPanCard(value)
    });


    SharedPreference.getEmpName().then((value) =>  {
      fullName=value,
      //print('show emp mobilenumber $value'),
      loadEmpName(value)

    });

    String mobileNumber_key="",jsId_key="",empCode="",
        empDateOfBirth_key="";

    SharedPreference.getEmpMobileNo().then((value) =>  {
      mobileNumber_key=value,
      //print('show emp mobilenumber $value'),
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
      //print('show emp dateofbirth $value'),
      complete_JSId = mobileNumber_key+"CJHUB"+jsId_key+"-"+empCode+"CJHUB"+empDateOfBirth_key,
      //print('show complete_JSId $complete_JSId'),
      view_KYC_Details()

    });

  }


  view_KYC_Details() async
  {

    String encryptedKey=getEncrypted_EmpCode(complete_JSId);
    //print('show js_id encryptedKey $encryptedKey');
    //print('show js_id encryptedKey $complete_JSId');

    /* String decryptedKey=getDecryptedData("9/OvrWKfqkaSkWRgnuo7KCceC3PONFYiwfUuZg3+19/DEMT7ip/ywV2o3iXVyMpt");
    //print('show js_id decryptedKey $decryptedKey');
*/

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.get_KYCDetails),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },

        body: {
          'js_id': getEncrypted_EmpCode(complete_JSId),
        },

      );
      //print(response.statusCode);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        kyc_details_modelResponse = KYC_details_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(kyc_details_modelResponse?.statusCode==true)
        {


          if(kyc_details_modelResponse!.data!.length > 0)
          {
            setState(() {

              dateOfJoining=kyc_details_modelResponse!.data![0].dateOfJoining;


              /*-----------------25-3-2022 start-------------------*/

              if(fullName=="" || fullName==null)
              {
                String fullNamedummy=kyc_details_modelResponse!.data![0].empName;
                fullName=fullNamedummy;
                txtController_fullName.text=fullNamedummy;

              }


              if(KYCStatusCode=="0")
              {
                empNameEnableStatus=true;
                empNameColor = Colors.white;

                panCardEnableStatus=true;
                panCardColor = Colors.white;
              }
              else
              {
                empNameEnableStatus=false;
                empNameColor = Colors.black12;

                if(panCardStatus=="1")
                {
                  panCardEnableStatus = false;
                  panCardColor = Colors.black12;
                }else
                {
                  panCardEnableStatus=true;
                  panCardColor = Colors.white;
                }
              }
              /*-----------------25-3-2022 end-------------------*/


              if(panCardNumber=="" || panCardNumber==null)
              {
                String panCard=kyc_details_modelResponse!.data![0].panCard;
                panCardNumber=panCard;
                txtController_panCardNumber.text=panCard;

                panCardEnableStatus=true;
                panCardColor = Colors.white;
              }




              var obj=kyc_details_modelResponse!.data![0];
              // txtController_aadharCardNumber.text=kyc_details_modelResponse.data[0].aadharCard;
              txtController_bankAccountNumber.text=obj.bankAccountNo;
              bankAccountNumber=obj.bankAccountNo;

              txtController_confirmBankAccountNumber.text=obj.bankAccountNo;
              confirmBankAccountNumber=obj.bankAccountNo;

              txtController_ifscCode.text=obj.ifscCode;
              ifscCode=obj.ifscCode;

              txtController_bankName.text=obj.bankName;
              bankName=obj.bankName;

              txtController_bankBranch.text=obj.bankBranch;
              bankBranch=obj.bankBranch;

              //txtController_pfNumber.text=kyc_details_modelResponse.data[0].pfNumber;
              //pfNumber=kyc_details_modelResponse.data[0].pfNumber;

              txtController_uanNumber.text=obj.uanNumber;
              uanNumber=obj.uanNumber;

              txtController_esicNumber.text=obj.esiNumber;
              esicNumber=obj.esiNumber;

              String esvStatus=obj.esvStatus;
              if(esvStatus=="1")
              {
                //use for save the records
                saveLockButton_VisibilityStatus=true;
              }
              else if(esvStatus=="2")
              {
                //use for lock records
                saveLockButton_VisibilityStatus=false;

              }
              else
              {

              }

            });


          }
          else
          {
            show_OKAlert("Data not found");

          }

        }
        else
        {
          if (kyc_details_modelResponse!.message==null || kyc_details_modelResponse!.message=="")
          {
            show_OKAlert("server error!");

          }else {
            show_OKAlert(kyc_details_modelResponse!.message!);
          }
        }

      } else {

        EasyLoading.dismiss();

        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }


    catch(e){
      //print(e);
    }

  }

  /*----------------------18-2-2022 start-----------------------*/
  validateToTheFields(String esvStatus)
  {

    if (fullName.trim().length >= 3) {
      validatePancardStatus();
      if (pancard_FormKey_bool==true) {
        if (esvStatus == "1") {
          /*-------------use for save the records 18-2-2022-------------*/
          validateToTheOptionalFields(esvStatus);
        }
        else {
          /*-------------use for save & lock the records 18-2-2022-------------*/
          if (bankName.trim().length>=3) {
            if (bankAccountNumber.trim().length>=9) {
              if (confirmBankAccountNumber.trim().length>=9) {
                if (bankAccountNumber == confirmBankAccountNumber) {
                  validateIFSCCodeStatus();
                  if (ifscCode_FormKey_bool==true) {
                    if (uanNumber.length == 0 || (uanNumber != "000000000000" && uanNumber.trim().length>11)) {
                      if (esicNumber.length == 0 || (esicNumber != "0000000000" && esicNumber.trim().length>9))
                      {

                        show_SaveandLock_Alert(
                            "Do you want to submit? You can't edit your profile data after save & lock.");
                      }
                      else {
                        show_OKAlert("Enter Valid ESIC Number");
                      }
                    }
                    else {
                      show_OKAlert("Enter Valid UAN Number");
                    }
                  }
                  else {
                    show_OKAlert(ifscCode_ErrorMsg);
                  }
                }
                else {
                  show_OKAlert("Enter Correct Confirm A/C Number");
                }
              }
              else {
                show_OKAlert("Enter Confirm Bank A/C Number");
              }
            }
            else {
              show_OKAlert("Enter Bank A/C Number");
            }
          }
          else {
            show_OKAlert("Enter Bank Name");
          }
        }
      }
      else {
        show_OKAlert(pancard_ErrorMsg);
      }
    }
    else {
      show_OKAlert("Enter Full Name");
    }

  }
  validateToTheOptionalFields(String esvStatus)
  {


    if (bankName.length == 0 || bankName.trim().length>=3) {
      if (bankAccountNumber.length == 0 || bankAccountNumber.trim().length>=9) {
        if (confirmBankAccountNumber.length == 0 || confirmBankAccountNumber.trim().length>=9) {
          if (bankAccountNumber == confirmBankAccountNumber) {
            if (uanNumber.length == 0 || (uanNumber != "000000000000" && uanNumber.trim().length>11)) {
              if (esicNumber.length == 0 || (esicNumber != "0000000000" && esicNumber.trim().length>9))
              {
                validateToTheIFSCCode_ForOptional(esvStatus);

              }
              else {
                show_OKAlert("Enter Valid ESIC Number");
              }
            }
            else {
              show_OKAlert("Enter Valid UAN Number");
            }
          }

          else {
            show_OKAlert("Enter Correct Confirm A/C Number");
          }
        }
        else {
          show_OKAlert("Enter Confirm Bank A/C Number");
        }
      }
      else {
        show_OKAlert("Enter Valid Bank A/C Number");
      }
    }

    else {
      show_OKAlert("Enter Valid Bank Name");
    }
  }

  validateToTheIFSCCode_ForOptional(String esvStatus)
  {
    if(ifscCode != "")
    {
      validateIFSCCodeStatus();
      if (ifscCode_FormKey_bool==true)
      {
        save_KYC_Details(esvStatus,"true");

      }
      else
      {
        show_OKAlert(ifscCode_ErrorMsg);
      }
    }
    else
    {
      save_KYC_Details(esvStatus,"true");
    }
  }

  /*----------------------18-2-2022 end-----------------------*/



  save_KYC_Details(String esvStatus,String loaderStatus) async
  {
    /*--------Note---------*/
    //esv_status=1 USE for save the details
    // esv_status=2 use for Lock the data
    // esv_status=3 use for Approve the data


    /*var empName=txtController_fullName.text;
    var panCardNumber=txtController_panCardNumber.text;
    var aadhaarCardNumber=aadharCardNumber;
    var bankName=txtController_bankName.text;
    var bankBranch=txtController_bankBranch.text;
    var bankAccountNumber=txtController_bankAccountNumber.text;
    var ifscCode=txtController_ifscCode.text;
    var pfNumber=txtController_pfNumber.text;
    var uanNumber=txtController_uanNumber.text;
    var esiNumber=txtController_esicNumber.text;*/


    //print('show dateOfJoining $dateOfJoining');
    //print('show panCardStatus $panCardStatus');
    //print('show aadhaarCardStatus $aadhaarCardStatus');


    if(loaderStatus=="true") {
      EasyLoading.show(status: Message.get_LoaderMessage);
    }

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.save_KYCDetails),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },

        body: {
          'js_id':getEncrypted_EmpCode(complete_JSId),
          'expected_doj' : dateOfJoining,
          'emp_name': fullName,
          'pan_card': panCardNumber,
          'aadhar_card': aadharCardNumber,
          'bank_name': bankName,
          'bank_branch': bankBranch,
          'bank_account_no': bankAccountNumber,
          'ifsc_code': ifscCode,
          'pf_number': pfNumber,
          'uan_number': uanNumber,
          'esi_number': esicNumber,
          'esv_status': esvStatus,
          'panCardStatus': panCardStatus,
          'aadhaarCardStatus':aadhaarCardStatus
        },

      );



      //print(response.statusCode);
      if (response.statusCode == 200) {


        if(loaderStatus=="true") {
          EasyLoading.dismiss();
        }
        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);

        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        kyc_details_modelResponse = KYC_details_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(kyc_details_modelResponse!.statusCode==true)
        {
          setState(() {
            if(esvStatus=="1")
            {
              //use for save the records
              saveLockButton_VisibilityStatus=true;
            }
            else if(esvStatus=="2")
            {
              //use for lock records
              saveLockButton_VisibilityStatus=false;

            }
            else
            {

            }

          });

          if(loaderStatus=="true") {
            show_SuccessAlert(kyc_details_modelResponse!.message!);
          }

        }
        else
        {
          if (kyc_details_modelResponse!.message==null || kyc_details_modelResponse!.message=="")
          {

            if(loaderStatus=="true") {
              show_OKAlert("server error!");
            }

          }else {

            if(loaderStatus=="true") {
              show_OKAlert(kyc_details_modelResponse!.message!);
            }
          }
        }

      } else {

        if(loaderStatus=="true") {
          EasyLoading.dismiss();
        }
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }


    catch(e){
      //print(e);
    }

  }



  show_OKAlert(String message)
  {
    /*------SnackBar-----21-07-2022--------start-----------*/

    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    /*-----SnackBar------21-07-2022--------end-----------*/

    /*-----AlertDialog------start----------------------*/
  /*  var alertDialog = AlertDialog(
      content: Text(message,
        textAlign: TextAlign.left,),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [

        TextButton(onPressed: () {
          Navigator.of(context).pop();
        },

          child: Text("OK",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
      ],

    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog

    );*/
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
          /*Navigator.push(context, MaterialPageRoute(builder: (_)=>

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

          ));*/

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