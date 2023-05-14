import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;


import 'package:universal_html/html.dart' as html;



import '../../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../CustomView/CJHubCustomView/palatte_Textstyle.dart';
import '../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';

import '../../../ModelClasses/CJHubModelClasses/ProfileDocumentSave_ModelResponse.dart';
import '../../CJHubInvestment_UploadDocumentModule/Investment_UploadDocumentClasses/UploadInvestmentProof_Image_View.dart';
import '../../CJHubInvestment_UploadDocumentModule/Investment_UploadDocumentClasses/UploadInvestmentProof_Pdf_View.dart';
import 'Profile_Document.dart';
import 'Profile_Document_ThirdPartyInsurance.dart';
import 'Profile_NewDocument.dart';
import 'cropper/ui_helper.dart'
if (dart.library.io) 'cropper/mobile_ui_helper.dart'
if (dart.library.html) 'cropper/web_ui_helper.dart';
import 'package:contractjobs/Controller/Talents/ModelClasses/CJHubModelClasses/ProfileDocumentType_ModelResponse.dart';


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
      home: Profile_NewDocument(title: 'CJ Hub'),
    );
  }
}
class Profile_NewDocument extends StatefulWidget {

  Profile_NewDocument({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _Profile_NewDocument createState() => _Profile_NewDocument();
}

class _Profile_NewDocument extends State<Profile_NewDocument>
{
  // This widget is the root of your application.

  String valueChoose_documents="";



  String Status = '1';

  String empId="",empIPAddress="";
  String complete_JSId="";


  ProfileDocumentType_ModelResponse? profileDocumentType_ModelResponse;
  Data? selected_DocumentData;
  bool dropDown_VisibilityStatus=false;
  String valueChoose = "Select Document";

  bool selectItem_VisibilityStatus=false;
  String selectedItem="";


  List<Data> profileDocumentDataArr=[Data(documentDescription: "",documentPath: ""),
  ];

  String document_path="testing";
  bool documentDefault_Visibility=true;
  bool documentDynamic_ImageVisibility=false;
  bool documentDynamic_PDFVisibility=false;


  /*------------------31-12-2021 start------------------*/
  bool editButton_Visibility=true;
  bool approvedRejectedText_Visibility=false;
  String approvedRejectedText="";
  Colors? colorType;
  TextStyle textStyle_approvedRejected=TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 13);
  /*------------------31-12-2021 end------------------*/

  String view_Upload_DocumentName="View Document";


  bool documentThirdParty_Visibility=false;
  String fromDate="",toDate="";


  @override
  void initState()
  {
    super.initState();
    setState(() {
    });

    getBasicInfo();

    //print("show initState method");

  }


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          backgroundColor: Colors.white,
          appBar:CJAppBar("", appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show the action type");
            Navigator.pop(context);
          })),

          body: WillPopScope(
            child: ListView.builder(
                padding: EdgeInsets.only(bottom: 70.0),
                shrinkWrap: true,
                itemCount: profileDocumentDataArr.length,
                itemBuilder: (BuildContext context, int index)
                {


                  //print('show selected index $index');
                  String documentDescription="";
                  String remarks="";
                  if(profileDocumentDataArr.length>0)
                  {
                    Data dataObj = profileDocumentDataArr[index];
                    document_path = dataObj.documentPath;
                    documentDescription=dataObj.documentDescription;
                    remarks=dataObj.remarks;
                    //print(document_path);


                    /*------------------24-1-2022 start------------------*/
                    String fileName_Extension="";
                    if(document_path=="")
                    {

                    }
                    else
                    {
                      fileName_Extension=document_path.split(".").last;
                    }
                    //print('show extension $fileName_Extension');
                    /*------------------24-1-2022 end------------------*/


                    if(document_path=="" || document_path==null)
                    {
                      view_Upload_DocumentName="Upload Document";
                      documentDefault_Visibility=true;
                      documentDynamic_ImageVisibility=false;
                      documentDynamic_PDFVisibility=false;
                      editButton_Visibility=false;

                    }
                    else
                    {

                      view_Upload_DocumentName="View Document";

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

                    //here P use for two cases .First  user not upload the document means document_path is blank.
                    //second  user upload the document means approvel is pending
                    if(dataObj.acceptStatus=="P")
                    {
                      if(document_path=="" || document_path==null) {
                        editButton_Visibility = false;
                        approvedRejectedText_Visibility = false;

                      }
                      else {
                        textStyle_approvedRejected=TextStyle(fontFamily: 'Vonique',color: Colors.blue,fontSize: 14);
                        approvedRejectedText="Pending";
                        editButton_Visibility = true;
                        approvedRejectedText_Visibility = true;
                      }
                    }
                    else if(dataObj.acceptStatus=="A")
                    {
                      textStyle_approvedRejected=TextStyle(fontFamily: 'Vonique',color: Colors.green,fontSize: 14);
                      approvedRejectedText="Approved";
                      editButton_Visibility=false;
                      approvedRejectedText_Visibility=true;
                    }
                    else if(dataObj.acceptStatus=="R")
                    {
                      if(remarks=="" || remarks==null)
                      {

                      }
                      else
                      {
                        documentDescription=documentDescription+": "+remarks;
                      }

                      textStyle_approvedRejected=TextStyle(fontFamily: 'Vonique',color: Colors.red,fontSize: 14);
                      approvedRejectedText="Rejected";
                      editButton_Visibility=true;
                      approvedRejectedText_Visibility=true;
                    }
                    else
                    {
                      //other case
                      editButton_Visibility=false;
                    }

                    /*----------------9-4-2022 start(use for the third party insurance)------------*/
                    if(dataObj.documentId=="20")
                    {
                      fromDate=dataObj.validFrom;
                      toDate=dataObj.validTo;
                      if(fromDate=="" || fromDate==null)
                      {
                        documentThirdParty_Visibility=false;
                      }
                      else
                      {
                        documentThirdParty_Visibility=true;
                      }
                    }
                    else
                    {
                      documentThirdParty_Visibility=false;
                    }
                    /*----------------9-4-2022 end(use for the third party insurance)------------*/


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
                                                      width: MediaQuery.of(context).size.width*0.45,
                                                      padding: const EdgeInsets.only(top: 5),

                                                      // color: Colors.yellow,
                                                      child:Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [

                                                          Expanded(
                                                            flex: 1,
                                                            child:  Container(
                                                              //height: 40,
                                                              child:Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(left: 10.0),
                                                                  child: Text(documentDescription,
                                                                    style: profileDocumentText_value,),
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
                                        /*-----------document-----------*/

                                        /*---------9-3-2022 start(use for the third party insurance)-------*/
                                        Visibility(visible: documentThirdParty_Visibility,
                                            child: Container(
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

                                                              Container(
                                                                // width: MediaQuery.of(context).size.width*0.19,
                                                                height: 40,
                                                                child:Align(
                                                                  alignment: Alignment.centerRight,
                                                                  child: Text("From Date",
                                                                    style: kHRA_Edit,),
                                                                ),
                                                              ),

                                                              Container(
                                                                height: 40,
                                                                child:Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(" :",
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
                                                                      padding: EdgeInsets.only(left: 5.0),
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
                                                      flex: 1,
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
                                                                  alignment: Alignment.centerRight,
                                                                  child: Text("To Date",
                                                                    style: kHRA_Edit,),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 40,
                                                                child:Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(" :",
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
                                                                      padding: EdgeInsets.only(left: 5.0),
                                                                      child: Text(toDate,
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
                                            )),

                                        /*---------9-3-2022 end-------*/



                                        Container(
                                          //color: Colors.yellow,
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  Container(
                                                    //color: Colors.grey,
                                                    //   width: MediaQuery.of(context).size.width * 0.41,
                                                      child:
                                                      Text.rich(

                                                        TextSpan(
                                                            text: view_Upload_DocumentName,recognizer: TapGestureRecognizer()
                                                          ..onTap = ()
                                                          {
                                                            //print('view document');

                                                            Data dataObj = profileDocumentDataArr[index];
                                                            document_path = dataObj.documentPath;
                                                            //print(document_path);

                                                            String fileName_Extension="";
                                                            if(document_path=="")
                                                            {
                                                            }
                                                            else
                                                            {
                                                              fileName_Extension=document_path.split(".").last;
                                                            }
                                                            //print('show extension $fileName_Extension');

                                                            if(document_path=="" || document_path==null)
                                                            {
                                                              /*----------------9-4-2022 start(use for the third party insurance)------------*/
                                                              if(dataObj.documentId=="20")
                                                              {

                                                                Navigator.push(context, MaterialPageRoute(builder: (_) =>

                                                                Responsive(
                                                                    mobile: Profile_Document_ThirdPartyInsurance(profileData: dataObj,),
                                                                    tablet: Center(
                                                                      child: Container(
                                                                        width: flutterWeb_tabletWidth,
                                                                        child: Profile_Document_ThirdPartyInsurance(profileData: dataObj,),
                                                                      ),
                                                                    ),
                                                                    desktop: Center(
                                                                      child: Container(
                                                                        width: flutterWeb_desktopWidth,
                                                                        child: Profile_Document_ThirdPartyInsurance(profileData: dataObj,),
                                                                      ),
                                                                    ))
                                                                    // Profile_Document_ThirdPartyInsurance(profileData: dataObj,)

                                                                ),);
                                                                /*----------------9-4-2022 start(use for the third party insurance)------------*/
                                                              }
                                                              else
                                                              {
                                                                Navigator.push(context, MaterialPageRoute(builder: (_) =>

                                                                Responsive(
                                                                  mobile: Profile_Document(profileData: dataObj,),
                                                                  tablet: Center(
                                                                    child: Container(
                                                                      width: flutterWeb_tabletWidth,
                                                                      child: Profile_Document(profileData: dataObj,),
                                                                    ),
                                                                  ),
                                                                  desktop: Center(
                                                                    child: Container(
                                                                      width: flutterWeb_desktopWidth,
                                                                      child: Profile_Document(profileData: dataObj,),
                                                                    ),
                                                                  ),
                                                                )
                                                                    // Profile_Document(profileData: dataObj,)

                                                                ),);
                                                              }
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
                                                                      )
                                                                  )
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
                                                                    ))
                                                                    // UploadInvestmentProof_Image_View(urlStr: document_path,)

                                                                ),);
                                                              }

                                                            }

                                                          },
                                                            style: TextStyle(
                                                              decoration: TextDecoration.underline,
                                                              decorationColor: Colors.black,
                                                              fontSize: 13,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black,
                                                              decorationThickness: 2,
                                                            )),

                                                      )



                                                  ),

                                                  Visibility(visible: editButton_Visibility,
                                                      child:
                                                      Container(
                                                        //color: Colors.blue,
                                                        // width: MediaQuery.of(context).size.width * 0.17,
                                                        child: Align(
                                                            alignment: Alignment.center,
                                                            child:  IconButton(
                                                                padding: EdgeInsets.zero,
                                                                constraints: BoxConstraints(),
                                                                icon: Image.asset(getCJHub_EditBtnIcon,
                                                                  width: 20.0,
                                                                  height: 20.0,),
                                                                iconSize: 20,
                                                                onPressed: ()
                                                                {
                                                                  //print('Index of the item clicked: $index');

                                                                  Data dataObj = profileDocumentDataArr[index];
                                                                  document_path = dataObj.documentPath;
                                                                  //print(document_path);

                                                                  /*----------------9-4-2022 start(use for the third party insurance)------------*/
                                                                  if(dataObj.documentId=="20")
                                                                  {
                                                                    Navigator.push(context, MaterialPageRoute(builder: (_) =>

                                                                    Responsive(
                                                                        mobile: Profile_Document_ThirdPartyInsurance(profileData: dataObj,),
                                                                        tablet: Center(
                                                                          child: Container(
                                                                            width: flutterWeb_tabletWidth,
                                                                            child: Profile_Document_ThirdPartyInsurance(profileData: dataObj,),
                                                                          ),
                                                                        ),
                                                                        desktop: Center(
                                                                          child: Container(
                                                                            width: flutterWeb_desktopWidth,
                                                                            child: Profile_Document_ThirdPartyInsurance(profileData: dataObj,),
                                                                          ),
                                                                        ))
                                                                        // Profile_Document_ThirdPartyInsurance(profileData: dataObj,)

                                                                    ),);
                                                                    /*----------------9-4-2022 start(use for the third party insurance)------------*/
                                                                  }
                                                                  else
                                                                  {
                                                                    Navigator.push(context, MaterialPageRoute(builder: (_) =>

                                                                    Responsive(

                                                                        mobile: Profile_Document(profileData: dataObj,),
                                                                        tablet: Center(
                                                                          child: Container(
                                                                            width: flutterWeb_tabletWidth,
                                                                            child: Profile_Document(profileData: dataObj,),
                                                                          ),
                                                                        ),
                                                                        desktop: Center(
                                                                          child: Container(
                                                                            width: flutterWeb_desktopWidth,
                                                                            child: Profile_Document(profileData: dataObj,),
                                                                          ),
                                                                        )

                                                                    )
                                                                        // Profile_Document(profileData: dataObj,)

                                                                    ),);
                                                                  }

                                                                }
                                                            )

                                                        ),
                                                      )),

                                                  Visibility(
                                                      visible: approvedRejectedText_Visibility,
                                                      child: Container(
                                                      color: Colors.white,
                                                      // width: MediaQuery.of(context).size.width * 0.22,
                                                      child:  Align(
                                                        alignment: Alignment.center,
                                                        child: Text(approvedRejectedText,
                                                            style: textStyle_approvedRejected),
                                                      )

                                                    /* Text(approvedRejectedText,
                                     style: textStyle_approvedRejected)*/


                                                  )),

                                                ],
                                              ),
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
            ),

            onWillPop: () async => false,
            /*onWillPop: ()
            {
              Message.alert_dialogAppExit(context);

            } ,*/

          )

      );
  }

  getBasicInfo()
  {
    SharedPreference.getEmpId().then((value) =>  {
      empId=value,
      //print('show emp name2 $value'),
      //loadData()
    });
    Method.getIPAddress().then((value) => {
      empIPAddress=value

    });

    String mobileNumber_key="",jsId_key="",empCode="",
        empDateOfBirth_key="";

    SharedPreference.getEmpMobileNo().then((value) =>  {
      mobileNumber_key=value,
      //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpCode().then((value) =>  {
      empCode=value,
      //print('show emp empCode $value'),
    });

    SharedPreference.getJSId().then((value) =>  {
      jsId_key=value,
      //print('show emp jsId $value'),
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth_key=value,
      //print('show emp name2 $value'),
      complete_JSId = mobileNumber_key+"CJHUB"+jsId_key+"-"+empCode+"CJHUB"+empDateOfBirth_key,
      //print('show complete_JSId $complete_JSId'),
      getDocumentTypeList()
    });
  }

  getDocumentTypeList() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.get_DocumentData),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'js_id': getEncrypted_EmpCode(complete_JSId),

        },
      );

      //print(response.statusCode);
      if (response.statusCode == 200)
      {

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        profileDocumentType_ModelResponse = ProfileDocumentType_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(profileDocumentType_ModelResponse!.statusCode==true)
        {

          setState(() {
            profileDocumentType_ModelResponse=profileDocumentType_ModelResponse;
            profileDocumentDataArr=profileDocumentType_ModelResponse!.data!;
            //dropDown_VisibilityStatus=true;
          });

        }
        else
        {
          if (profileDocumentType_ModelResponse!.message==null || profileDocumentType_ModelResponse!.message=="")
          {
            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, profileDocumentType_ModelResponse!.message!);
            // show_OKAlert(profileDocumentType_ModelResponse.message);
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