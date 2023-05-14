import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart'as http;

//import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../CustomView/CJHubCustomView/AutoLogout.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../ModelClasses/CJHubModelClasses/ViewIdCard_ModelResponse.dart';
import 'mobile_pdf.dart' if (dart.library.html) 'web_pdf.dart';

import '../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJHubCustomView/NetworkStatus/NetworkReachability.dart';
import '../../../../CustomView/CJHubCustomView/SalaryYearMonth_List.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../Services/AESAlgo/encrypt.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/Messages/Message.dart';
import '../../ModelClasses/CJHubModelClasses/SalaryStatus_ModelResponse.dart';

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
      home: pdf_id_ui(title: 'CJ Hub'),
    );
  }
}
class pdf_id_ui extends StatefulWidget {
  pdf_id_ui({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _pdf_id_ui createState() => _pdf_id_ui();

}

class _pdf_id_ui extends State<pdf_id_ui> {

  String genderType_icon=getCJHub_MaleIcon,
      checkRoleType="",
      genderType_Name="";

  String companyName="",
      companyAddress="",
      empName="",
      empDesignation="",
      empId="",
      empIdTitle="",
      empSinceDate="",
      empMobile="",cjCode="";

  String careManagerName="";
  String clientName="";
  String postingLocation="";
  String validPeriod="";

  String careSignIn_imagePath="http://demoarea.1akal.in/cj/production/assets/img/employer/sign_caremanager.jpg";
  //String careSignIn_imagePath="signature.png";
  bool careSignature_Visibility=false;


  // This widget is the root of your application.
  bool _visibleRegular=false;
  bool _visibleContractual=false;
  bool profileImage_Visiblity_Default=true;
  bool profileImage_Visiblity_Dynamic=false;
  String profile_ImageURL="";
  String careManagerSign_ImageURL="";

  ViewIdCard_ModelResponse? _card_modelResponse;

  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;

  @override
  void initState() {
    super.initState();
    checkEmp_JobType();
    check_EmpGenderType();

    if(!networkStatus){
      print("Api salary status should be called");
      viewIdCardDetails();
      EasyLoading.dismiss();
    }
    else{
      print("Api salary status should not be called");
      EasyLoading.show(status: Message.get_LoaderMessage);
      Method.snackBar_OkText(context, 'No Internet Connection');

    }
    print(" Inside Test Widget 2");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      NetworkReachability connectionStatus = NetworkReachability.getInstance();

      _connectionChangeStream =
          connectionStatus.connectionChange.listen(checkNetworkConnection);
    });

    // checkNetworkConnection();

    if(kIsWeb){

      //print("This CJ Hub Web");

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

    //print("pdf_id_view resetTimer:");

    AutoLogout.initializeTimer(context);
  }


  // ignore: non_constant_identifier_names
  check_EmpGenderType()
  {
    SharedPreference.getEmpGender().then((value) =>  {
      //print('show emp name2 $value'),

      genderType_Name=value.trim(),
      // ignore: unrelated_type_equality_checks
      if(value.trim() == "Male")
        {
          // Male
          genderType_icon=getCJHub_MaleIcon,
          loadGenderIcon()
        }
      else
        {
          //FeMale
          genderType_icon=getCJHub_FemaleIcon,
          loadGenderIcon()
        }
    });

  }
  loadGenderIcon()
  {
    setState(() {
      genderType_icon=genderType_icon;
    });
  }
  // ignore: non_constant_identifier_names
  checkEmp_JobType()
  {
    SharedPreference.getEmpJobType().then((value) =>  {
      //print('show emp name2 $value'),

      // ignore: unrelated_type_equality_checks
      if(value == "Regular")
        {
          // Regular
          checkRoleType="Regular",
          loadData(true,false)

        }
      else
        {
          //Contractual
          checkRoleType="Contractual",
          loadData(false,true)
        }
    });

  }
  void loadData(bool regularStatus,bool contractualStatus)
  {
    setState(() {

      _visibleRegular = regularStatus;
      _visibleContractual = contractualStatus;

    });
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

            backgroundColor: Colors.white,
            appBar:CJAppBar(getCJHUB_IdCard, appBarBlock: AppBarBlock(appBarAction: ()
            {
              print("show the action type");
              Navigator.pop(context);
            })),

            body: WillPopScope(
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20.0,
                                height: 30.0,
                                child: Image.asset(getCJHub_LineIcon,
                                ),
                              ),
                              SizedBox(
                                  width: 3.0),
                              Text('ID-Card',style: TextStyle(color: Colors.black,fontSize: 17),),
                            ],
                          ),

                          /*--------------28/2/2023 start-----------------*/

