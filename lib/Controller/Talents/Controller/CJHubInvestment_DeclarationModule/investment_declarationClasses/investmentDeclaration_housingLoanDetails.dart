

import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';
/*import 'package:web/Encrypt/encrypt.dart';
import 'package:web/Message/Message.dart';
import 'package:web/NetworkStatus/NetworkReachability.dart';
import 'package:web/constants/constants.dart';
import 'package:web/customView/AlwaysDisabledFocusNode.dart';
import 'package:web/customView/Method.dart';
import 'package:web/customView/SharedPreference.dart';
import 'package:web/customView/ValidateClass.dart';
import 'package:web/investment_declaration/ModelClasses/Investment_Declaration_HomeLoanDetails_ModelResponse.dart';
import 'package:web/webApi/WebApi.dart';*/
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/CJHubCustomView/AlwaysDisabledFocusNode.dart';
import '../../../../../CustomView/CJHubCustomView/AutoLogout.dart';
import '../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../CustomView/CJHubCustomView/NetworkStatus/NetworkReachability.dart';
import '../../../../../CustomView/CJHubCustomView/SalaryYearMonth_List.dart';
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../CustomView/CJHubCustomView/ValidateClass.dart';
import '../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../ModelClasses/Investment_Declaration_HomeLoanDetails_ModelResponse.dart';

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
      home: investmentDeclaration_housingLoanDetails(title: 'CJ Hub'),
    );
  }
}
class investmentDeclaration_housingLoanDetails extends StatefulWidget {

