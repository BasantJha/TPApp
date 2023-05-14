
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:contractjobs/Controller/Talents/Controller/CJHubSalaryModule/salary_slip_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;

import '../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJHubCustomView/NetworkStatus/NetworkReachability.dart';
import '../../../../CustomView/CJHubCustomView/SalaryYearMonth_List.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../Services/AESAlgo/encrypt.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../Services/Messages/Message.dart';
import '../../ModelClasses/CJHubModelClasses/SalaryStatus_ModelResponse.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff00BFFF)
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CJ Hub',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: salary_slip(title: 'CJ Hub'),
    );
  }
}

class salary_slip extends StatefulWidget {

  salary_slip({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _salary_slip createState() => _salary_slip();
}

class _salary_slip extends State<salary_slip>
{
  // This widget is the root of your application.

  String? valueChoose;

  List<String> heads_stringList = [];

  String mobileNumber="",
      empCode="",
      empDateOfBirth="",
      completeEmpCode="";

  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(!networkStatus){
      print("Api salary status should be called");
      salaryStatusRequest();
      EasyLoading.dismiss();
    }
    else{
      print("Api salary status should not be called");
      EasyLoading.show(status: Message.get_LoaderMessage);
      // showAlert(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No Internet Connection')));
    }
    print(" Inside Test Widget 2");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      NetworkReachability connectionStatus = NetworkReachability.getInstance();

      _connectionChangeStream =
          connectionStatus.connectionChange.listen(checkNetworkConnection);
    });

