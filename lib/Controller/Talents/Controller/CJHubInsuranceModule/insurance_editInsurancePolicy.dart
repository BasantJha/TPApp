import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart'as http;
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
import '../CJHubInvestment_DeclarationModule/ModelClasses/Investment_Declaration_ChapterVI_ModelResponse.dart';
import 'insurance_addInsurancePolicy.dart';
import 'insurance_editInsurancePolicy.dart';

Timer? _rootTimer;

void main()
{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff00BFFF)
  ));
  runApp(MyApp());
}
class MyApp extends StatelessWidget
{
  // This widget is the root of your application.
  final List? listData;
  const MyApp({Key? key, this.listData}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
      (
      debugShowCheckedModeBanner: false,
      title: 'CJ Hub',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: insurance_editInsurancePolicy(title: 'CJ Hub',insurance_List:listData),
    );
  }
}
class insurance_editInsurancePolicy extends StatefulWidget
{
  //Insurance_EditInsurancePolicy( {Key key, this.title,this.insurance_List}) : super(key: key);
  insurance_editInsurancePolicy( {Key? key, this.title,this.insurance_List}) : super(key: key);

  final String? title;
  final List? insurance_List;

  @override
  _insurance_editInsurancePolicy createState() => _insurance_editInsurancePolicy(this.insurance_List!);

}

class _insurance_editInsurancePolicy extends State<insurance_editInsurancePolicy> {

  GlobalKey<FormState> formkeySpouse = GlobalKey<FormState>();
  GlobalKey<FormState> formkeyDaughter = GlobalKey<FormState>();
  GlobalKey<FormState> formkeySon = GlobalKey<FormState>();


  /*-------custom constructor method start-------*/
  List insuranceListData=[];

  _insurance_editInsurancePolicy(List<dynamic> insurance_list)
  {
    insuranceListData = insurance_list;
    // //print('show edit items $insurance_list');
  }
  /*-------custom constructor method end-------*/



  String mySelf_Key="",mySelf_Value="",spouse_Key="",spouse_Value="",daughter_Key="",daughter_Value="",son_Key="",son_Value="";

  String txt_spouseName="",txt_spouseAge="",
      txt_daughterName="",txt_daughterAge="",
      txt_sonName="",txt_sonAge="";

  //String input_DependentName="";
  //String input_DependentAge="";

  int selectedIndex=0;

  bool _visibleSpouse = false;
  bool _visibleDaughter = false;
  bool _visibleSon = false;


  String completeEmpCode="",financialYear="";

  String empIp="",empUserId="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // //print('show edit items $insuranceListData');

    loadData();

