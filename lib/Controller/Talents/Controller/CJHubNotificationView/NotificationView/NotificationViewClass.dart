
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;

import 'package:contractjobs/Controller/Talents/Controller/CJHubNotificationView/NotificationView/NotificationViewModelResponse.dart';

import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/Messages/Message.dart';


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
      home: NotificationViewClass(title: 'CJ Hub'),
    );
  }
}
class NotificationViewClass extends StatefulWidget {

  NotificationViewClass({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _NotificationViewClass createState() => _NotificationViewClass();
}

class _NotificationViewClass extends State<NotificationViewClass>
{
  // This widget is the root of your application.

  String completeEmpCode="",completeEmpJSId="";
  String financialYear="2021-22";

  //NotificationViewModelResponse notificationViewModelResponse=Data({invMessage: "",remarks: ""});

  List<Data> notificationListData=[Data(invMessage: "Notification not found",remarks: "Notification not found")];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBasicInfo();
  }

  ListView mainFunction_UI(){
    return ListView.builder(
        shrinkWrap: true,
        itemCount: notificationListData.length,
        itemBuilder: (BuildContext context, int index)
        {
          String invMessage = notificationListData[index]!.invMessage!;

          return   new Padding(padding: new EdgeInsets.only(top: 10,left: 10,right: 10),
              child:Card(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
                child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          child:  ListTile(
                            contentPadding: EdgeInsets.only(left: 5,right: 5),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex:1,
                                          child: Container(
                                              child:
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(invMessage,style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.black),),

                                              )
                                          ),),

                                      ],
                                    )
                                ),

                              ],
                            ),

                            // trailing:  Text(data.status,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),

                          ),
                        )

                      ],
                    )

                ),

              )
          );

        }
    );
  }



  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(leading: BackButton(
            color: Colors.black
        ), backgroundColor: Color(0xfff0f0f2),centerTitle: true,
          title: Image.asset('applogo.png',height: 90,width: 90,),),
        body: Responsive(
          mobile: mainFunction_UI(),
          tablet:
             mainFunction_UI(),

          desktop: mainFunction_UI(),


        )




      );
  }

  getBasicInfo()
  {

    SharedPreference.getIncomeTax_HeadsFinancialYear().then((value) => {
      financialYear=value
    });

    String mobileNumber_key="",empCode_key="",
        empDateOfBirth_key="",jsId_key="";

    SharedPreference.getEmpMobileNo().then((value) =>  {
      mobileNumber_key=value,
      //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpCode().then((value) =>  {
      empCode_key=value,
      //print('show emp name2 $value'),
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth_key=value,
      //print('show emp name2 $value'),
      completeEmpCode = mobileNumber_key+"CJHUB"+empCode_key+"CJHUB"+empDateOfBirth_key,
    });

    SharedPreference.getJSId().then((value) =>  {
      jsId_key=value,
      completeEmpJSId=mobileNumber_key+"CJHUB"+jsId_key+"CJHUB"+empDateOfBirth_key,
      //print('show emp jsId $completeEmpJSId'),
    });


    SharedPreference.getEC_STATUS().then((value) =>  {
      //print('show emp ecstatus $value'),
      checkECStatus(value)
    });

  }
  checkECStatus(String ecStatus)
  {
    if(ecStatus=="EC")
    {
      getNotificationList("emp_code",completeEmpCode,WebApi.get_NotificationList_EC_Employee);

    }
    else if(ecStatus=="TEC")
    {
      getNotificationList("js_id",completeEmpJSId,WebApi.get_NotificationList_TEC_Employee);

    }
    else
    {

    }
  }

  getNotificationList(String identityParameterKey,String identityParameterValue,String webApiName) async
  {

    String hhh=getEncrypted_EmpCode(identityParameterValue);
    //print('show emp code $hhh');
    ////print('show emp financialYear $financialYear');

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            webApiName),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },

        body: {
          identityParameterKey: getEncrypted_EmpCode(identityParameterValue),
          'financial_year': financialYear

        },
      );

      //print(response.statusCode);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);

        NotificationViewModelResponse  notificationViewModelResponse = NotificationViewModelResponse.fromJson(jsonDecode(response.body));

        if(notificationViewModelResponse.statusCode==true)
        {
          if(notificationViewModelResponse.data!.length!>0) {
            setState(() {
              notificationListData = notificationViewModelResponse.data!;
            });
          }else
          {
            show_OKAlert("Notification not found");

          }
        }
        else
        {
          if (notificationViewModelResponse.message==null || notificationViewModelResponse.message=="")
          {
            show_OKAlert("server error!");

          }else {
            show_OKAlert(notificationViewModelResponse.message);
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

}