
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

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
import '../ModelClasses/InvestmentDeclaration_OtherIncomeDetails_ModelResponse.dart';

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
      home: investmentDeclaration_otherIncomeDetails(title: 'CJ Hub'),
    );
  }
}
class investmentDeclaration_otherIncomeDetails extends StatefulWidget {

  investmentDeclaration_otherIncomeDetails({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _investmentDeclaration_otherIncomeDetails createState() => _investmentDeclaration_otherIncomeDetails();
}

class _investmentDeclaration_otherIncomeDetails extends State<investmentDeclaration_otherIncomeDetails> {
  // This widget is the root of your application.

  String preEmp_totalIncome ="0";
  String preEmp_TDS ="0";
  String preEmp_professionalTax ="0";
  String preEmp_providentFund ="0";
  String preEmp_totalSum ="0";


  String OtherIncome_incomeFromOtherSources ="0";
  String OtherIncome_businessIncome ="0";
  String OtherIncome_incomeFromCapitalGains ="0";
  String OtherIncome_anyOtherIncome ="0";
  String OtherIncome_interestOnSavingBank ="0";
  String OtherIncome_tds ="0";
  String OtherIncome_totalIncome ="0";


  TextEditingController totalIncome_Controllers = TextEditingController();
  TextEditingController professionalTax_Controllers = TextEditingController();
  TextEditingController incomeFromOtherSource_Controllers = TextEditingController();
  TextEditingController businessIncome_Controllers = TextEditingController();
  TextEditingController incomeFromCapitalGains_Controllers = TextEditingController();
  TextEditingController anyOtherIncome_Controllers = TextEditingController();
  TextEditingController interestOnSavingBank_Controllers = TextEditingController();
  TextEditingController tds_Controllers = TextEditingController();


  String displayName="";
  bool _isEnabled = false;

  String completeEmpCode="",financialYear="";
  String empIp="",empUserId="";

  PreviousEmployerIncome? previousEmployerIncome_Obj;
  PreviousEmployerOtherIncome? previousEmployerOtherIncome_Obj;

  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(!networkStatus){
      print("Api salary status should be called");
      getOtherIncomeDetailsApiRequest();
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

        body:SingleChildScrollView(child:Column(
          children: <Widget>[

            create_Space(),

            Container(
              // color: Colors.red,
              child: create_heading('C. Income from Previous Employer'),
            ),

            create_Space(),

            Container(
              // color: Colors.blue,
              child: incomePreviousEmployee_Container(),
            ),

            create_Space(),
            create_Space(),

            Container(
              // color: Colors.red,
              child: create_heading('D. Other Income'),
            ),

            create_Space(),

            Container(
              // color: Colors.blue,
              child: otherIncome_Container(),
            ),

            create_Space(),

          ],
        ) ,)


    );
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

                          create_Space(),

                          incomeFromOtherSources_OtherIncome(),

                          create_Space(),

                          businessIncome_OtherIncome(),

                          create_Space(),

                          incomeFromCapitalGains_OtherIncome(),

                          create_Space(),

                          anyOtherIncome_OtherIncome(),

                          create_Space(),

                          interestOnSavineBank_OtherIncome(),

                          create_Space(),

                          tds_OtherIncome(),

                          create_Space(),

                          total_OtherIncome(),

                          create_Space(),
                          SizedBox(
                            height: 10,
                          ),
                          create_Button(),
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


  Container incomePreviousEmployee_Container() {
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
                          create_Space(),

                          totalIncome_previousEmp(),

                          create_Space(),

                          tds_PreviousEmp(),

                          create_Space(),

                          professionalTax_PreviousEmp(),

                          create_Space(),

                          providentFund_PreviousEmp(),

                          create_Space(),

                          total_PreviousEmp(),

                          create_Space(),
                          create_Space(),
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


  Row total_OtherIncome(){
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
              child: Text("Total",
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
          // color: Colors.grey[200],
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
              hintText: OtherIncome_totalIncome,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value){

              OtherIncome_totalIncome=value;
              previousEmployerOtherIncome_Obj!.total=value;

              setState(() {
                OtherIncome_totalIncome=calculateTheAll_OtherincomeData();
                previousEmployerOtherIncome_Obj!.total=OtherIncome_totalIncome;

              });

            },
          ),

        ))


      ],
    );
  }
  Row tds_OtherIncome(){
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
              child: Text("TDS (Others)",
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
            controller: tds_Controllers,
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
              hintText: OtherIncome_tds,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value)
            {
              OtherIncome_tds=value;
              previousEmployerOtherIncome_Obj!.tdsOthers=value;

              setState(() {
                OtherIncome_totalIncome=calculateTheAll_OtherincomeData();
                previousEmployerOtherIncome_Obj!.total=OtherIncome_totalIncome;

              });


            },
          ),

        ))


      ],
    );
  }

  Row interestOnSavineBank_OtherIncome(){
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
              child: Text("Interest on Saving Bank",
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
            controller: interestOnSavingBank_Controllers,
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
              hintText: OtherIncome_interestOnSavingBank,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value)
            {

              OtherIncome_interestOnSavingBank=value;
              previousEmployerOtherIncome_Obj?.interestOnSavingBank=value;

              setState(() {
                OtherIncome_totalIncome=calculateTheAll_OtherincomeData();
                previousEmployerOtherIncome_Obj?.total=OtherIncome_totalIncome;

              });

            },
          ),

        ))


      ],
    );
  }
  Row anyOtherIncome_OtherIncome(){
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
              child: Text("Any Other Income",
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
            controller: anyOtherIncome_Controllers,
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
              hintText: OtherIncome_anyOtherIncome,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value)
            {
              OtherIncome_anyOtherIncome=value;
              previousEmployerOtherIncome_Obj?.anyOtherIncome=value;

              setState(() {
                OtherIncome_totalIncome=calculateTheAll_OtherincomeData();
                previousEmployerOtherIncome_Obj?.total=OtherIncome_totalIncome;

              });

            },
          ),

        ))


      ],
    );
  }
  Row incomeFromCapitalGains_OtherIncome(){
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
              child: Text("Income From Capital Gains",
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
            controller: incomeFromCapitalGains_Controllers,
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
              hintText: OtherIncome_incomeFromCapitalGains,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value) {

              OtherIncome_incomeFromCapitalGains=value;
              previousEmployerOtherIncome_Obj?.incomeFromCapitalGains=value;

              setState(() {
                OtherIncome_totalIncome=calculateTheAll_OtherincomeData();
                previousEmployerOtherIncome_Obj?.total=OtherIncome_totalIncome;

              });

            },
          ),

        ))


      ],
    );
  }

  Row businessIncome_OtherIncome(){
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
              child: Text("Business Income",
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
            controller: businessIncome_Controllers,
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
              hintText: OtherIncome_businessIncome,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value)
            {
              OtherIncome_businessIncome=value;
              previousEmployerOtherIncome_Obj?.businessIncome=value;

              setState(() {
                OtherIncome_totalIncome=calculateTheAll_OtherincomeData();
                previousEmployerOtherIncome_Obj?.total=OtherIncome_totalIncome;

              });


            },
          ),

        ))


      ],
    );
  }

  Row incomeFromOtherSources_OtherIncome(){
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
              child: Text("Income From Other Sources",
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
            controller: incomeFromOtherSource_Controllers,
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
              hintText:OtherIncome_incomeFromOtherSources ,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value)
            {
              OtherIncome_incomeFromOtherSources=value;
              previousEmployerOtherIncome_Obj?.incomeFromOtherSources=value;

              setState(() {
                OtherIncome_totalIncome=calculateTheAll_OtherincomeData();
                previousEmployerOtherIncome_Obj?.total=OtherIncome_totalIncome;

              });


            },
          ),

        ))


      ],
    );
  }


  Row totalIncome_previousEmp(){
    return    Row(
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
              child: Text("Total Income",
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
            child: TextField
              (
              controller: totalIncome_Controllers,
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
                hintText: preEmp_totalIncome,
                border:
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0)),
              ),
              onChanged: (value)
              {
                preEmp_totalIncome=value;
                previousEmployerIncome_Obj?.totalIncome=value;
                setState(() {
                  preEmp_totalSum=calculateTheAll_previousEmployeeIncomeData();
                  previousEmployerIncome_Obj?.total=preEmp_totalSum;

                });
              },
            ),

          ),
        )


      ],
    );
  }
  Row tds_PreviousEmp(){
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
              child: Text("TDS",
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
              hintText: preEmp_TDS,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value) {
              preEmp_TDS=value;
              previousEmployerIncome_Obj!.tds=value;

            },
          ),

        ))


      ],
    );
  }
  Row professionalTax_PreviousEmp(){
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
              child: Text("Professional Tax",
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
            controller: professionalTax_Controllers,
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
              hintText: preEmp_professionalTax,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)),
            ),
            onChanged: (value)
            {

              preEmp_professionalTax=value;
              previousEmployerIncome_Obj?.professionalTax=value;

              setState(() {
                preEmp_totalSum=calculateTheAll_previousEmployeeIncomeData();
                previousEmployerIncome_Obj?.total=preEmp_totalSum;

              });

            },
          ),

        ))


      ],
    );
  }
  Row providentFund_PreviousEmp(){
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
              child: Text("Provident Fund",
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
            // color: Colors.grey[200],
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
                hintText: preEmp_providentFund,
                border:
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0)),
              ),
              onChanged: (value)
              {
                preEmp_providentFund=value;

                previousEmployerIncome_Obj?.providentFund=value;

              },
            ),

          ),
        )


      ],
    );
  }
  Row total_PreviousEmp(){
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
              child: Text("Total",
                style: TextStyle(fontSize: 12,color: Colors.black),),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),

        Expanded(
          flex: 1,
          child:Container(
            // color: Colors.grey[200],
            width: MediaQuery
                .of(context)
                .size
                .width * 0.4,
            height: 35,
            child: TextField(
              enabled: _isEnabled,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                fillColor: Colors.grey[200], filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                contentPadding: EdgeInsets.only(
                    top: 5, left: 3),
                hintText:  preEmp_totalSum,
                border:
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0)),
              ),
              onChanged: (value)
              {
                preEmp_totalSum=value;

                previousEmployerIncome_Obj?.total=value;

              },
            ),

          ) ,
        )


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

            saveTax_OtherIncomeDetails();

          },
          child: Text('Update',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 16))

      ),
    );
  }

  SizedBox create_Space(){
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
      getOtherIncomeDetailsApiRequest();
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
          getOtherIncomeDetailsApiRequest()
        }
      else
        {
          //print('please check the network status'),
          showNetworConnectionAlert()
        }
    });*/
    // getOtherIncomeDetailsApiRequest();
  }

  getOtherIncomeDetailsApiRequest()
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

    });

    SharedPreference.getEmpId().then((value) =>  {
      //print('show emp name2 $value'),
      empUserId=value,

    });

    Method.getIPAddress().then((value) =>  {
      //print('show emp name2 $value'),
      empIp=value,

      this.getOtherIncomeDetails()

    });
  }

  getOtherIncomeDetails() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.tax_get_previous_employer_income),
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

        InvestmentDeclaration_OtherIncomeDetails_ModelResponse incomeDetails_ModelResponse = InvestmentDeclaration_OtherIncomeDetails_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(incomeDetails_ModelResponse.statusCode==true)
        {
          setState(() {
            loadData(incomeDetails_ModelResponse.data!);
          });
        }
        else
        {
          if (incomeDetails_ModelResponse.message==null || incomeDetails_ModelResponse.message=="")
          {
            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, incomeDetails_ModelResponse.message);
            // show_OKAlert(incomeDetails_ModelResponse.message);
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
  loadData(Data data)
  {
    if(data.previousEmployerIncome!.length>0)
    {
      var preObj=data.previousEmployerIncome?[0];
      previousEmployerIncome_Obj = preObj;
      preEmp_totalIncome=preObj?.totalIncome;
      preEmp_TDS=preObj?.tds;
      preEmp_professionalTax=preObj?.professionalTax;
      preEmp_providentFund=preObj?.providentFund;
      preEmp_totalSum=preObj?.total;
    }

    if(data.previousEmployerOtherIncome!.length>0)
    {
      var preOtherObj=data.previousEmployerOtherIncome?[0];

      previousEmployerOtherIncome_Obj = preOtherObj;

      OtherIncome_incomeFromOtherSources=preOtherObj?.incomeFromOtherSources;
      OtherIncome_businessIncome=preOtherObj?.businessIncome;
      OtherIncome_incomeFromCapitalGains=preOtherObj?.incomeFromCapitalGains;
      OtherIncome_anyOtherIncome=preOtherObj?.anyOtherIncome;
      OtherIncome_interestOnSavingBank=preOtherObj?.interestOnSavingBank;
      OtherIncome_tds=preOtherObj?.tdsOthers;
      OtherIncome_totalIncome=preOtherObj?.total;

    }
  }

  saveTax_OtherIncomeDetails() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.tax_save_previous_employer_income_details),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'total_income': previousEmployerIncome_Obj?.totalIncome,
          'tds': previousEmployerIncome_Obj?.tds,
          'professional_tax': previousEmployerIncome_Obj?.professionalTax,
          'provident_fund': previousEmployerIncome_Obj?.providentFund,
          'total': previousEmployerIncome_Obj?.total,

          'income_from_other_sources': previousEmployerOtherIncome_Obj?.incomeFromOtherSources,
          'business_income': previousEmployerOtherIncome_Obj?.businessIncome,
          'income_from_capital_gains':previousEmployerOtherIncome_Obj?.incomeFromCapitalGains,
          'any_other_income': previousEmployerOtherIncome_Obj?.anyOtherIncome,
          'interest_on_saving_bank': previousEmployerOtherIncome_Obj?.interestOnSavingBank,
          'tds_others': previousEmployerOtherIncome_Obj?.tdsOthers,
          'other_income_total': previousEmployerOtherIncome_Obj?.total,

          'financial_year': financialYear.toString(),
          'emp_code': getEncrypted_EmpCode(completeEmpCode).toString(),
          'emp_ip': empIp.toString(),
          'emp_user_id': empUserId.toString()


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

        InvestmentDeclaration_OtherIncomeDetails_ModelResponse incomeDetails_ModelResponse = InvestmentDeclaration_OtherIncomeDetails_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(incomeDetails_ModelResponse.statusCode==true)
        {
          Method.snackBar_OkText(context, incomeDetails_ModelResponse.message);

          // show_OKAlert(incomeDetails_ModelResponse.message);

        }
        else
        {
          if (incomeDetails_ModelResponse.message==null || incomeDetails_ModelResponse.message=="")
          {
            Method.snackBar_OkText(context, "server error!");

            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, incomeDetails_ModelResponse.message);
            // show_OKAlert(incomeDetails_ModelResponse.message);
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
  String calculateTheAll_previousEmployeeIncomeData()
  {

    String totalIncome="";
    if (previousEmployerIncome_Obj?.totalIncome=="")
    {
      totalIncome="0";
    }else
    {
      totalIncome=previousEmployerIncome_Obj?.totalIncome;
    }

    String professionalTax="";
    if (previousEmployerIncome_Obj?.professionalTax=="")
    {
      professionalTax="0";
    }else
    {
      professionalTax=previousEmployerIncome_Obj?.professionalTax;
    }
    String provident_fund="";
    if (previousEmployerIncome_Obj?.providentFund=="")
    {
      provident_fund="0";
    }else
    {
      provident_fund=previousEmployerIncome_Obj?.providentFund;
    }
    //txt_providentFund.setText(provident_fund);


    int totalOtherIncome=int.parse(totalIncome)-int.parse(professionalTax);

    String totalCal=totalOtherIncome.toString();
    return totalCal;
  }
  String calculateTheAll_OtherincomeData()
  {
    String incomefromothersources="";
    if (previousEmployerOtherIncome_Obj?.incomeFromOtherSources=="")
    {
      incomefromothersources="0";
    }else
    {
      incomefromothersources=previousEmployerOtherIncome_Obj?.incomeFromOtherSources;
    }

    String businessincome="";
    if (previousEmployerOtherIncome_Obj?.businessIncome=="")
    {
      businessincome="0";
    }else
    {
      businessincome=previousEmployerOtherIncome_Obj?.businessIncome;
    }

    String ncomefromcapitalgains="";
    if (previousEmployerOtherIncome_Obj?.incomeFromCapitalGains=="")
    {
      ncomefromcapitalgains="0";
    }else
    {
      ncomefromcapitalgains=previousEmployerOtherIncome_Obj?.incomeFromCapitalGains;
    }
    String anyotherincome="";
    if (previousEmployerOtherIncome_Obj?.anyOtherIncome=="")
    {
      anyotherincome="0";
    }else
    {
      anyotherincome=previousEmployerOtherIncome_Obj?.anyOtherIncome;
    }

    String interestonsavingbank="";
    if (previousEmployerOtherIncome_Obj?.interestOnSavingBank=="")
    {
      interestonsavingbank="0";
    }else
    {
      interestonsavingbank=previousEmployerOtherIncome_Obj?.interestOnSavingBank;
    }

    String tdsothers="";
    if (previousEmployerOtherIncome_Obj?.tdsOthers=="")
    {
      tdsothers="0";
    }else
    {
      tdsothers=previousEmployerOtherIncome_Obj?.tdsOthers;
    }

    int totalOtherIncome=int.parse(incomefromothersources)+int.parse(businessincome)
        +int.parse(ncomefromcapitalgains)+int.parse(anyotherincome)
        +int.parse(interestonsavingbank)+int.parse(tdsothers);

    String totalCal=totalOtherIncome.toString();
    return totalCal;
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
  // /*  var alertDialog = AlertDialog(
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

/*----------commented shoe_OKAlert Dialog---------21-07-2022-end--*/

}