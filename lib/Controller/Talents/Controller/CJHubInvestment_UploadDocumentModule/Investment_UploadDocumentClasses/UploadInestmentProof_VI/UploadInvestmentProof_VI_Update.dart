import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:http/http.dart'as http;


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

import '../UploadInestmentProof_VI/UploadInvestmentProof_VI_View.dart';
import '../../UploadInvestmentProof_ModelClasses//HRA_Save_ModelResponse.dart';
import '../../UploadInvestmentProof_ModelClasses/ChapterVI_View_ModelResponse.dart';

import 'cropper/ui_helper.dart'
if (dart.library.io) 'cropper/mobile_ui_helper.dart'
if (dart.library.html) 'cropper/web_ui_helper.dart';

/*import '../cropper/ui_helper.dart'
if (dart.library.io) 'cropper/mobile_ui_helper.dart'
if (dart.library.html) 'cropper/web_ui_helper.dart';*/


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
      home: UploadInvestmentProof_VI_Update(title: 'CJ Hub'),
    );
  }
}
class UploadInvestmentProof_VI_Update extends StatefulWidget {

  UploadInvestmentProof_VI_Update({Key? key, this.title,this.chapterVI_ObjData}) : super(key: key);

  final String? title;
  final Data? chapterVI_ObjData;

  @override
  _UploadInvestmentProof_VI_Update createState() => _UploadInvestmentProof_VI_Update(chapterVI_ObjData!);
}

class _UploadInvestmentProof_VI_Update extends State<UploadInvestmentProof_VI_Update> {


  Data? chapterVI_ObjData;

  _UploadInvestmentProof_VI_Update(Data obj)
  {
    this.chapterVI_ObjData=obj;
  }

  Uint8List? fileBytes;
  String? fileName;
  File _file = File("zz");
  CroppedFile? _croppedFile;

  String? valueChoose ;
  String investment_name="Select";
  String investment_id="Select";
  String receipt_amount="testing";
  String receipt_number="testing";
  String receipt_date="Select date";

  String approval_status="testing";
  String document_path="testing";
  String document_name="testing";
  String original_document_name="testing";



  String empCode="",empName="",panNumber="";
  String completeEmpCode="",headId="";
  String financialYear="2021-22";
  String empId="",empIPAddress="";


  String? _fileName;
  FilePickerResult? _path;
  // Map<String, String> _paths;
  String? _extension;
  bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType = FileType.custom;
  File? _pickedImage;
  // String Camera_fileName;
  String actionType_Gallery = 'gallery';
  String actionType_Camera = 'camera';
  String actionType_web = 'upload';
  String actionType = '';
  String fileType_Name = 'No file choosen';


  String? checkbox_Status_parentssenior_citizen_Str,checkbox_Status_disabilitymore_Str,
      checkbox_Status_employee_disability_Str;

  bool parents_senior_citizen = false;
  bool disability_dependent = false;
  bool employee_disability = false;

  String? baseimage;

  var txtController_receiptNo = TextEditingController();
  var txtController_rentAmount = TextEditingController();

  /*--------------04-08-2022 start------------*/

  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  List<PlatformFile>? _paths;
  String? _directoryPath;

  /*--------------04-08-2022 end------------*/


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadBasicInfo();
    getBasicInfo();

