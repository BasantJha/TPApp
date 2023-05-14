import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;

import '../../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../CJHubInvestment_DeclarationModule/ModelClasses/Investment_Declaration_TaxSection_ModelResponse.dart';
import 'UploadInestmentProof_VI/UploadInvestmentProof_VI_Add.dart';
import 'UploadInestmentProof_VI/UploadInvestmentProof_VI_View.dart';
import 'UploadInvestmentProof_80C/UploadInvestmentProof_80C_Add.dart';
import 'UploadInvestmentProof_80C/UploadInvestmentProof_80C_View.dart';
import 'UploadInvestmentProof_HRA/UploadInvestmentProof_HRA_Add.dart';
import 'UploadInvestmentProof_HRA/UploadInvestmentProof_HRA_View.dart';
import 'UploadInvestmentProof_HousingLoan/UploadInvestmentProof_HousingLoan_Add.dart';
import 'UploadInvestmentProof_HousingLoan/UploadInvestmentProof_HousingLoan_View.dart';
/*import 'package:web/Encrypt/encrypt.dart';
import 'package:web/Investment_UploadDocumentModule/Investment_UploadDocumentClasses/UploadInvestmentProof_80C/UploadInvestmentProof_80C_Add.dart';
import 'package:web/Investment_UploadDocumentModule/Investment_UploadDocumentClasses/UploadInvestmentProof_80C/UploadInvestmentProof_80C_View.dart';
import 'package:web/Investment_UploadDocumentModule/Investment_UploadDocumentClasses/UploadInvestmentProof_HRA/UploadInvestmentProof_HRA_Add.dart';
import 'package:web/Investment_UploadDocumentModule/Investment_UploadDocumentClasses/UploadInvestmentProof_HRA/UploadInvestmentProof_HRA_View.dart';
import 'package:web/Investment_UploadDocumentModule/Investment_UploadDocumentClasses/UploadInvestmentProof_HousingLoan/UploadInvestmentProof_HousingLoan_Add.dart';
import 'package:web/Investment_UploadDocumentModule/Investment_UploadDocumentClasses/UploadInvestmentProof_HousingLoan/UploadInvestmentProof_HousingLoan_View.dart';
import 'package:web/Investment_UploadDocumentModule/Investment_UploadDocumentClasses/UploadInestmentProof_VI/UploadInvestmentProof_VI_Add.dart';
import 'package:web/Investment_UploadDocumentModule/Investment_UploadDocumentClasses/UploadInestmentProof_VI/UploadInvestmentProof_VI_View.dart';
import 'package:web/Message/Message.dart';
import 'package:web/constants/constants.dart';
import 'package:web/customView/Method.dart';
import 'package:web/customView/SharedPreference.dart';
import 'package:web/webApi/WebApi.dart';

import '../../investment_declaration/ModelClasses/Investment_Declaration_TaxSection_ModelResponse.dart';*/



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
      home: UploadInvestmentProof(title: 'CJ Hub'),
    );
  }
}
class UploadInvestmentProof extends StatefulWidget {

  UploadInvestmentProof({Key? key, this.title,this.checkStatusType}) : super(key: key);

  final String? title;
  final String? checkStatusType;

  @override
  _UploadInvestmentProof createState() => _UploadInvestmentProof(this.checkStatusType!);
}

class _UploadInvestmentProof extends State<UploadInvestmentProof> {
  // This widget is the root of your application.

  String checkStatusType="";


  //String valueChoose= "Chapter-VI" ;

  String empCode="",empName="",panNumber="";
  String investmentDeclaration_Alert="Investment Declaration Open Between xxx To xxx";
  String completeEmpCode="";
  String empId="",empIPAddress="",financialYear="";

  Investment_Declaration_TaxSection_ModelResponse? investment_declaration_taxSection_ModelResponse;
  String valueChoose = "Chapter-VI";

  // Data selected_TaxSection=Data(id: "1",financialYear: "2021-22",headName: "Dummy");
  Data? selected_TaxSection;