                         /* SizedBox(
                            height:75, //height of button
                            width:80,
                            child:MaterialButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed:() {
                                if (kIsWeb) {

                                  if(checkRoleType=="Regular")
                                  {
                                    _create_RegularEmp_PDF("Ok");
                                  }
                                  else
                                  {
                                    _create_ContractualEmp_PDF("Ok");
                                  }

                                }
                                else {
                                  alert_dialog(context);
                                }
                              },



                              child: SizedBox(
                                width: 75.0,
                                height: 80.0,
                                child: Image.asset(getCJHub_SalarySlipPDFIcon,
                                ),
                              ), ),
                          ),*/
                          /*--------------28/2/2023 end-----------------*/

                        ],
                      ),
                    ),
                  ),

                  /*---------------Regular-------------*/
                  Visibility(visible: _visibleRegular,
                    child:
                    Container(
                      width: 320,
                      padding: const EdgeInsets.fromLTRB(20,10,20,10),
                      child: Card(

                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 0.5,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color(0xff00BFFF),
                                      width: 7.0
                                  )
                              )
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              getSizeBoxHeight_ForRegularEmployee(4.0),

                              SizedBox(
                                child: Image.asset(getCJHub_AkalLogo,
                                ),
                              ),

                              getSizeBoxHeight_ForRegularEmployee(5.0),

                              Text(companyName,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold)),
                              getSizeBoxHeight_ForRegularEmployee(1.0),

                              Text(companyAddress,style: TextStyle(fontSize: 10,color: Colors.black)),

                              getSizeBoxHeight_ForRegularEmployee(10.0),

                              Stack(
                                children: <Widget>[
                                  /*GFAvatar(
                            backgroundImage: AssetImage(genderType_icon),
                            shape: GFAvatarShape.square,
                            size: 50,
                          ),*/

                                  /*-------------11-11-2021 start----------*/
                                  Visibility(visible: profileImage_Visiblity_Default,
                                    child: GFAvatar(
                                      backgroundImage: AssetImage(genderType_icon),
                                      shape: GFAvatarShape.square,
                                      size: 50,
                                    ),),

                                  Visibility(visible: profileImage_Visiblity_Dynamic,
                                      child: /*GFAvatar(
                              backgroundImage:NetworkImage(profile_ImageURL),
                              shape: GFAvatarShape.square,
                              size: 50,
                            )*//*Image.memory(base64Decode(profile_ImageURL))),*/
                                      GFAvatar(
                                        child: Image.memory(base64Decode(profile_ImageURL)),
                                        shape: GFAvatarShape.square,
                                        size: 50,
                                      ))
                                  /*-------------11-11-2021 end----------*/

                                ],
                              ),

                              getSizeBoxHeight_ForRegularEmployee(10.0),
                              Text(empName,style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold)),
                              getSizeBoxHeight_ForRegularEmployee(15.0),
                              Text(empDesignation,style: TextStyle(fontSize: 14,color: Colors.black)),
                              getSizeBoxHeight_ForRegularEmployee(15.0),
                              getRow_ForRegularEmp(empIdTitle,empId),
                              getSizeBoxHeight_ForRegularEmployee(15.0),
                              getRow_ForRegularEmp('Employee Since:',empSinceDate),
                              getSizeBoxHeight_ForRegularEmployee(15.0),
                              getRow_ForRegularEmp('Mob:',empMobile),
                              getSizeBoxHeight_ForRegularEmployee(18.0),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  /*--------Contractual-------*/
                  Visibility(
                    visible: _visibleContractual,
                    child:
                    Container(
                      width: 420,
                      padding: const EdgeInsets.fromLTRB(20,10,20,10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: twoHunGreyColor,
                            width: 2.0,
                          ),
                        ),
                        child: Container(

                          decoration: BoxDecoration(
                            // color: Colors.green,
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color(0xff00BFFF),
                                      width: 7.0
                                  )
                              )
                          ),
                          child: Column(
                            children: [
                              /* SizedBox(
                        child: Image.asset("akallogo.jpeg",
                        ),
                      ),*/


                              /*-----------------14-11-2021 start(Testing pending)-----------------*/

                              Container(
                                color: primaryColor,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 90,
                                        color: primaryColor,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(getCJHub_AkalLogoWhite),
                                          ],
                                        )

                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        width: 300,
                                        padding: const EdgeInsets.fromLTRB(10,10,10,10),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex:1,
                                                  child: Text(companyName,
                                                      style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold)),
                                                ),

                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Expanded(
                                                  flex:1,
                                                  child: Text(companyAddress,
                                                      style: TextStyle(fontSize: 10,color: Colors.white)),
                                                )

                                              ],
                                            ),

                                          ],
                                        ),
                                      ),)

                                  ],
                                ),
                              ),

                              /*-----------------14-11-2021 end-----------------*/


                              /*---------------------15-11-2021 start-----------------------*/

                              IntrinsicHeight(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex:1,
                                        child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 100,
                                                // height: 149,
                                                // color: Colors.yellow,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [

                                                    SizedBox(
                                                      height: 115.0,
                                                      child:Stack(
                                                        children: <Widget>[

                                                          /*-------------11-11-2021 start----------*/
                                                          Visibility(visible: profileImage_Visiblity_Default,
                                                            child: GFAvatar(
                                                              backgroundImage: AssetImage(genderType_icon),
                                                              shape: GFAvatarShape.square,
                                                              size: 70,
                                                            ),),

                                                          Visibility(visible: profileImage_Visiblity_Dynamic,
                                                              child: /*GFAvatar(
                              backgroundImage:NetworkImage(profile_ImageURL),
                              shape: GFAvatarShape.square,
                              size: 50,
                            )*//*Image.memory(base64Decode(profile_ImageURL))),*/

                                                              GFAvatar(
                                                                child: Image.memory(base64Decode(profile_ImageURL)),
                                                                shape: GFAvatarShape.square,
                                                                size: 70,
                                                              ))

                                                          /*-------------11-11-2021 end----------*/
                                                        ],
                                                      ),

                                                    ),


                                                    Visibility(visible: careSignature_Visibility,
                                                      child: Align(
                                                        child:Image.network(careSignIn_imagePath,
                                                            width: 90,height: 50),
                                                      ),
                                                    ),



                                                    Padding(padding: const EdgeInsets.only(left: 5,bottom: 15),
                                                      child:Text(careManagerName,style: TextStyle(fontSize: 11),),)

                                                  ],
                                                ),),

                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  width: 550,
                                                  // color: Colors.cyan,
                                                  child: Column(
                                                    children: [


                                                      getRow_ForContractualEmp('Name:',empName),
                                                      getRow_ForContractualEmp('Desi:',empDesignation),
                                                      getRow_ForContractualEmp(empIdTitle,cjCode),
                                                      getRow_ForContractualEmp('Client:',clientName),
                                                      getRow_ForContractualEmp('Working Location:',postingLocation),

                                                      getRow_ForContractualEmp('Valid Period:',validPeriod),
                                                      getRow_ForContractualEmp('Mob:',empMobile),
                                                      getRow_ForContractualEmp('',''),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      ),

                                    ]),
                              ),




                              /*---------------------15-11-2021 end-----------------------*/




                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
                ),

              ),
              onWillPop: () async => false,
              /*onWillPop: ()
          {
            Message.alert_dialogAppExit(context);

          } ,*/

            )


        )
    );
  }

  // ignore: non_constant_identifier_names
  SizedBox getSizeBoxHeight_ForRegularEmployee(double size)
  {
    return SizedBox(
        height: size
    );
  }

  Row getRow_ForRegularEmp(String key,String value)
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(key,style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold)),
        SizedBox(
          width: 2.0,
        ),
        Text(value,style: TextStyle(fontSize: 14,color: Colors.black)),
      ],
    );
  }
  Row getRow_ForContractualEmp(String key,String value)
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Expanded(
          flex:0,
          child:Padding(padding: EdgeInsets.only(left: 4),
              child: Text(key,style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold))),
        ),

        Expanded(
            flex:0,
            child:SizedBox(
              width: 2.0,
            )),

        Expanded(
          flex: 1,
          child:Text(value,style: TextStyle(fontSize: 14,color: Colors.black)),
        )
      ],
    );
  }

  alert_dialog(BuildContext context) {
    var alertDialog = AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //position
        mainAxisSize: MainAxisSize.min,
        // wrap content in flutter
        children: <Widget>[
          Text("ID Card Downloaded Successfully.",
            style: TextStyle(fontFamily:'Vonique',fontSize: 15,color: Colors.black),),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [
        TextButton(onPressed: ()
        {
          Navigator.of(context).pop();

          if(checkRoleType=="Regular")
          {
            _create_RegularEmp_PDF("Open");
          }
          else
          {
            _create_ContractualEmp_PDF("Open");
          }

        }, child: Text("OPEN",
          textAlign: TextAlign.right,style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
        SizedBox(width: 5.0),
        TextButton(onPressed: ()
        {
          Navigator.of(context).pop();

          if(checkRoleType=="Regular")
          {
            _create_RegularEmp_PDF("Ok");
          }
          else
          {
            _create_ContractualEmp_PDF("Ok");
          }

        }, child: Text("OK",
          textAlign: TextAlign.right,style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),

      ],

    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }

  alert_dialogWeb(BuildContext context){
    var alertDialog = AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //position
        mainAxisSize: MainAxisSize.min,
        // wrap content in flutter
        children: <Widget>[
          Text("Download ID Card",
            style: TextStyle(fontFamily:'Vonique',fontSize: 15,color: Colors.black),),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [
        TextButton(onPressed: ()
        {
          Navigator.of(context).pop();


        }, child: Text("Cancel",
          textAlign: TextAlign.right,style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
        SizedBox(width: 5.0),
        TextButton(onPressed: ()
        {
          Navigator.of(context).pop();

          if(checkRoleType=="Regular")
          {
            _create_RegularEmp_PDF("Ok");
          }
          else
          {
            _create_ContractualEmp_PDF("Ok");
          }

        }, child: Text("OK",
          textAlign: TextAlign.right,style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),

      ],

    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }

  showNetworkConnectionAlert()
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

/*---------hit view id card details start 15/7/2021-----*/

  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names

  void checkNetworkConnection(dynamic hasConnection)
  {
    if(mounted){
      setState(() {
        networkStatus = !hasConnection;
      });
    }
    if(!networkStatus){
      print("Api should be called");
      viewIdCardDetails();
      EasyLoading.dismiss();
    }
    else{
      print("Api should not be called");
      EasyLoading.show(status: Message.get_LoaderMessage);
      Method.snackBar_OkText(context, 'No Internet Connection');
    }
    print(" Inside Test Widget 2");
    /* NetworkReachability.networkConnectionStatus().then((networkStatus) =>
    {
      if(networkStatus)
        {
          viewIdCardDetails()
        }
      else
        {
          //print('please check the network status'),
          showNetworkConnectionAlert()
        }
    });*/

    // viewIdCardDetails();
  }

  // ignore: non_constant_identifier_names
  viewIdCardDetails()
  {

    String mobileNumber="",
        empCode="",
        empDateOfBirth="",
        completeEmpCode="";

    SharedPreference.getEmpMobileNo().then((value) =>  {
      mobileNumber=value,
      //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpCode().then((value) =>  {
      empCode=value,
      //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth=value,
      //print('show emp name2 $value'),
      completeEmpCode = mobileNumber+"CJHUB"+empCode+"CJHUB"+empDateOfBirth,
      // print('show emp id card completeEmpCode $completeEmpCode'),

      this.viewIdCardDetails_WebApi(completeEmpCode)

    });

  }

  // ignore: non_constant_identifier_names
  viewIdCardDetails_WebApi(String empCode) async
  {
   // empCode="9569734648CJHUB5610CJHUB14/05/1988";

    String ff=getEncrypted_EmpCode(empCode);
    //print('show emp id card completeEmpCode $ff');

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.viewEmp_CardIdDetails),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'emp_code': getEncrypted_EmpCode(empCode)
        },
      );
      //print(response.statusCode);
      if (response.statusCode == 200)
      {
        EasyLoading.dismiss();


        print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        ViewIdCard_ModelResponse viewIdCardModelResponse = ViewIdCard_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(viewIdCardModelResponse.statusCode==true)
        {
          loadViewIdCardData(viewIdCardModelResponse);
        }else
        {

          Method.snackBar_OkText(context, viewIdCardModelResponse.message!);
          // show_OKAlert(viewIdCardModelResponse.message);
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

  loadViewIdCardData(ViewIdCard_ModelResponse viewIdCardModelResponse)
  {
    _card_modelResponse=viewIdCardModelResponse;

    var companyaddress = viewIdCardModelResponse.data?.companyAddress;
    var parts = companyaddress.split("Yusuf Sarai,");
    var firstStr = parts[0].trim();
    var secondStr = parts[1].trim();
    var completeCompanyAddress=firstStr+"Yusuf Sarai,\n"+secondStr;
    String image_Str=viewIdCardModelResponse.data?.employeeImagePath;
    //String image_Str="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";

    setState(()  {

      companyName=viewIdCardModelResponse.data?.companyName;
      companyAddress=completeCompanyAddress;
      empName=viewIdCardModelResponse.data?.employeeName;
      empDesignation=viewIdCardModelResponse.data?.designation;
      empId=viewIdCardModelResponse.data?.empId;
      empMobile=viewIdCardModelResponse.data?.mobile;
      checkRoleType=viewIdCardModelResponse.data?.jobType;

      print("show the checkRoleType $checkRoleType");

      if(checkRoleType=="Regular")
      {
        //regular
        empIdTitle="Emp ID#:";
        empSinceDate=viewIdCardModelResponse.data?.dateOfJoining;

        /*--------------11-11-2021 start--------------*/

        if (image_Str=="")
        {

          if (genderType_Name=="Male")
          {
            genderType_icon=getCJHub_MaleIcon;
            setState(() {
              genderType_icon=genderType_icon;
            });

          }
          else
          {
            genderType_icon=getCJHub_FemaleIcon;
            setState(() {
              genderType_icon=genderType_icon;
            });

          }

          profileImage_Visiblity_Default=true;
          profileImage_Visiblity_Dynamic=false;

        }else
        {

          profile_ImageURL=viewIdCardModelResponse.data?.employeeImagePath;
          profileImage_Visiblity_Default=false;
          profileImage_Visiblity_Dynamic=true;

        }

        /*--------------11-11-2021 end--------------*/


      }else {
        //contractual

        /*-------14-10-2022 start----------*/
        empIdTitle="CJ ID:";
        cjCode=viewIdCardModelResponse.data?.cjCode;

        /*-------14-10-2022 end----------*/

        careManagerName = viewIdCardModelResponse.data?.careManagerName;
        clientName = viewIdCardModelResponse.data?.clientName;
        postingLocation = viewIdCardModelResponse.data?.postingLocation;
        validPeriod = viewIdCardModelResponse.data?.validPeriod;

        /*--------------11-11-2021 start--------------*/

        if (image_Str=="")
        {

          if (genderType_Name=="Male")
          {
            genderType_icon=getCJHub_MaleIcon;
            setState(() {
              genderType_icon=genderType_icon;
            });

          }
          else
          {
            genderType_icon=getCJHub_FemaleIcon;
            setState(() {
              genderType_icon=genderType_icon;
            });

          }
          profileImage_Visiblity_Default=true;
          profileImage_Visiblity_Dynamic=false;
        }
        else
        {
          profile_ImageURL=viewIdCardModelResponse.data?.employeeImagePath;
          profileImage_Visiblity_Default=false;
          profileImage_Visiblity_Dynamic=true;
        }
        /*---------12-11-2021 start--------*/
        if(viewIdCardModelResponse.data!.careManagerSign=="")
        {
          careSignature_Visibility=false;

        }else
        {
          careSignIn_imagePath=viewIdCardModelResponse.data!.careManagerSign;
          careSignature_Visibility=true;
        }
        /*---------12-11-2021 end--------*/

        /*--------------11-11-2021 end--------------*/

      }

    });
  }




  /*---------------Commented end ok alert dialog---------------*/

/*---------hit view id card details start 15/7/2021-----*/

  Future<void> _create_RegularEmp_PDF(String caseType) async
  {

    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawImage(
        PdfBitmap(await _readImageData(getCJHub_AkalLogo)),
        Rect.fromLTWH(210, 110, 100, 50));


    /* page.graphics.drawImage(
         PdfBitmap(await _readImageData(genderType_icon)),
         Rect.fromLTWH(218, 240, 90, 100));*/

    /*---------------11-11-2021 start---------------*/
    if (_card_modelResponse!.data!.employeeImagePath=="")
    {

      if (genderType_Name=="Male")
      {
        genderType_icon=getCJHub_MaleIcon;
      }
      else
      {
        genderType_icon=getCJHub_FemaleIcon;
      }

      page.graphics.drawImage(
          PdfBitmap(await _readImageData(genderType_icon)),
          Rect.fromLTWH(218, 240, 90, 100));
    }
    else
    {
      genderType_icon=_card_modelResponse!.data!.employeeImagePath;

      page.graphics.drawImage(
          PdfBitmap(base64Decode(genderType_icon)),
          Rect.fromLTWH(218, 240, 90, 100));
    }

    /*---------------11-11-2021 end---------------*/



    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 15),
        cellPadding: PdfPaddings(left: 5, right: 5, top: 2));

    grid.columns.add(count: 1);

    PdfGridRow row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 15),
        textBrush: PdfBrushes.skyBlue,
        cellPadding: PdfPaddings(top:60)
    );
    row.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,);
    row.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[0].value = '';



    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 16,style: PdfFontStyle.bold),
        cellPadding: PdfPaddings(top:15)
    );
    row.cells[0].style.borders = PdfBorders(
      top: PdfPens.transparent,
      bottom:PdfPens.transparent, );
    row.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[0].value = companyName;


    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 10),
    );
    row.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      top:PdfPens.transparent,);
    row.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[0].value = companyAddress;

