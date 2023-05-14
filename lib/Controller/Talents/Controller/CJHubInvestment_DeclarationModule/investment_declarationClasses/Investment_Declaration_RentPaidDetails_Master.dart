import 'dart:async';
import 'dart:convert';

import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart'as http;
/*import 'package:web/Encrypt/encrypt.dart';
import 'package:web/Message/Message.dart';
import 'package:web/NetworkStatus/NetworkReachability.dart';
import 'package:web/constants/constants.dart';
import 'package:web/customView/AutoLogout.dart';
import 'package:web/customView/Method.dart';
import 'package:web/customView/SharedPreference.dart';
import 'package:web/customView/ValidateClass.dart';
import 'package:web/investment_declaration/ModelClasses/Investment_Declaration_RentDetails_ModelResponse.dart';
import 'package:web/investment_declaration/investment_declarationClasses/Investment_Declaration_RentPaidDetails.dart';
import 'package:web/responsive/responsive_screen_width.dart';
import 'package:web/responsive/resposive.dart';
import 'package:web/webApi/WebApi.dart';*/

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
import '../ModelClasses/Investment_Declaration_RentDetails_ModelResponse.dart';
import 'Investment_Declaration_RentPaidDetails.dart';

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
      home: Investment_Declaration_RentPaidDetails_Master(),
    );
  }
}

class Investment_Declaration_RentPaidDetails_Master extends StatefulWidget
{
  const Investment_Declaration_RentPaidDetails_Master({Key? key}) : super(key: key);

  @override
  _Investment_Declaration_RentPaidDetails_Master createState() => _Investment_Declaration_RentPaidDetails_Master();
}

class _Investment_Declaration_RentPaidDetails_Master extends State<Investment_Declaration_RentPaidDetails_Master> {

  final _annualRentController=TextEditingController();
  final _landLordNameController=TextEditingController();
  final _landLordPANController=TextEditingController();
  final _landLordAddressController=TextEditingController();
  bool _visible =true;

  String annualHouseRent="",landloard_Name="",
  landloard_PanNumber="",landloard_Address="";
  int annualRent_int=0;
  bool landloardName_Visibility=false,landloardPANCard_Visibility=false,landloardAddress_Visibility=false;

  bool panCardStatus=false;

  String completeEmpCode="",financialYear="";
  String empIp="",empUserId="";

  String view_RentDetails="";

  String actionButtonName="SAVE";
  bool rentFieldUserInteractionStatus=true;
  bool nameFieldUserInteractionStatus=true;
  bool pannumberFieldUserInteractionStatus=true;
  bool addressFieldUserInteractionStatus=true;


  List<Data> listRentObj=[Data(rentMonth: "April",isMetro: "N",rentPaid: "1000",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "vipin",landlordPancard: "CRRPK7011F",address: "ramkhera"),Data(rentMonth: "May",isMetro: "N",rentPaid: "1000",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "vipin",landlordPancard: "CRRPK7011F",address: "ramkhera"),Data(rentMonth: "June",isMetro: "N",rentPaid: "1000",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "vipin",landlordPancard: "CRRPK7011F",address: "ramkhera"),Data(rentMonth: "July",isMetro: "N",rentPaid: "1000",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "vipin",landlordPancard: "CRRPK7011F",address: "ramkhera"),Data(rentMonth: "August",isMetro: "N",rentPaid: "1000",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "vipin",landlordPancard: "CRRPK7011F",address: "ramkhera"),Data(rentMonth: "Sep",isMetro: "N",rentPaid: "1000",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "vipin",landlordPancard: "CRRPK7011F",address: "ramkhera"),Data(rentMonth: "Oct",isMetro: "N",rentPaid: "1000",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "vipin",landlordPancard: "CRRPK7011F",address: "ramkhera"),Data(rentMonth: "Nov",isMetro: "N",rentPaid: "1000",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "vipin",landlordPancard: "CRRPK7011F",address: "ramkhera"),Data(rentMonth: "Dec",isMetro: "N",rentPaid: "1000",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "vipin",landlordPancard: "CRRPK7011F",address: "ramkhera"),Data(rentMonth: "Jan",isMetro: "N",rentPaid: "1000",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "vipin",landlordPancard: "CRRPK7011F",address: "ramkhera"),Data(rentMonth: "Feb",isMetro: "N",rentPaid: "1000",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "vipin",landlordPancard: "CRRPK7011F",address: "ramkhera"),Data(rentMonth: "march",isMetro: "N",rentPaid: "1000",noOfChildUnderCea: "0",
      noOfChildUnderCha: "0",landlordName: "vipin",landlordPancard: "CRRPK7011F",address: "ramkhera")];


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

