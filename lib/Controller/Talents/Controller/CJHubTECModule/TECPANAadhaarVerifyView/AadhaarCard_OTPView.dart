import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';


import '../../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../CustomView/CJHubCustomView/palatte_Textstyle.dart';
import '../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../CJHubTECView/KYC_details_Add_Edit.dart';
import '../CJHubTECView/profile_personalDetails_edit.dart';

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
      home: AadhaarCard_OTPView(title: 'CJ Hub'),
    );
  }
}
class AadhaarCard_OTPView extends StatefulWidget {

  AadhaarCard_OTPView({Key? key, this.title,this.clientID,this.aadhaarNumber,this.USER_ARRIVE_FROM_STATUS}) : super(key: key);

  final String? title;
  final String? clientID;
  final String? aadhaarNumber;
  final String? USER_ARRIVE_FROM_STATUS;


  @override
  _AadhaarCard_OTPView createState() => _AadhaarCard_OTPView(this.clientID!,this.aadhaarNumber!,this.USER_ARRIVE_FROM_STATUS!);
}
class _AadhaarCard_OTPView extends State<AadhaarCard_OTPView> {
  // This widget is the root of your application.


  String aadhaarNumber="",jsId_key="",mobileNumber="";
  int _otpCodeLength = 6;

  String _otpCode = "",otpNumber="";

  String clientID="";
  String USER_ARRIVE_FROM_STATUS="";

  _AadhaarCard_OTPView(String clientID,String aadhaarNumber,String USER_ARRIVE_FROM_STATUS)
  {
    this.clientID=clientID;
    this.aadhaarNumber=aadhaarNumber;
    this.USER_ARRIVE_FROM_STATUS=USER_ARRIVE_FROM_STATUS;

  }


  Timer? myTimer;
  Duration myDuration = Duration(minutes: 1);
  bool showTimer_Visibility=false;
  bool showResendOTP_Visibility=false;

  String loginTimeEmpName="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    getBasicInfo();

