import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:contractjobs/Controller/Talents/Controller/CJHubTECModule/CJHubTECView/profile_personalDetails_edit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:getwidget/getwidget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart'as http;
import 'package:url_launcher/url_launcher_string.dart';


import 'package:flutter/foundation.dart';

import '../../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../ModelClasses/CJHubModelClasses/UpdateProfileImage_ModelResponse.dart';
import '../../../ModelClasses/CJHubModelClasses/VersionCode_ModelData.dart';
import '../../CJHubPDF/pdf_id_ui.dart';
import '../TECPANAadhaarVerifyView/AadhaarCardView.dart';
import '../TECPANAadhaarVerifyView/PanCardView.dart';
import 'KYC_details_Add_Edit.dart';
import 'Profile_NewDocument.dart';
import 'Profile_UI.dart';
import 'cropper/ui_helper.dart'
if (dart.library.io) 'cropper/mobile_ui_helper.dart'
if (dart.library.html) 'cropper/web_ui_helper.dart';


void main()
{
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
      home: profile(title: 'CJ Hub'),
    );
  }
}

class profile extends StatefulWidget
{

  profile({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _profile createState() => _profile();


}


class _profile extends State<profile>
{


  //PickedFile _imageFile;
  //final ImagePicker _picker = ImagePicker();
  // File _pickedImage;

  File _file = File("zz");
  Uint8List webImage = Uint8List(10);

  CroppedFile? _croppedFile;

  String baseimage="";


  String genderType_icon=getCJHub_MaleIcon;

  String empName="xxx",
      empEmailId="xxx",
      empCode="xxx",
      empId="xxx",
      empDateOfBirth="xxx",
      empGender="xxx",
      empMobileNumber="xxx",
      empAddress="xxx",
      empFatherHusbandName="xxx";

  String getPackageName='';

  bool empProfileDefault_Visibility=false;
  bool empProfileDynamic_Visibility=false;

  String profileImagePath="",checkGenderType="";


  /*------23-12-2022 start------------*/

  bool KYCDetails_ADD=true, KYCDetails_EDIT=false, Document_ADD =true, Document_EDIT=false;
  String KYC_empType = 'second';
  String Document_empType = 'First';

  /*------23-12-2022 END------------*/

  String ecStatus="",jsId_key="";
  bool checkKYCDocuments_VisibilityStatus=false;
  bool checkKYCDocuments_BannerRedAlertTop_VisibilityStatus=false;


  /*--------15-1-2022 START----------*/
  String compare_ECStatus="EC";
  String compare_TECStatus="TEC";

  /*--------15-1-2022 END----------*/
  bool empProfileImageIcon_Visibility=false;

  String getEmp_JobStatus="";
  String welcomeEmployeeName="";

  String kyc_STATUSCode="",panCard_STATUSCode="",aadhaarCard_STATUSCode="";

  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;

  /*--------11-10-2022 START----------*/
  String empJobType="",empCodeTitle="",cjCode="";
  /*--------11-10-2022 END----------*/

  @override
  // ignore: must_call_super
  void initState()
  {
    super.initState();

    loadEmpInfo();

    /*---(version code upgrade functionality use for the Android, not a iOS)---*/

   /* WidgetsBinding.instance.addPostFrameCallback((_) {
      NetworkReachability connectionStatus = NetworkReachability.getInstance();

      _connectionChangeStream =
          connectionStatus.connectionChange.listen(checkNetworkConnection);
    });*/


    if(kIsWeb)
      {

      }else
        {
          /*-----use for only the android  ------*/
          //getAppVersionCode_FromServer();
        }

    // checkNetworkConnection();
    /*---(version code upgrade functionality use for the Android, not a iOS)---*/


    setState(() {
      checkKYCEmp();
      checkDocumentEmp();
    });
  }


  SplitEmployeeName(String empname)
  {
    var empNameStr=empname.split(" ");
    if(empNameStr.length>1)
    {
      welcomeEmployeeName=empNameStr[0];
    }
    else
    {
      welcomeEmployeeName=empNameStr[0];
    }
  }


  void loadEmpInfo()
  {

    SharedPreference.getJSId().then((value) =>  {
      jsId_key=value,
      //print('show emp jsId $value'),
    });

    SharedPreference.getEmpName().then((value) =>  {
      empName=value,
      //print('show emp name2 $value'),
      SplitEmployeeName(empName)
    });

    SharedPreference.getEmpEmailId().then((value) =>  {
      empEmailId=value,
      //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpCode().then((value) =>  {
      empCode=value,
      //print('show emp name2 $value'),
      //loadData()
    });

    /*-----------11-10-2022 start----------*/
    SharedPreference.get_CJCode().then((value) =>  {
      print('show emp cjCode $value'),
      cjCode=value,
    });
    SharedPreference.getEmpJobType().then((value) =>  {
      //print('show emp name2 $value'),
      empJobType=value,
      // ignore: unrelated_type_equality_checks

    });
    /*-----------11-10-2022 end----------*/
    SharedPreference.getEmpDateOfBirth().then((value) =>  {
      empDateOfBirth=value,
      //print('show emp name2 $value'),
      //loadData()
    });
    SharedPreference.getEmpGender().then((value) =>  {
      empGender=value,
      //print('show emp name2 $value'),
      //loadData()
    });
    SharedPreference.getEmpMobileNo().then((value) =>  {
      empMobileNumber=value,
      //print('show emp name2 $value'),
      //loadData()
    });
    SharedPreference.getEmpAddress().then((value) =>  {
      empAddress=value,
      //print('show emp name2 $value'),
      //loadData()
    });
    SharedPreference.getEmpFatherName().then((value) =>  {
      empFatherHusbandName=value,
      //print('show emp name2 $value'),
      loadData()
    });

    SharedPreference.getEmpGender().then((value) =>  {
      //print('show emp name2 $value'),

      checkGenderType=value.trim()
      // ignore: unrelated_type_equality_checks

    });

    SharedPreference.getEmp_ProfileImage().then((value) =>  {
      //print('show emp name2 $value'),

      profileImagePath=value,

      checkProfileImage(profileImagePath)

    });


    /*-----------4-1-2022 start----------*/
    SharedPreference.getEC_STATUS().then((value) =>  {
      //print('show emp ecstatus $value'),
      ecStatus=value,
      checkECStatus(ecStatus)
    });
    /*-----------4-1-2022 end----------*/

    //24-3-20222 START

    SharedPreference.getKYC_STATUSCode().then((value) =>  {
      //print('show emp KYC_STATUSCode $value'),
      kyc_STATUSCode=value

    });
    SharedPreference.getPANCard_STATUS().then((value) =>  {
      //print('show emp getPANCard_STATUS $value'),
      panCard_STATUSCode=value


    });
    SharedPreference.getAadhaarCard_STATUS().then((value) =>  {
      //print('show emp getAadhaarCard_STATUS $value'),
      aadhaarCard_STATUSCode=value


    });

    //24-3-20222 END


    SharedPreference.get_AppLogActivationSaveInCRMStatus().then((value) =>  {
      //print('show emp name2 $value'),

      if(value=="1")
        {

        }
      else
        {
          if(ecStatus == compare_TECStatus)
            {
              save_AppActivationLogToCRM()
            }
        }
    });



  }

  /*---------15-2-2022 start-------------*/
  loadEmpJobStatus()
  {
    /*----28-1-2022 start---use for emp job status----*/
    SharedPreference.getEmpJobStatus().then((value) =>  {
      //print('show getEmpJobStatus $value'),
      getEmp_JobStatus=value,

      if(getEmp_JobStatus=="Active")
        {
          if(ecStatus==compare_ECStatus)
            {
              Navigator.push(context, MaterialPageRoute(builder: (_) =>

                  Responsive(
                    mobile: pdf_id_ui(),
                    tablet: Center(
                      child: Container(
                        width: flutterWeb_tabletWidth,
                        child: pdf_id_ui(),
                      ),
                    ),
                    desktop: Center(
                      child: Container(
                        width: flutterWeb_desktopWidth,
                        child: pdf_id_ui(),
                      ),
                    ),
                  )
                  // pdf_id_ui()

              ),)
            }
          else
            {

              Method.snackBar_OkText(context, "ID card Not Generated , Please contact the Care team for more details.\ncare@contract-jobs.com")
              // show_OKAlert("ID card Not Generated , Please contact the Care team for more details.\ncare@contract-jobs.com")
            }
        }
      else
        {

          Method.snackBar_OkText(context, "ID card Not Generated , Please contact the Care team for more details.\ncare@contract-jobs.com")

          // show_OKAlert("ID card Not Generated , Please contact the Care team for more details.\ncare@contract-jobs.com")
        }

    });
    /*----28-1-2022 end---use for emp job status----*/
  }

  /*---------15-2-2022 end-------------*/


  /*-----------4-1-2022 start----------*/

  checkECStatus(String ecStatus)
  {
    if(ecStatus==compare_ECStatus)
    {
      //use for without KYC & Documents(EC)
      setState(() {
        checkKYCDocuments_VisibilityStatus=false;
        checkKYCDocuments_BannerRedAlertTop_VisibilityStatus=false;
        empProfileImageIcon_Visibility=true;
      });
    }
    else if(ecStatus==compare_TECStatus)
    {
      //USE FOR WITH KYC & Documents(TEC)
      setState(()
      {
        checkKYCDocuments_VisibilityStatus=true;
        checkKYCDocuments_BannerRedAlertTop_VisibilityStatus=true;
        empProfileImageIcon_Visibility=false;
      });

    }
    else
    {

    }
  }
  /*-----------4-1-2022 end----------*/


  /*------------13-11-2021 start----------*/

  checkProfileImage(String imagePath)
  {
    if(profileImagePath=="")
    {
      if(checkGenderType == "Male")
      {
        // Male
        genderType_icon=getCJHub_MaleIcon;
        loadGenderIcon();
      }
      else
      {
        //FeMale
        genderType_icon=getCJHub_FemaleIcon;
        loadGenderIcon();
      }

      setState(() {

        empProfileDefault_Visibility=true;
        empProfileDynamic_Visibility=false;

      });

    }
    else
    {
      setState(() {
        profileImagePath=imagePath;
        empProfileDefault_Visibility=false;
        empProfileDynamic_Visibility=true;
      });

    }
  }

  /*------------13-11-2021 end----------*/

  loadGenderIcon()
  {
    setState(() {
      genderType_icon=genderType_icon;
    });
  }


  void loadData()
  {
    setState(() {

      empName=empName;
      empEmailId=empEmailId;

      if(empCode=="-9999")
      {
        empCode="Not Generated";
      }
      else
      {
        /*---------11-10-2022 start---------*/
        if(empJobType == "Regular")
        {
          //Regular
          empCode=empCode;
          empCodeTitle="Emp Code";
        }
        else
        {
          //Contractual
          empCode=cjCode;
          empCodeTitle="CJ Code";
        }
        /*---------11-10-2022 end---------*/

      }

      empDateOfBirth=empDateOfBirth;
      empGender=empGender;
      empMobileNumber=empMobileNumber;
      empAddress=empAddress;
      empFatherHusbandName=empFatherHusbandName;

    });
  }

  Widget cameraGallery_BottomSheet(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      /*margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),*/
      child: Column(children: <Widget>[
        TextButton(onPressed: ()=>  _loadPicker(ImageSource.gallery),
            /*{
         takePhoto(ImageSource.gallery);
          },*/
            child: Row(
              children: <Widget>[
                new Image.asset(
                  getCJHub_GalleryIcon,
                  height: 20.0,
                  width: 20.0,
                ),
                // Icon(Icons.camera_alt,color: Color(0xff00BFFF),size: 18,),
                SizedBox(
                  width: 10,
                ),
                Text('Select Profile Picture',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'Vonique',color: Colors.black,fontSize: 16)),
              ],
            )),
        TextButton(onPressed: ()=>  _loadPicker(ImageSource.camera),
            /*{
         takePhoto(ImageSource.camera);
       },*/
            child: Row(
              children: <Widget>[
                new Image.asset(
                  getCJHub_CameraIcon,
                  height: 20.0,
                  width: 20.0,
                ),
                // Icon(Icons.image_outlined,color: Color(0xff00BFFF),size: 18,),
                SizedBox(
                  width: 10,
                ),
                Text('Take New Profile Picture',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'Vonique',color: Colors.black,fontSize: 16)),
              ],
            ))
      ]
      ),
    );
  }


  _loadPicker(ImageSource source) async
  {
   /* File picked = await ImagePicker.pickImage(source: source,imageQuality: Method.getImageQuality());
    if (picked != null)
    {
      //print('show profile gallery picked $picked');

      _cropImage(picked);
    }*/

    // MOBILE
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: source,imageQuality: Method.getImageQuality());

      if (image != null) {


        var fileName = (image.name);

        //print('show profile mobile gallery picked $fileName');

        fileName = (image.name).split('/').last;

        var checkFileExtension=fileName.split(".").last;
        checkFileExtension=checkFileExtension.toLowerCase();


        if(checkFileExtension == "jpg" || checkFileExtension == "jpeg" || checkFileExtension == "png")
        {
          //print("correct Extension");

          _cropImage(File(image.path));
        }

        else{

          //print("not correct Extension");

          String newExtension=checkFileExtension+" "+"not allowed";
          Method.snackBar_OkText(context, newExtension);
          // show_OKAlert(newExtension);
        }

      } else {
        showToast("No file selected");
      }
    }

    // WEB
    else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: source,imageQuality: Method.getImageQuality());
      if (image != null) {

        var fileName = (image.name);

        //print('show profile web gallery picked $fileName');

        fileName = (image.name).split('/').last;

        var checkFileExtension=fileName.split(".").last;
        checkFileExtension=checkFileExtension.toLowerCase();


        if(checkFileExtension == "jpg" || checkFileExtension == "jpeg" || checkFileExtension == "png")
          {
            //print("correct Extension");

            _cropImage(File(image.path));
          }

        else{

          //print("not correct Extension");

          String newExtension=checkFileExtension+" "+"not allowed";
          Method.snackBar_OkText(context, newExtension);
          // show_OKAlert(newExtension);
        }



      }
      else {
        showToast("No file selected");
      }
    }
    else {
      showToast("Permission not granted");
    }
    // Navigator.pop(context);
  }

  _cropImage(File image) async
  {
  /*  File cropped = await ImageCropper().cropImage(
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
      maxWidth: 2000,
    );
    if (cropped != null) {
      setState(() {
        _pickedImage = cropped;
        tapToUploadTheEmpProfile();

      });
    }*/

    final croppedFile  = await ImageCropper().cropImage(
      uiSettings: buildUiSettings(context),
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio4x3,
      ],

      maxWidth: 800,
    );
    if (croppedFile != null) {
      var f = await croppedFile.readAsBytes();

      var selected = File(croppedFile.path);

      _file = selected;

      setState(() {
        _croppedFile = croppedFile;

        if(!kIsWeb){
          _file = selected;

        }
        else{

          setState(() {
            _file = File("a");
            webImage = f;
          });
        }

        tapToUploadTheEmpProfile();

      });
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: primaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  checkWebAndMobile(){

    if(kIsWeb){
      var alertDialog = AlertDialog(
        content: Text('Upload passport size photo only',),
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


            _loadPicker(ImageSource.gallery);

            Navigator.of(context).pop();


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
      photo_alert(context);
    }

  }

  SingleChildScrollView mainFunction_ui(){
    return SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Center(

            child: Column(children: <Widget>[


              // Container(
              //   child: Padding(
              //     padding: const EdgeInsets.fromLTRB(20,10,20,0),
              //     child: Column(
              //       // crossAxisAlignment: CrossAxisAlignment.center,
              //       // mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         SizedBox(
              //
              //           child: Image.asset("profile_coverimage.jpeg",
              //             height: 200,
              //           ),
              //         ),
              //         /*SizedBox(
              //     height: 25.0),*/
              //       ],
              //     ),
              //   ),
              // ),


              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,20,20,10),
                  child: Row(
                    children: [
                      new Text('Welcome'),
                      SizedBox(
                        width: 5.0,
                      ),
                      new Text(welcomeEmployeeName,style:TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),

              /*-----------------23-12-2021 start------------------*/
              create_taxBannerContainer("Please complete your profile and upload required documents to get the employee code at the earliest"),

              /*-----------------23-12-2021 end------------------*/


              //personal details and edit button
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,10,20,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Stack(
                        children: <Widget>[
                          Padding(padding: const EdgeInsets.fromLTRB(40,30,40,50)),
                          /*GFAvatar(
                      backgroundImage:_imageFile==null? AssetImage(
                        genderType_icon,):FileImage(File(_imageFile.path)),
                      shape: GFAvatarShape.square,
                      size: 50,
                  ),
*/

                          /*------------13-11-2021 start----------*/
                          Visibility(visible: empProfileDefault_Visibility,

                              child: GFAvatar(
                                child: (_file.path == "zz") ?
                                Image.asset(genderType_icon) : null,
                                backgroundImage:
                                _file != null ? FileImage(_file) : null,
                                shape: GFAvatarShape.square,
                                size: 50,
                              )
                          ),

                          Visibility(visible: empProfileDynamic_Visibility,
                              child: GFAvatar(
                                child: (_file.path == "zz")
                                    ? Image.memory(base64Decode(profileImagePath))
                                    : (kIsWeb)
                                    ? Image.memory(webImage)
                                    : Image.file(_file),
                                backgroundImage:
                                _file != null ? FileImage(_file) : null,
                                shape: GFAvatarShape.square,
                                size: 50,
                              )
                          ),


                          /*------------13-11-2021 end----------*/


                          /*------------19-2-2022 start----------*/
                          Visibility(visible: empProfileImageIcon_Visibility,child:
                          Positioned(bottom: 1.0, right: 1.0 ,child: Container(
                            height: 30, width: 30,
                            child: InkWell(
                                onTap: ()
                                {
                                  checkWebAndMobile();
                                  // photo_alert(context);

                                },
                                child: Icon(Icons.camera_alt_outlined, color: Colors.white,size: 15,)),
                            decoration: BoxDecoration(
                                color: Color(0xff00BFFF),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                          ))),

                        ],
                      ),

                      SizedBox(
                        height:40, //height of button
                        width:160,
                        child:ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:Color(0xff00BFFF),
                            elevation: 5.0, //elevation of button
                            shape: RoundedRectangleBorder( //to set border radius to button
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            // padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          ),
                          onPressed:()
                          {
                            /*-----------15-2-2022 start----------*/

                            loadEmpJobStatus();

                            /*-----------15-2-2022 end----------*/


                          },
                          child: Row( // Replace with a Row for horizontal icon + text
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              Icon(Icons.contact_phone_outlined),
                              Text('View ID Card',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold))
                            ],
                          ), ),
                      ),
                    ],

                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,10,20,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Personal Details',
                        style: TextStyle(fontWeight: FontWeight.bold,fontFamily:'Vonique',fontSize: 13,color: Colors.black ),),
                      SizedBox(
                        height:30, //height of button
                        width:60,
                        child:MaterialButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed:()
                            {
                              /*-----------15-1-2022 START-----------*/
                              if(ecStatus==compare_ECStatus)
                              {
                                //use for without KYC & Documents(EC)--SHOW THE ALERT BOX
                                check_UserRoleType(context);
                              }
                              else if(ecStatus==compare_TECStatus)
                              {
                                //USE FOR WITH KYC & Documents(TEC)
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => profile_personalDetails_edit()),);
                                checkThePersonalDetailForTECEmloyeeForKYC();
                              }
                              else
                              {
                                check_UserRoleType(context);

                              }

                              /*-----------15-1-2022 END-----------*/

                            },

                            child: Text('Edit',
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily:'Vonique',fontSize: 13,color: Colors.black ))),
                      ),
                    ],
                  ),
                ),
              ),

              //empname
              Profile_UI.create_KeyContainer(getCJHub_PersonIcon,'Emp Name'),Profile_UI.create_ValueContainer(empName),
              //emp email id
              Profile_UI.create_KeyContainer(getCJHub_MailIcon,'Emp Email Id'),Profile_UI.create_ValueContainer(empEmailId),
              //emp code
              Profile_UI.create_KeyContainer(getCJHub_HashIcon,empCodeTitle),Profile_UI.create_ValueContainer(empCode),

              //date of birth
              Profile_UI.create_KeyContainer(getCJHub_CalendarIcon,'Date Of Birth'),Profile_UI.create_ValueContainer(empDateOfBirth),
              //gender
              Profile_UI.create_KeyContainer(getCJHub_GenderIcon,'Gender'),Profile_UI.create_ValueContainer(empGender),
              //mobile number
              Profile_UI.create_KeyContainer(getCJHub_CallIcon,'Mobile No'),Profile_UI.create_ValueContainer(empMobileNumber),
              Profile_UI.create_KeyContainer(getCJHub_LocationIcon,'Address'),Profile_UI.create_ValueContainer(empAddress),
              //father/husband
              Profile_UI.create_KeyContainer(getCJHub_PersonIcon,'Father/Husband'), Profile_UI.create_ValueContainer(empFatherHusbandName),

              SizedBox(
                height: 15,
              )
            ],
            ),
          ),
        )

    );
  }

  @override
  Widget build(BuildContext context)
  {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: bottomSheet_KYC_Document(),

        body: WillPopScope(
          child: Responsive(

              mobile: mainFunction_ui(),

              tablet: Center(
                child:  Container(
                  width: size.width*profile_tabletWidth,
                  child: mainFunction_ui(),


                ),
              ) ,

              desktop: Center(
                child: Container(
                  width: size.width*profile_desktopWidth,

                  child: mainFunction_ui(),
                ),
              )

          ),

          onWillPop: () async => false,

          /*onWillPop: ()
          {
            Message.alert_dialogAppExit(context);

          } ,*/

        )

    );

  }



  checkThePersonalDetailForTECEmloyeeForKYC()
  {
    /*-----------24-3-2022 START-----------*/
    if(kyc_STATUSCode=="0")
    {
      //no kyc required means(PAN Card & Aadhaar Card KYC Completed)
      Navigator.push(context, MaterialPageRoute(builder: (_) =>
          Responsive(
            mobile: profile_personalDetails_edit(),
            tablet: Center(
              child: Container(
                width: flutterWeb_tabletWidth,
                child: profile_personalDetails_edit(),
              ),
            ),
            desktop: Center(
              child: Container(
                width: flutterWeb_desktopWidth,
                child: profile_personalDetails_edit(),
              ),
            ),
          )
          // profile_personalDetails_edit()

      ),);
    }
    else if(kyc_STATUSCode=="1")
    {
      //PAN card kyc required
      if(panCard_STATUSCode=="1")
      {
        //use for 1 means true(PAN CARD KYC Completed)

        Navigator.push(context, MaterialPageRoute(builder: (_) =>
            Responsive(
              mobile: profile_personalDetails_edit(),
              tablet: Center(
                child: Container(
                  width: flutterWeb_tabletWidth,
                  child: profile_personalDetails_edit(),
                ),
              ),
              desktop: Center(
                child: Container(
                  width: flutterWeb_desktopWidth,
                  child: profile_personalDetails_edit(),
                ),
              ),
            )
            // profile_personalDetails_edit()

        ),);

      }else
      {
        //use for 0 means false(PAN CARD KYC Pending)
        Navigator.push(context, MaterialPageRoute(builder: (_) =>

        Responsive(
            mobile: PanCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
            tablet: Center(
              child: Container(
                width: flutterWeb_tabletWidth,
                child: PanCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
              ),
            ),
            desktop: Center(
              child: Container(
                width: flutterWeb_desktopWidth,
                child: PanCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
              ),
            )
        )
            // PanCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",)

        ),);

      }
    }
    else if(kyc_STATUSCode=="2")
    {
      //Aadhaar card kyc required

      if(aadhaarCard_STATUSCode=="1")
      {
        //use for 1 means true(Aadhaar CARD KYC Completed)
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            Responsive(
              mobile: profile_personalDetails_edit(),
              tablet: Center(
                child: Container(
                  width: flutterWeb_tabletWidth,
                  child: profile_personalDetails_edit(),
                ),
              ),
              desktop: Center(
                child: Container(
                  width: flutterWeb_desktopWidth,
                  child: profile_personalDetails_edit(),
                ),
              ),
            )
            // profile_personalDetails_edit()

        ),);

      }else
      {
        //use for 0 means false(Aadhaar CARD KYC Pending)
        Navigator.push(context, MaterialPageRoute(builder: (_) =>

        Responsive(
            mobile: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
            tablet: Center(
              child: Container(
                width: flutterWeb_tabletWidth,
                child: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
              ),
            ),
            desktop: Center(
              child: Container(
                width: flutterWeb_desktopWidth,
                child: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
              ),
            )
        )
            // AadhaarCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",)

        ),);

      }

    }
    else if(kyc_STATUSCode=="3")
    {
      //PAN Card & Aadhaar Card kyc required

      if(panCard_STATUSCode=="1" && aadhaarCard_STATUSCode=="1")
      {
        Navigator.push(context, MaterialPageRoute(builder: (_) =>

        Responsive(
            mobile: profile_personalDetails_edit(),
            tablet: Center(
              child: Container(
                width: flutterWeb_tabletWidth,
                child: profile_personalDetails_edit(),
              ),
            ),
            desktop: Center(
              child: Container(
                width: flutterWeb_desktopWidth,
                child: profile_personalDetails_edit(),
              ),
            ))
            // profile_personalDetails_edit()

        ),);
      }
      else if(panCard_STATUSCode=="0" && aadhaarCard_STATUSCode=="0")
      {
        Navigator.push(context, MaterialPageRoute(builder: (_) =>

        Responsive(
          mobile: PanCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
          tablet: Center(
            child: Container(
              width: flutterWeb_tabletWidth,
              child: PanCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
            ),
          ),
          desktop: Center(
            child: Container(
              width: flutterWeb_desktopWidth,
              child: PanCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
            ),
          ),
        )
            // PanCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",)

        ),);
      }
      else if(panCard_STATUSCode=="0" && aadhaarCard_STATUSCode=="1")
      {
        Navigator.push(context, MaterialPageRoute(builder: (_) =>

        Responsive(
            mobile: PanCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
            tablet: Center(
              child: Container(
                width: flutterWeb_tabletWidth,
                child: PanCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
              ),
            ),
            desktop: Center(
              child: Container(
                width: flutterWeb_desktopWidth,
                child: PanCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
              ),
            )
        )
            // PanCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",)

        ),);
      }
      else if(panCard_STATUSCode=="1" && aadhaarCard_STATUSCode=="0")
      {
        Navigator.push(context, MaterialPageRoute(builder: (_) =>

        Responsive(
            mobile: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
            tablet: Center(
              child: Container(
                width: flutterWeb_tabletWidth,
                child: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
              ),
            ),
            desktop: Center(
              child: Container(
                width: flutterWeb_desktopWidth,
                child: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",),
              ),
            ))
            // AadhaarCardView(USER_ARRIVE_FROM_STATUS: "PersonalDetails",)

        ),);
      }
      else
      {

      }

    }
    else
    {

    }
    /*-----------24-3-2022 END-----------*/
  }



  /*--------------23-12-2021 start-----------------*/


  Visibility create_taxBannerContainer(String value)
  {

    return  Visibility(visible: checkKYCDocuments_BannerRedAlertTop_VisibilityStatus,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,1,20,5),
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
                    child: Text(value,style: TextStyle(color: bannerTextColor,fontSize: 12),),
                  )
              )
            ],
          ),
        ),
      ),);


  }

  /*--------------23-12-2021 end-----------------*/

  /*---------------23-12-2021 start--(Add KYC and Document details)----------------*/
  Widget bottomSheet_KYC_Document()
  {
    return Visibility(
      visible: checkKYCDocuments_VisibilityStatus,
      child: Container(
        height: 70.0,
        width: MediaQuery.of(context).size.width,
        /*margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),*/

        child: Column(children: <Widget>[
          Expanded(
              child: Divider(
                color: addLightGrayColor,
                thickness: 1,
              )
          ),

          //KYC START
          Expanded(
            flex: 3,
            child: Container(
                // color: Colors.amberAccent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(

                      // height:70,
                        padding: const EdgeInsets.only(left: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('KYC Details',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily:'Vonique',fontSize: 12,color: Colors.black ),
                          ),
                        )
                    ),

                    SizedBox(
                      // height:30, //height of button
                        width:60,
                        child:MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          // onPressed:()=> alert_dialog(context),
                          onPressed: ()
                          {
                            /*-----------24-3-2022 START-----------*/
                            if(kyc_STATUSCode=="0")
                            {
                              //no kyc required means(PAN Card & Aadhaar Card KYC Completed)
                              Navigator.push(context, MaterialPageRoute(builder: (_) =>

                                  Responsive(
                                      mobile: KYC_details_Add_Edit(),
                                      tablet: Center(
                                        child: Container(
                                          width: flutterWeb_tabletWidth,
                                          child: KYC_details_Add_Edit(),
                                        ),
                                      ),
                                      desktop: Center(
                                        child: Container(
                                          width: flutterWeb_desktopWidth,
                                          child: KYC_details_Add_Edit(),
                                        ),
                                      ))
                                // KYC_details_Add_Edit()

                              ),);
                            }
                            else if(kyc_STATUSCode=="1")
                            {
                              //PAN card kyc required
                              if(panCard_STATUSCode=="1")
                              {
                                //use for 1 means true(PAN CARD KYC Completed)

                                Navigator.push(context, MaterialPageRoute(builder: (_) =>

                                    Responsive(
                                        mobile: KYC_details_Add_Edit(),
                                        tablet: Center(
                                          child: Container(
                                            width: flutterWeb_tabletWidth,
                                            child: KYC_details_Add_Edit(),
                                          ),
                                        ),
                                        desktop: Center(
                                          child: Container(
                                            width: flutterWeb_desktopWidth,
                                            child: KYC_details_Add_Edit(),
                                          ),
                                        ))
                                  // KYC_details_Add_Edit()

                                ),);

                              }else
                              {
                                //use for 0 means false(PAN CARD KYC Pending)
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>

                                    Responsive(
                                        mobile: PanCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                                        tablet: Center(
                                          child: Container(
                                            width: flutterWeb_tabletWidth,
                                            child: PanCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                                          ),
                                        ),
                                        desktop: Center(
                                          child: Container(
                                            width: flutterWeb_desktopWidth,
                                            child: PanCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                                          ),
                                        )
                                    )
                                  // PanCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",)

                                ),);

                              }
                            }
                            else if(kyc_STATUSCode=="2")
                            {
                              //Aadhaar card kyc required

                              if(aadhaarCard_STATUSCode=="1")
                              {
                                //use for 1 means true(Aadhaar CARD KYC Completed)
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>

                                    Responsive(
                                        mobile: KYC_details_Add_Edit(),
                                        tablet: Center(
                                          child: Container(
                                            width: flutterWeb_tabletWidth,
                                            child: KYC_details_Add_Edit(),
                                          ),
                                        ),
                                        desktop: Center(
                                          child: Container(
                                            width: flutterWeb_desktopWidth,
                                            child: KYC_details_Add_Edit(),
                                          ),
                                        ))
                                  // KYC_details_Add_Edit()
                                ),);

                              }else
                              {
                                //use for 0 means false(Aadhaar CARD KYC Pending)
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>

                                    Responsive(
                                      mobile: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                                      tablet: Center(
                                        child: Container(
                                          width: flutterWeb_tabletWidth,
                                          child: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                                        ),
                                      ),
                                      desktop: Center(
                                        child: Container(
                                          width: flutterWeb_desktopWidth,
                                          child: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                                        ),
                                      ),
                                    )
                                  // AadhaarCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",)

                                ),);

                              }

                            }
                            else if(kyc_STATUSCode=="3")
                            {
                              //PAN Card & Aadhaar Card kyc required

                              if(panCard_STATUSCode=="1" && aadhaarCard_STATUSCode=="1")
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>

                                    Responsive(
                                        mobile: KYC_details_Add_Edit(),
                                        tablet: Center(
                                          child: Container(
                                            width: flutterWeb_tabletWidth,
                                            child: KYC_details_Add_Edit(),
                                          ),
                                        ),
                                        desktop: Center(
                                          child: Container(
                                            width: flutterWeb_desktopWidth,
                                            child: KYC_details_Add_Edit(),
                                          ),
                                        ))
                                  // KYC_details_Add_Edit()

                                ),);
                              }
                              else if(panCard_STATUSCode=="0" && aadhaarCard_STATUSCode=="0")
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>

                                    Responsive(
                                      mobile: PanCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                                      tablet: Center(
                                        child: Container(
                                          width: flutterWeb_tabletWidth,
                                          child: PanCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                                        ),
                                      ),
                                      desktop: Center(
                                        child: Container(
                                          width: flutterWeb_desktopWidth,
                                          child: PanCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                                        ),
                                      ),
                                    )
                                  // PanCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",)

                                ),);
                              }
                              else if(panCard_STATUSCode=="0" && aadhaarCard_STATUSCode=="1")
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>

                                    Responsive(
                                        mobile:  PanCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                                        tablet: Center(
                                          child: Container(
                                            width: flutterWeb_tabletWidth,
                                            child:  PanCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                                          ),
                                        ),
                                        desktop: Center(
                                          child: Container(
                                            width: flutterWeb_desktopWidth,
                                            child:  PanCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                                          ),
                                        ))
                                  // PanCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",)

                                ),);
                              }
                              else if(panCard_STATUSCode=="1" && aadhaarCard_STATUSCode=="0")
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>

                                    Responsive(
                                        mobile: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                                        tablet: Center(
                                          child: Container(
                                            width: flutterWeb_tabletWidth,
                                            child: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                                          ),
                                        ),
                                        desktop: Center(
                                          child: Container(
                                            width: flutterWeb_desktopWidth,
                                            child: AadhaarCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",),
                                          ),
                                        ))
                                  // AadhaarCardView(USER_ARRIVE_FROM_STATUS: "KYCDetails",)

                                ),);
                              }
                              else
                              {

                              }

                            }
                            else
                            {

                            }
                            /*-----------24-3-2022 END-----------*/

                          },
                          child: _buildChild_KYC_Details(),
                          /*Text('Add',
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily:'Vonique',fontSize: 13,color: primaryColor )),
                       */
                        )

                    ),

                  ],
                )),
          )
          ,

          Expanded(
              child: Divider(
                color: addLightGrayColor,
                thickness: 1,
              )
          ),

          //Documents START
          Expanded(
            flex: 3,
              child: Container(
              // color: Colors.blue,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(

                    // height: 70,
                    padding: const EdgeInsets.only(left: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Document',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.bold,fontFamily:'Vonique',fontSize: 12,color: Colors.black ),
                      ),
                    ),
                  ),


                  SizedBox(
                    // height:30, //height of button
                    width:60,
                    child:MaterialButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      // onPressed:()=> alert_dialog(context),
                      onPressed: ()
                      {

                        Navigator.push(context, MaterialPageRoute(builder: (_) =>

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
                                )
                            )
                          // Profile_NewDocument()
                        ),);

                      },
                      child: _buildChild_Document(),
                      /* Text('Add',
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily:'Vonique',fontSize: 13,color: primaryColor ))*/
                    ),
                  ),
                ],
              )))
          ,


          Expanded(
              child: Divider(
                color: addLightGrayColor,
                thickness: 1,
              )
          ),
        ]
        ),
      ) ,
    );

  }

  Widget _buildChild_KYC_Details()
  {
    if(KYC_empType=="First Time"){
      return Visibility(
          visible: KYCDetails_ADD,
          child:  Text('Add',
              style: TextStyle(fontWeight: FontWeight.bold,fontFamily:'Vonique',fontSize: 13,color: primaryColor )));
    }
    else
      return Visibility(
          visible: KYCDetails_EDIT,
          child:  Text('Edit',
              style: TextStyle(fontWeight: FontWeight.bold,fontFamily:'Vonique',fontSize: 13,color: primaryColor )));
  }

  Widget _buildChild_Document()
  {
    if(Document_empType=="First")
    {
      return Visibility(
          visible: Document_ADD,
          child:  Text('Add',
              style: TextStyle(fontWeight: FontWeight.bold,fontFamily:'Vonique',fontSize: 13,color: primaryColor )));
    }
    else
      return Visibility(
          visible: Document_EDIT,
          child:  Text('Edit',
              style: TextStyle(fontWeight: FontWeight.bold,fontFamily:'Vonique',fontSize: 13,color: primaryColor )));
  }

  void checkKYCEmp()
  {
    if(KYC_empType =='First Time' )
    {
      KYCDetails_ADD= true;
      KYCDetails_EDIT =false;
    }else{
      // After Save Button
      KYCDetails_EDIT =true;
      KYCDetails_ADD= false;
    }
  }

  void checkDocumentEmp(){
    if(Document_empType =='First' )
    {
      Document_ADD= true;
      Document_EDIT =false;
    }else{
      // After Save Button
      Document_EDIT =true;
      Document_ADD= false;
    }
  }

  /*---------------23-12-2021 END--(Add KYC and Document details)----------------*/



  // ignore: non_constant_identifier_names
  check_UserRoleType(BuildContext context)
  {

    SharedPreference.getEmpJobType().then((value) =>  {
      //print('show emp name2 $value'),

      // ignore: unrelated_type_equality_checks
      if(value == "Regular")
        {
          // Regular
          showAlertDialog('Please contact HR Team at', 'hr@akalinfosys.com')
        }
      else
        {
          //Contractual
          showAlertDialog('Please contact Care Team at', 'care@contract-jobs.com')
        }
    });
  }

  void showAlertDialog(String heading,String email)
  {
    var alertDialog = AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //position
        mainAxisSize: MainAxisSize.min,
        // wrap content in flutter
        children: <Widget>[
          Text(heading,
            style: TextStyle(fontFamily:'Vonique',fontSize: 15,color: Colors.black),),
          Text(email,
            style: TextStyle(fontFamily:'Vonique',fontSize: 15,color: Color(0xff00BFFF)),)
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [

        TextButton(onPressed: ()
        {
          Navigator.of(context).pop();



        }, child: Text("OK",
          textAlign: TextAlign.right,style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
        SizedBox(width: 20.0),
      ],

    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog
    );
  }

  photo_alert(BuildContext context)
  {
    var alertDialog = AlertDialog(
      content: Text("Upload passport size photo only",
        textAlign: TextAlign.left,),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [

        TextButton(onPressed: () {
          Navigator.of(context).pop();
          showModalBottomSheet(context: context,
            builder: ((builder)=> cameraGallery_BottomSheet()),);

        },

          child: Text("OK",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
      ],

    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }


  tapToUploadTheEmpProfile()
  {
    SharedPreference.getEmpId().then((value) =>  {
      empId=value,
      //print('show emp name2 $value'),
    });

    Method.getIPAddress().then((value) => {

      tapToUploadThe_EmpProfile_WebApi(value)



    });
  }

  // ignore: non_constant_identifier_names
  tapToUploadThe_EmpProfile_WebApi(String ipAddress) async
  {
    EasyLoading.show(status: Message.get_LoaderMessage);

    String baseimage;

    if (_file == null) return;

    if(kIsWeb){

      //print('API WebImage');

       baseimage = base64Encode(webImage);
      //print("webImage API path: $baseimage");

    }
    else{
      List<int> imageBytes = File(_file.path).readAsBytesSync();
       baseimage = base64Encode(imageBytes);

      //print("Mobile API path: $baseimage");
    }





    try {
      final response = await http.post(
        Uri.parse(
            WebApi.insert_Emp_ProfilePhoto),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'emp_code': empCode,
          'emp_profile_photo': baseimage,
          'created_ip': ipAddress,
          'created_by': empId
        },
      );
      //print(response.statusCode);
      //print(response.body);

      EasyLoading.dismiss();

      if (response.statusCode == 200)
      {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        UpdateProfileImage_ModelResponse imageModelResponse=UpdateProfileImage_ModelResponse.fromJson(jsonDecode(response.body));

        if(imageModelResponse.statusCode==true)
        {

          Method.snackBar_OkText(context, imageModelResponse.message!);
          // show_OKAlert(imageModelResponse.message);
        }
        else
        {
          if(imageModelResponse.message==null || imageModelResponse.message=="")
          {
            Method.snackBar_OkText(context, "Server error!");
            // show_OKAlert("Server error!");

          }
          else {

            Method.snackBar_OkText(context, imageModelResponse.message!);
            // show_OKAlert(imageModelResponse.message);
          }
        }

      }
      else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      //print(e);
    }
  }
  // ignore: non_constant_identifier_names

  void checkNetworkConnection(dynamic hasConnection)
  {

    if(mounted){
      setState(() {
        networkStatus = !hasConnection;
      });
    }

    if(!networkStatus){
      print("Api profile should be called");
      // await _longOperation();
      // Navigator.pop(dialogContext!);
      getAppVersionCode_FromServer();
      EasyLoading.dismiss();
    }
    else{
      print("Api profile should not be called");
      EasyLoading.show(status: Message.get_LoaderMessage);
      // showAlert(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No Internet Connection')));
    }
    print(" Inside Test Widget profile 2");



    /*NetworkReachability.networkConnectionStatus().then((networkStatus) =>
    {
      if(networkStatus)
        {
          getAppVersionCode_FromServer()
        }
      else
        {
          //print('please check the network status'),
        }
    });*/
    // getAppVersionCode_FromServer();
  }
  showNetworConnectionAlert()
  {
    var alertDialog = AlertDialog(
      content: Text(Message.get_NetworkConnectionMessage,
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

    );
  }
  getAppVersionCode_FromServer() async
  {

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.getApp_VersionCode),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'device_type': 'android'
        },
      );
      print(response.body);

      if (response.statusCode == 200)
      {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        VersionCode_ModelData versionCode_ModelData=VersionCode_ModelData.fromJson(jsonDecode(serverResponse));
        String vvcc=versionCode_ModelData.data!.versionCode;
        if(versionCode_ModelData.statusCode==true)
        {
          showAppVersionUpgraded(versionCode_ModelData.data!.versionCode);

        }else
        {

        }

      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      //print(e);
    }
  }
  showAppVersionUpgraded(String dbVersionCode) async
  {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    getPackageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    //print('show version code new $buildNumber');
    //print('show version name new $version');
    //print('show server version code new $dbVersionCode');
    if (int.parse(dbVersionCode) > int.parse(buildNumber))
    {
       updateApp_Alert(context);
    }
  }

  updateApp_Alert(BuildContext context)
  {
    var alertDialog = AlertDialog(
      title: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text("New Version Available",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),) ,
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //position
        mainAxisSize: MainAxisSize.min,
        // wrap content in flutter
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text("There are New Updates Available \non CJHub" ,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily:'Vonique',fontSize: 14,color: Colors.black),) ,
          )

        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [
        Align(
          alignment: Alignment.center,
          child: TextButton(onPressed: ()
          {
            Navigator.of(context).pop();

            SharedPreference.setLoginStatus("false");
            try {

             // launch("market://details?id=" + getPackageName);
              _launchURL("market://details?id=" + getPackageName);


            } on PlatformException catch(e)
            {
              //launch("https://play.google.com/store/apps/details?id=" + getPackageName);
              _launchURL("https://play.google.com/store/apps/details?id=" + getPackageName);

            } finally
            {
              //launch("https://play.google.com/store/apps/details?id=" + getPackageName);
              _launchURL("https://play.google.com/store/apps/details?id=" + getPackageName);
            }

          }, child: Text("Update",
            textAlign: TextAlign.center,style:TextStyle(fontSize: 16,color: primaryColor,fontWeight: FontWeight.bold),),),
        )

      ],

    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => alertDialog

    );

  }
  _launchURL(String url) async
  {

    if (await canLaunchUrlString(url)) {

      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /*----------commented show_OKAlert Dialog---------21-07-2022-start--*/

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
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) => alertDialog
  //
  //   );*/
  // }

  /*----------commented show_OKAlert Dialog---------21-07-2022-end--*/


  alertPopUpForLogout()
  {
    var alertDialog = AlertDialog(
      content: Text('Do you want to logout?',
        textAlign: TextAlign.center,),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [

        TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("CANCEL",
          textAlign: TextAlign.center,style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
        SizedBox(width: 20.0),

        TextButton(onPressed: (){setState(()
        {
          Navigator.of(context).pop();
          /*Navigator.push(context, MaterialPageRoute(builder: (_)=>

              Responsive(
                mobile: login(),
                tablet: Center(
                  child: Container(
                    width: login_tabletWidth,
                    child: login(),
                  ),
                ),
                desktop: Center(
                  child: Container(
                    width: login_desktopWidth,
                    child: login(),
                  ),
                ),
              ),
              // login()

          ));*/

        });},
          child: Text("OK",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
      ],

    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }

/*--------------18-4-2022 start save_AppActivationLogToCRM----------------*/
  save_AppActivationLogToCRM() async
  {

    /*---statusType=P means pass or statusType=F means Fail--------*/

    //print('show js id $jsId_key');

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.save_AppActivationLogTo_CRM),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'js_id': getEncrypted_EmpCode(jsId_key),
        },
      );


      //print(response.statusCode);
      //print(response.body);

      if (response.statusCode == 200)
      {

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        SharedPreference.set_AppLogActivationSaveInCRMStatus("1");

        //print(response.body);
        //print('show save_AppActivationLogTo_CRM');

        var responseBody=jsonDecode(response.body);
        var statusCode=responseBody["statusCode"];
        var message=responseBody["message"];

        //print('show status $message');


      } else {


        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      //print(e);
    }
  }
/*--------------18-4-2022 end save_AppActivationLogToCRM----------------*/



}