//"Jet Air House,Community Centre, Yusuf Sarai,""\nNew Delhi, Delhi 110049. Ph: 011-46503545"
    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(top:120),
      textBrush: PdfBrushes.gray,
    );
    row.cells[0].style.borders = PdfBorders(
      top: PdfPens.transparent,
      bottom: PdfPens.transparent,);
    row.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[0].value = '';

    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 15,style: PdfFontStyle.bold),
    );
    row.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      top: PdfPens.transparent,);
    row.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[0].value = empName;


    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 13),
    );
    row.cells[0].style.borders = PdfBorders(
      top: PdfPens.transparent,
      bottom: PdfPens.transparent,
    );
    row.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[0].value = empDesignation;



    PdfGrid grid1 = PdfGrid();
    grid1.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 15),
        cellPadding: PdfPaddings(left: 5, right: 5, top: 2));

    grid1.columns.add(count: 2);

    PdfGridRow row1 = grid1.rows.add();
    row1.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 14,style: PdfFontStyle.bold),
    );
    row1.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      top: PdfPens.transparent,
      right:PdfPens.transparent, );
    row1.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 14),
    );
    row1.cells[1].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      top: PdfPens.transparent,
      left:PdfPens.transparent, );
    grid1.columns[0].width = 148;
    row1.cells[0].stringFormat.alignment = PdfTextAlignment.right;
    row1.cells[1].stringFormat.alignment = PdfTextAlignment.left;
    row1.cells[0].value = empIdTitle;
    row1.cells[1].value = empId;

    row1 = grid1.rows.add();
    row1.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 14,style: PdfFontStyle.bold),
    );
    row1.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      top: PdfPens.transparent,
      right:PdfPens.transparent, );
    row1.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 14),
    );
    row1.cells[1].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      top: PdfPens.transparent,
      left:PdfPens.transparent, );
    row1.cells[0].stringFormat.alignment = PdfTextAlignment.right;
    row1.cells[1].stringFormat.alignment = PdfTextAlignment.left;
    row1.cells[0].value = 'Employee Since:';
    row1.cells[1].value = empSinceDate;


    PdfGrid grid2 = PdfGrid();
    grid2.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 15),
        cellPadding: PdfPaddings(left: 5, right: 5, top: 2));

    grid2.columns.add(count: 2);

    PdfGridRow row2 = grid2.rows.add();
    row2.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 14,style: PdfFontStyle.bold),
    );
    row2.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      top: PdfPens.transparent,
      right:PdfPens.transparent, );
    row2.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 14),
    );
    row2.cells[1].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      top: PdfPens.transparent,
      left:PdfPens.transparent, );
    grid2.columns[0].width = 118;
    row2.cells[0].stringFormat.alignment = PdfTextAlignment.right;
    row2.cells[1].stringFormat.alignment = PdfTextAlignment.left;
    row2.cells[0].value = 'Mob:';
    row2.cells[1].value = empMobile;



    row2 = grid2.rows.add();
    row2.cells[0].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 14,style: PdfFontStyle.bold),
    );
    row2.cells[0].style.borders = PdfBorders(
      bottom: PdfPen(PdfColor(50,	170,	224), width: 4),
      top: PdfPens.transparent,
      right:PdfPens.transparent, );
    row2.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 14),
    );
    row2.cells[1].style.borders = PdfBorders(
      bottom: PdfPen(PdfColor(50,	170,	224), width: 4),
      top: PdfPens.transparent,
      left:PdfPens.transparent, );
    row2.cells[0].stringFormat.alignment = PdfTextAlignment.right;
    row2.cells[1].stringFormat.alignment = PdfTextAlignment.left;
    row2.cells[0].value = '';
    row2.cells[1].value = '';



    grid.draw(
        page: page,bounds: Rect.fromLTWH(
        130, 90, 400, 0));
    grid1.draw(
        page: page,bounds: Rect.fromLTWH(
        130, 393, 400, 0));
    grid2.draw(
        page: page,bounds: Rect.fromLTWH(
        130, 438, 400, 0));


    List<int> bytes = await document.save();
    document.dispose();

    saveAndLaunchFile(bytes, getPdf_FileName(),caseType);
  }

  String getPdf_FileName()
  {
    String pdfFileName = "Akal_"+empName+"_IdCard"+".pdf";
    return pdfFileName;

  }

  Future<Uint8List> _readImageData(String name) async {
    //final data = await rootBundle.load('assets/$name');
    final data = await rootBundle.load('$name');

    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> _create_ContractualEmp_PDF(String caseType) async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    /* page.graphics.drawImage(
        PdfBitmap(await _readImageData(genderType_icon)),
        Rect.fromLTWH(85, 199, 90, 100));*/

    /*---------------11-11-2021 start---------------*/
    if (_card_modelResponse!.data!.employeeImagePath=="")
    {

      if (genderType_Name=="Male")
      {
        genderType_icon=getCJHub_MaleIcon;
      }
      else
      {
        genderType_icon=getCJHub_FemaleIcon;
      }

      page.graphics.drawImage(
          PdfBitmap(await _readImageData(genderType_icon)),
          Rect.fromLTWH(80, 190, 90, 100));
    }
    else
    {
      genderType_icon=_card_modelResponse!.data!.employeeImagePath;

      page.graphics.drawImage(
          PdfBitmap(base64Decode(genderType_icon)),
          Rect.fromLTWH(80, 190, 90, 100));
    }

    //careManagerName = _card_modelResponse.data.careManagerName;
    //careSignIn_imagePath = _card_modelResponse.data.careManagerSign;

    /*---------------11-11-2021 end---------------*/

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 15),
        cellPadding: PdfPaddings(left: 5, right: 5, top: 2));

    grid.columns.add(count: 2);
    PdfGridRow row = grid.rows.add();
    grid.columns[0].width = 100;
    row.cells[1].style = PdfGridCellStyle(
        backgroundBrush: new PdfSolidBrush(new PdfColor(50,	170,	224)),
        textBrush: PdfBrushes.white,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 16,style: PdfFontStyle.bold),
        cellPadding: PdfPaddings(top:5,left: 5)
    );
    row.cells[0].style = PdfGridCellStyle(
        backgroundBrush: new PdfSolidBrush(new PdfColor(50,	170,	224)),
        cellPadding: PdfPaddings(left: 10,right: 10)
    );
    row.cells[1].style.borders = PdfBorders(
      bottom: PdfPen(PdfColor(50,	170,	224)),
      left: PdfPen(PdfColor(50,	170,	224)),
      top: PdfPen(PdfColor(50,	170,	224)),
      right: PdfPen(PdfColor(50,	170,	224)),
    );
    row.cells[0].style.borders = PdfBorders(
      bottom: PdfPen(PdfColor(50,	170,	224)),
      left: PdfPen(PdfColor(50,	170,	224)),
      top: PdfPen(PdfColor(50,	170,	224)),
      right: PdfPen(PdfColor(50,	170,	224)),
    );
    // grid.rows[0].height = 100;
    row.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[0].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    row.cells[0].rowSpan = 2;
    row.cells[0].value = PdfBitmap(await _readImageData(getCJHub_AkalLogoWhite));
    row.cells[1].value = companyName;


    row = grid.rows.add();
    row.cells[1].style = PdfGridCellStyle(
        backgroundBrush: new PdfSolidBrush(new PdfColor(50,	170,	224)),
        textBrush: PdfBrushes.white,
        font: PdfStandardFont(PdfFontFamily.helvetica, 11),
        cellPadding: PdfPaddings(left: 5)
    );
    row.cells[1].style.borders = PdfBorders(
      bottom: PdfPen(PdfColor(50,	170,	224)),
      left: PdfPen(PdfColor(50,	170,	224)),
      right: PdfPen(PdfColor(50,	170,	224)),
      top: PdfPen(PdfColor(50,	170,	224)),
    );
    grid.columns[0].width = 100;
    // row.cells[0].value = '';
    row.cells[1].value = companyAddress;

    PdfGrid grid1 = PdfGrid();
    grid1.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        cellPadding: PdfPaddings(left: 5, right: 5, top: 2));

    grid1.columns.add(count: 3);
    PdfGridRow row1 = grid1.rows.add();
    row1.cells[0].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(top: 17),
    );
    row1.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      right: PdfPens.transparent,
      top: PdfPen(PdfColor(50,	170,	224)),);
    row1.cells[1].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(top: 17),
    );
    row1.cells[1].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      top: PdfPen(PdfColor(50,	170,	224)),
      right: PdfPens.transparent,);
    row1.cells[2].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(top: 17),
    );
    row1.cells[2].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      top: PdfPen(PdfColor(50,	170,	224)),);
    grid1.columns[0].width = 120;
    // grid.rows[0].height = 100;
    row1.cells[0].rowSpan = 8;
    row1.cells[0].value = '';
    row1.cells[1].value = '';
    row1.cells[2].value = '';

    row1 = grid1.rows.add();
    grid1.columns[0].width = 120;
    grid1.columns[1].width = 75;
    row1.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 12,style: PdfFontStyle.bold),
    );
    row1.cells[1].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      right:  PdfPens.transparent,
      top: PdfPens.transparent,);
    row1.cells[2].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      top: PdfPens.transparent,);
    // grid1.columns[2].width = 150;
    // row.cells[0].value = '';
    row1.cells[1].value = "Name:";
    row1.cells[2].value = empName;

    row1 = grid1.rows.add();
    grid1.columns[0].width = 120;
    row1.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 12,style: PdfFontStyle.bold),
    );
    row1.cells[1].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      right:  PdfPens.transparent,
      top: PdfPens.transparent,);
    row1.cells[2].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      top: PdfPens.transparent,);
    // row.cells[0].value = '';
    row1.cells[1].value = "Desi:";
    row1.cells[2].value = empDesignation;

    row1 = grid1.rows.add();
    grid1.columns[0].width = 120;
    row1.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 12,style: PdfFontStyle.bold),
    );
    row1.cells[1].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      right:  PdfPens.transparent,
      top: PdfPens.transparent,);
    row1.cells[2].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      top: PdfPens.transparent,);
    // row.cells[0].value = '';
    row1.cells[1].value = empIdTitle;
    row1.cells[2].value = cjCode;

    row1 = grid1.rows.add();
    grid1.columns[0].width = 120;
    row1.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 12,style: PdfFontStyle.bold),
    );
    row1.cells[1].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      right:  PdfPens.transparent,
      top: PdfPens.transparent,);
    row1.cells[2].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      top: PdfPens.transparent,);
    // row.cells[0].value = '';
    row1.cells[1].value = "Client:";
    row1.cells[2].value = clientName;



    row1 = grid1.rows.add();
    grid1.columns[0].width = 120;
    row1.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 12,style: PdfFontStyle.bold),
    );
    row1.cells[1].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      right:  PdfPens.transparent,
      top: PdfPens.transparent,);
    row1.cells[2].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      top: PdfPens.transparent,);
    // row.cells[0].value = '';
    row1.cells[1].value = "Working Location:";
    row1.cells[2].value = postingLocation;


    row1 = grid1.rows.add();
    grid1.columns[0].width = 120;
    row1.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 12,style: PdfFontStyle.bold),
    );
    row1.cells[1].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      right:  PdfPens.transparent,
      top: PdfPens.transparent,);
    row1.cells[2].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      top: PdfPens.transparent,);
    // row.cells[0].value = '';
    row1.cells[1].value = "Valid Period:";
    row1.cells[2].value = validPeriod;

    row1 = grid1.rows.add();
    grid1.columns[0].width = 120;
    row1.cells[1].style = PdfGridCellStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 12,style: PdfFontStyle.bold),
    );
    row1.cells[1].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      right:  PdfPens.transparent,
      top: PdfPens.transparent,);
    row1.cells[2].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      top: PdfPens.transparent,);
    // row.cells[0].value = '';
    row1.cells[1].value = "Mob:";
    row1.cells[2].value = empMobile;


    row1 = grid1.rows.add();
    grid1.columns[0].width = 120;
    row1.cells[0].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(top: 20),
    );
    row1.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      right: PdfPens.transparent,
      top: PdfPens.transparent,);
    row1.cells[1].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(top: 20),
    );
    row1.cells[1].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      right: PdfPens.transparent,
      left: PdfPens.transparent,
      top: PdfPens.transparent,);
    row1.cells[2].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(top: 20),
    );
    row1.cells[2].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      top: PdfPens.transparent,);
    row1.cells[0].value = '';
    row1.cells[1].value = "";
    row1.cells[2].value = "";

    row1 = grid1.rows.add();
    grid1.columns[0].width = 120;
    row1.cells[0].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(left: 0),
    );
    row1.cells[0].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      right: PdfPens.transparent,
      top: PdfPens.transparent,);
    row1.cells[1].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      right: PdfPens.transparent,
      top: PdfPens.transparent,);
    row1.cells[2].style.borders = PdfBorders(
      bottom: PdfPens.transparent,
      left: PdfPens.transparent,
      top: PdfPens.transparent,);

