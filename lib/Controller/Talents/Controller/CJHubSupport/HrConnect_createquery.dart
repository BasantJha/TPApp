import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:contractjobs/Services/CJTalentsService/CJTalentServiceBody.dart';
import 'package:contractjobs/Services/CJTalentsService/CJTalentServiceRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;

import '../../../../Constant/Constants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJHubCustomView/NetworkStatus/NetworkReachability.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../Services/AESAlgo/encrypt.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/Messages/Message.dart';
import '../../ModelClasses/CJHubSupportModelClass/HrConnect_SaveMsg_ModelResponse.dart';
import '../../ModelClasses/CJHubSupportModelClass/HrConnect_SubjectTicket_ModelResponse.dart';


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
      home: HrConnect_createquery(title: 'CJ Hub'),
    );
  }
}
class HrConnect_createquery extends StatefulWidget {

  HrConnect_createquery({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HrConnect_createquery createState() => _HrConnect_createquery();
}

class _HrConnect_createquery extends State<HrConnect_createquery> {
  // This widget is the root of your application.


  String empIPAddress="",empCode="";

  String completeEmpCode="";

  String valueChoose="Choose Subject",selectedSubjectValue="Choose Subject" ;
  bool dropDown_VisibilityStatus=false;
  String txt_Comment="";

  //List listItem =["Attendance","Salary ","Other"];
  //bool Other_Selected = false;


  HrConnect_SubjectTicket_ModelResponse? ticket_modelResponse;
  //List<Tickets> tickets_Obj=[Tickets(ticketId: "1",ticketName: "Appointment Letter")];
  Tickets? tickets_Obj;

  String restrictSameTicketValue="";

  TabController? tabController;

  String check_ECStatus="";

  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // checkNetworkConnection();

    if(!networkStatus){
      print("Api salary status should be called");
      get_SujectTicketsRequest();
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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            create_textContainer("Subject"),

            dropDownButton_Container(),

            create_text2Container("Comment\ Query"),

            create_commentQueryContainer(),

            create_submitButton(),



            /* Container(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 40),

              child:Align(
                alignment: Alignment.centerLeft,
                child:create_TextAlertFor_CareTeam("Please contact the Care team for create Tickets.\n","care@contract-jobs.com"),
              ),
            ),

*/


          ],
        ),
      ),
    );
  }
  create_TextAlertFor_CareTeam(String textName,String emailId)
  {
    return Text.rich(

      TextSpan(

        text: textName,
        children: <InlineSpan>[
          TextSpan(
            text: emailId,
            style: TextStyle(color: Colors.blue,fontSize: 16),
          ),
        ],
        style: TextStyle(color: Colors.black,fontSize: 14),
      ),
    );
  }


  Container create_textContainer(String value){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,20,0,0),
        child: Row(
          children: [
            Text(value,
              style: TextStyle(color: Colors.black,fontSize: 15),),
          ],
        ),
      ),
    );
  }

  Container dropDownButton_Container(){
    return Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left:10,right: 10,top: 5),
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
          border: Border.all(color: colors.boderColor,
              width: 1.0,
              style: BorderStyle.solid),
          borderRadius: new BorderRadius.circular(0.0),
        ),
        child:loadDropDown_VisibleData(),


      );
  }
  Visibility loadDropDown_VisibleData() {

    if (dropDown_VisibilityStatus == true)
    {
      /*------load live data in dropdown start------*/

      return Visibility(
        visible: true,
        child: DropdownButton(
          hint: Text(selectedSubjectValue),
          icon: Icon(Icons.arrow_drop_down),
          dropdownColor: Colors.white,
          underline: DropdownButtonHideUnderline(child: Container()),
          iconSize: 25,
          isExpanded: true,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
          value: tickets_Obj,
          onChanged: (Tickets? obj)
          {
            selectedSubjectValue=obj!.ticketName!;
            tickets_Obj = obj;

            setState(()
            {

              /*if(valueChoose =='Other' )
              {
                Other_Selected = true;
              }else{
                // Not others
                Other_Selected = false;
              }*/

            });
          },
          items: ticket_modelResponse!.data!.tickets!.map((Tickets tickets){
            return DropdownMenuItem(
              value: tickets,
              child: Text(tickets.ticketName),
            );
          }).toList(),
        ),
      );
      /*------load live data in dropdown end------*/

    }
    else
    {
      /*------load default data first time load dropdown handle the exception page start------*/
      return Visibility(
          visible: true,
          child: DropdownButton(
            hint: Text('Choose Subject'),
            icon: Icon(Icons.arrow_drop_down),
            dropdownColor: Colors.white,
            underline: DropdownButtonHideUnderline(child: Container()),
            iconSize: 25,
            isExpanded: true,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
            value: tickets_Obj,
            onChanged: (obj)
            {

            },
            items: HrConnect_SubjectTicket_ModelResponse.loadDefaultData.map((Tickets data)
            {
              return DropdownMenuItem(
                value: data.ticketName,
                child: Text(data.ticketName),
              );
            }).toList(),
          )
      );
    }
    /*------load default data first time load dropdown handle the exception page end------*/

  }

  Container create_subjectContainer(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,10,10,0),
        child: TextField(
          // controller: _controllers[index] ,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: colors.boderColor, width: 1.0),
              borderRadius: BorderRadius.circular(0.0),
            ),
            contentPadding: EdgeInsets.only(
                top: 5, left: 3),
            hintText: "Other Subject",
            border:
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.0)),
          ),

        ),
      ),
    );
  }

  Container create_text2Container(String value){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,30,0,0),
        child: Row(
          children: [
            Text(value,
              style: TextStyle(color: Colors.black,fontSize: 15),),
          ],
        ),
      ),
    );
  }

  SizedBox create_commentQueryContainer(){
    return SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,5,10,0),
          child: TextField(
            expands: true,
            maxLines: null,
            minLines: null,
            maxLength: 500,
            // controller: _controllers[index] ,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              fillColor: addInsuranceCardColor,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: colors.boderColor, width: 1.0),
                borderRadius: BorderRadius.circular(0.0),
              ),
              /* contentPadding: EdgeInsets.only(
               left: 3),*/
              hintText: "",
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1.0)),
            ),
            onChanged: (value)
          {
            txt_Comment=value;
          },

          ),
        )
    );
  }

  Container create_text3Container(String value){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,30,0,0),
        child: Row(
          children: [
            Text(value,
              style: TextStyle(color: Colors.black,fontSize: 15),),
          ],
        ),
      ),
    );
  }

  Container create_uploadFile(){
    return Container(
      // color: Colors.yellow,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child:  Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    height: 50,
                    decoration: new BoxDecoration(
                      // color:Colors.blue,
                        shape: BoxShape.rectangle,
                        borderRadius: new BorderRadius.circular(0.0),
                        border: Border.all(color: colors.boderColor,
                            width: 1.0,
                            style: BorderStyle.solid)
                    ),
                    child: Text(""),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.31,

                  decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: new BorderRadius.circular(0.0),
                      border: Border.all(color: colors.boderColor,
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
                        onPressed: () {},
                        child: Text('Choose File',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'Vonique',color: Colors.black,fontSize: 13))
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }

  Container create_submitButton(){
    return Container(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(5.0),
                  color: primaryColor,
                  child:MaterialButton(
                      minWidth: 180,
                      height: 50,
                      padding: EdgeInsets.only(left:20,right: 20),
                      onPressed: ()
                      {

                        validateTheFields();
                      },
                      child: Text('SUBMIT',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Vonique',color: Colors.white,fontSize: 13))

                  ),
                ),
              ],
            )
        )
    );
  }



  void checkNetworkConnection(dynamic hasConnection)
  {
   /* NetworkReachability.networkConnectionStatus().then((networkStatus) =>
    {
      if(networkStatus)
        {
          get_SujectTicketsRequest()
        }
      else
        {
          //print('please check the network status'),
          showNetworConnectionAlert()
        }
    });*/

    if(mounted){
      setState(() {
        networkStatus = !hasConnection;
      });
    }
    if(!networkStatus){
      print("Api should be called");
      get_SujectTicketsRequest();
      EasyLoading.dismiss();
    }
    else{
      print("Api should not be called");
      EasyLoading.show(status: Message.get_LoaderMessage);
      Method.snackBar_OkText(context, 'No Internet Connection');
    }
    print(" Inside Test Widget 2");

    // get_SujectTicketsRequest();
  }

  get_SujectTicketsRequest()
  {

    Method.getIPAddress().then((value) => {
      empIPAddress=value

    });

    SharedPreference.getEC_STATUS().then((value) =>  {
      check_ECStatus=value,
      //print('show emp getEC_STATUS $value'),
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
      this.get_SujectTicketsWebApi()

    });

  }


  // ignore: non_constant_identifier_names
  get_SujectTicketsWebApi() async
  {

    //completeEmpCode="9569734648CJHUB5610CJHUB14/05/1988";
   /* var ff=getEncrypted_EmpCode(completeEmpCode);
    print("show encrypted emp code $ff");*/

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.get_HRConnect_Subject_Tickets),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
        },
      );
      //print(response.statusCode);
      if (response.statusCode == 200)
      {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        print(response.body);
        print("show the api request here-----");

        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        ticket_modelResponse = HrConnect_SubjectTicket_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(ticket_modelResponse?.statusCode==true)
        {
          setState(() {
            dropDown_VisibilityStatus=true;
            ticket_modelResponse=ticket_modelResponse;
          });
        }
        else
        {
          if (ticket_modelResponse!.message==null)
          {
            // show_OKAlert("server error!");
            Method.snackBar_OkText(context, "server error!");

          }else {

            Method.snackBar_OkText(context, ticket_modelResponse!.message!);

            // show_OKAlert(ticket_modelResponse.message);
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

  validateTheFields()
  {

    if(selectedSubjectValue=="Choose Subject")
    {

      Method.snackBar_OkText(context, "Please Select the subject");
      // show_OKAlert("Please Select the subject");
    }
    else
    {
      if (txt_Comment.trim().length>=3)
      {

        //print('show selected value $selectedSubjectValue');
        //print('show comments $txt_Comment');

        if(restrictSameTicketValue==tickets_Obj!.ticketName!)
        {

          Method.snackBar_OkText(context, "Please Choose  Other Subject");
          // show_OKAlert("Please Choose  Other Subject");

        }
        else {
          save_CreateQueryWebApi();
        }
      }
      else
      {
        Method.snackBar_OkText(context, "Please enter the valid comment query");
        // show_OKAlert("Please enter the valid comment query");
      }
    }
  }

  save_CreateQueryWebApi() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.save_HRConnect_CreateQuery),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'subject_id': tickets_Obj!.ticketId,
          'subject_desc': tickets_Obj!.ticketName,
          'query_comment': txt_Comment,
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
          restrictSameTicketValue=tickets_Obj!.ticketName;
          show_SuccessAlert(connect_saveMsg_ModelResponse.message!);

        }
        else
        {
          if (connect_saveMsg_ModelResponse.message==null)
          {
            // show_OKAlert("server error!");

            Method.snackBar_OkText(context, "server error!");

          }else {

            Method.snackBar_OkText(context, connect_saveMsg_ModelResponse!.message!);

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

/*
  serviceBodyRequest()
  {
    print("show the request111");
    var mapObject=getCJHub_SupportCreateQuery_RequestBody(completeEmpCode,tickets_Obj!.ticketId,tickets_Obj!.ticketName,txt_Comment,empIPAddress);
    serviceRequest(mapObject);

  }
  serviceRequest(Map mapObj)
  {
    print("show the request2");
    print("show the request object $mapObj");

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.save_HRConnect_CreateQuery,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          var response=success as IntroModelClass;

          restrictSameTicketValue=tickets_Obj!.ticketName;
          show_SuccessAlert(connect_saveMsg_ModelResponse.message!);

        }, talentFailureBlock:<T>(failure)
        {
          print("show the request failure");

        }));

  }

*/

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

          if(check_ECStatus=="EC")
          {
            /*----------comment query 17-11-2022  start(use)------------*/

            //use for regular and contractual employee
           /* Navigator.push(context, MaterialPageRoute(builder: (_)=>

            Responsive(
                mobile: bottom(selectedItemIndexFromCreateQuery: 1,),
                tablet: Center(
                  child: Container(
                    width: flutterWeb_tabletWidth,
                    child: bottom(selectedItemIndexFromCreateQuery: 1,)
                  ),
                ),
                desktop: Center(
                  child: Container(
                    width: flutterWeb_desktopWidth,
                    child: bottom(selectedItemIndexFromCreateQuery: 1,),
                  ),
                )
            )
            ));*/

            /*----------comment query 17-11-2022  end------------*/

          }
          else if(check_ECStatus=="REC" || check_ECStatus=="RTEC")
          {
            //USE FOR Rider---//26-4-2022 start
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Rider_REC_bottom(selectedItemIndexFromCreateQuery: 1,)));
            //USE FOR Rider---//26-4-2022 end

          }else
          {

          }

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
class colors{
  static const boderColor = Color(0xffE0E0E0);
}