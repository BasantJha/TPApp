import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;
import '../../../../Constant/Constants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/CJHubCustomView/AutoLogout.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJHubCustomView/NetworkStatus/NetworkReachability.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../Services/AESAlgo/encrypt.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../Services/Messages/Message.dart';


import '../../ModelClasses/CJHubSupportModelClass/HrConnect_PendingQuery_ModelResponse.dart';
import 'HrConnect_ClosedThread.dart';


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
      home: HrConnect_closedquery(title: 'CJ Hub'),
    );
  }
}

class HrConnect_closedquery extends StatefulWidget {

  HrConnect_closedquery({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HrConnect_closedquery createState() => _HrConnect_closedquery();
}

class _HrConnect_closedquery extends State<HrConnect_closedquery> {
  // This widget is the root of your application.

  bool _Togglevisible = false;

  String empCode="";
  String completeEmpCode="";
  //List<Queries> pendingQueryList=[Queries(queryMasterId: 1,createdon: "24 Sep 2021",subject: "Increment",subjectDesc: "Testing")];
  List<Queries> pendingQueryList=[];

  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;

  @override
  void initState() {
    super.initState();

    if(!networkStatus){
      print("Api salary status should be called");
      get_ClosedQueryRequest();
      EasyLoading.dismiss();
    }
    else{
      print("Api salary status should not be called");
      EasyLoading.show(status: Message.get_LoaderMessage);
      Method.snackBar_OkText(context, 'No Internet Connection');

    }
    print(" Inside Test Widget 2");

   /* WidgetsBinding.instance.addPostFrameCallback((_) {
      NetworkReachability connectionStatus = NetworkReachability.getInstance();

      _connectionChangeStream =
          connectionStatus.connectionChange.listen(checkNetworkConnection);
    });*/
    // checkNetworkConnection();

    if(kIsWeb){

      //print("This CJ Hub Web");

      //AutoLogout.initializeTimer(context);

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

    //print("HR Connect_Closed query resetTimer:");

    AutoLogout.initializeTimer(context);
  }

  @override
  Widget build(BuildContext context)
  {
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handleUserInteraction,
        onPointerMove: _handleUserInteraction,
        onPointerUp: _handleUserInteraction,
        child:
      Scaffold(
      body: Container(
          child:Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child:
                    ListView.builder(
                        itemCount: pendingQueryList.length,
                        itemBuilder: (BuildContext context, int index)
                        {
                          //HRData data = pendingQueryList[index];

                          String queryId=pendingQueryList[index].queryMasterId.toString();
                          String createdDate=pendingQueryList[index].createdon.toString();
                          String subjectName=pendingQueryList[index].subject.toString();
                          String queryComment=pendingQueryList[index].queryComment.toString();

                          return
                            Container(
                              child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                      color: Color(0xFF757575),
                                      width: 0.5,
                                    ),
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(10),
                                    child:  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        Container(
                                            child:Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child:Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width * 0.4,
                                                      child: Text('Query ID',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.blue
                                                        ),),
                                                    ),
                                                  ),

                                                  Expanded(
                                                    flex: 1,
                                                    child:  Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width * 0.4,
                                                      child: Text(queryId,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // fontWeight: FontWeight.bold
                                                        ),),
                                                    ),)


                                                ],
                                              ),
                                            )

                                        ),

                                        Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width * 0.4,
                                                      child: Text('Created Date',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.blue
                                                        ),),
                                                    ),
                                                  ),

                                                  Expanded(
                                                    flex: 1,
                                                    child:  Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width * 0.4,
                                                      child: Text(createdDate,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // fontWeight: FontWeight.bold
                                                        ),),
                                                    ),)


                                                ],
                                              ),
                                            )

                                        ),

                                        Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width * 0.4,
                                                      child: Text('Subject',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.blue
                                                        ),),
                                                    ),
                                                  ),

                                                  Expanded(
                                                    flex: 1,
                                                    child:  Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width * 0.4,
                                                      child: Text(subjectName,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // fontWeight: FontWeight.bold
                                                        ),),
                                                    ),)


                                                ],
                                              ),
                                            )

                                        ),

                                        Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 15),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [

                                                  Container(
                                                    child:
                                                    Text.rich(
                                                      TextSpan(
                                                          text: 'View & Reply',recognizer: TapGestureRecognizer()
                                                        ..onTap = ()
                                                        {
                                                          //print('click');


                                                          String queryId=pendingQueryList[index].queryMasterId.toString();

                                                          //print('show closed queryId $queryId');
                                                          SharedPreference.setSupportQueryId(queryId);


                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>

                                                          Responsive(
                                                              mobile: HrConnect_ClosedThread(),
                                                              tablet: Center(
                                                                child: Container(
                                                                  width: flutterWeb_tabletWidth,
                                                                  child: HrConnect_ClosedThread(),
                                                                ),
                                                              ),
                                                              desktop: Center(
                                                                child: Container(
                                                                  width: flutterWeb_desktopWidth,
                                                                  child: HrConnect_ClosedThread(),
                                                                ),
                                                              ))
                                                              // HrConnect_ClosedThread()
                                                          ));


                                                        },
                                                          style: TextStyle(
                                                            decoration: TextDecoration.underline,
                                                            decorationColor: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                            decorationThickness: 2,
                                                          )),
                                                    ),
                                                  ),



                                                ],
                                              ),
                                            )
                                        ),

                                      ],
                                    ),
                                  )

                              ),
                            );
                        }),

                  ))
            ],
          )

      ),
    ));

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
      get_ClosedQueryRequest();
      EasyLoading.dismiss();
    }
    else{
      print("Api should not be called");
      EasyLoading.show(status: Message.get_LoaderMessage);
      Method.snackBar_OkText(context, 'No Internet Connection');
    }
    print(" Inside Test Widget 2");

    /*NetworkReachability.networkConnectionStatus().then((networkStatus) =>
    {
      if(networkStatus)
        {
          get_ClosedQueryRequest()
        }
      else
        {
          //print('please check the network status'),
          showNetworConnectionAlert()
        }
    });*/

    // get_ClosedQueryRequest();
  }

  get_ClosedQueryRequest()
  {


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
      //loadData()
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth_key=value,
      //print('show emp name2 $value'),
      completeEmpCode = mobileNumber_key+"CJHUB"+empCode_key+"CJHUB"+empDateOfBirth_key,
      this.get_ClosedQueryWebApi()


    });

  }


  // ignore: non_constant_identifier_names
  get_ClosedQueryWebApi() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.get_HRConnect_PendingQuery),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'query_type':"Close"
        },
      );
      //print(response.statusCode);
      if (response.statusCode == 200)
      {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        HrConnect_PendingQuery_ModelResponse query_modelResponse = HrConnect_PendingQuery_ModelResponse.fromJson(jsonDecode(serverResponse));
        if(query_modelResponse.statusCode==true)
        {
          setState(()
          {
            pendingQueryList=query_modelResponse!.data!.queries!;

          });
        }
        else
        {
          if (query_modelResponse.message==null)
          {
            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, query_modelResponse!.message!);

            // show_OKAlert(query_modelResponse.message);
          }
        }
        //return _verify_mobile_modelResponse;

      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      //print(e);
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

  /*------------Comment show alert dialog----------start------*/
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
  //   /*var alertDialog = AlertDialog(
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
  //       context: context,
  //       builder: (BuildContext context) => alertDialog
  //
  //   );*/
  // }

/*------------Comment show alert dialog----------end------*/



}