    if(kIsWeb){

      // //print("This CJ Hub investment_declaration tax section Web");

      AutoLogout.initializeTimer(context);

    }
    else{

      // //print('this is mobile App');

    }
  }

  void _handleUserInteraction([_]) {
    if (_rootTimer != null && !_rootTimer!.isActive) {
      // This means the user has been logged out
      return;
    }

    _rootTimer?.cancel();

    // //print("insurance editPolicy resetTimer");

    AutoLogout.initializeTimer(context);
  }

  SingleChildScrollView mainFunction_UI(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          create_headingContainer("Insurance"),

          create_text("Who would you like to insure ?"),

          create_cardMyself(),

          Visibility(
            visible: _visibleSpouse,
            child: create_cardSpouseAdd(),
          ),

          Visibility(
            visible: _visibleDaughter,
            child: create_cardDaughterAdd(),
          ),

          Visibility(
            visible: _visibleSon,
            child: create_cardSonAdd(),
          ),
          // create_cardSonAdd1(),

          SizedBox(
            height: 15,
          ),

          create_horizontalLine(),

          SizedBox(
            height: 30,
          ),

          create_Button(),

        ],
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handleUserInteraction,
        onPointerMove: _handleUserInteraction,
        onPointerUp: _handleUserInteraction,
        child:
      Scaffold(
      /*appBar: AppBar(leading: BackButton(
          color: Colors.black
      ), backgroundColor: Color(0xfff0f0f2), centerTitle: true,
        title: Image.asset(getCJHub_AppLogo, height: 90, width: 90,),),*/

        backgroundColor: Colors.white,
        appBar:CJAppBar(getCJHUB_InsuranceTitle, appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action type");
          Navigator.pop(context);

        })),

      body: Responsive(
        mobile: mainFunction_UI(),
        tablet: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: insurance_addInsurancePolicy_tabletWidth,
            child: mainFunction_UI(),
          ),
        ),
        desktop: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: insurance_addInsurancePolicy_desktopWidth,
            child: mainFunction_UI(),
          ),
        ),
      ),
    )
    );
  }

  Container create_cardMyself() {
    return Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Card(
            // color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: primaryColor,
                width: 0.5,
              ),
            ),
            child: Container(child: ListTile(

              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("My Self",
                    style: TextStyle(color: primaryColor, fontSize: 17),),

                ],
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(mySelf_Value,
                    style: TextStyle(color: Colors.black, fontSize: 13),),

                ],
              ),
            ),
            ),
          ),
        )
    );
  }

  Container create_cardSpouseAdd() {
    return Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Card(
            // color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: primaryColor,
                width: 0.5,
              ),
            ),
            child: Container(child: ListTile(

              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text(spouse_Key,
                    style: TextStyle(color: primaryColor, fontSize: 17),),

                ],
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(spouse_Value,
                    style: TextStyle(color: Colors.black, fontSize: 13),),

                ],
              ),
              trailing: SizedBox(
                height: 30, //height of button
                width: 100,
                child: MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () => alert_dialogSpouse(context),
                    child: Text('Edit',
                        style: TextStyle(fontFamily: 'Vonique',
                            fontSize: 17,
                            color: primaryColor))),
              ),
            ),
            ),
          ),
        )
    );
  }

  Container create_cardDaughterAdd() {
    return Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Card(
            // color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: primaryColor,
                width: 0.5,
              ),
            ),
            child: Container(child: ListTile(

              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text(daughter_Key,
                    style: TextStyle(color: primaryColor, fontSize: 17),),

                ],
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(daughter_Value,
                    style: TextStyle(color: Colors.black, fontSize: 13),),

                ],
              ),
              trailing: SizedBox(
                height: 30, //height of button
                width: 100,
                child: MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () => alert_dialogDaughter(context),
                    child: Text('Edit',
                        style: TextStyle(fontFamily: 'Vonique',
                            fontSize: 17,
                            color: primaryColor))),
              ),
            ),
            ),
          ),
        )
    );
  }

  /* Container create_cardDaughterAdd1() {
    return Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Card(
            // color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: primaryColor,
                width: 0.5,
              ),
            ),
            child: Container(child: ListTile(

              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text("Spouse",
                    style: TextStyle(color: primaryColor, fontSize: 17),),

                ],
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("bjhhgvb,50 Male",
                    style: TextStyle(color: Colors.black, fontSize: 13),),

                ],
              ),
              trailing: SizedBox(
                height: 30, //height of button
                width: 100,
                child: MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      setState(() {

                      });
                    },
                    // => alert_dialog(context),
                    child: Text('Edit',
                        style: TextStyle(fontFamily: 'Vonique',
                            fontSize: 17,
                            color: primaryColor))),
              ),
            ),
            ),
          ),
        )
    );
  }*/

  Container create_cardSonAdd() {
    return Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Card(
            // color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: primaryColor,
                width: 0.5,
              ),
            ),
            child: Container(child: ListTile(

              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text(son_Key,
                    style: TextStyle(color: primaryColor, fontSize: 17),),

                ],
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(son_Value,
                    style: TextStyle(color: Colors.black, fontSize: 13),),

                ],
              ),
              trailing: SizedBox(
                height: 30, //height of button
                width: 100,
                child: MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () => alert_dialogSon(context),
                    child: Text('Edit',
                        style: TextStyle(fontFamily: 'Vonique',
                            fontSize: 17,
                            color: primaryColor))),
              ),
            ),
            ),
          ),
        )
    );
  }

  /* Container create_cardSonAdd1() {
    return Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Card(
            // color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: primaryColor,
                width: 0.5,
              ),
            ),
            child: Container(child: ListTile(

              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text("Son",
                    style: TextStyle(color: primaryColor, fontSize: 17),),

                ],
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Xyzabh,5 Male",
                    style: TextStyle(color: Colors.black, fontSize: 13),),

                ],
              ),
              trailing: SizedBox(
                height: 30, //height of button
                width: 100,
                child: MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      setState(() {

                      });
                    },
                    // => alert_dialog(context),
                    child: Text('Edit',
                        style: TextStyle(fontFamily: 'Vonique',
                            fontSize: 17,
                            color: primaryColor))),
              ),
            ),
            ),
          ),
        )
    );
  }*/

  alert_dialogDaughter(BuildContext context) {
    var alertDialog = AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 300.0,
        height: 250.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius:
          new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: new Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // dialog top
            new Expanded(
              child: new Container(
                  color: primaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: const EdgeInsets.only(left: 7),
                        child: Text("Daughter Details",
                          style: TextStyle(color: Colors.white, fontSize: 17),),
                      ),


                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },

                        child: Icon(
                          Icons.close, color: Colors.white, size: 30,),
                      ),


                    ],
                  )
              ),
            ),

            // dialog centre
            new Expanded(
              child: new Container(
                child: Form(
                  // autovalidate: true, //check for validation while typing
                    key: formkeyDaughter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: twoHunGreyColor,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: twoHunGreyColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 5, left: 3),
                                hintText: txt_daughterName,
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            txt_daughterName=value;
                          },
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Enter Name"),

                              ])
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                fillColor: twoHunGreyColor,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: twoHunGreyColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 5, left: 3),
                                hintText: txt_daughterAge,
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            txt_daughterAge=value;
                          },
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Enter Age"),

                              ])
                          ),
                        ),

                      ],
                    )
                ),
              ),
              flex: 4,
            ),

            // dialog bottom
            new Expanded(
              child: new Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 30, //height of button
                          width: 100,
                          child: MaterialButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                if (formkeyDaughter.currentState!.validate()) {
                                  Navigator.of(context).pop();

                                  setState(() {

                                    selectedIndex=2;
                                    editValueInDialog(selectedIndex,txt_daughterName,txt_daughterAge);
                                  });

                                  // //print("Validated");
                                } else {
                                  // //print("Not Validated");
                                }
                              },

                              child: Text('OK',
                                  style: TextStyle(fontFamily: 'Vonique',
                                      fontSize: 17,
                                      color: Colors.black))),
                        ),
                      ),

                    ],
                  )
              ),
            ),
          ],
        ),
      ),

    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }

  alert_dialogSon(BuildContext context) {
    var alertDialog = AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 300.0,
        height: 250.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius:
          new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: new Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // dialog top
            new Expanded(
              child: new Container(
                  color: primaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: const EdgeInsets.only(left: 7),
                        child: Text("Daughter Details",
                          style: TextStyle(color: Colors.white, fontSize: 17),),
                      ),


                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },

                        child: Icon(
                          Icons.close, color: Colors.white, size: 30,),
                      ),


                    ],
                  )
              ),
            ),

            // dialog centre
            new Expanded(
              child: new Container(
                child: Form(
                  // autovalidate: true, //check for validation while typing
                    key: formkeyDaughter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: twoHunGreyColor,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: twoHunGreyColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 5, left: 3),
                                hintText: txt_sonName,
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            txt_sonName=value;
                          },
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Enter Name"),

                              ])
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                fillColor: twoHunGreyColor,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: twoHunGreyColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 5, left: 3),
                                hintText: txt_sonAge,
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            txt_sonAge=value;
                          },
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Enter Age"),

                              ])
                          ),
                        ),

                      ],
                    )
                ),
              ),
              flex: 4,
            ),

            // dialog bottom
            new Expanded(
              child: new Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 30, //height of button
                          width: 100,
                          child: MaterialButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                if (formkeyDaughter.currentState!.validate()) {
                                  Navigator.of(context).pop();

                                  setState(() {
                                    selectedIndex=3;
                                    editValueInDialog(selectedIndex,txt_sonName,txt_sonAge);
                                  });

                                  // //print("Validated");
                                } else {
                                  // //print("Not Validated");
                                }
                              },

                              child: Text('OK',
                                  style: TextStyle(fontFamily: 'Vonique',
                                      fontSize: 17,
                                      color: Colors.black))),
                        ),
                      ),

                    ],
                  )
              ),
            ),
          ],
        ),
      ),

    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }

  Container create_horizontalLine() {
    return Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
              height: 3.0,
              width: 400.0,
              color: twoHunGreyColor),
        )
    );
  }

  Container create_headingContainer(String value) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
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
                style: TextStyle(color: Colors.black, fontSize: 17),),
            ),
          ],
        ),
      ),
    );
  }

  Container create_text(String value) {
    return Container(
      // color: Colors.greenAccent,
      // width: 200,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }

  Material create_Button() {
    return Material(
      elevation: 0.0,
      borderRadius: BorderRadius.circular(5.0),
      color: primaryColor,
      child: MaterialButton(
          minWidth: 150,
          height: 50,
          padding: EdgeInsets.only(left: 20, right: 20),
          onPressed: () {

            saveInsuranceDetails();
          },
          child: Text('Send Request',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Vonique', color: Colors.white, fontSize: 13))

      ),
    );
  }

  alert_dialogSpouse(BuildContext context)
  {
    var alertDialog = AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 300.0,
        height: 250.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius:
          new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: new Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // dialog top
            new Expanded(
              child: new Container(
                  color: primaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: const EdgeInsets.only(left: 7),
                        child: Text("Spouse Details",
                          style: TextStyle(color: Colors.white, fontSize: 17),),
                      ),


                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: ()
                        {
                          Navigator.of(context).pop();
                        },

                        child: Icon(
                          Icons.close, color: Colors.white, size: 30,),
                      ),

                    ],
                  )
              ),
            ),

            // dialog centre
            new Expanded(
              child: new Container(
                child: Form(
                  // autovalidate: true, //check for validation while typing
                    key: formkeySpouse,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: twoHunGreyColor,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: twoHunGreyColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 5, left: 3),
                                hintText: txt_spouseName,
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            txt_spouseName=value;
                          },
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Enter Name"),
                              ])
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                fillColor: twoHunGreyColor,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: twoHunGreyColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 5, left: 3),
                                hintText: txt_spouseAge,
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            txt_spouseAge=value;
                          },
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Enter Age"),
                              ])
                          ),
                        ),

                      ],
                    )
                ),
              ),
              flex: 4,
            ),

            // dialog bottom
            new Expanded(
              child: new Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 30, //height of button
                          width: 100,
                          child: MaterialButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: ()
                              {
                                if (formkeySpouse.currentState!.validate())
                                {
                                  Navigator.of(context).pop();
                                  setState(()
                                  {
                                    selectedIndex=1;
                                    editValueInDialog(selectedIndex,txt_spouseName,txt_spouseAge);
                                  });

                                  // //print("Validated");
                                } else {
                                  // //print("Not Validated");
                                }
                              },

                              child: Text('OK',
                                  style: TextStyle(fontFamily: 'Vonique',
                                      fontSize: 17,
                                      color: Colors.black))),
                        ),
                      ),

                    ],
                  )
              ),
            ),
          ],
        ),
      ),

    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }


  loadData() {
    int len = insuranceListData.length;
    for (int i = 0; i < len; i++) {
      Map obj = insuranceListData[i];
      String GenderType = obj["gender"];
      String GenderName = obj["dependentname"];
      String GenderAge = obj["age"];
      String relationship = obj["relationship"];
      String aliasName = obj["aliasName"];

      setState(() {

        if (i == 0)
        {
          mySelf_Key="My Self";
          mySelf_Value= GenderName + ", " + GenderAge + " " + GenderType;
        }
        else if (i == 1)
        {
          spouse_Key=aliasName;
          spouse_Value=GenderName + ", " + GenderAge + " " + GenderType;
          _visibleSpouse=true;

          txt_spouseName=GenderName;
          txt_spouseAge=GenderAge;

        }
        else if (i == 2)
        {
          daughter_Key=aliasName;
          daughter_Value= GenderName + ", " + GenderAge + " " + GenderType;
          _visibleDaughter=true;

          txt_daughterName=GenderName;
          txt_daughterAge=GenderAge;
        }
        else if (i == 3)
        {
          son_Key=aliasName;
          son_Value=GenderName + ", " + GenderAge + " " + GenderType;
          _visibleSon=true;

          txt_sonName=GenderName;
          txt_sonAge=GenderAge;
        }
        else {

        }

      });

    }
  }

  editValueInDialog(int i,String txt_dependentName,String txt_dependentAge)
  {

    Map obj = insuranceListData[i];
    String genderType = obj["gender"];
    //String GenderName = obj["dependentname"];
    //String GenderAge = obj["age"];
    String relationship = obj["relationship"];
    String aliasName = obj["aliasName"];


    Map<String, String> updateMap = {'gender': genderType, 'dependentname': txt_dependentName,
      'age': txt_dependentAge,'relationship':relationship, 'dob':"-",
      'aliasName':aliasName};
    insuranceListData.replaceRange(i, i + 1, [updateMap]);

    setState(()
    {
      loadData();
      //insuranceListData=insuranceListData;
      // //print('show updated records $insuranceListData');

    });

  }

  saveInsuranceDetails()
  {
    String mobileNumber_key="",empCode_key="",
        empDateOfBirth_key="";

    SharedPreference.getEmpMobileNo().then((value) =>  {
      mobileNumber_key=value,
      // //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpCode().then((value) =>  {
      empCode_key=value,
      // //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth_key=value,
      // //print('show emp name2 $value'),
      completeEmpCode = mobileNumber_key+"CJHUB"+empCode_key+"CJHUB"+empDateOfBirth_key,
      // //print('show emp completeEmpCode $completeEmpCode'),

    });

    SharedPreference.getEmpId().then((value) =>  {
      // //print('show emp name2 $value'),
      empUserId=value,

    });

    Method.getIPAddress().then((value) =>  {
      // //print('show emp name2 $value'),
      empIp=value,
      save_InsuranceDetails_webApi()

    });

  }
  save_InsuranceDetails_webApi() async
  {
    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.save_Emp_Insurance_Details),
        headers: <String, String>{
          'Content-Type': "application/json",
        },

        body:  json.encode({
          'request_type': "Add",
          'request_by_user_type': "Employee",
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'emp_ip': empIp,
          'created_by': empUserId,
          'dependent_count': insuranceListData.length,
          'dependent_details': insuranceListData,

        }),
      );
      // //print(response.statusCode);
      if (response.statusCode == 200)
      {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        // //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        Investment_Declaration_ChapterVI_ModelResponse vi_modelResponse = Investment_Declaration_ChapterVI_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(vi_modelResponse.statusCode==true)
        {
          Method.snackBar_OkText(context,vi_modelResponse.message );
          // show_OKAlert(vi_modelResponse.message);

        }
        else
        {
          if (vi_modelResponse.message==null || vi_modelResponse.message=="")
          {
            Method.snackBar_OkText(context,"server error!" );

            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context,vi_modelResponse.message );

            // show_OKAlert(vi_modelResponse.message);
          }
        }

      } else {

        EasyLoading.dismiss();

        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      // //print(e);
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
  show_OKAlert(String message)
  {

    /*------SnackBar-----21-07-2022--------start-----------*/

    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    /*-----SnackBar------21-07-2022--------end-----------*/

    /*-----AlertDialog------start----------------------*/
    /*var alertDialog = AlertDialog(
      content: Text(message,
        textAlign: TextAlign.left,),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [

        TextButton(onPressed: ()
        {
          Navigator.of(context).pop();
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
}

