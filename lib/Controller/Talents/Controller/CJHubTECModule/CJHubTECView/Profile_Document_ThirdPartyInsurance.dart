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
import 'package:intl/intl.dart';
import 'package:http/http.dart'as http;

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


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
import 'Profile_NewDocument.dart';
import 'cropper/ui_helper.dart'
if (dart.library.io) 'cropper/mobile_ui_helper.dart'
if (dart.library.html) 'cropper/web_ui_helper.dart';
import 'package:contractjobs/Controller/Talents/ModelClasses/CJHubModelClasses/ProfileDocumentType_ModelResponse.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: primaryColor
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
      home: Profile_Document_ThirdPartyInsurance(title: 'CJ Hub'),
    );
  }
}
class Profile_Document_ThirdPartyInsurance extends StatefulWidget {

  Profile_Document_ThirdPartyInsurance({Key? key, this.title,this.profileData}) : super(key: key);

  final String? title;
  final Data? profileData;

  @override
  _Profile_Document_ThirdPartyInsurance createState() => _Profile_Document_ThirdPartyInsurance(profileData!);
}

// ignore: camel_case_types
class _Profile_Document_ThirdPartyInsurance extends State<Profile_Document_ThirdPartyInsurance> {


  String Status = '1';

  String empId="",empIPAddress="";
  String complete_JSId="";


  bool selectItem_VisibilityStatus=true;
  String selectedItem="";



  String baseimage="";
  String? _fileName;
  // String _path="";
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

  String _selectedDate = 'From Date';
  String selectedFromDate = "Select Date";
  String _selectedDateTo = 'To Date';
  String selectedToDate = "Select Date";

  int checkPermissionStatus=0;


  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _directoryPath;
  List<PlatformFile>? _paths;
  FilePickerResult? _path;
  Uint8List? fileBytes;
  String? fileName;
  File _file = File("zz");
  CroppedFile? _croppedFile;

