import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_app/Constants.dart';
/*import 'package:flutter_app/Design_UI/HRA_Edit_Data.dart';
import 'package:flutter_app/Design_UI/InvestmentDeclaration_tax_section.dart';*/
import 'package:flutter_easyloading/flutter_easyloading.dart';
//import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:http/http.dart'as http;
/*import 'package:web/Encrypt/encrypt.dart';
import 'package:web/Investment_UploadDocumentModule/Investment_UploadDocumentClasses/UploadInvestmentProof.dart';
import 'package:web/Investment_UploadDocumentModule/Investment_UploadDocumentClasses/UploadInvestmentProof_HRA/UploadInvestmentProof_HRA_Update.dart';
import 'package:web/Investment_UploadDocumentModule/Investment_UploadDocumentClasses/UploadInvestmentProof_Image_View.dart';
import 'package:web/Investment_UploadDocumentModule/Investment_UploadDocumentClasses/UploadInvestmentProof_Pdf_View.dart';
import 'package:web/Investment_UploadDocumentModule/UploadInvestmentProof_ModelClasses/HRA_View_ModelResponse.dart';
import 'package:web/Message/Message.dart';
import 'package:web/customView/AutoLogout.dart';
import 'package:web/customView/Method.dart';
import 'package:web/customView/SharedPreference.dart';
import 'package:web/customView/palatte_Textstyle.dart';
import 'package:web/responsive/responsive_screen_width.dart';
import 'package:web/responsive/resposive.dart';
import 'package:web/webApi/WebApi.dart';*/
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
import '../../UploadInvestmentProof_ModelClasses/HRA_View_ModelResponse.dart';
import '../UploadInvestmentProof.dart';
import '../UploadInvestmentProof_Image_View.dart';
import '../UploadInvestmentProof_Pdf_View.dart';
import 'UploadInvestmentProof_HRA_Update.dart';

/*
import '../palatte_Textstyle.dart';
import 'US80C_data.dart';
import 'email_data.dart';
*/


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
      home: UploadInvestmentProof_HRA_View(title: 'CJ Hub'),
    );
  }
}
class UploadInvestmentProof_HRA_View extends StatefulWidget {

  UploadInvestmentProof_HRA_View({Key? key, this.title,this.userArriveFrom_AddToView_or_DirectView}) : super(key: key);

  final String? title;
  final String? userArriveFrom_AddToView_or_DirectView;

  @override
  _UploadInvestmentProof_HRA_View createState() => _UploadInvestmentProof_HRA_View(this.userArriveFrom_AddToView_or_DirectView!);
}

class _UploadInvestmentProof_HRA_View extends State<UploadInvestmentProof_HRA_View> {
  // This widget is the root of your application.
  bool _visible = true;
  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;

  List dataName = [
    "Medical claim(80D)",
    "Mediciam(Parents)(80D)",
    "imbhbhbh mmedical"
  ];


  String empCode="",empName="",panNumber="";
  String investmentDeclaration_Alert="Investment Declaration Open Between xxx To xxx";
  String completeEmpCode="";
  String financialYear="2021-22";

  String fromDate="testing";
  String toDate="testing";
  String receiptNo="testing";
  String receiptDate="testing";
  String rentAmount="testing";
  String landlordName="testing";
  String landlordAddress="testing";
  String landlordCity="testing";
  String landlordStateId="testing";
  String landlordStateName="testing";
  String landlordPanNo="testing";