      //print("This CJ Hub rent paid details master tax section Web");

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

      body:
      SafeArea(
          child:SingleChildScrollView(
              child: Column(
                children: [
                  _buildRentDetailsContainer(),
                ],
              )
          )
      ),
    )
    );
  }

  Widget _buildRentDetailsContainer()
  => Container(
    child:
    Padding(
        padding: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 10.0),
        child:Container(
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

                    heading(),

                    annualRent_Container(),

                    create_SpaceBtweenContainer(),

                    Visibility(visible: landloardName_Visibility,child:

                    landLordName_Container(),
                    ),

                    create_SpaceBtweenContainer(),

                    Visibility(visible: landloardPANCard_Visibility,child:

                    landLordPAN_Container(),
                    ),


                    create_SpaceBtweenContainer(),

                    create_SpaceBtweenContainer(),

                    Visibility(visible: landloardAddress_Visibility,child:

                    landLordAddress_Container(),
                    ),


                    create_Button_Save(),


                  ],
                ),
              )

          ),
        )
    ),

  );

  Container heading(){
    return Container(
        child:Padding(
            padding: const EdgeInsets.only(left: 20, right: 20,top: 5,bottom: 5),
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Expanded(
                      flex:1,
                      child:Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Rent Details',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                    ),
                ),

                Container(
                  child: Expanded(
                    flex:1,
                    child:Align(
                      alignment: Alignment.centerRight,
                      child:
                      Text.rich(

                        TextSpan(
                            text: view_RentDetails,recognizer: TapGestureRecognizer()
                          ..onTap = ()
                          {
                            //print('view document');
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>Investment_Declaration_RentPaidDetails()));
                            taoToNavigateToRentDetails();
                          },
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              decorationThickness: 2,
                            )),

                      ),
                    ),
                  ),
                )
              ],
            )
        )
    );
  }

  Container annualRent_Container() {
    return Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Annual House Rent",style: TextStyle(color: primaryColor,fontSize: 13),),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    height: 70,
                    child: TextField(
                      enabled: rentFieldUserInteractionStatus,
                      controller: _annualRentController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        contentPadding: EdgeInsets.only(
                            top: 5, left: 3),
                        hintText: "0",
                        border:
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0)),
                      ),
                      onChanged: (String value)
                      {
                        annualHouseRent = _annualRentController.text.toString() ;
                        //print('Rent: $annualHouseRent');



                        annualRent_int = int.parse(annualHouseRent);

                        setState(()
                        {
                          if(annualRent_int > 100000)
                          {
                            ////print('1 lakh more $annualRent');
                             landloardName_Visibility=true;
                          landloardPANCard_Visibility=true;
                          landloardAddress_Visibility=true;

                          }
                          else{

                            ////print('not 1 lakh $annualRent');
                            landloardName_Visibility=false;
                            landloardPANCard_Visibility=false;
                            landloardAddress_Visibility=false;
                          }
                        });


                      },
                    ),


                  ),

                ],
              ),

            ),
          ],
        )
    );
  }

  Container landLordName_Container() {
    return Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child: Text("LandLoard Name",style: TextStyle(color: primaryColor,fontSize: 13),),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    height: 70,
                    child: TextField(
                      enabled: nameFieldUserInteractionStatus,
                      controller: _landLordNameController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: validate_name(),
                      maxLength: 100,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        contentPadding: EdgeInsets.only(
                            top: 5, left: 3),
                        hintText: "name",
                        border:
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0)),
                      ),
                      onChanged: (String value)
                      {
                        landloard_Name=value;
                      },
                    ),


                  ),

                ],
              ),

            ),
          ],
        )
    );
  }

  Container landLordPAN_Container() {
    return Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child: Text("LandLoard PAN No.",style: TextStyle(color: primaryColor,fontSize: 13),),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  Container(
                    height: 70,
                    child: Form(
                      key: formkey_panCard,
                      child:
                      TextFormField(
                        enabled: pannumberFieldUserInteractionStatus,
                        keyboardType:TextInputType.text,
                        controller: _landLordPANController,
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: validate_panCard(),
                        validator: validate_PAN,
                        maxLength: 10,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          contentPadding: EdgeInsets.only(
                              top: 5, left: 10),
                          hintText: "",
                          border:
                          OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2.0)),
                        ),

                        onChanged: (String value)
                        {
                         /* _panNumber = _landLordPANController.text;

                          setState(() {

                            if(_panNumber.length <= 10){
                              validate_PANCard();
                              //print("validation check");

                            }

                            else

                              //print("invalid input");

                          });*/


                          landloard_PanNumber=value;
                          landloard_PanNumber = _landLordPANController.text;

                          /*setState(()
                          {

                            if(landloard_PanNumber.length<=10 )
                            {
                              panCardStatus=validate_PANCard();
                              //print("validation check $panCardStatus");

                            }
                            else {
                              panCardStatus=false;
                              //print("invalid input");
                            }


                          });*/

                        },
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

  Container landLordAddress_Container() {
    return Container(
        width: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child:
              Column(
                children: [

                  Container(
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child: Text("LandLoard Address",style: TextStyle(color: primaryColor,fontSize: 13),),
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  SizedBox(
                    height: 100,
                    child: TextField(
                      enabled: addressFieldUserInteractionStatus,
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      controller: _landLordAddressController ,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.words,
                      maxLength: 500,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        contentPadding: EdgeInsets.only(
                            left: 3),
                        hintText: "",
                        border:
                        OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0)),
                      ),
                      onChanged: (value)
                      {
                        landloard_Address=value;

                      },

                    ),

                  ),

                ],
              ),

            ),
          ],
        )
    );
  }

  Container create_Button_Save() {
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
              padding: const EdgeInsets.only(left: 10, right: 10, top: 30,bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 40,

                    child: Material(
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(5.0),
                      color: primaryColor,
                      child:MaterialButton(
                          minWidth: 50,
                          height: 50,
                          onPressed: ()
                          {
                            if(actionButtonName=="SAVE") {
                              validateToTheFields();
                            }
                            else
                              {
                               // Navigator.push(context, MaterialPageRoute(builder: (context)=>Investment_Declaration_RentPaidDetails()));

                                taoToNavigateToRentDetails();
                              }
                          },
                          child: Text(actionButtonName,
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

  SizedBox create_SpaceBtweenContainer(){
    return SizedBox(
      height: 10,
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


          if(total_Amount>0)
            {
              view_RentDetails="View Rent Details";
              actionButtonName="View Rent";
              rentFieldUserInteractionStatus=false;
              nameFieldUserInteractionStatus=false;
              pannumberFieldUserInteractionStatus=false;
              addressFieldUserInteractionStatus=false;

            }
          else
            {
              view_RentDetails="";
              actionButtonName="SAVE";
              rentFieldUserInteractionStatus=true;
              nameFieldUserInteractionStatus=true;
              pannumberFieldUserInteractionStatus=true;
              addressFieldUserInteractionStatus=true;

            }



          setState(()
          {
            annualHouseRent=total_Amount.toString();
            _annualRentController.text=total_Amount.toString();
           int checkannualRent_int = int.parse(annualHouseRent);

            listRentObj=listRentObj;


            if(checkannualRent_int > 100000)
            {
              ////print('1 lakh more $annualRent');
              landloardName_Visibility=true;
              landloardPANCard_Visibility=true;
              landloardAddress_Visibility=true;

              _landLordNameController.text=listRentObj[11].landlordName;
              landloard_Name=listRentObj[11].landlordName;

              _landLordPANController.text=listRentObj[11].landlordPancard;
              landloard_PanNumber=listRentObj[11].landlordPancard;

              _landLordAddressController.text=listRentObj[11].address;
              landloard_Address=listRentObj[11].address;

            }
            else{

              ////print('not 1 lakh $annualRent');
              landloardName_Visibility=false;
              landloardPANCard_Visibility=false;
              landloardAddress_Visibility=false;
            }


            /*--------30-8-2021 end-------*/
          });
        }
        else
        {
          if (rentDetails_ModelResponse.message==null || rentDetails_ModelResponse.message=="")
          {
            Method.snackBar_OkText(context, "server error!");
            // show_OKAlert("server error!");

          }else {

            Method.snackBar_OkText(context, rentDetails_ModelResponse.message);

            // show_OKAlert(rentDetails_ModelResponse.message);
          }
        }

        EasyLoading.dismiss();

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


  validateToTheFields()
  {

    annualHouseRent=_annualRentController.text;
    annualRent_int = int.parse(annualHouseRent);
    landloard_Name=_landLordNameController.text;
    landloard_PanNumber=_landLordPANController.text;
    landloard_Address=_landLordAddressController.text;

    //print("show annualRent_int $annualRent_int");
    //print("show landloard_Name $landloard_Name");
    //print("show landloard_PanNumber $landloard_PanNumber");
    //print("show landloard_Address $landloard_Address");


    if(annualRent_int>100000)
      {
        if(landloard_Name.length == 0 || landloard_Name.trim().length >= 3)
        {
          panCardStatus=validate_PANCard();

          if(panCardStatus==true)
          {
            if(landloard_Address.length == 0 || landloard_Address.trim().length >= 3)
            {
              loadTheData();
            }
            else
            {

              Method.snackBar_OkText(context, "Please enter the landlord address");
              // show_OKAlert("Please enter the landlord address");
            }
          }
          else
          {

            Method.snackBar_OkText(context, "Please enter the correct landlord PAN number");
            // show_OKAlert("Please enter the correct landlord PAN number");
          }
        }
        else
        {

          Method.snackBar_OkText(context, "Please enter the landlord name");
          // show_OKAlert("Please enter the landlord name");
        }
      }
    else
      {

        loadTheData();

      }

  }

  loadTheData()
  {
    List newList = [];
    int total_Amount=0;


    if(annualRent_int>100000)
    {

    }
    else
      {
        landloard_Name="";
        landloard_PanNumber="";
        landloard_Address="";

      }


    int getAnnualRent_int=(annualRent_int/12).round();
    var rounded_AnnualRent = getAnnualRent_int.round();



     //print('show month rent annualRent_int $rounded_AnnualRent');


    for (int i = 0; i < listRentObj.length; i++)
    {
      var obj = listRentObj[i];
      Map<String, String> map = {
        'rent_year': obj.rentYear,
        'rent_month': obj.rentMonth,
        'is_metro': obj.isMetro,
        'rentpaid': rounded_AnnualRent.toString(),
        'no_of_child_under_cea': obj.noOfChildUnderCea,
        'no_of_child_under_cha': obj.noOfChildUnderCha,
        'landlordname': landloard_Name,
        'landlordpancard': landloard_PanNumber,
        'address': landloard_Address
      };
      newList.add(map);


    }
    setState(()
    {
      //totalEmployeeRent=total_Amount.toString();
    });

    //print('show rent details $newList');

    save__RentDetails(newList);
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
          setState(() {
            view_RentDetails="View Rent Details";

          });
          show_SuccessAlert(vi_modelResponse.message);

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

        EasyLoading.dismiss();

        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create get product.');
      }
    }catch(e){
      //print(e);
    }
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

        TextButton(onPressed: () {

          Navigator.of(context).pop();
          taoToNavigateToRentDetails();

        },

          child: Text("OK",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
      ],

    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }

  /*-------------------8-7-20222 start(reload the rent details )------------------------*/
  taoToNavigateToRentDetails()
  {
    Navigator.push(context, MaterialPageRoute(builder: (_)=>

    Responsive(
        mobile: Investment_Declaration_RentPaidDetails(),
        tablet: Center(
          child: Container(
            width: flutterWeb_tabletWidth,
            child: Investment_Declaration_RentPaidDetails() ,
          ),
        ),
        desktop: Center(
          child: Container(
            width: flutterWeb_desktopWidth,
            child: Investment_Declaration_RentPaidDetails(),
          ),
        )

    )

        // Investment_Declaration_RentPaidDetails()
    )).then((value)
    {
      /*------8-6-2022 start(Reload the Rent data api)------*/
      //setState(() {
        //print("load the rent details data");
        getRentDetails();
      //});

      /*------8-6-2022 end------*/

    });
  }
  /*-------------------8-7-20222 end------------------------*/

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
}
