import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;

//import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

//import 'package:web/mobile_pdf.dart' if (dart.library.html) 'package:web/web_pdf.dart';


import '../../../../Constant/CJAppFlowConstants.dart';
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
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../Services/AESAlgo/encrypt.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../Services/Messages/Message.dart';
import '../../ModelClasses/CJHubModelClasses/SalarySlip_ModelResponse.dart';
import '../../ModelClasses/CJHubModelClasses/SalaryStatus_ModelResponse.dart';
import '../../ModelClasses/CJTalentCommonModelClass.dart';
import '../CJHubPDF/mobile_pdf.dart';
import 'SalarySlipDetails_UI.dart';


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
      home: salary_slip_detail(title: 'CJ Hub'),
    );
  }
}
class salary_slip_detail extends StatefulWidget
{
  salary_slip_detail({Key? key, this.title, this.completedEmpCode, this.salaryYearType, this.salaryMonthNameType}) : super(key: key);

  final String? title;
  final String? completedEmpCode;
  final String? salaryYearType;
  final String? salaryMonthNameType;


  @override
  _salary_slip_detail createState() => _salary_slip_detail();

}

class _salary_slip_detail extends State<salary_slip_detail> {


  String empCode = "-",
      empName = "-",
      designation = "-",
      esic_number = "-",
      pf_number = "-",
      uan_number = "-",
      pay_days = "-",
      lop_days = "-",
      pan_number = "-";

  String basic_amount = "0",
      pf_amount = "0",
      hra = "0",
      esic = "0",
      allowances = "0",
      nps = "0",
      govt_bonus = "0",
      medical_insurance = "0",
      arrears = "0",
      miscellaneous_deductions = "0",
      taxes = "0",
      total_earnings = "0",
      total_deductions = "0",
      net_payable = "0",
      bank_account_no = "-";

  String doj = "",dob="",ratebasic="0",ratehra="0",ratespecialallowance="0", rategross="0",
      arearbasic="0",arearhra="0",arearallowance="0",areargross="0";

//
  String firstVariableComponent_Key = "",
      firstVariableComponent_Value = "-",
      secondVariableComponent_Key = "",
      secondVariableComponent_Value = "-",
      thirdVariableComponent_Key = "",
      thirdVariableComponent_Value = "-";

  String firstDeductionComponent_Key = "",
      firstDeductionComponent_Value = "-",
      secondDeductionComponent_Key = "",
      secondDeductionComponent_Value = "-";


  String salaryMonthName = "",
      salaryYear = "",
      headerHeading = "",companyName="",companyAddress="";

  /*------use for generate pdf start----------*/
  double title_TextFontSize = 12;
  double subtitle_TextFontSize = 11;

  /*------use for generate pdf end----------*/

  /*------use for generate ui start----------*/
  double text_subtitle_TextFontSize = 11;

  /*------use for generate pdf end----------*/

  /*------------13-11-2021 start-----------*/

  bool arrears_Visibility=false;

  bool first_VariableDeductionComponent_Visibility=false;
  bool second_VariableDeductionComponent_Visibility=false;
  /*------------13-11-2021 end-----------*/

  /*--------11-10-2022 START----------*/
  String empJobType="",empCodeTitle="",cjCode="",dateOfJoiningTitle="";
  /*--------11-10-2022 END----------*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     //loadTheApiCallData();
    //salarySlipDetails_WebApi("");
    //testing purpose --- 11-1-2022
    /*String completeEmpCode =
        "mobileno" + "CJHUB" + "empcode" + "CJHUB" + "date" +
            "CJHUB" + "month" + "CJHUB" + "year";

   salarySlipDetails_WebApi(completeEmpCode);*/


    loadBasicData();
    salarySlipDetails_WebApi();

