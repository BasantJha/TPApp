
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:http/http.dart'as http;
/*
import 'package:web/Encrypt/encrypt.dart';
import 'package:web/Message/Message.dart';
import 'package:web/NetworkStatus/NetworkReachability.dart';
import 'package:web/customView/Method.dart';
import 'package:web/customView/SalaryYearMonth_List.dart';
import 'package:web/customView/SharedPreference.dart';
import 'package:web/investment_declaration/ModelClasses/Investment_Declaration_CarDetails_ModelResponse.dart';
import 'package:web/webApi/WebApi.dart';
*/
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/CJHubCustomView/AutoLogout.dart';
import '../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../CustomView/CJHubCustomView/NetworkStatus/NetworkReachability.dart';
import '../../../../../CustomView/CJHubCustomView/SalaryYearMonth_List.dart';
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../CustomView/CJHubCustomView/ValidateClass.dart';
import '../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../ModelClasses/Investment_Declaration_CarDetails_ModelResponse.dart';


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
      home: investmentDeclaration_carDetails(title: 'CJ Hub'),
    );
  }
}
class investmentDeclaration_carDetails extends StatefulWidget {

  investmentDeclaration_carDetails({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _investmentDeclaration_carDetails createState() => _investmentDeclaration_carDetails();
}

class _investmentDeclaration_carDetails extends State<investmentDeclaration_carDetails> {
  // This widget is the root of your application.


  bool monVal = false;
  bool tuVal = false;
  List listItem =["Not Applicable","Co-Part Use","Own-Part Use"];

  String completeEmpCode="",financialYear="";
  String empIp="",empUserId="";

  List<Data> listCarDetailsObj=[Data(declarationMonth: "April",carDetail: "Not Applicable",above1point6Cc: "N",driver: "N"),
    Data(declarationMonth: "May",carDetail: "Not Applicable",above1point6Cc: "N",driver: "N"),
    Data(declarationMonth: "Jun",carDetail: "Not Applicable",above1point6Cc: "N",driver: "N"),
    Data(declarationMonth: "July",carDetail: "Not Applicable",above1point6Cc: "N",driver: "N"),
    Data(declarationMonth: "August",carDetail: "Not Applicable",above1point6Cc: "N",driver: "N"),
    Data(declarationMonth: "Sep",carDetail: "Not Applicable",above1point6Cc: "N",driver: "N"),
    Data(declarationMonth: "Oct",carDetail: "Not Applicable",above1point6Cc: "N",driver: "N"),
    Data(declarationMonth: "Nov",carDetail: "Not Applicable",above1point6Cc: "N",driver: "N"),
    Data(declarationMonth: "Dec",carDetail: "Not Applicable",above1point6Cc: "N",driver: "N"),
    Data(declarationMonth: "Jan",carDetail: "Not Applicable",above1point6Cc: "N",driver: "N"),
    Data(declarationMonth: "Feb",carDetail: "Not Applicable",above1point6Cc: "N",driver: "N"),
    Data(declarationMonth: "March",carDetail: "Not Applicable",above1point6Cc: "N",driver: "N")];

  String monthName="Apri";
  var carDetails;
  bool aboveCC_CheckBox=false;
  bool driver_CheckBox=false;


  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;

  @override
  void initState() {
    super.initState();

    if(!networkStatus){
      print("Api salary status should be called");
      getCarDetailsApiRequest();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Container(
            child:Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    flex: 1,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: Center(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: listCarDetailsObj.length-11,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                // color: Colors.greenAccent,
                                height: 10,
                                width: 530,
                                child:
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: listCarDetailsObj.length+1,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        // color: Colors.green,
                                        border: Border(bottom: BorderSide(
                                            color: twoHunGreyColor,width: 1.0
                                        )),
                                      ),
                                      child:
                                      _generateRightHandSideColumnRow(context,index),

                                    );
                                  },
                                ),
                              );
                            }),
                      ),
                    ))
              ],
            )

        ) ,
      )

    );
  }

  Widget _getTitleItemWidget(String label, double width,color) {
    return Container(
      color: color,
      child: Text(label,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white,)),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      alignment: Alignment.center,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      // color: Colors.pink,
      child: Text('',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
      width: 120,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      alignment: Alignment.center,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index)
  {

    if(index==0)
    {
      return Row(
        children: [
         _getTitleItemWidget('Month' , 120,Color(0xff32AAE0)),
          Container(width: 2,height: 56,color: Colors.white,),
          _getTitleItemWidget('Car Details', 100,Color(0xff32AAE0)),
          Container(width: 2,height: 56,color: Colors.white,),
          _getTitleItemWidget('Above 1.6 CC (Y/N)' , 100,Color(0xff32AAE0)),
          Container(width: 2,height: 56,color: Colors.white,),
          _getTitleItemWidget('Driver(Y/N)', 100,Color(0xff32AAE0)),
          Container(width: 2,height: 56,color: Colors.white,),
          _getTitleItemWidget("Update", 100,Color(0xff32AAE0)),
        ],
      );
    }
    else {
      Data dataObj = listCarDetailsObj[index-1];

      monthName =
          SalaryYearMonth_List.FindMonthName_ByNumber(dataObj.declarationMonth);

      if (dataObj.above1point6Cc == "Y") {
        aboveCC_CheckBox = true;
      } else {
        aboveCC_CheckBox = false;
      }
      if (dataObj.driver == "Y") {
        driver_CheckBox = true;
      } else {
        driver_CheckBox = false;
      }
      carDetails = dataObj.carDetail;
      if (carDetails == "") {
        carDetails = "Not Applicable";
      }


      return Row(
        children: <Widget>[
          Container(
            // color: Colors.pink,
            child: Text(monthName, style: TextStyle(fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black),),
            width: 120,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            alignment: Alignment.center,
          ),

          create_Divider(),

          Container(
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: DropdownButton(
                icon: Icon(Icons.arrow_drop_down),
                dropdownColor: Colors.white,
                underline: DropdownButtonHideUnderline(child: Container()),
                iconSize: 25,
                isExpanded: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                ),
                value: carDetails,
                onChanged: (newValue)
                {
                  Data dataObj = listCarDetailsObj[index-1];
                  dataObj.carDetail = newValue;
                  listCarDetailsObj.replaceRange(index-1, index, [dataObj]);

                  setState(() {
                    carDetails = newValue;
                    listCarDetailsObj = listCarDetailsObj;
                  });
                },
                items: listItem.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            alignment: Alignment.centerLeft,
          ),

          create_Divider(),

          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: aboveCC_CheckBox,
                    onChanged: (bool? value)
                    {
                      Data dataObj = listCarDetailsObj[index-1];
                      String checkBoxValue;

                      if (value!) {
                        checkBoxValue = "Y";
                      } else {
                        checkBoxValue = "N";
                      }
                      dataObj.above1point6Cc = checkBoxValue;
                      listCarDetailsObj.replaceRange(
                          index-1, index, [dataObj]);

                      setState(() {
                        aboveCC_CheckBox = value!;
                        listCarDetailsObj = listCarDetailsObj;
                      });
                    },
                  ),
                ]
            ),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            alignment: Alignment.centerLeft,
          ),

          create_Divider(),

          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: driver_CheckBox,
                    onChanged: (bool? value)
                    {
                      Data dataObj = listCarDetailsObj[index-1];
                      String checkBoxValue;

                      if (value!) {
                        checkBoxValue = "Y";
                      } else {
                        checkBoxValue = "N";
                      }
                      dataObj.driver = checkBoxValue;
                      listCarDetailsObj.replaceRange(
                          index-1, index, [dataObj]);


                      setState(() {
                        driver_CheckBox = value!;
                        listCarDetailsObj = listCarDetailsObj;
                      });
                    },
                  ),
                ]
            ),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            alignment: Alignment.centerLeft,
          ),

          create_Divider(),

          Container(
            child: SizedBox(
              height: 30, //height of button
              width: 70,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff32AAE0),
                    elevation: 0.0, //elevation of button
                    shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    // padding: EdgeInsets.only(top: 15),
                  ),
                  onPressed: () {
                    List newList = [];

                    for (int i = 0; i < listCarDetailsObj.length; i++) {
                      var obj = listCarDetailsObj[i];
                      Map<String, String> map = {
                        'declaration_year': obj.declarationYear,
                        'declaration_month': obj.declarationMonth,
                        'cardetail': obj.carDetail,
                        'above_1point6_cc': obj.above1point6Cc,
                        'driver': obj.driver
                      };
                      newList.add(map);
                    }
                    save__CarDetails(newList);

                    //save__CarDetails(listData;)

                  }, child: Text('Update',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Vonique',
                      color: Colors.white,
                      fontSize: 10))),
            ),
            width: 100,
            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            alignment: Alignment.center,
          ),

          create_Divider(),

        ],
      );
    }
  }

  Container create_Divider(){
    return Container(width: 1,height: 52,color: Colors.grey[300],);
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
      getCarDetailsApiRequest();
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
          getCarDetailsApiRequest()
        }
      else
        {
          //print('please check the network status'),
          showNetworConnectionAlert()
        }
    });*/
    // getCarDetailsApiRequest();
  }

  getCarDetailsApiRequest()
  {

    SharedPreference.getIncomeTax_HeadsFinancialYear().then((value) =>  {
      financialYear=value,
      //print('show emp getIncomeTax_HeadsFinancialYear $value'),
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
      //print('show emp name2 $value'),
      //loadData()
    });

    SharedPreference.getEmpDateOfBirth().then((value) =>  {

      empDateOfBirth_key=value,
      //print('show emp name2 $value'),
      completeEmpCode = mobileNumber_key+"CJHUB"+empCode_key+"CJHUB"+empDateOfBirth_key,

    });

    SharedPreference.getEmpId().then((value) =>  {
      //print('show emp name2 $value'),
      empUserId=value,

    });

    Method.getIPAddress().then((value) =>  {
      //print('show emp name2 $value'),
      empIp=value,

      this.getCarDetailsWebApi()

    });
  }

  getCarDetailsWebApi() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.tax_get_car_details),
        headers: <String, String>{
          'Content-Type': WebApi.service_Content_Type,
        },
        body: {
          'financial_year': financialYear,
          'emp_code': getEncrypted_EmpCode(completeEmpCode)

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

        Investment_Declaration_CarDetails_ModelResponse obj = Investment_Declaration_CarDetails_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(obj.statusCode==true)
        {
          setState(()
          {
            listCarDetailsObj=obj.data!;
          });
        }
        else
        {
          if (obj.message==null || obj.message=="")
          {
            // show_OKAlert("server error!");

            Method.snackBar_OkText(context, "server error!");

          }else {

            Method.snackBar_OkText(context, obj.message);
            // show_OKAlert(obj.message);
          }
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

  save__CarDetails(List listData) async
  {
    //String jsonTutorial = jsonEncode(listData);
    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.tax_save_car_details),
        headers: <String, String>{
          'Content-Type': "application/json",
        },

        body: json.encode({
          'financial_year': financialYear,
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'emp_ip': empIp,
          'emp_user_id': empUserId,
          'car_details': listData
        }),
      );
      //print(response.statusCode);
      if (response.statusCode == 200)
      {
        EasyLoading.dismiss();

        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        Investment_Declaration_CarDetails_ModelResponse vi_modelResponse = Investment_Declaration_CarDetails_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(vi_modelResponse.statusCode==true)
        {

          Method.snackBar_OkText(context, vi_modelResponse.message);
          // show_OKAlert(vi_modelResponse.message);

        }
        else
        {
          if (vi_modelResponse.message==null || vi_modelResponse.message=="")
          {
            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, vi_modelResponse.message);
            // show_OKAlert(vi_modelResponse.message);
          }
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
  //
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

}
