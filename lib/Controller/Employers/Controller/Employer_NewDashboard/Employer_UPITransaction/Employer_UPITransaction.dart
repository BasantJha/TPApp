import 'dart:convert';
import 'package:contractjobs/Controller/Talents/ModelClasses/CJTalentCommonModelClass.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/Services/AESAlgo/EncryptedMapBody.dart';
import 'package:contractjobs/Services/AESAlgo/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../EmployerModelClasses/EmployerUPITransactionModelClass/EmployerUPITransactionModelClass.dart';
import 'WebviewScaffoldScreen.dart';

class Employer_UPITransaction extends StatefulWidget {
  final amount;
  final orderId;
  final tpAccountId;
  const Employer_UPITransaction({super.key, this.amount, this.orderId, this.tpAccountId});

  @override
  State<Employer_UPITransaction> createState() => _Employer_UPITransaction();
}

class _Employer_UPITransaction extends State<Employer_UPITransaction>
{
  TextEditingController userInputForUPI = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userInputForUPI.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
      appBar: CJAppBar(getEmployer_PaymentTitle,
          appBarBlock: AppBarBlock(appBarAction: () {
            // print("show the action type");
            Navigator.pop(context);
          })),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50),
        child: Center(
          child: Column(
            children: [
              Text(
                "Pay Using UPI",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: "Enter Your UPI ID"),
                onChanged: (value)
                {
                  userInputForUPI.text = value.toString();
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(200.0, 70),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: ()
                  {
                        print(userInputForUPI.text);

                        if(userInputForUPI.text != "")
                          {
                            callHdfcApi(userInputForUPI.text);
                          }else
                            {
                              CJSnackBar(context, "Enter UPI ID");
                            }
                  },
                  child: Text(
                    'Pay',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  )),
            ],
          ),
        ),
      ),
    );
  }

//
  void callHdfcApi(String upiId) async
  {
    String MechantId = "HDFC000000000948";
    String OrderNO = widget.orderId;
    String amountToPay = widget.amount;
    String paymentType = "P2M";
    String TransactionType = "PAY";
    String TransactionDescription = "TESTING";
    // String UserUPI = upiId;
    String UserUPI = userInputForUPI.text;

    String finalRequest = "";
    finalRequest = MechantId +
        "|" +
        OrderNO +
        "||" +
        paymentType +
        "|" +
        TransactionType +
        "|" +
        TransactionDescription +
        "|" +
        UserUPI +
        "||" +
        amountToPay +
        "|||||||||NULL|NA";

    //finalRequest="HDFC000000000948|5P1V2328KIW5EMQDZH5D||P2M|PAY|TEST|||10.00||||||MEBR|1234567||null|NA";

    createBodyWebApi_UPITransaction(finalRequest);
    print("show the upi payment request $finalRequest");

  }

  createBodyWebApi_UPITransaction(String transactionRequest)
  {
    var mapObject=getEmployer_UPITransaction_RequestBody(transactionRequest);
    serviceRequest_UPITransaction(mapObject);
  }
  serviceRequest_UPITransaction(Map mapObj)
  {
    print("show the upi body data $mapObj");
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_UPITransactionAPI_MePayInetent,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        async {
          EasyLoading.dismiss();

//
          print("show the upi commonResponse $commonResponse");

          CJTalentCommonModelClass modelClass=commonResponse as CJTalentCommonModelClass;

          /*-------------15-2-2023 start-----------------*/
          //String getCommonData=getDecryptedData(modelClass.commonData.toString());
          String getCommonData=modelClass.commonData.toString();
          /*-------------15-2-2023 end-----------------*/

          if (getCommonData.toString().contains("SUCCESS"))
          {
            CJSnackBar(context, "SUCCESS");

            String url = "upi://pay?pa=tankhapay@hdfcbank&pn=AkalInfoys&mc=6012&tr=${widget.orderId}&mode=03&am=${widget.amount}&cu=INR";

            print("show the open url $url");
            if (await canLaunchUrl(Uri.parse(url)))
             {
                 launchUrl(Uri.parse(url));

                 //TalentNavigation().pushTo(context, WebviewScaffoldScreen(url:url, appBarTitle:"",withJavascript:true));
              }
            else
            {
              print("show the launch url status failure");

              throw "could not launch ";
            }
          } else
          {
            CJSnackBar(context, "FAILED");
          }


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


 /* createBodyWebApi_UPITransactionCallBackURL(String transactionRequest)
  {
    var mapObject=getEmployer_UPITransactionCallBackURL_RequestBody(widget.tpAccountId,widget.orderId);
    serviceRequest_UPITransactionCallBackURL(mapObject);
  }
  serviceRequest_UPITransactionCallBackURL(Map mapObj)
  {
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_UPITransactionCallBackAPI,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
         {
          EasyLoading.dismiss();

          CJTalentCommonModelClass modelClass=commonResponse as CJTalentCommonModelClass;
          CJSnackBar(context, modelClass!.message!);

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

*/

}