    if(kIsWeb){

      //print("This CJ Hub salary slip Web");

      AutoLogout.initializeTimer(context);

    }
    else{

      //print('this is mobile App');

    }


  }

  void _handleUserInteraction([_]) {
    if (_rootTimer != null && !_rootTimer!.isActive) {
      // This means the user has been logged out
      return;
    }

    _rootTimer?.cancel();

    //print("salary_slip_details resetTimer");

    AutoLogout.initializeTimer(context);
  }

  loadBasicData()
  {

    /* SharedPreference.getSalaryYear().then((value) =>
    {
      salaryYear = value
    });

    SharedPreference.getSalaryMonthName().then((value) =>
    {
      salaryMonthName = value,
    });*/

    salaryYear=widget.salaryYearType!;
    salaryMonthName=widget.salaryMonthNameType!;


    print("show the salaryYear $salaryYear");
    print("show the salaryMonthName $salaryMonthName");


  }

  loadTheApiCallData()
  {
    String mobileNumber = "",
        empDateOfBirth = "",
        selected_Month = "",
        selected_Year = "",
        completeEmpCode = "",
        empCode_key="";


    SharedPreference.getEmpPanCardNumber().then((value) =>
    {
      //mobileNumber=value,
      //print('show emp name2 $value'),
      pan_number = value
    });

    SharedPreference.getEmpMobileNo().then((value) =>
    {
      mobileNumber = value,
      //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpCode().then((value) =>
    {
      empCode = value,
      empCode_key=value
      //print('show emp name2 $value'),
      //loadData()
    });

    /*-----------11-10-2022 start----------*/
    SharedPreference.get_CJCode().then((value) =>  {
      // print('show emp cjCode $value'),
      cjCode=value,
    });

    SharedPreference.getEmpJobType().then((value) =>  {
      //print('show emp name2 $value'),
      empJobType=value,
      //loadThe_EmpTitle()
      // ignore: unrelated_type_equality_checks
    });
    /*-----------11-10-2022 end----------*/

    SharedPreference.getSalaryMonthNumber().then((value) =>
    {
      selected_Month = value,

    });
    SharedPreference.getSalaryYear().then((value) =>
    {
      selected_Year = value,
      salaryYear = value
    });

    SharedPreference.getSalaryMonthName().then((value) =>
    {
      salaryMonthName = value,

    });

    SharedPreference.getEmpDateOfBirth().then((value) =>
    {

      empDateOfBirth = value,
      dob=value,

      //print('show emp name2 $value'),

      completeEmpCode =
          mobileNumber + "CJHUB" + empCode_key + "CJHUB" + empDateOfBirth +
              "CJHUB" + selected_Month + "CJHUB" + selected_Year,


      /*completeEmpCode =
    mobileNumber + "CJHUB" + "5649" + "CJHUB" + empDateOfBirth +
    "CJHUB" + selected_Month + "CJHUB" + selected_Year,

      //print('show the new empcode  $getEncrypted_EmpCode(empCode)'),
*/

      // this.salarySlipDetails_WebApi(completeEmpCode)
    });
  }

  loadThe_EmpTitle()
  {
    setState(() {

      /*---------12-10-2022 start---------*/
      if(empJobType == "Regular")
      {
        //Regular
        empCodeTitle="Employee Code";
        dateOfJoiningTitle="DOJ";
      }
      else
      {
        //Contractual
        empCodeTitle=getTPCode;
        dateOfJoiningTitle="Deputed Date";

      }
      /*---------12-10-2022 end---------*/
    });
  }
  SingleChildScrollView salary_slip_details_UIMain(){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          create_headingContainer(headerHeading),

          create_dataTable_1(),

          SalarySlipDetails_UI.create_uperDownSpace(),

          SingleChildScrollView(
            child: create_dataTable_2(),
          )

        ],
      ),

    );
  }

  @override
  Widget build(BuildContext context)
  {
    var size =MediaQuery.of(context).size;
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handleUserInteraction,
        onPointerMove: _handleUserInteraction,
        onPointerUp: _handleUserInteraction,
        child:
        Scaffold(

            backgroundColor: Colors.white,
            appBar:CJAppBar(getCJHUB_SalarySlip, appBarBlock: AppBarBlock(appBarAction: ()
            {
              print("show the action type");
              Navigator.pop(context);
            })),


            body: /*WillPopScope(
              child:*/ Responsive(

                mobile: salary_slip_details_UIMain(),

                tablet: Center(
                    child: Container(
                      width: size.width*salarySlipDetails_tabletWidth,
                      child: salary_slip_details_UIMain(),
                    )
                ),

                desktop: Center(
                    child: Container(
                      width: size.width*salarySlipDEtails_desktopWidth,
                      child: salary_slip_details_UIMain(),
                    )
                ),
              ),

             /* onWillPop: () async => false,*/

              /*onWillPop: ()
          {
            Message.alert_dialogAppExit(context);

          } ,*/
            /*)*/


        )
    );
  }

  Container create_headingContainer(String value) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20,top: 20,bottom: 10),
        child: Row(
          children: [
            SizedBox(
              width: 20.0,
              height: 30.0,
              child: Image.asset(getCJHub_LineIcon,
              ),
            ),
            SizedBox(
                width: 3.0),
            Expanded(
              flex: 1,
              child: Text(value,
                style: TextStyle(color: Colors.black, fontSize: 15),),
            ),

            /*--------------28/2/2023 start-----------------*/

           /* SizedBox(
              height: 75, //height of button
              width: 80,
              child: MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {

                  if(kIsWeb){

                    _createPDF_SalarySlip("Ok");
                    alert_dialogWeb(context);

                  }
                  else{

                    alert_dialog(context);

                  }
                },

                child: SizedBox(
                  child: Image.asset(getCJHub_SalarySlipPDFIcon,
                  ),
                ),),
            ),*/

            /*--------------28/2/2023 end-----------------*/

          ],
        ),
      ),
    );
  }

  Column create_dataTable_1() {
    return
      Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              // padding: EdgeInsets.fromLTRB(15.0, 0, 5.0, 0),
              margin: EdgeInsets.all(10),
              child: Table(
                border: TableBorder.symmetric(
                  inside: BorderSide(width: 1, color: twoHunGreyColor),
                  outside: BorderSide(width: 1, color: twoHunGreyColor),),
                children: [
                  TableRow(children: [
                    SalarySlipDetails_UI.create_dataTableSub1(
                        empCodeTitle, empCode,text_subtitle_TextFontSize),

                    SalarySlipDetails_UI.create_dataTableSub1(
                        'Employee Name', empName,text_subtitle_TextFontSize)
                  ]),

                 TableRow(children: [
                    SalarySlipDetails_UI.create_dataTableSub1(dateOfJoiningTitle, doj,text_subtitle_TextFontSize),
                    SalarySlipDetails_UI.create_dataTableSub1('DOB', dob,text_subtitle_TextFontSize)
                  ]),

                   TableRow(children: [
                    SalarySlipDetails_UI.create_dataTableSub1(
                        'Designation', designation,text_subtitle_TextFontSize),
                    SalarySlipDetails_UI.create_dataTableSub1(
                        'ESIC Number', esic_number,text_subtitle_TextFontSize),
                  ]),
                  TableRow(children: [
                    SalarySlipDetails_UI.create_dataTableSub1(
                        'PF Number', pf_number,text_subtitle_TextFontSize),
                    SalarySlipDetails_UI.create_dataTableSub1(
                        'UAN Number', uan_number,text_subtitle_TextFontSize),
                  ]),
                  TableRow(children: [
                    SalarySlipDetails_UI.create_dataTableSub1(
                        'Pay Days', pay_days,text_subtitle_TextFontSize),
                    SalarySlipDetails_UI.create_dataTableSub1(
                        'LOP Days', lop_days,text_subtitle_TextFontSize),
                  ]),
                  TableRow(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SalarySlipDetails_UI.create_uperDownSpace(),

                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                                'PAN No.', style: TextStyle(color: Color(
                                0xff32AAE0), fontSize: 10)),
                          ),

                          /*create_SpaceBetweenWords(),

                            Text('26',style: TextStyle(fontWeight: FontWeight.bold),),*/

                          SalarySlipDetails_UI.create_uperDownSpace(),
                        ]),

                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SalarySlipDetails_UI.create_uperDownSpace(),

                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(pan_number, style: TextStyle(
                                color: Colors.black, fontSize: 10)),
                          ),

                          /*create_SpaceBetweenWords(),

                            Text('',style: TextStyle(fontWeight: FontWeight.bold),),
*/
                          SalarySlipDetails_UI.create_uperDownSpace(),
                        ]),
                  ]),
                ],
              ),
            ),
          ]);
  }


  Column create_dataTable_2() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          SalarySlipDetails_UI.create_earnDed('Earnings', 'Deductions'),
          SalarySlipDetails_UI.create_headAmount(
              'Heads','Monthly Rate','Earnings' ,'Arrears', 'Heads', 'Amount'),
          SalarySlipDetails_UI.create_subHeadAmount(
              'Basic', ratebasic,basic_amount, arearbasic,"Provident" + "\nFund", pf_amount),
          SalarySlipDetails_UI.create_subHeadAmount('HRA',ratehra ,hra,arearhra, "ESIC", esic),
          SalarySlipDetails_UI.create_subHeadAmount(
              'Allowances',ratespecialallowance, allowances,arearallowance, "NPS", nps),
          SalarySlipDetails_UI.create_subHeadAmount(
              'Govt. Bonus','', govt_bonus,'', "Medical" + "\nInsurance",
              medical_insurance),



          /*SalarySlipDetails_UI.create_subHeadAmount(
              'Arrears','', arrears,'', "Miscellaneous" + "\nDeductions",
              miscellaneous_deductions),*/
          /*---------13-11-2021 start--------*/

          //Note---14-12-2021---Arrears replace by Incentive
          Visibility(visible: arrears_Visibility,

            child:SalarySlipDetails_UI.create_subHeadAmount(
                'Incentive','', arrears,'', "Miscellaneous" + "\nDeductions",
                miscellaneous_deductions) ,
          ),
          Visibility(visible: !arrears_Visibility,

            child:SalarySlipDetails_UI.create_subHeadAmount(
                '','', '','', "Miscellaneous" + "\nDeductions",
                miscellaneous_deductions) ,
          ),
          /*---------13-11-2021 end--------*/


          SalarySlipDetails_UI.create_subHeadAmount(
              firstVariableComponent_Key, '',firstVariableComponent_Value,'', "Taxes",
              taxes),

          /*---------13-11-2021 start--------*/

          Visibility(visible: first_VariableDeductionComponent_Visibility,

            child:SalarySlipDetails_UI.create_subHeadAmount(
                secondVariableComponent_Key,'', secondVariableComponent_Value,'',
                firstDeductionComponent_Key, firstDeductionComponent_Value),
          ),

          Visibility(visible: second_VariableDeductionComponent_Visibility,

            child: SalarySlipDetails_UI.create_subHeadAmount(
                thirdVariableComponent_Key, '',thirdVariableComponent_Value,'',
                secondDeductionComponent_Key, secondDeductionComponent_Value),
          ),


          /*---------13-11-2021 end--------*/

          SalarySlipDetails_UI.create_totalEarn(
              "Total Earnings" + "\n(Gross)", rategross,total_earnings,areargross,
              "Total" + "\nDeductions", total_deductions),
          /* SalarySlipDetails_UI.create_subHeadAmount(
              '', '', "Net Payable", net_payable),
*/
          SalarySlipDetails_UI.create_bankDetail(
              'Net Payable', net_payable),
          SalarySlipDetails_UI.create_bankDetail(
              'Bank A/c No.', bank_account_no),
          SalarySlipDetails_UI.create_disclaimer('Disclaimer: This is a system generated payslip, does not require any signature.')
        ]);
  }

  alert_dialog(BuildContext context) {
    var alertDialog = AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //position
        mainAxisSize: MainAxisSize.min,
        // wrap content in flutter
        children: <Widget>[
          Text("Salary Slip Downloaded Successfully.",
            style: TextStyle(
                fontFamily: 'Vonique', fontSize: 15, color: Colors.black),),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [
        TextButton(onPressed: ()
        {
          _createPDF_SalarySlip("Open");
          Navigator.of(context).pop();

        }, child: Text("OPEN",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 15, color: Color(0xff00BFFF),),),),
        SizedBox(width: 5.0),
        TextButton(onPressed: ()
        {
          _createPDF_SalarySlip("Ok");
          Navigator.of(context).pop();

        }, child: Text("OK",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 15, color: Color(0xff00BFFF),),),),

      ],

    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }

  alert_dialogWeb(BuildContext context) {
    var alertDialog = AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //position
        mainAxisSize: MainAxisSize.min,
        // wrap content in flutter
        children: <Widget>[
          Text("Download Salary Slip ",
            style: TextStyle(
                fontFamily: 'Vonique', fontSize: 15, color: Colors.black),),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [
        TextButton(onPressed: ()
        {
          // _createPDF_SalarySlip("Open");
          Navigator.of(context).pop();

        }, child: Text("Cancel",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 15, color: Color(0xff00BFFF),),),),
        SizedBox(width: 5.0),
        TextButton(onPressed: ()
        {
          _createPDF_SalarySlip("Ok");
          Navigator.of(context).pop();

        }, child: Text("OK",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 15, color: Color(0xff00BFFF),),),),

      ],

    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }

  /*------------24-11-2022 start-------------*/
  salarySlipDetails_WebApi()
  {

    var mapObject=getCJHub_SalarySlip_RequestBody(widget.completedEmpCode!);
    serviceRequest(mapObject);
  }

  serviceRequest(Map mapObj)
  {
    print("show the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.get_Salary_Slip,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();

          SalarySlip_ModelResponse salarySlip_ModelResponse=success as SalarySlip_ModelResponse;
          if(salarySlip_ModelResponse.statusCode==true)
          {
            loadSalarySlipData(salarySlip_ModelResponse);
          }

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();
          CJTalentCommonModelClass commonObject= failure as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }
          return ;

        }, talentHandleExceptionBlock: <T>(handleException)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= handleException as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }

        }));
  }

  /*------------24-11-2022 end-------------*/


  loadSalarySlipData(SalarySlip_ModelResponse salarySlip_ModelResponse)
  {
    setState(() {

      companyName=(salarySlip_ModelResponse.data?.salaryComponents![0])
          .toString();

      /* empCode = (salarySlip_ModelResponse.data.salaryComponents[0].empCode)
          .toString();*/


      var salaryComponentObj=salarySlip_ModelResponse.data?.salaryComponents![0];

      empName = salaryComponentObj?.empName;
      designation = salaryComponentObj?.postOffered;
      esic_number = salaryComponentObj?.esinumber;
      pf_number = salaryComponentObj?.pfnumber;
      uan_number = salaryComponentObj?.uannumber;
      pay_days = salaryComponentObj!.paidDays.toString();
      lop_days = salaryComponentObj!.lopdays.toString();

      basic_amount = salaryComponentObj.basic.toString();
      hra = salaryComponentObj.hra.toString();
      pf_amount = salaryComponentObj.pf.toString();
      esic = salaryComponentObj.employeeesirate.toString();
      allowances = salaryComponentObj.allowance.toString();
      nps = salaryComponentObj.nps.toString();
      govt_bonus = salaryComponentObj.govtBonusAmt.toString();
      medical_insurance = salaryComponentObj.insurance.toString();

      /*-----------13-11-2021 start------------*/
      arrears = salaryComponentObj.totalarear.toString();

      if(arrears=="0" || arrears=="" || arrears==null)
      {
        arrears_Visibility=false;
      }
      else
      {
        arrears_Visibility=true;
      }
      /*-----------13-11-2021 end------------*/

      miscellaneous_deductions = salaryComponentObj.other.toString();
      taxes = salaryComponentObj.taxes.toString();
      total_earnings = salaryComponentObj.grossearning.toString();
      total_deductions = salaryComponentObj.grossdeduction.toString();
      net_payable = salaryComponentObj.netpay.toString();
      bank_account_no = salaryComponentObj.bankaccountno;

      /*-----------9-11-2021 start----------*/
      //dob=dob(old)//12-1-2023(dob pending by shiv sir)

      dob=salaryComponentObj.dateofbirth;;

      doj=salaryComponentObj.doj.toString();

      ratebasic = salaryComponentObj.ratebasic.toString();
      ratehra = salaryComponentObj.ratehra.toString();
      ratespecialallowance = salaryComponentObj.ratespecialallowance.toString();
      rategross = salaryComponentObj.rategross.toString();

      arearbasic = salaryComponentObj.arearbasic.toString();
      arearhra = salaryComponentObj.arearhra.toString();
      arearallowance = salaryComponentObj.arearallowance.toString();
      areargross = salaryComponentObj.areargross.toString();


      /*---------------14-10-2022 start--------------*/

      pan_number = salaryComponentObj.pancardnumber.toString();

      String empJobTypeStatus=salaryComponentObj.jobtype.toString();
      String regularEmployeeCode=salaryComponentObj.empCode.toString();
      String contractualEmployeeCode=salaryComponentObj.cjcode.toString();

      if(empJobTypeStatus == "Regular")
      {
        //Regular
        empCode=regularEmployeeCode;
        empCodeTitle="Employee Code";
        dateOfJoiningTitle="DOJ";
      }
      else
      {
        //Contractual
        empCode=contractualEmployeeCode;
        empCodeTitle=getTPCode;
        dateOfJoiningTitle="Deputed Date";
      }


      /*---------------14-10-2022 end--------------*/



      /*-----------9-11-2021 end----------*/

      /*--------show variable  componenets start---------*/


      if (salarySlip_ModelResponse.data?.variableComponent!.length == 1) {

        var firstVariableComponentObj=salarySlip_ModelResponse.data?.variableComponent![0];
        firstVariableComponent_Key = firstVariableComponentObj!.variableName;
        firstVariableComponent_Value = firstVariableComponentObj!.amt.toString();

      }
      else if (salarySlip_ModelResponse.data?.variableComponent!.length == 2)
      {
        first_VariableDeductionComponent_Visibility=true;

        var firstVariableComponentObj=salarySlip_ModelResponse.data?.variableComponent![0];
        var secondVariableComponentObj=salarySlip_ModelResponse.data?.variableComponent![1];


        firstVariableComponent_Key = firstVariableComponentObj!.variableName;
        firstVariableComponent_Value = firstVariableComponentObj.amt.toString();

        secondVariableComponent_Key = secondVariableComponentObj!.variableName;
        secondVariableComponent_Value = secondVariableComponentObj!.amt.toString();

      }
      else if (salarySlip_ModelResponse.data?.variableComponent!.length == 3)
      {
        second_VariableDeductionComponent_Visibility=true;

        var firstVariableComponentObj=salarySlip_ModelResponse.data?.variableComponent![0];
        var secondVariableComponentObj=salarySlip_ModelResponse.data?.variableComponent![1];
        var thirdVariableComponentObj=salarySlip_ModelResponse.data?.variableComponent![2];


        firstVariableComponent_Key = firstVariableComponentObj!.variableName;
        firstVariableComponent_Value = firstVariableComponentObj.amt.toString();

        secondVariableComponent_Key = secondVariableComponentObj!.variableName;
        secondVariableComponent_Value = secondVariableComponentObj!.amt.toString();

        thirdVariableComponent_Key = thirdVariableComponentObj!.variableName;
        thirdVariableComponent_Value = thirdVariableComponentObj!.amt.toString();
      }
      else
      {

      }
      /*--------show variable  componenets end---------*/


      /*--------show deduction componenets start---------*/
      if (salarySlip_ModelResponse.data?.deductionComponent!.length == 1)
      {
        first_VariableDeductionComponent_Visibility=true;

        var firstDeductionComponentObj=salarySlip_ModelResponse.data?.deductionComponent![0];

        firstDeductionComponent_Key = firstDeductionComponentObj!.deductionName;
        firstDeductionComponent_Value = firstDeductionComponentObj!.amt.toString();
      }
      else if (salarySlip_ModelResponse.data?.deductionComponent!.length == 2)
      {
        second_VariableDeductionComponent_Visibility=true;

        var firstDeductionComponentObj=salarySlip_ModelResponse.data?.deductionComponent![0];
        var secondDeductionComponentObj=salarySlip_ModelResponse.data?.deductionComponent![1];

        firstDeductionComponent_Key = firstDeductionComponentObj!.deductionName;
        firstDeductionComponent_Value = firstDeductionComponentObj!.amt.toString();

        secondDeductionComponent_Key = secondDeductionComponentObj!.deductionName;
        secondDeductionComponent_Value = secondDeductionComponentObj!.amt.toString();

      } else {

      }
      /*--------show deduction componenets end---------*/


      headerHeading =
      "Salary Slip for the month of $salaryMonthName ' $salaryYear";

      print("show the headerHeading $headerHeading");



      // print("show the pan_number $pan_number");


    });
  }


  /*----------download salary slip start-----------*/

  PdfSolidBrush getPDFSolidBrush_Color()
  {
    return PdfSolidBrush(PdfColor(30,156,255));
  }
