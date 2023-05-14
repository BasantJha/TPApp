import 'dart:convert';
import 'dart:ui';

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
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../CustomView/CJHubCustomView/ValidateClass.dart';
import '../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/Messages/Message.dart';
import '../CJHubTECView/KYC_details_Add_Edit.dart';
import '../CJHubTECView/profile_personalDetails_edit.dart';
import 'AadhaarCardView.dart';


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
      home: PanCardView(title: 'CJ Hub'),
    );
  }
}
class PanCardView extends StatefulWidget {

  PanCardView({Key? key, this.title,this.USER_ARRIVE_FROM_STATUS}) : super(key: key);

  final String? title;
  final String? USER_ARRIVE_FROM_STATUS;


  @override
  _PanCardView createState() => _PanCardView(USER_ARRIVE_FROM_STATUS!);
}
class _PanCardView extends State<PanCardView> {
  // This widget is the root of your application.
  final _aadharFirstBoxController=TextEditingController();
  final _aadharSecondBoxController=TextEditingController();
  final _aadharThirdBoxController=TextEditingController();
  final _panCardController=TextEditingController();
  FocusNode textSecondFocusNode = new FocusNode();
  FocusNode textThirdFocusNode = new FocusNode();
  FocusNode textFristFocusNode = new FocusNode();

  bool _isEnableSecondBox =false;
  bool _isEnableThirdBox =false;

  String panNumber="",jsId_key="";

  bool panCardStatus=false;
  String kyc_STATUSCode="";
  String USER_ARRIVE_FROM_STATUS="";
  String loginTimeEmpName="";

  _PanCardView(String user_arrive_from_status)
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



          create_PANCard(),

          create_Button_Verify(),


        ]
        ),
      ),
    );
  }



  Container create_PANCard() {
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
                      child: asteriskText("PAN Card"),
                      // Text("Relation with Nominee",style: TextStyle(color: Colors.black,fontSize: 13),),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),



                  Container(
                    height: 50,
                    child: Form(
                      key: formkey_panCard,
                      child:
                      TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        keyboardType: TextInputType.text,
                        controller: _panCardController,
                        inputFormatters: validate_panCard(),
                        validator: validate_PAN,
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
                        onChanged: (String _panNumber)
                        {
                          _panNumber = _panCardController.text;
                          panNumber=_panNumber;


                          setState(() {



                            if(_panNumber.length<=10 )
                            {
                              panCardStatus=validate_PANCard();
                              //print("validation check $panCardStatus");


                            }
                            else {
                              panCardStatus=false;
                              //print("invalid input");
                            }


                          });



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

                            validateToThePANNumber();
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

    //24-3-20222 START

    SharedPreference.getKYC_STATUSCode().then((value) =>  {
      //print('show emp KYC_STATUSCode $value'),
      kyc_STATUSCode=value

    });
  }
  validateToThePANNumber()
  {
    if(panCardStatus==true)
    {
      verify_PanCardNumber();
    }
    else
    {
      show_OKAlert("Enter Correct PAN Number");

    }
  }
  verify_PanCardNumber() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.verify_PAN_Number),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'id_number': getEncrypted_EmpCode(panNumber),
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

        if(statusCode==true)
        {

          var encryptedData=responseBody["data"];
          var decryptedDataObj=getDecryptedData(encryptedData);
          var decryptedDataObj1=jsonDecode(decryptedDataObj);
          var pancardEmpName=decryptedDataObj1["full_name"];
          var pan_number=decryptedDataObj1["pan_number"];

          /*-----------2-4-2022 start---------*/
          //var panCardNameArr=pancardEmpName.toString().split(" ");
          //var empFirstName_panCard=panCardNameArr[0].toUpperCase();
          ////print('show emp full name empFirstName_panCard $empFirstName_panCard');

          var loginTimeNameArr = loginTimeEmpName.toString().split(" ");
          var empFirstName_loginTimeName=loginTimeNameArr[0].toUpperCase().trim();

          //print('show emp full name empFirstName_loginTimeName $empFirstName_loginTimeName');
          //print('show emp pancardEmpName $pancardEmpName');


          bool compareNameStatus=pancardEmpName.toString().toUpperCase().contains(empFirstName_loginTimeName);
          //print('show emp full name empFirstName_loginTimeName status $compareNameStatus');

          /*-----------2-4-2022 end---------*/

          if(compareNameStatus) {

            SharedPreference.setEmpName(pancardEmpName);
            SharedPreference.setEmpPanCardNumber(pan_number);
            SharedPreference.setPANCard_STATUS("1");

            //print('show emp data details $decryptedDataObj1');
            //print('show emp full name $pancardEmpName');

            show_SuccessAlert(message);
            save_kyc_verification_status("P");

          }
          else
          {
            show_OKAlert("PAN verification fail due to name mismatch.");
            save_kyc_verification_status("F");

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

    //print('show js id $jsId_key');
    //print('show statusType $statusType');

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.save_kyc_verification_status),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'js_id': getEncrypted_EmpCode(jsId_key),
          'kyc_type': "pan",
          'status': statusType,

        },
      );


      //print(response.statusCode);
      //print(response.body);

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

          /*-----------24-3-2022 START-----------*/

          if(kyc_STATUSCode=="3")
          {
            if(USER_ARRIVE_FROM_STATUS=="KYCDetails") {
              Navigator.push(context, MaterialPageRoute(builder: (_) =>

              Responsive(
                  mobile: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                  tablet: Center(
                    child: Container(
                      width: flutterWeb_tabletWidth,
                      child: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                    ),
                  ),
                  desktop: Center(
                    child: Container(
                      width: flutterWeb_desktopWidth,
                      child: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                    ),
                  ))
                  // AadhaarCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",)

              ),);

            }
            else
            {
              Navigator.push(context, MaterialPageRoute(builder: (_) =>

              Responsive(
                  mobile: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
                  tablet: Center(
                    child: Container(
                      width: flutterWeb_tabletWidth,
                      child: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
                    ),
                  ),
                  desktop: Center(
                    child: Container(
                      width: flutterWeb_desktopWidth,
                      child: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
                    ),
                  )
              )
                  // AadhaarCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",)

              ),);
            }

          }
          else
          {
            if(USER_ARRIVE_FROM_STATUS=="KYCDetails")
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>

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
                ),
              )
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
          }

          /*-----------24-3-2022 END-----------*/


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