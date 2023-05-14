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
import '../../../../../../CustomView/CJHubCustomView/AutoLogout.dart';
import '../../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../../CustomView/CJHubCustomView/ValidateClass.dart';
import '../../../../../../CustomView/CJHubCustomView/palatte_Textstyle.dart';
import '../../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../../Services/Messages/Message.dart';
import '../../UploadInvestmentProof_ModelClasses/HRA_Save_ModelResponse.dart';

import 'UploadInvestmentProof_HousingLoan_View.dart';

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
      home: UploadInvestmentProof_HousingLoan_Add(title: 'CJ Hub'),
    );
  }
}
class UploadInvestmentProof_HousingLoan_Add extends StatefulWidget {

  UploadInvestmentProof_HousingLoan_Add({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _UploadInvestmentProof_HousingLoan_Add createState() => _UploadInvestmentProof_HousingLoan_Add();
}

class _UploadInvestmentProof_HousingLoan_Add extends State<UploadInvestmentProof_HousingLoan_Add> {
  // This widget is the root of your application.

  List listItem_LoanType =["Personal","Other"];
  String? valueChoose_LoanType="Personal";

  List listItem_LoanHolderType =["Personal","Other"];
  String valueChoose_LoanHolderType="Personal";

  String? _fileName;
  // String _path;
  // Map<String, String> _paths;
  String? _extension;
  bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType = FileType.custom;
  File? _pickedImage;
  // String Camera_fileName;
  String actionType_Gallery = 'gallery';
  String actionType_Camera = 'camera';
  String actionType = '';
  String fileType_Name = 'No file choosen';


  String empCode="",empName="",panNumber="";
  String completeEmpCode="",headId="";
  String financialYear="2021-22";
  String empId="",empIPAddress="";


  String  lender_pan_number1="",lender_pan_number2="",lender_pan_number3="",lender_pan_number4="",
      principal_amount="",interest_amount="",name_of_owner="",lender_name="",
      loan_no="",loan_type="",loan_holder_type="",loan_holder_name="";

  String loan_sanction_date = 'Select date';


  var txtController_loan_no = TextEditingController();
  var txtController_loanAmount = TextEditingController();
  var txtController_propertyValue = TextEditingController();
  var txtController_principal_amount = TextEditingController();
  var txtController_interest_amount = TextEditingController();
  var txtController_name_of_owner = TextEditingController();
  var txtController_loan_holder_name = TextEditingController();
  var txtController_lender_name = TextEditingController();
  var txtController_lender_pan_number1 = TextEditingController();
  var txtController_lender_pan_number2 = TextEditingController();
  var txtController_lender_pan_number3 = TextEditingController();
  var txtController_lender_pan_number4 = TextEditingController();


  /*--------------04-08-2022 start------------*/

  Uint8List? fileBytes;
  String? fileName;
  File _file = File("zz");
  CroppedFile? _croppedFile;

  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  List<PlatformFile>? _paths;
  String? _directoryPath;
  FilePickerResult? _path;
  String actionType_web = 'upload';

  /*--------------04-08-2022 end------------*/



  bool firstTimeBuyer = false;
  bool Before01Apr1999 = false;
  String loanAmount="",propertyValue="",is_before_01_apr_1999="",is_first_time_buyer="";
  String baseimage="";

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
    if(lender_pan_number1.length<=10 )
    {
      validate_PAN(lender_pan_number1);

    }
    else {

      validate_PAN(lender_pan_number1);

    }


  }

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(Method.getStartYearFor_HomeLoan()),
      lastDate: DateTime(Method.getEndYearFor_HomeLoan()),
    );
    if (d != null)
      setState(() {

        String selectedDate = new DateFormat.yMd("en_US").format(d);
        loan_sanction_date=Method.changeTheDateFormat_ForUploadInvestmentDeclaration(selectedDate);

      });
  }

  alert_dialog(BuildContext context) {
    var alertDialog = AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //position
        mainAxisSize: MainAxisSize.min,
        // wrap content in flutter
        children: <Widget>[
          Text("Select Document Mode",
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
  }

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
      //maxWidth: 800,
    );
    if (cropped != null) {
      setState(() {
        _pickedImage = cropped;
        actionType = actionType_Camera;
        // Camera_fileName = _pickedImage.toString();
        fileType_Name = 'housingloan.png';
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

      //print('bytes for web: $imageBytes');

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
      Method.snackBar_OkText(context, checkFileExtension);
      // show_OKAlert(checkFileExtension);

    }
    /*-----------------25-2-2022 end------------------*/

    /*---------use for camera and gallery(use for image or pdf)--20/11/2021 end-----------*/

  }

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
      body:  SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 1),

        child:
        Column(
          children: <Widget>[

            create_Gap(),
            create_Gap(),

            /*----------1-12-2021 start changes----------*/
            Container(
              // color: Colors.red,
              child: checkBox_Container_is_firstmeBuyer_is_Before1apr1999(),
            ),

            /*----------1-12-2021 start changes----------*/

            Container(
              // color: Colors.red,
              child: create_HousingLoan_LoanNoDate(),
            ),

            /*----------1-12-2021 start changes----------*/
            Container(child: create_HousingLoan_LoanAmount_PropertyValue(),
            ),
            /*----------1-12-2021 start changes----------*/

            Container(
              // color: Colors.red,
              child: create_HousingLoan_PrincipalAmount_InterestAmount(),
            ),
            Container(
              // color: Colors.red,
              child: create_HousingLoan_Name_LoanType(),
            ),
            Container(
              // color: Colors.red,
              child: create_HousingLoan_LoanHolderName_Type(),
            ),
            Container(
              // color: Colors.red,
              child: create_HousingLoan_LenderPan_Name(),
            ),
            /*--------------4-12-2021 start-----------------*/

            Container(
              // color: Colors.red,
              child: create_HousingLoan_LenderPan2_Pan3(),
            ),

            Container(
              // color: Colors.red,
              child: create_HousingLoan_LenderPan4(),
            ),
            /*--------------4-12-2021 end-----------------*/

            Container(
              // color: Colors.red,
              child: create_HRA_ChooseFile(),
            ),

            Container(
              // color: Colors.red,
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

  Container checkBox_Container_is_firstmeBuyer_is_Before1apr1999()
  {
    return Container(
        width: double.maxFinite,

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
                    child: Row(
                      children: [
                        Expanded(
                          flex:1,
                            child: Container(
                          width: 120,
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Acquisition of the house Before 01/04/1999",style: TextStyle(color: primaryColor,fontSize: 10),),
                          ),
                        ))
                        ,

                        Container(
                          width: 20,
                          height: 30,
                          child:  Checkbox(
                            value: Before01Apr1999,
                            onChanged: (bool? value)
                            {
                              setState(() {
                                Before01Apr1999 = value!;
                              });
                            },
                          ),
                        ),


                      ],
                    ),
                  ),

                  SizedBox(
                    width: 5,
                  ),

                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [

                        Expanded(
                          flex:1,
                            child: Container(
                          width: 120,
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: Text("First Time Buyer",style: TextStyle(color: primaryColor,fontSize: 10),),
                          ),
                        )),

                        Container(
                          width: 20,
                          height: 30,
                          child:  Checkbox(
                            value: firstTimeBuyer,
                            onChanged: (bool? value) {

                              //print('show the house before $value');
                              setState(() {
                                firstTimeBuyer = value!;
                              });
                            },
                          ),
                        ),


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
  Container create_HousingLoan_LoanNoDate() {
    return Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              decoration: Style_UploadInvestment_Inner,

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
                          child: Text("Loan No",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: TextField(
                          controller:txtController_loan_no,
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                            LengthLimitingTextInputFormatter(10),
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
                            loan_no=value;
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
                          child: Text("Loan Sanction Date",style: TextStyle(color: primaryColor,fontSize: 12),),
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
                                        loan_sanction_date,
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




                ],
              ),

            ),
          ],
        )
    );
  }

  Container create_HousingLoan_LoanAmount_PropertyValue() {
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
                          child: Text("loan Amount",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: TextField(
                          controller: txtController_loanAmount,
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
                            loanAmount=value;
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
                          child: Text("Property Value",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: TextField(controller: txtController_propertyValue,
                          keyboardType: TextInputType.number,
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
                            propertyValue=value;
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
  Container create_HousingLoan_PrincipalAmount_InterestAmount() {
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
                            child: Text("Principal Amount",style: TextStyle(color: primaryColor,fontSize: 12),),
                          ),
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          height: 30,
                          child: TextField(controller: txtController_principal_amount,
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
                              principal_amount=value;
                            },


                          ),
                        ),

                      ],
                    ),
                  ),

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
                          child: Text("Interest Amount",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: TextField(controller: txtController_interest_amount,
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
                            interest_amount=value;
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
  Container create_HousingLoan_Name_LoanType() {
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
                          child: Text("Name of Owner",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: TextField(controller: txtController_name_of_owner,
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
                            hintText: "",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            name_of_owner=value;
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
                          child: Text("Loan Type",style: TextStyle(color: primaryColor,fontSize: 12),),
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
                          // hint: Text('Select'),
                          icon: Icon(Icons.arrow_drop_down),
                          dropdownColor: Colors.white,
                          underline: DropdownButtonHideUnderline(child: Container()),
                          iconSize: 25,
                          isExpanded: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Method.fontSize_DropDownItem(),
                          ),
                          value: valueChoose_LoanType,
                          onChanged: (newValue){
                            setState(() {
                              valueChoose_LoanType!=newValue;

                            });
                          },
                          items: listItem_LoanType.map((valueItem)
                          {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
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
  Container create_HousingLoan_LoanHolderName_Type() {
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
                          child: Text("Loan Holder Name",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: TextField(controller: txtController_loan_holder_name,
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
                            hintText: "",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            loan_holder_name=value;
                          },
                        ),
                      ),

                    ],
                  )),

                  SizedBox(width: 5,),

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
                          child: Text("Loan Holder Type",style: TextStyle(color: primaryColor,fontSize: 12),),
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
                          // hint: Text('Select'),
                          icon: Icon(Icons.arrow_drop_down),
                          dropdownColor: Colors.white,
                          underline: DropdownButtonHideUnderline(child: Container()),
                          iconSize: 25,
                          isExpanded: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Method.fontSize_DropDownItem(),
                          ),
                          value: valueChoose_LoanHolderType,
                          onChanged: (newValue)
                          {
                            setState(()
                            {
                              valueChoose_LoanHolderType!=newValue;
                            });

                          },
                          items: listItem_LoanHolderType.map((valueItem)
                          {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
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
  /*--------------4-12-2021 start-----------------*/

  Container create_HousingLoan_LenderPan_Name() {
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
                            child: Text("Lender_Name",style: TextStyle(color: primaryColor,fontSize: 12),),
                          ),
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.4,
                          height: 30,
                          child: TextField(controller: txtController_lender_name,
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
                              hintText: "",
                              border:
                              OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2.0)),
                            ),
                            onChanged: (value)
                            {
                              lender_name=value;
                            },

                          ),
                        ),

                      ],
                    ),
                  ),

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
                          child: Text("Lender PAN 1",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: TextFormField(
                          controller: txtController_lender_pan_number1,
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
                            hintText: "",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            lender_pan_number1=value;
                          },
                        ),
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
  Container create_HousingLoan_LenderPan2_Pan3() {
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
                          child: Text("Lender PAN 2",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: TextFormField(
                          controller: txtController_lender_pan_number2,
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
                            hintText: "",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            lender_pan_number2=value;
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
                          child: Text("Lender PAN 3",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: TextFormField(
                          controller: txtController_lender_pan_number3,
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
                            hintText: "",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            lender_pan_number3=value;
                          },
                        ),
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
  Container create_HousingLoan_LenderPan4() {
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
                          child: Text("Lender PAN 4",style: TextStyle(color: primaryColor,fontSize: 12),),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        height: 30,
                        child: TextFormField(
                          controller: txtController_lender_pan_number4,
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
                            hintText: "",
                            border:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                          ),
                          onChanged: (value)
                          {
                            lender_pan_number4=value;
                          },
                        ),
                      ),

                    ],
                  )),

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

