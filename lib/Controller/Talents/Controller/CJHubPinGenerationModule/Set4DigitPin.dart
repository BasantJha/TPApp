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
import '../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../Services/AESAlgo/encrypt.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../Services/Messages/Message.dart';
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
      home: Set4DigitPin(title: 'CJ Hub'),
    );
  }
}
class Set4DigitPin extends StatefulWidget {
  Set4DigitPin({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _Set4DigitPin createState() => _Set4DigitPin();

}

class _Set4DigitPin extends State<Set4DigitPin> {
  // This widget is the root of your application.
  bool _visible = true;

  String completeEmpCode="";
  String empIp="",empUserId="";
  String fourDigitPinNumber="";
  String headingType="Generate 4 digit pin";
  String ecStatus="",jsId="";

  TextEditingController textEditingController = TextEditingController();
  String currentText = "";

  SingleChildScrollView mainFunction_UI(){
    return SingleChildScrollView(
      child: Column(children: <Widget>[

        //create_headingContainer(),
        SizedBox(
          height: 70,
        ),

        create_SetTextContainer(),


        create_PinBox(),


        //create_GenerateContainer(),

        create_height(),
        create_Button(),



      ],
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       /* appBar: AppBar(leading: BackButton(
            color: Colors.black
        ), backgroundColor: Color(0xfff0f0f2),centerTitle: true,
          title: Image.asset(getCJHub_AppLogo,height: 90,width: 90,),),
*/

        backgroundColor: Colors.white,
        appBar:CJAppBar(getCJHUB_SetFourDigitPinNumberTitle, appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action 1type");
          Navigator.pop(context);

        })),

        body: WillPopScope(
          child: Responsive(
            mobile: mainFunction_UI(),
            tablet: Center(
              child: Container(
                width: flutterWeb_tabletWidth,
                child: mainFunction_UI(),
              ),
            ),
            desktop: Container(
              width: flutterWeb_desktopWidth,
              child: mainFunction_UI(),
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

  /*-------------start 05-06-2022--------------*/
  Center create_SetTextContainer(){
    return Center(
      child:  Container(
        width: 300,
        // color: Colors.yellow,
        padding: const EdgeInsets.only(left: 30,right: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(headingType,
              style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
            ),            ],
        ),
      ),
    );
  }
  /*------------end 05-06-2022--------------------*/

  /*Container create_GenerateContainer(){
    return Container(

      width: MediaQuery.of(context).size.width*0.75,
      // color: Colors.yellow,
      padding: const EdgeInsets.only(left: 5,right: 5,top: 10),

      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'Re-Generate Pin',recognizer: TapGestureRecognizer()
                    ..onTap = ()
                    {
                      //print('Click to Generate Pin button');
                      },
                    style: TextStyle(color: primaryColor,fontSize: 15,fontWeight: FontWeight.bold),

                  ),
                ],
              ),
            ),        ],
        ),
      );

  }*/
  Container create_PinBox(){
    return Container(

      width: MediaQuery.of(context).size.width*1,
      // color: Colors.lightGreen,
      padding: const EdgeInsets.only(left: 20,right: 20),

      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          PinCodeTextField(
            length: 4,
            obscureText: true,
            autoFocus: true,
            // animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 50,
              activeFillColor: Colors.white,
            ),
            animationDuration: const Duration(milliseconds: 300),
            // backgroundColor: Colors.blue.shade50,
            enableActiveFill: true,
            controller: textEditingController,
            onCompleted: (v) {
              // debug
              //print("Completed");

              if(fourDigitPinNumber=="" || fourDigitPinNumber==null)
              {

                Method.snackBar_OkText(context, 'Enter 4 digit  pin');
                // show_OKAlert('Enter 4 digit  pin');

              }else
              {
                checkEnterInputNumber();
              }

            },
            onChanged: (output) {

              // print(output);
              setState(() {
                //print('show 4 digit pin number $output');
                fourDigitPinNumber=output;
              });
            },
            beforeTextPaste: (text) {
              return true;
            },
            appContext: context,
          ),

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
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
            onComplete: (output)
            {

            },
            onChange: (output)
            {
              // Your logic with pin code
              //print('show 4 digit pin number $output');
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

                    if(fourDigitPinNumber=="" || fourDigitPinNumber==null)
                    {

                      Method.snackBar_OkText(context, 'Enter 4 digit  pin');
                      // show_OKAlert('Enter 4 digit  pin');

                    }else
                    {
                      checkEnterInputNumber();
                    }

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
      save4DigitPinApiRequest();
    }
    else
    {
      Method.snackBar_OkText(context, "Enter 4 digit  pin");
      // show_OKAlert("Enter 4 digit  pin");
    }
  }

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

    //print('show emp pin number2 $fourDigitPinNumber');
    //String jsonTutorial = jsonEncode(listData);
    EasyLoading.show(status: Message.get_LoaderMessage);

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
  showNetworConnectionAlert()
  {
    var alertDialog = AlertDialog(
      content: Text(Message.get_NetworkConnectionMessage,
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

          if(ecStatus=="EC" || ecStatus =='TEC')
          {
            /*-----------19-11-2022(use)----------*/
/*
            Navigator.push( context, MaterialPageRoute(builder: (_) =>
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
            ));
*/
          }

          else if(ecStatus=="RTEC")
          {
            /*-----------19-11-2022(use)----------*/

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
          /*------------------7-4-2022 end-----------------------*/


        },

          child: Text("OK",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
      ],

    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }

  SizedBox create_height(){
    return SizedBox(
      height: 30,
    );
  }

}