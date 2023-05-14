import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'dart:io' as Io;

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:http/http.dart'as http;


import 'package:universal_html/html.dart' as html;

import '../../../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../../../Constant/Constants.dart';
import '../../../../../../Constant/Responsive.dart';
import '../../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../../CustomView/CJHubCustomView/AutoLogout.dart';
import '../../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../../CustomView/CJHubCustomView/ValidateClass.dart';
import '../../../../../../CustomView/CJHubCustomView/palatte_Textstyle.dart';
import '../../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../../Services/Messages/Message.dart';

import '../../Investment_UploadDocumentClasses/UploadInvestmentProof.dart';
import '../../Investment_UploadDocumentClasses//UploadInvestmentProof_Image_View.dart';
import '../../Investment_UploadDocumentClasses/UploadInvestmentProof_Pdf_View.dart';
import '../UploadInestmentProof_VI/UploadInvestmentProof_VI_Update.dart';
import '../../UploadInvestmentProof_ModelClasses/ChapterVI_View_ModelResponse.dart';

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
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CJ Hub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UploadInvestmentProof_VI_View(title: 'CJ Hub'),
    );
  }
}
class UploadInvestmentProof_VI_View extends StatefulWidget {

  UploadInvestmentProof_VI_View({Key? key, this.title,this.userArriveFrom_AddToView_or_DirectView}) : super(key: key);

  final String? title;
  final String? userArriveFrom_AddToView_or_DirectView;

  @override
  _UploadInvestmentProof_VI_View createState() => _UploadInvestmentProof_VI_View(userArriveFrom_AddToView_or_DirectView!);
}

class _UploadInvestmentProof_VI_View extends State<UploadInvestmentProof_VI_View> {
  // This widget is the root of your application.

  String empCode="",empName="",panNumber="";
  String completeEmpCode="";
  String financialYear="2021-22";

  String investment_name="testing";
  String receipt_amount="testing";
  String receipt_number="testing";
  String receipt_date="testing";
  String approval_status="testing";
  String document_path="testing";
  String document_name="testing";
  String original_document_name="testing";

  ChapterVI_View_ModelResponse? chapterVI_View_ModelResponse;

