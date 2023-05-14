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
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../../../Constant/Constants.dart';
import '../../../../../../Constant/Responsive.dart';
import '../../../../../../CustomView/CJHubCustomView/AutoLogout.dart';
import '../../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../../CustomView/CJHubCustomView/ValidateClass.dart';
import '../../../../../../CustomView/CJHubCustomView/palatte_Textstyle.dart';
import '../../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../../Services/Messages/Message.dart';
import '../../../CJHubInvestment_DeclarationModule/ModelClasses/Investment_Declaration_ChapterVI_ModelResponse.dart';
import '../../UploadInvestmentProof_ModelClasses/HRA_Save_ModelResponse.dart';

import 'UploadInvestmentProof_VI_View.dart';
import 'package:http/http.dart'as http;

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
      home: UploadInvestmentProof_VI_Add(title: 'CJ Hub'),
    );
  }
}
class UploadInvestmentProof_VI_Add extends StatefulWidget {

  UploadInvestmentProof_VI_Add({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _UploadInvestmentProof_VI_Add createState() => _UploadInvestmentProof_VI_Add();
}

class _UploadInvestmentProof_VI_Add extends State<UploadInvestmentProof_VI_Add>
{
  // This widget is the root of your application.

  Uint8List? fileBytes;
  String? fileName;
  Uint8List? fileBytesGallery;
  String? fileNameGallery;
  File _file = File("zz");
  CroppedFile? _croppedFile;

  String? valueChoose ;

  String? _fileName;
  FilePickerResult? _path;
  FilePickerResult? _pathGallery;
  String baseimage="";

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

  String actionType = 'upload';
  String fileType_Name = 'No file choosen';

  int count_nextVariable = 1;

  String empCode="",empName="",panNumber="";
  String completeEmpCode="",headId="";
  String financialYear="2021-22";
  List<SectionInvestmentHeadList> sectionDataList=[SectionInvestmentHeadList(investmentName: "Mediclaim (Self/Spouse/Children) (80D)",investmentAmount: "10")];
  List<InvestmentChoices>? choicesList;
  List<SectionInvestmentHeadList>?filterDataList;

  SectionInvestmentHeadList? sectionObj;
  String empId="",empIPAddress="";


  String investmentName="Select" ;
  String investmentId="";
  String receipt_amount="";
  String receipt_number="";
  String receipt_date="Select date";

  var txtController_receipt_amount = TextEditingController();
  var txtController_receipt_number = TextEditingController();



  String? checkbox_Status_parentssenior_citizen_Str,checkbox_Status_disabilitymore_Str,
      checkbox_Status_employee_disability_Str;


  final _formsPageViewController = PageController();
  List? _forms;


  bool parents_senior_citizen = false;
  bool disability_dependent = false;
  bool employee_disability = false;

  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  List<PlatformFile>? _paths;
  String? _directoryPath;
  // String _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  PlatformFile? file_gallery;


  //String _selectedDate = 'Select date';

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

        },
          child: Text("Camera",
            textAlign: TextAlign.right,style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),

        SizedBox(width: 5.0),

        TextButton(onPressed: (){

          actionType= actionType_Gallery;
          // _galleryPicker();
          _pickFiles();

          Navigator.pop(context);

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

  /*------------------For web and Gallery picker ---------on 01-08-2022-------start-----*/

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

/*------------------For web and Gallery picker ---------on 01-08-2022-------end-----*/



  void _galleryPicker() async
  {

    if (_pickingType !=  _hasValidMime)
    {
      try
      {
        if (_multiPick)
        {
          //print('show the correct value');
          _pathGallery = null;
          /*_paths = await FilePicker.getMultiFilePath(
              type: _pickingType,
              allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png']);*/
        }
        else
        {
          //print('show the incorrect value');
          _paths = null;

          _pathGallery = await FilePicker.platform.pickFiles(
              type: _pickingType,
              allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png']);

          if (_pathGallery != null) {
            fileBytesGallery = _pathGallery!.files.first.bytes;
            fileNameGallery = _pathGallery!.files.first.name;

            //print("File Name in Mobile mode :$fileNameGallery");
            //print("File As a Bytes in Mobile mode :$fileBytesGallery");
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

        /*------------21-2-2022 start-----------------*/
        if(fileNameGallery!.length>0)
        {
          _fileName = fileNameGallery!.split('/').last;

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

      /*------------21-2-2022 end-----------------*/

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
          fileType_Name = getCJHub_ChapterVIIcon;
          //print('camera path: $fileType_Name');

        }
        else{


        }

        convertImageFormat_base64();

      });

    }
  }


  checkWebAndMobile(){

    if(kIsWeb){

      //print('file picker for web');

      var alertDialog = AlertDialog(
        content: Text('Upload File',),
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

      //print('file picker for mobile');

      alert_dialog(context);
    }

  }


  /*------------------For web and Gallery picker ---------on 01-08-2022-------start-----*/
  
  convertImageFormat_base64()
  {
    /*---------use for camera and gallery(use for image or pdf)--20/11/2021 start-----------*/
    List<int>? imageBytes;

    /*--------------04-08-2022 start------------*/


    //print('show action TYpe : $actionType');
    //print('show action TYpe web : $actionType_web');

    if(actionType == actionType_web){

      //print("output for web file picker");
      imageBytes = fileBytes;

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

        //print('gallery image as converted into bytes2 $imageBytes');
      }

      //use for camera
      if (actionType == actionType_Camera)
      {
        //print("xyzmobile 3 caemra");


        if (_croppedFile!.path == null) return;
        imageBytes = File(_croppedFile!.path).readAsBytesSync();

        //print("camera imageBytes : $imageBytes");


      }

    /*--------------04-08-2022 end------------*/


  /*  //use for gallery
    if (actionType == actionType_Gallery)
    {
      if (_path == null) return;

        //print("output for mobile file picker");
      imageBytes = File(fileName).readAsBytesSync();

        //print('bytes for mobile: $imageBytes');

    }

    //use for web
    if (actionType == actionType_web)
    {
      if (_path == null) return;

      //print("output for web file picker");
      imageBytes = fileBytes;

      //print('bytes for mobile: $imageBytes');

    }


    //use for camera
    if (actionType == actionType_Camera)
    {
      if (_pickedImage == null) return;
      imageBytes = File(_pickedImage.path).readAsBytesSync();
    }*/

    //print("xyzmobile 4 before base64");

    baseimage = base64Encode(imageBytes!);

    //print("xyzmobile 5 after base64");

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

    /*---------use for camera and gallery(use for image or pdf)--20/11/2021 end-----------*/

  }

  /*------------------For web and Gallery picker ---------on 01-08-2022-------end-----*/

  Widget _buildChild_chooseFile()
  {
   /* if (actionType == actionType_Camera) {
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
    else if(actionType ==actionType_web){
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
    }*/

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

  void _nextFormStep()
  {
    count_nextVariable = count_nextVariable+1;
    if(count_nextVariable<=4)
    {
      _formsPageViewController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }else
    {

    }

  }

  bool onWillPop()
  {
    if (_formsPageViewController.page!.round() ==
        _formsPageViewController.initialPage) return true;

    _formsPageViewController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );

    return false;
  }

  @override
  Widget build(BuildContext context)
  {
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

  Widget Step1Container()
  {
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handleUserInteraction,
        onPointerMove: _handleUserInteraction,
        onPointerUp: _handleUserInteraction,
        child:
      Scaffold(

      body:  SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),

        child:
        Column(
          children: <Widget>[

            create_Gap(),
            create_Gap(),

            Container(
              // color: Colors.red,
              child: checkBox_Container(),
            ),
            create_Gap(),
            Container(
              // color: Colors.red,
              child: dropDownButton_Container(),
            ),
            /*create_Gap(),
            create_Gap(),*/

            Container(
              // color: Colors.red,
              //child: create_VI_GrossProofAmount(),
              child: create_VI__Receipt_No_Date(),


            ),
            Container(
              child: create_VI__Receipt_Amount(),
            ),

            Container(
              child: create_VI_ChooseFile(),
            ),

            Container(
              child: create_NoteContainer(),
            ),

            create_Gap(),
            create_Gap(),

            Container(
              // color: Colors.red,
              child: create_VI_Button_SaveFinish(),
            ),

          ],
        ),
      ),
    )
    );
  }



  Container create_NoteContainer() {
    return Container(
        width: double.maxFinite,
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
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: Style_UploadInvestment_Inner,

              padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    flex: 1,
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
                            onPressed: () => {

                              checkWebAndMobile()

                            },


                            child: Text('Choose File',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: 'Vonique',color: Colors.black,fontSize: 13))
                        ),
                      ),
                    ),
                  ),

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

  Container dropDownButton_Container(){
    return Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: Style_UploadInvestment_Top,
              padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
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

  Container dropDown(){
    return
      Container(
        padding: EdgeInsets.fromLTRB(10,0,10,0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: fourHunGreyColor,
              width: 1.0,
              style: BorderStyle.solid),
          borderRadius: new BorderRadius.circular(10.0),
        ),
        child:DropdownButton(
          hint: Text(investmentName),
          icon: Icon(Icons.arrow_drop_down),
          dropdownColor: Colors.white,
          underline: DropdownButtonHideUnderline(child: Container()),
          iconSize: 25,
          isExpanded: true,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
          value: sectionObj,
          onChanged: (SectionInvestmentHeadList? obj)
          {
            //print('show selected name $obj');
            setState(() {
              investmentName = obj!.investmentName;
              investmentId=obj!.investmentId;
            });
          },
          items: sectionDataList.map((SectionInvestmentHeadList obj){
            return DropdownMenuItem(
              value: obj,
              child: Text(obj.investmentName),
            );
          }).toList(),
        ),
      );
  }

  Container checkBox_Container()
  {
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

                        Expanded(
                          flex: 1,
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
                                      filterDataWhenUserSelectTheCheckBox();
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
                        ),

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
                                    filterDataWhenUserSelectTheCheckBox();
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
                                    filterDataWhenUserSelectTheCheckBox();
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
                  Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.3,
                      height: 30,
                      child: Text("",style: TextStyle(color: Colors.grey),)
                  ),
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

                  /*----------start---Added Expanded flex and sizedBox----------*/
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
                          child: Text("Receipt_No",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: TextField(controller: txtController_receipt_number,
                          // keyboardType: TextInputType.text,
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
                            hintText: "",
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
                  ))


                  /*----------end---Added Expanded flex and sizedBox----------*/


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
                        child: TextField(controller: txtController_receipt_amount,
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
                            hintText: "",
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


  Container create_VI_Button_SaveFinish() {
    return Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: new BoxDecoration(
                // color: Colors.grey[400],
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(0.0),
                /* border: Border.all(color: Colors.grey[200],
                      width: 1.0,
                      style: BorderStyle.solid)*/
              ),
              padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    width: 100,
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

                          //onPressed: ()=> _nextFormStep(),
                          onPressed: ()
                          {
                            checkTheFieldValidation();
                          },

                          child: Text('Save&Next',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 13))
                      ),
                    ),
                  )
                  ,

                   Container(
                    width: 100,
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
                            Navigator.push(context, MaterialPageRoute(builder: (_) =>

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
                                ))
                                // UploadInvestmentProof_VI_View(userArriveFrom_AddToView_or_DirectView: "AddToChapterVIView",)

                            ),);
                          },
                          child: Text('Finish',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 13))
                      ),
                    ),
                  )
                  ,
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

  Future<void> _selectDate(BuildContext context) async
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
      //print('show emp chapter-vi getIncomeTax_HeadsId $headId'),
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
      getTax_Sections()
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


          sectionDataList=vi_modelResponse.data!.sectionInvestmentHeadList!;
          loadData(sectionDataList, vi_modelResponse.data!.investmentChoices!);

          setState(() {

            if(sectionDataList.length>0)
            {

              investmentName = sectionDataList[0].investmentName;
              investmentId = sectionDataList[0].investmentId;

            }

          });
        }
        else
        {
          if (vi_modelResponse.message==null || vi_modelResponse.message=="")
          {
            show_OKAlert("server error!");

          }else {
            show_OKAlert(vi_modelResponse.message);
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
  loadData(List<SectionInvestmentHeadList>dataList,List<InvestmentChoices>choicesLists)
  {

    filterDataList = dataList;
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
      });


    });

  }

  /*-------------2-12-2021 start----------*/
  filterDataWhenUserSelectTheCheckBox()
  {

    List<SectionInvestmentHeadList> newCustomList=[];

    int i;
    int total = 0;

    for(i=0;i<filterDataList!.length;i++){

      String amount=filterDataList![i].investmentAmount.toString();
      int totalAmount=int.parse(amount);
      total = total + totalAmount;

      /*----28-5-2021 START NEW TASKS-----*/

      SectionInvestmentHeadList newModelObject=new SectionInvestmentHeadList();
      newModelObject.financialYear=filterDataList![i].financialYear;
      newModelObject.headId=filterDataList![i].headId;
      newModelObject.investmentAmount=filterDataList![i].investmentAmount;
      newModelObject.investmentComment=filterDataList![i].investmentComment;
      newModelObject.investmentDescription=filterDataList![i].investmentDescription;
      newModelObject.investmentId=filterDataList![i].investmentId;
      newModelObject.investmentName=filterDataList![i].investmentName;
      newModelObject.maxLimit=filterDataList![i].maxLimit;
      newModelObject.sectionName=filterDataList![i].sectionName;

      //String idtype=newModelObject.investmentId;
      ////print('show investment id $idtype');

      if (filterDataList![i].investmentName=="Mediclaim (Parents) (80D)" && filterDataList![i].maxLimit=="25000")
      {
        if (parents_senior_citizen==false)
        {
          newCustomList.add(newModelObject);

          String idtype=newModelObject.investmentId;
          //print('show mediclaim investment id $idtype');

        }else
        {

        }
      }
      else if (filterDataList![i].investmentName=="Mediclaim (Parents) (80D)" && filterDataList![i].maxLimit=="50000")
      {
        if (parents_senior_citizen==true)
        {
          newCustomList.add(newModelObject);

          String idtype=newModelObject.investmentId;
          //print('show mediclaim investment id $idtype');

        }else
        {

        }
      }
      else if (filterDataList![i].investmentName=="Handicaped Dependents (80DD)" && filterDataList![i].maxLimit=="75000")
      {
        if (disability_dependent==false)
        {
          newCustomList.add(newModelObject);

        }else
        {

        }
      }
      else if (filterDataList![i].investmentName=="Handicaped Dependents (80DD)" && filterDataList![i].maxLimit=="125000")
      {
        if (disability_dependent==true)
        {
          newCustomList.add(newModelObject);

        }else
        {

        }
      }
      else if (filterDataList![i].investmentName=="Pension Handicap (80U)" && filterDataList![i].maxLimit=="75000")
      {
        if (employee_disability==false)
        {
          newCustomList.add(newModelObject);

        }else
        {

        }
      }
      else if (filterDataList![i].investmentName=="Pension Handicap (80U)" && filterDataList![i].maxLimit=="125000")
      {
        if (employee_disability==true)
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
      });

    });
  }

  /*-------------2-12-2021 end----------*/






  checkTheFieldValidation()
  {
    if(receipt_number != "")
    {
      if(receipt_amount != "")
      {
        if(receipt_date != "Select date")
        {
          if(baseimage != "")
          {
            save_ChapterVI_Details();
          }
          else
          {
            show_OKAlert("Upload the document");

          }

        }
        else
        {
          show_OKAlert("Select the receipt date");

        }

      }
      else
      {
        show_OKAlert("Enter the receipt amount");

      }
    }
    else
    {
      show_OKAlert("Enter the receipt number");
    }
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
          'investment_id': investmentId,
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
          setState(() {


            txtController_receipt_amount.text="";
            txtController_receipt_number.text="";
            receipt_date="Select date";
            fileType_Name = "No file choosen";
            baseimage="";

          });
          show_OKAlert(hra_save_modelResponse.message);

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


}