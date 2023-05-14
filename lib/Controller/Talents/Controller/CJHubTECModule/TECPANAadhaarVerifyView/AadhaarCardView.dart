import 'dart:convert';
import 'dart:ui';

import 'package:checkdigit/checkdigit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;

import '../../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../CustomView/CJHubCustomView/ValidateClass.dart';
import '../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/Messages/Message.dart';
import '../CJHubTECView/KYC_details_Add_Edit.dart';
import '../CJHubTECView/profile_personalDetails_edit.dart';
import 'AadhaarCard_OTPView.dart';



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
      home: AadhaarCardView(title: 'CJ Hub'),
    );
  }
}
class AadhaarCardView extends StatefulWidget {

  AadhaarCardView({Key? key, this.title,this.USER_ARRIVE_FROM_STATUS}) : super(key: key);

  final String? title;
  final String? USER_ARRIVE_FROM_STATUS;



  @override
  _AadhaarCardView createState() => _AadhaarCardView(USER_ARRIVE_FROM_STATUS!);
}
class _AadhaarCardView extends State<AadhaarCardView> {
  // This widget is the root of your application.
  final _aadharFirstBoxController=TextEditingController();
  final _aadharSecondBoxController=TextEditingController();
  final _aadharThirdBoxController=TextEditingController();
  final _panCardController=TextEditingController();
  FocusNode textSecondFocusNode = new FocusNode();
  FocusNode textThirdFocusNode = new FocusNode();
  FocusNode textFirstFocusNode = new FocusNode();

  bool _isEnableSecondBox =false;
  bool _isEnableThirdBox =false;


  String aadhaarNumber="",jsId_key="";
  int _otpCodeLength = 6;

  String _otpCode = "",otpNumber="";
  String USER_ARRIVE_FROM_STATUS="";

  String loginTimeEmpName="";


  _AadhaarCardView(String user_arrive_from_status)
  {
    this.USER_ARRIVE_FROM_STATUS=user_arrive_from_status;

  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBasicInfo();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CJAppBar(getCJHUB_TEC_KYCDetails, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),

      body: SingleChildScrollView(
        child: Column(children: <Widget>[

          create_AadharNumber(),

          create_Button_Verify(),


        ]
        ),
      ),
    );
  }