//
  Future<void> _createPDF_SalarySlip(String caseType) async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    /* page.graphics.drawString("Salary Slip for the month of July' 2021",
        PdfStandardFont(PdfFontFamily.helvetica, 15,style: PdfFontStyle.bold),
        );*/

    page.graphics.drawImage(
        PdfBitmap(await _readImageData(getCJHub_AkalLogo)),
        Rect.fromLTWH(0, 0, 70, 50));

    PdfGrid gridAdress = PdfGrid();
    gridAdress.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 14),
        cellPadding: PdfPaddings(left: 5, right: 5, top: 2));

    gridAdress.columns.add(count: 2);
    PdfGridRow rowAdress = gridAdress.rows.add();
    gridAdress.columns[0].width = 100;
    rowAdress.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      top: PdfPens.transparent,
      right: PdfPens.transparent,
    );
    rowAdress.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(
          PdfFontFamily.helvetica, 16, style: PdfFontStyle.bold),
    );
    rowAdress.cells[1].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      top: PdfPens.transparent,
      right: PdfPens.transparent,
    );
    // grid.rows[0].height = 100;
    rowAdress.cells[1].stringFormat.alignment = PdfTextAlignment.right;
    rowAdress.cells[0].rowSpan = 2;
    rowAdress.cells[0].value = "";
    rowAdress.cells[1].value = 'Akal Information Systems Ltd.';


    rowAdress = gridAdress.rows.add();
    gridAdress.columns[0].width = 100;
    rowAdress.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 10),
    );
    rowAdress.cells[1].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      right: PdfPens.transparent,
      top: PdfPens.transparent,
    );
    rowAdress.cells[1].stringFormat.alignment = PdfTextAlignment.right;
    // row.cells[0].value = '';
    rowAdress.cells[1].value =
    "Jet Air House,Community Centre, Yusuf Sarai,""\nNew Delhi, Delhi 110049. Ph: 011-46503545";


    PdfGrid grid0 = PdfGrid();
    grid0.style = PdfGridStyle(
        font: PdfStandardFont(
            PdfFontFamily.helvetica, 14, style: PdfFontStyle.bold),
        cellPadding: PdfPaddings(left: 5, right: 5, top: 2));

    grid0.columns.add(count: 1);
    PdfGridRow row0 = grid0.rows.add();
    row0.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      top: PdfPens.transparent,
      left: PdfPens.transparent,
      right: PdfPens.transparent,);
    row0.cells[0].value = headerHeading;


    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 14),
        cellPadding: PdfPaddings(left: 5, right: 5, top: 2));

    grid.columns.add(count: 6);

    PdfGridRow row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[3].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[3].style.borders = PdfBorders(
      bottom: PdfPens.transparent,);
    row.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,);
    row.cells[0].columnSpan = 3;
    row.cells[3].columnSpan = 3;
    //row.cells[0].value = 'Employee Code';
    row.cells[0].value = empCodeTitle;
    row.cells[3].value = 'Employee Name';

    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[3].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[3].style.borders = PdfBorders(
      top: PdfPens.transparent,);
    row.cells[0].style.borders = PdfBorders(
      top: PdfPens.transparent,);
    row.cells[0].columnSpan = 3;
    row.cells[3].columnSpan = 3;
    row.cells[0].value = empCode;
    row.cells[3].value = empName;


    /*-------------date of joining and date of birth start 9-11-2021 ----------*/

    row = grid.rows.add();


    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, title_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[3].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[3].style.borders = PdfBorders(
      bottom: PdfPens.transparent,);
    row.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,);

    row.cells[0].columnSpan = 3;
    row.cells[3].columnSpan = 3;
    row.cells[0].value = dateOfJoiningTitle;
    row.cells[3].value = 'DOB';

    row = grid.rows.add();
    row.cells[3].style.borders = PdfBorders(
      top: PdfPens.transparent,);
    row.cells[0].style.borders = PdfBorders(
      top: PdfPens.transparent,);
    row.cells[0].columnSpan = 3;
    row.cells[3].columnSpan = 3;
    row.cells[0].value = doj;
    row.cells[3].value = dob;

    /*-------------date of joining and date of birth start 9-11-2021 ----------*/


    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[3].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[3].style.borders = PdfBorders(
      bottom: PdfPens.transparent,);
    row.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,);
    row.cells[0].columnSpan = 3;
    row.cells[3].columnSpan = 3;
    row.cells[0].value = 'Designation';
    row.cells[3].value = 'ESIC Number';

    row = grid.rows.add();
    row.cells[3].style.borders = PdfBorders(
      top: PdfPens.transparent,);
    row.cells[0].style.borders = PdfBorders(
      top: PdfPens.transparent,);
    row.cells[0].columnSpan = 3;
    row.cells[3].columnSpan = 3;
    row.cells[0].value = designation;
    row.cells[3].value = esic_number;

    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[3].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[3].style.borders = PdfBorders(
      bottom: PdfPens.transparent,);
    row.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,);
    row.cells[0].columnSpan = 3;
    row.cells[3].columnSpan = 3;
    row.cells[0].value = 'PF Number';
    row.cells[3].value = 'UAN Number';

    row = grid.rows.add();
    row.cells[3].style.borders = PdfBorders(
      top: PdfPens.transparent,);
    row.cells[0].style.borders = PdfBorders(
      top: PdfPens.transparent,);
    row.cells[0].columnSpan = 3;
    row.cells[3].columnSpan = 3;
    row.cells[0].value = pf_number;
    row.cells[3].value = uan_number;

    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[3].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[3].style.borders = PdfBorders(
      bottom: PdfPens.transparent,);
    row.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,);
    row.cells[0].columnSpan = 3;
    row.cells[3].columnSpan = 3;
    row.cells[0].value = 'Pay Days';
    row.cells[3].value = 'LOP Days';

    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[3].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[3].style.borders = PdfBorders(
      top: PdfPens.transparent,);
    row.cells[0].style.borders = PdfBorders(
      top: PdfPens.transparent,);
    row.cells[0].columnSpan = 3;
    row.cells[3].columnSpan = 3;
    row.cells[0].value = pay_days;
    row.cells[3].value = lop_days;

    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 13),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[0].columnSpan = 3;
    row.cells[3].columnSpan = 3;
    row.cells[0].value = 'PAN No.';
    row.cells[3].value = pan_number;


    /*---------use for space start-----------*/
    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
        cellPadding: PdfPaddings(top: 20)
    );
    row.cells[3].style = PdfGridCellStyle(
        cellPadding: PdfPaddings(top: 20)
    );
    row.cells[3].style.borders = PdfBorders(
        top: PdfPens.transparent,
        bottom: PdfPens.transparent,
        right: PdfPens.transparent,
        left: PdfPens.transparent);
    row.cells[0].style.borders = PdfBorders(
        top: PdfPens.transparent,
        bottom: PdfPens.transparent,
        right: PdfPens.transparent,
        left: PdfPens.transparent);
    row.cells[0].columnSpan = 3;
    row.cells[3].columnSpan = 3;
    row.cells[0].value = '';
    row.cells[3].value = '';

    /*---------use for space end-----------*/


    row = grid.rows.add();
    row.cells[0].columnSpan = 4;
    row.cells[4].columnSpan = 2;
    row.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[4].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, title_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[4].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, title_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[0].value = 'Earnings';
    row.cells[4].value = 'Deductions';

    row = grid.rows.add();
    row.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[1].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[2].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[3].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[4].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[5].stringFormat.alignment = PdfTextAlignment.center;


    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, title_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, title_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[2].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, title_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[3].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, title_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[4].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, title_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[5].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, title_TextFontSize,
          style: PdfFontStyle.bold),
    );

    row.cells[0].value = 'Heads';
    row.cells[1].value = 'Monthly Rate';
    row.cells[2].value = 'Earnings';
    row.cells[3].value = 'Arrears';
    row.cells[4].value = 'Head';
    row.cells[5].value = 'Amount';


    row = grid.rows.add();
    row.cells[4].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[3].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
    );
    row.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
    );

    row.cells[0].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[1].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[2].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[3].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[4].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[5].stringFormat.lineAlignment = PdfVerticalAlignment.middle;

    row.cells[0].value = 'Basic';
    row.cells[1].value = ratebasic;
    row.cells[2].value = basic_amount;
    row.cells[3].value = arearbasic;
    row.cells[4].value = 'Provident'"\nFund";
    row.cells[5].value = pf_amount;

    row = grid.rows.add();
    row.cells[4].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[0].value = 'HRA';
    row.cells[1].value = ratehra;
    row.cells[2].value = hra;
    row.cells[3].value = arearhra;
    row.cells[4].value = 'ESIC';
    row.cells[5].value = esic;

    row = grid.rows.add();
    row.cells[4].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[0].value = 'Allowances';
    row.cells[1].value = ratespecialallowance;
    row.cells[2].value = allowances;
    row.cells[3].value = arearallowance;
    row.cells[4].value = 'NPS';
    row.cells[5].value = nps;

    row = grid.rows.add();
    row.cells[4].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[3].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
    );
    row.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
    );
    row.cells[0].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[1].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[2].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[3].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[4].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[5].stringFormat.lineAlignment = PdfVerticalAlignment.middle;

    row.cells[0].value = 'Govt.Bonus';
    row.cells[1].value = '';
    row.cells[2].value = govt_bonus;
    row.cells[3].value = '';
    row.cells[4].value = 'Medical'"\nInsurance";
    row.cells[5].value = medical_insurance;

    row = grid.rows.add();
    row.cells[4].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[3].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
    );
    row.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
    );
    row.cells[0].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[1].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[2].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[3].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[4].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[5].stringFormat.lineAlignment = PdfVerticalAlignment.middle;

    /*-----------13-11-2021 start--------------*/

    if (arrears == "0" || arrears=="" || arrears==null) {
      row.cells[0].value = '';
      row.cells[1].value = '';
      row.cells[2].value = '';
      row.cells[3].value = '';
    }
    else {
      //Note 14-12-2021 --Arrears replace by Incentive
      row.cells[0].value = 'Incentive';
      row.cells[1].value = '';
      row.cells[2].value = arrears;
      row.cells[3].value = '';
    }

    row.cells[4].value = 'Miscellaneous'"\nDeductions";
    row.cells[5].value = miscellaneous_deductions;


    /*-----------13-11-2021 end--------------*/


    row = grid.rows.add();
    row.cells[4].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[0].value = firstVariableComponent_Key;
    row.cells[1].value = '';
    row.cells[2].value = firstVariableComponent_Value;
    row.cells[3].value = '';
    row.cells[4].value = 'Taxes';
    row.cells[5].value = taxes;

    /*--------------------13-11-2021 start----------------------*/
    if(first_VariableDeductionComponent_Visibility)
    {
      row = grid.rows.add();
      row.cells[4].style = PdfGridCellStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
        textBrush: getPDFSolidBrush_Color(),
      );
      row.cells[0].value = secondVariableComponent_Key;
      row.cells[1].value = '';
      row.cells[2].value = secondVariableComponent_Value;
      row.cells[3].value = '';
      row.cells[4].value = firstDeductionComponent_Key;
      row.cells[5].value = firstDeductionComponent_Value;
    }

    if(second_VariableDeductionComponent_Visibility)
    {
      row = grid.rows.add();
      row.cells[4].style = PdfGridCellStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize),
        textBrush: getPDFSolidBrush_Color(),
      );
      row.cells[0].value = thirdVariableComponent_Key;
      row.cells[1].value = '';
      row.cells[2].value = thirdVariableComponent_Value;
      row.cells[3].value = '';
      row.cells[4].value = secondDeductionComponent_Key;
      row.cells[5].value = secondDeductionComponent_Value;
    }
    /*--------------------13-11-2021 end----------------------*/


    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, title_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[2].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[3].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[4].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, title_TextFontSize,
          style: PdfFontStyle.bold),
    );

    row.cells[5].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize,
          style: PdfFontStyle.bold),
    );

    row.cells[0].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[1].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[2].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[3].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[5].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[4].stringFormat.lineAlignment = PdfVerticalAlignment.middle;

    row.cells[0].value = 'Total Earnings'"\n(Gross)";
    row.cells[1].value = rategross;
    row.cells[2].value = total_earnings;
    row.cells[3].value = areargross;
    row.cells[4].value = 'Total'"\nDeductions";
    row.cells[5].value = total_deductions;

    row = grid.rows.add();

    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize,
          style: PdfFontStyle.bold),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[3].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize,
          style: PdfFontStyle.bold),
    );


    row.cells[0].columnSpan = 3;
    row.cells[3].columnSpan = 3;
    row.cells[0].value = 'Net Payable';
    row.cells[3].value = net_payable;


    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize,
          style: PdfFontStyle.bold),
      textBrush: getPDFSolidBrush_Color(),
    );
    row.cells[3].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize,
          style: PdfFontStyle.bold),
    );

    row.cells[0].columnSpan = 3;
    row.cells[3].columnSpan = 3;
    row.cells[0].value = 'Bank A/c No.';
    row.cells[3].value = bank_account_no;

    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, subtitle_TextFontSize,
          style: PdfFontStyle.bold),
    );
    row.cells[0].columnSpan = 6;
    row.cells[0].value =
    'Disclaimer: This is a system generated payslip, does not require any signature.';


    gridAdress.draw(
        page: page, bounds: Rect.fromLTWH(
        0, 0, 0, 0));
    grid0.draw(
        page: page, bounds: Rect.fromLTWH(
        0, 60, 0, 0));
    grid.draw(
        page: page, bounds: Rect.fromLTWH(
        0, 90, 0, 0));

    List<int> bytes = await document.save();
    document.dispose();

    String salarySlipName = salaryMonthName + "_" + salaryYear;
    String dynamicFileName = "Akal_Salary_Slip_" + salarySlipName + ".pdf";

    saveAndLaunchFile(bytes, dynamicFileName, caseType);
  }


  Future<Uint8List> _readImageData(String name) async
  {
    //final data = await rootBundle.load('assets/$name');
    final data = await rootBundle.load('$name');

    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }


}