import 'dart:convert';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart'as http;

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../Services/AESAlgo/Keys.dart';
import '../../../../Services/AESAlgo/encrypt.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../Services/Messages/Message.dart';
import '../../ModelClasses/CJHubModelClasses/Verify_Mobile_ModelResponse.dart';
import 'PinGeneration_ModelResponse.dart';

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
      home: Responsive(
        mobile:  Enter4DigitPin(title: 'CJ Hub'),
        tablet:  Center(
          child: Container(
            width: flutterWeb_tabletWidth,
            child: Enter4DigitPin(title: 'CJ Hub'),
          )
        ),
        desktop:  Center(
            child: Container(
              width: flutterWeb_desktopWidth,
              child: Enter4DigitPin(title: 'CJ Hub'),
            )
        )
      )
      // Enter4DigitPin(title: 'CJ Hub'),
    );
  }
}
class Enter4DigitPin extends StatefulWidget {
  Enter4DigitPin({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _Enter4DigitPin createState() => _Enter4DigitPin();

}

class _Enter4DigitPin extends State<Enter4DigitPin> {


  String completeEmpCode="";
  String empIp="",empUserId="";

  String userArriveFrom="";
  String checkNormalPinNumberorGeneratedPinNumber="";

  String txt_regeneratePin="Generate Pin",txt_enterOTPMessage="Generate 4 digit pin";
  String fourDigitPinNumber="";

/*-------29-1-2022 start--------*/
  String ecStatus="",jsId="";
  String empMobileNumber="";



  TextEditingController textEditingController = TextEditingController();
  String currentText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    SharedPreference.getEmp_PinNumberScreen().then((pinnumber) =>
    {
      loadInitialData(pinnumber)
    });

  }
  loadInitialData(String pinnumber)
  {
    setState(() {

      userArriveFrom=pinnumber;
      checkNormalPinNumberorGeneratedPinNumber="OldPinNumber";
      checkUserArriveFromStatus();

    });
  }

  SingleChildScrollView mainFunction_UI(){
    return SingleChildScrollView(
      child: Column(children: <Widget>[

        //create_headingContainer(),

        SizedBox(
          height: 70,
        ),

        create_TextContainer(),


        create_PinBox(),



        create_GenerateContainer(),

        create_height(),

        create_Button(),


      ],
      ),

    );
  }
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false, backgroundColor: Color(0xfff0f0f2),centerTitle: true,
          title: Text("Pin Number",style: TextStyle(color:blackColor,fontSize: large_FontSize,fontFamily: robotoFontFamily),),),



