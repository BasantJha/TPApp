import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;


import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../CustomView/CJHubCustomView/NetworkStatus/NetworkReachability.dart';
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';

import '../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../ModelClasses/Investment_Declaration_ChapterVI_ModelResponse.dart';

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
      home: investmentDeclaration_US80C(title: 'CJ Hub'),
    );
  }
}
class investmentDeclaration_US80C extends StatefulWidget {

  investmentDeclaration_US80C({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _investmentDeclaration_US80C createState() => _investmentDeclaration_US80C();
}

class _investmentDeclaration_US80C extends State<investmentDeclaration_US80C> {
  // This widget is the root of your application.
  bool _visible = true;
  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;


  List<SectionInvestmentHeadList> sectionDataList=[SectionInvestmentHeadList(investmentName: "NPS 80CCD (i)",investmentAmount: "10")];


  List<TextEditingController> _controllers = [];
  String displayName="";
  bool _isEnabled = false;
  bool _isEnabledForList = false;


  String completeEmpCode="",financialYear="",headId="";
  String update_InvestmentAmount="";
  String empIp="",empUserId="",parentSeniorCitizen="",disabilityMoreThan80="",empWithSevereDisability="";

  String totalDeclarationAmount="0",maxBenefitLimitOfAmount="0";

  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(!networkStatus){
      print("Api salary status should be called");
      chapter80CApiRequest();
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

ListView mainFunction_US80C_UI(){
    return ListView.builder(

        itemCount: sectionDataList.length+2,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index)
        {
          _controllers.add(new TextEditingController());

          if(index==sectionDataList.length+1)
          {

            return Container(
              child: Card(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
                child: Container(child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text("Total Declaration Amount:",
                                style: new TextStyle(
                                    fontSize: 12.0)),
                            ),

                            Expanded(
                              flex: 1,
                              child:SizedBox(
                                width: 10,
                              ) ,
                            ),

                            Expanded(
                              flex: 1,
                              child: Text(totalDeclarationAmount,
                                style: new TextStyle(color: primaryColor,
                                    fontSize: 14.0)),
                            )

                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [

                            Expanded(
                              flex: 1,
                              child:  Text("(Max. Benefit Limit of 80C is 1.5 Lakh):",
                                style: new TextStyle(
                                    fontSize: 12.0)),
                            ),

                            Expanded(
                              flex: 1,
                                child: SizedBox(
                              width: 10,
                            )),

                            Expanded(
                              flex: 1,
                              child: Text(maxBenefitLimitOfAmount,
                                style: new TextStyle(color: primaryColor,
                                    fontSize: 14.0)),)

                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    )
                ),
                ),
              ),
            );
          }
          else if(index==0)
          {
            //return create_heading('Deduction U/S 80C, 80CCC, 80CCD');

            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child:Padding(padding: const EdgeInsets.only(top: 10,bottom: 5),
                      child: Text(
                        "Deduction U/S 80C, 80CCC, 80CCD", style: TextStyle(color: Colors.black, fontSize: 15),),

                    ),),
                  Container(
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
                                            .width * 0.28,
                                        // height: MediaQuery.of(context).size.height * 0.5,
                                        child:Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "NPS 80CCD (i)",textAlign: TextAlign.center,
                                                style: new TextStyle(fontSize: 12.0),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: 25,
                                                width: 80,
                                                child: TextField(
                                                  enabled: _isEnabled,
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey, width: 1.0),
                                                      borderRadius: BorderRadius.circular(5.0),
                                                    ),
                                                    contentPadding: EdgeInsets.only(
                                                        top: 5, left: 3),
                                                    hintText: "",
                                                    border:
                                                    OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(2.0)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ),

                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.28,
                                        // color: Colors.greenAccent,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "NPS 80CCD (1B) -Max Limit (Rs. 50000/-)",textAlign: TextAlign.center,
                                                style: new TextStyle(fontSize: 12.0),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: 80,
                                                height: 25,
                                                child: TextField(
                                                  textAlign: TextAlign.center,
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
                                                    hintText: "",
                                                    border:
                                                    OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(2.0)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),),

                                      Expanded(
                                        flex: 1,
                                          child: Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.28,
                                        // color: Colors.orange,
                                        child:Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Deduction Amount",textAlign: TextAlign.center,
                                                style: new TextStyle(fontSize: 12.0),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: 80,
                                                height: 25,
                                                child: TextField(
                                                  enabled: _isEnabled,
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey, width: 1.0),
                                                      borderRadius: BorderRadius.circular(5.0),
                                                    ),
                                                    contentPadding: EdgeInsets.only(
                                                        top: 5, left: 3),
                                                    hintText: "",
                                                    border:
                                                    OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(2.0)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),


                                    ],
                                  ),
                                ),

                              ],
                            ),

                          ),
                        ],
                      )
                  )
                ],
              ),
            );
          }
          else {


            SectionInvestmentHeadList headList = sectionDataList[index-1];
            String investmentName = headList.investmentName;
            String investmentAmount = headList.investmentAmount;

            //print('show the list 80c investmentName $investmentName');
            //print('show the list 80c investmentAmount $investmentAmount');
            //print('show the list 80c index $index');


            if (investmentName=="EPF (80C)"
                || investmentName=="VPF (80C)"
                ||investmentName=="PF Deducted By Prev. Employer(80C)"
            )
            {
              _isEnabledForList=false;
            }else
            {
              _isEnabledForList=true;
            }

            return
              Card(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
                child: Container(child: ListTile(
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                          child: Container(
                        // color: Colors.greenAccent,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        height: 55,
                        child:Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  investmentName,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),)
                            )

                        ),

                      ))
                      ,

                      SizedBox(
                        width: 4,
                      ),


                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 10), child: Container(
                            // color: Colors.yellow,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.2,
                            height: 30,

                            child: TextField(
                              controller: _controllers[index],
                              enabled: _isEnabledForList,
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
                                hintText: investmentAmount,
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),
                              /*onChanged: () {
                                  displayName  = value[index];
                                },*/
                            ),
                          ),

                          )
                      ),


                      SizedBox(
                        width: 3,
                      ),

                      Expanded(
                          flex: 1, child:Padding(padding: const EdgeInsets.only(top: 15),

                        child: SizedBox(

                          height: 30, //height of button
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.19,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                elevation: 0.0, //elevation of button
                                shape: RoundedRectangleBorder( //to set border radius to button
                                    borderRadius: BorderRadius.circular(5.0)
                                ),
                                // padding: EdgeInsets.only(top: 15),
                              ),
                              onPressed: ()
                              {


                                update_InvestmentAmount=_controllers[index].text;

                                //print('show update update_InvestmentAmount $update_InvestmentAmount');

                                if(update_InvestmentAmount=="" || update_InvestmentAmount==null)
                                {
                                  update_InvestmentAmount="0";
                                }


                                String  investmentNameType = sectionDataList[index - 1].investmentName;

                                if (investmentNameType=="EPF (80C)"
                                    || investmentNameType=="VPF (80C)"
                                    ||investmentNameType=="PF Deducted By Prev. Employer(80C)"
                                )
                                {
                                  return;
                                }


                                if(int.parse(update_InvestmentAmount)>=0)
                                {
                                  SectionInvestmentHeadList headList1 = sectionDataList[index - 1];
                                  //String before=headList1.investmentAmount;
                                  ////print('show before amount $before');

                                  headList1.investmentAmount =
                                      update_InvestmentAmount;
                                  //String after=headList1.investmentAmount;
                                  ////print('show after amount $after');
                                  sectionDataList.replaceRange(
                                      index - 1, index, [headList1]);
                                  setState(() {
                                    sectionDataList = sectionDataList;
                                  });

                                  List newList = [];
                                  int total_Amount = 0;

                                  for (int i = 0; i <
                                      sectionDataList.length; i++) {
                                    var obj = sectionDataList[i];

                                    Map<String, String> map = {
                                      'investment_id': obj.investmentId,
                                      'investment_amount': obj
                                          .investmentAmount,
                                      'investment_comment': '-'
                                    };
                                    newList.add(map);

                                    /*--------30-8-2021 start-------*/
                                    int amount = int.parse(
                                        obj.investmentAmount);
                                    total_Amount += amount;

                                    /*--------30-8-2021 end-------*/

                                  }
                                  setState(() {
                                    totalDeclarationAmount = total_Amount.toString();
                                    maxBenefitLimitOfAmount = total_Amount.toString();
                                  });


                                  saveInvestmentDetails(newList);
                                  // //print('showcompleted list $newList');
                                }else
                                {

                                  Method.snackBar_OkText(context, "Please enter the investment declaration amount for $investmentNameType");
                                  // show_OKAlert("Please enter the investment declaration amount for $investmentNameType");
                                }


                              }, child: Text('Update',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Vonique',
                                  color: Colors.white,
                                  fontSize: 11))),
                        ),
                      )

                      ),

                    ],
                  ),
                  dense: false,
                ),

                ),

              );
          }
        });
}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body:MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Responsive(
              mobile: mainFunction_US80C_UI(),
              tablet: Center(
                  child:  Container(
                    // width: flutterWeb_tabletWidth,
                    child:mainFunction_US80C_UI(),
                  )
              ),
              desktop: Center(
                child: Container(
                  // width: flutterWeb_tabletWidth,
                  child: mainFunction_US80C_UI(),
                ),
              )
          )
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

          ),
          checkBox_Container()
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
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.28,
                          // height: MediaQuery.of(context).size.height * 0.5,
                          child:Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "NPS 80CCD (i)",textAlign: TextAlign.center,
                                  style: new TextStyle(fontSize: 12.0),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 25,
                                  width: 80,
                                  child: TextField(
                                    enabled: _isEnabled,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          top: 5, left: 3),
                                      hintText: "",
                                      border:
                                      OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(2.0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.28,
                          // color: Colors.greenAccent,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "NPS 80CCD (1B) -Max Limit (Rs. 50000/-)",textAlign: TextAlign.center,
                                  style: new TextStyle(fontSize: 12.0),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 80,
                                  height: 25,
                                  child: TextField(
                                    textAlign: TextAlign.center,
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
                                      hintText: "",
                                      border:
                                      OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(2.0)),
                                    ),
                                    onChanged: (value)
                                    {

                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.28,
                          // color: Colors.orange,
                          child:Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Deduction Amount",textAlign: TextAlign.center,
                                  style: new TextStyle(fontSize: 12.0),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 80,
                                  height: 25,
                                  child: TextField(
                                    enabled: _isEnabled,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          top: 5, left: 3),
                                      hintText: "",
                                      border:
                                      OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(2.0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )

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
 void checkNetworkConnection(dynamic hasConnection)
  {
    if(mounted){
      setState(() {
        networkStatus = !hasConnection;
      });
    }
    if(!networkStatus){
      print("Api should be called");
      chapter80CApiRequest();
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
          chapter80CApiRequest()
        }
      else
        {
          //print('please check the network status'),
          showNetworConnectionAlert()
        }
    });*/
    // chapter80CApiRequest();
  }

  chapter80CApiRequest()
  {

    SharedPreference.getIncomeTax_HeadsFinancialYear().then((value) =>  {
      financialYear=value,
      //print('show emp getIncomeTax_HeadsFinancialYear $value'),
      //loadData()
    });
    SharedPreference.getIncomeTax_HeadsId().then((value) =>  {
      headId=value,
      //print('show emp getIncomeTax_HeadsId $value'),
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
      this.getTax_Sections()


    });

  }
  getTax_Sections() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.tax_investment_sections),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'financial_year': financialYear,
          'head_id': headId,
          'emp_code': getEncrypted_EmpCode(completeEmpCode)

        },
      );
      //print(response.statusCode);
      if (response.statusCode == 200)
      {

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        Investment_Declaration_ChapterVI_ModelResponse vi_modelResponse = Investment_Declaration_ChapterVI_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(vi_modelResponse.statusCode==true)
        {


          sectionDataList=vi_modelResponse!.data!.sectionInvestmentHeadList!;

          /*--------30-8-2021 start-------*/
          int total_Amount=0;
          for(var obj in sectionDataList)
          {
            int amount= int.parse(obj.investmentAmount);
            total_Amount += amount;
          }
          //print('show total sum US 80C $total_Amount');

          setState(() {

            sectionDataList=sectionDataList;
            totalDeclarationAmount=total_Amount.toString();
            maxBenefitLimitOfAmount=total_Amount.toString();
            /*--------30-8-2021 end-------*/

          });
        }
        else
        {
          if (vi_modelResponse.message==null || vi_modelResponse.message=="")
          {
            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, vi_modelResponse.message);

            // show_OKAlert(vi_modelResponse.message);
          }
        }

        EasyLoading.dismiss();


      } else {

        EasyLoading.dismiss();

        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      //print(e);
    }
  }
  saveInvestmentDetails(List listData)
  {

    SharedPreference.getEmpId().then((value) =>  {
      //print('show emp name2 $value'),
      empUserId=value,

    });

    Method.getIPAddress().then((value) =>  {
      //print('show emp name2 $value'),
      empIp=value,

      save_InvestmentDeclaration_80C(listData)

    });

  }

  save_InvestmentDeclaration_80C(List listData) async
  {
    //String jsonTutorial = jsonEncode(listData);
    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.tax_save_employee_investment),
        headers: <String, String>{
          'Content-Type': "application/json",
        },

        body: json.encode({
          'financial_year': financialYear,
          'head_id': headId,
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'emp_ip': empIp,
          'emp_user_id': empUserId,
          'emp_investment_detail': listData,
          'parent_senior_citizen': 'N',
          'disability_more_than_80': 'N',
          'emp_with_severe_disability': 'N'

        }),
      );
      //print(response.statusCode);
      if (response.statusCode == 200)
      {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        Investment_Declaration_ChapterVI_ModelResponse vi_modelResponse = Investment_Declaration_ChapterVI_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(vi_modelResponse.statusCode==true)
        {
          Method.snackBar_OkText(context, vi_modelResponse.message);
          // show_OKAlert(vi_modelResponse.message);

        }
        else
        {
          if (vi_modelResponse.message==null || vi_modelResponse.message=="")
          {
            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, vi_modelResponse.message);
            // show_OKAlert(vi_modelResponse.message);
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

/*----------commented show_OKAlert Dialog---------21-07-2022-start--*/

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

/*----------commented show_OKAlert Dialog---------21-07-2022-end--*/

}