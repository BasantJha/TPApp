import 'dart:convert';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/Services/AESAlgo/EncryptedMapBody.dart';
import 'package:contractjobs/Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import 'package:contractjobs/Services/CJTalentsService/CJTalentServiceBody.dart';
import 'package:contractjobs/Services/CJTalentsService/CJTalentServiceRequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:marquee/marquee.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
//import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../EmployerModelClasses/EmployerPaymentModelClass/EmployerTransactionModelClass.dart';
import '../../Employer_KYC/Employer_AddStartingBalance.dart';
import '../../Employer_KYC/Employer_JoinerHome.dart';
import '../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../../Employer_TabBarController/Employer_TabBarController.dart';
import '../Employer_NewWorkPlace/Employer_NewWorkPlacePayouts/Employer_NewWorkPlacePayoutsManageStatus.dart';
import '../Employer_UPITransaction/Employer_UPITransaction.dart';
import 'Employer_NewPaymentPlan.dart';

class Employer_NewPaymentGateway extends StatefulWidget
{
  final Map data;
  const Employer_NewPaymentGateway({Key? key, required this.data, required this.userArriveFrom, this.liveModelObj}) : super(key: key);
  final String userArriveFrom;
  final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  State<Employer_NewPaymentGateway> createState() => _Employer_NewPaymentGateway();
//
}

class _Employer_NewPaymentGateway extends State<Employer_NewPaymentGateway> {
  var actual_data;
  var mapObj = Map();
  var resMap = Map();
  var decMap = Map();
  // response_of_api? response_object;
  // production keys
  //variables for opening paytm screen
  String? merchantId = "ikirfh88472746934843";
  String? orderid;
  String? txnToken;
  String? amount;
  bool isStaging = false;
  String? callbackurl = JG_ApiMethod_CallBackUrlForTxn;
  bool restrictAppInvoke = false;
  //restrict is true means webview everytime
  //restrict is false paytm app if install then opened
  String result = "";

  /*function to generate the required map*/
  String TxnOrderId = '';
  String amt = '';
  String customerAccountId = '';
  String currency = '';
  String requestType = '';

  String manualBankTransfer="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // generateEncrptObjForTxnToken();
    actual_data = widget.data;
  }

  //function for generating QR code for UPI apps