  Data? profileData;
  _Profile_Document_ThirdPartyInsurance(Data profileData)
  {
    this.profileData=profileData;
    selectedItem=profileData.documentDescription;
    selectedFromDate=profileData.validFrom;
    selectedToDate=profileData.validTo;

    if(selectedFromDate=="" || selectedFromDate==null)
    {
      selectedFromDate="Select Date";
      selectedToDate="Select Date";

    }
    else
    {
    }

  }
  @override
  void initState() {
    super.initState();
    setState(()
    {
    });

    getBasicInfo();
  }



  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2060),
    );
    if (d != null)
      setState(() {
        _selectedDate = new DateFormat.yMd("en_US").format(d);
        String datePattern = "MM/dd/yyyy";

        var birthDate = DateFormat(datePattern).parse(_selectedDate);
        var outputFormat=  DateFormat("dd/MM/yyyy");
        selectedFromDate= outputFormat.format(birthDate);
        //print("From: $selectedFromDate");
        //print("From birthDate: $birthDate");

      });
  }


  Future<void> _selectDateTo(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2222),
    );
    if (d != null)
      setState(() {
        _selectedDateTo = new DateFormat.yMd("en_US").format(d);
        String datePattern = "MM/dd/yyyy";

        var birthDate = DateFormat(datePattern).parse(_selectedDateTo);
        var outputFormat=  DateFormat("dd/MM/yyyy");
        selectedToDate= outputFormat.format(birthDate);
        //print("From: $selectedToDate");

      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar:CJAppBar("", appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action type");
          Navigator.pop(context);
        })),


        bottomNavigationBar: bottomSheet_KYC_Document(),


        body: WillPopScope(
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              create_headingContainer("Upload Document"), //heading

              create_FromDate_ToDate_Container(),

              Container(
                child: _buildChild_Certificate(),
              ),

              create_NoteContainer(),

              create_Button_Save(), //Emp_Save Button

            ]
            ),
          ),
          onWillPop: () async => false,
          /*onWillPop: ()
          {
            Message.alert_dialogAppExit(context);

          } ,*/
        )

    );
  }


  Container create_FromDate_ToDate_Container() {
    return Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              // decoration:Style_UploadInvestment_Inner,
              padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Column(
                    children: [
                      Container(
                        width: kIsWeb? 120 : MediaQuery.of(context).size.width * 0.4, // width changed on 27-07-2022
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: Text("From Date",style: TextStyle(color: primaryColor,fontSize: 14),),
                        ),
                      ),

                      Container(
                        width: kIsWeb? 120 : MediaQuery
                            .of(context)
                            .size
                            .width * 0.4, // width changed on 27-07-2022
                        height: 40,
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
                                    child:
                                    Text(
                                        selectedFromDate,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black)
                                    ),

                                    onTap: (){
                                      _selectFromDate(context);
                                    },
                                  ),
                                  MaterialButton(
                                      minWidth: 5,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed:() {
                                        _selectFromDate(context);
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

                  Column(
                    children: [

                      Container(
                        width: kIsWeb? 120 : MediaQuery
                            .of(context)
                            .size
                            .width * 0.4, // width changed on 27-07-2022
                        child:Align(
                          alignment: Alignment.centerLeft,
                          child: Text("To Date",style: TextStyle(color: primaryColor,fontSize: 14),),
                        ),
                      ),
                      Container(
                        width: kIsWeb? 120 : MediaQuery
                          .of(context)
                          .size
                          .width * 0.4, // width changed on 27-07-2022
                        height: 40,
                        child: Container(

                            decoration:  const BoxDecoration(
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
                                    child: Text(
                                        selectedToDate,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black)
                                    ),

                                    onTap: (){
                                      _selectDateTo(context);
                                    },
                                  ),
                                  MaterialButton(
                                      minWidth: 5,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed:() {
                                        _selectDateTo(context);
                                      },
                                      child: Text('')
                                  ),


                                ],
                              ),
                            )
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

  Widget bottomSheet_KYC_Document(){
    return Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        /*margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),*/
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20,0,20,2),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: double.maxFinite,
                      // color: bannerColor,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("",style: TextStyle(color: bannerTextColor),),
                      )
                  )
                ])
        )
    );
  }

  Container create_headingContainer(String value)
  {
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

            Text(value,
              style: TextStyle(color: Colors.black,fontSize: 15),),
          ],
        ),
      ),
    );
  }

  Container create_NoteContainer()
  {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25,5,0,0),
        child: Row(
          children: [
            /*SizedBox(
              width: 20.0,
              height: 20.0,
              child: Image.asset(getCJHub_LineIcon,
              ),
            ),
            SizedBox(
                width: 1.0),
*/
            Text(Message.get_UploadDocumentTypeHint,
              style: TextStyle(color: Colors.black54,fontSize: 12),),
          ],
        ),
      ),
    );
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


        if(checkFileExtension == "mp3" || checkFileExtension == "mp4")
        {
          baseimage="";
          print(('only mp3 and mp4'));
          Navigator.pop(context);
          Method.snackBar_OkText(context,"mp3 and mp4 are not allowed");

        }
        else{

          if(profileData!.documentId=="17")
          {
            if(checkFileExtension == "jpg" || checkFileExtension == "jpeg" || checkFileExtension == "png")
              {
                fileType_Name = _fileName ?? '...';
                //print('gallery path: $fileType_Name');
                //print('show the web2  path: $_fileName');


                // Navigator.pop(context);

                convertImageFormat_base64();

              }
            else{

              String newExtension=checkFileExtension+" "+"not allowed";
              baseimage="";
              Method.snackBar_OkText(context,newExtension);

            }
          }
          else{
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
              Method.snackBar_OkText(context,newExtension);
              // Navigator.pop(context);

            }
          }
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


  Widget _buildChild_Certificate()
  {

    if(selectItem_VisibilityStatus==true)
    {
      return Visibility(visible: true,child: Container(
          width: double.maxFinite,
          child: new Stack(
            children: <Widget>[
              Container(
                width: double.maxFinite,
                // decoration: Style_UploadInvestment_Inner,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                child:
                Column(
                  children: [

                    Container(
                      child:Align(
                        alignment: Alignment.centerLeft,
                        child: Text(selectedItem,style: TextStyle(color: primaryColor,fontSize: 14),),
                      ),
                    ),

                    SizedBox(
                      height: 7,
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child:  Container(
                            // width: MediaQuery.of(context).size.width*0.6, // commented on 27-07-2022
                            height: 50,
                            decoration: Style_KYC_details_Add_Edit,
                            child: Text(fileType_Name),
                          ),
                        ),
                        Container(
                          // width: MediaQuery.of(context).size.width*0.31, // commented in 27-07-2022
                          height: 50,
                          decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: new BorderRadius.circular(0.0),
                              border: Border.all(color: Colors.grey,
                                  width: 1.0,
                                  style: BorderStyle.solid)
                          ),
                          child:Material(
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(0.0),
                            color: addInsuranceCardColor,
                            child:MaterialButton(
                                minWidth: 50,
                                // height: 10,
                                onPressed: (){

                                  checkWebAndMobile();

                                  // alert_dialog(context);
                                },

                                child: Text('Choose File',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontFamily: 'Vonique',color: Colors.black,fontSize: 13))
                            ),
                          ),
                        ),
                      ],
                    )

                  ],
                ),

              ),
            ],
          )
      ) ,);


    }
    else
      return Text(
          "",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black)
      );

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
        TextButton(onPressed: ()
        {

          actionType = actionType_Camera;

          _cameraPicker(ImageSource.camera);

          Navigator.pop(context);

          // _cameraPicker(ImageSource.camera);

        },
          child: Text("Camera",
            textAlign: TextAlign.right,style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),

        SizedBox(width: 5.0),

        TextButton(onPressed: ()
        {
          //_galleryPicker();

          _permissionRequest();
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

  void _permissionRequest() async
  {

    var _permissionStatus = await Permission.storage.status;

    if(_permissionStatus.isDenied)
    {
      //print('show checkPermissionStatus count $checkPermissionStatus');

      if(checkPermissionStatus==2)
      {
        return  showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Allow CJ Hub to access photos"),
                content:
                const Text('Please make sure you enable the Storage'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () async {

                      await openAppSettings();

                      Navigator.of(context, rootNavigator: true).pop();

                    },
                  ),
                ],
              );
            });
      }
      else
      {
        actionType= actionType_Gallery;
        _pickFiles();

        Navigator.pop(context);
        // _galleryPicker();
      }
      checkPermissionStatus++;

      //print('show checkPermissionStatus count1 $checkPermissionStatus');
    }
    else
    {
      //print('show gallery');

      actionType= actionType_Gallery;
      _pickFiles();

      Navigator.pop(context);
      // _galleryPicker();
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
          fileType_Name = getCJHub_UploadDocumentIcon;
          //print('camera path: $fileType_Name');

        }
        else{


        }

        convertImageFormat_base64();

      });

    }
  }

 /* void _galleryPicker() async
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

          if(profileData.documentId=="17")
          {
            _path = await FilePicker.getFilePath(
                type: _pickingType,
                allowedExtensions: ['jpg','jpeg','png']);
          }
          else
          {
            _path = await FilePicker.getFilePath(
                type: _pickingType,
                allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png']);
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

        *//*------------21-2-2022 start-----------------*//*
        if(_path.length>0)
        {
          _fileName = _path.split('/').last;

          var checkFileExtension=_fileName.split(".").last;
          checkFileExtension=checkFileExtension.toLowerCase();

          if(checkFileExtension == "mp3" || checkFileExtension == "mp4")
          {
            baseimage="";
            //print(('only mp3 and mp4'));
            Navigator.pop(context);
            show_OKAlert("mp3 and mp4 are not allowed");

          }
          else
          {

            if(profileData.documentId=="17")
            {
              if(checkFileExtension == "jpg" || checkFileExtension == "jpeg" || checkFileExtension == "png")
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
  }

  _cameraPicker(ImageSource source) async
  {
    File picked = await ImagePicker.pickImage(source: source,imageQuality: 1);
    if (picked != null) {
      _cropImage(picked);
    }
    Navigator.pop(context);
  }

  _cropImage(File picked) async
  {
    File cropped = await ImageCropper().cropImage(
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
      //maxWidth: 800,
    );
    if (cropped != null) {
      setState(() {
        _pickedImage = cropped;
        actionType = actionType_Camera;
        // Camera_fileName = _pickedImage.toString();
        fileType_Name = 'uploaddocument.png';
        //print('camera path: $fileType_Name');

        convertImageFormat_base64();

      });
    }
  }*/
  convertImageFormat_base64()
  {
    /*---------use for camera and gallery(use for image or pdf)--20/11/2021 start-----------*/
    List<int>? imageBytes;

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


    baseimage = base64Encode(imageBytes!);
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

  Container create_Button_Save() {
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
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30,top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
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
                            validateToTheFields();
                          },
                          child: Text('Save',
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
      height: 2,
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
    });
  }

  /*-------------16-2-2022 start-----------*/
  validateToTheFields()
  {
    if(baseimage=="" || baseimage==null || fileType_Name=="")
    {
      show_OKAlert("Please choose the document");
    }
    else
    {
      validateToTheFromDate_andToDate();
    }
  }
  /*-------------16-2-2022 end-----------*/

  /*-----------------9-3-2022 start(use for the date validation)----------------*/
  validateToTheFromDate_andToDate()
  {

    if(selectedFromDate != "Select Date")
    {
      if(selectedToDate != "Select Date")
      {
        String getSelectedToDate=Method.changeTheDateFormat_ForInvestmentDeclaration(selectedToDate);
        String getSelectedFromDate=Method.changeTheDateFormat_ForInvestmentDeclaration(selectedFromDate);
        String currentDate=Method.getTheCurrentDate_ForInvestmentDeclaration();

        if (int.parse(getSelectedToDate) > (int.parse(getSelectedFromDate)))
        {
          if (int.parse(getSelectedToDate) > (int.parse(currentDate)))
          {
            saveDocumentTypeData();
          }
          else
          {
            show_OKAlert("Select The Valid To Date");

          }

        }
        else
        {
          show_OKAlert("Select The Valid To Date");

        }
      }
      else
      {
        show_OKAlert("Please Select The To Date");
      }
    }
    else
    {
      show_OKAlert("Please Select The From Date");
    }
  }
  /*-----------------9-3-2022 end(use for the date validation)----------------*/

  saveDocumentTypeData() async
  {

    String jsid=getEncrypted_EmpCode(complete_JSId);
    String document_id=profileData!.documentId;
    String docSectionId=profileData!.sectionId;
    if(docSectionId==""||docSectionId==null)
    {
      docSectionId="";
    }
    String doc_desc=profileData!.documentDescription;
    if(doc_desc==""||doc_desc==null)
    {
      doc_desc="";
    }


    fileType_Name=fileType_Name.split(".").last;
    //print('show file name extension $fileType_Name');



    //print('show js id $jsid');
    //print('show document_id $document_id');
    //print('show base image $baseimage');
    //print('show docSectionId $docSectionId');
    //print('show emp id $empId');
    //print('show emp ip address $empIPAddress');
    //print('show document description $doc_desc');


    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.save_DocumentData),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'js_id': getEncrypted_EmpCode(complete_JSId),
          'document_id': document_id,
          'document_path': baseimage,
          'document_extension':fileType_Name,
          'desc': doc_desc,
          'section_id': docSectionId,
          'created_by': empId,
          'created_ip': empIPAddress,
          'valid_from':selectedFromDate,
          'valid_to':selectedToDate

        },
      );


      //print(response.statusCode);
      if (response.statusCode == 200)
      {

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body)
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);
        ProfileDocumentSave_ModelResponse profileDocumentSave_ModelResponse= ProfileDocumentSave_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(profileDocumentSave_ModelResponse.statusCode==true)
        {
          setState(()
          {
            fileType_Name="";
          });
          show_SuccessAlert(profileDocumentSave_ModelResponse.message!);
        }
        else
        {
          if (profileDocumentSave_ModelResponse.message==null || profileDocumentSave_ModelResponse.message=="")
          {
            show_OKAlert("server error!");

          }else {
            show_OKAlert(profileDocumentSave_ModelResponse.message!);
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

  show_SuccessAlert(String message)
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

          /*----------19-11-2022(use ) start-------------*/

          //Navigator.pushReplacementNamed(context, "Profile_NewDocument");

         /* Navigator.push(context, MaterialPageRoute(builder: (_)=>

          Responsive(
              mobile: bottom(),
              tablet: Center(
                child: Container(
                  width: flutterWeb_tabletWidth,
                  child: bottom(),
                ),
              ),
              desktop: Center(
                child: Container(
                  width: flutterWeb_desktopWidth,
                  child: bottom(),
                ),
              )
          )
              // bottom()

          ));

          Navigator.push(context, MaterialPageRoute(builder: (_)=>

          Responsive(
            mobile: Profile_NewDocument(),
            tablet: Center(
              child: Container(
                width: flutterWeb_tabletWidth,
                child: Profile_NewDocument(),
              ),
            ),
            desktop: Center(
              child: Container(
                width: flutterWeb_desktopWidth,
                child: Profile_NewDocument(),
              ),
            ),
          )
              // Profile_NewDocument()

          ));*/
          /*----------19-11-2022(use ) end-------------*/


        },

          child: Text("OK",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
      ],

    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }


}