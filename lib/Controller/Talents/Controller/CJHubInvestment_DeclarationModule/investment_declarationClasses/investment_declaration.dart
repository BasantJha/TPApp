import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';

import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../CustomView/CJHubCustomView/NetworkStatus/NetworkReachability.dart';
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../CJHubInvestment_UploadDocumentModule/Investment_UploadDocumentClasses/UploadInvestmentProof.dart';
import '../ModelClasses/InvestmentDeclaration_RegimeType_ModelResponse.dart';
import '../ModelClasses/InvestmentDeclaration_TaxCalculate_ModelResponse.dart';
import '../investment_declarationUI/Investment_DeclarationUI.dart';
import 'investmentDeclaration_tax_section.dart';


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
      home: investment_declaration(title: 'CJ Hub'),
    );
  }
}
class investment_declaration extends StatefulWidget {

  investment_declaration({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _investment_declaration createState() => _investment_declaration();
}

class _investment_declaration extends State<investment_declaration> {

  String empCode="",panNumber="",empName="";
  String totalIncome="",totalSaving="",taxableIncome="",totalTax="",taxDeduction="",balanceTax="",taxSlab="";
  String investmentDeclaration_Alert="Investment Declaration Open Between xxx To xxx";

  //String completeEmpCode="9569734648CJHUB5610CJHUB14/05/1988";
  String completeEmpCode="";

  String empId="",empIPAddress="";

  InvestmentDeclaration_RegimeType_ModelResponse? investmentDeclaration_RegimeType_ModelResponse;
  String financialYear="2021-2022";

  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;

  /*--------11-10-2022 START----------*/
  String empJobType="",empCodeTitle="",cjCode="";
  /*--------11-10-2022 END----------*/


  @override
  void initState() {
    super.initState();

    if(!networkStatus){
      print("Api salary status should be called");
      taxRegimeRequest();
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

  // This widget is the root of your application.
  bool taxCalNewRegime_visible=true,investmentButton_Visible=true;
  String regimeType = 'Old Regime';
  int id = 1;

  String btnTitleFor_DeclareAndUploadInvestment="CLICK HERE TO DECLARE INVESTMENT";
  String checkDeclareType="";

  Color bannerTextColorType=bannerTextColor;

  @override
  Widget build(BuildContext context) {
  var size = MediaQuery.of(context).size;
    return Scaffold(

        backgroundColor: Colors.white,
        appBar:CJAppBar(getCJHUB_InvestmentDeclarationTitle, appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action 1type");
          Navigator.pop(context);

        })),
        body: WillPopScope(
          child: Responsive(
            mobile: mainFunction_investmentDeclarationUI(),
            tablet: Center(
             child:  Container(
              width: size.width*investmentDeclaration_tabletWidth,
              child:mainFunction_investmentDeclarationUI(),
             )
            ),
            desktop: Center(
              child: Container(
                width: size.width*investmentDeclaration_desktopWidth,
                child: mainFunction_investmentDeclarationUI(),
              ),
            )

          ),
          onWillPop: () async => false,

          /*onWillPop: ()
          {
            Message.alert_dialogAppExit(context);

          } ,*/
        )
    );
  }
  SingleChildScrollView mainFunction_investmentDeclarationUI(){
    return SingleChildScrollView(
      child:
      Column(children: <Widget>[

        Investment_DeclarationUI.create_headingContainer("Investment Declartion F.Y($financialYear)" ),
        // name of Investment Declaration year
        Investment_DeclarationUI.create_salaryBannerContainer(investmentDeclaration_Alert,bannerTextColorType),

        create_empCodePanTxtContainer(empCodeTitle,'PAN No.'),

        /*---------------11-10-2022 start-----------------*/
        create_empCodePanButtonContainer(empCode, panNumber),
        /*---------------11-10-2022 end-----------------*/


        create_empNameRadioButtonContainer('Emp Name', empName),

        create_dataTable_1(),

        Investment_DeclarationUI.create_Text('Value for Reference Only.'),

        Visibility(
          visible: taxCalNewRegime_visible,
          child: Investment_DeclarationUI.create_TaxCalculated('Tax will be Calculated as per New Regime'),),

        Visibility(
          visible: investmentButton_Visible,
          child: create_Button(),),

        // create_Button(),

        SizedBox(
          height: 60,
        ),

      ],
      ),
    );
  }

Container create_empCodePanTxtContainer(String key1, String key2){
  return Container(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(10,0,10,5),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(key1,style: TextStyle(color: primaryColor,fontSize: 15),),
                      ),
                    ]
                ),
              ),



          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 84),
                        child:Text(key2,textAlign:TextAlign.start,style: TextStyle(color: primaryColor,fontSize: 15),) ,

                  )
                ],
              ),

            ],
          ),

        ],
      ),
    ),
  );
}

  Container create_empCodePanButtonContainer(String value1, String value2){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,0,10,10),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Expanded(
              flex: 1,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30.0),
                      ),

                      child:Padding(
                        padding: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                        child: Text(value1,style: TextStyle(fontFamily: 'Vonique',color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                      )

                  )



                ],
              ),
            ),



            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Container(
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30.0),
                      ),

                      child:Padding(
                        padding: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                        child: Text(value2,style: TextStyle(fontFamily: 'Vonique',color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                      )

                  )



                ],
              ) ,
            )
            ,



          ],
        ),
      ),
    );
  }


  Container create_empNameRadioButtonContainer(String key, String value){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,0,10,5),
        child:  Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child:  Container(
                width: MediaQuery.of(context).size.width*0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(key,style: TextStyle(color: primaryColor,fontSize: 15),),
                    SizedBox(
                      height: 5,
                    ),

                    Container(
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(30.0),
                        ),

                        child:Padding(
                          padding: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                          child: Text(value,style: TextStyle(fontFamily: 'Vonique',color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                        )

                    )



                  ],
                ),
              )
              ,
            ),


             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 1,
                      activeColor: radiobuttonColor,
                      groupValue: id,
                      onChanged: (val) {
                        setState(()
                        {
                          /*-------------18-2-2022 start-----------*/
                          checkDateExistsorNotFor_NewRegime("Old");
                          /*-------------18-2-2022 end-----------*/


                        });
                      },
                    ),


                    Text(
                      'Old Regime:',textAlign: TextAlign.center,
                      style: new TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),


                SizedBox(
                  width: 4,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 2,
                      activeColor: radiobuttonColor,
                      groupValue: id,
                      onChanged: (val)
                      {
                        setState(()
                        {
                          checkDateExistsorNotFor_NewRegime("New");
                        });
                      },
                    ),
                    Text(
                      'New Regime:',textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                )



              ],
            )
            ,



          ],
        ),


      ),
    );
  }

  Column create_dataTable_1(){
    return
      Column(
          children: <Widget>[
            Container(
              // padding: EdgeInsets.fromLTRB(15.0, 0, 5.0, 0),
              margin: EdgeInsets.all(10),
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(2),
                },
                border: TableBorder(horizontalInside: BorderSide(width: 1, color: threeHunGreyColor),
                  right: BorderSide(width: 1, color: threeHunGreyColor),
                  top: BorderSide(width: 1, color: threeHunGreyColor),
                  bottom: BorderSide(width: 1, color: threeHunGreyColor),
                  left: BorderSide(width: 1, color: threeHunGreyColor),),
                children: [
                  TableRow(children: [
                    Investment_DeclarationUI.create_dataTableSub1('Total Income',),
                    Investment_DeclarationUI.create_dataTableSub1(totalIncome,)
                  ]),
                  TableRow(children: [
                    Investment_DeclarationUI.create_dataTableSub1('Total Saving',),
                    Investment_DeclarationUI.create_dataTableSub1(totalSaving,),
                  ]),
                  TableRow(children: [
                    Investment_DeclarationUI.create_dataTableSub1('Taxable Income',),
                    Investment_DeclarationUI.create_dataTableSub1(taxableIncome,),
                  ]),
                  TableRow(children: [
                    Investment_DeclarationUI.create_dataTableSub1('Total Tax',),
                    Investment_DeclarationUI.create_dataTableSub1(totalTax,),
                  ]),
                  TableRow(children: [
                    Investment_DeclarationUI.create_dataTableSub1('Tax Deducted',),
                    Investment_DeclarationUI.create_dataTableSub1(taxDeduction,),
                  ]),
                  TableRow(children: [
                    Investment_DeclarationUI.create_dataTableSub1('Balance Tax Payable/Refund',),
                    Investment_DeclarationUI.create_dataTableSub1(balanceTax,),
                  ]),
                  TableRow(children: [
                    Investment_DeclarationUI.create_dataTableSub1('Tax Slab',),
                    Investment_DeclarationUI.create_dataTableSub1(taxSlab,),
                  ]),
                ],
              ),
            ),
          ]);
  }




  Material create_Button()
  {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5.0),
      color: primaryColor,

      child:MaterialButton(
          minWidth: 120,
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
          onPressed: ()
          {

            /*-------------14-12-2021 START-----------*/
            if(checkDeclareType=="P")
            {
              /*----use for upload investment proof(P)-------*/
              Navigator.push(context, MaterialPageRoute(builder: (_)=>

                  Responsive(
                      mobile: UploadInvestmentProof(),
                      tablet: Center(
                        child: Container(
                          width: flutterWeb_tabletWidth,
                          child: UploadInvestmentProof(),
                        ),
                      ),
                      desktop: Center(
                        child: Container(
                          width: flutterWeb_desktopWidth,
                          child: UploadInvestmentProof(),
                        ),
                      )
                  )
                // UploadInvestmentProof()

              ));
            }
            else
            {
              /*--------------13-07-2022 comment the line for testing proof start-----------*/

              /*----use for upload investment proof(P)-------*/

              // Navigator.push(context, MaterialPageRoute(builder: (_)=>
              //
              // Responsive(
              //     mobile: UploadInvestmentProof(),
              //     tablet: Center(
              //       child: Container(
              //         width: flutterWeb_tabletWidth,
              //         child: UploadInvestmentProof(),
              //       ),
              //     ),
              //     desktop: Center(
              //       child: Container(
              //         width: flutterWeb_desktopWidth,
              //         child: UploadInvestmentProof(),
              //       ),
              //     )
              // )
              //     // UploadInvestmentProof()
              //
              // ));

              /*----use for upload investment proof(D)-------*/

              Navigator.push(context, MaterialPageRoute(builder: (_)=>

                  Responsive(
                    mobile: investmentDeclaration_tax_section(),
                    tablet: Center(
                      child: Container(
                        width: flutterWeb_tabletWidth,
                        child: investmentDeclaration_tax_section(),
                      ),
                    ),
                    desktop: Center(
                      child: Container(
                        width: flutterWeb_desktopWidth,
                        child: investmentDeclaration_tax_section(),
                      ),
                    ),
                  )
                  // investmentDeclaration_tax_section()
              ));

              /*--------------13-07-2022 comment the line for testing proof end-----------*/


            }
            /*-------------14-12-2021 END-----------*/

          },
          child: Text(btnTitleFor_DeclareAndUploadInvestment,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 15))

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
      taxRegimeRequest();
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
          taxRegimeRequest()
        }
      else
        {
          // //print('please check the network status'),
          showNetworConnectionAlert()
        }
    });*/
    //taxRegimeRequest();
  }

  /*--------23-4-2022 start---------*/
  loadFinancialYear(String fYear)
  {
    setState(() {
      financialYear=fYear;

    });
  }
  /*--------23-4-2022 end---------*/

  taxRegimeRequest()
  {

    SharedPreference.getIncomeTax_HeadsFinancialYear().then((value) =>  {
      financialYear=value,
      // //print('show emp getIncomeTax_HeadsFinancialYear $value'),
      loadFinancialYear(financialYear)
    });


    SharedPreference.getEmpPanCardNumber().then((value) =>  {
      panNumber=value,
      // //print('show emp name2 $value'),
      //loadData()
    });
    SharedPreference.getEmpName().then((value) =>  {
      empName=value,
      // //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpId().then((value) =>  {
      empId=value,
      // //print('show emp name2 $value'),
      //loadData()
    });
    Method.getIPAddress().then((value) => {
      empIPAddress=value

    });



    String mobileNumber_key="",empCode_key="",
        empDateOfBirth_key="";

    SharedPreference.getEmpMobileNo().then((value) =>  {
      mobileNumber_key=value,
      // //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpCode().then((value) =>  {
      empCode_key=value,
      empCode=value,
      // //print('show emp name2 $value'),
      //loadData()
    });

    /*-----------11-10-2022 start----------*/
    SharedPreference.get_CJCode().then((value) =>  {
      print('show emp cjCode $value'),
      cjCode=value,
    });

    SharedPreference.getEmpJobType().then((value) =>  {
      //print('show emp name2 $value'),
      empJobType=value,
      loadThe_EmpTitle()
      // ignore: unrelated_type_equality_checks
    });
    /*-----------11-10-2022 end----------*/

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth_key=value,
      // //print('show emp name2 $value'),
      completeEmpCode = mobileNumber_key+"CJHUB"+empCode_key+"CJHUB"+empDateOfBirth_key,
      this.getTax_RegimeType()


    });

  }

  loadThe_EmpTitle()
  {
    setState(() {

      /*---------11-10-2022 start---------*/
      if(empJobType == "Regular")
      {
        //Regular
        empCode=empCode;
        empCodeTitle="Emp Code";
      }
      else
      {
        //Contractual
        empCode=cjCode;
        empCodeTitle="CJ Code";
      }
      /*---------11-10-2022 end---------*/
    });
  }
  // ignore: non_constant_identifier_names
  getTax_RegimeType() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.tax_get_Emp_RegimeType),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'financial_year': financialYear

        },
      );
      // //print(response.statusCode);
      if (response.statusCode == 200)
      {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        // //print(response.body);

        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        investmentDeclaration_RegimeType_ModelResponse = InvestmentDeclaration_RegimeType_ModelResponse.fromJson(jsonDecode(serverResponse));


        if(investmentDeclaration_RegimeType_ModelResponse!.statusCode==true)
        {
          checkRegimeTypeAnd_LoadData(investmentDeclaration_RegimeType_ModelResponse!.data!.regimeType,investmentDeclaration_RegimeType_ModelResponse!);

          getTaxCalculation_Api(investmentDeclaration_RegimeType_ModelResponse!.data!.regimeType);
        }
        else
        {
          if (investmentDeclaration_RegimeType_ModelResponse!.message==null)
          {

            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, investmentDeclaration_RegimeType_ModelResponse!.message);
            // show_OKAlert(investmentDeclaration_RegimeType_ModelResponse.message);

          }
        }
        //return _verify_mobile_modelResponse;

      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      // //print(e);
    }
  }

  getTaxCalculation_Api(String regimeType) async
  {

    String financial_year=financialYear;
    String regimeType1=regimeType;
    String empcode=getEncrypted_EmpCode(completeEmpCode);

    // //print('show emp financial_year $financial_year');
    // //print('show emp regimeType1 $regimeType1');
    // //print('show emp code encrypted $empcode');
    //
    // //print('show emp code $completeEmpCode');
    // EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.get_Tax_Calculation),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'financial_year': financialYear,
          'regime': regimeType,
          'emp_code': getEncrypted_EmpCode(completeEmpCode),

        },
      );
      // //print(response.statusCode);
      if (response.statusCode == 200)
      {
        //EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        // //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        InvestmentDeclaration_TaxCalculate_ModelResponse investmentDeclaration_TaxCalculate_ModelResponse = InvestmentDeclaration_TaxCalculate_ModelResponse.fromJson(jsonDecode(serverResponse));


        if(investmentDeclaration_TaxCalculate_ModelResponse.statusCode==true)
        {
          loadData(investmentDeclaration_TaxCalculate_ModelResponse);
        }
        else
        {
          if (investmentDeclaration_TaxCalculate_ModelResponse.message==null)
          {
            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, investmentDeclaration_TaxCalculate_ModelResponse.message);
            // show_OKAlert(investmentDeclaration_TaxCalculate_ModelResponse.message);

          }
        }
        //return _verify_mobile_modelResponse;

      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      // //print(e);
    }
  }

  saveTaxRegimeType_Api(String regimeType) async
  {

    // //print('show emp code $empCode');
    // EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.tax_save_Emp_RegimeType),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'financial_year': financialYear,
          'regime_type': regimeType,
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'created_by': empId,
          'emp_ip':empIPAddress


        },
      );
      // //print(response.statusCode);
      if (response.statusCode == 200)
      {
        //EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        // //print(response.body);

        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        InvestmentDeclaration_TaxCalculate_ModelResponse investmentDeclaration_TaxCalculate_ModelResponse = InvestmentDeclaration_TaxCalculate_ModelResponse.fromJson(jsonDecode(serverResponse));


        if(investmentDeclaration_TaxCalculate_ModelResponse.statusCode==true)
        {
          //show_OKAlert(investmentDeclaration_TaxCalculate_ModelResponse.message);
          getTax_RegimeType();

        }
        else
        {
          if (investmentDeclaration_TaxCalculate_ModelResponse.message==null)
          {
            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, investmentDeclaration_TaxCalculate_ModelResponse.message);
            // show_OKAlert(investmentDeclaration_TaxCalculate_ModelResponse.message);

          }
        }
        //return _verify_mobile_modelResponse;

      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      // //print(e);
    }
  }

  loadData(InvestmentDeclaration_TaxCalculate_ModelResponse response)
  {
    setState(() {
      var responseObj=response.data!;
      totalIncome=responseObj.totalIncome;
      totalSaving=responseObj.totalSavings;
      taxableIncome=responseObj.taxableIncome;
      totalTax=responseObj.netPayableTax;
      taxDeduction=responseObj.taxDeducted;
      balanceTax=responseObj.balanceTax;
      taxSlab=responseObj.taxSlab;


    });
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
   /* var alertDialog = AlertDialog(
      content: Text(message,
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

    );*/
  }

  /*--use for when current date exists in the declaration date then change the New Regime otherwise user interation disable-10-12-2021 start------*/
  checkDateExistsorNotFor_NewRegime(String regimeType)
  {
    String getCurrentMessage = investmentDeclaration_RegimeType_ModelResponse!.data!.declarationMessage;
    if (getCurrentMessage=="")
    {

    }
    else
    {
      var currentStringArray = getCurrentMessage.split(" ");
      String getInvestmentDeclaration_EndDate = currentStringArray[currentStringArray.length - 1];

      String getInvestmentDeclaration_EndDate_ValidFormat=Method.changeTheDateFormat_ForInvestmentDeclaration(getInvestmentDeclaration_EndDate);
      String currentDate=Method.getTheCurrentDate_ForInvestmentDeclaration();

      if (int.parse(getInvestmentDeclaration_EndDate_ValidFormat)>=(int.parse(currentDate)))
      {

        /*----------P means Proof(upload document) user not allow the New Regime) 18-2-2022------------*/
        if(checkDeclareType=="P")
        {
          // //print("show regime type P $regimeType");

        }
        else
        {
          /*---------D means declaration user click on the new regime 18-2-2022--------*/


          /*------------------13-07-2022 comment the line start------------*/
          // //print("show regime type D $regimeType");
          regime_Popup(regimeType);

          // //print("show regime type P $regimeType");

          /*------------------13-07-2022 comment the line end------------*/
        }

      }
      else
      {

      }

    }
  }
  /*--use for when current date exists in the declaration date then change the New Regime otherwise user interation disable-10-12-2021 end------*/

  regime_Popup(String regimeType)
  {
    var alertDialog = AlertDialog(
      content: Text('Are you sure, you want to change the Regime?',
        textAlign: TextAlign.center,),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [

        TextButton(onPressed: ()
        {
          Navigator.of(context).pop();

          checkRegimeTypeAnd_LoadData(
              investmentDeclaration_RegimeType_ModelResponse!.data!.regimeType,
              investmentDeclaration_RegimeType_ModelResponse!);

        },
          child: Text("CANCEL",
            textAlign: TextAlign.center,style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
        SizedBox(width: 20.0),

        TextButton(onPressed: (){setState(()
        {
          Navigator.of(context).pop();

          saveTaxRegimeType_Api(regimeType);

        });},
          child: Text("OK",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
      ],

    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => alertDialog
    );
  }

  checkRegimeTypeAnd_LoadData(String regimeType,InvestmentDeclaration_RegimeType_ModelResponse dataModel)
  {
    setState(() {

      investmentDeclaration_Alert=dataModel.data!.declarationMessage;

      if(regimeType=="Old")
      {
        /*-----------11-11-2021 start--------------*/
        String getCurrentMessage = dataModel.data!.declarationMessage;
        if (getCurrentMessage=="")
        {

        }
        else
        {
          var currentStringArray = getCurrentMessage.split(" ");
          String getInvestmentDeclaration_EndDate = currentStringArray[currentStringArray.length - 1];

          String getInvestmentDeclaration_EndDate_ValidFormat=Method.changeTheDateFormat_ForInvestmentDeclaration(getInvestmentDeclaration_EndDate);
          String currentDate=Method.getTheCurrentDate_ForInvestmentDeclaration();

          if (int.parse(getInvestmentDeclaration_EndDate_ValidFormat)>=(int.parse(currentDate)))
          {
            investmentButton_Visible=true;
            bannerTextColorType=bannerTextColor;
            checkDeclareType=dataModel.data!.declarationOrProof;
            /*---use for current date  exists into the declaration date start------*/

            //9-12-2021 START
            if(checkDeclareType=="P")
            {
              /*----use for upload investment proof(P)-------*/
              btnTitleFor_DeclareAndUploadInvestment="CLICK HERE TO Upload INVESTMENT";
            }
            else
            {
              /*----use for  investment declaration(D)------*/

              /*--------------13-07-2022 comment the line for testing proof start-----------*/

              // btnTitleFor_DeclareAndUploadInvestment="CLICK HERE TO Upload INVESTMENT";

              btnTitleFor_DeclareAndUploadInvestment="CLICK HERE TO DECLARE INVESTMENT";

              /*--------------13-07-2022 comment the line for testing proof end-----------*/

            }
            //9-12-2021 END


          }
          else
          {
            /*---use for current date not exists into the declaration date start------*/
            investmentButton_Visible=false;
            bannerTextColorType=addLightGrayColor;

//USE FOR TESTING PURPOSE 13-12-2021 START

            //investmentButton_Visible=true;
            //btnTitleFor_DeclareAndUploadInvestment="CLICK HERE TO Upload INVESTMENT";

//USE FOR TESTING PURPOSE 13-12-2021 END

          }
        }

        /*-----------11-11-2021 end--------------*/
        taxCalNewRegime_visible=false;
        regimeType = 'Old Regime';
        id = 1;

      }
      else
      {
        //new
        taxCalNewRegime_visible=true;
        investmentButton_Visible=false;
        regimeType = 'New Regime';
        id = 2;
      }

    });

  }


}