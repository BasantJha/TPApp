
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;
/*import 'package:web/Encrypt/encrypt.dart';
import 'package:web/Message/Message.dart';
import 'package:web/NetworkStatus/NetworkReachability.dart';
import 'package:web/constants/constants.dart';
import 'package:web/customView/AutoLogout.dart';
import 'package:web/customView/Method.dart';
import 'package:web/customView/SharedPreference.dart';
import 'package:web/investment_declaration/ModelClasses/Investment_Declaration_ChapterVI_ModelResponse.dart';
import 'package:web/responsive/responsive_screen_width.dart';
import 'package:web/responsive/resposive.dart';
import 'package:web/webApi/WebApi.dart';*/

import '../../../../../Constant/Constants.dart';
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
import '../ModelClasses/Investment_Declaration_ChapterVI_ModelResponse.dart';

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
      home: investmentDeclaration_ChapterVI(title: 'CJ Hub'),
    );
  }
}
class investmentDeclaration_ChapterVI extends StatefulWidget {

  investmentDeclaration_ChapterVI({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _investmentDeclaration_ChapterVI createState() => _investmentDeclaration_ChapterVI();
}

class _investmentDeclaration_ChapterVI extends State<investmentDeclaration_ChapterVI>
{
  // This widget is the root of your application.
  bool _visible = true;
  bool checkbox_tax_parentssenior_citizen = false;
  bool checkbox_tax_disabilitymore = false;
  bool checkbox_tax_employee_disability = false;

  /* List sectionDataList = [
    "Medical claim(80D)"
  ];*/


  List<SectionInvestmentHeadList> sectionDataList=[SectionInvestmentHeadList(investmentName: "Mediclaim (Self/Spouse/Children) (80D)",investmentAmount: "10")];
  List<InvestmentChoices>? choicesList;

  List<TextEditingController> _controllers = [];
  String update_InvestmentAmount="";

  String completeEmpCode="",financialYear="",headId="";

  String empIp="",empUserId="",parentSeniorCitizen="",disabilityMoreThan80="",empWithSevereDisability="";

  String totalInvestment="0", totalExemption="0";


  String checkbox_Status_parentssenior_citizen_Str="",
      checkbox_Status_disabilitymore_Str="",
      checkbox_Status_employee_disability_Str="";

  bool _isEnabled = false;

  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(!networkStatus){
      print("Api salary status should be called");
      chapterVIApiRequest();
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

    if(kIsWeb){

      //print("This CJ Hub chapterVI tax section Web");

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

    //print("investmentDeclaration tax section resetTimer");

    AutoLogout.initializeTimer(context);
  }

  ListView mainFUnction_UI(){
    return  ListView.builder
      (
        shrinkWrap: true,
        itemCount: sectionDataList.length+2,
        itemBuilder: (BuildContext context, int index)
        {
          //print('show the chapter vi index $index');

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
                child: Container(
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Total Investment:",
                                style: new TextStyle(
                                    fontSize: 12.0)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(totalInvestment,
                                style: new TextStyle(color: primaryColor,
                                    fontSize: 14.0)),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text("Total Exemption:",
                                style: new TextStyle(
                                    fontSize: 12.0)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(totalExemption,
                                style: new TextStyle(color: primaryColor,
                                    fontSize: 14.0)),
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
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(

                    child:Padding(padding: const EdgeInsets.only(top: 10,bottom: 5),
                      child: Text(
                        'A. Deduction to be claimed U/s CH-VI (A)', style: TextStyle(color: Colors.black, fontSize: 15),),

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
                                  child:  Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.28,
                                        // height: MediaQuery.of(context).size.height * 0.5,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                              value: checkbox_tax_parentssenior_citizen,
                                              onChanged: (bool? value)
                                              {
                                                setState(()
                                                {
                                                  checkbox_tax_parentssenior_citizen = value!;

                                                  if (value)
                                                  {
                                                    checkbox_Status_parentssenior_citizen_Str="Y";
                                                  }else
                                                  {
                                                    checkbox_Status_parentssenior_citizen_Str="N";
                                                  }
                                                  FilterChapterVI_Data(sectionDataList,choicesList!);

                                                });
                                              },
                                            ),
                                            Text(
                                              "Parents Senior Citizen (Claim Under 80D)",textAlign: TextAlign.center,
                                              style: new TextStyle(fontSize: 12.0),
                                            ),


                                          ],
                                        ),
                                      ),),

                                      Expanded(
                                        flex: 1,
                                        child:Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.28,
                                          // color: Colors.greenAccent,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: checkbox_tax_disabilitymore,
                                                onChanged: (bool? value)
                                                {
                                                  setState(() {
                                                    checkbox_tax_disabilitymore = value!;

                                                    if (value)
                                                    {
                                                      checkbox_Status_disabilitymore_Str="Y";
                                                    }else
                                                    {
                                                      checkbox_Status_disabilitymore_Str="N";
                                                    }
                                                    FilterChapterVI_Data(sectionDataList,choicesList!);
                                                  });
                                                },
                                              ),

                                              Text(
                                                "Disability More Than 80% with Dependent (80DD)",textAlign: TextAlign.center,
                                                style: new TextStyle(fontSize: 12.0),
                                              ),


                                            ],
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
                                        // color: Colors.orange,
                                        child: Column(

                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                              value: checkbox_tax_employee_disability,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  checkbox_tax_employee_disability = value!;

                                                  if (value)
                                                  {
                                                    checkbox_Status_employee_disability_Str="Y";
                                                  }else
                                                  {
                                                    checkbox_Status_employee_disability_Str="N";
                                                  }

                                                  FilterChapterVI_Data(sectionDataList,choicesList!);

                                                });
                                              },
                                            ),

                                            Text(
                                              "Employee with Severe Disability",textAlign: TextAlign.center,
                                              style: new TextStyle(fontSize: 12.0),
                                            ),

                                          ],
                                        ),
                                      ))


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
          else
          {

            SectionInvestmentHeadList headList=sectionDataList[index-1];
            String investmentName = headList.investmentName;
            String investmentAmount = headList.investmentAmount;

            //print('show the list chapter vi investmentName $investmentName');
            //print('show the list chapter vi investmentAmount $investmentAmount');
            //print('show the list chapter vi index $index');



            if (investmentName=="Mediclaim (Prem. Ded. From Sal. Self/Spouse/Children) (80D)"
                || investmentName=="Rent Paid (80GG)"
                ||investmentName=="Interest on Saving Bank (80TTA)"
                || investmentName=="Interest on Home Loan(2016-17)"
                || investmentName=="Interest on Home Loan(2019-20)")
            {
              _isEnabled=false;
            }
            else
            {
              _isEnabled=true;

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
                  contentPadding: EdgeInsets.only(left: 5,right: 5),
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
                              .width * 0.45,
                          height: 50,

                          child:
                          Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child:Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    investmentName,
                                    style: TextStyle(fontSize: 12,color: Colors.black),)
                              )

                          ),
                        ),
                      ),


                      SizedBox(
                        width: 4,
                      ),

                       Expanded(
                         flex: 1,
                         child: Padding(
                         padding: EdgeInsets.only(top: 15, bottom: 10),
                         child:Container(
                           // color: Colors.yellow,
                           width: MediaQuery
                               .of(context)
                               .size
                               .width * 0.2,
                           height: 30,
                           child: TextField(
                             enabled: _isEnabled,
                             controller: _controllers[index] ,
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
                                  update_InvestmentAmount  = value[index];
                                },*/
                           ),

                         ),
                       ),),



                      SizedBox(
                        width: 3,
                      ),

                     Expanded(
                       flex: 1,
                       child: Padding(padding: const EdgeInsets.only(top: 15),
                         child:SizedBox(
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

                             if (investmentNameType=="Mediclaim (Prem. Ded. From Sal. Self/Spouse/Children) (80D)"
                                 || investmentNameType=="Rent Paid (80GG)"
                                 ||investmentNameType=="Interest on Saving Bank (80TTA)"
                                 || investmentNameType=="Interest on Home Loan(2016-17)"
                                 || investmentNameType=="Interest on Home Loan(2019-20)")
                             {
                               return;
                             }


                             if(int.parse(update_InvestmentAmount)>=0)
                             {
                               SectionInvestmentHeadList headList1 = sectionDataList[index -
                                   1];
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
                                 totalInvestment = total_Amount.toString();
                                 totalExemption = total_Amount.toString();
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
                     ),)




                    ],
                  ),
                  dense: false,
                ),),

              );
          }

        });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handleUserInteraction,
        onPointerMove: _handleUserInteraction,
        onPointerUp: _handleUserInteraction,
        child:
      Scaffold(
      body:
      MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Responsive(
              mobile: mainFUnction_UI(),
              tablet: Center(
                  child:  Container(
                    // width: flutterWeb_tabletWidth,
                    child:mainFUnction_UI(),
                  )
              ),
              desktop: Center(
                child: Container(
                  // width: flutterWeb_desktopWidth,
                  child: mainFUnction_UI(),
                ),
              )
          )


      ),
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
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.28,
                          // height: MediaQuery.of(context).size.height * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: checkbox_tax_parentssenior_citizen,
                                onChanged: (bool? value) {
                                  setState(() {
                                    checkbox_tax_parentssenior_citizen = value!;
                                  });
                                },
                              ),
                              Text(
                                "Parents Senior Citizen (Claim Under 80D)",textAlign: TextAlign.center,
                                style: new TextStyle(fontSize: 12.0),
                              ),


                            ],
                          ),
                        ),

                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.28,
                          // color: Colors.greenAccent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: checkbox_tax_disabilitymore,
                                onChanged: (bool? value) {
                                  setState(() {
                                    checkbox_tax_disabilitymore = value!;
                                  });
                                },
                              ),

                              Text(
                                "Disability More Than 80% with Dependent (80DD)",textAlign: TextAlign.center,
                                style: new TextStyle(fontSize: 12.0),
                              ),


                            ],
                          ),
                        ),

                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.28,
                          // color: Colors.orange,
                          child: Column(

                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: checkbox_tax_employee_disability,
                                onChanged: (bool? value)
                                {
                                  setState(()
                                  {
                                    checkbox_tax_employee_disability = value!;
                                  });
                                },
                              ),

                              Text(
                                "Employee with Severe Disability",textAlign: TextAlign.center,
                                style: new TextStyle(fontSize: 12.0),
                              ),

                            ],
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
      chapterVIApiRequest();
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
          chapterVIApiRequest()
        }
      else
        {
          //print('please check the network status'),
          showNetworConnectionAlert()
        }
    });*/
    // chapterVIApiRequest();
  }

  chapterVIApiRequest()
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
    //print('SHOW CHAPTER VI financialYear $financialYear');
    //print('SHOW CHAPTER VI head_id $headId');
    //print(getEncrypted_EmpCode(completeEmpCode));

    //print(getEncrypted_EmpCode(completeEmpCode));


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

        EasyLoading.dismiss();

        //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        Investment_Declaration_ChapterVI_ModelResponse vi_modelResponse = Investment_Declaration_ChapterVI_ModelResponse.fromJson(jsonDecode(serverResponse));


        if(vi_modelResponse.statusCode==true)
        {

          sectionDataList=vi_modelResponse!.data!.sectionInvestmentHeadList!;
          loadData(sectionDataList, vi_modelResponse!.data!.investmentChoices!);

        }
        else
        {

          if (vi_modelResponse.message==null || vi_modelResponse.message=="")
          {
            // show_OKAlert("server error!");

            Method.snackBar_OkText(context, "server error!");

          }else {

            Method.snackBar_OkText(context, vi_modelResponse.message);
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
      //print(e);
    }
  }

  loadData(List<SectionInvestmentHeadList>dataList,List<InvestmentChoices>choicesLists)
  {


    sectionDataList = dataList;
    choicesList = choicesLists;


    /*----28-5-2021 START NEW TASKS-----*/
    List<SectionInvestmentHeadList> newCustomList=[];

    if (choicesLists[0].parentSeniorCitizen=="Y")
    {
      //checkbox_tax_parentssenior_citizen.setChecked(true);
      checkbox_Status_parentssenior_citizen_Str="Y";

    }else
    {
      checkbox_Status_parentssenior_citizen_Str="N";
    }
    if (choicesLists[0].disabilityMoreThan80=="Y")
    {
      //checkbox_tax_disabilitymore.setChecked(true);
      checkbox_Status_disabilitymore_Str="Y";

    }else
    {
      checkbox_Status_disabilitymore_Str="N";
    }

    if (choicesLists[0].empWithSevereDisability=="Y")
    {
      //checkbox_tax_employee_disability.setChecked(true);
      checkbox_Status_employee_disability_Str="Y";

    }else
    {
      checkbox_Status_employee_disability_Str="N";
    }

    /*----28-5-2021 END NEW TASKS-----*/


    int i;
    int total = 0;

    for(i=0;i<dataList.length;i++){

      String amount=dataList[i].investmentAmount.toString();
      int totalAmount=int.parse(amount);
      total = total + totalAmount;

      /*----28-5-2021 START NEW TASKS-----*/

      SectionInvestmentHeadList newModelObject=new SectionInvestmentHeadList();
      newModelObject.financialYear=dataList[i].financialYear;
      newModelObject.headId=dataList[i].headId;
      newModelObject.investmentAmount=dataList[i].investmentAmount;
      newModelObject.investmentComment=dataList[i].investmentComment;
      newModelObject.investmentDescription=dataList[i].investmentDescription;
      newModelObject.investmentId=dataList[i].investmentId;
      newModelObject.investmentName=dataList[i].investmentName;
      newModelObject.maxLimit=dataList[i].maxLimit;
      newModelObject.sectionName=dataList[i].sectionName;

      if (dataList[i].investmentName=="Mediclaim (Parents) (80D)" && dataList[i].maxLimit=="25000")
      {
        if (checkbox_Status_parentssenior_citizen_Str=="N")
        {
          newCustomList.add(newModelObject);

        }else
        {

        }
      }
      else if (dataList[i].investmentName=="Mediclaim (Parents) (80D)" && dataList[i].maxLimit=="50000")
      {
        if (checkbox_Status_parentssenior_citizen_Str=="Y")
        {
          newCustomList.add(newModelObject);

        }else
        {

        }
      }
      else if (dataList[i].investmentName=="Handicaped Dependents (80DD)" && dataList[i].maxLimit=="75000")
      {
        if (checkbox_Status_disabilitymore_Str=="N")
        {
          newCustomList.add(newModelObject);

        }else
        {

        }
      }
      else if (dataList[i].investmentName=="Handicaped Dependents (80DD)" && dataList[i].maxLimit=="125000")
      {
        if (checkbox_Status_disabilitymore_Str=="Y")
        {
          newCustomList.add(newModelObject);

        }else
        {

        }
      }
      else if (dataList[i].investmentName=="Pension Handicap (80U)" && dataList[i].maxLimit=="75000")
      {
        if (checkbox_Status_employee_disability_Str=="N")
        {
          newCustomList.add(newModelObject);

        }else
        {

        }
      }
      else if (dataList[i].investmentName=="Pension Handicap (80U)" && dataList[i].maxLimit=="125000")
      {
        if (checkbox_Status_employee_disability_Str=="Y")
        {
          newCustomList.add(newModelObject);

        }else
        {

        }
      }
      else
      {
        newCustomList.add(newModelObject);

      }

      /*----28-5-2021 END NEW TASKS-----*/
    }

    setState(() {

      setState(() {
        sectionDataList=newCustomList;
        totalExemption=total.toString();
        totalInvestment=total.toString();
      });


    });


  }
  FilterChapterVI_Data(List<SectionInvestmentHeadList>dataList,List<InvestmentChoices>choicesLists)
  {
    /*----28-5-2021 START NEW TASKS-----*/
    List<SectionInvestmentHeadList> newCustomList=[];

    /*----28-5-2021 END NEW TASKS-----*/


    int i;
    int total = 0;

    for(i=0;i<dataList.length;i++) {

      String amount=dataList[i].investmentAmount.toString();
      int totalAmount=int.parse(amount);
      total = total + totalAmount;
      /*----28-5-2021 START NEW TASKS-----*/

      SectionInvestmentHeadList newModelObject=new SectionInvestmentHeadList();
      newModelObject.financialYear=dataList[i].financialYear;
      newModelObject.headId=dataList[i].headId;
      newModelObject.investmentAmount=dataList[i].investmentAmount;
      newModelObject.investmentComment=dataList[i].investmentComment;
      newModelObject.investmentDescription=dataList[i].investmentDescription;
      newModelObject.investmentId=dataList[i].investmentId;
      newModelObject.investmentName=dataList[i].investmentName;
      newModelObject.maxLimit=dataList[i].maxLimit;
      newModelObject.sectionName=dataList[i].sectionName;

      if (dataList[i].investmentName=="Mediclaim (Parents) (80D)" && dataList[i].maxLimit=="25000")
      {
        if (checkbox_Status_parentssenior_citizen_Str=="N")
        {
          newCustomList.add(newModelObject);

        }else
        {

        }
      }
      else if (dataList[i].investmentName=="Mediclaim (Parents) (80D)" && dataList[i].maxLimit=="50000")
      {
        if (checkbox_Status_parentssenior_citizen_Str=="Y")
        {
          newCustomList.add(newModelObject);

        }else
        {

        }
      }
      else if (dataList[i].investmentName=="Handicaped Dependents (80DD)" && dataList[i].maxLimit=="75000")
      {
        if (checkbox_Status_disabilitymore_Str=="N")
        {
          newCustomList.add(newModelObject);

        }else
        {

        }
      }
      else if (dataList[i].investmentName=="Handicaped Dependents (80DD)" && dataList[i].maxLimit=="125000")
      {
        if (checkbox_Status_disabilitymore_Str=="Y")
        {
          newCustomList.add(newModelObject);

        }else
        {

        }
      }
      else if (dataList[i].investmentName=="Pension Handicap (80U)" && dataList[i].maxLimit=="75000")
      {
        if (checkbox_Status_employee_disability_Str=="N")
        {
          newCustomList.add(newModelObject);

        }else
        {

        }
      }
      else if (dataList[i].investmentName=="Pension Handicap (80U)" && dataList[i].maxLimit=="125000")
      {
        if (checkbox_Status_employee_disability_Str=="Y")
        {
          newCustomList.add(newModelObject);

        }else
        {

        }
      }
      else
      {
        newCustomList.add(newModelObject);

      }


      /*----28-5-2021 END NEW TASKS-----*/
    }

    setState(() {

      sectionDataList=newCustomList;
      totalExemption=total.toString();
      totalInvestment=total.toString();
    });


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

      save_InvestmentDeclaration_ChapterVI(listData)

    });

  }

  save_InvestmentDeclaration_ChapterVI(List listData) async
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

        body:  json.encode({
          'financial_year': financialYear,
          'head_id': headId,
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'emp_ip': empIp,
          'emp_user_id': empUserId,
          'emp_investment_detail': listData,
          'parent_senior_citizen': checkbox_Status_parentssenior_citizen_Str,
          'disability_more_than_80': checkbox_Status_disabilitymore_Str,
          'emp_with_severe_disability': checkbox_Status_employee_disability_Str,

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

        EasyLoading.dismiss();

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

/*----------commented shoe_OKAlert Dialog---------21-07-2022-end--*/

}