  bool chapterVI_VisibilityStatus=true,
      us80c__VisibilityStatus=false,
      otherIncomeDetails__VisibilityStatus=false,
      housingLoan__VisibilityStatus=false,
      rentPaidDetails__VisibilityStatus=false,
      carDetails__VisibilityStatus=false,
      incomeFromLeftOutHousePeoperty__VisibilityStatus=false;

  bool dropDown_VisibilityStatus=false;


  bool housingLoan__VisibilityStatus_Add=true,
      housingLoan__VisibilityStatus_View=false;

  bool rentDetails__VisibilityStatus_Add=true,
      rentDetails__VisibilityStatus_View=false;

  bool chapterVI__VisibilityStatus_Add=true,
      chapterVI__VisibilityStatus_View=false;

  bool us80C__VisibilityStatus_Add=true,
      us80C__VisibilityStatus_View=false;

  /*-----------------7-12-2021 start-----------------*/
  _UploadInvestmentProof(String checkStatusType)
  {
    this.checkStatusType=checkStatusType;

    //print('show selected status $checkStatusType');



    if(checkStatusType==Method.getUpload_UserArriveFromView_ToAddHouseLoan())
    {
      //user arrive from viewToAdd

      chapterVI_VisibilityStatus=false;
      us80c__VisibilityStatus=false;
      otherIncomeDetails__VisibilityStatus=false;
      housingLoan__VisibilityStatus=true;
      rentPaidDetails__VisibilityStatus=false;
      carDetails__VisibilityStatus=false;
      incomeFromLeftOutHousePeoperty__VisibilityStatus=false;

      valueChoose="Housing Loan Details";
      SharedPreference.setIncomeTax_HeadsId("4");


    }
    else if(checkStatusType==Method.getUpload_UserArriveFromView_ToAddRentDetails())
    {
      //user arrive from viewToAdd

      chapterVI_VisibilityStatus=false;
      us80c__VisibilityStatus=false;
      otherIncomeDetails__VisibilityStatus=false;
      housingLoan__VisibilityStatus=false;
      rentPaidDetails__VisibilityStatus=true;
      carDetails__VisibilityStatus=false;
      incomeFromLeftOutHousePeoperty__VisibilityStatus=false;

      valueChoose="Rent Paid Details";
      SharedPreference.setIncomeTax_HeadsId("5");

    }
    else if(checkStatusType==Method.getUpload_UserArriveFromView_ToAddChapterVI())
    {
      //user arrive from viewToAdd

      chapterVI_VisibilityStatus=true;
      us80c__VisibilityStatus=false;
      otherIncomeDetails__VisibilityStatus=false;
      housingLoan__VisibilityStatus=false;
      rentPaidDetails__VisibilityStatus=false;
      carDetails__VisibilityStatus=false;
      incomeFromLeftOutHousePeoperty__VisibilityStatus=false;

      valueChoose="Chapter-VI";
      SharedPreference.setIncomeTax_HeadsId("1");

    }
    else if(checkStatusType==Method.getUpload_UserArriveFromView_ToAddUS80C())
    {
      //user arrive from viewToAdd

      chapterVI_VisibilityStatus=false;
      us80c__VisibilityStatus=true;
      otherIncomeDetails__VisibilityStatus=false;
      housingLoan__VisibilityStatus=false;
      rentPaidDetails__VisibilityStatus=false;
      carDetails__VisibilityStatus=false;
      incomeFromLeftOutHousePeoperty__VisibilityStatus=false;

      valueChoose="U/S 80 C";
      SharedPreference.setIncomeTax_HeadsId("2");

    }
    else
    {

    }
  }

  /*-----------------7-12-2021 end-----------------*/

