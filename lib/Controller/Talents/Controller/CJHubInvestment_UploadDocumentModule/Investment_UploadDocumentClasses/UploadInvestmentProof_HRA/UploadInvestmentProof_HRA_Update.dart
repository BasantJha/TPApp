import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:contractjobs/Constant/Constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart'as http;


import '../../../../../../Constant/CJHub_ConstantIcon.dart';
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
import '../../UploadInvestmentProof_ModelClasses/HRA_Save_ModelResponse.dart';
import '../UploadInvestmentProof_HRA/UploadInvestmentProof_HRA_View.dart';

import 'cropper/ui_helper.dart'
if (dart.library.io) 'cropper/mobile_ui_helper.dart'
if (dart.library.html) 'cropper/web_ui_helper.dart';


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
      home: UploadInvestmentProof_HRA_Update(title: 'CJ Hub'),
    );
  }
}
class UploadInvestmentProof_HRA_Update extends StatefulWidget {

  UploadInvestmentProof_HRA_Update({Key? key, this.title,this.hraEditRecords}) : super(key: key);

  final String? title;
  final Data? hraEditRecords;

  @override
  _UploadInvestmentProof_HRA_Update createState() => _UploadInvestmentProof_HRA_Update(hraEditRecords!);
}

class _UploadInvestmentProof_HRA_Update extends State<UploadInvestmentProof_HRA_Update>

{


  /*-------custom constructor method start-------*/
  Data? hraDataObj;


  _UploadInvestmentProof_HRA_Update(Data hraDataObj)
  {
    this.hraDataObj = hraDataObj;
    //print('show edit items $hraDataObj');

  }
  /*-------custom constructor method end-------*/



  // This widget is the root of your application.
  List listItem =["April-2019","May-2019","June-2019","July-2019","August-2019","September-2019","October-2019","November-2019",
    "December-2019","January-2020","February-2020","March-2020"];
  String valueChoose="" ;

  List listItem_To =["April-2019","May-2019","June-2019","July-2019","August-2019","September-2019","October-2019","November-2019",
    "December-2019","January-2020","February-2020","March-2020"];
  String valueChoose_To="" ;

  List listItem_State =["Andhra Pradesh","Arunachal Pradesh","Assam","Bihar","Chhattisgarh","Goa","Gujarat","Haryana",
    "Himachal Pradesh","Jharkhand","Karnataka","Kerala","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram",
    "Nagaland","Odisha","Punjab","Rajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttar Pradesh","Uttarakhand","West Bengal"];
  String valueChoose_State="" ;

  List listItem_monthTenure = ["Month","Quarterly","Yearly"];
  String valueChoose_monthTenure="" ;

  //String _selectedDate = 'Select date';


  String _fileName="";

  bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType = FileType.custom;
  File? _pickedImage;
  // String Camera_fileName;
  String actionType_Gallery = 'gallery';
  String actionType_Camera = 'camera';
  String actionType = '';
  String fileType_Name = 'No file choosen';


  int count_nextVariable =1;

  final _formsPageViewController = PageController();
  List? _forms;


  String fromDate="";
  String toDate="";
  String receiptNo="";
  String receiptDate="";
  String rentAmount="";
  String landlordName="";
  String landlordAddress="";
  String landlordCity="Delhi";
  String landlordStateId="0";
  String landlordStateName="";
  String landlordPanNo="";
  String tenureId="";

  String dateSelectionType_FromDate="FromDate";
  String dateSelectionType_ToDate="ToDate";
  String dateSelectionType_ReceiptDate="ReceiptDate";

  String approval_status="";
  String document_path="";
  String document_name="";
  String original_document_name="";

  String empCode="",empName="",panNumber="";
  String completeEmpCode="",headId="";
  String financialYear="2021-22";
  String empId="",empIPAddress="";


  String? baseimage;

  var txtController_receiptNo = TextEditingController();
  var txtController_rentAmount = TextEditingController();
  var txtController_landlordName = TextEditingController();
  var txtController_landlordAddress = TextEditingController();
  var txtController_landlordCity = TextEditingController();
  var txtController_landlordPanNo = TextEditingController();


  /*--------------04-08-2022 start------------*/

  Uint8List? fileBytes;
  String fileName="";
  File _file = File("zz");
  CroppedFile? _croppedFile;

  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  List<PlatformFile>? _paths;
  String? _directoryPath;
  FilePickerResult? _path;
  String actionType_web = 'upload';

  /*--------------04-08-2022 end------------*/

  bool? panCardStatus;