        body: WillPopScope(
          child: Responsive(
            mobile: mainFunction_UI(),
            tablet: Center(
              child: Container(
                width: flutterWeb_tabletWidth,
                child: mainFunction_UI(),
              ),
            ),
            desktop: Center(
              child: Container(
                width: flutterWeb_tabletWidth,
                child: mainFunction_UI(),
              ),
            ),
          ),
          onWillPop: () async => false,
          /*onWillPop: ()
          {
            Message.alert_dialogAppExit(context);

          } ,*/

        )
    );
  }

  Container create_headingContainer(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20,10,20,0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200.0,
              height: 200.0,
              child: Image.asset(getCJHub_AppLogo,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*--------------start 05-06-2022--------------*/
  Center create_TextContainer(){
    return Center(
      child:  Container(
        width: 300,
        // color: Colors.yellow,
        padding: const EdgeInsets.only(left: 30,right: 5),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(txt_enterOTPMessage,
              style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
            ),            ],
        ),
      ),
    );
  }


  Center create_GenerateContainer()
  {
    return Center(
      child: Container(
        width: 300,
        // color: Colors.yellow,
        padding: const EdgeInsets.only(left: 5,right: 30,top: 10),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: txt_regeneratePin,recognizer: TapGestureRecognizer()
                    ..onTap = ()
                    {
                      //print('Click to Generate Pin button');

                      if (userArriveFrom=="SplashScreen")
                      {

                        SharedPreference.setLoginStatus("false");
                        
                        /*--------------19-11-2022(use)------------*/
/*
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>
                            Responsive(
                              mobile: login(),
                              tablet: Center(
                                child: Container(
                                  width: login_tabletWidth,
                                  child: login(),
                                ),
                              ),
                              desktop: Center(
                                child: Container(
                                  width: login_desktopWidth,
                                  child: login(),
                                ),
                              ),
                            )
                            // login()

                        ));
*/

                      }
                      else {
                        /*-----15-7-2021 end----*/

                        setState(() {

                          txt_enterOTPMessage="Generate 4 digit pin";
                          checkNormalPinNumberorGeneratedPinNumber = "generatedPinNumber";

                          //18-2-2022 start
                          txt_regeneratePin="";
                          //18-2-2022 end

                        });

                      }

                    },
                    style: TextStyle(color: primaryColor,fontSize: 15,fontWeight: FontWeight.bold),

                  ),
                ],
              ),
            ),

          ],
        ),

      ),
    )
      ;
  }

  /*--------------end 05-06-2022------------------*/
  Container create_PinBox(){
    return Container(

      width: MediaQuery.of(context).size.width*1,
      // color: Colors.lightGreen,
      // padding: const EdgeInsets.only(left: 20,right: 20),

      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


/*-----------------start 05-06-2022------------------*/
        PinCodeTextField(
        length: 4,
        obscureText: true,
        autoFocus: true,
        // animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 45,
          fieldWidth: 45,
          activeFillColor: Colors.white,
        ),
        animationDuration: const Duration(milliseconds: 300),
        // backgroundColor: Colors.blue.shade50,
        enableActiveFill: true,
        controller: textEditingController,
        onCompleted: (v) {
          //print("Completed");

          checkEnterInputNumber();

        },
        onChanged: (output) {
          //print(output);
          setState(() {
            fourDigitPinNumber=output;
          });
        },
        beforeTextPaste: (text) {
          return true;
        },

        appContext: context,
      ),

          /*-----------------end 05-06-2022------------------*/


         /* PinCodeFields(
            length: 4,
            margin: const EdgeInsets.only(left: 5,right: 5),
            fieldBorderStyle: FieldBorderStyle.Square,
            responsive: false,
            fieldHeight:50.0,
            fieldWidth: 50.0,
            borderWidth:1.0,
            borderRadius: BorderRadius.circular(2.0),
            keyboardType: TextInputType.number,
            autoHideKeyboard: false,
            obscureText: true,
            // fieldBackgroundColor: Colors.black12,
            borderColor: Colors.black38,
            textStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
            ),
            onComplete: (output)
            {
              // Your logic with pin code

            },
            onChange: (output)
            {
              ////print('show change character $value');
              ////print(output);
              fourDigitPinNumber=output;
            },
          ),*/
        ],
      ),
    );
  }
  Padding create_Button(){
    return Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              elevation: 0.0,
              borderRadius: BorderRadius.circular(5.0),
              color: primaryColor,
              child:MaterialButton(
                  minWidth: 250,
                  height: 50,
                  padding: EdgeInsets.only(left:20,right: 20),
                  onPressed: () {

                    checkEnterInputNumber();

                  },
                  child: Text('Confirm',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,fontSize: 18))

              ),
            ),
          ],
        )
    );
  }

  checkEnterInputNumber()
  {
    if(fourDigitPinNumber.length==4)
    {
      validateTheFields();
    }
    else
    {
      // show_OKAlert("Enter your 4 digit  pin");

      Method.snackBar_OkText(context, "Enter your 4 digit  pin");
    }
  }


  validateTheFields()
  {
    String input_pinNumber=fourDigitPinNumber;

    String pinno="";
    SharedPreference.getEmp_PinNumber().then((encryptedPinno) =>
    {

      //print('show login status $encryptedPinno'),
      //print('show input_pinNumber  $input_pinNumber'),

      //print('show ecstatus  $ecStatus'),


      /*---getDecryptedData is true only use for testing(pinno=encryptedPinno,)-3-9-2021--------------*/

      //use for all employee
      pinno = getDecryptedData(encryptedPinno),
      //print('show DecryptedData  $pinno'),

      //use for only me
      //pinno=encryptedPinno,
      /*---getDecryptedData is true only use for testing(pinno=encryptedPinno,)--3-9-2021--------------*/


      if (userArriveFrom=="SplashScreen")
        {
          if (pinno==input_pinNumber)
            {
              /*------------------7-4-2022 start-----------------------*/
              if(ecStatus=="EC" || ecStatus =='TEC')
                {
                  /*--------------19-11-2022(use)------------*/

/*
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>
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
                            width: flutterWeb_tabletWidth,
                            child: bottom(),
                          ),
                        ),
                      )
                      // bottom()

                      ),)
*/
                }
              else if(ecStatus=="RTEC")
                {
                  /*--------------19-11-2022(use)------------*/

/*
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>

                  Responsive(
                      mobile: Rider_bottom(),
                      tablet: Center(
                        child: Container(
                          width: flutterWeb_tabletWidth,
                          child: Rider_bottom(),
                        ),
                      ),
                      desktop: Center(
                        child: Container(
                          width: flutterWeb_desktopWidth,
                          child: Rider_bottom(),
                        ),
                      ))
                      // Rider_bottom()

                  ),)
*/

                }
              else if(ecStatus=="REC")
                  {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => Rider_REC_bottom()),)

                  }
                else
                  {

                  }
              /*------------------7-4-2022 end-----------------------*/
            }
          else
            {

              Method.snackBar_OkText(context, "Enter correct  pin")

              // show_OKAlert("Enter correct  pin")
            }
        }
      else
        {
          //if (userArriveFrom.equalsIgnoreCase("LoginScreen"))
          //user arrive from login screen


          if (checkNormalPinNumberorGeneratedPinNumber=="OldPinNumber")
            {
              if (pinno==input_pinNumber)
                {

                  SharedPreference.setLoginStatus("true"),

                  /*------------------7-4-2022 start-----------------------*/

                  if(ecStatus=="EC" || ecStatus =='TEC')
                    {
                      /*--------------19-11-2022(use)------------*/

/*
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>
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
                        width: flutterWeb_tabletWidth,
                        child: bottom(),
                      ),
                    ),
                    )
                          // bottom()

                      ),)
*/
                    }

                  else if(ecStatus=="RTEC")
                    {
                      /*--------------19-11-2022(use)------------*/

/*
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>

                      Responsive(
                         mobile: Rider_bottom(),
                         tablet: Center(
                          child: Container(
                           width: flutterWeb_tabletWidth,
                            child: Rider_bottom(),
                        ),
                      ),
                         desktop: Center(
                          child: Container(
                           width: flutterWeb_desktopWidth,
                           child: Rider_bottom(),
                         ),
                    ))
                          // Rider_bottom()

                      ),)
*/
                    }
                  else if(ecStatus=="REC")
                      {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => Rider_REC_bottom()),)
                      }
                    else
                      {
                      }
                  /*------------------7-4-2022 end-----------------------*/


                } else {

                Method.snackBar_OkText(context, "Enter correct  pin")
                // show_OKAlert("Enter correct  pin")
              }
            }
          else
            {
              /*---------11-2-2022 start----------*/
              if(input_pinNumber.length==4)
                {
                  //print(('show message for pin number set  $input_pinNumber')),

                  save4DigitPinApiRequest()
                }
              else
                {
                  //print(('show message for pin number')),

                  Method.snackBar_OkText(context, "Generate 4 digit  pin")
                  // show_OKAlert("Generate 4 digit  pin")

                }
              /*---------11-2-2022 end----------*/

            }

        }


    });

  }

  checkUserArriveFromStatus()
  {
    setState(() {

      if (userArriveFrom=="SplashScreen")
      {

        txt_regeneratePin="Generate Pin";
        txt_enterOTPMessage="Enter your 4 digit pin";

        /*--emp mobile verify api for the empcode or ec_status for the TEC module start 16-2-2022----*/
        checkTheEmp_TEC_Status();
        /*--emp mobile verify api for the empcode or ec_status for the TEC module end 16-2-2022----*/


      }
      else if (userArriveFrom=="LoginScreen")
      {

        SharedPreference.getEC_STATUS().then((value) =>  {
          //print('show emp ecStatus $value'),
          ecStatus=value,

        });

        txt_enterOTPMessage="Enter your 4 digit pin";

        // Method.snackBar_OkText(context, "Enter your 4 digit pin");
        // show_OKAlert("Enter your 4 digit pin");



      }else
      {

      }
    });
  }

  /*--------------use for only TEC employee 16-2-2022 start------------*/
  checkTheEmp_TEC_Status()
  {
    SharedPreference.getEmpMobileNo().then((value) =>  {
      //print('show emp Mobile number $value'),
      empMobileNumber=value

    });

    SharedPreference.getEC_STATUS().then((value) =>  {
      //print('show emp ecStatus $value'),
      ecStatus=value,
      if(value=="TEC" || value=="RTEC")
        {
          verifyMobileNumber_WebApi()
        }
    });
  }

  verifyMobileNumber_WebApi() async
  {
    String getEncryptedMobileNumber=getEncryptedData(empMobileNumber);
    String encryptedKey=getEncryptedData(Keys.get_SaltKey);

    //print('show emp mobile $getEncryptedMobileNumber');
    //print('show emp empSecretKey $encryptedKey');


    try {
      final response = await http.post(
        Uri.parse(
            WebApi.verifyMobile_api),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'emp_mobile': getEncryptedMobileNumber,
          'emp_secret_key': encryptedKey
        },
      );
      //print(response.statusCode);
      if (response.statusCode == 200)
      {


        //print(response.body);
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        // Verify_Mobile_ModelResponse response=Verify_Mobile_ModelResponse.fromJson(jsonDecode(response.body));
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        Verify_Mobile_ModelResponse _verify_mobile_modelResponse=Verify_Mobile_ModelResponse.fromJson(jsonDecode(serverResponse));


        if(_verify_mobile_modelResponse.statusCode==true)
        {

         /* var fourDigitPinObj=_verify_mobile_modelResponse.data!;
          SharedPreference.setEmpId(fourDigitPinObj.userId);
          SharedPreference.setEmpGender(fourDigitPinObj.empGender);
          SharedPreference.setEmpJobType(fourDigitPinObj.jobType);
          SharedPreference.setEmpAddress(fourDigitPinObj.empResidentialAddress);
          SharedPreference.setEmpFatherName(fourDigitPinObj.empFatherName);
          SharedPreference.setEmpDateOfBirth(fourDigitPinObj.empDob);
          //SharedPreference.setEmp_ProfileImage(fourDigitPinObj.empPhotoPath);

          SharedPreference.setEmpMobileNo(fourDigitPinObj.empMobile);
          SharedPreference.setEmpEmailId(fourDigitPinObj.empEmail);
          SharedPreference.setEmpCode(fourDigitPinObj.empCode);

          SharedPreference.setEmpPanCardNumber(fourDigitPinObj.empPancardNumber);
          SharedPreference.setEmpName(fourDigitPinObj.empName);

          //11-1-20222 start::'CRM','PartialBatch','HUBCRM'
          SharedPreference.setEC_STATUS(fourDigitPinObj.ecStatus);


          SharedPreference.setRecord_Source(fourDigitPinObj.recordSource);
          SharedPreference.setJSId(fourDigitPinObj.jsId);

          SharedPreference.setIncomeTax_HeadsFinancialYear(fourDigitPinObj.financialYear);


          //24-3-20222 atRT
          SharedPreference.setKYC_STATUSCode(fourDigitPinObj.kycStatusCode);
          SharedPreference.setPANCard_STATUS(fourDigitPinObj.panCardStatus);
          SharedPreference.setAadhaarCard_STATUS(fourDigitPinObj.aadhaarCardStatus);

          //24-3-20222 END

          *//*--------22-4-2022 start(check show summary details or not(nomineestatus=1 means show summary and nomineestatus=0 means show document upload))-------*//*
          SharedPreference.setRider_NomineeDetails_SaveStatus(fourDigitPinObj.nomineestatus);


          //9-5-20222 start
          SharedPreference.setRider_GigECCode(fourDigitPinObj.gigEc);
          //9-5-20222 end

          //11-10-20222 start
          SharedPreference.set_CJCode(fourDigitPinObj.cjCode);
          SharedPreference.setQREmpId(fourDigitPinObj.empId);*/

          //11-10-20222 end
//
        }

        //String ecstatus=fourDigitPinObj.ecStatus;
        //String empcode=fourDigitPinObj.empCode;

        //print('show emp ecstatus $ecstatus');
        //print('show emp empcode $empcode');



      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      //print(e);
    }
  }
  /*--------------use for only TEC employee 16-2-2022 end------------*/



  save4DigitPinApiRequest()
  {


    String mobileNumber_key="",empCode_key="",
        empDateOfBirth_key="";

    SharedPreference.getEmpMobileNo().then((value) =>  {
      mobileNumber_key=value,
      //print('show emp name2 $value'),
      //loadData()
    });

    /*--------19-1-2-22 start---------*/
    SharedPreference.getEC_STATUS().then((value) =>  {
      //print('show emp ecStatus $value'),
      ecStatus=value,


    });
    SharedPreference.getJSId().then((value) =>  {
      //print('show emp jsId $value'),
      jsId=value,

    });

    /*--------19-1-2-22 end---------*/

    SharedPreference.getEmpCode().then((value) =>  {
      empCode_key=value,
      //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      /*--------19-1-2-22 start---------*/
      //'CRM','PartialBatch','HUBCRM'

      if(ecStatus=="EC" || ecStatus=="REC")
        {
          //use for EC(HUBCRM)
          empCode_key=empCode_key
        }
      else if(ecStatus=="TEC" || ecStatus=="RTEC")
        {
          //use for TEC(CRM,PartialBatch)
          empCode_key=jsId
        }
      else
        {
          //use for EC(HUBCRM)------------this case 29-1-2022
          empCode_key=empCode_key
        },
      /*--------19-1-2-22 end---------*/



      empDateOfBirth_key=value,
      //print('show emp name2 $value'),
      //print('show emp empCode_key $empCode_key'),

      completeEmpCode = mobileNumber_key+"CJHUB"+empCode_key+"CJHUB"+empDateOfBirth_key,

      //print('show emp completeEmpCode $completeEmpCode'),


    });

    SharedPreference.getEmpId().then((value) =>  {
      //print('show emp name2 $value'),
      empUserId=value,

    });



    Method.getIPAddress().then((value) =>  {
      //print('show emp name2 $value'),
      empIp=value,

      save_EmployeeSet4DigitPin()

    });
  }


  save_EmployeeSet4DigitPin() async
  {
    //String jsonTutorial = jsonEncode(listData);
    EasyLoading.show(status: Message.get_LoaderMessage);
    //print('show 4 digit pin number1 $fourDigitPinNumber');

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.save_Emp_Pin_Number),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },

        body:  {
          'operation': "Add",
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'emp_ip': empIp,
          'emp_user_id': empUserId,
          'emp_pin':getEncryptedData(fourDigitPinNumber),
          'ec_status':ecStatus

        },
      );
      //print(response.statusCode);
      //print(response.body);

      if (response.statusCode == 200)
      {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);

        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        PinGeneration_ModelResponse vi_modelResponse = PinGeneration_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(vi_modelResponse.statusCode==true)
        {
          SharedPreference.setLoginStatus("true");
          String encryptedPinNo=getEncryptedData(fourDigitPinNumber);
          SharedPreference.setEmp_PinNumber(encryptedPinNo);


          successAlert(vi_modelResponse.message);

        }
        else
        {
          if (vi_modelResponse.message==null || vi_modelResponse.message=="")
          {

            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, vi_modelResponse.message);

            // show_OKAlert(vi_modelResponse.message);
          }
        }


      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      //print(e);
    }
  }

  successAlert(String message)
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

          /*------------------7-4-2022 start-----------------------*/

          if(ecStatus=="EC" || ecStatus=="TEC")
          {
            /*---------19-11-2022 (use)----------*/
/*
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
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
                      width: flutterWeb_tabletWidth,
                      child: bottom(),
                    ),
                  ),
                )
                // bottom()

            ),);
*/
          }
          else if(ecStatus=="RTEC")
          {
            /*---------19-11-2022 (use)----------*/

/*
            Navigator.push(context, MaterialPageRoute(builder: (context) =>

            Responsive(
                mobile: Rider_bottom(),
                tablet: Center(
                  child: Container(
                    width: flutterWeb_tabletWidth,
                    child: Rider_bottom(),
                  ),
                ),
                desktop: Center(
                  child: Container(
                    width: flutterWeb_desktopWidth,
                    child: Rider_bottom(),
                  ),
                )

            )
                // Rider_bottom()

            ),);
*/
          }
          else if(ecStatus=="REC")
          {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => Rider_REC_bottom()),);
          }
          else
          {

          }
          /*-----------------------7-4-2022 end-----------------------*/


        },

          child: Text("OK",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
      ],

    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }

  /*----------commented show_OKAlert Dialog---------21-07-2022-start--*/

  // show_OKAlert(String message)
  // {
  //
  //   /*------SnackBar-----21-07-2022--------start-----------*/
  //
  //   var snackBar = SnackBar(
  //     content: Text(message),
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //
  //   /*-----SnackBar------21-07-2022--------end-----------*/
  //
  //   /*-----AlertDialog------start----------------------*/
  //
  //   /*var alertDialog = AlertDialog(
  //     content: Text(message,
  //       textAlign: TextAlign.left,),
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(0.0))
  //     ),
  //
  //     actions: [
  //
  //       TextButton(onPressed: () {
  //         Navigator.of(context).pop();
  //       },
  //
  //         child: Text("OK",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
  //     ],
  //
  //   );
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) => alertDialog
  //
  //   );*/
  // }

  /*----------commented show_OKAlert Dialog---------21-07-2022-end--*/

  SizedBox create_height(){
    return SizedBox(
      height: 30,
    );
  }
}