  /*------------------31-12-2021 start------------------*/
  bool editButton_Visibility=true;
  bool approvedRejectedText_Visibility=false;
  String approvedRejectedText="";
  Colors? colorType;
  TextStyle textStyle_approvedRejected=TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 13);
  /*------------------31-12-2021 end------------------*/


  bool documentDefault_Visibility=true;
  bool documentDynamic_ImageVisibility=false;
  bool documentDynamic_PDFVisibility=false;

  String parents_senior_citizen = "N";
  String disability_dependent = "N";
  String employee_disability = "N";


  List<Data> chapterVIDataArr=[Data(investmentName: "",receiptAmount: "",receiptNumber: "",receiptDate: "",approvalStatus: "",
      documentName: "",documentPath: "",originalDocumentName:"",parentSeniorCitizen: "",employeeWithSevereDisability: "",disabilityMoreThan80: "" ),
  ];

  PDFDocument? _pdf;
  bool _isLoading = true;

  /*---------------------8-12-2021 start------------------*/

  bool appBarVisibility=false;
  String? userArriveFrom_AddToView_or_DirectView;
  _UploadInvestmentProof_VI_View(String userArriveFrom_AddToView_or_DirectView)
  {
    this.userArriveFrom_AddToView_or_DirectView=userArriveFrom_AddToView_or_DirectView;

    if(userArriveFrom_AddToView_or_DirectView=="AddToChapterVIView")
    {
      //user arrive from Add to View

      appBarVisibility=true;
    }
    else if(userArriveFrom_AddToView_or_DirectView=="DirectChapterVIView")
    {
      //user arrive from UploadInvestmentProof to view means records available then show the view

      appBarVisibility=false;

    }
  }

  /*---------------------8-12-2021 end------------------*/


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBasicInfo();

    if(kIsWeb){

      //print("This Upload CJ Hub tax section Web");

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

  /*------------------4-12-2021 start---------------------*/

  IconButton addRight_IconButton(BuildContext buildContext)
  {
    return IconButton(
      icon:  Icon(Icons.upload_file),
      color: Colors.black,
      tooltip: 'Continue to Add',
      iconSize: 30,
      onPressed: ()
      {

        Navigator.push(buildContext,MaterialPageRoute(builder: (_)=>

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
            ), )
            // UploadInvestmentProof()

        ));

      },
    );
  }

  /*IconButton addRight_IconButton = IconButton(
    icon:  Icon(Icons.upload_file),
    color: Colors.black,
    tooltip: 'Continue to Add',
    iconSize: 30,
    onPressed: ()
    {

      //Navigator.push(BuildContext context,MaterialPageRoute(builder: (context)=>UploadInvestmentProof_VI_Add()));

    },
  );*/

  /*------------------4-12-2021 end---------------------*/

  @override
  Widget build(BuildContext context) {
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handleUserInteraction,
        onPointerMove: _handleUserInteraction,
        onPointerUp: _handleUserInteraction,
        child:
      Scaffold(

        /*---------------------8-12-2021 start------------------*/

        appBar: appBarVisibility
            ? /*AppBar(
          leading: BackButton(
              color: Colors.black
          ) ,backgroundColor: Color(0xfff0f0f2),centerTitle: true,
          title: Image.asset(getCJHub_AppLogo,height: 90,width: 90,),

        )*/
         CJAppBar("", appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show the action 1type");
            Navigator.pop(context);

          }))
            : PreferredSize(
          child: Container(),
          preferredSize: Size(0.0, 0.0),
        ),

        floatingActionButton: FloatingActionButton(

          backgroundColor: Colors.blue,

          child: Icon(Icons.add),


          onPressed: ()
          {
            Navigator.push(context,MaterialPageRoute(builder: (_)=>

            Responsive(
                mobile:UploadInvestmentProof(checkStatusType: Method.getUpload_UserArriveFromView_ToAddChapterVI()),
                tablet: Center(
                  child: Container(
                    width: flutterWeb_tabletWidth,
                    child: UploadInvestmentProof(checkStatusType: Method.getUpload_UserArriveFromView_ToAddChapterVI()),
                  ),
                ),
                desktop: Center(
                  child: Container(
                    width: flutterWeb_desktopWidth,
                    child: UploadInvestmentProof(checkStatusType: Method.getUpload_UserArriveFromView_ToAddChapterVI()),
                  ),
                ), )
                // UploadInvestmentProof(checkStatusType: Method.getUpload_UserArriveFromView_ToAddChapterVI(),

                ));

          },

        ),

        /*---------------------8-12-2021 end------------------*/


        /*------------6-12-2021 START------------*/
        /* floatingActionButton: FloatingActionButton(

          backgroundColor: Colors.blue,

          child: Icon(Icons.add),

          onPressed: ()
          {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>UploadInvestmentProof()));

          },

        ),*/

        /*------------6-12-2021 END------------*/

        body: chapterVIDataArr.isNotEmpty ?
        ListView.builder(
            padding: EdgeInsets.only(bottom: 90.0),
            shrinkWrap: true,
            itemCount: chapterVIDataArr.length,
            itemBuilder: (BuildContext context, int index)
            {
              Data data = chapterVIDataArr[index];

              if(chapterVIDataArr.length>0)
              {

                Data dataObj = chapterVIDataArr[index];

                investment_name=dataObj.investmentName;
                receipt_date = dataObj.receiptDate;
                receipt_number = dataObj.receiptNumber;
                receipt_amount = dataObj.receiptAmount;
                approval_status = dataObj.approvalStatus;
                document_path = dataObj.documentPath;
                document_name = dataObj.documentName;
                original_document_name = dataObj.originalDocumentName;


                parents_senior_citizen=dataObj.parentSeniorCitizen;
                disability_dependent=dataObj.disabilityMoreThan80;
                employee_disability=dataObj.employeeWithSevereDisability;



                //print(document_path);
                //print(document_name);

                /*------------------1-12-2021 start------------------*/


                /*------------------29-1-2022 start------------------*/
                String fileName_Extension="";
                if(original_document_name=="")
                {

                }
                else
                {
                  fileName_Extension=original_document_name.split(".").last;
                }
                //print('show extension $fileName_Extension');
                /*------------------29-1-2022 end------------------*/


                if(document_path=="" || document_path==null)
                {
                  documentDefault_Visibility=true;
                  documentDynamic_ImageVisibility=false;
                  documentDynamic_PDFVisibility=false;
                }
                else
                {

                  if(fileName_Extension=="PDF" || fileName_Extension=="pdf")
                  {

                    documentDefault_Visibility = false;
                    documentDynamic_ImageVisibility = false;
                    documentDynamic_PDFVisibility = true;

                  }
                  else
                  {
                    /*---USE FOR IMAGES LIKES THAT (PNG,JPEG AND OTHER FORMAT)---*/
                    documentDefault_Visibility = false;
                    documentDynamic_ImageVisibility = true;
                    documentDynamic_PDFVisibility = false;

                  }
                }

                /*------------------31-12-2021 start------------------*/
                if(dataObj.approvalStatus=="P")
                {

                  editButton_Visibility=true;
                  approvedRejectedText_Visibility=false;
                }
                else if(dataObj.approvalStatus=="A")
                {
                  textStyle_approvedRejected=TextStyle(fontFamily: 'Vonique',color: Colors.green,fontSize: 14);
                  approvedRejectedText="Approved";
                  editButton_Visibility=false;
                  approvedRejectedText_Visibility=true;

                }
                else if(dataObj.approvalStatus=="R")
                {
                  textStyle_approvedRejected=TextStyle(fontFamily: 'Vonique',color: Colors.red,fontSize: 14);
                  approvedRejectedText="Rejected";
                  editButton_Visibility=false;
                  approvedRejectedText_Visibility=true;

                }
                else
                {
                  //other case
                  editButton_Visibility=false;
                }


              }
              else
              {

              }


              return   new Padding(padding: new EdgeInsets.only(top: 5,left: 10,right: 10),
                  child:Card(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                    child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              // color: white,
                              child:  ListTile(
                                contentPadding: EdgeInsets.only(left: 5,right: 5),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Container(
                                      // color: Colors.greenAccent,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex:1,
                                              child: Container(
                                                // color:Colors.yellow,
                                                //   width: MediaQuery.of(context).size.width*0.45,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        /* width: MediaQuery.of(context).size.width*0.19,
                                                        height: 30,*/

                                                          child: Expanded(
                                                            flex:1,
                                                            child:Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(investment_name,style: k80C_VI_Edit_value,),
                                                            ),
                                                          )
                                                      ),

                                                    ],
                                                  )
                                              ),),

                                          ],
                                        )
                                    ),

                                    /*----------3-12-2021 start----------*/
                                    Container(
                                      // color: Colors.greenAccent,
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex:1,
                                              child: Container(
                                                // color:Colors.yellow,
                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex:3,
                                                          child: Container(
                                                        width: MediaQuery.of(context).size.width*0.19,
                                                        // height: 30,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("Parents Senior Citizen (Claim Under 80D)",
                                                            style: VI_View_black,),
                                                        ),
                                                      )),

                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          height: 30,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text(":",style: VI_View,),
                                                          ),
                                                        ),
                                                      ),

                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width*0.1,
                                                          height: 30,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0),
                                                              child: Text(parents_senior_citizen,
                                                                style: VI_View_value,),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ),),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                // color: Colors.yellow,
                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width*0.19,
                                                            // height: 30,
                                                            child:Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Text("Disability More Than 80% with Dependent (80DD)",
                                                                style: VI_View_black,),
                                                            ),
                                                          )),

                                                      Expanded(
                                                        flex: 1,
                                                          child: Container(
                                                        height: 30,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(":",style: VI_View,),
                                                        ),
                                                      )),

                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          height: 30,
                                                          width: MediaQuery.of(context).size.width*0.1,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0),
                                                              child: Text(disability_dependent,
                                                                style: VI_View_value,),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ),),

                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                // color: Colors.yellow,
                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex:3,
                                                          child: Container(
                                                        width: MediaQuery.of(context).size.width*0.19,
                                                        // height: 30,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("Employee with Severe Disability",style: VI_View_black,),
                                                        ),
                                                      )),

                                                      Expanded(
                                                        flex: 1,
                                                          child: Container(
                                                        height: 30,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(":",style: VI_View,),
                                                        ),
                                                      )),

                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          height: 30,
                                                          width: MediaQuery.of(context).size.width*0.1,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0),
                                                              child: Text(employee_disability,
                                                                style: VI_View_value,),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ),)

                                          ],
                                        )
                                    ),
                                    /*----------3-12-2021 end----------*/

                                    Container(
                                      // color: Colors.greenAccent,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child:Container(
                                                  width: MediaQuery.of(context).size.width*0.45,
                                                  // color:Colors.yellow,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      Expanded(
                                                        flex:1,
                                                          child: Container(
                                                        width: MediaQuery.of(context).size.width*0.19,
                                                        height: 40,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("Receipt No",
                                                            style: kHRA_Edit,),
                                                        ),
                                                      )),

                                                       Container(
                                                          height: 40,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text(":",
                                                              style: kHRA_Edit,),
                                                          ),
                                                        ),


                                                       Container(
                                                          height: 40,
                                                          width: 100,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0),
                                                              child: Text(receipt_number,
                                                                style: kHRA_Edit_value,),
                                                            ),
                                                          ),
                                                        ),

                                                    ],
                                                  )
                                              ),),

                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                  width: MediaQuery.of(context).size.width*0.45,
                                                  // color:Colors.yellow,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width*0.19,
                                                          height: 40,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text("Receipt Date",
                                                              style: kHRA_Edit,),
                                                          ),
                                                        ),
                                                      ),

                                                       Container(
                                                        height: 40,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(":",
                                                            style: kHRA_Edit,),
                                                        ),
                                                      ),

                                                       Container(
                                                          height: 40,
                                                          width: 100,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0),
                                                              child: Text(receipt_date,
                                                                style: kHRA_Edit_value,),
                                                            ),
                                                          ),
                                                        ),

                                                    ],
                                                  )
                                              ),),
                                          ],
                                        )
                                    ),

                                    /*----receipt amount and document------*/
                                    Container(
                                      // color: Colors.greenAccent,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child:Container(
                                                  width: MediaQuery.of(context).size.width*0.45,
                                                  // color:Colors.yellow,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                          flex:1,
                                                          child: Container(
                                                        width: MediaQuery.of(context).size.width*0.19,
                                                        height: 40,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("Receipt Amount",
                                                            style: kHRA_Edit,),
                                                        ),
                                                      )),

                                                       Container(
                                                          height: 40,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text(":",
                                                              style: kHRA_Edit,),
                                                          ),
                                                        ),


                                                       Container(
                                                          width: 100,
                                                          height: 40,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0),
                                                              child: Text(receipt_amount,
                                                                style: kHRA_Edit_value,),
                                                            ),
                                                          ),
                                                        ),

                                                    ],
                                                  )
                                              ),),

                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                  width: MediaQuery.of(context).size.width*0.45,
                                                  padding: const EdgeInsets.only(top: 10),
                                                  // color:Colors.yellow,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      new Container(
                                                        child: Stack(
                                                          children: <Widget>[

                                                            /*------------------1-12-2021 start------------------*/

                                                            /*    Visibility(visible: documentDefault_Visibility,
                                                            child:
                                                            Image.asset('document.jpeg',
                                                              height: 50,
                                                              width: 50,
                                                            ),
                                                            ),

                                                            Visibility(visible: documentDynamic_ImageVisibility,
                                                              child:
                                                              Align(
                                                                child:Image.network(document_path,
                                                                    width: 80,height: 70),
                                                              ),
                                                            ),

                                                            Visibility(visible: documentDynamic_PDFVisibility,
                                                                child: new Container(
                                                                  height: 60,
                                                                  width: 50,
                                                                  decoration: Style_UploadInvestment_All_Border,

                                                                  child: _isLoading ? Center(child: CircularProgressIndicator(),)
                                                                      : PDFViewer(document: _pdf,
                                                                    showPicker: false,
                                                                    showIndicator: false,
                                                                    showNavigation: false,


                                                                  ),

                                                                )
                                                              *//*------------------1-12-2021 end------------------*//*

                                                            )
*/

                                                            /*---------10-2-2022 start-------*/
                                                            Text.rich(

                                                              TextSpan(
                                                                  text: 'View Document',recognizer: TapGestureRecognizer()
                                                                ..onTap = ()
                                                                {
                                                                  //print('view document');

                                                                  Data dataObj = chapterVIDataArr[index];
                                                                  document_path = dataObj.documentPath;
                                                                  document_name = dataObj.documentName;
                                                                  original_document_name = dataObj.originalDocumentName;
                                                                  //print(document_path);
                                                                  //print(document_name);

                                                                  /*------------------1-12-2021 start------------------*/


                                                                  /*------------------29-1-2022 start------------------*/
                                                                  String fileName_Extension="";
                                                                  if(original_document_name=="")
                                                                  {

                                                                  }
                                                                  else
                                                                  {
                                                                    fileName_Extension=original_document_name.split(".").last;
                                                                  }
                                                                  //print('show extension $fileName_Extension');
                                                                  /*------------------29-1-2022 end------------------*/

                                                                  if(document_path=="" || document_path==null)
                                                                  {

                                                                  }
                                                                  else
                                                                  {

                                                                    if(fileName_Extension=="PDF" || fileName_Extension=="pdf")
                                                                    {

                                                                    if(kIsWeb){

                                                                    //print('This is for web');

                                                                    html.window.open(document_path,'document fileName');

                                                                    // Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                                                    //
                                                                    //     Responsive(
                                                                    //       mobile: UploadInvestmentProof_Web_Pdf_View(urlStr: document_path,),
                                                                    //       tablet: Center(
                                                                    //         child: Container(
                                                                    //           width: flutterWeb_tabletWidth,
                                                                    //           child: UploadInvestmentProof_Web_Pdf_View(urlStr: document_path,),
                                                                    //         ),
                                                                    //       ),
                                                                    //       desktop: Center(
                                                                    //         child: Container(
                                                                    //           width: flutterWeb_desktopWidth,
                                                                    //           child: UploadInvestmentProof_Web_Pdf_View(urlStr: document_path,),
                                                                    //         ),
                                                                    //       ), )
                                                                    //   // UploadInvestmentProof_Pdf_View(urlStr: document_path,)
                                                                    //
                                                                    // ),);

                                                                    }

                                                                    else{
                                                                      Navigator.push(context, MaterialPageRoute(builder: (_) =>

                                                                          Responsive(
                                                                            mobile: UploadInvestmentProof_Pdf_View(urlStr: document_path,),
                                                                            tablet: Center(
                                                                              child: Container(
                                                                                width: flutterWeb_tabletWidth,
                                                                                child: UploadInvestmentProof_Pdf_View(urlStr: document_path,),
                                                                              ),
                                                                            ),
                                                                            desktop: Center(
                                                                              child: Container(
                                                                                width: flutterWeb_desktopWidth,
                                                                                child: UploadInvestmentProof_Pdf_View(urlStr: document_path,),
                                                                              ),
                                                                            ), )
                                                                        // UploadInvestmentProof_Pdf_View(urlStr: document_path,)

                                                                      ),);
                                                                    }

                                                                    }
                                                                    else
                                                                    {
                                                                      /*---USE FOR IMAGES LIKES THAT (PNG,JPEG AND OTHER FORMAT)---*/
                                                                      Navigator.push(context, MaterialPageRoute(builder: (_) =>

                                                                      Responsive(
                                                                        mobile: UploadInvestmentProof_Image_View(urlStr: document_path,),
                                                                       tablet: Center(
                                                                        child: Container(
                                                                          width: flutterWeb_tabletWidth,
                                                                          child: UploadInvestmentProof_Image_View(urlStr: document_path,),
                                                                        ),
                                                                      ),
                                                                      desktop: Center(
                                                                        child: Container(
                                                                          width: flutterWeb_desktopWidth,
                                                                          child: UploadInvestmentProof_Image_View(urlStr: document_path,),
                                                                        ),
                                                                      ),)
                                                                          // UploadInvestmentProof_Image_View(urlStr: document_path,)
                                                                      ),);

                                                                    }
                                                                  }


                                                                },
                                                                  style: TextStyle(
                                                                    decoration: TextDecoration.underline,
                                                                    decorationColor: Colors.black,
                                                                    fontSize: 13,
                                                                    //fontWeight: FontWeight.bold,
                                                                    color: Colors.black,
                                                                    decorationThickness: 2,
                                                                  )),

                                                            )

                                                            /*---------10-2-2022 end-------*/


                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                              ),),

                                          ],
                                        )
                                    ),

                                    /*----------add edit icon 29-1-2022 start ---------*/
                                    Visibility(visible: editButton_Visibility,child:
                                    Container(
                                        width: double.maxFinite,
                                        child: new Stack(
                                          children: <Widget>[
                                            Container(
                                              width: double.maxFinite,
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius: new BorderRadius.circular(0.0),
                                              ),
                                              // padding: const EdgeInsets.only(left: 10, right: 7),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  /*Container(
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.3,
                                                    height: 30,
                                                    decoration: new BoxDecoration(
                                                        shape: BoxShape.rectangle,
                                                        borderRadius: new BorderRadius.circular(20.0),
                                                        border: Border.all(color: primaryColor,
                                                            width: 1.0,
                                                            style: BorderStyle.solid)
                                                    ),
                                                    child: Material(
                                                      elevation: 0.0,
                                                      borderRadius: BorderRadius.circular(20.0),
                                                      color: primaryColor,
                                                      child:MaterialButton(
                                                          minWidth: 50,
                                                          // height: 10,
                                                          onPressed: ()
                                                          {
                                                            Data objData=chapterVIDataArr[index];
                                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadInvestmentProof_VI_Update(chapterVI_ObjData:objData)));

                                                          },
                                                          child: Text('Edit',
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 13))
                                                      ),
                                                    ),
                                                  ),*/

                                                  IconButton(
                                                    icon: Image.asset(getCJHub_EditBtnIcon,
                                                      width: 25.0,
                                                      height: 20.0,),
                                                    iconSize: 20,
                                                    onPressed: ()
                                                    {

                                                      Data objData=chapterVIDataArr[index];
                                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>

                                                      Responsive(
                                                          mobile: UploadInvestmentProof_VI_Update(chapterVI_ObjData:objData),
                                                          tablet: Center(
                                                            child: Container(
                                                              width: flutterWeb_tabletWidth,
                                                              child: UploadInvestmentProof_VI_Update(chapterVI_ObjData:objData),
                                                            ),
                                                          ),
                                                          desktop: Center(
                                                            child: Container(
                                                              width: flutterWeb_desktopWidth,
                                                              child: UploadInvestmentProof_VI_Update(chapterVI_ObjData:objData),
                                                            ),
                                                          ), )
                                                          // UploadInvestmentProof_VI_Update(chapterVI_ObjData:objData)

                                                      ));

                                                    },
                                                  ),
                                                ],
                                              ),

                                            ),
                                          ],
                                        )
                                    ),
                                    ),

                                    /*----------add approved & rejected text 31-1-2022 start ---------*/
                                    Visibility(visible: approvedRejectedText_Visibility,child:
                                    Container(
                                        width: double.maxFinite,
                                        child: new Stack(
                                          children: <Widget>[
                                            Container(
                                              width: double.maxFinite,
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius: new BorderRadius.circular(0.0),
                                              ),
                                              // padding: const EdgeInsets.only(left: 10, right: 7),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.3,
                                                    height: 30,

                                                    child: Material(
                                                      elevation: 0.0,
                                                      child:MaterialButton(
                                                          minWidth: 60,
                                                          // height: 10,
                                                          onPressed: ()
                                                          {

                                                          },
                                                          child: Text(approvedRejectedText,
                                                              textAlign: TextAlign.right,
                                                              style: textStyle_approvedRejected)
                                                      ),
                                                    ),
                                                  ),


                                                ],
                                              ),

                                            ),
                                          ],
                                        )
                                    ),
                                    )
                                  ],
                                ),

                                dense: false,
                              ),
                            )

                          ],
                        )

                    ),

                  )
              );

            }
        ): Center(
          child: Text("Data not found",textAlign: TextAlign.center,),
        ),



      )
    );
  }

  getBasicInfo()
  {

    SharedPreference.getIncomeTax_HeadsFinancialYear().then((value) => {
      financialYear=value

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
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth_key=value,
      //print('show emp name2 $value'),
      completeEmpCode = mobileNumber_key+"CJHUB"+empCode_key+"CJHUB"+empDateOfBirth_key,
      view_ChapterVI_Details()

    });

  }
  view_ChapterVI_Details() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.gate_UploadInvestmentProof_chapterVI),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },

        body: {
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'financial_year': financialYear,
          'head_id': "1",

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

        chapterVI_View_ModelResponse = ChapterVI_View_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(chapterVI_View_ModelResponse!.statusCode==true)
        {
          // show_OKAlert(hra_save_modelResponse.message);


          if(chapterVI_View_ModelResponse!.data!.length>0)
          {
            setState(() {
              chapterVIDataArr=chapterVI_View_ModelResponse!.data!;
            });

          }
          else
          {
            setState(() {
              chapterVIDataArr = [];
            });

            show_OKAlert("Data not found");

          }

        }
        else
        {
          if (chapterVI_View_ModelResponse!.message==null || chapterVI_View_ModelResponse!.message=="")
          {
            show_OKAlert("server error!");

          }else {
            show_OKAlert(chapterVI_View_ModelResponse!.message);
          }
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