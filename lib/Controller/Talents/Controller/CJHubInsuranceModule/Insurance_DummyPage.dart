import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../CustomView/CJHubCustomView/AutoLogout.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJHubCustomView/NetworkStatus/NetworkReachability.dart';
import '../../../../CustomView/CJHubCustomView/SalaryYearMonth_List.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../Services/AESAlgo/encrypt.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../Services/Messages/Message.dart';
import '../../ModelClasses/CJHubModelClasses/SalaryStatus_ModelResponse.dart';
import 'insurance_addInsurancePolicy.dart';
import 'insurance_editInsurancePolicy.dart';

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
      home: Insurance_DummyPage(title: 'CJ Hub'),
    );
  }
}
class Insurance_DummyPage extends StatefulWidget {

  Insurance_DummyPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _Insurance_DummyPage createState() => _Insurance_DummyPage();
}

class _Insurance_DummyPage extends State<Insurance_DummyPage> {

  bool buttonVisibility=true;
  String message="NOT INSURED YET?\nAPPLY FOR COMPANY GROUP\nINSURANCE NOW.";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkInsuranceStatus();
  }

  SingleChildScrollView mainFunction_UI(){
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        //create_headingContainer("Insurance"),

        //create_insuranceBannerContainer(),

        SizedBox(
          height: 20,
        ),
        create_text("Not Generated"),

        SizedBox(
          height: 5,
        ),

        //create_horizontalLine(),



        SizedBox(
          height: 40,
        ),

        /*  Visibility(
              visible: buttonVisibility,
              child: create_Button()
          ),*/

      ],
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white,
        appBar:CJAppBar(getCJHUB_InsuranceTitle, appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action type");
          Navigator.pop(context);

        })),

        body: WillPopScope(
          child: Responsive(
            mobile: mainFunction_UI(),
            tablet: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: insurance_tabletWidth,
                child: mainFunction_UI(),
              ),
            ),
            desktop: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: insurance_desktopWidth,
                child: mainFunction_UI(),
              ),
            ),
          ),

          /*onWillPop: ()
          {
            Message.alert_dialogAppExit(context);

          } ,*/

          onWillPop: () async => false,

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
            Expanded(
              flex: 1,
              child: Text(value,
                style: TextStyle(color: Colors.black,fontSize: 17),),
            ),
          ],
        ),
      ),
    );
  }

  Container create_insuranceBannerContainer(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30,0,30,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset("",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container create_text(String value)
  {
    return Container(
      // color: Colors.greenAccent,
      width: 400,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30,200,30,0),
        //minWidth: 300,
        //padding: EdgeInsets.only(left:20,right: 20,top: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value,textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }

  Padding create_horizontalLine(){
    return Padding(
      padding:EdgeInsets.symmetric(horizontal:10.0),
      child:Container(
          height:3.0,
          width:130.0,
          color: primaryColor),
    );
  }


  Material create_Button(){
    return Material(
      elevation: 0.0,
      borderRadius: BorderRadius.circular(5.0),
      color: primaryColor,
      child:MaterialButton(
          minWidth: 300,
          padding: EdgeInsets.only(left:20,right: 20),
          onPressed: ()
          {
            Navigator.push(context, MaterialPageRoute(builder: (_) =>

            Responsive(
                mobile: insurance_addInsurancePolicy(),
                tablet: Center(
                  child: Container(
                    width: flutterWeb_tabletWidth,
                    child: insurance_addInsurancePolicy(),
                  ),
                ),
                desktop: Center(
                  child: Container(
                    width: flutterWeb_desktopWidth,
                    child: insurance_addInsurancePolicy(),
                  ),
                ))
                // insurance_addInsurancePolicy()

            ),);

          },
          child: Text('APPLY INSURANCE POLICY',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 14))

      ),
    );
  }

  checkInsuranceStatus()
  {

    SharedPreference.getInsuranceMessage().then((insuranceMessage) =>
    {
      message=insuranceMessage
    });

    SharedPreference.getInsuranceStatus().then((insuranceStatus) =>  {

      loadInsuranceData(insuranceStatus)
    });
  }

  /*----------------check insurance status 8-9-2021 start----------------*/

  loadInsuranceData(String insuranceStatus)
  {
    setState(() {
      buttonVisibility=false;
      message=message;
    });
  }
/*----------------check insurance status 8-9-2021 end----------------*/

}