  validate_PAN(String value) {
    String patttern = r"^[A-Z]{5}[0-9]{4}[A-Z]{1}";
    RegExp regExp = new RegExp(patttern);

    if (!regExp.hasMatch(value)) {
      panCardStatus = false;

    }
    else{
      panCardStatus = true;
    }

  }

  validateToThePANNumber()
  {
    if(landlordPanNo.length<=10 )
    {
      validate_PAN(landlordPanNo);

    }
    else {

      validate_PAN(landlordPanNo);

    }


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBasicInfo();
    loadData();

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

  loadData()
  {
    setState(()  {
      fromDate=hraDataObj?.fromDate;
      toDate=hraDataObj?.toDate;
      receiptNo=hraDataObj?.receiptNo;
      receiptDate=hraDataObj?.receiptDate;
      rentAmount=hraDataObj?.rentAmount;
      landlordName=hraDataObj?.landlordName;
      landlordAddress=hraDataObj?.landlordAddress;
      landlordCity=hraDataObj?.landlordCity;
      landlordStateId=hraDataObj?.landlordState;
      landlordStateName=hraDataObj?.landlordStateName;
      landlordPanNo=hraDataObj?.landlordPan;
      tenureId=hraDataObj?.monthlyTenure;

      approval_status=hraDataObj?.approvalStatus;
      document_path=hraDataObj?.documentPath;
      document_name=hraDataObj?.documentName;
      original_document_name=hraDataObj?.originalDocumentName;
      fileType_Name=original_document_name;

      //24-1-20222 start
      txtController_receiptNo.text=receiptNo;
      txtController_rentAmount.text=rentAmount;
      txtController_landlordName.text=landlordName;
      txtController_landlordAddress.text=landlordAddress;
      txtController_landlordPanNo.text=landlordPanNo;

      //24-1-20222 end

    });

    SharedPreference.networkImageToBase64(hraDataObj!.documentPath).then((value) =>  {

      baseimage=value,
      print('show document2 $baseimage'),
      //loadData()
    });

  }

  Future<void> _selectDate(BuildContext context,String dateSelectionType) async
  {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(Method.getStartYear()),
      lastDate: DateTime(Method.getEndYear()),
    );
    if (d != null)
      setState(()
      {
        receiptDate = new DateFormat.yMMMd("en_US").format(d);

        String selectedDate = new DateFormat.yMd("en_US").format(d);
        selectedDate=Method.changeTheDateFormat_ForUploadInvestmentDeclaration(selectedDate);


        if(dateSelectionType==dateSelectionType_FromDate)
        {
          fromDate=selectedDate;
        }
        else  if(dateSelectionType==dateSelectionType_ToDate)
        {
          toDate=selectedDate;

        }else
        {
          /*-----receipt date--------*/
          receiptDate=selectedDate;
        }

      });
  }