  investmentDeclaration_housingLoanDetails({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _investmentDeclaration_housingLoanDetails createState() => _investmentDeclaration_housingLoanDetails();
}

class _investmentDeclaration_housingLoanDetails extends State<investmentDeclaration_housingLoanDetails> {
  // This widget is the root of your application.
  bool _visible = true;
  bool contructionBefore_yearVal = false;
  bool firstTime_BuyerVal = false;

  String interestOnLoan ="0";
  String lossFromHouseProperty ="0";
  String total ="0";

  String loan_SanctionDate ="dd/mm/yyyy";
  String loan_Amount ="0";
  String propertyValue ="0";

  String panNumber_First ="0";
  String panNumber_Second ="0";
  String panNumber_Third ="0";
  String panNumber_Fourth ="0";

  TextEditingController interestOnLoan_Controllers = TextEditingController();
  TextEditingController lossFromHouseProperty_Controllers = TextEditingController();

  TextEditingController loanSanctionDate_Controllers = TextEditingController();
  TextEditingController loanAmount_Controllers = TextEditingController();
  TextEditingController propertyValue_Controllers = TextEditingController();

  TextEditingController homeLoanPAN1_Controllers = TextEditingController();
  TextEditingController homeLoanPAN2_Controllers = TextEditingController();
  TextEditingController homeLoanPAN3_Controllers = TextEditingController();
  TextEditingController homeLoanPAN4_Controllers = TextEditingController();



  bool _isEnabled = false;
  bool fristTimeBuyer_isEnabled = false;


  String completeEmpCode="",financialYear="";
  String empIp="",empUserId="",empName="";


  DateTime selectedDate = DateTime.now();

  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(!networkStatus){
      print("Api salary status should be called");
      houseLoanDetailsApiRequest();
      EasyLoading.dismiss();
    }
    else{
      print("Api salary status should not be called");
      EasyLoading.show(status: Message.get_LoaderMessage);
      Method.snackBar_OkText(context, 'No Internet Connection');

    }
    print(" Inside Test Widget 2");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      NetworkReachability connectionStatus = NetworkReachability.getInstance();

      _connectionChangeStream =
          connectionStatus.connectionChange.listen(checkNetworkConnection);
    });
    // checkNetworkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(child:
      Column(
        children: <Widget>[

          create_Gap(),

          Container(
            // color: Colors.red,
            child: create_heading('Loan Details'),
          ),

          create_Gap(),

          Container(
            // color: Colors.blue,
            child: loanDetails_Container(),
          ),

          create_Gap(),
          create_Gap(),
          create_Gap(),

          Container(
            // color: Colors.red,
            child: create_heading('Loss On Property'),
          ),

          create_Gap(),
          create_Gap(),

          Container(
            // color: Colors.blue,
            child: otherIncome_Container(),
          ),

          create_Gap(),
          create_Gap(),
          create_Gap(),

          Container(
            // color: Colors.red,
            child: create_heading("Lender's Details"),
          ),

          create_Gap(),
          create_Gap(),

          Container(
            // color: Colors.blue,
            child: lendersDetails_Container(),
          ),

          /*   Expanded(
            flex: 1,
            child: create_Gap(),),

          Expanded(
            flex: 1,
            child: create_Gap(),)*/

          create_Gap(),
          create_Gap()

        ],
      ),
      ),);
  }

  Container otherIncome_Container() {
    return Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                  border: Border.all(color: fourHunGreyColor,
                      width: 1.0,
                      style: BorderStyle.solid)
              ),
              padding: const EdgeInsets.only(left: 10, right: 10, top: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 35,
                                child:Checkbox(
                                  activeColor: Colors.amber,
                                  value: firstTime_BuyerVal,
                                  onChanged: (bool? value) {
                                    setState(()
                                    {
                                      firstTime_BuyerVal=value!;
                                      //print('show firstTime_BuyerVal $firstTime_BuyerVal');

                                      /*--------22-10-2021 start------------*/
                                      if(value!)
                                      {
                                        fristTimeBuyer_isEnabled = true;

                                      }else
                                      {
                                        fristTimeBuyer_isEnabled =
                                        false;
                                      }
                                      /*--------22-10-2021 end------------*/

                                    });
                                  },
                                ) ,
                              ),

                              SizedBox(
                                width: 10,
                              ),

                              Expanded(
                                flex: 1,
                                  child: Container(
                                // color: Colors.yellow,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.6,
                                  height: 35,
                                  child:Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "First Time Buyer",
                                      style: new TextStyle(fontSize: 12.0),
                                    ),
                                  )

                              ))

                            ],
                          ),
                          create_Gap(),
                          create_loanSanctionDate('Loan Sanction Date:'),
                          create_Gap(),
                          create_LoanAmount('Loan Amount:'),
                          create_Gap(),
                          create_PropertyValue('Property Value'),
                          create_Gap(),
                          create_Gap(),
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
  Container lendersDetails_Container() {
    return Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                  border: Border.all(color: fourHunGreyColor,
                      width: 1.0,
                      style: BorderStyle.solid)
              ),
              padding: const EdgeInsets.only(left: 10, right: 10, top: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          create_Gap(),
                          create_HomeLoan1('Home Loan Lender PAN 1'),
                          create_Gap(),
                          create_HomeLoan2('Home Loan Lender PAN 2'),
                          create_Gap(),
                          create_HomeLoan3('Home Loan Lender PAN 3'),
                          create_Gap(),
                          create_HomeLoan4('Home Loan Lender PAN 4'),
                          create_Gap(),
                          create_Gap(),
                          create_Button(),
                          create_Gap(),
                          create_Gap(),
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
  Container create_heading(String text) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              text, style: TextStyle(color: Colors.black, fontSize: 15),),

          )
        ],
      ),
    );
  }


  Container loanDetails_Container() {
    return Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                  border: Border.all(color: fourHunGreyColor,
                      width: 1.0,
                      style: BorderStyle.solid)
              ),
              padding: const EdgeInsets.only(left: 10, right: 10, top: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          create_Gap(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 35,
                                child:Checkbox(
                                  activeColor: Colors.amber,
                                  value: contructionBefore_yearVal,
                                  onChanged: (bool? value)
                                  {
                                    setState(()
                                    {
                                      contructionBefore_yearVal = value!;
                                    });
                                    loadThe_ConstructionOfTheHouse();

                                  },
                                ) ,
                              ),

                              SizedBox(
                                width: 10,
                              ),

                              Expanded(
                                flex: 1,
                                  child: Container(
                                // color: Colors.yellow,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.6,
                                  height: 35,
                                  child:Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Acquisition or Construction of the house Before 01/04/1999",
                                      style: new TextStyle(fontSize: 12.0),
                                    ),
                                  )
                              ))


                            ],
                          ),
                          create_Gap(),
                          create_InserestOnLoan('Loss: Interest on Loan (Max. 2 Lac)'),
                          create_Gap(),
                          create_LossFromHouseProperty('Tot: Loss from house Property'),
                          create_Gap(),
                          create_Total('Total'),
                          create_Gap(),
                          create_Gap(),
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
  Row create_InserestOnLoan(String key){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            // color: Colors.greenAccent,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.5,
            height: 35,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(key,
                style: TextStyle(fontSize: 12,color: Colors.black),),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
            child: Container(
          // color: Colors.grey[300],
          width: MediaQuery
              .of(context)
              .size
              .width * 0.4,
          height: 35,
          child: TextField(
            controller: interestOnLoan_Controllers,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              contentPadding: EdgeInsets.only(
                  top: 5, left: 3),
              hintText: interestOnLoan,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value)
            {

              interestOnLoan = value;

              //21-10-2021 start

              loadThe_ConstructionOfTheHouse();
              //21-10-2021 end


            },
          ),

        ))


      ],
    );
  }

  //21-10-2021 start
  loadThe_ConstructionOfTheHouse()
  {
    int interestOnLoan_int=int.parse(interestOnLoan);

    if(contructionBefore_yearVal==true)
    {
      //print('show the contructionBefore_yearVal true: $contructionBefore_yearVal');
      if (interestOnLoan_int > 30000) {
        interestOnLoan_int = 30000;
        total = interestOnLoan_int.toString();

      }
      else {
        total = interestOnLoan_int.toString();

      }
      setState(()
      {
        total = total;
        lossFromHouseProperty=total;
      });
    }
    else {

      //print('show the contructionBefore_yearVal false: $contructionBefore_yearVal');


      if (interestOnLoan_int > 200000) {
        interestOnLoan_int = 200000;
      }
      else {

      }
      total = interestOnLoan_int.toString();
      setState(()
      {
        total = total;
        lossFromHouseProperty=total;
      });
    }
  }
  //21-10-2021 end


  Row create_LossFromHouseProperty(String key){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            // color: Colors.greenAccent,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.5,
            height: 35,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(key,
                style: TextStyle(fontSize: 12,color: Colors.black),),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child:  Container(
            // color: Colors.grey[300],
            width: MediaQuery
                .of(context)
                .size
                .width * 0.4,
            height: 35,
            child: TextField(
              controller: lossFromHouseProperty_Controllers,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                contentPadding: EdgeInsets.only(
                    top: 5, left: 3),
                hintText: lossFromHouseProperty,
                border:
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0)),
              ),
              onChanged: (value) {
                lossFromHouseProperty=value;
              },
            ),

          ),
        )


      ],
    );
  }
  Row create_Total(String key){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            // color: Colors.greenAccent,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.5,
            height: 35,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(key,
                style: TextStyle(fontSize: 12,color: Colors.black),),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
            child:  Container(
          // color: Colors.grey[300],
          width: MediaQuery
              .of(context)
              .size
              .width * 0.4,
          height: 35,
          child: TextField(
            enabled: _isEnabled,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              fillColor: Colors.grey[200],
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              contentPadding: EdgeInsets.only(
                  top: 5, left: 3),
              hintText: total,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value) {

            },
          ),

        ))


      ],
    );
  }

  Row create_loanSanctionDate(String key){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            // color: Colors.greenAccent,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.5,
            height: 35,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(key,
                style: TextStyle(fontSize: 12,color: Colors.black),),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),

        Expanded(
          flex: 1,
            child: Container(
          // color: Colors.yellow,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.4,
          height: 35,
          child: TextField(focusNode: AlwaysDisabledFocusNode(),
            controller: loanSanctionDate_Controllers,
            enabled: fristTimeBuyer_isEnabled,
            //keyboardType: TextInputType.datetime,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'[: a space]')),
            ],
            decoration: InputDecoration(
              fillColor: Colors.grey[100],
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              contentPadding: EdgeInsets.only(
                  top: 5, left: 3),
              hintText: loan_SanctionDate,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            /* onChanged: (value)
            {
              loan_SanctionDate=value;
            },*/
            onTap:()
            {
              _selectDate(context);

            },
          ),

        ))


      ],
    );
  }
  Row create_LoanAmount(String key){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            // color: Colors.greenAccent,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.5,
            height: 35,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(key,
                style: TextStyle(fontSize: 12,color: Colors.black),),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),

        Expanded(
          flex: 1,
            child: Container(
          // color: Colors.yellow,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.4,
          height: 35,
          child: TextField(
            controller: loanAmount_Controllers,
            enabled: fristTimeBuyer_isEnabled,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              fillColor: Colors.grey[100],
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              contentPadding: EdgeInsets.only(
                  top: 5, left: 3),
              hintText: loan_Amount,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value) {
              loan_Amount=value;
            },
          ),

        ))


      ],
    );
  }
  Row create_PropertyValue(String key){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            // color: Colors.greenAccent,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.5,
            height: 35,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(key,
                style: TextStyle(fontSize: 12,color: Colors.black),),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),

        Expanded(
          flex: 1,
            child: Container(
          // color: Colors.yellow,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.4,
          height: 35,
          child: TextField(
            controller: propertyValue_Controllers,
            enabled: fristTimeBuyer_isEnabled,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              fillColor: Colors.grey[100],
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              contentPadding: EdgeInsets.only(
                  top: 5, left: 3),
              hintText: propertyValue,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value) {
              propertyValue=value;
            },
          ),

        ))


      ],
    );
  }
  Row create_HomeLoan1(String key){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            // color: Colors.greenAccent,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.5,
            height: 35,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(key,
                style: TextStyle(fontSize: 12,color: Colors.black),),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),

        Expanded(
          flex: 1,
            child: Container(
          // color: Colors.yellow,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.4,
          height: 35,
          child: TextField(
            controller: homeLoanPAN1_Controllers,
            textCapitalization: TextCapitalization.characters,
            keyboardType: TextInputType.text,
            inputFormatters: validate_panCard(),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              contentPadding: EdgeInsets.only(
                  top: 5, left: 3),
              hintText: panNumber_First,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value) {
              panNumber_First=value;
            },
          ),

        ))


      ],
    );
  }
  Row create_HomeLoan2(String key){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            // color: Colors.greenAccent,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.5,
            height: 35,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(key,
                style: TextStyle(fontSize: 12,color: Colors.black),),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),

        Expanded(
          flex: 1,
            child: Container(
          // color: Colors.yellow,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.4,
          height: 35,
          child: TextField(
            controller: homeLoanPAN2_Controllers,
            textCapitalization: TextCapitalization.characters,
            keyboardType: TextInputType.text,
            inputFormatters: validate_panCard(),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              contentPadding: EdgeInsets.only(
                  top: 5, left: 3),
              hintText: panNumber_Second,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value) {
              panNumber_Second=value;
            },
          ),

        ))


      ],
    );
  }
  Row create_HomeLoan3(String key){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            // color: Colors.greenAccent,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.5,
            height: 35,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(key,
                style: TextStyle(fontSize: 12,color: Colors.black),),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),

        Expanded(
          flex: 1,
            child: Container(
          // color: Colors.yellow,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.4,
          height: 35,
          child: TextField(
            controller: homeLoanPAN3_Controllers,
            textCapitalization: TextCapitalization.characters,
            keyboardType: TextInputType.text,
            inputFormatters: validate_panCard(),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              contentPadding: EdgeInsets.only(
                  top: 5, left: 3),
              hintText: panNumber_Third,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value) {
              panNumber_Third=value;
            },
          ),

        ))


      ],
    );
  }
  Row create_HomeLoan4(String key){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            // color: Colors.greenAccent,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.5,
            height: 35,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(key,
                style: TextStyle(fontSize: 12,color: Colors.black),),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),

        Expanded(
          flex: 1,
            child: Container(
          // color: Colors.yellow,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.4,
          height: 35,
          child: TextField(
            controller: homeLoanPAN4_Controllers,
            textCapitalization: TextCapitalization.characters,
            keyboardType: TextInputType.text,
            inputFormatters: validate_panCard(),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              contentPadding: EdgeInsets.only(
                  top: 5, left: 3),
              hintText: panNumber_Fourth,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value) {
              panNumber_Fourth=value;
            },
          ),

        ))


      ],
    );
  }
  Material create_Button(){
    return Material(
      elevation: 0.0,
      borderRadius: BorderRadius.circular(5.0),
      color: primaryColor,
      child:MaterialButton(
          minWidth: 250,
          padding: EdgeInsets.only(left:20,right: 20),
          onPressed: () {

            save_LoanDetailsWebApi();
          },
          child: Text('Update',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 16))

      ),
    );
  }

  SizedBox create_Gap(){
    return SizedBox(
      height: 5,
    );
  }

