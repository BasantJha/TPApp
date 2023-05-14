import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;

import '../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../CustomView/CJHubCustomView/AutoLogout.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJHubCustomView/NetworkStatus/NetworkReachability.dart';
import '../../../../CustomView/CJHubCustomView/SalaryYearMonth_List.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../Services/AESAlgo/encrypt.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../Services/Messages/Message.dart';
import '../../ModelClasses/CJHubModelClasses/SalaryStatus_ModelResponse.dart';
import 'Insurance_PDFViewer.dart';
import 'ViewInsuranceCard_ModelResponse.dart';
import 'insurance_addInsurancePolicy.dart';
import 'insurance_editInsurancePolicy.dart';

// import "package:flutter/material.dart" if (dart.library.html)  "package:flutter_web/material.dart";

import 'package:universal_html/html.dart' as html;

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
      home: insurance_ViewInsuranceCard(title: 'CJ Hub'),
    );
  }
}
class insurance_ViewInsuranceCard extends StatefulWidget {

  insurance_ViewInsuranceCard({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _insurance_ViewInsuranceCard createState() => _insurance_ViewInsuranceCard();
}

class _insurance_ViewInsuranceCard extends State<insurance_ViewInsuranceCard> {
  // This widget is the root of your application.


  String completeEmpCode="";
  String empName="",bankName="",validFromDate="",
      validToDate="",totalMembers="",policyNumber="";

  //28-12-2021 start

  String third_party_document_path="";
  bool visibility_third_party_document_path=false;

  //28-12-2021 end

  String insuranceCard_Status="Active";
  //Color ff=Color.

  TextStyle textStyle_insuranceCardStatus=TextStyle(color: Colors.green,fontSize: 12,fontWeight: FontWeight.bold);
  BoxDecoration boxDecoration__insuranceCardStatus=BoxDecoration(
      color: Colors.green,
      shape: BoxShape.circle
  );

  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(!networkStatus){
      print("Api salary status should be called");
      insuranceCardRequest();
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

    getInsuranceRequestApi();
  }


  SingleChildScrollView mainFunction_UI(){
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        // create_headingContainer("Insurance"),

        create_insuranceBannerContainer(),

        create_text("YOUR INSURANCE DETAILS ARE AS UNDER"),

        create_cardContainer(),

        SizedBox(
          height: 20,
        ),

        Visibility(
          visible: visibility_third_party_document_path,
          child:create_Button() ,)



      ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar:CJAppBar(getCJHUB_InsuranceTitle, appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action type");
          Navigator.pop(context);

        })),
        body: WillPopScope(
          child: Responsive(
            mobile: mainFunction_UI(),
            tablet: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: insurance_tabletWidth,
                child: mainFunction_UI(),
              ),
            ),
            desktop: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: insurance_desktopWidth,
                child: mainFunction_UI(),
              ),
            ),
          ),
          /*onWillPop: ()
          {
            Message.alert_dialogAppExit(context);

          } ,*/
          onWillPop: () async => false,
        )
    );
  }

  Container create_headingContainer(String value){
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
            Expanded(
              flex: 1,
              child: Text(value,
                style: TextStyle(color: Colors.black,fontSize: 17),),
            ),
          ],
        ),
      ),
    );
  }

  Container create_insuranceBannerContainer(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30,20,30,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset(getCJHub_InsuranceIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container create_text(String value){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30,15,30,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child:Text(value,
                style: TextStyle(color: primaryColor,fontSize: 14,fontWeight: FontWeight.bold),),
            )

          ],
        ),
      ),
    );
  }

  Container create_cardContainer(){
    return Container(
        height: 160.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30,7,30,0),
          child: new Stack(
              children: <Widget>[
                Container(
                  height: 160.0,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: new BorderRadius.circular(8.0),
                      border: Border.all(color: twoHunGreyColor,
                          width: 1.0,
                          style: BorderStyle.solid)
                  ),
                  child:  IntrinsicHeight(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Container(
                                      width: 100,
                                      // color: Colors.yellow,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 115.0,
                                            child: Image.asset(getCJHub_DilIcon,
                                            ),

                                          ),
                                        ],
                                      ),
                                        ),

                                     Expanded(
                                       flex: 1,
                                       child: Container(
                                         width: 230,
                                         // color: Colors.cyan,
                                         child: Column(
                                           children: [

                                             create_Active(),
                                             SizedBox(
                                               height: 10,
                                             ),
                                             create_NameText(empName),
                                             SizedBox(
                                               height: 5,
                                             ),
                                             create_EmpBankText(bankName),
                                             SizedBox(
                                               height: 5,
                                             ),
                                             create_vaildFromToMember(),

                                           ],
                                         ),
                                       ),
                                     ),

                                  ]),

                            create_PolicyNumber("Policy Number:"),

                          ]),
                    ),


                ),
              ]
          ),
        )


    );
  }

  Container create_Active()
  {
    return Container(
        child:Padding(
          padding: const EdgeInsets.only(top: 5,right: 9),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height:10,
                width: 10,
                decoration: boxDecoration__insuranceCardStatus,
              ),
              SizedBox(
                width: 4,
              ),
              Padding(padding: const EdgeInsets.only(top: 4),
                child: Text(insuranceCard_Status,style: textStyle_insuranceCardStatus,
                ),
              )

            ],
          ),
        )
    );
  }


  Container create_NameText(String value){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child:Padding(
                padding: const EdgeInsets.only(left: 3),
                child:Text(value,
                  style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
              )

          )

        ],
      ),
    );
  }
  Container create_EmpBankText(String value){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child:Padding(
                padding: const EdgeInsets.only(left: 3),
                child:Text(value,
                  style: TextStyle(color: Colors.black,fontSize: 12),),
              )

          )

        ],
      ),
    );
  }



  Container create_vaildFromToMember(){
    return Container(
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: const EdgeInsets.only(left: 3),
                        child:Text(
                          "Valid From",textAlign: TextAlign.center,
                          style: new TextStyle(fontSize: 9.0),
                        ),
                      ),

                      Padding(padding: const EdgeInsets.only(left: 3),
                        child:Text(
                          validFromDate,textAlign: TextAlign.center,
                          style: new TextStyle(color: Colors.black,fontSize: 9.0,fontWeight: FontWeight.bold),
                        ),
                      ),

                    ],
                  ),
                ),

                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(
                        "Valid To",textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 9.0),
                      ),

                      Text(
                        validToDate,textAlign: TextAlign.center,
                        style: new TextStyle(color: Colors.black,fontSize: 9.0,fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),
                ),

                Container(
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Padding(padding: const EdgeInsets.only(right: 5),
                        child:Text(
                          "Members",textAlign: TextAlign.center,
                          style: new TextStyle(fontSize: 9.0),
                        ) ,
                      ),

                      Text(
                        totalMembers,textAlign: TextAlign.center,
                        style: new TextStyle(color: Colors.black,fontSize: 9.0,fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),
                )

              ],
            ),
          ),

        ],
      ),

    );
  }

  Container create_PolicyNumber(String value){
    return Container(
      // color: Colors.orange,
        child:Padding(
          padding: const EdgeInsets.only(left: 5,bottom: 7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Text(value,
                style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
              SizedBox(
                width: 4,
              ),
              Text(policyNumber,
                style: TextStyle(color: Colors.black,fontSize: 14),),

            ],
          ),
        )

    );
  }

  Material create_Button(){
    return Material(
      elevation: 0.0,
      borderRadius: BorderRadius.circular(5.0),
      color: primaryColor,
      child:MaterialButton(
          minWidth: 180,
          height: 40,
          padding: EdgeInsets.only(left:20,right: 20),
          onPressed: ()
          {
            //download code here....

            if(kIsWeb){

              // //print('web');

              // html.AnchorElement anchorElement = html.AnchorElement(href: third_party_document_path,);
              // anchorElement.download = "InsurancePolicy.pdf"; //in my case is .pdf
              // anchorElement.click();

              html.window.open(third_party_document_path,'document fileName');

              // Navigator.push(context, MaterialPageRoute(builder: (context) => Insurance_WEB_PDFViewer(pdfURL: third_party_document_path,)),);

            }
            else{
              // //print('mobile');

              Navigator.push(context, MaterialPageRoute(builder: (context) => Insurance_PDFViewer(pdfURL: third_party_document_path,)),);

            }

          },
          child: Text('Download Policy',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 13))

      ),
    );
  }


 void checkNetworkConnection(dynamic hasConnection)
  {
    if(mounted){
      setState(() {
        networkStatus = !hasConnection;
      });
    }
    if(!networkStatus){
      print("Api should be called");
      insuranceCardRequest();
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
          insuranceCardRequest()
        }
      else
        {
          //print('please check the network status'),
          showNetworConnectionAlert()
        }
    });*/
    // insuranceCardRequest();
  }

  insuranceCardRequest()
  {

    String mobileNumber_key="",empCode_key="",
        empDateOfBirth_key="";

    SharedPreference.getEmpMobileNo().then((value) =>  {
      mobileNumber_key=value,
      // //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpCode().then((value) =>  {
      empCode_key=value,
      // //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth_key=value,
      // //print('show emp name2 $value'),
      completeEmpCode = mobileNumber_key+"CJHUB"+empCode_key+"CJHUB"+empDateOfBirth_key,
      this.getInsuranceRequestApi()


    });


  }


  // ignore: non_constant_identifier_names
  getInsuranceRequestApi() async
  {

    //completeEmpCode="9569734648CJHUB5610CJHUB14/05/1988";

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.get_Emp_Insurance_Card),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'emp_code': getEncrypted_EmpCode(completeEmpCode)
        },
      );
      // //print(response.statusCode);
      if (response.statusCode == 200)
      {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        // //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        ViewInsuranceCard_ModelResponse  viewInsuranceCard_ModelResponse= ViewInsuranceCard_ModelResponse.fromJson(jsonDecode(serverResponse));


        if(viewInsuranceCard_ModelResponse.statusCode==true)
        {
          setState(() {
            empName=viewInsuranceCard_ModelResponse.data?.empName;
            bankName=viewInsuranceCard_ModelResponse.data?.insuranceCompanyName;
            validFromDate=viewInsuranceCard_ModelResponse.data?.policyStartDate;
            validToDate=viewInsuranceCard_ModelResponse.data?.policyEndDate;
            totalMembers=viewInsuranceCard_ModelResponse.data?.memberCount;
            policyNumber=viewInsuranceCard_ModelResponse.data?.policyNo;

            /*------------28-12-2021 start---------------*/
            third_party_document_path=viewInsuranceCard_ModelResponse.data?.thirdPartyDocumentPath;
            /*if(third_party_document_path == "" || third_party_document_path == null)
                {
                  visibility_third_party_document_path=false;
                }
               else
                {
                  visibility_third_party_document_path=true;

                }*/
            /*------------28-12-2021 end---------------*/


            /*--------------26-5-2022 START-------------------*/

            //validToDate="25 May 2022";
            String getInsuranceCardExpired_EndDate_ValidFormat=Method.changeTheDateFormat_ForInsuranceIdCardExpiredDate(validToDate);
            String currentDate=Method.getTheCurrentDate_ForInvestmentDeclaration();

            if (int.parse(getInsuranceCardExpired_EndDate_ValidFormat)>=(int.parse(currentDate)))
            {
              insuranceCard_Status="Active";
              textStyle_insuranceCardStatus=TextStyle(color: Colors.green,fontSize: 12,fontWeight: FontWeight.bold);
              boxDecoration__insuranceCardStatus=BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle
              );
              if(third_party_document_path == "" || third_party_document_path == null)
              {
                visibility_third_party_document_path=false;
              }
              else
              {
                visibility_third_party_document_path=true;
              }

            }
            else
            {
              insuranceCard_Status="Expired";
              textStyle_insuranceCardStatus=TextStyle(color: Colors.red,fontSize: 12,fontWeight: FontWeight.bold);
              boxDecoration__insuranceCardStatus=BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle
              );
              visibility_third_party_document_path=false;

            }

            /*--------------26-5-2022 END-------------------*/




          });
        }
        else
        {
          if (viewInsuranceCard_ModelResponse.message==null)
          {
            Method.snackBar_OkText(context, "server error!");

            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, viewInsuranceCard_ModelResponse.message);

            // show_OKAlert(viewInsuranceCard_ModelResponse.message);
          }
        }
        //return _verify_mobile_modelResponse;

      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      // //print(e);
    }
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
  show_OKAlert(String message)
  {

    /*------SnackBar-----21-07-2022--------start-----------*/

    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    /*-----SnackBar------21-07-2022--------end-----------*/

    /*-----AlertDialog------start----------------------*/

  /*  var alertDialog = AlertDialog(
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