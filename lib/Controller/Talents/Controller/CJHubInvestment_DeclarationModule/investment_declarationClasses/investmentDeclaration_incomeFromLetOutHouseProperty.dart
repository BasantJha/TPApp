
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;
/*import 'package:web/Encrypt/encrypt.dart';
import 'package:web/Message/Message.dart';
import 'package:web/NetworkStatus/NetworkReachability.dart';
import 'package:web/constants/constants.dart';
import 'package:web/customView/Method.dart';
import 'package:web/customView/SharedPreference.dart';
import 'package:web/investment_declaration/ModelClasses/Investment_Declaration_IncomeLetOut_HouseProperty.dart';
import 'package:web/webApi/WebApi.dart';*/

import '../../../../../Constant/Responsive.dart';
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
import '../ModelClasses/Investment_Declaration_IncomeLetOut_HouseProperty.dart';

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
      home: investmentDeclaration_incomeFromLetOutHouseProperty(title: 'CJ Hub'),
    );
  }
}
class investmentDeclaration_incomeFromLetOutHouseProperty extends StatefulWidget {

  investmentDeclaration_incomeFromLetOutHouseProperty({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _Investment_Declaration_IncomeFromLetOutHouseProperty createState() => _Investment_Declaration_IncomeFromLetOutHouseProperty();
}

class _Investment_Declaration_IncomeFromLetOutHouseProperty extends State<investmentDeclaration_incomeFromLetOutHouseProperty> {
  // This widget is the root of your application.
  bool _visible = true;
  bool loan_CheckBoxValue = false;
  bool withoutLoan_CheckBoxValue = true;

  String grossAnnual_WithoutLoan ="0";
  String municipalTax_WithoutLoan ="0";
  String netAnnual_WithoutLoan ="0";
  String standardDeduction_WithoutLoan ="0";
  String total_WithoutLoan ="0";

  String grossAnnual_Loan = "0";
  String municipalTax_Loan = "0";
  String netAnnual_Loan = "0";
  String standardDeduction_Loan = "0";
  String borrowedCapital_Loan = "0";
  String netIncomeHouseProperty_Loan = "0";


  TextEditingController grossAnnual_WithoutLoan_Controllers = TextEditingController();
  TextEditingController municipalTax_WithoutLoan_Controllers = TextEditingController();

  TextEditingController grossAnnual_Loan_Controllers = TextEditingController();
  TextEditingController municipalTax_Loan_Controllers = TextEditingController();
  TextEditingController interestBorrowedCapital_Loan_Controllers = TextEditingController();


  String displayName="";
  bool _isEnabled = false;

  String completeEmpCode="",financialYear="";
  String empIp="",empUserId="",empName="";
  String loanStatus="";

  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(!networkStatus){
      print("Api salary status should be called");
      letOutHousePropertyApiRequest();
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
            child: create_heading('E. Income from Let Out House Property'),
          ),

          create_Gap(),

          Container(
            // color: Colors.blue,
            child: checkBox_Container(),
          ),

          create_Gap(),
          create_Gap(),
          create_Gap(),

          Visibility(
            visible: _visible,
            child: Container(
              // color: Colors.red,
              child: create_heading('If Property is Owned and Without Loan'),
            ),
          ),

          Visibility(
            visible: _visible,
            child:create_Gap(),),



          Container(
            // color: Colors.blue,
            child: IncomeHouseProperty(),
          ),

          create_Gap(),
          create_Gap(),
          create_Gap(),

          create_Button(),

          create_Gap(),
          create_Gap(),

        ],
      ),),
    );
  }

  Container IncomeHouseProperty() {
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

                          Visibility(
                            visible: _visible,
                            child: create_GrossAnnualWithoutLoan('Gross Annual Value (Rental Income)') ,
                          ),

                          Visibility(
                            visible: !_visible,
                            child: create_GrossAnnual('Gross Annual Value (Rental Income)'),
                          ),
                          //on Loan check

                          create_Gap(),

                          Visibility(
                            visible: _visible,
                            child: create_MunicipalTaxWithoutLoan('Less: Municipal Taxes'),
                          ),

                          Visibility(
                            visible: !_visible,
                            child: create_MunicipalTax('Less: Municipal Taxes'),
                          ),

                          create_Gap(),

                          Visibility(
                            visible: _visible,
                            child: create_NetAnnualValueWithoutLoan('Net Annual Value'),
                          ),

                          Visibility(
                            visible: !_visible,
                            child: create_NetAnnualValue('Net Annual Value'),
                          ),

                          create_Gap(),

                          Visibility(
                            visible: _visible,
                            child: create_StandardDeductionWithoutLoan('Less: Standard Deduction @30%'),
                          ),

                          Visibility(
                            visible: !_visible,
                            child: create_StandardDeduction('Less: Standard Deduction @30%'),
                          ),

                          create_Gap(),

                          Visibility(
                            visible: !_visible,
                            child: create_InterestBorrowedCap('Less: Interest on Borrowed Capital'),
                          ),
                          //on Loan check
                          Visibility(
                            visible: !_visible,
                            child: create_Gap(),
                          ),

                          Visibility(
                            visible: _visible,
                            child: create_NetIncomeWithoutLoan('Net Income from House Property'),
                          ),

                          Visibility(
                            visible: !_visible,
                            child: create_NetIncome('Net Income from House Property'),
                          ),

                          create_Gap(),

                          Visibility(
                            visible: _visible,
                            child: create_TotalWithoutLoan('Total'),
                          ),

                          create_Gap(),
                          SizedBox(
                            height: 10,
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


  Container checkBox_Container() {
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex:1,
                          child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          // height: MediaQuery.of(context).size.height * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              create_Gap(),

                              Text(
                                "If Property is Owned and on Loan",textAlign: TextAlign.center,
                                style: new TextStyle(fontSize: 12.0),
                              ),

                              create_Gap(),

                              Checkbox(
                                activeColor: Colors.amber,
                                value: loan_CheckBoxValue,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _visible=!_visible;
                                    loan_CheckBoxValue = value!;
                                    withoutLoan_CheckBoxValue = false;
                                  });
                                },
                              ),
                              create_Gap(),
                            ],
                          ),
                        ),
                        ),

                        SizedBox(
                          width: 10,
                        ),

                        Expanded(
                          flex: 1,
                          child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          // color: Colors.greenAccent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              create_Gap(),

                              Text(
                                "If Property is Owned and Without Loan",textAlign: TextAlign.center,
                                style: new TextStyle(fontSize: 12.0),
                              ),

                              create_Gap(),

                              Checkbox(
                                activeColor: Colors.amber,
                                value: withoutLoan_CheckBoxValue,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _visible=!_visible;
                                    withoutLoan_CheckBoxValue = value!;
                                    loan_CheckBoxValue = false;
                                  });
                                },
                              ),

                              create_Gap(),
                            ],
                          ),
                        ),)



                      ],
                    ),
                  ),

                ],
              ),

            ),
          ],
        )
    );
  }

  /*---------without Loan House property start------*/
  Row create_GrossAnnualWithoutLoan(String key){
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
              controller: grossAnnual_WithoutLoan_Controllers,
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
                hintText: grossAnnual_WithoutLoan,
                border:
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0)),
              ),
              onChanged: (value)
              {
                setState(() {
                  grossAnnual_WithoutLoan=value;
                  netAnnual_WithoutLoan=calculate_netAnualValue_WithoutLoan();
                  standardDeduction_WithoutLoan=calculate_standardDeduction_WithoutLoan();
                  total_WithoutLoan=calculate_netIncomeFromHouseProperty_WithoutLoan();
                });

              },
            ),

          ),
        )


      ],
    );
  }
  Row create_MunicipalTaxWithoutLoan(String key){
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
              controller: municipalTax_WithoutLoan_Controllers,
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
                hintText: municipalTax_WithoutLoan,
                border:
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0)),
              ),
              onChanged: (value) {
                municipalTax_WithoutLoan = value;

                setState(() {
                  municipalTax_WithoutLoan=value;
                  netAnnual_WithoutLoan=calculate_netAnualValue_WithoutLoan();
                  standardDeduction_WithoutLoan=calculate_standardDeduction_WithoutLoan();
                  total_WithoutLoan=calculate_netIncomeFromHouseProperty_WithoutLoan();
                });

              },
            ),

          ),
        )


      ],
    );
  }
  Row create_NetAnnualValueWithoutLoan(String key){
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
            enabled: _isEnabled,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
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
              hintText: netAnnual_WithoutLoan,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value)
            {
              setState(() {
                netAnnual_WithoutLoan = value;

              });

            },
          ),

        ))


      ],
    );
  }
  Row create_StandardDeductionWithoutLoan(String key){
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
            enabled: _isEnabled,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
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
              hintText: standardDeduction_WithoutLoan,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value)

            {

              setState(() {
                standardDeduction_WithoutLoan=value;
              });

            },
          ),

        ))


      ],
    );
  }
  Row create_NetIncomeWithoutLoan(String key){
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
            enabled: _isEnabled,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
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
              hintText: total_WithoutLoan,
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
  Row create_TotalWithoutLoan(String key){
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
            enabled: _isEnabled,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
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
              hintText: total_WithoutLoan,
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
  /*---------without Loan House property end------*/

  /*---------with Loan House property start------*/
  Row create_GrossAnnual(String key){
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
            // color: Colors.yellow,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.4,
            height: 35,
            child: TextField(
              controller: grossAnnual_Loan_Controllers,
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
                hintText: grossAnnual_Loan,
                border:
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0)),
              ),
              onChanged: (value) {

                setState(() {
                  grossAnnual_Loan=value;
                  netAnnual_Loan=calculate_netAnualValue_WithLoan();
                  standardDeduction_Loan=calculate_standardDeduction_WithLoan();
                  netIncomeHouseProperty_Loan=calculate_netIncomeFromHouseProperty_WithLoan();
                });
              },
            ),

          ),
        )


      ],
    );
  }
  Row create_MunicipalTax(String key){
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
            controller: municipalTax_Loan_Controllers,
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
              hintText: municipalTax_Loan,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value) {

              setState(() {
                municipalTax_Loan=value;
                netAnnual_Loan=calculate_netAnualValue_WithLoan();
                standardDeduction_Loan=calculate_standardDeduction_WithLoan();
                netIncomeHouseProperty_Loan=calculate_netIncomeFromHouseProperty_WithLoan();
              });
            },
          ),

        ))


      ],
    );
  }
  Row create_NetAnnualValue(String key){
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
              enabled: _isEnabled,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
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
                hintText: netAnnual_Loan,
                border:
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0)),
              ),
              onChanged: (value) {

              },
            ),

          ),
        )


      ],
    );
  }
  Row create_StandardDeduction(String key){
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
            enabled: _isEnabled,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
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
              hintText: standardDeduction_Loan,
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
  Row create_InterestBorrowedCap(String key){
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
            controller: interestBorrowedCapital_Loan_Controllers,
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
              hintText: borrowedCapital_Loan,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value) {
              setState(() {
                borrowedCapital_Loan=value;
                netIncomeHouseProperty_Loan=calculate_netIncomeFromHouseProperty_WithLoan();
              });
            },
          ),

        ))


      ],
    );
  }
  Row create_NetIncome(String key){
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
          // color: Colors.yellow,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.4,
          height: 35,
          child: TextField(
            enabled: _isEnabled,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
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
              hintText: netIncomeHouseProperty_Loan,
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
  /*---------with Loan House property end------*/

  Material create_Button(){
    return Material(
      elevation: 0.0,
      borderRadius: BorderRadius.circular(5.0),
      color: primaryColor,
      child:MaterialButton(
          minWidth: 250,
          padding: EdgeInsets.only(left:20,right: 20),
          onPressed: ()
          {
            save_letOutHousePropertyWebApi();
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

  void checkNetworkConnection(dynamic hasConnection)
  {
    if(mounted){
      setState(() {
        networkStatus = !hasConnection;
      });
    }
    if(!networkStatus){
      print("Api should be called");
      letOutHousePropertyApiRequest();
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
          letOutHousePropertyApiRequest()
        }
      else
        {
          //print('please check the network status'),
          showNetworConnectionAlert()
        }
    });*/
    // letOutHousePropertyApiRequest();
  }

  letOutHousePropertyApiRequest()
  {

    SharedPreference.getIncomeTax_HeadsFinancialYear().then((value) =>  {
      financialYear=value,
      //print('show emp getIncomeTax_HeadsFinancialYear $value'),
    });


    String mobileNumber_key="",empCode_key="",
        empDateOfBirth_key="";

    SharedPreference.getEmpMobileNo().then((value) =>  {
      mobileNumber_key=value,
      //print('show emp name2 $value'),
    });

    SharedPreference.getEmpCode().then((value) =>  {
      empCode_key=value,
      //print('show emp name2 $value'),
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth_key=value,
      //print('show emp name2 $value'),
      completeEmpCode = mobileNumber_key+"CJHUB"+empCode_key+"CJHUB"+empDateOfBirth_key,

      this.get_letOutHouseProperty()

    });

  }

  get_letOutHouseProperty() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.tax_get_house_let_out_property_details),
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

        Investment_Declaration_IncomeLetOut_HouseProperty details_modelResponse = Investment_Declaration_IncomeLetOut_HouseProperty.fromJson(jsonDecode(serverResponse));

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
  save_letOutHousePropertyWebApi()
  {
    SharedPreference.getEmpId().then((value) =>  {
      //print('show emp name2 $value'),
      empUserId=value,

    });

    Method.getIPAddress().then((value) =>  {
      //print('show emp name2 $value'),
      empIp=value,

      save_letOutHouseProperty()

    });

  }
  save_letOutHouseProperty() async
  {
    String grossAnnual="",municipalTax="",netAnnual="",standardDeduction="",borrowedCapital="",netIncomeHouseProperty="";
    if(loanStatus=="Y")
    {
      grossAnnual=grossAnnual_Loan;
      municipalTax=municipalTax_Loan;
      netAnnual=netAnnual_Loan;
      standardDeduction=standardDeduction_Loan;
      borrowedCapital=borrowedCapital_Loan;
      netIncomeHouseProperty=netIncomeHouseProperty_Loan;

    }else
    {
      grossAnnual=grossAnnual_WithoutLoan;
      municipalTax=municipalTax_WithoutLoan;
      netAnnual=netAnnual_WithoutLoan;
      standardDeduction=standardDeduction_WithoutLoan;
      borrowedCapital="0";
      netIncomeHouseProperty=total_WithoutLoan;
    }

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.save_let_out_house_property_details),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'financial_year': financialYear,
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'emp_ip': empIp,
          'emp_user_id': empUserId,

          'gross_annual_rental_income': grossAnnual,
          'municipal_taxes': municipalTax,
          'net_annual_value': netAnnual,
          'standard_deduction': standardDeduction,
          'interest_on_borrowed_capital': borrowedCapital,
          'net_income_from_house': netIncomeHouseProperty,
          'is_having_loan': loanStatus,

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

        Investment_Declaration_IncomeLetOut_HouseProperty details_modelResponse = Investment_Declaration_IncomeLetOut_HouseProperty.fromJson(jsonDecode(serverResponse));

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

  loadData(List<Data> data)
  {
    if(data.length>0)
    {
      Data dataObj=data[0];

      loanStatus=dataObj.isHavingLoan;
      if(dataObj.isHavingLoan=="Y")
      {

        grossAnnual_Loan=dataObj.grossAnnualRentalIncome;
        municipalTax_Loan=dataObj.standardDeduction;
        netAnnual_Loan=dataObj.netAnnualValue;
        standardDeduction_Loan=dataObj.standardDeduction;
        borrowedCapital_Loan=dataObj.interestOnBorrowedCapital;
        netIncomeHouseProperty_Loan=dataObj.netIncomeFromHouse;

      }
      else
      {
        grossAnnual_WithoutLoan=dataObj.grossAnnualRentalIncome;
        municipalTax_WithoutLoan=dataObj.standardDeduction;
        netAnnual_WithoutLoan=dataObj.netAnnualValue;
        standardDeduction_WithoutLoan=dataObj.standardDeduction;
        //total_WithoutLoan use for the NetIncomeFromhouseproperty and total
        total_WithoutLoan=dataObj.netIncomeFromHouse;

      }
    }
  }

  String calculate_netAnualValue_WithLoan()
  {
    String grossAnualValue_Loan="";
    if (grossAnnual_Loan=="")
    {
      grossAnualValue_Loan="0";
    }else
    {
      grossAnualValue_Loan=grossAnnual_Loan;
    }

    String municipalTaxes_Loan="";
    if (municipalTax_Loan=="")
    {
      municipalTaxes_Loan="0";
    }else
    {

      municipalTaxes_Loan=municipalTax_Loan;
    }

    int totalNetAnnualValue=int.parse(grossAnualValue_Loan)-int.parse(municipalTaxes_Loan);

    return totalNetAnnualValue.toString();
  }

  String calculate_standardDeduction_WithLoan()
  {
    String netAnualValue=calculate_netAnualValue_WithLoan();

    double standardDeductionDouble=(double.parse(netAnualValue)*30/100);
    int standardDeductionInt=standardDeductionDouble.toInt();
    return standardDeductionInt.toString();
  }
  String calculate_netIncomeFromHouseProperty_WithLoan()
  {
    String borrowedCapital_Loan_Str="";
    if (borrowedCapital_Loan=="")
    {
      borrowedCapital_Loan_Str="0";
    }else
    {
      borrowedCapital_Loan_Str=borrowedCapital_Loan;
    }

    String netAnualValue_str=calculate_netAnualValue_WithLoan();
    double netAnnualValue_double=double.parse(netAnualValue_str);
    int netAnnualValue_int=netAnnualValue_double.toInt();

    double standardDeductionDouble=(netAnnualValue_int*30/100);
    int standardDeductionInt=standardDeductionDouble.toInt();
    int borrowedCapital_int=int.parse(borrowedCapital_Loan_Str);

    int netIncomeFromHouseProperty=netAnnualValue_int-standardDeductionInt-borrowedCapital_int;

    return netIncomeFromHouseProperty.toString();
  }
  /*----------calculate the house property rent with Loan start---------*/



  String calculate_netAnualValue_WithoutLoan()
  {
    String grossAnualValue_withoutLoan="";
    if (grossAnnual_WithoutLoan=="")
    {
      grossAnualValue_withoutLoan="0";
    }else
    {
      grossAnualValue_withoutLoan=grossAnnual_WithoutLoan;
    }

    String municipalTaxes_withoutLoan="";
    if (municipalTax_WithoutLoan=="")
    {
      municipalTaxes_withoutLoan="0";
    }else
    {

      municipalTaxes_withoutLoan=municipalTax_WithoutLoan;
    }

    int totalNetAnnualValue=int.parse(grossAnualValue_withoutLoan)-int.parse(municipalTaxes_withoutLoan);

    return totalNetAnnualValue.toString();
  }
  String calculate_standardDeduction_WithoutLoan()
  {
    String netAnualValue=calculate_netAnualValue_WithoutLoan();

    double standardDeductionDouble=(double.parse(netAnualValue)*30/100);
    int standardDeductionInt=standardDeductionDouble.toInt();
    return standardDeductionInt.toString();
  }

  String calculate_netIncomeFromHouseProperty_WithoutLoan()
  {

    String netAnualValue_str=calculate_netAnualValue_WithoutLoan();
    double netAnnualValue_int=double.parse(netAnualValue_str);

    double standardDeductionDouble=(netAnnualValue_int*30/100);
    int standardDeductionInt=standardDeductionDouble.toInt();

    double netIncomeFromHouseProperty=netAnnualValue_int-standardDeductionInt;


    return (netIncomeFromHouseProperty.toInt()).toString();
  }
  /*----------calculate the house property rent without Loan end---------*/

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
  //
  // }

/*----------commented shoe_OKAlert Dialog---------21-07-2022-end--*/

}