/*-----------Date Picker start 22-10-2021 START------------*/
  _selectDate(BuildContext context) async
  {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != selectedDate)
      setState(()
      {
        selectedDate = selected;
        String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
        loan_SanctionDate=formattedDate;

      });
  }
/*-----------Date Picker start 22-10-2021 END------------*/

 void checkNetworkConnection(dynamic hasConnection)
  {
    if(mounted){
      setState(() {
        networkStatus = !hasConnection;
      });
    }
    if(!networkStatus){
      print("Api should be called");
      houseLoanDetailsApiRequest();
      EasyLoading.dismiss();
    }
    else{
      print("Api should not be called");
      EasyLoading.show(status: Message.get_LoaderMessage);
      Method.snackBar_OkText(context, 'No Internet Connection');
    }
    print(" Inside Test Widget 2");
   /* NetworkReachability.networkConnectionStatus().then((networkStatus) =>
    {
      if(networkStatus)
        {
          houseLoanDetailsApiRequest()
        }
      else
        {
          //print('please check the network status'),
          showNetworConnectionAlert()
        }
    });*/
    // houseLoanDetailsApiRequest();
  }

  houseLoanDetailsApiRequest()
  {

    SharedPreference.getIncomeTax_HeadsFinancialYear().then((value) =>  {
      financialYear=value,
      //print('show emp getIncomeTax_HeadsFinancialYear $value'),
      //loadData()
    });


    String mobileNumber_key="",empCode_key="",
        empDateOfBirth_key="";

    SharedPreference.getEmpMobileNo().then((value) =>  {
      mobileNumber_key=value,
      //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpCode().then((value) =>  {
      empCode_key=value,
      //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth_key=value,
      //print('show emp name2 $value'),
      completeEmpCode = mobileNumber_key+"CJHUB"+empCode_key+"CJHUB"+empDateOfBirth_key,

      this.get_HouseLoanDetails()

    });

  }

  get_HouseLoanDetails() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.tax_get_house_Loan),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'financial_year': financialYear,
          'emp_code': getEncrypted_EmpCode(completeEmpCode)

        },
      );
      //print(response.statusCode);
      if (response.statusCode == 200)
      {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);

        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        Investment_Declaration_HomeLoanDetails_ModelResponse details_modelResponse = Investment_Declaration_HomeLoanDetails_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(details_modelResponse.statusCode==true)
        {

          setState(() {

            loadData(details_modelResponse.data!);
          });
        }
        else
        {
          if (details_modelResponse.message==null || details_modelResponse.message=="")
          {
            // show_OKAlert("server error!");

            Method.snackBar_OkText(context, "server error!");

          }else {

            Method.snackBar_OkText(context, details_modelResponse.message);

            // show_OKAlert(details_modelResponse.message);
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

  loadData(List<Data> dataArr)
  {
    if(dataArr.length>0)
    {
      Data obj=dataArr[0];
      interestOnLoan=obj.interestOnBorrowedCapital;
      lossFromHouseProperty=obj.interestOnBorrowedCapital;
      total=obj.interestOnBorrowedCapital;

      loan_SanctionDate=obj.loanSanctionDate;
      if(loan_SanctionDate=="0"||loan_SanctionDate=="")
      {
        loan_SanctionDate="dd/mm/yyyy";
      }
      loan_Amount=obj.loanAmount;
      propertyValue=obj.propertyValue;

      panNumber_First=obj.lenderPanNumber1;
      panNumber_Second=obj.lenderPanNumber2;
      panNumber_Third=obj.lenderPanNumber3;
      panNumber_Fourth=obj.lenderPanNumber4;




      if(obj.isFirstTimeBuyer=="Y")
      {
        firstTime_BuyerVal=true;
        _isEnabled=true;

        fristTimeBuyer_isEnabled = true;
      }
      else
      {
        _isEnabled=false;
        firstTime_BuyerVal=false;

        fristTimeBuyer_isEnabled = false;
      }

      if(obj.isBefore01Apr1999=="Y")
      {
        contructionBefore_yearVal=true;
      }
      else
      {
        contructionBefore_yearVal=false;
      }


    }
  }

  save_LoanDetailsWebApi()
  {
    SharedPreference.getEmpId().then((value) =>  {
      //print('show emp name2 $value'),
      empUserId=value,

    });
    SharedPreference.getEmpName().then((value) =>  {
      //print('show emp name2 $value'),
      empName=value,

    });


    Method.getIPAddress().then((value) =>  {
      //print('show emp name2 $value'),
      empIp=value,

      checkPanNumber_Validation()

    });

  }

  checkPanNumber_Validation()
  {
    if((panNumber_First=="0"|| panNumber_First=="")&&(panNumber_Second=="0"|| panNumber_Second=="")&&
        (panNumber_Third=="0"|| panNumber_Third=="")&&(panNumber_Fourth=="0"|| panNumber_Fourth==""))
    {
      // show_OKAlert_PanNumber("Please enter the Pan Number");

      Method.snackBar_OkText(context, "Please enter the Pan Number");
    }
    else
    {
      if (firstTime_BuyerVal)
      {
        if((loan_SanctionDate==""|| loan_SanctionDate=="")&&(loan_Amount=="0"|| loan_Amount=="")&&
            (propertyValue=="0"|| propertyValue==""))
        {

          Method.snackBar_OkText(context, "Please enter the First Time Buyer details");

          // show_OKAlert_PanNumber("Please enter the First Time Buyer details");

        }
        else
        {
          save_HouseLoanDetails();
        }
      }
      else
      {
        save_HouseLoanDetails();

      }

    }
  }


  save_HouseLoanDetails() async
  {

    String cc=getEncrypted_EmpCode(completeEmpCode);
    //print('show the empcode $cc');

    if(loan_SanctionDate=="dd/mm/yyyy")
    {
      loan_SanctionDate="";
    }
    //print('show the loan_SanctionDate $loan_SanctionDate');


    String contructionBefore_yearVal_Str,firstTime_BuyerVal_Str;
    if (contructionBefore_yearVal)
    {
      contructionBefore_yearVal_Str="Y";
    }else
    {
      contructionBefore_yearVal_Str="N";
    }
    if (firstTime_BuyerVal)
    {
      firstTime_BuyerVal_Str="Y";
    }else
    {
      firstTime_BuyerVal_Str="N";
    }

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.tax_save_house_Loan),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {

          'lender_pan_number_1': panNumber_First,
          'lender_pan_number_2': panNumber_Second,
          'lender_pan_number_3': panNumber_Third,
          'lender_pan_number_4': panNumber_Fourth,
          'loan_sanction_date': loan_SanctionDate,
          'loan_amount': loan_Amount,
          'property_value': propertyValue,
          'lender_name': empName,
          'is_first_time_buyer': firstTime_BuyerVal_Str,
          'principal_on_borrowed_capital': lossFromHouseProperty,
          'interest_on_borrowed_capital': interestOnLoan,
          'is_before_01_apr_1999': contructionBefore_yearVal_Str,

          'financial_year': financialYear,
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'emp_ip': empIp,
          'emp_user_id': empUserId

        },
      );
      //print(response.statusCode);
      if (response.statusCode == 200)
      {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        Investment_Declaration_HomeLoanDetails_ModelResponse details_modelResponse = Investment_Declaration_HomeLoanDetails_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(details_modelResponse.statusCode==true)
        {

          Method.snackBar_OkText(context, details_modelResponse.message);
          // show_OKAlert(details_modelResponse.message);

        }
        else
        {
          if (details_modelResponse.message==null || details_modelResponse.message=="")
          {
            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, details_modelResponse.message);

            // show_OKAlert(details_modelResponse.message);
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

/*----------commented shoe_OKAlert Dialog---------21-07-2022-start--*/

// show_OKAlert(String message)
  // {
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
  //  /* var alertDialog = AlertDialog(
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

  // show_OKAlert_PanNumber(String message)
  // {
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
  //  /* var alertDialog = AlertDialog(
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

/*----------commented shoe_OKAlert Dialog---------21-07-2022-start--*/

}