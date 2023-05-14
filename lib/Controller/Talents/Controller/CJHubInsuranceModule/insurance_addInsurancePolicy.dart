import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

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
import 'insurance_editInsurancePolicy.dart';

Timer? _rootTimer;

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
      home: insurance_addInsurancePolicy(title: 'CJ Hub'),
    );
  }
}

class insurance_addInsurancePolicy extends StatefulWidget {
  insurance_addInsurancePolicy({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _Insurance_AddInsurancePolicy createState() => _Insurance_AddInsurancePolicy();

}

class _Insurance_AddInsurancePolicy extends State<insurance_addInsurancePolicy> {


  GlobalKey<FormState> formkeySpouse = GlobalKey<FormState>();
  GlobalKey<FormState> formkeyDaughter = GlobalKey<FormState>();
  GlobalKey<FormState> formkeySon = GlobalKey<FormState>();

  bool _visibleSpouse = true;
  bool _visibleDaughter = true;

  bool _visibleDaughter1_add = false;
  bool _visibleDaughter1_cancel = false;

  bool _visibleSon = true;

  bool _visibleSon1_add = false;
  bool _visibleSon1_cancel = false;


  int totalMemberCount= 1;

  String empGender="",empName="",dateOfBirth="";
  List addInsurance_List=[];

  String input_DependentName="";
  String input_DependentAge="";

  @override
  void initState() {

    super.initState();

    getEmpInfo();

    if(kIsWeb){

      print("This CJ Hub insurance add Policy Web");

      AutoLogout.initializeTimer(context);

    }
    else{

      // //print('this is mobile App');

    }
  }

  SingleChildScrollView mainFunction_UI(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          create_headingContainer("Insurance"),

          create_text("Who would you like to insure ?"),

          create_cardMyself(),

          Visibility(
            visible: !_visibleSpouse,
            child: create_cardSpouseAdd(),
          ),
          Visibility(
            visible: _visibleSpouse,
            child: create_cardSpouseCancel(),
          ),

          Visibility(
            visible: !_visibleDaughter,
            child: create_cardDaughter_Add(),
          ),
          Visibility(
            visible: _visibleDaughter,
            child: create_cardDaughter_Cancel(),
          ),
          Visibility(
            visible: _visibleDaughter1_add,
            child: create_cardDaughter_Add1(),
          ),
          Visibility(
            visible: _visibleDaughter1_cancel,
            child: create_cardDaughter_Cancel1(),
          ),

          Visibility(
            visible: !_visibleSon,
            child: create_cardSonCancel(),
          ),
          Visibility(
            visible: _visibleSon,
            child: create_cardSonADD(),
          ),
          Visibility(
            visible: _visibleSon1_add,
            child: create_cardSon1_add(),
          ),

          Visibility(
            visible: _visibleSon1_cancel,
            child: create_cardSonCancel1(),
          ),


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

  void _handleUserInteraction([_]) {
    if (_rootTimer != null && !_rootTimer!.isActive) {
      // This means the user has been logged out
      return;
    }

    _rootTimer?.cancel();

    // //print("insurance editPolicy resetTimer");

    AutoLogout.initializeTimer(context);
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
        ), backgroundColor: Color(0xfff0f0f2),centerTitle: true,
          title: Image.asset(getCJHub_AppLogo,height: 90,width: 90,),),
*/
        backgroundColor: Colors.white,
        appBar:CJAppBar(getCJHUB_InsuranceTitle, appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action 1type");
          Navigator.pop(context);

        })),