    if(kIsWeb){

      //print("This Upload CJ Hub tax section Web");

      AutoLogout.initializeTimer(context);

    }
    else{

      //print('this is mobile App');

    }
  }

  loadBasicInfo()
  {
    setState(()
    {

      investment_name=chapterVI_ObjData!.investmentName;
      investment_id=chapterVI_ObjData!.investmentId;
      receipt_amount=chapterVI_ObjData!.receiptAmount;
      receipt_number=chapterVI_ObjData!.receiptNumber;
      receipt_date=chapterVI_ObjData!.receiptDate;

      txtController_receiptNo.text=receipt_number;
      txtController_rentAmount.text=receipt_amount;

      approval_status=chapterVI_ObjData!.approvalStatus;
      document_path=chapterVI_ObjData!.documentPath;
      document_name=chapterVI_ObjData!.documentName;
      original_document_name=chapterVI_ObjData!.originalDocumentName;
      fileType_Name=original_document_name;

      if(chapterVI_ObjData!.parentSeniorCitizen=="Y")
      {
        parents_senior_citizen=true;
      }
      else
      {
        parents_senior_citizen=false;
      }

      if(chapterVI_ObjData!.disabilityMoreThan80=="Y")
      {
        disability_dependent=true;
      }
      else
      {
        disability_dependent=false;
      }

      if(chapterVI_ObjData!.employeeWithSevereDisability=="Y")
      {
        employee_disability=true;
      }
      else
      {
        employee_disability=false;
      }


    });

    SharedPreference.networkImageToBase64(chapterVI_ObjData!.documentPath).then((value) =>  {

      baseimage=value,
      //print('show document $value'),
      //loadData()
    });


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

  alert_dialog(BuildContext context) {
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
          fileType_Name = getCJHub_ChapterVIIcon;
          //print('camera path: $fileType_Name');

        }
        else{


        }

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
          //print('This is for multiple file pick');
          _path = null;

          _path = await FilePicker.platform.pickFiles(
              type: _pickingType,
              allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png']);


          if (_path != null) {
            fileBytes = _path!.files.first.bytes;
            fileName = _path!.files.first.name;

            //print("File Name :$fileName");
            //print("File As a Bytes :$fileBytes");

          }

        }
        else
        {
          //print('show the correct value updated');
          _paths = null;

          _path = await FilePicker.platform.pickFiles(
              type: _pickingType,
              allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png']);


          if (_path != null) {
            fileBytes = _path!.files.first.bytes;
            fileName = _path!.files.first.name;

            //print("File Name :$fileName");
            //print("File As a Bytes :$fileBytes");

          }


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


        if(fileName!.length>0)
        {
          _fileName = fileName!.split('/').last;

          var checkFileExtension=_fileName!.split(".").last;
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



    }
  }

  // _cameraPicker(ImageSource source) async {
  //  /* File picked = await ImagePicker.pickImage(source: source,imageQuality: Method.getImageQuality());
  //   if (picked != null) {
  //     _cropImage(picked);
  //   }
  //   Navigator.pop(context);*/
  //
  //   final ImagePicker _picker = ImagePicker();
  //   XFile picked = await _picker.pickImage(source: source,imageQuality: Method.getImageQuality());
  //
  //   if (picked != null) {
  //
  //     var fileName = (picked.name);
  //
  //     //print('show profile mobile gallery picked $fileName');
  //
  //     _cropImage(File(picked.path));
  //
  //   }
  // }
  //
  // _cropImage(File picked) async {
  //  /* File cropped = await ImageCropper.cropImage(
  //     androidUiSettings: AndroidUiSettings(
  //       statusBarColor: primaryColor,
  //       toolbarColor: primaryColor,
  //       toolbarTitle: "Crop Image",
  //       toolbarWidgetColor: Colors.white,
  //     ),
  //     sourcePath: picked.path,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio16x9,
  //       CropAspectRatioPreset.ratio4x3,
  //     ],
  //     //maxWidth: 800,
  //   );
  //   if (cropped != null) {
  //     setState(() {
  //       _pickedImage = cropped;
  //       actionType = actionType_Camera;
  //       // Camera_fileName = _pickedImage.toString();
  //       fileType_Name = 'chaptervi.png';
  //       //print('camera path: $fileType_Name');
  //
  //       convertImageFormat_base64();
  //
  //     });
  //   }*/
  //
  //   final croppedFile  = await ImageCropper().cropImage(
  //     uiSettings: buildUiSettings(context),
  //     sourcePath: picked.path,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio16x9,
  //       CropAspectRatioPreset.ratio4x3,
  //     ],
  //
  //     maxWidth: 800,
  //   );
  //   if (croppedFile != null) {
  //     var f = await croppedFile.readAsBytes();
  //
  //     var selected = File(croppedFile.path);
  //
  //     _file = selected;
  //
  //     setState(() {
  //       _croppedFile = croppedFile;
  //
  //       if(!kIsWeb){
  //         _file = selected;
  //
  //         actionType = actionType_Camera;
  //         // Camera_fileName = _pickedImage.toString();
  //         fileType_Name = 'chaptervi.png';
  //         //print('camera path: $fileType_Name');
  //
  //       }
  //       else{
  //
  //
  //       }
  //
  //       convertImageFormat_base64();
  //
  //     });
  //
  //   }
  // }

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


  @override
  Widget build(BuildContext context) {
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handleUserInteraction,
        onPointerMove: _handleUserInteraction,
        onPointerUp: _handleUserInteraction,
        child:
      Scaffold(
     /* appBar: AppBar(leading: BackButton(
          color: Colors.black
      ), backgroundColor: Color(0xfff0f0f2),centerTitle: true,
        title: Image.asset(getCJHub_AppLogo,height: 90,width: 90,),),*/

        backgroundColor: Colors.white,
        appBar:CJAppBar("", appBarBlock: AppBarBlock(appBarAction: ()
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

            /*-----------3-12-2021 start-----------*/
            Container(
              // color: Colors.red,
              child: checkBox_Container(),
            ),
            create_Gap(),
            /*-----------3-12-2021 end-----------*/
            Container(
              // color: Colors.red,
              child: create_VI_text(),
            ),
            Container(
              // color: Colors.red,
              child: create_VI__Receipt_No_Date(),
            ),
            Container(
              // color: Colors.red,
              child: create_VI__Receipt_Amount(),
            ),
            Container(
              // color: Colors.red,
              child: create_VI_ChooseFile(),
            ),

            Container(
              child: create_NoteContainer(),
            ),

            create_Gap(),
            create_Gap(),

            Container(
              // color: Colors.red,
              child: create_VI_Button_update(),
            ),

          ],
        ),
      ),
    )
    );
  }

  /*--------------04-08-2022 start------------*/


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

            fileName = _path!.files.first.path;

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

      if(fileName!.length>0)
      {
        _fileName = fileName!.split('/').last;
        //print('show the web  path: $_fileName');

        var checkFileExtension=_fileName!.split(".").last;
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

  /*--------------04-08-2022 start------------*/


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

  Container create_VI_ChooseFile() {
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
                          onPressed: () {

                            checkWebAndMobile();

                          },
                          child: Text('Choose File',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Vonique',color: Colors.black,fontSize: 13))
                      ),
                    ),
                  )),

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


  Container checkBox_Container() {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: parents_senior_citizen,
                                onChanged: (bool? value) {
                                  setState(() {
                                    parents_senior_citizen = value!;
                                  });
                                },
                              ),
                              Text(
                                "Parents Senior Citizen (Claim Under 80D)",textAlign: TextAlign.center,
                                style: new TextStyle(fontSize: 12.0),
                              ),


                            ],
                          ),
                        )),

                        Expanded(
                          flex: 1,
                            child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.28,
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          // color: Colors.greenAccent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: disability_dependent,
                                onChanged: (bool? value) {
                                  setState(() {
                                    disability_dependent = value!;
                                  });
                                },
                              ),

                              Text(
                                "Disability More Than 80% with Dependent (80DD)",textAlign: TextAlign.center,
                                style: new TextStyle(fontSize: 12.0),
                              ),


                            ],
                          ),
                        )),

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
                                value: employee_disability,
                                onChanged: (bool? value) {
                                  setState(() {
                                    employee_disability = value!;
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
    );
  }

  Container create_VI_text() {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: Style_UploadInvestment_Top,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex:1,
                      child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.8,
                      height: 30,
                      child: Text(investment_name,style: k80C_VI_Edit_value)
                  ))
                  ,
                ],
              ),

            ),
          ],
        )
    );
  }

  Container create_VI__Receipt_No_Date() {
    return  Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),

        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: Style_UploadInvestment_Inner,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                          // keyboardType: TextInputType.text,
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
                            hintText: receipt_number,
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            receipt_number=value;
                          },

                        ),
                      ),

                    ],
                  )),

                  SizedBox(
                    width: 5,
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
                                          receipt_date,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black)
                                      ),

                                      onTap: ()
                                      {
                                        _selectDate(context);
                                      },
                                    ),
                                    MaterialButton(
                                        minWidth: 5,
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onPressed:()
                                        {
                                          _selectDate(context);
                                        },
                                        child: Text('')
                                    ),
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

  Container create_VI__Receipt_Amount() {
    return  Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: Style_UploadInvestment_Inner,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                          child: Text("Receipt Amount",style: TextStyle(color: primaryColor,fontSize: 12),),
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
                            hintText: receipt_amount,
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            receipt_amount=value;
                          },

                        ),
                      ),

                    ],
                  )),

                  SizedBox(
                    width: 5,
                  ),

                  Expanded(
                      flex:1,
                      child: Column(
                        children: [

                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.4,

                          ),


                        ],
                      )),
                ],
              ),

            ),
          ],
        )
    );
  }

  Container create_VI_Button_update() {
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
              padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
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
                            save_ChapterVI_Details();
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(Method.getStartYear()),
      lastDate: DateTime(Method.getEndYear()),
    );
    if (d != null)
      setState(() {

        //receipt_date = new DateFormat.yMMMd("en_US").format(d);
        receipt_date = new DateFormat.yMd("en_US").format(d);
        receipt_date=Method.changeTheDateFormat_ForUploadInvestmentDeclaration(receipt_date);
      });
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
      headId="1",
      //print('show emp getIncomeTax_HeadsId $headId'),
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

      //print('bytes for mobile: $imageBytes');

    }


    //print("xyzmobile");

    if (actionType == actionType_Gallery)
    {
      //print("xyzmobile 2");

      if (fileName == null) return;
      // imageBytes = File(fileNameGallery).readAsBytesSync();
      //print('gallery image as converted into bytes1 $fileName');

      imageBytes = File(fileName!).readAsBytesSync();
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
    //print("update baseimage : $baseimage");
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
  save_ChapterVI_Details() async
  {

    if(parents_senior_citizen==true)
    {
      checkbox_Status_parentssenior_citizen_Str="Y";
    }
    else
    {
      checkbox_Status_parentssenior_citizen_Str="N";

    }
    if(disability_dependent==true)
    {
      checkbox_Status_disabilitymore_Str="Y";

    }
    else
    {
      checkbox_Status_disabilitymore_Str="N";

    }
    if(employee_disability==true)
    {
      checkbox_Status_employee_disability_Str="Y";

    }
    else
    {
      checkbox_Status_employee_disability_Str="N";

    }





    /*---------use for camera and gallery(use for image or pdf)--20/11/2021 end-----------*/

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.save_UploadInvestmentProof_chapterVI),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },

        body: {
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'head_id': headId,
          'financial_year': financialYear,
          'investment_id': investment_id,
          'receipt_amount': receipt_amount,
          'receipt_number':receipt_number,
          'receipt_date':receipt_date,
          'investment_comment': "akal",
          'document_path': baseimage,
          'document_name': fileType_Name,
          'original_document_name': fileType_Name,
          'created_by': empId,
          'created_ip': empIPAddress,
          'parent_senior_citizen':checkbox_Status_parentssenior_citizen_Str,
          'disability_more_than_80':checkbox_Status_disabilitymore_Str,
          'employee_with_severe_disability':checkbox_Status_employee_disability_Str

        },


      );
      //'receipt_no': "receiptNo",
      //'receipt_date': "receiptDate",


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

        TextButton(onPressed: ()
        {
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
              mobile: UploadInvestmentProof_VI_View(userArriveFrom_AddToView_or_DirectView: "AddToChapterVIView",),
              tablet: Center(
                child: Container(
                  width: flutterWeb_tabletWidth,
                  child: UploadInvestmentProof_VI_View(userArriveFrom_AddToView_or_DirectView: "AddToChapterVIView",),
                ),
              ),
              desktop: Center(
                child: Container(
                  width: flutterWeb_desktopWidth,
                  child: UploadInvestmentProof_VI_View(userArriveFrom_AddToView_or_DirectView: "AddToChapterVIView",),
                ),
              ),
          )
              // UploadInvestmentProof_VI_View(userArriveFrom_AddToView_or_DirectView: "AddToChapterVIView",)

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

}