  /*HomeLoan_View_ModelResponse homeLoan_View_ModelResponse;
  List<Data> homeLoanDataArr=[Data(nameOfOwner: "a",documentPath: "",documentName: "",
      intrestAmount: "",lenderName: "",principalAmount: "",lenderPanNumber1: "",lenderPanNumber2: "",lenderPanNumber3: "",
      lenderPanNumber4: "",approvalStatus: "",loanType: "",loanAmount:"",propertyValue:""),
  ];
*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBasicInfo();
    getTax_Heads();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(

      /*  appBar: AppBar(leading: BackButton(
            color: Colors.black
        ), backgroundColor: Color(0xfff0f0f2),centerTitle: true,
          title: Image.asset('applogo.png',height: 90,width: 90,),),

      body: SingleChildScrollView(
          child:Column(children: <Widget>[
            *//*create_headingContainer("Upload Investment Proof F.Y(2021-2022)" ),

            create_taxBannerContainer("Upload Investment Proof Open For Between 01/01/2020 To 31/01/21"),

            createEmp_CodeNamePan(),*//*

            create_ChooseText("Choose Option"),

            dropDownButton_Container(),


            create_DownContainer(),



          ])
      )*/

      body: new NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              leading: BackButton(
                  color: Colors.black),
              pinned: true,
              backgroundColor: Color(0xfff0f0f2),
              centerTitle: true,
              title: new Image.asset(getCJHub_AppLogo,height: 90,width: 90,),
            ),
          ];
        },
        body: new Column(
          children: <Widget>[
            new Container(
              child:Column(children: <Widget>[

                /*create_headingContainer("Upload Investment Proof F.Y(2021-2022)" ),

                create_taxBannerContainer("Upload Investment Proof Open For Between 01/01/2020 To 31/01/21"),

                createEmp_CodeNamePan(),*/

                create_ChooseText("Choose Option"),

                dropDownButton_Container(),



              ]),
            ),
            Expanded(
              child:  new Container(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(1,0,1,1),

                    child: create_DownContainer(),

                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container create_DownContainer()
  {
    return
      Container(
        width: double.maxFinite,
        height:MediaQuery.of(context).size.height,
        // color: Colors.grey,

        child: Padding(
          padding: const EdgeInsets.fromLTRB(1,1,1,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child:  Container
                    (
                      height:MediaQuery.of(context).size.height,
                      child:load_Visible_SectionData()
                  ))


            ],
          ),


        ),



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
                style: TextStyle(color: Colors.black,fontSize: 15),),
            ),
          ],
        ),
      ),
    );
  }
  Container create_taxBannerContainer(String value){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,15,10,5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: double.maxFinite,
                // color: bannerColor,
                decoration: BoxDecoration(
                  color: bannerColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 5,top: 7,bottom: 7,right: 5),
                  child: Text(value,style: TextStyle(color: bannerTextColor),),
                )
            )
          ],
        ),
      ),
    );
  }
  Container create_ChooseText(String text){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,25,10,0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(text,style: TextStyle(color: primaryColor,fontSize: 16,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
  Container dropDownButton_Container(){
    return Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left:10,right: 10,top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dropDown(),
                ],
              ),
            ),
          ],
        )
    );

  }



  Container dropDown()
  {
    return
      Container(
          padding: EdgeInsets.fromLTRB(10,0,10,0),
          decoration: BoxDecoration(
            border: Border.all(color: fourHunGreyColor,
                width: 1.0,
                style: BorderStyle.solid),
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child:loadDropDown_VisibleData()
      );
  }

  Visibility loadDropDown_VisibleData()
  {

    if (dropDown_VisibilityStatus == true)
    {
      /*------load live data in dropdown start------*/

      return Visibility(
          visible: true,
          child: DropdownButton(
            hint: Text(valueChoose),
            icon: Icon(Icons.arrow_drop_down),
            dropdownColor: Colors.white,
            underline: DropdownButtonHideUnderline(child: Container()),
            iconSize: 25,
            isExpanded: true,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
            value: selected_TaxSection,
            onChanged: (Data? obj)
            {
              load_SelectedData(obj!);

            },
            items: investment_declaration_taxSection_ModelResponse!.data!.map((Data data)
            {
              return DropdownMenuItem(
                value: data,
                child: Text(data.headName),
              );
            }).toList(),
          )
      );
      /*------load live data in dropdown end------*/

    }
    else
    {
      /*------load default data first time load dropdown handle the exception page start------*/
      return Visibility(
          visible: true,
          child: DropdownButton(
            hint: Text(valueChoose),
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
            onChanged: (obj)
            {

            },
            items: Investment_Declaration_TaxSection_ModelResponse.loadDefaultData.map((Data data)
            {
              return DropdownMenuItem(
                value: data.headName,
                child: Text(data.headName),
              );
            }).toList(),
          )
      );
    }
    /*------load default data first time load dropdown handle the exception page end------*/

  }


  Container createEmp_CodeNamePan(){
    return   Container(
      width: double.maxFinite,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(10,15,10,0),
          child: new Stack(
            children: <Widget>[
              Container(

                width: double.maxFinite,
                decoration: new BoxDecoration(
                  // color: Colors.yellow[100],
                    shape: BoxShape.rectangle,
                    borderRadius: new BorderRadius.circular(8.0),
                    border: Border.all(color: fourHunGreyColor,
                        width: 1.0,
                        style: BorderStyle.solid)
                ),
                padding: const EdgeInsets.only(left: 10, right: 10,top: 5,bottom: 5),
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

                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Emp Code",textAlign: TextAlign.center,
                                  style: new TextStyle(fontSize: 10.0),
                                ),
                                Text(
                                  empCode,textAlign: TextAlign.center,
                                  style: new TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),
                                ),


                                SizedBox(
                                  height: 5,
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

                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Emp Name",textAlign: TextAlign.center,
                                  style: new TextStyle(fontSize: 10.0),
                                ),
                                Text(
                                  empName,textAlign: TextAlign.center,
                                  style: new TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),
                                ),

                                SizedBox(
                                  height: 5,
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

                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Pan No",textAlign: TextAlign.center,
                                  style: new TextStyle(fontSize: 10.0),
                                ),
                                Text(
                                  panNumber,textAlign: TextAlign.center,
                                  style: new TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),
                                ),

                              ],
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                        ],
                      ),
                    ),

                  ],
                ),

              ),
            ],
          )
      ),
    );
  }

  getBasicInfo()
  {
    SharedPreference.getIncomeTax_HeadsFinancialYear().then((value) => {
      financialYear=value

    });


    SharedPreference.getEmpPanCardNumber().then((value) =>  {
      panNumber=value,
      //print('show emp name2 $value'),
      //loadData()
    });
    SharedPreference.getEmpName().then((value) =>  {
      empName=value,
      //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpId().then((value) =>  {
      empId=value,
      //print('show emp name2 $value'),
      //loadData()
    });
    Method.getIPAddress().then((value) => {
      empIPAddress=value

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
      empCode=value,
      //print('show emp name2 $value'),
      loadBasicInfo()
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth_key=value,
      //print('show emp name2 $value'),
      completeEmpCode = mobileNumber_key+"CJHUB"+empCode_key+"CJHUB"+empDateOfBirth_key,

    });

  }
  loadBasicInfo()
  {
    setState(() {
      empCode=empCode;
      empName=empName;
      panNumber=panNumber;
    });
  }

  Visibility load_Visible_SectionData() {

    if (chapterVI_VisibilityStatus == true)
    {
      return Visibility(
          visible: chapterVI_VisibilityStatus,
          child: load_ChapterVI()

      );
    }
    else if (us80c__VisibilityStatus == true) {
      return Visibility(
          visible: us80c__VisibilityStatus,
          child: load_US80C()
      );
    }
    else if (rentPaidDetails__VisibilityStatus == true) {
      return Visibility(
        visible: rentPaidDetails__VisibilityStatus,
        //child: UploadInvestmentProof_HRA_Add()
        child: load_RentDetails(),
      );
    }
    else if (housingLoan__VisibilityStatus == true)
    {
      return Visibility(
        visible: housingLoan__VisibilityStatus,
        //child: UploadInvestmentProof_HousingLoan_Add()

        /*-------------------6-12-2021 START----------------*/
        child:load_HouseLoan(),
      );
      /*-------------------6-12-2021 END----------------*/


    }
    /*---------------21-1-2022 start------------------*/
    /*else if (otherIncomeDetails__VisibilityStatus == true) {
      return Visibility(
          visible: otherIncomeDetails__VisibilityStatus,
          child: UploadInvestmentProof_HRA_Add()
      );
    }
    else if (carDetails__VisibilityStatus == true) {
      return Visibility(
          visible: carDetails__VisibilityStatus,
          child: UploadInvestmentProof_HRA_Add()
      );
    }
    else if (incomeFromLeftOutHousePeoperty__VisibilityStatus == true) {
      return Visibility(
          visible: incomeFromLeftOutHousePeoperty__VisibilityStatus,
          child: UploadInvestmentProof_HRA_Add()
      );
    }*/
    /*---------------21-1-2022 end------------------*/
    else
    {
      return Visibility(visible: false,child: Text("record not found"),);

    }
  }
