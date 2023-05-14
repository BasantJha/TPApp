
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:http/http.dart'as http;


import '../../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
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
import '../investment_declarationClasses/Investment_Declaration_RentDetailsEdit.dart';
import '../ModelClasses/Investment_Declaration_RentDetails_ModelResponse.dart';


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
      home: Investment_Declaration_RentPaidDetails(title: 'CJ Hub'),
    );
  }
}
class Investment_Declaration_RentPaidDetails extends StatefulWidget {

  Investment_Declaration_RentPaidDetails({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _Investment_Declaration_RentPaidDetails createState() => _Investment_Declaration_RentPaidDetails();
}

class _Investment_Declaration_RentPaidDetails extends State<Investment_Declaration_RentPaidDetails> {
  // This widget is the root of your application.

  List monthName_array = [
    "April",
    "May",
    "June","July","August","September","October","November","December","January","February","March",
  ];

  List<TextEditingController> _controllers = [];
  String displayName="";

  List<bool> _isChecked_array = [false,true,false,true,false,true,false,true,false,true,false,true];
  bool monVal = false;
  List listItem =["0","1","2"];
  List listItem1 =["0","1","2"];


  String completeEmpCode="",financialYear="";
  String empIp="",empUserId="";
  List<Data> listRentObj=[Data(rentMonth: "April",isMetro: "N",rentPaid: "0",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "0",landlordPancard: "0",address: "ramkhera"),Data(rentMonth: "May",isMetro: "N",rentPaid: "0",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "0",landlordPancard: "0",address: "ramkhera"),Data(rentMonth: "June",isMetro: "N",rentPaid: "0",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "0",landlordPancard: "0",address: "ramkhera"),Data(rentMonth: "July",isMetro: "N",rentPaid: "0",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "0",landlordPancard: "0",address: "ramkhera"),Data(rentMonth: "August",isMetro: "N",rentPaid: "0",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "0",landlordPancard: "0",address: "ramkhera"),Data(rentMonth: "Sep",isMetro: "N",rentPaid: "0",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "0",landlordPancard: "0",address: "ramkhera"),Data(rentMonth: "Oct",isMetro: "N",rentPaid: "0",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "0",landlordPancard: "0",address: "ramkhera"),Data(rentMonth: "Nov",isMetro: "N",rentPaid: "0",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "0",landlordPancard: "0",address: "ramkhera"),Data(rentMonth: "Dec",isMetro: "N",rentPaid: "0",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "0",landlordPancard: "0",address: "ramkhera"),Data(rentMonth: "Jan",isMetro: "N",rentPaid: "0",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "0",landlordPancard: "0",address: "ramkhera"),Data(rentMonth: "Feb",isMetro: "N",rentPaid: "0",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "0",landlordPancard: "0",address: "ramkhera"),Data(rentMonth: "march",isMetro: "N",rentPaid: "0",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "0",landlordPancard: "0",address: "ramkhera")];

  String monthName="";
  bool checkBox=false;

  String rentPaidAmt="";
  String noOfChildUnderCEA="";
  String noOfChildUnder_CHA="";
  String nameOf_Landlord="";
  String landlord_PanNumber="";
  String address="";

  List<TextEditingController> monthName_controllers = [];

  String totalEmployeeRent="0";

  bool landlordName_Visibility=false,landlordPANNumber_Visibility=false,landlordAddress_Visibility=false;

  final annualRentController=TextEditingController();
  final landLordNameController=TextEditingController();
  final landLordPANController=TextEditingController();
  final landLordAddressController=TextEditingController();
  bool editlandlordName_Visibility=false,editlandlordPANNumber_Visibility=false,editlandlordAddress_Visibility=false;

  double rentAlertBoxHeight=0;

  StreamSubscription? _connectionChangeStream;

  bool networkStatus = false;

  @override
  void initState() {
    super.initState();
    //user.initData(monthName_array);

    if(!networkStatus){
      print("Api salary status should be called");
      getRentDetailsApiRequest();
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

      //print("This CJ Hub rent details tax section Web");

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

    //print("investmentDeclaration rent details resetTimer");

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

     /* appBar: AppBar(leading: BackButton(
          color: Colors.black,onPressed: ()
        {
          Navigator.pop(context);
        },
      ), backgroundColor: Color(0xfff0f0f2),centerTitle: true,
        title: Image.asset(getCJHub_AppLogo,height: 90,width: 90,),),*/

        backgroundColor: Colors.white,
        appBar:CJAppBar("", appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action 1type");
          Navigator.pop(context);

        })),
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
                        itemCount: listRentObj.length,
                        itemBuilder: (BuildContext context, int index)
                        {

                          Data rentObj = listRentObj[index];

                          String monthName = SalaryYearMonth_List.FindMonthName_ByNumber(rentObj.rentMonth);
                          String rentAmount=rentObj.rentPaid.toString();
                          String landlordName=rentObj.landlordName.toString();
                          String landlordPanNumber=rentObj.landlordPancard.toString();
                          String landlordAddress=rentObj.address.toString();


                          int checkannualRent_int = int.parse(totalEmployeeRent);
                          if(checkannualRent_int > 100000) {
                            landlordName_Visibility = true;
                            landlordPANNumber_Visibility = true;
                            landlordAddress_Visibility = true;
                          }else
                            {
                              landlordName_Visibility = false;
                              landlordPANNumber_Visibility = false;
                              landlordAddress_Visibility = false;
                            }


                          return
                            Container(
                              child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                      color: sixHunGreyColor,
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
                                              padding: const EdgeInsets.only(top: 8),
                                              child:Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child:
                                                  Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width * 0.6,
                                                      child: Text(monthName,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black
                                                        ),),
                                                    ),
                                                  ),

                                                  Expanded(
                                                    flex: 1,
                                                    child:
                                                  Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width * 0.2,
                                                      child: /*Text("",
                                                        style: TextStyle(
                                                          fontSize: 14
                                                          // fontWeight: FontWeight.bold
                                                        ),)*/
                                                      Align(
                                                          alignment: Alignment.center,
                                                          child:  IconButton(
                                                              padding: EdgeInsets.zero,
                                                              constraints: BoxConstraints(),
                                                              icon: Image.asset(getCJHub_EditBtnIcon,
                                                                width: 20.0,
                                                                height: 20.0,),
                                                              iconSize: 20,
                                                              onPressed: ()
                                                              {
                                                                //print('Index of the item clicked: $index');

                                                                Data rentObj = listRentObj[index];
                                                                String monthName = SalaryYearMonth_List.FindMonthName_ByNumber(rentObj.rentMonth);
                                                                String rentAmount=rentObj.rentPaid.toString();
                                                                String landlordName=rentObj.landlordName.toString();
                                                                String landlordPanNumber=rentObj.landlordPancard.toString();
                                                                String landlordAddress=rentObj.address.toString();
                                                                //show_OKAlert("show selected index no is:: $index");

                                                                //editlandlordAddress_Visibility
                                                                setState(() {


                                                                 int checkannualRent_int = int.parse(totalEmployeeRent);
                                                                 if(checkannualRent_int > 100000) {

                                                                   rentAlertBoxHeight=374;
                                                                   editlandlordName_Visibility = true;
                                                                   editlandlordPANNumber_Visibility = true;
                                                                   editlandlordAddress_Visibility = true;

                                                                   annualRentController.text=rentAmount;
                                                                   landLordNameController.text=landlordName;
                                                                   landLordPANController.text=landlordPanNumber;
                                                                   landLordAddressController.text=landlordAddress;
                                                                 }else
                                                                 {

                                                                 if((landlordName == "" || landlordName == null)||(landlordPanNumber == "" || landlordPanNumber == null)||(landlordAddress == "" || landlordAddress == null))
                                                                 {

                                                                   annualRentController.text=rentAmount;

                                                                   rentAlertBoxHeight=210;
                                                                   editlandlordName_Visibility = false;
                                                                   editlandlordPANNumber_Visibility = false;
                                                                   editlandlordAddress_Visibility = false;


                                                                 }
                                                                 else
                                                                   {
                                                                     rentAlertBoxHeight=374;
                                                                     editlandlordName_Visibility = true;
                                                                     editlandlordPANNumber_Visibility = true;
                                                                     editlandlordAddress_Visibility = true;

                                                                     annualRentController.text=rentAmount;
                                                                     landLordNameController.text=landlordName;
                                                                     landLordPANController.text=landlordPanNumber;
                                                                     landLordAddressController.text=landlordAddress;

                                                                   }


                                                                 }

                                                                });

                                                                /*----------11-7-2022 start(use for the edit rent details )---------*/
                                                                //alertDialog_EditRentDetails(context,monthName,index);

                                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>

                                                                Responsive(
                                                                    mobile: Investment_Declaration_RentDetailsEdit(dataObj: rentObj,totalEmployeeRent: totalEmployeeRent,selectedIndex: index,listRentObj: listRentObj,),
                                                                    tablet: Center(
                                                                      child: Container(
                                                                        width: flutterWeb_tabletWidth,
                                                                        child: Investment_Declaration_RentDetailsEdit(dataObj: rentObj,totalEmployeeRent: totalEmployeeRent,selectedIndex: index,listRentObj: listRentObj,),
                                                                      ),
                                                                    ),
                                                                    desktop: Center(
                                                                      child: Container(
                                                                        width: flutterWeb_desktopWidth,
                                                                        child: Investment_Declaration_RentDetailsEdit(dataObj: rentObj,totalEmployeeRent: totalEmployeeRent,selectedIndex: index,listRentObj: listRentObj,),
                                                                      ),
                                                                    )
                                                                )
                                                                    // Investment_Declaration_RentDetailsEdit(dataObj: rentObj,totalEmployeeRent: totalEmployeeRent,selectedIndex: index,listRentObj: listRentObj,)

                                                                )).then((value)
                                                                {
                                                                  getRentDetails();
                                                                });

                                                                /*----------11-7-2022 end(use for the edit rent details )---------*/

                                                              }
                                                          )

                                                      ),
                                                    ),
                                                  )


                                                ],
                                              ),
                                            )

                                        ),

                                        Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 8),
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
                                                      child: Text('Rent Paid',
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
                                                      child: Text(rentAmount,
                                                        style: TextStyle(
                                                            fontSize: 14
                                                          // fontWeight: FontWeight.bold
                                                        ),),
                                                    ),)


                                                ],
                                              ),
                                            )

                                        ),

                                        /*---name of landlord---*/

                                        Visibility(visible: landlordName_Visibility,
                                        child:Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 7),
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
                                                      child: Text('Name of Landlord',
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
                                                      child: Text(landlordName,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // fontWeight: FontWeight.bold
                                                        ),),
                                                    ),)


                                                ],
                                              ),
                                            )

                                        )),

                                        /*---landlord PAN No---*/

                                         Visibility(visible: landlordPANNumber_Visibility,
                                             child:Container(
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
                                                      child: Text('Landlord PAN No',
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
                                                      child: Text(landlordPanNumber,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // fontWeight: FontWeight.bold
                                                        ),),
                                                    ),)


                                                ],
                                              ),
                                            )

                                        )),

                                        /*---address---*/

                                        Visibility(visible: landlordAddress_Visibility,
                                            child:Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 5,bottom: 8),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width * 0.4,
                                                      child: Text('Address',
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
                                                      child: Text(landlordAddress,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // fontWeight: FontWeight.bold
                                                        ),),
                                                    ),)


                                                ],
                                              ),
                                            )

                                        )),



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


    )
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
      getRentDetailsApiRequest();
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
          getRentDetailsApiRequest()
        }
      else
        {
          //print('please check the network status'),
          showNetworConnectionAlert()
        }
    });*/
    // getRentDetailsApiRequest();
  }

  getRentDetailsApiRequest()
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
      this.getRentDetails()

    });

    SharedPreference.getEmpId().then((value) =>  {
      //print('show emp name2 $value'),
      empUserId=value,

    });

    Method.getIPAddress().then((value) =>  {
      //print('show emp name2 $value'),
      empIp=value,


    });
  }


  getRentDetails() async
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.tax_get_rent_details),
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

        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        EasyLoading.dismiss();

        //print(response.body);
        var serverResponse=getTheDecryptedDataFromApiResponse(response.body);

        Investment_Declaration_RentDetails_ModelResponse rentDetails_ModelResponse = Investment_Declaration_RentDetails_ModelResponse.fromJson(jsonDecode(serverResponse));

        if(rentDetails_ModelResponse.statusCode==true)
        {

            listRentObj=rentDetails_ModelResponse.data!;

            /*--------30-8-2021 start-------*/
            int total_Amount=0;
            for(var obj in listRentObj)
            {
              int amount= int.parse(obj.rentPaid);
              total_Amount += amount;
            }
            //print('show total sum rent paid $total_Amount');

            setState(()
            {
              listRentObj=listRentObj;
              totalEmployeeRent=total_Amount.toString();
            /*--------30-8-2021 end-------*/
            });
        }
        else
        {
          if (rentDetails_ModelResponse.message==null || rentDetails_ModelResponse.message=="")
          {
            // show_OKAlert("server error!");

            Method.snackBar_OkText(context, "server error!");

          }else {

            Method.snackBar_OkText(context, rentDetails_ModelResponse.message);
            // show_OKAlert(rentDetails_ModelResponse.message);
          }
        }



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


  save__RentDetails(List listData) async
  {
    //String jsonTutorial = jsonEncode(listData);
    EasyLoading.show(status: Message.get_LoaderMessage);

    try {
      final response = await http.post(
        Uri.parse(
            WebApi.tax_save_rent_details),
        headers: <String, String>{
          'Content-Type': "application/json",
        },

        body: json.encode({
          'financial_year': financialYear,
          'emp_code': getEncrypted_EmpCode(completeEmpCode),
          'emp_ip': empIp,
          'emp_user_id': empUserId,
          'emp_rent_details': listData
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

        Investment_Declaration_RentDetails_ModelResponse vi_modelResponse = Investment_Declaration_RentDetails_ModelResponse.fromJson(jsonDecode(serverResponse));

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
  show_OKAlert(String message)
  {
    /*------SnackBar-----21-07-2022--------start-----------*/

    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    /*-----SnackBar------21-07-2022--------end-----------*/

    /*-----AlertDialog------start----------------------*/

    /*var alertDialog = AlertDialog(
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

 /* alertDialog_EditRentDetails(BuildContext context,String monthName,int selectedIndex)
  {
    var alertDialog = AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 300.0,
        height: rentAlertBoxHeight,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius:
          new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: new Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // dialog top
            new Expanded(
              child: new Container(
                  color: primaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: const EdgeInsets.only(left: 7),
                        child: Text(monthName,
                          style: TextStyle(color: Colors.white, fontSize: 17),),
                      ),


                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: ()
                        {
                          Navigator.of(context).pop();
                        },

                        child: Icon(
                          Icons.close, color: Colors.white, size: 30,),
                      ),

                    ],
                  )
              ),
            ),

            // dialog centre
           // new Expanded(
              *//*child: new*//* Container(
                //child: Form(
                  // autovalidate: true, //check for validation while typing
                    //key: formkeySpouse,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [


                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: TextFormField(
                              controller: annualRentController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                fillColor: Colors.grey[200],
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[200], width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 5, left: 3),
                                hintText: "Enter rent amount",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {



                          },
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Enter rent amount"),
                              ])
                          ),
                        ), //rent


                        Visibility(visible: editlandlordName_Visibility, child:
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              controller: landLordNameController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.grey[200],
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[200], width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 5, left: 3),
                                hintText: "Landlord name",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {


                          },
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Landlord name"),
                              ])
                          ),
                        )), //landlord name

                        Visibility(visible: editlandlordPANNumber_Visibility, child:
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: TextFormField(
                              controller: landLordPANController,
                              textCapitalization: TextCapitalization.characters,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.grey[200],
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[200], width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 5, left: 3),
                                hintText: "Landlord PAN number",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            //txt_spouseName=value;
                          },
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Landlord PAN number"),
                              ])
                          ),
                        )), //landlord PAN Number

                        Visibility(visible: editlandlordAddress_Visibility, child:
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: TextFormField(
                              controller: landLordAddressController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.grey[200],
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[200], width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: EdgeInsets.only(
                                    top: 5, left: 3),
                                hintText: "Landlord address",
                                border:
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                              ),onChanged: (value)
                          {
                            //txt_spouseName=value;
                          },
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Landlord address"),
                              ])
                          ),
                        )), //landlord address

                      ],
                    )
               // ),
              ),
              //flex: 4,
            //),

            // enter ok button
            new Expanded(
              child: new Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 30, //height of button
                          width: 100,
                          child: MaterialButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: ()
                              {
                                *//*if (formkeySpouse.currentState.validate())
                                {
                                  Navigator.of(context).pop();
                                  setState(()
                                  {
                                    selectedIndex=1;
                                    editValueInDialog(selectedIndex,txt_spouseName,txt_spouseAge);
                                  });

                                  //print("Validated");
                                } else {
                                  //print("Not Validated");
                                }*//*


                                String enterRentAmt_Str=annualRentController.text;
                                int enterRentAmt_int = int.parse(enterRentAmt_Str);
                                String enterlandlordName=landLordNameController.text;
                                String enterlandlordPANnumber=landLordPANController.text;
                                String enteraddress=landLordAddressController.text;


                              Data rentObj = listRentObj[selectedIndex];
                              String rentAmount=rentObj.rentPaid.toString();
                              int oldRentAmt_int = int.parse(rentAmount);



                              //editlandlordAddress_Visibility
                              setState(()
                              {


                              int checkannualRent_int = int.parse(totalEmployeeRent)-oldRentAmt_int+enterRentAmt_int;
                              //print('total new employee rent $checkannualRent_int');
                              totalEmployeeRent=checkannualRent_int.toString();

                              if(checkannualRent_int > 100000)
                              {
                                *//*rentAlertBoxHeight=374;
                                editlandlordName_Visibility = true;
                                editlandlordPANNumber_Visibility = true;
                                editlandlordAddress_Visibility = true;*//*

                                if((enterlandlordName == "" || enterlandlordName == null)||(enterlandlordPANnumber == "" || enterlandlordPANnumber == null)||(enteraddress == "" || enteraddress == null))
                                  {

                                  }
                                  else
                                    {

                                    for(var i=selectedIndex;i<listRentObj.length;i++) {
                                      Data dataObj = listRentObj[i];
                                      dataObj.rentPaid = enterRentAmt_Str;
                                      dataObj.landlordName = enterlandlordName;
                                      dataObj.landlordPancard = enterlandlordPANnumber;
                                      dataObj.address = enteraddress;
                                      listRentObj.replaceRange(i, i + 1, [dataObj]);
                                    }

                                      setState(() {
                                        listRentObj = listRentObj;
                                      });

                                    }

                              }
                              else
                                {

                                  for(var i=selectedIndex;i<listRentObj.length;i++)
                                    {

                                      Data dataObj = listRentObj[i];
                                      dataObj.rentPaid = enterRentAmt_Str;
                                      listRentObj.replaceRange(i, i+1, [dataObj]);
                                    }


                                  setState(() {
                                    listRentObj = listRentObj;
                                  });

                                  *//*rentAlertBoxHeight=210;
                                  editlandlordName_Visibility = false;
                                  editlandlordPANNumber_Visibility = false;
                                  editlandlordAddress_Visibility = false;*//*

                                }


                              });

                                Navigator.of(context).pop();

                                *//*------------create the new  object start 11-5-2022---------------*//*

                              List newList = [];
                              int total_Amount=0;

                              for (int i = 0; i < listRentObj.length; i++) {
                                var obj = listRentObj[i];
                                Map<String, String> map = {
                                  'rent_year': obj.rentYear,
                                  'rent_month': obj.rentMonth,
                                  'is_metro': obj.isMetro,
                                  'rentpaid': obj.rentPaid,
                                  'no_of_child_under_cea': obj
                                      .noOfChildUnderCea,
                                  'no_of_child_under_cha': obj
                                      .noOfChildUnderCha,
                                  'landlordname': obj.landlordName,
                                  'landlordpancard': obj.landlordPancard,
                                  'address': obj.address
                                };
                                newList.add(map);
                              }

                                save__RentDetails(newList);

                                *//*------------create the new  object end 11-5-2022---------------*//*
                              },

                              child: Text('OK',
                                  style: TextStyle(fontFamily: 'Vonique',
                                      fontSize: 17,
                                      color: Colors.black))),
                        ),
                      ),

                    ],
                  )
              ),
            ),
          ],
        ),
      ),

    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }*/




}