  @override
  Widget build(BuildContext context) {
    _forms = [
      WillPopScope(
        onWillPop: () => Future.sync(this.onWillPop),
        child: Step1Container(),
      ),
      WillPopScope(
        onWillPop: () => Future.sync(this.onWillPop),
        child: Step1Container(),
      ),
      WillPopScope(
        onWillPop: () => Future.sync(this.onWillPop),
        child: Step1Container(),
      ),
      WillPopScope(
        onWillPop: () => Future.sync(this.onWillPop),
        child: Step1Container(),
      ),
    ];

    return
      PageView.builder(
        controller: _formsPageViewController,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _forms![index];
        },
      );

  }

  void _nextFormStep() {
    count_nextVariable = count_nextVariable+1;
    if(count_nextVariable<=4){
      _formsPageViewController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }

  }


  /*---------------------------------start 20-11-2021-------------------------------------------*/
  Widget _buildChild_chooseFile() {
    if (actionType == actionType_Camera) {
      return new  Expanded(
          flex:1,
          child: Container(
              height: 35,
              child:Align(
                  alignment: Alignment.centerLeft,
                  child:   new Text(fileType_Name,
                    style: TextStyle(color: Colors.black,fontSize: 12),
                  )
              )
          ));
    }
    else if(actionType ==actionType_Gallery){
      return new  Expanded(
          flex:1,
          child: Container(
              height: 35,
              child:Align(
                  alignment: Alignment.centerLeft,
                  child:   new Text(fileType_Name,
                    style: TextStyle(color: Colors.black,fontSize: 12),
                  )
              )
          ));
    }
    else {
      return new Container(
        width: MediaQuery
            .of(context)
            .size
            .width *0.5,
        height: 30,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(fileType_Name,style: TextStyle(color: primaryColor,fontSize: 12),),
        ),
      );
    }
  }


  alert_dialog(BuildContext context)
  {
    var alertDialog = AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //position
        mainAxisSize: MainAxisSize.min,
        // wrap content in flutter
        children: <Widget>[
          Text(Message.get_Document_name,
            style: TextStyle(fontFamily:'Vonique',fontSize: 15,color: Colors.black),),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [
        TextButton(onPressed: (){

          actionType = actionType_Camera;

          _cameraPicker(ImageSource.camera);

          Navigator.pop(context);

          // _cameraPicker(ImageSource.camera);
        },
          child: Text("Camera",
            textAlign: TextAlign.right,style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),

        SizedBox(width: 5.0),

        TextButton(onPressed: (){

          actionType= actionType_Gallery;
          _pickFiles();

          Navigator.pop(context);
          // _galleryPicker();
        },
          child: Text("Gallery",
            textAlign: TextAlign.right,style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),

      ],

    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }


/*
  _cameraPicker(ImageSource source) async {
    File picked = await ImagePicker.pickImage(source: source,imageQuality: Method.getImageQuality());
    if (picked != null) {
      _cropImage(picked);
    }
    Navigator.pop(context);
  }

  _cropImage(File picked) async {
    File cropped = await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
        statusBarColor: primaryColor,
        toolbarColor: primaryColor,
        toolbarTitle: "Crop Image",
        toolbarWidgetColor: Colors.white,
      ),
      sourcePath: picked.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio4x3,
      ],
      // maxWidth: 800,
    );
    if (cropped != null) {
      setState(() {
        _pickedImage = cropped;
        actionType = actionType_Camera;
        // Camera_fileName = _pickedImage.toString();
        fileType_Name = 'HRA.png';
        //print('camera path: $fileType_Name');

        convertImageFormat_base64();

      });
    }
  }



  void _galleryPicker() async
  {

    if (_pickingType !=  _hasValidMime)
    {
      try
      {
        if (_multiPick)
        {
          //print('show the correct value');
          _path = null;
          _paths = await FilePicker.getMultiFilePath(
              type: _pickingType,
              allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png']);
        }
        else
        {
          //print('show the incorrect value');
          _paths = null;

          _path = await FilePicker.getFilePath(
              type: _pickingType,
              allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png']);


        }

      }
      on PlatformException catch (e)
      {

        //print('show the exception value');
        //print("Unsupported operation" + e.toString());

      }

      if (!mounted) return;

      setState(()
      {

        *//*------------21-2-2022 start-----------------*//*
        if(_path.length>0)
        {
          _fileName = _path.split('/').last;

          var checkFileExtension=_fileName.split(".").last;
          checkFileExtension=checkFileExtension.toLowerCase();


          if(checkFileExtension == "jpg" || checkFileExtension == "jpeg" || checkFileExtension == "png" || checkFileExtension == "pdf")
          {
            fileType_Name = _fileName ?? '...';
            //print('gallery path: $fileType_Name');
            actionType = actionType_Gallery;
            Navigator.pop(context);

            convertImageFormat_base64();
            //print(('only pdf and image1 $checkFileExtension'));
          }
          else
          {

            String newExtension=checkFileExtension+" "+"not allowed";
            baseimage="";
            Navigator.pop(context);
            show_OKAlert(newExtension);

          }
        }
        else
        {
          baseimage="";
          Navigator.pop(context);
        }
      });

      *//*------------21-2-2022 end-----------------*//*

    }
  }*/

  /*---------------------------------------end 20-11/2021----------------------------------------*/

  bool onWillPop() {
    if (_formsPageViewController.page!.round() ==
        _formsPageViewController.initialPage) return true;

    _formsPageViewController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );

    return false;
  }

  Widget Step1Container(){
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handleUserInteraction,
        onPointerMove: _handleUserInteraction,
        onPointerUp: _handleUserInteraction,
        child:
      Scaffold(
      appBar: /*AppBar(leading: BackButton(
          color: Colors.black
      ), backgroundColor: Color(0xfff0f0f2),centerTitle: true,
        title: Image.asset(getCJHub_AppLogo,height: 90,width: 90,),),*/
      CJAppBar("", appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action 1type");
        Navigator.pop(context);

      })),
      body:  SingleChildScrollView(
        child:
        Column(
          children: <Widget>[

            create_Gap(),
            create_Gap(),
            create_Gap(),
            create_Gap(),
            create_Gap(),

            Container(
              // color: Colors.red,
              child: create_HRAFromTo(),
            ),
            Container(
              // color: Colors.red,
              child: create_HRAReceipt(),
            ),
            Container(
              // color: Colors.red,
              child: create_HRA_LandLoadName_Amount(),
            ),
            Container(
              // color: Colors.red,
              child: create_HRA_LandLoadAdd_City(),
            ),
            /* Container(
              // color: Colors.red,
              child: create_HRA_LandLoadState_Pan(),
            ),*/

            Container(
              // color: Colors.red,
              child: create_HRA_ChooseFile(),
            ),

            Container(
              child: create_NoteContainer(),
            ),

            create_Gap(),
            create_Gap(),

            Container(
              // color: Colors.red,
              child: create_HRA_Button_AddEdit(),
            ),

          ],
        ),
      ),
    )
    );
  }


  Container create_HRAFromTo() {
    return Container(

        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: Style_UploadInvestment_Top,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    flex:1,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: Text("From",style: TextStyle(color: primaryColor,fontSize: 12),),
                          ),
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          height: 30,
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    top: BorderSide(width: 1.0, color: Colors.grey),
                                    left: BorderSide(width: 1.0, color: Colors.grey),
                                    right: BorderSide(width: 1.0, color: Colors.grey),
                                    bottom: BorderSide(width: 1.0, color: Colors.grey),
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    InkWell(
                                      child:Text(
                                          fromDate,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black)
                                      ),

                                      onTap: ()
                                      {
                                        _selectDate(context,dateSelectionType_FromDate);
                                      },
                                    ),
                                    MaterialButton(
                                        minWidth: 5,
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onPressed:()
                                        {
                                          _selectDate(context,dateSelectionType_FromDate);
                                        },
                                        child: Text('')
                                    ),
                                    /*IconButton(
                                  icon: Icon(Icons.calendar_today,size: 20,),
                                  tooltip: 'Date picker',
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                ),*/
                                  ],
                                ),
                              )
                          ),
                        ),

                      ],
                    ),
                  ),

                  Expanded(
                    flex: 1,
                      child: Column(
                    children: [

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: Text("To",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(width: 1.0, color: Colors.grey),
                                  left: BorderSide(width: 1.0, color: Colors.grey),
                                  right: BorderSide(width: 1.0, color: Colors.grey),
                                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  InkWell(
                                    child:Text(
                                        toDate,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black)
                                    ),

                                    onTap: ()
                                    {
                                      _selectDate(context,dateSelectionType_ToDate);
                                    },
                                  ),
                                  MaterialButton(
                                      minWidth: 5,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed:()
                                      {
                                        _selectDate(context,dateSelectionType_ToDate);
                                      },
                                      child: Text('')
                                  ),
                                  /*IconButton(
                                  icon: Icon(Icons.calendar_today,size: 20,),
                                  tooltip: 'Date picker',
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                ),*/
                                ],
                              ),
                            )
                        ),
                      ),

                    ],
                  ))




                ],
              ),

            ),
          ],
        )
    );
  }
  Container create_HRAReceipt() {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),

        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: Style_UploadInvestment_Inner,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex:1,
                      child:  Column(
                    children: [

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Receipt No",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: TextField(
                          //keyboardType: TextInputType.text,
                          controller: txtController_receiptNo,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                          ],
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 5, left: 3),
                            hintText: receiptNo,
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            receiptNo=value;
                          },

                        ),
                      ),

                    ],
                  )),

                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [

                        Container(

                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Receipt Date",style: TextStyle(color: primaryColor,fontSize: 12),),
                          ),
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          height: 30,
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    top: BorderSide(width: 1.0, color: Colors.grey),
                                    left: BorderSide(width: 1.0, color: Colors.grey),
                                    right: BorderSide(width: 1.0, color: Colors.grey),
                                    bottom: BorderSide(width: 1.0, color: Colors.grey),
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    InkWell(
                                      child:Text(
                                          receiptDate,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black)
                                      ),

                                      onTap: ()
                                      {
                                        _selectDate(context,dateSelectionType_ReceiptDate);
                                      },
                                    ),
                                    MaterialButton(
                                        minWidth: 5,
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onPressed:()
                                        {
                                          _selectDate(context,dateSelectionType_ReceiptDate);
                                        },
                                        child: Text('')
                                    ),
                                    /*IconButton(
                                  icon: Icon(Icons.calendar_today,size: 20,),
                                  tooltip: 'Date picker',
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                ),*/
                                  ],
                                ),
                              )
                          ),
                        ),

                      ],
                    ),
                  )

                ],
              ),

            ),
          ],
        )
    );
  }
  Container create_HRA_LandLoadName_Amount() {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),

        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: Style_UploadInvestment_Inner,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [

                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Amount",style: TextStyle(color: primaryColor,fontSize: 12),),
                          ),
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          height: 30,
                          child: TextField(
                            controller: txtController_rentAmount,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              contentPadding: EdgeInsets.only(
                                  top: 5, left: 3),
                              hintText: rentAmount,
                              border:
                              OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0)),
                            ),
                            onChanged: (value)
                            {
                              rentAmount=value;
                            },

                          ),
                        ),

                      ],
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [

                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: Text("LandLord_Name",style: TextStyle(color: primaryColor,fontSize: 12),),
                          ),
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          height: 30,
                          child: TextField(
                            controller: txtController_landlordName,
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                            ],
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              contentPadding: EdgeInsets.only(
                                  top: 5, left: 3),
                              hintText: landlordName,
                              border:
                              OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0)),
                            ),
                            onChanged: (value)
                            {
                              landlordName=value;
                            },

                          ),
                        ),

                      ],
                    ),
                  )




                ],
              ),

            ),
          ],
        )
    );
  }
  Container create_HRA_LandLoadAdd_City() {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),

        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: Style_UploadInvestment_Inner,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    flex:1,
                      child: Column(
                    children: [

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: Text("LandLord_Add",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: TextField(
                          controller: txtController_landlordAddress,
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z / -]")),
                            LengthLimitingTextInputFormatter(250),
                          ],
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 5, left: 3),
                            hintText: landlordAddress,
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            landlordAddress=value;
                          },

                        ),
                      ),

                    ],
                  ))
                  ,