/*-----------------4-12-2021 end-------------------------*/

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

  Container create_HRA_ChooseFile() {
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

/*
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
              padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.3,
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UploadInvestmentProof_HousingLoan_View()),);
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
*/

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
                          onPressed: ()
                          {
                            checkTheFieldValidation();
                          },
                          child: Text('Save',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 13))
                      ),
                    ),
                  ),

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
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>

                            Responsive(
                                mobile: UploadInvestmentProof_HousingLoan_View(userArriveFrom_AddToView_or_DirectView: "AddToHomeLoanView",),
                                tablet: Center(
                                  child: Container(
                                    width: flutterWeb_tabletWidth,
                                    child: UploadInvestmentProof_HousingLoan_View(userArriveFrom_AddToView_or_DirectView: "AddToHomeLoanView",),
                                  ),
                                ),
                                desktop: Center(
                                  child: Container(
                                    width: flutterWeb_desktopWidth,
                                    child: UploadInvestmentProof_HousingLoan_View(userArriveFrom_AddToView_or_DirectView: "AddToHomeLoanView",),
                                  ),
                                ), )
                                // UploadInvestmentProof_HousingLoan_View(userArriveFrom_AddToView_or_DirectView: "AddToHomeLoanView",)

                            ),);

                          },
                          child: Text('Finish',
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

  checkTheFieldValidation()
  {
    if(loan_no != "")
    {
      if(loan_sanction_date != "Select date")
      {
        if(loanAmount != "")
        {
          if(propertyValue != "")
          {
            if(principal_amount != "")
            {
              if (interest_amount != "")
              {
                if (name_of_owner != "")
                {
                  if (loan_holder_name != "")
                  {
                    if (lender_name != "")
                    {
                      if (lender_pan_number1 != "")
                      {
                        if (baseimage != "")
                        {
                          validateToThePANNumber();
                          if(panCardStatus == true){
                            print("status of PANCard $panCardStatus");
                            save_HousingLoan_Details();
                          }
                          else{
                            Method.snackBar_OkText(context, "Please enter valid PAN number");
                          }

                        }
                        else
                        {
                          show_OKAlert("Upload the document");
                        }
                      }
                      else
                      {
                        show_OKAlert("Enter pan number");
                      }
                    }
                    else
                    {
                      show_OKAlert("Enter lender name");
                    }
                  }
                  else
                  {
                    show_OKAlert("Enter loan holder name");
                  }
                }
                else
                {
                  show_OKAlert("Enter name of owner");
                }
              }
              else {
                show_OKAlert("Enter interest amount");
              }
            }
            else
            {
              show_OKAlert("Enter principal amount");
            }
          }
          else
          {
            show_OKAlert("Enter property value");
          }
        }
        else
        {
          show_OKAlert("Enter loan amount");
        }
      }
      else
      {
        show_OKAlert("Select the date");
      }
    }
    else
    {
      show_OKAlert("Enter the loan number");
    }
  }


  save_HousingLoan_Details() async
  {

    if(Before01Apr1999==true)
    {
      is_before_01_apr_1999="Y";
    }
    else
    {
      is_before_01_apr_1999="N";
    }

    if(firstTimeBuyer==true)
    {
      is_first_time_buyer="Y";
    }
    else
    {
      is_first_time_buyer="N";
    }
/*------------------1-12-2021 END-------------------*/
    /*---------use for camera and gallery(use for image or pdf)--20/11/2021 end-----------*/


    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.save_UploadInvestmentProof_HomeLoanDetails),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },

        body: {
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'financial_year': financialYear,
          'lender_pan_number1': lender_pan_number1,
          'lender_pan_number2': lender_pan_number2,
          'lender_pan_number3': lender_pan_number3,
          'lender_pan_number4':lender_pan_number4,
          'loan_sanction_date': loan_sanction_date,
          'principal_amount': principal_amount,
          'interest_amount': interest_amount,
          'name_of_owner': name_of_owner,
          'lender_name': lender_name,
          'loan_no': loan_no,
          'loan_type': valueChoose_LoanType,
          'loan_holder_type': valueChoose_LoanHolderType,
          'loan_holder_name': loan_holder_name,
          'document_path': baseimage,
          'document_name': fileType_Name,
          'original_document_name': fileType_Name,
          'created_by': empId,
          'created_ip': empIPAddress,
          'is_before_01_apr_1999': is_before_01_apr_1999,
          'is_first_time_buyer': is_first_time_buyer,
          'property_value': propertyValue,
          'loan_amount': loanAmount

        },

      );



      //print(response.statusCode);
      //print(response.body);

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

            txtController_loan_no.text="";
            loan_sanction_date="Select date";
            txtController_loanAmount.text="";
            txtController_propertyValue.text="";
            txtController_principal_amount.text="";
            txtController_interest_amount.text="";
            txtController_name_of_owner.text="";
            txtController_loan_holder_name.text="";
            txtController_lender_name.text="";
            txtController_lender_pan_number1.text="";
            txtController_lender_pan_number2.text="";
            txtController_lender_pan_number3.text="";
            txtController_lender_pan_number4.text="";

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
          fileType_Name = getCJHub_HousingLoanIcon;
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

/*--------------04-08-2022 end------------*/


}