    setState(() {
      showTimer_Visibility=true;
      startTimer();

    });
  }

  /*---------22-10-2021 start-------*/
  _onOtpCallBack(String otpCode, bool isAutofill)
  {

    setState(()
    {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill)
      {

        //stopTimerUI();

        otpNumber=otpCode;
        //print('show enter otp $otpNumber');
        //_verifyOtpCode();

      }
      else if (otpCode.length == _otpCodeLength && !isAutofill)
      {

        /*------use for enter manually OTP-----19-1-2022 START-----*/
        otpNumber=otpCode;
        // _verifyOtpCode();

        /*------use for enter manually OTP-----19-1-2022 END-----*/


        //print('show call this method $otpCode');
        //print('show call this method $isAutofill');
        //print('new step 1');

      }
      else
      {
        /*------use for enter manually OTP(handle the 4 digit pin number)-----19-1-2022 START-----*/
        otpNumber=otpCode;
        /*------use for enter manually OTP-----19-1-2022 END-----*/


        //print('show call this method $otpCode');
        //print('show call this method $isAutofill');
        //print('new step 2');

      }
    });
  }

  @override
  Widget build(BuildContext context) {


    final resendButton = RichText
      (
      text: TextSpan
        (
        /*text: 'Resend',
        style: DefaultTextStyle.of(context).style,*/
        children: <TextSpan>[
          TextSpan(text: "Resend OTP",recognizer: TapGestureRecognizer()
            ..onTap = ()
            {
              //print('Resend"');

              /*------6-1-2021 start-----*/
              setState(() {
                showTimer_Visibility=true;
                resetTimer();
                startTimer();
              });
              /*------6-1-2021 end-----*/

              verify_AadhaarNumber_ResendOTP();

            },
              style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff00BFFF),fontSize: 15)

          ),
          // TextSpan(text: ' world!'),
        ],
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CJAppBar(getCJHUB_TEC_KYCDetails, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),

      body: SingleChildScrollView(
        child: Column(children: <Widget>[

          create_HeadingContainer("Enter the 6 digit OTP"),
          createTheOTPViewBoxes(),
          /*---6-1-2022-timer start-----*/
          Visibility(
              visible: showTimer_Visibility,
              child: create_Timer()),

          /*---6-1-2022-timer end-----*/

          SizedBox(
              height: 25.0),


          Visibility(visible: showResendOTP_Visibility,child:
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Didn't receive OTP?"),
              SizedBox(
                  width: 5.0),
              resendButton,
            ],
          )),


          create_Button_Verify()

        ]
        ),
      ),
    );
  }



  Container create_HeadingContainer(String value){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25,60,10,0),
        child: Row(
          children: [
            Text(value,
              style: TextStyle(color: Colors.black,fontSize: 18),),
          ],
        ),
      ),
    );
  }



  Container createTheOTPViewBoxes()
  {
    return Container
      (

      child: Column(
        children: <Widget>[

          Visibility(
            visible: true,
            child:Padding(
              padding: const EdgeInsets.fromLTRB(8,20,5,10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  /* SizedBox(
                      height: 45.0),
*/
                  /*-------android start 28-10-2021 start---------*/
                  /*TextFieldPin(

                    filled: true,
                    filledColor: Colors.transparent,
                    codeLength: _otpCodeLength,
                    boxSize: 38,
                    filledAfterTextChange: false,
                    textStyle: TextStyle(fontSize: 16),
                    borderStyle: OutlineInputBorder(
                        borderSide:  BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5)),

                    onOtpCallback: (code, isAutofill) =>
                        _onOtpCallBack(code, isAutofill),


                  ),*/
                  /*-------android end 28-10-2021 end---------*/



                ],
              ),
            ),
          ),



        ],
      ),
    );

  }



  Container create_Button_Verify() {
    return Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(0.0),
              ),
              padding: const EdgeInsets.only(left: 10, right: 30, top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 30,

                    child: Material(
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(5.0),
                      color: primaryColor,
                      child:MaterialButton(
                          minWidth: 50,
                          height: 30,
                          onPressed: ()
                          {

                            if (otpNumber.length == _otpCodeLength)
                            {

                              //print('enter 4 digit otp');
                              verify_AadhaarOTP();

                            }
                            else
                            {
                              show_OKAlert("Please enter the 6 digit OTP");

                            }
                          },
                          child: Text('Verify',
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


  getBasicInfo()
  {
    SharedPreference.getEmpName().then((value) =>  {
      loginTimeEmpName=value,
      //print('show emp loginTimeEmpName $value'),
    });

    SharedPreference.getJSId().then((value) =>  {
      jsId_key=value,
      //print('show emp jsId $value'),
    });
    SharedPreference.getEmpMobileNo().then((value) =>  {
      mobileNumber=value,
      //print('show emp mobileNumber $value'),
    });

  }
  verify_AadhaarOTP() async
  {

    //print('show clientID $clientID');
    //print('show mobileNumber $mobileNumber');
    //print('show otpNumber $otpNumber');

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.verify_Aadhaar_OTP),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'js_id': getEncrypted_EmpCode(jsId_key),
          'client_id': clientID,
          'mobile_number': getEncrypted_EmpCode(mobileNumber),
          'otp': otpNumber,

        },
      );


      //print(response.statusCode);
      if (response.statusCode == 200)
      {

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);

        var responseBody=jsonDecode(response.body);
        var statusCode=responseBody["statusCode"];
        var message=responseBody["message"];

        if(statusCode==true)
        {


          var encryptedData=responseBody["data"];
          var decryptedDataObj=getDecryptedData(encryptedData);
          var decryptedDataObj1=jsonDecode(decryptedDataObj);

          var full_name=decryptedDataObj1["full_name"];

          var dob=decryptedDataObj1["dob"];

          dob=Method.changeTheDateFormat_ForAadhaarCard(dob);
          //print('show dateofbirth $dob');



          var loginTimeNameArr = loginTimeEmpName.toString().split(" ");
          var empFirstName_loginTimeName=loginTimeNameArr[0].toUpperCase().trim();
          //print('show emp full name empFirstName_loginTimeName $empFirstName_loginTimeName');


          bool compareNameStatus=full_name.toString().toUpperCase().contains(empFirstName_loginTimeName);
          //print('show emp full name empFirstName_loginTimeName status $compareNameStatus');

          /*-----------2-4-2022 end---------*/

          if(compareNameStatus)

          {

            var fatherName = decryptedDataObj1["care_of"];
            var gender=decryptedDataObj1["gender"];
            if(gender=="M")
            {
              gender="Male";
            }
            else
            {
              gender="Female";

            }




            /*-------------17-5-2022 start---------------*/
            var house_add=decryptedDataObj1["house_add"];
            if(house_add=="" || house_add==null)
            {
              house_add=decryptedDataObj1["vtc_add"];
              if(house_add=="" || house_add==null)
              {
                house_add="";
              }else{
                house_add=house_add+",";

              }
            }
            else
            {
              house_add=house_add+",";
            }


            var loc_add=decryptedDataObj1["loc_add"];
            if(loc_add=="" || loc_add==null)
            {
              loc_add="";
            }
            else
            {
              loc_add=loc_add+",";
            }


            var landmark_add=decryptedDataObj1["landmark_add"];
            if(landmark_add=="" || landmark_add==null)
            {
              landmark_add="";
            }
            else
            {
              landmark_add=landmark_add+",";
            }


            var po_add=decryptedDataObj1["po_add"];
            var subdist_add=decryptedDataObj1["subdist_add"];
            var dist_add=decryptedDataObj1["dist_add"];
            var state_add=decryptedDataObj1["state_add"];

            String completeAddress=house_add+loc_add+landmark_add+po_add+","+subdist_add+","+dist_add+","+state_add;

            /*-------------17-5-2022 end---------------*/



            SharedPreference.setEmpName(full_name);
            SharedPreference.setEmpDateOfBirth(dob);
            SharedPreference.setEmpGender(gender);
            SharedPreference.setEmp_AadhaarCard_PermanentAddress(completeAddress);
            SharedPreference.setEmp_AadhaarCard_FatherName(fatherName);

            SharedPreference.setAadhaarCard_STATUS("1");
            show_SuccessAlert(message);

          }
          else
          {
            show_OKAlert("Aadhaar verification fail due to name mismatch.");

          }


        }
        else
        {
          if (message==null || message=="")
          {
            show_OKAlert("server error!");

          }else {
            show_OKAlert(message);
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

  show_OKAlert(String message)
  {
    /*------SnackBar-----21-07-2022--------start-----------*/

    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    /*-----SnackBar------21-07-2022--------end-----------*/

    /*-----AlertDialog------start----------------------*/
   /* var alertDialog = AlertDialog(
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



          if(USER_ARRIVE_FROM_STATUS=="KYCDetails")
          {
            Navigator.push(context, MaterialPageRoute(builder: (_) =>

            Responsive(
                mobile: KYC_details_Add_Edit(),
                tablet: Center(
                  child: Container(
                    width: flutterWeb_tabletWidth,
                    child: KYC_details_Add_Edit(),
                  ),
                ),
                desktop: Center(
                  child: Container(
                    width: flutterWeb_desktopWidth,
                    child: KYC_details_Add_Edit(),
                  ),
                ))
                // KYC_details_Add_Edit()
            ),);

          }else
          {
            /*---use from Personal details Edit------*/
            Navigator.push(context, MaterialPageRoute(builder: (_) =>

            Responsive(
                mobile: profile_personalDetails_edit(),
                tablet: Center(
                  child: Container(
                    width: flutterWeb_tabletWidth,
                    child: profile_personalDetails_edit(),
                  ),
                ),
                desktop: Center(
                  child: Container(
                    width: flutterWeb_desktopWidth,
                    child: profile_personalDetails_edit(),
                  ),
                )
            )
                // profile_personalDetails_edit()

            ),);
          }

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
/*-----------------Timer 6-1-2022 start--next release---------------*/

  Container create_Timer()
  {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 8,right: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            displayTimer(),

          ],
        ),
      ),
    );
  }

  Widget displayTimer()
  {
    String strDigits(int n) => n.toString().padLeft(2, "0");
    //final hours = strDigits(myDuration.inHours);
    //final minutes = strDigits(myDuration.inMinutes.remainder(1));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          displayTimerUI(time: seconds, header: "OTP::"),
        ]
    );
  }

  Widget displayTimerUI({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(header+""+time, style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.black, fontSize: 12)),
          //Text(header, style: TextStyle(fontSize: 9, color: Colors.grey)),
        ],
      );



  void resetTimer()
  {
    setState(() =>
    myDuration = Duration(minutes: 1));
  }

  void startTimer()
  {
    //print('show timer method call 1');

    myTimer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = false})
  {
    //print('show timer method stop $myDuration');

    if (resets)
    {
      resetTimer();
    }
    setState(() => myTimer!.cancel());
  }

  void addTime()
  {
    //print('show timer method call 2');
    final addSeconds = -1;
    setState(() {
      final seconds = myDuration.inSeconds + addSeconds;
      if (seconds < 0)
      {
        myTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);

        //print('show timer method call 3 $seconds');
        //print('show timer method call 4 $myDuration');

        if(seconds==0)
        {
          //here visible the resend otp button
          showResendOTP_Visibility=true;
          stopTimerUI();
        }
        else
        {
          //hide the resend otp button
          showResendOTP_Visibility=false;
        }

      }
    });
  }
  stopTimerUI()
  {
    setState(() {
      /*----25-2-2022-timer start-----*/
      showTimer_Visibility=false;

      /*---25-2-2022-timer end-----*/
    });
  }