/*
                  Column(
                    children: [

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: Text("LandLord_City",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 5, left: 3),
                            hintText: landlordCity,
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            landlordCity=value;
                          },

                        ),
                      ),

                    ],
                  )
*/

                Expanded(
                  flex: 1,
                    child: Column(
                  children: [

                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.4,
                      child:Align(
                        alignment: Alignment.centerLeft,
                        child: Text("PAN",style: TextStyle(color: primaryColor,fontSize: 12),),
                      ),
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.4,
                      height: 30,
                      child: TextFormField(
                        controller: txtController_landlordPanNo,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: validate_panCard(),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          contentPadding: EdgeInsets.only(
                              top: 5, left: 3),
                          hintText: landlordPanNo,
                          border:
                          OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2.0)),
                        ),
                        onChanged: (value)
                        {
                          landlordPanNo=value;
                        },

                      ),
                    ),

                  ],
                ))




                ],
              ),

            ),
          ],
        )
    );
  }
/*
  Container create_HRA_LandLoadState_Pan() {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),

        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,

              decoration: Style_UploadInvestment_Inner,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: Text("LandLord_State",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        padding: EdgeInsets.fromLTRB(10,0,10,0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey,
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        child:DropdownButton(
                          hint: Text(landlordStateName),
                          icon: Icon(Icons.arrow_drop_down),
                          dropdownColor: Colors.white,
                          underline: DropdownButtonHideUnderline(child: Container()),
                          iconSize: 25,
                          isExpanded: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Method.fontSize_DropDownItem(),
                          ),
                          value: valueChoose_State,
                          onChanged: (newValue){
                            setState(() {
                              valueChoose_State = newValue;
                              landlordStateName=newValue;


                            });
                          },
                          items: listItem_State.map((valueItem)
                          {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                      ),

                    ],
                  ),
                  Column(
                    children: [

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: Text("PAN",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 5, left: 3),
                            hintText: landlordPanNo,
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            landlordPanNo=value;
                          },

                        ),
                      ),

                    ],
                  )


                ],
              ),

            ),
          ],
        )
    );
  }
*/

  Container create_NoteContainer() {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: Style_UploadInvestment_Bottom,
              padding: const EdgeInsets.only(left: 10, right: 10,bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,5,0,0),
                        child: Row(
                          children: [

                            Text(Message.get_UploadDocumentTypeHint,
                              style: TextStyle(color: Colors.black54,fontSize: 10),),
                          ],
                        ),
                      ),
                    ),
                  ),



                ],
              ),

            ),
          ],
        )
    );
  }

  Container create_HRA_ChooseFile() {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),

        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: Style_UploadInvestment_Inner,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 7,bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    flex:1,
                      child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.3,
                    height: 30,
                    decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: new BorderRadius.circular(0.0),
                        border: Border.all(color: fourHunGreyColor,
                            width: 1.0,
                            style: BorderStyle.solid)
                    ),
                    child: Material(
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.grey[300],
                      child:MaterialButton(
                          minWidth: 60,
                          // height: 10,
                          onPressed: () => checkWebAndMobile(),
                          child: Text('Choose File',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Vonique',color: Colors.black,fontSize: 13))
                      ),
                    ),
                  ))
                  ,

                  SizedBox(
                    width: 10,
                  ),

                  Expanded(
                      flex: 1,
                      //child: new Container(child: _buildChild_chooseFile())),
                      child: Container(
                          height: 35,
                          child:Align(
                              alignment: Alignment.centerLeft,
                              child:   new Text(fileType_Name,
                                style: TextStyle(color: Colors.black,fontSize: 12),
                              )
                          )
                      )),

                ],
              ),
            ),
          ],
        )
    );
  }

  Container create_HRA_Button_AddEdit() {
    return Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(0.0),
              ),
              padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 30,
                    decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: new BorderRadius.circular(5.0),
                        border: Border.all(color: primaryColor,
                            width: 1.0,
                            style: BorderStyle.solid)
                    ),
                    child: Material(
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(5.0),
                      color: primaryColor,
                      child:MaterialButton(
                          minWidth: 50,
                          // height: 10,
                          onPressed: ()
                          {
                            checkTheFieldValidation();
                          },
                          child: Text('Update',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 13))
                      ),
                    ),
                  ),
                ],
              ),

            ),
          ],
        )
    );
  }

  SizedBox create_Gap(){
    return SizedBox(
      height: 5,
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

    SharedPreference.getIncomeTax_HeadsFinancialYear().then((value) => {
      financialYear=value

    });
    SharedPreference.getIncomeTax_HeadsId().then((value) =>  {
      headId="5",
      //print('show emp rent head update id $headId')

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
      empCode=value,
      //print('show emp name2 $value'),
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth_key=value,
      //print('show emp name2 $value'),
      completeEmpCode = mobileNumber_key+"CJHUB"+empCode_key+"CJHUB"+empDateOfBirth_key,
    });

  }

  convertImageFormat_base64()
  {
    /*---------use for camera and gallery(use for image or pdf)--20/11/2021 start-----------*/
    List<int>? imageBytes;
    //print('show action TYpe : $actionType');
    //print('show action TYpe web : $actionType_web');

    if(actionType == actionType_web){

      //print("output for web file picker");
      imageBytes = fileBytes;
      baseimage = base64Encode(imageBytes!);

      //print('bytes for web: $imageBytes');

    }


    //print("xyzmobile");

    if (actionType == actionType_Gallery)
    {
      //print("xyzmobile 2");

      if (fileName == null) return;
      // imageBytes = File(fileNameGallery).readAsBytesSync();
      //print('gallery image as converted into bytes1 $fileName');

      imageBytes = File(fileName).readAsBytesSync();
      baseimage = base64Encode(imageBytes);

      //print('gallery image as converted into bytes2 $imageBytes');
    }

    //use for camera
    if (actionType == actionType_Camera)
    {
      //print("xyzmobile 3 caemra");


      if (_croppedFile!.path == null) return;
      imageBytes = File(_croppedFile!.path).readAsBytesSync();
      baseimage = base64Encode(imageBytes);

      //print("camera imageBytes : $imageBytes");


    }

    if(baseimage==""||baseimage==null)
    {
      baseimage=document_path;
      fileType_Name=original_document_name;
      original_document_name=original_document_name;
    }
    //print(baseimage);
    //print('show file type name $fileType_Name');

    final kb = imageBytes!.length/1024;
    final mb = kb/1024;
    //print('show image size in MB $mb');
    //print('show image size in KB $kb');

    /*-----------------25-2-2022 start------------------*/
    if(1024>=kb)
    {
      //print("show size less than 1MB $kb");

    }
    else
    {
      //print("show size greater than 1MB $kb");
      baseimage="";
      var checkFileExtension=fileType_Name.split(".").last;
      fileType_Name="";
      checkFileExtension=checkFileExtension.toUpperCase();
      checkFileExtension=checkFileExtension+" File Size Must Be Less Than 1MB";
      show_OKAlert(checkFileExtension);

    }
    /*-----------------25-2-2022 end------------------*/

  }

  /*checkAmountLimit_or_OtherValidation()
  {
    String tenurId=tenureId;
    int cal_RentAmount=0;
    if(tenurId=="1")
    {
      //Monthly
      cal_RentAmount=int.parse(rentAmount)*12;
    }
    if(tenureId=="2")
    {
      //Quarterly
      cal_RentAmount=int.parse(rentAmount)*4;
    }
    if(tenureId=="3")
    {
      //Half-Yearly
      cal_RentAmount=int.parse(rentAmount)*2;
    }
    if(cal_RentAmount=="4")
    {
      //Yearly
      cal_RentAmount=int.parse(rentAmount);
    }

    //print('show total rent amount $cal_RentAmount');


    if(cal_RentAmount > 100000)
    {
      if (landlordName != "")
      {
        if (landlordAddress != "")
        {
          if (landlordPanNo != "")
          {
            checkTheFieldValidation();
          }
          else {
            show_OKAlert("Enter the landlord pan number");
          }
        }
        else {
          show_OKAlert("Enter the landlord address");
        }
      }
      else {
        show_OKAlert("Enter the landlord name");
      }
    }
    else
    {
      checkTheFieldValidation();
    }

  }*/

  checkTheFieldValidation()
  {
    if (fromDate != "Select date")
    {
      if (toDate != "Select date")
      {
        if (receiptNo != "")
        {
          if (receiptDate != "Select date")
          {
            if (rentAmount != "")
            {
              if (baseimage != "")
              {
                save_HRA_Details();
              }
              else {
                show_OKAlert("Upload the document");
              }
            }
            else {
              show_OKAlert("Enter the amount");
            }
          }
          else {
            show_OKAlert("Select the Receipt date");
          }
        }
        else {
          show_OKAlert("Enter the receipt no");
        }
      }
      else {
        show_OKAlert("Select the To date");
      }
    }
    else {
      show_OKAlert("Select the From date");
    }


  }


  save_HRA_Details() async
  {

    print("show headId $headId");
    print("show receiptNo $receiptNo");
    print("show fromDate $fromDate");
    print("show to_date $toDate");
    print("show receiptNo $receiptNo");
    print("show receiptDate $receiptDate");
    print("show landlordAddress $landlordAddress");
    print("show landlordCity $landlordCity");
    print("show landlordState $landlordStateId");
    print("show financial_year $financialYear");
    print("show tenure $tenureId");
    print("show rent amount $rentAmount");
    print("show landLord Name $landlordName");
    print("show landLord PAN $landlordPanNo");
    print("show documnet Path $baseimage");
    print("show document_name $fileType_Name");
    print("show original_document_name $fileType_Name");
    print("show created_by $empId");
    print("show created_ip $empIPAddress");
    print("show emp_code ${getEncrypted_EmpCode(completeEmpCode)}");


    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.save_UploadInvestmentProof_HRA),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },

        body: {
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'head_id': headId,
          'financial_year': financialYear,
          'tenure': tenureId,
          'from_date': fromDate,
          'to_date': toDate,
          'receipt_no': receiptNo,
          'receipt_date': receiptDate,
          'rent_amount': rentAmount,
          'landlord_name': landlordName,
          'landlord_address': landlordAddress,
          'landlord_city': landlordCity,
          'landlord_state': landlordStateId,
          'landlord_pan': landlordPanNo,
          'document_path': baseimage,
          'document_name': fileType_Name,
          'original_document_name': fileType_Name,
          'created_by': empId,
          'created_ip': empIPAddress,

        },

      );
      //print(response.statusCode);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        HRA_Save_ModelResponse hra_save_modelResponse = HRA_Save_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(hra_save_modelResponse.statusCode==true)
        {
          show_OKAlert_Success(hra_save_modelResponse.message);

        }
        else
        {
          if (hra_save_modelResponse.message==null || hra_save_modelResponse.message=="")
          {
            show_OKAlert("server error!");

          }else {
            show_OKAlert(hra_save_modelResponse.message);
          }
        }

      }
      else {

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
  show_OKAlert_Success(String message)
  {
    var alertDialog = AlertDialog(
      content: Text(message,
        textAlign: TextAlign.left,),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [

        TextButton(onPressed: ()
        {
          Navigator.of(context).pop();
          Navigator.push(context, MaterialPageRoute(builder: (context) =>

          Responsive(
              mobile:  UploadInvestmentProof_HRA_View(userArriveFrom_AddToView_or_DirectView: "AddToRentDetailsView",),
              tablet: Center(
                child: Container(
                  width: flutterWeb_tabletWidth,
                  child:  UploadInvestmentProof_HRA_View(userArriveFrom_AddToView_or_DirectView: "AddToRentDetailsView",),
                ),
              ),
              desktop: Center(
                child: Container(
                  width: flutterWeb_desktopWidth,
                  child:  UploadInvestmentProof_HRA_View(userArriveFrom_AddToView_or_DirectView: "AddToRentDetailsView",),
                ),
              )
          )
              // UploadInvestmentProof_HRA_View(userArriveFrom_AddToView_or_DirectView: "AddToRentDetailsView",)
          ),);

        },

          child: Text("OK",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
      ],

    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }


  /*--------------04-08-2022 start------------*/

  checkWebAndMobile(){

    if(kIsWeb){
      var alertDialog = AlertDialog(
        content: Text('Upload Document',),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0))
        ),

        actions: [

          TextButton(onPressed: (){Navigator.of(context).pop();},

              child: Text("Cancel",
                textAlign: TextAlign.center,style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),)
          ),

          SizedBox(width: 20.0),

          TextButton(onPressed: (){


            actionType = actionType_web;
            _pickFiles();

            Navigator.pop(context);


          },
            child: Text("Upload",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
        ],

      );
      showDialog(
          context: context,
          builder: (BuildContext context) => alertDialog

      );
      // Navigator.of(context).pop();

    }

    else{
      alert_dialog(context);
    }

  }

  _cameraPicker(ImageSource source) async {
    /* File picked = await ImagePicker.pickImage(source: source,imageQuality: Method.getImageQuality());
    if (picked != null) {
      _cropImage(picked);
    }
    Navigator.pop(context);*/

    final ImagePicker _picker = ImagePicker();
    XFile? picked = await _picker.pickImage(source: source,imageQuality: Method.getImageQuality());

    if (picked != null) {

      var fileName = (picked.name);

      //print('show profile mobile gallery picked $fileName');

      _cropImage(File(picked.path));

    }

  }

  _cropImage(File picked) async
  {
    /* File cropped = await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
        statusBarColor: primaryColor,
        toolbarColor: primaryColor,
        toolbarTitle: "Crop Image",
        toolbarWidgetColor: Colors.white,
      ),
      sourcePath: picked.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio4x3,
      ],
      maxWidth: 800,
    );
    if (cropped != null) {
      setState(() {
        _pickedImage = cropped;
        actionType = actionType_Camera;
        // Camera_fileName = _pickedImage.toString();
        fileType_Name = 'chaptervi.png';
        //print('camera path: $fileType_Name');

        convertImageFormat_base64();
      });
    }*/

    final croppedFile  = await ImageCropper().cropImage(
      uiSettings: buildUiSettings(context),
      sourcePath: picked.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio4x3,
      ],

      maxWidth: 800,
    );
    if (croppedFile != null) {

      //print('cropped file');

      var f = await croppedFile.readAsBytes();

      //print('cropped file2');

      var selected = File(croppedFile.path);

      //print("cropped path :${selected}");

      _file = selected;

      setState(() {
        _croppedFile = croppedFile;

        if(actionType == actionType_Camera){
          _file = selected;

          //print('Camera picked path: $_file');


          // Camera_fileName = _pickedImage.toString();
          fileType_Name = getCJHub_HRAIcon;
          //print('camera path: $fileType_Name');

        }
        else{


        }

        convertImageFormat_base64();

      });

    }
  }

  void _pickFiles() async {

    //print('calling pick files');

    try {
      _directoryPath = null;
      if(_multiPick){
        _paths = (await FilePicker.platform.pickFiles(
            type: _pickingType,
            allowMultiple: _multiPick,
            onFileLoading: (FilePickerStatus status) => print(status),
            allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png']
        ))?.files;
      }
      else{
        //print('show single path');
        _path = await FilePicker.platform.pickFiles(
            type: _pickingType,
            allowMultiple: _multiPick,
            onFileLoading: (FilePickerStatus status) => print(status),
            allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png']
        );

        if (_path != null) {
          //print("path not null");
          fileBytes = _path!.files.first.bytes;

          if(actionType==actionType_web){

            fileName = _path!.files.first.name;

          }
          else{

            fileName = _path!.files!.first.path!;

          }

          // file_gallery = _path.files.first;

          //print("File Name :$fileName");
          //print("File As a Bytes :$fileBytes");
          ////print("mobile file name :$file_gallery");

        }
      }

    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }

    if (!mounted) return;
    setState(() {

      if(fileName.length>0)
      {
        _fileName = fileName.split('/').last;
        //print('show the web  path: $_fileName');

        var checkFileExtension=_fileName.split(".").last;
        checkFileExtension=checkFileExtension.toLowerCase();


        if(checkFileExtension == "jpg" || checkFileExtension == "jpeg" || checkFileExtension == "png" || checkFileExtension == "pdf")
        {
          //print('show the web1  path: $_fileName');

          fileType_Name = _fileName ?? '...';
          //print('gallery path: $fileType_Name');
          //print('show the web2  path: $_fileName');


          // Navigator.pop(context);

          convertImageFormat_base64();
          //print(('only pdf and image1 $checkFileExtension'));
          //print('show the web3  path: $_fileName');

        }
        else
        {

          String newExtension=checkFileExtension+" "+"not allowed";
          baseimage="";
          show_OKAlert(newExtension);
          // Navigator.pop(context);

        }
      }
      else
      {
        baseimage="";
        Navigator.pop(context);
      }

      // //print('gallery path: $fileType_Name');
      // actionType = actionType_Gallery;

      // Navigator.pop(context);

    });
  }

  void _logException(String message) {
    //print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

/*--------------04-08-2022 end------------*/

}