/*
  UPIDetails storeValues()
  {
    final upiDetails = UPIDetails(
        upiID: "akalinfo.02@hdfcbank",
        payeeName: "Akal Infoys Pvt Ltd.",
        amount: double.parse(actual_data["amt"]),
        transactionID: actual_data["orderId"]);
    return upiDetails;
  }
*/


  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CJAppBar(getEmployer_PaymentTitle,
            appBarBlock: AppBarBlock(appBarAction: () {
              // print("show the action type");
              Navigator.pop(context);
            })),
        body: SingleChildScrollView(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'CHOOSE YOUR PAYMENT METHOD',
                    style: TextStyle(
                        fontSize: medium_FontSize,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                ),

                //netbanking

                InkWell(
                  onTap: () async {
                    // mapObj["orderId"] =
                    //     // "ORDERID_${DateTime.now().millisecondsSinceEpoch}";
                    //     'GST-S-71-2223';
                    // mapObj["customerAccountId"] =
                    //     // "CUST_${DateTime.now().millisecondsSinceEpoch}";
                    //     "1";
                    // mapObj["amt"] = "1.27";
                    // mapObj["currency"] = "INR";
                    // mapObj["requestType"] = "Payment";
                    // await StartTransaction();
                    await generateEncrptObjForTxnToken();
                  },
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Credit/Debit Cards, Wallet, Netbanking etc.',
                            style: TextStyle(
                                fontSize: medium_FontSize,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Image(image: AssetImage(visa)),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Image(image: AssetImage(mastercard)),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Image(image: AssetImage(upi_small)),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Image(image: AssetImage(netbanking)),
                                    Image(image: AssetImage(passbook)),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                      width: 25,
                                      child:
                                      Image(image: AssetImage(arrow_big))),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Additional payment gateway charges will apply",
                              style: TextStyle(
                                  fontSize: medium_FontSize,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),


                Divider(
                  height: 1,
                  thickness: 10,
                  color: Colors.grey[200],
                ),

                //upi card
               InkWell(onTap: ()
                 async{

                  // UPIDetails upiDetails = await storeValues();


                   /*---------27-2-2023 start(testing purpose)-----------*/
                /*   Navigator.push(context,
                       MaterialPageRoute(
                           builder: (context) => Employer_UPITransaction(
                               amount: actual_data["amt"],
                               orderId: actual_data["orderId"],
                               tpAccountId: widget.liveModelObj?.tpAccountId,))).then((value)
                   {
                     createBodyWebApi_UPITransactionCallBackURL(widget.liveModelObj?.tpAccountId,actual_data["orderId"]);
                   });*/

                   /*---------27-2-2023 end(testing purpose)-----------*/

                   //old
                /*   UPIDetails upiDetails = await createTheUPIId();
                   showModalBottomSheet(
                       isScrollControlled: true,
                       shape: const RoundedRectangleBorder(
                         borderRadius:
                         BorderRadius.vertical(top: Radius.circular(40)),
                       ),
                       context: context,
                       builder: (context) {
                         return StatefulBuilder(builder: (BuildContext context,
                             StateSetter setModalState) {
                           return UPI_BottomSheet(setModalState, upiDetails);
                         });
                       });
                   */

                 },child:  Card(
                   elevation: 0,
                   child: Container(
                     width: MediaQuery.of(context).size.width,
                     child: Padding(
                       padding: const EdgeInsets.symmetric(
                           vertical: 15.0, horizontal: 15),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Container(
                                 // height: 200,
                                 width: 100,
                                 child: Image(
                                   image: AssetImage(upi),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(top: 38.0),
                                 child: Column(
                                   children: [
                                     Container(
                                       height: 25,
                                       child:
                                       Image(image: AssetImage(arrow_big)),
                                     ),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                           SizedBox(
                             height: 10,
                           ),
                           Text(
                             'Max Limit Rs.100000 per day',
                             style: TextStyle(
                                 color: Colors.green,
                                 fontSize: large_FontSize,
                                 fontWeight: FontWeight.w500),
                           ),
                           Text('No Additional Charges',
                               style: TextStyle(
                                   fontSize: medium_FontSize,
                                   color: Colors.red,
                                   fontWeight: FontWeight.w500)),
                         ],
                       ),
                     ),
                   )),),

                Divider(
                  height: 1,
                  thickness: 10,
                  color: Colors.grey[200],
                ),

                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40)),
                        ),
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (BuildContext context,
                              StateSetter setModalState) {
                            return buildsheet(setModalState);
                          });
                        });
                  },
                  child: Card(
                    elevation: 0,
                    child: ListTile(
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /*-------16-2-2023 start-----*/

/*
                            manualBankTransfer==""?Container():Container(height: 30,padding: EdgeInsets.only(top: 1,bottom: 10),child:  InkWell(onTap: ()
                            {
                              print("show the action on the marquee");

                            },child: Marquee(
                              text: manualBankTransfer,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontFamily: robotoFontFamily,color: greenColor,fontSize: large_FontSize),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 20.0,
                              velocity: 100.0,
                              startPadding: 10.0,
                            ),),),
*/
                            /*--------16-2-2023 end--------*/

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        width: 55,
                                        child: Image(image: AssetImage(bank))),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Bank \nTransfer',
                                      style: TextStyle(
                                          fontSize: large_FontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 38.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 25,
                                            child: Image(
                                                image: AssetImage(arrow_big)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "No Additional Charges apply",
                              style: TextStyle(
                                  fontSize: medium_FontSize,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Divider(
                  height: 1,
                  thickness: 10,
                  color: Colors.grey[200],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  generateEncrptObjForTxnToken()
  {
    // TxnOrderId = "GST-09-22222222222";

    TxnOrderId = actual_data["orderId"];
    amt = actual_data["amt"];
    customerAccountId = actual_data["customerAccountId"];
    currency = actual_data["currency"];
    requestType = actual_data["requestType"];

    var generateTxnTokenMap = getTransactionTokenMap(
        amt, TxnOrderId, customerAccountId, currency, requestType);
    serviceRequest(generateTxnTokenMap);
  }

  serviceRequest(Map mapObj)
  {


    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_TransUrl,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          print("print Details model response $modelResponse");
          EasyLoading.dismiss();

          EmployerTransactionModelClass txn_token_data = modelResponse as EmployerTransactionModelClass;

          print(
              'txn data : ' + '${txn_token_data.data![0].body!.txnToken}');

          //global variable for txnToken
          orderid = TxnOrderId;
          amount = amt;
          txnToken = txn_token_data.data![0].body!.txnToken;

          print("show the request success");
          completeTransaction();

        }, employerFailureBlock:<T>(commonResponse,failure)
        {
          print("show the request error");
          EasyLoading.dismiss();

          CJTalentCommonModelClass paymentModelClass=commonResponse as CJTalentCommonModelClass;
          if (paymentModelClass?.message==null || paymentModelClass?.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context, paymentModelClass!.message!);
          }

        }
        )
    );
  }


  //bottommodal sheet
  Widget buildsheet(StateSetter setNewState)
  {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, top: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please use the following details to complete the bank transfer:',
              style: TextStyle(
                  fontSize: large_FontSize,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Amount:₹ ${actual_data["amt"]}',
              style: TextStyle(
                  fontSize: large_FontSize,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Account No:13092790000308',
              style: TextStyle(
                color: Colors.black,
                fontSize: medium_FontSize,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Text('Bank Name: HDFC BANK',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: medium_FontSize,
                )),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            SizedBox(
              height: 7,
            ),
            Text('IFSC Code: HDFC0001664',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: medium_FontSize,
                )),
            SizedBox(
              height: 10,
            ),

            Divider(
              height: 1,
              thickness: 1,
            ),
            SizedBox(
              height: 20,
            ),

            Center(child: Container(height: 30,child: InkWell(onTap: ()
              {

                Navigator.pop(context);
                createBodyWebApi_UpdateManualBankTransfer();

              },child: Text("Bank Transfer",
              style: TextStyle(color: darkBlueColor,fontWeight: semiBold_FontWeight,
                  fontFamily: robotoFontFamily,fontSize: large_FontSize),),),),),


            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
  //bottom modal sheet end


/*
  UPIDetails createTheUPIId()
  {
    final upiDetails = UPIDetails(
        upiID: "akalinfo.02@hdfcbank",
        payeeName: "Akal Information Systems Ltd.",
        amount: double.parse(actual_data["amt"]),
        transactionID: actual_data["orderId"]);
    return upiDetails;
  }
*/

/*
  Widget UPI_BottomSheet(StateSetter setNewState, UPIDetails upiDetails) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, top: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'To transfer amount through UPI, please scan the QR code:',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            UPIPaymentQRCode(
              upiDetails: upiDetails,
              size: 150,
            )
          ],
        ),
      ),
    );
  }
*/


  Future<void> completeTransaction() async {

    try {
      var response = AllInOneSdk.startTransaction(
          merchantId!.toString(),
          orderid!.toString(),
          amount!.toString(),
          txnToken!.toString(),
          callbackurl!.toString(),
          isStaging,
          restrictAppInvoke);
      response.then((value)
      {
        // print(value);
        setState(()
        {
          result = value.toString();
          print('Response successfully generated : ' + result);

          //showPaymentSuccessMessage("Payment is Successful");

          var snackBar = SnackBar(
            content: Text("Payment is Successful",style: TextStyle(color: Colors.green,fontSize: 16,fontFamily: robotoFontFamily),),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);


          if(widget.userArriveFrom==getEmployerAddStartingBalance)
          {
            TalentNavigation().pushTo(context, Employer_JoinerHome(liveModelObj: widget.liveModelObj,));
          }
          else if(widget.userArriveFrom==getEmployerAddPayment)
          {
            Navigator.pop(context,[Employer_NewPaymentPlan()]);
          }
          else if(widget.userArriveFrom==getEmployerAddPayout)
          {
            Navigator.pop(context);
          }
//

        });
      }).catchError((onError)
      {
        if (onError is PlatformException)
        {
          setState(()
          {
            result = "${onError.message} \n  ${onError.details}";
            print("platform exception  " + result.toString());
            // Fluttertoast.showToast(msg: result, timeInSecForIosWeb: 4);

            if(result=="" || result==null)
            {
              print("show the failure message first");

            }else
            {
              print("show the failure message second 1");

              showPaymentFailureMessage(result);
            }

          });
        }
        else
        {
          setState(() {
            result = onError.toString();
            print("Error:  " + result);
            if(result=="" || result==null)
              {
              }else
                {
                  print("show the failure message second 2");

                  showPaymentFailureMessage(result);
                }
          });
        }

      });
    } catch (err)
    {

      result = err.toString();
      if(result=="" || result==null)
      {
      }else
      {
        print("show the failure message second 3");

        showPaymentFailureMessage(result);
      }
    }
  }

  showPaymentFailureMessage(String message)
  {
    /*--------16 march 2023 discuss with yatendra sir start-----------*/
     message="Your payment was interrupted, please try again";
     /*--------16 march 2023 discuss with yatendra sir end-----------*/

     print("show the transaction status");
    var snackBar = SnackBar(
      content: Text(message,style: TextStyle(color: Colors.red,fontSize: 16,fontFamily: robotoFontFamily),),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if(widget.userArriveFrom==getEmployerAddStartingBalance)
      {
        Navigator.pop(context,[Employer_AddStartingBalance()]);
      }
    else if(widget.userArriveFrom==getEmployerAddPayment)
    {
      Navigator.pop(context,[Employer_NewPaymentPlan()]);

    }
    else if(widget.userArriveFrom==getEmployerAddPayout)
    {
      Navigator.pop(context);
    }

  }

  showPaymentSuccessMessage(String message)
  {

    var snackBar = SnackBar(
      content: Text(message,style: TextStyle(color: Colors.green,fontSize: 16,fontFamily: robotoFontFamily),),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);


    if(widget.userArriveFrom==getEmployerAddStartingBalance)
    {
      TalentNavigation().pushTo(context, Employer_JoinerHome(liveModelObj: widget.liveModelObj,));
    }
    else if(widget.userArriveFrom==getEmployerAddPayment)
    {
      Navigator.pop(context,[Employer_NewPaymentPlan()]);
    }
    else if(widget.userArriveFrom==getEmployerAddPayout)
    {
      Navigator.pop(context);
    }
  }

  createBodyWebApi_UPITransactionCallBackURL(String tpAccountId,String orderId)
  {//
    print("show step 1");
    var mapObject=getEmployer_UPITransactionCallBackURL_RequestBody(tpAccountId,orderId);
    serviceRequest_UPITransactionCallBackURL(mapObject);
  }
  serviceRequest_UPITransactionCallBackURL(Map mapObj)
  {
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_UPITransactionCallBackAPI,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          print("show step 2");

          CJTalentCommonModelClass modelClass=commonResponse as CJTalentCommonModelClass;
          CJSnackBar(context, modelClass!.message!);

        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          print("show step 3");
          CJTalentCommonModelClass modelObject=commonResponse as CJTalentCommonModelClass;
          print("show the verify message ${modelObject.message}");
          if (modelObject?.message==null || modelObject?.message=="")
          {
            CJSnackBar(context, "server  error!");
          }else
          {
            CJSnackBar(context, modelObject!.message!);
          }
        }));
  }


  /*-----------------update manual  bank transfer 16-2-2023 start----------------------*/
  createBodyWebApi_UpdateManualBankTransfer()
  {
    String orderId = actual_data["orderId"];
    String amt = actual_data["amt"];
    String customerAccountId = actual_data["customerAccountId"];

    var mapObject=getEmployer_UpdateManualBankTransfer_RequestBody(orderId,customerAccountId,amt);
    serviceRequest_UpdateManualBankTransfer(mapObject);

  }

  serviceRequest_UpdateManualBankTransfer(Map mapObj)
  {

    print("show the bank request $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_Payment_UpdateBankTransfer,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass modelClass=commonResponse as CJTalentCommonModelClass;
          widget.liveModelObj?.useForAddDOJStatus=Employee_UpdateManualBankTransfer;
          alertViewWithAction(modelClass!.message!);


        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass modelObject=commonResponse as CJTalentCommonModelClass;
          print("show the verify message ${modelObject.message}");
          if (modelObject?.message==null || modelObject?.message=="")
          {
            CJSnackBar(context, "server  error!");
          }else
          {
            CJSnackBar(context, modelObject!.message!);
          }
        }));
  }
  alertViewWithAction(String message)
  {
    var alertDialog = AlertDialog(
      content: Text(message,
        textAlign: TextAlign.center,),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      actions: [
//
        Center(child: TextButton(onPressed: () {

          Navigator.of(context).pop();

          /*---------28-2-2023 start--------*/
          if(widget.userArriveFrom==getEmployerAddStartingBalance)
          {
            TalentNavigation().pushTo(context, Employer_JoinerHome(liveModelObj: widget.liveModelObj,));
          }
          else
            {
              TalentNavigation().pushTo(
                  context, Employer_TabBarController(liveModelObj: widget.liveModelObj,));
            }
          /*---------28-2-2023 end--------*/

        },

          child: Text("OK",style:TextStyle(fontSize: 18,color: Color(0xff00BFFF),),),),),
      ],

    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => alertDialog

    );
  }

/*-----------------update manual  bank transfer 16-2-2023 end----------------------*/

}