    // checkNetworkConnection();

  }

  SingleChildScrollView mainFuncation_UI(){
    return SingleChildScrollView(
       child: Container(
        // color: Colors.white,
        child: Center(
        child:
        Column(children: <Widget>[

        // create_headingContainer("Salary Slip" ),//heading

        create_salaryBannerContainer(),//image of salary_slip_banner

        SizedBox(
          height: 15,
        ),

        create_cardDropdownContainer('View Salary Slip'),

          SizedBox(
            height:15 ,
          ),

      ]),
    )
       )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
          child:
          Responsive(
            mobile: mainFuncation_UI(),
            tablet: Center(
              child: Container(
                width: salarySlip_tabletWidth,
                child: mainFuncation_UI(),
              ),
            ),
            desktop: Center(
              child: Container(
                width: salarySlip_desktopWidth,
                child: mainFuncation_UI(),
              ),
            ),
          ),

          onWillPop: () async => false,
         /* onWillPop: ()
          {
            Message.alert_dialogAppExit(context);

          } ,*/

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

            Text(value,
              style: TextStyle(color: Colors.black,fontSize: 15),),
          ],
        ),
      ),
    );
  }

  Container create_salaryBannerContainer(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30,20,30,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset(getCJHub_SalarySlipBannerIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container create_cardDropdownContainer(String salaryStatus_name){
    return Container(
        width: 320,
        height: 180.0,
        margin: const EdgeInsets.symmetric(
          // vertical: 6.0,
          horizontal: 20.0,
        ),
        child: new Stack(
          children: <Widget>[
            Container(
              height: 180.0,
              width: 320,
              margin: new EdgeInsets.only(left: 10),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                  border: Border.all(color: fourHunGreyColor,
                      width: 1.0,
                      style: BorderStyle.solid)
              ),
              padding: const EdgeInsets.only(left:10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(salaryStatus_name,
                    style: TextStyle(color: Color(0xff32AAE0),
                        fontSize: 15),),

                  // Drop down of months
                  dropDownButton(),

                  SizedBox(
                    height:20 ,
                  ),

                  // Button of view salary_slip
                  ViewSalarySlip_Button(),


                ],
              ),
            ),
          ],
        )
    );
  }

  Container dropDownButton(){
    return Container(
      padding: EdgeInsets.fromLTRB(10,0,10,0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: fourHunGreyColor,
            width: 1.0,
            style: BorderStyle.solid),
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child:DropdownButton(
        hint: Text("Select Month"),
        icon: Icon(Icons.arrow_drop_down),
        dropdownColor: Colors.white,
        underline: DropdownButtonHideUnderline(child: Container()),
        iconSize: 25,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
        value: valueChoose,
        onChanged: (newValue)
        {
          setState(()
          {
            valueChoose = newValue;
            //print('show selected value $valueChoose');

            loadTheSelectedYearMonth(valueChoose!);
          });
        },
        items: heads_stringList.map((valueItem){
          return DropdownMenuItem(
            value: valueItem,
            child: Text(valueItem),
          );
        }).toList(),
      ),
    );
  }

  Padding ViewSalarySlip_Button(){
    return Padding(
      padding: const EdgeInsets.only(left:0,right: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height:50, //height of button
            width:180,
            child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary:Color(0xff00BFFF),
                  elevation: 1.0, //elevation of button
                  shape: RoundedRectangleBorder( //to set border radius to button
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                ),
                onPressed:()
                {
                  /*------------3/8/2021 start------------*/
                  //print('show selected year month $valueChoose');
                  if(valueChoose==null || valueChoose=="")
                  {

                    Method.snackBar_OkText(context, "Please Select The Month");
                    // show_OKAlert("Please Select The Month");
                  }
                  else
                  {

                    Navigator.push(context, MaterialPageRoute(
                        builder: (_) =>
                            Responsive(
                              mobile: salary_slip_detail(),
                              tablet: Center(
                                child: Container(
                                  width: flutterWeb_tabletWidth,
                                  child: salary_slip_detail(),
                                ),
                              ),
                              desktop: Center(
                                child: Container(
                                  width: flutterWeb_desktopWidth,
                                  child: salary_slip_detail(),
                                ),
                              ),
                            )
                            // salary_slip_detail()
                    ),);
                  }

                  /*------------3/8/2021 end------------*/

                },
                child: Text('View Salary Slip',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 15))),
          ),
        ],

      ),
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
      salaryStatusRequest();
      EasyLoading.dismiss();
    }
    else{
      print("Api should not be called");
      EasyLoading.show(status: Message.get_LoaderMessage);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No Internet Connection')));
    }
    print(" Inside Test Widget 2");
   /* NetworkReachability.networkConnectionStatus().then((networkStatus) =>
    {
      if(networkStatus)
        {
          salaryStatusRequest()
        }
      else
        {
          //print('please check the network status'),
          showNetworkConnectionAlert()
        }
    });*/

    // salaryStatusRequest();
  }
  salaryStatusRequest()
  {


    SharedPreference.getEmpMobileNo().then((value) =>  {
      mobileNumber=value,
      //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpCode().then((value) =>  {
      empCode=value,
      //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth=value,
      //print('show emp name2 $value'),
      completeEmpCode = mobileNumber+"CJHUB"+empCode+"CJHUB"+empDateOfBirth,

      this.salaryStatus_WebApi(completeEmpCode)

    });

  }

  // ignore: non_constant_identifier_names
  salaryStatus_WebApi(String empCode) async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.get_Salary_Status),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'emp_code': getEncrypted_EmpCode(empCode)
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

        SalaryStatus_ModelResponse salaryStatus_ModelResponse = SalaryStatus_ModelResponse.fromJson(jsonDecode(serverResponse));


        if(salaryStatus_ModelResponse.statusCode==true)
        {
          loadLiveData(salaryStatus_ModelResponse);
        }
        else
        {
          if (salaryStatus_ModelResponse.message==null)
          {
            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, salaryStatus_ModelResponse.message!);
            // show_OKAlert(salaryStatus_ModelResponse.message);
          }
        }
        //return _verify_mobile_modelResponse;

      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      //print(e);
    }
  }

  loadLiveData(SalaryStatus_ModelResponse checkSalaryStatusModelData)
  {

    heads_stringList=SalaryYearMonth_List.loadLiveData(checkSalaryStatusModelData);
    //print('show string list $heads_stringList');

    setState(() {
      heads_stringList=heads_stringList;
    });
    /*-----start new logic for the -------*/

  }
  loadTheSelectedYearMonth(String selected_year_month)
  {
    List<String> separated = selected_year_month.split(" ");
    String selected_MonthName=separated[0];
    String selected_Year=separated[1];

    String monthNumber_byMonthName=SalaryYearMonth_List.FindMonthNumber_ByMonthName(selected_MonthName);

    SharedPreference.setSalaryMonthNumber(monthNumber_byMonthName);

    SharedPreference.setSalaryMonthName(selected_MonthName);
    SharedPreference.setSalaryYear(selected_Year);

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
  //
  //   /*  var alertDialog = AlertDialog(
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
  //   /*-----AlertDialog------end----------------------*/
  //
  // }

  /*----------commented show_OKAlert Dialog---------21-07-2022-end--*/


  showNetworkConnectionAlert()
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

}