  /*------------------31-12-2021 start------------------*/
  bool editButton_Visibility=true;
  bool approvedRejectedText_Visibility=false;
  String approvedRejectedText="";
  Colors? colorType;
  TextStyle textStyle_approvedRejected=TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 13);
  /*------------------31-12-2021 end------------------*/


  HRA_View_ModelResponse? hra_view_modelResponse;


  List<Data> hraDataArr=[Data(fromDate: "",toDate: "",receiptNo: '',receiptDate: "",
      rentAmount: "",landlordName: "",landlordAddress: "",landlordCity: "",landlordStateName: "",landlordPan: "",documentPath: "",originalDocumentName: ""),
  ];

  List<TextEditingController> _controllers = [];


  String document_path="testing";
  String document_name="testing";
  String original_document_name="testing";

  bool documentDefault_Visibility=true;
  bool documentDynamic_ImageVisibility=false;
  bool documentDynamic_PDFVisibility=false;

  PDFDocument? _pdf;
  bool _isLoading = true;

  /*---------------------8-12-2021 start------------------*/

  bool appBarVisibility=false;
  String userArriveFrom_AddToView_or_DirectView="";
  _UploadInvestmentProof_HRA_View(String userArriveFrom_AddToView_or_DirectView)
  {
    this.userArriveFrom_AddToView_or_DirectView=userArriveFrom_AddToView_or_DirectView;

    if(userArriveFrom_AddToView_or_DirectView=="AddToRentDetailsView")
    {
      //user arrive from Add to View

      appBarVisibility=true;
    }
    else if(userArriveFrom_AddToView_or_DirectView=="DirectHomeLoanView")
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

  @override
  Widget build(BuildContext context) {
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handleUserInteraction,
        onPointerMove: _handleUserInteraction,
        onPointerUp: _handleUserInteraction,
        child:
      Scaffold(

        /*  appBar: AppBar(leading: BackButton(
            color: Colors.black
        ), backgroundColor: Color(0xfff0f0f2),centerTitle: true,
          title: Image.asset('applogo.png',height: 90,width: 90,),),
*/

        /*---------------------8-12-2021 start------------------*/

        appBar: appBarVisibility
            ? /*AppBar(
          leading: BackButton(
              color: Colors.black
          ) ,backgroundColor: Color(0xfff0f0f2),centerTitle: true,
          title: Image.asset(getCJHub_AppLogo,height: 90,width: 90,),)*/
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

            Navigator.push(context,MaterialPageRoute(builder: (context)=>

            Responsive(
                mobile:  UploadInvestmentProof(checkStatusType: Method.getUpload_UserArriveFromView_ToAddRentDetails(),),
                tablet: Center(
                  child: Container(
                    width: flutterWeb_tabletWidth,
                    child:  UploadInvestmentProof(checkStatusType: Method.getUpload_UserArriveFromView_ToAddRentDetails(),)
                  ),
                ),
                desktop: Center(
                  child: Container(
                    width: flutterWeb_desktopWidth,
                    child: UploadInvestmentProof(checkStatusType: Method.getUpload_UserArriveFromView_ToAddRentDetails(),)
                  ),
                ),
            )

                // UploadInvestmentProof(checkStatusType: Method.getUpload_UserArriveFromView_ToAddRentDetails(),)

            ));

          },

        ),

        /*---------------------8-12-2021 end------------------*/


        body: hraDataArr.isNotEmpty ?
        ListView.builder(
            padding: EdgeInsets.only(bottom: 70.0),
            shrinkWrap: true,
            itemCount: hraDataArr.length,
            itemBuilder: (BuildContext context, int index)
            {

              _controllers.add(new TextEditingController());

              // HRA_Edit_Data data = hra_edit_data[index];

              //print('show selected index $index');
              if(hraDataArr.length>0)
              {
                Data dataObj = hraDataArr[index];

                fromDate = dataObj.fromDate;
                toDate = dataObj.toDate;
                receiptNo = dataObj.receiptNo;
                receiptDate = dataObj.receiptDate;
                rentAmount = dataObj.rentAmount;
                landlordName = dataObj.landlordName;
                landlordAddress = dataObj.landlordAddress;
                landlordCity = dataObj.landlordCity;
                landlordStateName = dataObj.landlordStateName;
                landlordPanNo = dataObj.landlordPan;

                document_path = dataObj.documentPath;
                document_name = dataObj.documentName;
                original_document_name = dataObj.originalDocumentName;


                //print(document_path);
                //print(document_name);


                /*------------------24-1-2022 start------------------*/
                String fileName_Extension="";
                if(original_document_name=="")
                {

                }
                else
                {
                  fileName_Extension=original_document_name.split(".").last;
                }
                //print('show extension $fileName_Extension');
                /*------------------24-1-2022 end------------------*/


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
                /*------------------1-12-2021 end------------------*/

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
                                              child:Container(
                                                // color:Colors.yellow,
                                                  width: MediaQuery.of(context).size.width*0.45,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                       Container(
                                                          // width: MediaQuery.of(context).size.width*0.19,
                                                          height: 30,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text("From",style: kHRA_Edit,),
                                                          ),
                                                        ),


                                                      Container(
                                                        height: 30,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(":",style: kHRA_Edit,),
                                                        ),
                                                      ),

                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          height: 30,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0),
                                                              child: Text(fromDate,
                                                                style: kHRA_Edit_value,),
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  )
                                              ),),
                                            Expanded(
                                              flex:1,
                                              child:Container(
                                                // color: Colors.yellow,
                                                  width: MediaQuery.of(context).size.width*0.45,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                       Container(
                                                        // width: MediaQuery.of(context).size.width*0.19,
                                                        height: 30,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("To",style: kHRA_Edit,),
                                                        ),
                                                      ),

                                                      Container(
                                                        height: 30,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(":",style: kHRA_Edit,),
                                                        ),
                                                      ),

                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          height: 30,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0),
                                                              child: Text(toDate,
                                                                style: kHRA_Edit_value,),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ),),
                                          ],
                                        )
                                    ),

                                    Container(
                                      // color: Colors.greenAccent,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex:1,
                                              child: Container(
                                                  width: MediaQuery.of(context).size.width*0.45,
                                                  // color:Colors.yellow,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      Container(
                                                        // width: MediaQuery.of(context).size.width*0.19,
                                                        height: 40,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("Receipt No",
                                                            style: kHRA_Edit,),
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

                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          height: 40,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0),
                                                              child: Text(receiptNo,
                                                                style: kHRA_Edit_value,),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ),),

                                            Expanded(
                                              flex:1,
                                              child:Container(
                                                  width: MediaQuery.of(context).size.width*0.45,
                                                  // color:Colors.yellow,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                       Container(
                                                          // width: MediaQuery.of(context).size.width*0.19,
                                                          height: 40,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text("Receipt Date",
                                                              style: kHRA_Edit,),
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

                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          height: 40,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0),
                                                              child: Text(receiptDate,
                                                                style: kHRA_Edit_value,),
                                                            ),
                                                          ),
                                                        ),
                                                      )

                                                    ],
                                                  )
                                              ),),
                                          ],
                                        )
                                    ),

                                    Container(
                                      // color: Colors.greenAccent,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex:1,
                                              child:Container(
                                                  width: MediaQuery.of(context).size.width*0.45,
                                                  // color:Colors.yellow,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                       Container(
                                                          // width: MediaQuery.of(context).size.width*0.19,
                                                          height: 40,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text("Amount",
                                                              style: kHRA_Edit,),
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

                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          height: 40,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0),
                                                              child: Text(rentAmount,
                                                                style: kHRA_Edit_value,),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ),),

                                            Expanded(
                                              flex:1,
                                              child:Container(
                                                  width: MediaQuery.of(context).size.width*0.45,
                                                  // color:Colors.yellow,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [


                                                      Container(
                                                        // width: MediaQuery.of(context).size.width*0.19,
                                                        height: 40,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("LandLord Name",
                                                            style: kHRA_Edit,),
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

                                                      Expanded(
                                                        flex: 1,
                                                        child:  Container(
                                                          // height: 40,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0,top: 12),
                                                              child: Text(landlordName,
                                                                style: kHRA_Edit_value,),
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

                                    Container(
                                      // color: Colors.greenAccent,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex:1,
                                              child:Container(
                                                  width: MediaQuery.of(context).size.width*0.45,
                                                  // color: Colors.yellow,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        // width: MediaQuery.of(context).size.width*0.19,
                                                        height: 40,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("LandLord Add",
                                                            style: kHRA_Edit,),
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
                                                      Expanded(
                                                        flex: 1,
                                                        child:  Container(
                                                          // height: 40,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0,top: 12),
                                                              child: Text(landlordAddress,
                                                                style: kHRA_Edit_value,),

                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ),),

                                            // Expanded(
                                            //   flex:1,
                                            //   child:Container(
                                            //       width: MediaQuery.of(context).size.width*0.45,
                                            //       // color: Colors.yellow,
                                            //       child:Row(
                                            //         crossAxisAlignment: CrossAxisAlignment.start,
                                            //         children: [
                                            //           Container(
                                            //             width: MediaQuery.of(context).size.width*0.19,
                                            //             height: 40,
                                            //             child:Align(
                                            //               alignment: Alignment.centerLeft,
                                            //               child: Text("LandLord City",
                                            //                 style: kHRA_Edit,),
                                            //             ),
                                            //           ),
                                            //           Container(
                                            //             height: 40,
                                            //             child:Align(
                                            //               alignment: Alignment.centerLeft,
                                            //               child: Text(":",
                                            //                 style: kHRA_Edit,),
                                            //             ),
                                            //           ),
                                            //           Expanded(
                                            //             flex: 1,
                                            //             child: Container(
                                            //               height: 40,
                                            //               child:Align(
                                            //                 alignment: Alignment.centerLeft,
                                            //                 child: Padding(
                                            //                   padding: EdgeInsets.only(left: 10.0),
                                            //                   child: Text(landlordCity,
                                            //                     style: kHRA_Edit_value,),
                                            //                 ),
                                            //               ),
                                            //             ),
                                            //           ),
                                            //         ],
                                            //       )
                                            //   ),),

                                            Expanded(
                                              flex:1,
                                              child:Container(
                                                  width: MediaQuery.of(context).size.width*0.45,
                                                  // color: Colors.yellow,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        // width: MediaQuery.of(context).size.width*0.19,
                                                        height: 40,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("PAN",style: kHRA_Edit,),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 40,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(":",style: kHRA_Edit,),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child:  Container(
                                                          height: 40,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0),
                                                              child: Text(landlordPanNo,
                                                                style: kHRA_Edit_value,),
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

/*
                                    Container(
                                      // color: Colors.greenAccent,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex:1,
                                              child: Container(
                                                  width: MediaQuery.of(context).size.width*0.45,
                                                  // color: Colors.yellow,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(context).size.width*0.19,
                                                        height: 40,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("LandLord State",
                                                            style: kHRA_Edit,),
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
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          height: 40,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0),
                                                              child: Text(landlordStateName,
                                                                style: kHRA_Edit_value,),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ),),

                                            Expanded(
                                              flex:1,
                                              child:Container(
                                                  width: MediaQuery.of(context).size.width*0.45,
                                                  // color: Colors.yellow,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(context).size.width*0.19,
                                                        height: 40,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("PAN",style: kHRA_Edit,),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 40,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(":",style: kHRA_Edit,),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child:  Container(
                                                          height: 40,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0),
                                                              child: Text(landlordPanNo,
                                                                style: kHRA_Edit_value,),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ),),
                                          ],
                                        )
                                    ),
*/

                                    /*-----------document-----------*/

                                    Container(
                                      // color: Colors.greenAccent,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex:1,
                                              child: Container(
                                                  width: MediaQuery.of(context).size.width*0.45,
                                                  padding: const EdgeInsets.only(top: 10),

                                                  // color: Colors.yellow,
                                                  child:Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                                              child: *//*GFAvatar(
                                                           // child: Image.memory(base64Decode(document_path)),
                                                            child: Image.network(document_path),
                                                            size: 50,
                                                          )*//*

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
                                                            )*/
                                                            /*------------------1-12-2021 end------------------*/

                                                            /*---------10-2-2022 start-------*/
                                                            Text.rich(

                                                              TextSpan(
                                                                  text: 'View Document',recognizer: TapGestureRecognizer()
                                                                ..onTap = ()
                                                                {
                                                                  //print('view document');

                                                                  Data dataObj = hraDataArr[index];
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



                                                                      }

                                                                      else{
                                                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>

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
                                                                              ),
                                                                            )
                                                                          // UploadInvestmentProof_Pdf_View(urlStr: document_path,)

                                                                        ),);
                                                                      }

                                                                    }
                                                                    else
                                                                    {
                                                                      /*---USE FOR IMAGES LIKES THAT (PNG,JPEG AND OTHER FORMAT)---*/
                                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>

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
                                                                          )
                                                                      )
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

                                            Expanded(
                                              flex:1,
                                              child: Visibility(visible: editButton_Visibility,
                                                child:  Container(
                                                    width: MediaQuery.of(context).size.width*0.45,
                                                    // color: Colors.yellow,
                                                    child:Row(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        IconButton(
                                                          icon: Image.asset(getCJHub_EditBtnIcon,
                                                            width: 20.0,
                                                            height: 20.0,),
                                                          iconSize: 20,
                                                          onPressed: ()
                                                          {
                                                            //print('Index of the item clicked: $index');


                                                            Data selectedDataObj=hraDataArr[index];
                                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>

                                                            Responsive(
                                                                mobile:  UploadInvestmentProof_HRA_Update(hraEditRecords: selectedDataObj,),
                                                                tablet: Center(
                                                                  child: Container(
                                                                    width: flutterWeb_tabletWidth,
                                                                    child:  UploadInvestmentProof_HRA_Update(hraEditRecords: selectedDataObj,),
                                                                  ),
                                                                ),
                                                                desktop: Center(
                                                                  child: Container(
                                                                    width: flutterWeb_desktopWidth,
                                                                    child:  UploadInvestmentProof_HRA_Update(hraEditRecords: selectedDataObj,),
                                                                  ),
                                                                ),
                                                            )

                                                                // UploadInvestmentProof_HRA_Update(hraEditRecords: selectedDataObj,)

                                                            ));

                                                          },
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              ),
                                            ),

                                            /*--------approved&rejected add into the houseloan-----------*/
                                            Expanded(
                                                flex:1,
                                                child: Visibility(visible: approvedRejectedText_Visibility,child:
                                                Container(
                                                    width: MediaQuery.of(context).size.width*0.45,
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
                                                                width: 100,
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
                                            )
                                          ],
                                        )
                                    ),


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
        ) :
        Center(
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
      view_HRA_Details()

    });

  }
  view_HRA_Details() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.get_UploadInvestmentProof_HRA),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },

        body: {
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'financial_year': financialYear,
        },

      );
      //print(response.statusCode);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        hra_view_modelResponse = HRA_View_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(hra_view_modelResponse!.statusCode==true)
        {
          // show_OKAlert(hra_save_modelResponse.message);


          if(hra_view_modelResponse!.data!.length>0)
          {
            setState(() {
              hraDataArr=hra_view_modelResponse!.data!;
            });


          }
          else
          {
            setState(() {
              hraDataArr = [];
            });
            show_OKAlert("Data not found");

          }

        }
        else
        {
          if (hra_view_modelResponse!.message==null || hra_view_modelResponse!.message=="")
          {
            show_OKAlert("server error!");

          }else {
            show_OKAlert(hra_view_modelResponse!.message);
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