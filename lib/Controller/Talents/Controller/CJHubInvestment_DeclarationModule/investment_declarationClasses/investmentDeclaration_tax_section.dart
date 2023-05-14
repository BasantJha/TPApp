import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//import 'package:flutter_app/Constants.dart';
//import 'package:flutter_app/Design_UI/InvestmentDeclaration_ChapterVI.dart';
import 'package:http/http.dart'as http;


import '../../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJHubCustomView/AutoLogout.dart';
import '../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';

import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';

import '../ModelClasses/Investment_Declaration_TaxSection_ModelResponse.dart';
import '../investment_declarationClasses/Investment_Declaration_RentPaidDetails_Master.dart';
import '../investment_declarationClasses/investmentDeclaration_ChapterVI.dart';
import '../investment_declarationClasses/investmentDeclaration_US80C.dart';
import '../investment_declarationClasses/investmentDeclaration_carDetails.dart';
import '../investment_declarationClasses/investmentDeclaration_housingLoanDetails.dart';
import '../investment_declarationClasses/investmentDeclaration_incomeFromLetOutHouseProperty.dart';
import '../investment_declarationClasses/investmentDeclaration_otherIncomeDetails.dart';


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
      home: investmentDeclaration_tax_section(title: 'CJ Hub'),
    );
  }
}
class investmentDeclaration_tax_section extends StatefulWidget {

  investmentDeclaration_tax_section({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _investmentDeclaration_tax_section createState() => _investmentDeclaration_tax_section();

}

class _investmentDeclaration_tax_section extends State<investmentDeclaration_tax_section>
{
  // This widget is the root of your application.
  String valueChoose = "Chapter-VI";

  // Data selected_TaxSection=Data(id: "1",financialYear: "2021-22",headName: "Dummy");
  Data? selected_TaxSection;

  /* List listItem =["Chapter-VI","U/S 80 C","Other Income Details","Housing Loan Details",
    "Rent Paid Details","Car Details","Income from Let Out House Property"];
*/

  Investment_Declaration_TaxSection_ModelResponse? investment_declaration_taxSection_ModelResponse;

  bool chapterVI_VisibilityStatus=true,
      us80c__VisibilityStatus=false,
      otherIncomeDetails__VisibilityStatus=false,
      housingLoan__VisibilityStatus=false,
      rentPaidDetails__VisibilityStatus=false,
      carDetails__VisibilityStatus=false,
      incomeFromLeftOutHousePeoperty__VisibilityStatus=false;
  bool dropDown_VisibilityStatus=false;


  String financialYear="2021-2022";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreference.setIncomeTax_HeadsId("1");
    loadBasicDetails();

    getTax_Heads();

    if(kIsWeb){

      //print("This CJ Hub investment_declaration tax section Web");

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

  loadBasicDetails()
  {
    SharedPreference.getIncomeTax_HeadsFinancialYear().then((value) =>  {
      financialYear=value,
      //print('show emp getIncomeTax_HeadsFinancialYear $value'),
      loadFinancialYear(financialYear)
    });
  }

 /*--------23-4-2022 start---------*/

  loadFinancialYear(String fYear)
  {
    setState(() {
      financialYear=fYear;

    });
  }

  /*--------23-4-2022 end---------*/

  /*----------------start 13-06-2022------------------*/
  Column mainFunction_investmentDeclarationUI(){
    return new Column(
      children: <Widget>[
        // new FlutterLogo(size: 100.0,),
        new Container(
          child:Column(children: <Widget>[

            create_headingContainer("Investment Declaration F.Y($financialYear)" ),

            create_taxBannerContainer("Please check your PAN No. before submission. If any discrepancy found please contact your HR/Accounts Dept. immediately."),

            create_ChooseText("Choose Option"),

            dropDownButton_Container(),
            // create_Container()
            SizedBox(
              height: 0,
            )

          ]),
        ),
        Expanded(
          child:  new Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10,0,10,10),
                child:

                load_Visible_SectionData()

            ),
          ),
        ),
        // new FlutterLogo(size: 100.0,),
      ],
    );
  }
  /*----------------end 13-06-2022--------------------*/