/*--------------6-12-2021 start-------------*/
  Visibility load_HouseLoan()
  {
    if(housingLoan__VisibilityStatus_Add==true)
    {
      return Visibility(
          visible: housingLoan__VisibilityStatus_Add,
          child: UploadInvestmentProof_HousingLoan_Add()
      );
    }
    else {

      //use for
      return Visibility(
          visible: housingLoan__VisibilityStatus_View,
          child: UploadInvestmentProof_HousingLoan_View(userArriveFrom_AddToView_or_DirectView:"DirectHomeLoanView" ,)
      );


      //Navigator.push(context,MaterialPageRoute(builder: (context)=>UploadInvestmentProof_HousingLoan_View()));

    }
  }
  Visibility load_RentDetails()
  {
    if(rentDetails__VisibilityStatus_Add==true)
    {
      return Visibility(
          visible: rentDetails__VisibilityStatus_Add,
          child: UploadInvestmentProof_HRA_Add()
      );
    }
    else {

      //use for
      return Visibility(
          visible: rentDetails__VisibilityStatus_View,
          child: UploadInvestmentProof_HRA_View(userArriveFrom_AddToView_or_DirectView:"DirectRentDetailsView" ,)
      );


      //Navigator.push(context,MaterialPageRoute(builder: (context)=>UploadInvestmentProof_HousingLoan_View()));

    }
  }
  Visibility load_ChapterVI()
  {
    if(chapterVI__VisibilityStatus_Add==true)
    {
      return Visibility(
          visible: chapterVI__VisibilityStatus_Add,
          child: UploadInvestmentProof_VI_Add()
      );
    }
    else {

      //use for
      return Visibility(
          visible: chapterVI__VisibilityStatus_View,
          child: UploadInvestmentProof_VI_View(userArriveFrom_AddToView_or_DirectView:"DirectChapterVIView" ,)
      );


      //Navigator.push(context,MaterialPageRoute(builder: (context)=>UploadInvestmentProof_HousingLoan_View()));

    }
  }
  Visibility load_US80C()
  {
    if(us80C__VisibilityStatus_Add==true)
    {
      return Visibility(
          visible: us80C__VisibilityStatus_Add,
          child: UploadInvestmentProof_80C_Add()
      );
    }
    else {

      //use for
      return Visibility(
          visible: us80C__VisibilityStatus_View,
          child: UploadInvestmentProof_80C_View(userArriveFrom_AddToView_or_DirectView:"Direct80CView" ,)
      );


      //Navigator.push(context,MaterialPageRoute(builder: (context)=>UploadInvestmentProof_HousingLoan_View()));

    }
  }