/*
  Container create_AadharNumber() {
    return  Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child: asteriskText("Aadhaar Number"),
                      // Text("Nominee Name",style: TextStyle(color: Colors.black,fontSize: 13),),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.28,
                            child:TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: validate_aadharNumber(),
                              controller: _aadharFirstBoxController,
                              focusNode: textFirstFocusNode,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 5, left: 10),
                                hintText: "",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),
                              onChanged: (String _aadharFirstBoxController) {
                                setState(() {
                                  if(_aadharFirstBoxController.length==4 ){
                                    _isEnableSecondBox = true;
                                    FocusScope.of(context).requestFocus(textSecondFocusNode);

                                  }
                                });

                              },
                            ),
                          ),

                          SizedBox(
                            width: 7,
                          ),

                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.28,
                            child:TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: validate_aadharNumber(),
                              focusNode: textSecondFocusNode,
                              controller: _aadharSecondBoxController,
                              enabled: _isEnableSecondBox,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 5, left: 10),
                                hintText: "",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),
                              onChanged: (String _aadharSecondBoxController) {
                                setState(() {
                                  if(_aadharSecondBoxController.length==4){
                                    _isEnableThirdBox= true;
                                    FocusScope.of(context).requestFocus(textThirdFocusNode);
                                  }
                                  else if(_aadharSecondBoxController.isEmpty){
                                    FocusScope.of(context).requestFocus(textFirstFocusNode);
                                  }
                                });

                              },
                            ),
                          ),

                          SizedBox(
                            width: 7,
                          ),

                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.28,
                            child:TextFormField(
                              keyboardType: TextInputType.number,
                              focusNode: textThirdFocusNode,
                              controller: _aadharThirdBoxController,
                              enabled: _isEnableThirdBox,
                              inputFormatters: validate_aadharNumber(),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 5, left: 10),
                                hintText: "",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),
                              onChanged: (String _aadharThirdBoxController)
                              {
                                setState(()
                                {
                                  if(_aadharThirdBoxController.isEmpty)
                                  {
                                    FocusScope.of(context).requestFocus(textSecondFocusNode);
                                  }
                                });

                              },
                            ),
                          ),
                        ],
                      )

                  ),

                ],
              ),

            ),
          ],
        )
    );
  }
*/

  Container create_AadharNumber() {
    return  Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child: asteriskText("Aadhaar Number"),
                      // Text("Nominee Name",style: TextStyle(color: Colors.black,fontSize: 13),),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex:1,
                              child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width*0.28,
                              child: Form(
                                key: formkey_firstFourNumber,
                                child:TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: validate_aadharNumber(),
                                  controller: _aadharFirstBoxController,
                                  focusNode: textFirstFocusNode,
                                  validator: validate_firstFourAadharNumber,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        top: 5, left: 10),
                                    hintText: "",
                                    border:
                                    OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2.0)),
                                  ),
                                  onChanged: (String _aadharController)
                                  {
                                    _aadharController =_aadharFirstBoxController.text;
                                    setState(()
                                    {
                                      if(_aadharController.length >=3 && validate_firstFourAadharNo(_aadharController) )
                                      {
                                        FocusScope.of(context).requestFocus(textSecondFocusNode);
                                        //print("next focus");
                                      }
                                      else if(_aadharController.length >1){
                                        _isEnableSecondBox = true;
                                      }
                                      else if(_aadharController.length<=4 ) {
                                        validate_firstFourAadharNo(_aadharController);
                                        //print("not move");
                                      }

                                    });

                                  },
                                ),
                              )

                          ))
                          ,

                          SizedBox(
                            width: 7,
                          ),

                      Expanded(
                        flex:1,
                          child:Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.28,
                            child:TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: validate_aadharNumber(),
                              focusNode: textSecondFocusNode,
                              controller: _aadharSecondBoxController,
                              enabled: _isEnableSecondBox,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 5, left: 10),
                                hintText: "",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),
                              onChanged: (String _aadharSecondBox)
                              {
                                _aadharSecondBox = _aadharSecondBoxController.text;
                                setState(()
                                {

                                  if(_aadharSecondBox.length >3){
                                    FocusScope.of(context).requestFocus(textThirdFocusNode);
                                  }
                                  else if(_aadharSecondBox.length >1){
                                    _isEnableThirdBox= true;
                                  }
                                  else if(_aadharSecondBox.isEmpty){
                                    FocusScope.of(context).requestFocus(textFirstFocusNode);
                                  }

                                });

                              },
                            ),
                          )
                      ),

                          SizedBox(
                            width: 7,
                          ),

                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width*0.28,
                              child:TextFormField(
                                keyboardType: TextInputType.number,
                                focusNode: textThirdFocusNode,
                                controller: _aadharThirdBoxController,
                                enabled: _isEnableThirdBox,
                                inputFormatters: validate_aadharNumber(),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      top: 5, left: 10),
                                  hintText: "",
                                  border:
                                  OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2.0)),
                                ),
                                onChanged: (String _aadharThirdBox) {
                                  _aadharThirdBox = _aadharThirdBoxController.text;
                                  setState(() {
                                    if(_aadharThirdBox.isEmpty){
                                      FocusScope.of(context).requestFocus(textSecondFocusNode);
                                    }
                                  });

                                },
                              ),
                            ),
                          )
                          ,
                        ],
                      )

                  ),

                ],
              ),

            ),
          ],
        )
    );
  }

 String? validate_firstFourAadharNumber(String? value)
  {
    String patttern = r"^[2-9]{1}[0-9]{3}$";
    RegExp regExp = new RegExp(patttern);

    if (!regExp.hasMatch(value!)) {
      //return "Enter valid Aadhaar";
      return "";

    }
    return null;
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
              padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
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

                            validateToTheFields();
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

  }
  validateToTheFields()
  {
    aadhaarNumber=_aadharFirstBoxController.text+""+_aadharSecondBoxController.text+""+_aadharThirdBoxController.text;

    //print('show valid aadhaar number $aadhaarNumber');
    if(verhoeff.validate(aadhaarNumber))
    {
      verify_AadhaarNumber();
    }
    else
    {
      show_OKAlert("Enter Valid Aadhaar Number");
    }

  }
  verify_AadhaarNumber() async
  {


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

            show_SuccessAlert(message, client_id, "VerifyAadhaarOTP");

            save_kyc_verification_status("P");

          }
          else
          {
            if(aadhar_verified_status==true)
            {
              var full_name=decryptedDataObj1["full_name"];

              var dob=decryptedDataObj1["dob"];

              dob=Method.changeTheDateFormat_ForAadhaarCard(dob);
              //print('show dateofbirth $dob');



              var fatherName=decryptedDataObj1["care_of"];


              var loginTimeNameArr = loginTimeEmpName.toString().split(" ");
              var empFirstName_loginTimeName=loginTimeNameArr[0].toUpperCase().trim();
              //print('show emp full name empFirstName_loginTimeName $empFirstName_loginTimeName');
              //print('show emp full name aadhar based $full_name');


              bool compareNameStatus=full_name.toString().toUpperCase().contains(empFirstName_loginTimeName);
              //print('show emp full name empFirstName_loginTimeName status $compareNameStatus');

              /*-----------2-4-2022 end---------*/

              if(compareNameStatus) {


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

                show_SuccessAlert(message, client_id, "VerifyAadhaar");

              }
              else
              {
                show_OKAlert("Aadhaar verification fail due to name mismatch.");

              }

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

          save_kyc_verification_status("F");

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

  save_kyc_verification_status(String statusType) async
  {

    /*---statusType=P means pass or statusType=F means Fail--------*/

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.save_kyc_verification_status),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'js_id': getEncrypted_EmpCode(jsId_key),
          'kyc_type': "aadhaar",
          'status': statusType,

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

        //print('show status $message');


      } else {


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

        TextButton(onPressed: ()
        {
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

  show_SuccessAlert(String message,String clientId,String userArriveStatus)
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

          if(userArriveStatus=="VerifyAadhaar")
          {

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
                  ))
                  // profile_personalDetails_edit()

              ),);
            }

          }else if(userArriveStatus=="VerifyAadhaarOTP")
          {
            Navigator.push(context, MaterialPageRoute(builder: (_) =>

            Responsive(
                mobile: AadhaarCard_OTPView(clientID: clientId,aadhaarNumber: aadhaarNumber,USER_ARRIVE_FROM_STATUS: USER_ARRIVE_FROM_STATUS,),
                tablet: Center(
                  child: Container(
                    width: flutterWeb_tabletWidth,
                    child: AadhaarCard_OTPView(clientID: clientId,aadhaarNumber: aadhaarNumber,USER_ARRIVE_FROM_STATUS: USER_ARRIVE_FROM_STATUS,),
                  ),
                ),
                desktop: Center(
                  child: Container(
                    width: flutterWeb_desktopWidth,
                    child: AadhaarCard_OTPView(clientID: clientId,aadhaarNumber: aadhaarNumber,USER_ARRIVE_FROM_STATUS: USER_ARRIVE_FROM_STATUS,),
                  ),
                )
            )
                // AadhaarCard_OTPView(clientID: clientId,aadhaarNumber: aadhaarNumber,USER_ARRIVE_FROM_STATUS: USER_ARRIVE_FROM_STATUS,)

            ));
          }else
          {

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


}