/*-----------------Timer 6-1-2022 end---------------*/
  verify_AadhaarNumber_ResendOTP() async
  {

    //aadhaarNumber="776679243002";
    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.verify_Aadhaar_Number),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'id_number': getEncrypted_EmpCode(aadhaarNumber),
          'js_id': getEncrypted_EmpCode(jsId_key),

        },
      );


      //print(response.statusCode);
      if (response.statusCode == 200)
      {

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);

        var responseBody=jsonDecode(response.body);
        var statusCode=responseBody["statusCode"];
        var message=responseBody["message"];
        var aadhar_verified_status=responseBody["aadhar_verified_status"];

        if(statusCode==true)
        {

          var encryptedData=responseBody["data"];
          var decryptedDataObj=getDecryptedData(encryptedData);
          var decryptedDataObj1=jsonDecode(decryptedDataObj);

          //print('show emp data details $decryptedDataObj1');

          var client_id=decryptedDataObj1["client_id"];
          var otp_sent=decryptedDataObj1["otp_sent"];
          var if_number=decryptedDataObj1["if_number"];
          var valid_aadhaar=decryptedDataObj1["valid_aadhaar"];



          //print('show emp data details $decryptedDataObj1');
          //print('show emp client_id $client_id $otp_sent $if_number $valid_aadhaar $aadhar_verified_status');

          if(otp_sent==true && if_number==true && valid_aadhaar==true)
          {

          }
          else
          {
            if(aadhar_verified_status==true)
            {
              var full_name=decryptedDataObj1["full_name"];
              SharedPreference.setEmpName(full_name);
              SharedPreference.setAadhaarCard_STATUS("1");


            }
            else {
              show_OKAlert(message);
            }

          }

        }
        else
        {
          if (message==null || message=="")
          {
            show_OKAlert("server error!");

          }else {
            show_OKAlert(message);
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
}