/*--------------6-12-2021 end-------------*/

  load_SelectedData(Data obj)
  {

    setState(()
    {
      SharedPreference.setIncomeTax_HeadsDescription(obj.subHeadName);
      SharedPreference.setIncomeTax_HeadsFinancialYear(obj.financialYear);
      SharedPreference.setIncomeTax_HeadsId(obj.id);
      selected_TaxSection = obj;


      String id=obj.id;
      String headname=obj.headName;
      //print('show headid $id');
      //print('show headname $headname');

    });


    //print('show selected object $selected_TaxSection');
    //print(obj.id);

    String selectedHeadName=obj.headName;

    if (selectedHeadName=="Chapter-VI")
    {
      //completed with testing
      setState(() {
        chapterVI_VisibilityStatus=true;
        us80c__VisibilityStatus=false;
        otherIncomeDetails__VisibilityStatus=false;
        housingLoan__VisibilityStatus=false;
        rentPaidDetails__VisibilityStatus=false;
        carDetails__VisibilityStatus=false;
        incomeFromLeftOutHousePeoperty__VisibilityStatus=false;

        /*--------------8-12-2021 start-------------*/


        if(checkStatusType==Method.getUpload_UserArriveFromView_ToAddChapterVI())
        {
          //show data views
          chapterVI__VisibilityStatus_Add=true;
          chapterVI__VisibilityStatus_View=false;
        }
        else
        {
          chapterVI__VisibilityStatus_Add=true;
          chapterVI__VisibilityStatus_View=false;
          checkView_DetailsFor_ChapterVIor80C(WebApi.gate_UploadInvestmentProof_chapterVI,"ChapterVI","1");
        }
        /*--------------8-12-2021 end-------------*/
      });

    }else if(selectedHeadName=="U/S 80 C")
    {
      //completed with testing
      setState(() {
        chapterVI_VisibilityStatus=false;
        us80c__VisibilityStatus=true;
        otherIncomeDetails__VisibilityStatus=false;
        housingLoan__VisibilityStatus=false;
        rentPaidDetails__VisibilityStatus=false;
        carDetails__VisibilityStatus=false;
        incomeFromLeftOutHousePeoperty__VisibilityStatus=false;

        /*--------------8-12-2021 start-------------*/


        if(checkStatusType==Method.getUpload_UserArriveFromView_ToAddUS80C())
        {
          //show data views
          us80C__VisibilityStatus_Add=true;
          us80C__VisibilityStatus_View=false;
        }
        else
        {
          us80C__VisibilityStatus_Add=true;
          us80C__VisibilityStatus_View=false;
          checkView_DetailsFor_ChapterVIor80C(WebApi.gate_UploadInvestmentProof_80C,"US80C","2");
        }
        /*--------------8-12-2021 end-------------*/

      });
    }
    else if(selectedHeadName=="Other Income Details")
    {
      //completed with testing

      setState(() {
        chapterVI_VisibilityStatus=false;
        us80c__VisibilityStatus=false;
        otherIncomeDetails__VisibilityStatus=true;
        housingLoan__VisibilityStatus=false;
        rentPaidDetails__VisibilityStatus=false;
        carDetails__VisibilityStatus=false;
        incomeFromLeftOutHousePeoperty__VisibilityStatus=false;


      });
    }
    else if(selectedHeadName=="Housing Loan Details")
    {

      setState(() {
        chapterVI_VisibilityStatus=false;
        us80c__VisibilityStatus=false;
        otherIncomeDetails__VisibilityStatus=false;
        housingLoan__VisibilityStatus=true;
        rentPaidDetails__VisibilityStatus=false;
        carDetails__VisibilityStatus=false;
        incomeFromLeftOutHousePeoperty__VisibilityStatus=false;

        /*--------------6-12-2021 start-------------*/


        if(checkStatusType==Method.getUpload_UserArriveFromView_ToAddHouseLoan())
        {
          //show data views
          housingLoan__VisibilityStatus_Add=true;
          housingLoan__VisibilityStatus_View=false;
        }
        else
        {
          housingLoan__VisibilityStatus_Add=true;
          housingLoan__VisibilityStatus_View=false;
          checkView_Details(WebApi.gate_UploadInvestmentProof_HomeLoanDetails,"HomeLoan");
        }
        /*--------------6-12-2021 end-------------*/

      });
    }
    else if(selectedHeadName=="Rent Paid Details")
    {
      setState(() {
        chapterVI_VisibilityStatus=false;
        us80c__VisibilityStatus=false;
        otherIncomeDetails__VisibilityStatus=false;
        housingLoan__VisibilityStatus=false;
        rentPaidDetails__VisibilityStatus=true;
        carDetails__VisibilityStatus=false;
        incomeFromLeftOutHousePeoperty__VisibilityStatus=false;

        /*--------------6-12-2021 start-------------*/


        if(checkStatusType==Method.getUpload_UserArriveFromView_ToAddRentDetails())
        {
          //show data views
          rentDetails__VisibilityStatus_Add=true;
          rentDetails__VisibilityStatus_View=false;
        }
        else
        {
          rentDetails__VisibilityStatus_Add=true;
          rentDetails__VisibilityStatus_View=false;
          checkView_Details(WebApi.get_UploadInvestmentProof_HRA,"RentDetails");
        }
        /*--------------6-12-2021 end-------------*/
      });
    }
    else if(selectedHeadName=="Car Details")
    {
      setState(() {
        chapterVI_VisibilityStatus=false;
        us80c__VisibilityStatus=false;
        otherIncomeDetails__VisibilityStatus=false;
        housingLoan__VisibilityStatus=false;
        rentPaidDetails__VisibilityStatus=false;
        carDetails__VisibilityStatus=true;
        incomeFromLeftOutHousePeoperty__VisibilityStatus=false;
      });
    }else if(selectedHeadName=="Income from Let Out House Property")
    {

      setState(() {
        chapterVI_VisibilityStatus=false;
        us80c__VisibilityStatus=false;
        otherIncomeDetails__VisibilityStatus=false;
        housingLoan__VisibilityStatus=false;
        rentPaidDetails__VisibilityStatus=false;
        carDetails__VisibilityStatus=false;
        incomeFromLeftOutHousePeoperty__VisibilityStatus=true;
      });
    }else
    {

    }
  }

  getTax_Heads() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.tax_investment_heads),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
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

        investment_declaration_taxSection_ModelResponse = Investment_Declaration_TaxSection_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(investment_declaration_taxSection_ModelResponse!.statusCode==true)
        {
          SharedPreference.setIncomeTax_HeadsDescription(investment_declaration_taxSection_ModelResponse!.data![0].subHeadName);
          SharedPreference.setIncomeTax_HeadsFinancialYear(investment_declaration_taxSection_ModelResponse!.data![0].financialYear);
          SharedPreference.setIncomeTax_HeadsId(investment_declaration_taxSection_ModelResponse!.data![0].id);

          setState(() {
            investment_declaration_taxSection_ModelResponse=investment_declaration_taxSection_ModelResponse;
            dropDown_VisibilityStatus=true;
          });
        }
        else
        {
          if (investment_declaration_taxSection_ModelResponse!.message==null || investment_declaration_taxSection_ModelResponse!.message=="")
          {
            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, investment_declaration_taxSection_ModelResponse!.message);
            // show_OKAlert(investment_declaration_taxSection_ModelResponse.message);
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

  /*--------------6-12-2021 start-------------*/

  checkView_Details(String requestServiceURL,String serviceType) async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            requestServiceURL),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },

        body: {
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'financial_year': financialYear,
        },

      );
      //print(response.statusCode);
      if (response.statusCode == 200)
      {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        Map results =  json.decode(response.body);


        //print(response.body);

        //print(results['statusCode']);
        //print(results['message']);
        //print(results['data']);

        if(results['statusCode']==true)
        {
          List dataArr=results['data'];

          if(serviceType=="HomeLoan") {
            if (dataArr.length > 0) {
              setState(() {
                housingLoan__VisibilityStatus_Add = false;
                housingLoan__VisibilityStatus_View = true;
              });
            }
            else {
              setState(() {
                housingLoan__VisibilityStatus_Add = true;
                housingLoan__VisibilityStatus_View = false;
              });
            }
          }
          else if(serviceType=="RentDetails") {
            if (dataArr.length > 0) {
              setState(() {
                rentDetails__VisibilityStatus_Add = false;
                rentDetails__VisibilityStatus_View = true;
              });
            }
            else {
              setState(() {
                rentDetails__VisibilityStatus_Add = true;
                rentDetails__VisibilityStatus_View = false;
              });
            }
          }
          else if(serviceType=="ChapterVI") {
            if (dataArr.length > 0) {
              setState(() {
                chapterVI__VisibilityStatus_Add = false;
                chapterVI__VisibilityStatus_View = true;
              });
            }
            else {
              setState(() {
                chapterVI__VisibilityStatus_Add = true;
                chapterVI__VisibilityStatus_View = false;
              });
            }
          }
          else if(serviceType=="US80C")  {
            if (dataArr.length > 0) {
              setState(() {
                us80C__VisibilityStatus_Add = false;
                us80C__VisibilityStatus_View = true;
              });
            }
            else {
              setState(() {
                us80C__VisibilityStatus_Add = true;
                us80C__VisibilityStatus_View = false;
              });
            }
          }

        }
        else
        {

        }


      } else {

        EasyLoading.dismiss();

        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }


    catch(e){
      //print(e);
    }

  }

  checkView_DetailsFor_ChapterVIor80C(String requestServiceURL,String serviceType,String headId) async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            requestServiceURL),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },

        body: {
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'financial_year': financialYear,
          'head_id': headId,
        },

      );
      //print(response.statusCode);
      if (response.statusCode == 200)
      {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        Map results =  json.decode(response.body);


        //print(response.body);

        //print(results['statusCode']);
        //print(results['message']);
        //print(results['data']);

        if(results['statusCode']==true)
        {
          List dataArr=results['data'];

          if(serviceType=="HomeLoan") {
            if (dataArr.length > 0) {
              setState(() {
                housingLoan__VisibilityStatus_Add = false;
                housingLoan__VisibilityStatus_View = true;
              });
            }
            else {
              setState(() {
                housingLoan__VisibilityStatus_Add = true;
                housingLoan__VisibilityStatus_View = false;
              });
            }
          }
          else if(serviceType=="RentDetails") {
            if (dataArr.length > 0) {
              setState(() {
                rentDetails__VisibilityStatus_Add = false;
                rentDetails__VisibilityStatus_View = true;
              });
            }
            else {
              setState(() {
                rentDetails__VisibilityStatus_Add = true;
                rentDetails__VisibilityStatus_View = false;
              });
            }
          }
          else if(serviceType=="ChapterVI") {
            if (dataArr.length > 0) {
              setState(() {
                chapterVI__VisibilityStatus_Add = false;
                chapterVI__VisibilityStatus_View = true;
              });
            }
            else {
              setState(() {
                chapterVI__VisibilityStatus_Add = true;
                chapterVI__VisibilityStatus_View = false;
              });
            }
          }
          else if(serviceType=="US80C")  {
            if (dataArr.length > 0) {
              setState(() {
                us80C__VisibilityStatus_Add = false;
                us80C__VisibilityStatus_View = true;
              });
            }
            else {
              setState(() {
                us80C__VisibilityStatus_Add = true;
                us80C__VisibilityStatus_View = false;
              });
            }
          }

        }
        else
        {

        }


      } else {

        EasyLoading.dismiss();

        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }


    catch(e){
      //print(e);
    }

  }

  /*--------------6-12-2021 end-------------*/

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

}