        body:  Responsive(
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

  Container create_cardMyself()
  {
    return  Container(
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
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(getCJHub_SalaryStatusBlueTick,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 5),
                    child: Text("My Self",style: TextStyle(color: Colors.black,fontSize: 17),),
                  )
                ],
              ),
            ),
            ),
          ) ,
        )
    );
  }

  Container create_cardSpouseCancel()
  {
    return  Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Card(
            color: addInsuranceCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: addInsuranceCardColor,
                width: 0.5,
              ),
            ),
            child: Container(child: ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(getCJHub_SpouseIcon,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 5),
                    child: Text("Spouse",style: TextStyle(color: Colors.black,fontSize: 17),),
                  )

                ],
              ),
              trailing: SizedBox(
                height:30, //height of button
                width:80,
                child:MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed:()
                    => alert_dialogSpouse(context),
                    child: Text('+ ADD',
                        style: TextStyle(fontFamily:'Vonique',fontSize: 17,color: primaryColor ))),
              ),
            ),
            ),
          ) ,
        )
    );
  }

  Container create_cardSpouseAdd(){
    return  Container(
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
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(getCJHub_SalaryStatusBlueTick,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 5),
                    child: Text("Spouse",style: TextStyle(color: Colors.black,fontSize: 17),),
                  )
                ],
              ),
              trailing: SizedBox(
                height:30, //height of button
                width:100,
                child:MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed:()
                    {
                      setState(()
                      {
                        _visibleSpouse = !_visibleSpouse;
                        totalCountMember_Subtraction();
                        removeTheAddMemeberFromListArr("Spouse");


                        //showToastMessage("cancel message");
                      });
                    },
                    // => alert_dialog(context),
                    child: Text('Cancel',
                        style: TextStyle(fontFamily:'Vonique',fontSize: 17,color: primaryColor ))),
              ),
            ),
            ),
          ) ,
        )
    );
  }

  Container create_cardDaughter_Add(){
    return  Container(
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
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(getCJHub_SalaryStatusBlueTick,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 5),
                    child: Text("Daughter",style: TextStyle(color: Colors.black,fontSize: 17),),
                  )
                ],
              ),
              trailing: SizedBox(
                height:30, //height of button
                width:100,
                child:MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed:(){
                      setState(()
                      {
                        _visibleDaughter = !_visibleDaughter;
                        totalCountMember_Subtraction();
                        removeTheAddMemeberFromListArr("Daughter");


                      });
                    },

                    child: Text('Cancel',
                        style: TextStyle(fontFamily:'Vonique',fontSize: 17,color: primaryColor ))),
              ),
            ),
            ),
          ) ,
        )
    );
  }
  Container create_cardDaughter_Cancel(){
    return  Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Card(
            color: addInsuranceCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: addInsuranceCardColor,
                width: 0.5,
              ),
            ),
            child: Container(child: ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(getCJHub_DaughterIcon,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 5),
                    child: Text("Daughter",style: TextStyle(color: Colors.black,fontSize: 17),),
                  )

                ],
              ),
              trailing: SizedBox(
                height:30, //height of button
                width:80,
                child:MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed:()
                    => alert_dialogDaughter(context),
                    child: Text('+ ADD',
                        style: TextStyle(fontFamily:'Vonique',fontSize: 17,color: primaryColor ))),
              ),
            ),
            ),
          ) ,
        )
    );
  }

  Container create_cardDaughter_Add1()
  {
    return  Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Card(
            color: addInsuranceCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: addInsuranceCardColor,
                width: 0.5,
              ),
            ),
            child: Container(child: ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(getCJHub_DaughterIcon,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 5),
                    child: Text("Daughter",style: TextStyle(color: Colors.black,fontSize: 17),),
                  )

                ],
              ),
              trailing: SizedBox(
                height:30, //height of button
                width:80,
                child:MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed:()
                    => alert_dialogDaughter1(context),
                    child: Text('+ ADD',
                        style: TextStyle(fontFamily:'Vonique',fontSize: 17,color: primaryColor ))),
              ),
            ),
            ),
          ) ,
        )
    );

  }
  Container create_cardDaughter_Cancel1()
  {

    return  Container(
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
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(getCJHub_SalaryStatusBlueTick,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 5),
                    child: Text("Daughter",style: TextStyle(color: Colors.black,fontSize: 17),),
                  )
                ],
              ),
              trailing: SizedBox(
                height:30, //height of button
                width:100,
                child:MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed:(){
                      setState(() {


                        _visibleDaughter1_add=false;
                        _visibleDaughter1_cancel=false;

                        totalCountMember_Subtraction();
                        removeTheAddMemeberFromListArr("Daughter1");


                      });
                    },

                    child: Text('Cancel',
                        style: TextStyle(fontFamily:'Vonique',fontSize: 17,color: primaryColor ))),
              ),
            ),
            ),
          ) ,
        )
    );

  }

  Container create_cardSonADD(){
    return  Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Card(
            color: addInsuranceCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: addInsuranceCardColor,
                width: 0.5,
              ),
            ),
            child: Container(child: ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(getCJHub_SonIcon,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 5),
                    child: Text("Son",style: TextStyle(color: Colors.black,fontSize: 17),),
                  )

                ],
              ),
              trailing: SizedBox(
                height:30, //height of button
                width:80,
                child:MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed:()
                    => alert_dialogSon(context),
                    child: Text('+ ADD',
                        style: TextStyle(fontFamily:'Vonique',fontSize: 17,color: primaryColor ))),
              ),
            ),
            ),
          ) ,
        )
    );
  }
  Container create_cardSon1_add(){
    return  Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Card(
            color: addInsuranceCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: addInsuranceCardColor,
                width: 0.5,
              ),
            ),
            child: Container(child: ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(getCJHub_SonIcon,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 5),
                    child: Text("Son",style: TextStyle(color: Colors.black,fontSize: 17),),
                  )

                ],
              ),
              trailing: SizedBox(
                height:30, //height of button
                width:80,
                child:MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed:()
                    => alert_dialogSon1(context),
                    child: Text('+ ADD',
                        style: TextStyle(fontFamily:'Vonique',fontSize: 17,color: primaryColor ))),
              ),
            ),
            ),
          ) ,
        )
    );
  }
  Container create_cardSonCancel(){
    return  Container(
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
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(getCJHub_SalaryStatusBlueTick,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 5),
                    child: Text("Son",style: TextStyle(color: Colors.black,fontSize: 17),),
                  )
                ],
              ),
              trailing: SizedBox(
                height:30, //height of button
                width:100,
                child:MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed:(){
                      setState(() {
                        _visibleSon = !_visibleSon;
                        totalCountMember_Subtraction();

                        removeTheAddMemeberFromListArr("Son");

                      });
                    },
                    // => alert_dialog(context),
                    child: Text('Cancel',
                        style: TextStyle(fontFamily:'Vonique',fontSize: 17,color: primaryColor ))),
              ),
            ),
            ),
          ) ,
        )
    );
  }

  Container create_cardSonCancel1(){
    return  Container(
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
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(getCJHub_SalaryStatusBlueTick,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 5),
                    child: Text("Son",style: TextStyle(color: Colors.black,fontSize: 17),),
                  )
                ],
              ),
              trailing: SizedBox(
                height:30, //height of button
                width:100,
                child:MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed:(){
                      setState(()
                      {
                        //_visibleSon = !_visibleSon;

                        _visibleSon1_add=false;
                        _visibleSon1_cancel=false;

                        totalCountMember_Subtraction();

                        removeTheAddMemeberFromListArr("Son1");


                      });
                    },
                    // => alert_dialog(context),
                    child: Text('Cancel',
                        style: TextStyle(fontFamily:'Vonique',fontSize: 17,color: primaryColor ))),
              ),
            ),
            ),
          ) ,
        )
    );
  }


  Container create_horizontalLine(){
    return Container(
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal:20.0),
          child:Container(
              height:3.0,
              width:400.0,
              color: twoHunGreyColor),
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

  Container create_text(String value){
    return Container(
      // color: Colors.greenAccent,
      // width: 200,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30,30,30,0),
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

  Material create_Button(){
    return Material(
      elevation: 0.0,
      borderRadius: BorderRadius.circular(5.0),
      color: primaryColor,
      child:MaterialButton(
          minWidth: 150,
          height: 50,
          padding: EdgeInsets.only(left:20,right: 20),
          onPressed: ()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>

            Responsive(
              mobile: insurance_editInsurancePolicy(insurance_List: addInsurance_List,),
              tablet: Center(
                  child: Container(
                     width: flutterWeb_tabletWidth,
                     child: insurance_editInsurancePolicy(insurance_List: addInsurance_List,),
                  ),
              ),
              desktop: Center(
                child: Container(
                  width: flutterWeb_desktopWidth,
                  child: insurance_editInsurancePolicy(insurance_List: addInsurance_List,),
                ),
              ),
            )
                // insurance_editInsurancePolicy(insurance_List: addInsurance_List,)

            ),);
          },
          child: Text('Send Request',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 13))

      ),
    );
  }

  alert_dialogSpouse(BuildContext context) {
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
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: const EdgeInsets.only(left:7),
                        child:Text("Spouse Details",style: TextStyle(color: Colors.white,fontSize: 17),),
                      ),


                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed:(){Navigator.of(context).pop();},

                        child: Icon(Icons.close,color: Colors.white,size: 30,),
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
                    child:Column(
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
                                hintText: "Enter Spouse Name",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ), onChanged: (value)
                          {
                            input_DependentName=value;
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
                                hintText: "Enter Spouse Age",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ), onChanged: (value)
                          {
                            input_DependentAge=value;

                          },
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Enter Age"),
                              ])
                          ) ,
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
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height:30, //height of button
                          width:100,
                          child:MaterialButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed:()
                              {
                                if (formkeySpouse.currentState!.validate())
                                {

                                  Navigator.of(context).pop();
                                  setState(()
                                  {
                                    if (4>totalMemberCount)
                                    {
                                      _visibleSpouse = !_visibleSpouse;
                                      totalCountMember_Addition();

                                      // dialog_addInsurance("Spouse "+"Details",getSpouseGender(),Methods.getRelationType("Spouse"),"Spouse","Spouse");
                                      addInsuranceDetails(getSpouseGender(),Method.getRelationType("Spouse"),"Spouse","Spouse",
                                          input_DependentName,input_DependentAge);


                                    }

                                  });

                                  // //print("Validated");
                                } else {
                                  // //print("Not Validated");
                                }

                              },

                              child: Text('OK',
                                  style: TextStyle(fontFamily:'Vonique',fontSize: 17,color: Colors.black ))),
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

  alert_dialogDaughter(BuildContext context)
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
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: const EdgeInsets.only(left:7),
                        child:Text("Daughter Details",style: TextStyle(color: Colors.white,fontSize: 17),),
                      ),


                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed:(){Navigator.of(context).pop();},

                        child: Icon(Icons.close,color: Colors.white,size: 30,),
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
                    child:Column(
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
                                hintText: "Enter Female Name",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            input_DependentName=value;
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
                                hintText: "Enter Female Age",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            input_DependentAge=value;
                          },
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Enter Age"),

                              ])
                          ) ,
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
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height:30, //height of button
                          width:100,
                          child:MaterialButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed:(){
                                if (formkeyDaughter.currentState!.validate()) {

                                  Navigator.of(context).pop();


                                  if (4>totalMemberCount)
                                  {
                                    setState(()
                                    {
                                      _visibleDaughter = ! _visibleDaughter;

                                      _visibleDaughter1_add=true;
                                      _visibleDaughter1_cancel=false;

                                      totalCountMember_Addition();

                                    });

                                    addInsuranceDetails("Female",Method.getRelationType("Daughter"),"Daughter","Daughter",
                                        input_DependentName,input_DependentAge);

                                  }

                                  // //print("Validated");
                                } else {
                                  // //print("Not Validated");
                                }
                              },

                              child: Text('OK',
                                  style: TextStyle(fontFamily:'Vonique',fontSize: 17,color: Colors.black ))),
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

  alert_dialogDaughter1(BuildContext context) {
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
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: const EdgeInsets.only(left:7),
                        child:Text("Daughter Details",style: TextStyle(color: Colors.white,fontSize: 17),),
                      ),


                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed:(){Navigator.of(context).pop();},

                        child: Icon(Icons.close,color: Colors.white,size: 30,),
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
                    child:Column(
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
                                hintText: "Enter Female Name",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            input_DependentName=value;
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
                                hintText: "Enter Female Age",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            input_DependentAge=value;
                          },
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Enter Age"),

                              ])
                          ) ,
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
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height:30, //height of button
                          width:100,
                          child:MaterialButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed:(){
                                if (formkeyDaughter.currentState!.validate()) {

                                  Navigator.of(context).pop();


                                  if (4>totalMemberCount) {

                                    setState(() {

                                      _visibleDaughter1_add = false;
                                      _visibleDaughter1_cancel = true;

                                      totalCountMember_Addition();
                                    });

                                    addInsuranceDetails("Female",Method.getRelationType("Daughter"),"Daughter","Daughter1",
                                        input_DependentName,input_DependentAge);

                                  }



                                  // //print("Validated");
                                } else {
                                  // //print("Not Validated");
                                }
                              },

                              child: Text('OK',
                                  style: TextStyle(fontFamily:'Vonique',fontSize: 17,color: Colors.black ))),
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
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: const EdgeInsets.only(left:7),
                        child:Text("Son Details",style: TextStyle(color: Colors.white,fontSize: 17),),
                      ),


                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed:(){Navigator.of(context).pop();},

                        child: Icon(Icons.close,color: Colors.white,size: 30,),
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
                    key: formkeySon,
                    child:Column(
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
                                hintText: "Enter Male Name",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            input_DependentName=value;
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
                                hintText: "Enter Male Age",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            input_DependentAge=value;
                          },
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Enter Age"),

                              ])
                          ) ,
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
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height:30, //height of button
                          width:100,
                          child:MaterialButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed:(){
                                if (formkeySon.currentState!.validate()) {

                                  Navigator.of(context).pop();


                                  if (4>totalMemberCount)
                                  {
                                    setState(() {
                                      _visibleSon = !_visibleSon;

                                      _visibleSon1_add = true;
                                      _visibleSon1_cancel = false;
                                    });
                                    totalCountMember_Addition();

                                    addInsuranceDetails("Son",Method.getRelationType("Son"),"Son","Son",
                                        input_DependentName,input_DependentAge);
                                  }
                                  // //print("Validated");
                                } else {
                                  // //print("Not Validated");
                                }

                              },

                              child: Text('OK',
                                  style: TextStyle(fontFamily:'Vonique',fontSize: 17,color: Colors.black ))),
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

  alert_dialogSon1(BuildContext context) {
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
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: const EdgeInsets.only(left:7),
                        child:Text("Son Details",style: TextStyle(color: Colors.white,fontSize: 17),),
                      ),


                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed:(){Navigator.of(context).pop();},

                        child: Icon(Icons.close,color: Colors.white,size: 30,),
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
                    key: formkeySon,
                    child:Column(
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
                                hintText: "Enter Male Name",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            input_DependentName=value;
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
                                hintText: "Enter Male Age",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            input_DependentAge=value;
                          },
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Enter Age"),

                              ])
                          ) ,
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
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height:30, //height of button
                          width:100,
                          child:MaterialButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed:(){
                                if (formkeySon.currentState!.validate()) {

                                  Navigator.of(context).pop();
                                  setState(()
                                  {
                                    if (4>totalMemberCount)
                                    {
                                      _visibleSon1_add = false;
                                      _visibleSon1_cancel = true;

                                      totalCountMember_Addition();

                                      addInsuranceDetails("Son",Method.getRelationType("Son"),"Son","Son1",
                                          input_DependentName,input_DependentAge);
                                    }

                                  });
                                  // //print("Validated");
                                } else {
                                  // //print("Not Validated");
                                }

                              },

                              child: Text('OK',
                                  style: TextStyle(fontFamily:'Vonique',fontSize: 17,color: Colors.black ))),
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


  totalCountMember_Addition()
  {
    ++totalMemberCount;

    if (4>totalMemberCount) {

      // Toast.makeText(this,"Total count sum::"+totalMemberCount,Toast.LENGTH_SHORT).show();

      // //print('show total member addition length $totalMemberCount');

    }else
    {

    }


  }
  totalCountMember_Subtraction()
  {
    --totalMemberCount;

    if (totalMemberCount>=1) {

      // //print('show total member subraction length $totalMemberCount');


      // Toast.makeText(this,"Total count subraction::"+totalMemberCount,Toast.LENGTH_SHORT).show();
    }

  }

  void showToastMessage(String message)
  {
    Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_LONG, //duration for message to show
        gravity: ToastGravity.BOTTOM, //where you want to show, top, bottom
        timeInSecForIosWeb: 1, //for iOS only
        //backgroundColor: Colors.red, //background Color for message
        textColor: Colors.white, //message text color
        fontSize: 16.0 //message font size
    );
  }


  getEmpInfo()
  {

    SharedPreference.getEmpGender().then((value) =>  {
      empGender=value.toString().trim(),
      // //print('show emp getIncomeTax_HeadsFinancialYear $value'),
    });

    SharedPreference.getEmpName().then((value) =>  {
      empName=value,
      // //print('show emp getIncomeTax_HeadsFinancialYear $value'),
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {
      dateOfBirth=value,
      AddSelf_Dependent(),
      // //print('show emp getIncomeTax_HeadsFinancialYear $value'),
    });

  }
  String getSpouseGender()
  {
    String spouseGender="";
    if (empGender=="Male")
    {
      spouseGender ="Female";
    }
    else
    {
      spouseGender ="Male";
    }
    return  spouseGender;
  }

  AddSelf_Dependent()
  {
    String getAge=Method.getAge_ByDateOfBirth(dateOfBirth);

    Map<String, String> map = {'gender': empGender, 'dependentname': empName, 'age': getAge,'relationship':'MMBR',
      'dob':dateOfBirth,'aliasName':'My Self','tmpObject':'My Self'};
    addInsurance_List.add(map);
    // //print('show dependent items $addInsurance_List');

  }

  addInsuranceDetails(String genderType,String relationType,String aliasName,String tmpObject,String txt_dependentName,String txt_dependentAge)
  {

    Map<String, String> map = {'gender': genderType, 'dependentname': txt_dependentName,
      'age': txt_dependentAge,'relationship':relationType, 'dob':"-",
      'aliasName':aliasName,'tmpObject':tmpObject};
    addInsurance_List.add(map);

    // //print('show addition items $addInsurance_List');

  }
  removeTheAddMemeberFromListArr(String tmpObjectKey)
  {
    for (int i=0;i<addInsurance_List.length;i++)
    {
      var obj=addInsurance_List[i] as Map;

      if(obj['tmpObject'] == tmpObjectKey)
      {
        addInsurance_List.removeAt(i);
        // //print('after remove item show list item $addInsurance_List');

      }
    }
  }

}