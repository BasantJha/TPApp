import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;

import '../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/CJHubCustomView/AutoLogout.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJHubCustomView/NetworkStatus/NetworkReachability.dart';
import '../../../../CustomView/CJHubCustomView/SalaryYearMonth_List.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../Services/AESAlgo/encrypt.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../Services/Messages/Message.dart';
import '../../ModelClasses/CJHubModelClasses/SalarySlip_ModelResponse.dart';
import '../../ModelClasses/CJHubModelClasses/SalaryStatus_ModelResponse.dart';
import '../CJHubPDF/mobile_pdf.dart';
import 'SalarySlipDetails_UI.dart';
import 'SalaryStatus_UI.dart';

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
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CJ Hub',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: salary_status(title: 'CJ Hub'),
    );
  }
}
class salary_status extends StatefulWidget
{

  salary_status({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _salary_status createState() => _salary_status();
}

class _salary_status extends State<salary_status>
{
  // This widget is the root of your application.
  String checkRoleType="";
  String salaryStatus="Salary Status";


  bool clientAccount_Selected=false,clientAccount_Unselected =false,
      attendanceReceived_Selected=false, attendanceReceived_Unselected=true,
      salaryProcess_Selected=false,salaryProcess_Unselected=true
  ,bankTransfer_Selected=false,bankTransfer_Unselected=true;

  String attendanceReceivedDate="",salaryProcessingDate="",bankTransferDate="";

  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;


  checkEmp_JobType()
  {
    SharedPreference.getEmpJobType().then((value) =>  {
      //print('show emp name2 $value'),
      loadData(value)
    });
  }

  loadData(String value)
  {
    setState(() {

      if(value == "Regular")
      {
        // Regular
        checkRoleType="Regular";

        clientAccount_Selected=false;
        attendanceReceived_Unselected = true;
        salaryProcess_Unselected = true;
        bankTransfer_Unselected = true;

        clientAccount_Unselected =false;
        attendanceReceived_Selected = false;
        salaryProcess_Selected = false;
        bankTransfer_Selected = false;

      }
      else
      {
        //Contractual
        checkRoleType="Contractual";

        clientAccount_Unselected = true;
        attendanceReceived_Unselected =true;
        salaryProcess_Unselected =true;
        bankTransfer_Unselected =true;

        clientAccount_Selected = false;
        attendanceReceived_Selected = false;
        salaryProcess_Selected = false;
        bankTransfer_Selected = false;
      }
    });

  }

  @override
  void initState() {
    super.initState();


    checkEmp_JobType();

    if(!networkStatus){
      print("Api salary status should be called");
      salaryStatusRequest();
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
      Method.snackBar_OkText(context, 'No Internet Connection');
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
          showNetworConnectionAlert()
        }
    });*/
     // salaryStatusRequest();
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

  SingleChildScrollView mainFunction_UI(){
    return SingleChildScrollView(
      child: Container(
        // color: Colors.white,
        child: Center(

      child: Column(children: <Widget>[

        // SalaryStatus_UI.create_headingContainer(salaryStatus),

        // name of Salary status month
        SalaryStatus_UI.create_salaryBannerContainer(salaryStatus),
        //image of salary_banner

        //Unselected card
        Visibility(
          visible: clientAccount_Unselected,
          child: SalaryStatus_UI.create_cardUnselectedContainer("Client Account Funded"),), //Unselected Client fund

        //Selected card
        Visibility(
          visible: clientAccount_Selected,
          child: SalaryStatus_UI.create_cardSelectedContainer('Client Account Funded', attendanceReceivedDate),),
        SalaryStatus_UI.create_sizebetweenCards(),


        Visibility(
          visible: attendanceReceived_Unselected,
          child: SalaryStatus_UI.create_cardUnselectedContainer("Attendance Processing"),), //Unselected Attendance Processing,

        Visibility(
          visible: attendanceReceived_Selected,
          child: SalaryStatus_UI.create_cardSelectedContainer('Attendance Received', attendanceReceivedDate),),
        SalaryStatus_UI.create_sizebetweenCards(),

        Visibility(
          visible: salaryProcess_Unselected,
          child: SalaryStatus_UI.create_cardUnselectedContainer("Salary Processing"),),
        //Unselected Salary Processing

        Visibility(
          visible: salaryProcess_Selected,
          child: SalaryStatus_UI.create_cardSelectedContainer('Salary Processed', salaryProcessingDate),),
        SalaryStatus_UI.create_sizebetweenCards(),

        Visibility(
          visible: bankTransfer_Unselected,
          child: SalaryStatus_UI.create_cardUnselectedContainer("Bank Transfer"),),
        //Unselected Bank Transfer

        Visibility(
          visible: bankTransfer_Selected,
          child: SalaryStatus_UI.create_cardSelectedContainer('Bank Transfer', bankTransferDate),),

        SizedBox(
          height: 15,
        )

      ],
      ),
    )
      )

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: WillPopScope(
          child:  Responsive(
            mobile: mainFunction_UI(),
            tablet: Center(
              child: Container(
                width: salaryStatus_tabletWidth,
                child: mainFunction_UI(),
              ),
            ),
            desktop: Center(
              child: Container(
                width: salaryStatus_desktopWidth,
                child: mainFunction_UI(),
              ),
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


  salaryStatusRequest()
  {

    String mobileNumber="",
        empCode="",
        empDateOfBirth="",
        completeEmpCode="";

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
          loadSalaryStatusData(salaryStatus_ModelResponse);
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

  loadSalaryStatusData(SalaryStatus_ModelResponse salaryStatus_ModelResponse)
  {
    String checkSalaryStatus=salaryStatus_ModelResponse.data!.salaryStatus;

    String monthNameByMonthNumber=SalaryYearMonth_List.FindMonthName_ByNumber(salaryStatus_ModelResponse.data!.mprMonth);
    String  salaryYear = salaryStatus_ModelResponse.data!.mprYear;
    // String completeSalaryStatus="Salary Status for the\nmonth of "+""+monthNameByMonthNumber+" ' "+salaryYear;
    String completeSalaryStatus=monthNameByMonthNumber+" ' "+salaryYear;

    setState(() {

      salaryStatus=completeSalaryStatus;

      if(checkSalaryStatus=="1")
      {
        Method.snackBar_OkText(context, "Salary Status not found");
        // show_OKAlert("Salary Status not found");
      }
      else if(checkSalaryStatus=="2")
      {
        clientAccount_Unselected =false;
        attendanceReceived_Unselected = false;

        clientAccount_Selected=false;
        attendanceReceived_Selected = true;
        salaryProcess_Unselected = true;
        bankTransfer_Unselected = true;
        attendanceReceivedDate=salaryStatus_ModelResponse.data!.attendanceReceiveDate;
      }
      else if(checkSalaryStatus=="3")
      {
        clientAccount_Unselected =false;
        attendanceReceived_Unselected = false;
        salaryProcess_Unselected = false;

        attendanceReceived_Selected = true;
        salaryProcess_Selected = true;
        bankTransfer_Unselected = true;

        attendanceReceivedDate=salaryStatus_ModelResponse.data!.attendanceReceiveDate;
        salaryProcessingDate=salaryStatus_ModelResponse.data!.payrollProcessingDate;
      }
      else if(checkSalaryStatus=="4")
      {

        clientAccount_Unselected =false;
        attendanceReceived_Unselected = false;
        salaryProcess_Unselected = false;
        bankTransfer_Unselected = false;

        attendanceReceived_Selected = true;
        salaryProcess_Selected = true;
        bankTransfer_Selected = true;

        attendanceReceivedDate=salaryStatus_ModelResponse.data!.attendanceReceiveDate;
        salaryProcessingDate=salaryStatus_ModelResponse.data!.payrollProcessingDate;
        bankTransferDate=salaryStatus_ModelResponse.data!.bankTransferDate;

      }
      else
      {

      }

      if(checkRoleType=="Regular")
      {
        //regular
      }
      else
      {
        //contractual
        clientAccount_Selected=true;
        clientAccount_Unselected=false; ///29-1-2022
        attendanceReceivedDate=salaryStatus_ModelResponse.data!.attendanceReceiveDate;

      }

    });

  }

  /*---------------COmmmented Show_alert dialog ---------start------*/
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
  //   /*-----AlertDialog------end----------------------*/
  //
  // }

/*---------------COmmmented Show_alert dialog ---------end------*/

}