  @override
  Widget build(BuildContext context)
  {
    var size = MediaQuery.of(context).size;

    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handleUserInteraction,
        onPointerMove: _handleUserInteraction,
        onPointerUp: _handleUserInteraction,
        child:
      Scaffold(
        backgroundColor: Colors.white,

      body: new NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              leading: /*BackButton(
                color: Colors.black,
                onPressed:()
                {
                  Navigator.of(context).pop();
                  *//*------------21-11-2022(use)---------*//*
                },
              )*/Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10, 0, 2),
                child: ElevatedButton(
                  onPressed: ()
                  {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color(0xFFD9D9D9),
                      minimumSize: Size.zero,
                      padding: EdgeInsets.all(-12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                      maximumSize: Size.zero),

                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 25,
                    color: appBarBackButtonColor,
                  ),
                ) ,) ,

              pinned: true,
              floating: false,
              forceElevated: innerBoxIsScrolled,
              //backgroundColor: Color(0xfff0f0f2),
              backgroundColor: whiteColor,

               centerTitle: true,
                title: new Text(
                  getCJHUB_InvestmentDeclarationTitle,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: appBarTitleFontWeight,
                    fontFamily: viewHeadingFontfamily,
                    fontWeight: bold_FontWeight,
                  ),
                )
              //title: new Image.asset(getCJHub_AppLogo,height: 90,width: 90,),
            ),
          ];
        },
        body: Responsive(
            mobile: mainFunction_investmentDeclarationUI(),
            tablet: Center(
                child:  Container(
                  width: flutterWeb_tabletWidth,
                  child:mainFunction_investmentDeclarationUI(),
                )
            ),
            desktop: Center(
              child: Container(
                width: flutterWeb_desktopWidth,
                child: mainFunction_investmentDeclarationUI(),
              ),
            )

        ),
      ),

    )
    ); //second option
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
                style: TextStyle(color: Colors.black,fontSize: 18),),
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
        padding: const EdgeInsets.fromLTRB(10,10,10,0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(text,style: TextStyle(color: primaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
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
              padding: const EdgeInsets.only(left:10,right: 10,top: 5,bottom: 0),
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

  Visibility loadDropDown_VisibleData() {

    if (dropDown_VisibilityStatus == true)
    {
      /*------load live data in dropdown start------*/

      return Visibility(
          visible: true,
          child: DropdownButton(
            hint: Text('Chapter-VI'),
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
            hint: Text('Chapter-VI'),
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

  Container create_Container()
  {
    return
      Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height,
        //color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,10,10,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: load_Visible_SectionData()
              )


            ],
          ),
        ),
      );
  }

  Visibility load_Visible_SectionData() {

    if (chapterVI_VisibilityStatus == true) {
      return Visibility(
          visible: chapterVI_VisibilityStatus,
          child: investmentDeclaration_ChapterVI()
      );
    }
    else if (us80c__VisibilityStatus == true) {
      return Visibility(
          visible: us80c__VisibilityStatus,
          child: investmentDeclaration_US80C()
      );
    }
    else if (otherIncomeDetails__VisibilityStatus == true) {
      return Visibility(
          visible: otherIncomeDetails__VisibilityStatus,
          child: investmentDeclaration_otherIncomeDetails()
      );
    }
    else if (housingLoan__VisibilityStatus == true) {
      return Visibility(
          visible: housingLoan__VisibilityStatus,
          child: investmentDeclaration_housingLoanDetails()
      );
    }
    else if (rentPaidDetails__VisibilityStatus == true) {
      return Visibility(
          visible: rentPaidDetails__VisibilityStatus,
          //child: Investment_Declaration_RentPaidDetails()
          child: Investment_Declaration_RentPaidDetails_Master()

      );
    }
    else if (carDetails__VisibilityStatus == true) {
      return Visibility(
          visible: carDetails__VisibilityStatus,
          child: investmentDeclaration_carDetails()
      );
    }
    else if (incomeFromLeftOutHousePeoperty__VisibilityStatus == true) {
      return Visibility(
          visible: incomeFromLeftOutHousePeoperty__VisibilityStatus,
          child: investmentDeclaration_incomeFromLetOutHouseProperty()
      );
    }
    else
      {
        return Visibility(visible: false,child: Text("record not found"),);
      }
  }

  // ignore: non_constant_identifier_names
  load_SelectedData(Data obj)
  {

    setState(()
    {
      SharedPreference.setIncomeTax_HeadsDescription(obj.subHeadName);
      SharedPreference.setIncomeTax_HeadsFinancialYear(obj.financialYear);
      SharedPreference.setIncomeTax_HeadsId(obj.id);
      selected_TaxSection = obj;
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