/*---------------12-11-2021 start-----------------------*/
    /* row1.cells[0].value = PdfBitmap(await _readImageData('signature.png'));
    row1.cells[1].value = "";
    row1.cells[2].value = "";*/


    if(careSignIn_imagePath=="")
    {
      careSignIn_imagePath=getCJHub_Signature;
      row1.cells[0].value = PdfBitmap(await _readImageData(getCJHub_Signature));

    }else
    {
      careSignIn_imagePath=careSignIn_imagePath;
      final imgBase64Str = await networkImageToBase64(careSignIn_imagePath);
      //row1.cells[0].value = PdfBitmap.fromBase64String(imgBase64Str);
      page.graphics.drawImage(
          PdfBitmap.fromBase64String(imgBase64Str!),
          Rect.fromLTWH(80, 320, 90, 50));

    }

    row1.cells[1].value = "";
    row1.cells[2].value = "";
/*---------------12-11-2021 end-----------------------*/

    row1 = grid1.rows.add();
    grid1.columns[0].width = 120;
    row1.cells[0].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(bottom: 20,left: 5,top: 5),
    );
    row1.cells[0].style.borders = PdfBorders(
      bottom: PdfPen(PdfColor(50,	170,	224), width: 4),
      right: PdfPens.transparent,
      top: PdfPens.transparent,);
    row1.cells[1].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(bottom: 20),
    );
    row1.cells[1].style.borders = PdfBorders(
      bottom: PdfPen(PdfColor(50,	170,	224), width: 4),
      left: PdfPens.transparent,
      right: PdfPens.transparent,
      top: PdfPens.transparent,);
    row1.cells[2].style = PdfGridCellStyle(
      cellPadding: PdfPaddings(bottom: 20),
    );
    row1.cells[2].style.borders = PdfBorders(
      bottom: PdfPen(PdfColor(50,	170,	224), width: 4),
      left: PdfPens.transparent,
      top: PdfPens.transparent,);
    row1.cells[0].value = careManagerName;
    row1.cells[1].value = "";
    row1.cells[2].value = "";



    grid.draw(
        page: page,bounds: Rect.fromLTWH(
        70, 90, 420, 0));
    grid1.draw(
        page: page,bounds: Rect.fromLTWH(
        70, 170, 420, 0));


    List<int> bytes = await document.save();
    document.dispose();

    saveAndLaunchFile(bytes, getPdf_FileName(),caseType);
  }
  Future<String?> networkImageToBase64(String imageUrl) async
  {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }


}