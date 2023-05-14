import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;

import '../../../../Constant/CJHub_ConstantIcon.dart';
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
import '../../ModelClasses/CJHubSupportModelClass/HrConnect_PendingThread_ModelResponse.dart';
import '../../ModelClasses/CJHubSupportModelClass/HrConnect_SaveMsg_ModelResponse.dart';
import 'ReceivedMessageWidget.dart';
import 'SendedMessageWidget.dart';



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
      home: HrConnect_PendingThread(title: 'CJ Hub'),
    );
  }
}

class HrConnect_PendingThread extends StatefulWidget {
  HrConnect_PendingThread({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HrConnect_PendingThread createState() => _HrConnect_PendingThread();
}


class _HrConnect_PendingThread extends State<HrConnect_PendingThread>
{
  TextEditingController _text = new TextEditingController();
  ScrollController _scrollController = ScrollController();
  var childList = <Widget>[];

  List<QueriesTrail>? queryListData;

  String empCode="";
  String completeEmpCode="",supportQueryId="",empIPAddress="",commentText="";
  String hintTextMessage="Type a message";


  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;

  @override
  void initState()
  {
    super.initState();

    // checkNetworkConnection();

    if(!networkStatus){
      print("Api salary status should be called");
      get_PendingThreadRequest();
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

    childList.add(Align(
        alignment: Alignment(0, 0),
        child: Container(
          margin: const EdgeInsets.only(top: 5.0),
          height: 25,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              )),
          child: Center(
              child: Text(
                "Today",
                style: TextStyle(fontSize: 11),
              )),
        )));

    if(kIsWeb){

      //print("This CJ Hub pending thread Web");

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

    //print("HrConnect ClosedThread resetTimer");

    AutoLogout.initializeTimer(context);
  }

  SafeArea mainFunction_UI(){
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                  height: 0,
                  color: Colors.black54,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                        controller: _scrollController,
                        // reverse: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: childList,
                        )),
                  ),
                ),
                // Divider(height: 0, color: Colors.black26),
                Container(
                  color: Colors.grey[300],
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: 20,
                      controller: _text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(padding: EdgeInsets.only(right: 10),
                              child: Material(
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(10.0),
                                color: primaryColor,
                                child:MaterialButton(
                                    minWidth: 50,
                                    // height: 10,
                                    onPressed: () {

                                      commentText =_text.text;

                                      if(commentText.trim().length>0) {
                                        save_PostCommentWebApi();
                                      }else
                                      {
                                        Method.snackBar_OkText(context, "Type correct message");
                                        // show_OKAlert("Type correct message");
                                      }
                                    },
                                    child: Text('Submit',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 13))
                                ),
                              ),
                            ),

                          ],
                        ),

                        contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                        hintText: hintTextMessage,
                        border:
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handleUserInteraction,
        onPointerMove: _handleUserInteraction,
        onPointerUp: _handleUserInteraction,
        child:
      Scaffold(
      appBar: AppBar(leading: BackButton(
          color: Colors.black
      ), backgroundColor: Color(0xfff0f0f2),centerTitle: true,
        title: Image.asset(getCJHub_AppLogo,height: 90,width: 90,),),
      body: Responsive(
        mobile: mainFunction_UI(),
          tablet: Align(
            alignment: Alignment.topCenter,
            child:  Container(
              width: size.width*support_tabletWidth,
              child: mainFunction_UI(),

            ),
          ) ,

          desktop: Center(
            child: Container(
              width: size.width*support_desktopWidth,

              child: mainFunction_UI(),
            ),
          )

    ))
    );
  }
// This widget is the root of your application.

 void checkNetworkConnection(dynamic hasConnection)
  {

    if(mounted){
      setState(() {
        networkStatus = !hasConnection;
      });
    }
    if(!networkStatus){
      print("Api should be called");
      get_PendingThreadRequest();
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
          get_PendingThreadRequest()
        }
      else
        {
          //print('please check the network status'),
          showNetworConnectionAlert()
        }
    });*/

    // get_PendingThreadRequest();
  }

  get_PendingThreadRequest()
  {

    SharedPreference.getSupportQueryId().then((value) =>  {

      supportQueryId=value,
      //print('show emp name2 $value'),
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
      //loadData()
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth_key=value,
      //print('show emp name2 $value'),
      completeEmpCode = mobileNumber_key+"CJHUB"+empCode_key+"CJHUB"+empDateOfBirth_key,
      this.get_PendingThreadWebApi()


    });
    Method.getIPAddress().then((value) => {
      empIPAddress=value

    });


  }


  // ignore: non_constant_identifier_names
  get_PendingThreadWebApi() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.get_HRConnect_PendingThread),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'query_id':getEncryptedData(supportQueryId)
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

        HrConnect_PendingThread_ModelResponse query_modelResponse = HrConnect_PendingThread_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(query_modelResponse.statusCode==true)
        {
          setState(()
          {
            childList = <Widget>[];
            _text.text="";

            queryListData=query_modelResponse.data?.queriesTrail;

            int i=0;
            for(i=0;i<queryListData!.length;i++)
            {
              var userType=queryListData![i].usertype;
              QueriesTrail OBJ=queryListData![i];
              //var check_isAcknowledged=queryListData[i].isAcknowledged;

              if(userType=="Employee")
              {
                //EMPLOYEE
                childList.add(Align(
                  alignment: Alignment(1, 0),
                  child: SendedMessageWidget(
                    content: OBJ.queryComment,
                    time: OBJ.createdon,
                  ),
                ));

              }
              else
              {
                childList.add(Align(
                  alignment: Alignment(-1, 0),
                  child: ReceivedMessageWidget(
                    content: OBJ.queryComment,
                    time: OBJ.createdon,
                  ),
                ));

                //HR
              }
            }

          });
        }
        else
        {
          if (query_modelResponse.message==null)
          {
            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {
            Method.snackBar_OkText(context, query_modelResponse.message!);

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

  save_PostCommentWebApi() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(


        Uri.parse(
            WebApi.get_HRConnect_SavePendingQuery_Trail),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },

        body: {
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'query_id': getEncryptedData(supportQueryId),
          'reply_status': "Open",
          'query_comment': commentText,
          'created_ip': empIPAddress,

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

        HrConnect_SaveMsg_ModelResponse  connect_saveMsg_ModelResponse = HrConnect_SaveMsg_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(connect_saveMsg_ModelResponse.statusCode==true)
        {
          //show_OKAlert(connect_saveMsg_ModelResponse.message);
          get_PendingThreadWebApi();

        }
        else
        {
          if (connect_saveMsg_ModelResponse.message==null)
          {
            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {
            Method.snackBar_OkText(context, connect_saveMsg_ModelResponse.message!);

            // show_OKAlert(connect_saveMsg_ModelResponse.message);
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
  //       TextButton(onPressed: ()
  //       {
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


}