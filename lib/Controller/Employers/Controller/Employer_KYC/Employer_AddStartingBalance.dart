import 'dart:convert';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';

import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/Services/AESAlgo/EncryptedMapBody.dart';
import 'package:contractjobs/Services/AESAlgo/encrypt.dart';
import 'package:contractjobs/Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import 'package:contractjobs/Services/CJTalentsService/CJTalentServiceBody.dart';
import 'package:contractjobs/Services/CJTalentsService/CJTalentServiceRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:http/http.dart' as http;
//
import '../../../../Constant/CJAppFlowConstants.dart';
import '../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../Services/Messages/Message.dart';
import '../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../EmployerModelClasses/EmployerAddBalanceModelClass/EmployerAmountFromInvoiceModel.dart';
import '../EmployerModelClasses/EmployerAddBalanceModelClass/EmployerInvoiceModel.dart';
import '../EmployerModelClasses/EmployerAddBalanceModelClass/EmployerOrderIdForInvoiceModel.dart';
import '../EmployerModelClasses/EmployerPaymentModelClass/PaymentInvoiceModelClass.dart';
import '../Employer_NewDashboard/Employer_NewPayment/Employer_NewPaymentGateway.dart';
import '../Employer_NewDashboard/Employer_NewPayment/Employer_NewPaymentInvoice.dart';
import '../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
//
class Employer_AddStartingBalance extends StatefulWidget
{
  const Employer_AddStartingBalance({super.key, this.liveModelObj});
  final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  State<Employer_AddStartingBalance> createState() => _Employer_AddStartingBalance();
}

class _Employer_AddStartingBalance extends State<Employer_AddStartingBalance> {
  String amount = '';
  //Map sendData = {};
  var paymentTitle = "Starting Payment";


  //variables for generating invoice
  String baseAmount = '';
  int NoOfEmp = 0;

  //amount api variable
  String emp_id = '';

  //variables for invoice screen
 /* var netAmount;
  var sgRate;
  var sgAmount;
  var sgstRate;
  var sgstAmount;
  var cgstRate;
  var cgstAmount;
  var igstRate;
  var igstAmount;
  var gstbaseamount;
  var customeraccountname;
  var customercontactname;
  var gstmode;
  var statecode;
  var ac_gstnumber;
  var customeraddress;

  var custaccountid;
  var no_of_emp;
  var gst_mode;
  var net_value;
  var source = "Web";
  var createdby = "1";
  var created_ip = ":::1";
  var invoice_type = "";
  var service_name = "";

  var package_name = "Starting Payment";*/


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAmountDetails();
    generateAmountForInvoice();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor: whiteColor,
      appBar: CJAppBar(getEmployer_AddStartingBalanceTitle,
          appBarBlock: AppBarBlock(appBarAction: ()
          {
            // print("show the action type");
            Navigator.pop(context);
          })),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: lightBlueColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () async
          {
            await generateMapForInvoice();

          },
          child: ListTile(
            title: Text(
              "Starting Payment",
              style: TextStyle(color: whiteColor, fontSize: medium_FontSize),
            ),
            subtitle: Text("₹$amount",
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 25,
                    fontWeight: bold_FontWeight)),
            trailing: Text(
              "Pay Now",
              style: TextStyle(color: whiteColor, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }



  Text billD(String text) => Text(
    text,
    style: TextStyle(
      color: Colors.grey[700],
      fontSize: medium_FontSize,
    ),
  );

  Text billDS(String text) => Text(
    text,
    style: TextStyle(
      color: Colors.grey[700],
      fontSize: small_FontSize,
    ),
  );


  generateAmountForInvoice() async {

    var MapForAmount = getMapForAmountInInvoice(widget.liveModelObj?.employerId!);
    await serviceRequestForAmount(MapForAmount);
  }

  serviceRequestForAmount(Map mapObj)
  {
    print(mapObj);
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_StartingPayment,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          print("print Details model response $modelResponse");
          EasyLoading.dismiss();

          EmployerAmountFromInvoiceModel amount_class_data = modelResponse as EmployerAmountFromInvoiceModel;
          setState(() {
            amount = amount_class_data.startingPayAmt!;
            // print('amount' + '$amount');
          });

        }, employerFailureBlock:<T>(commonResponse,failure)
        {
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

  generateMapForInvoice() async {

    // await generateAmountForInvoice();
    baseAmount = amount;
    print(baseAmount);
    NoOfEmp = 0;
    var InvoiceMap = getMapForInvoice(widget.liveModelObj?.tpAccountId!, baseAmount, NoOfEmp);
    serviceRequest(InvoiceMap);
  }

  serviceRequest(Map mapObj)
  {
    print("sucess till now 1");


    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_Employer_ViewInvoice,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
         {
          print("print Details model response $modelResponse");
          EasyLoading.dismiss();
//
          PaymentInvoiceModelClass invoice_data = modelResponse as PaymentInvoiceModelClass;
           tapToNavigate(invoice_data);

        }, employerFailureBlock:<T>(commonResponse,failure)
        {
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
  tapToNavigate(PaymentInvoiceModelClass invoice_data)
  async {

    /*----------------22-2-2023 start----------*/

    //await Employer_NewPaymentInvoice().showBottomSheetMethod(context,invoice_data,paymentTitle,getEmployerAddStartingBalance,widget.liveModelObj!);

    TalentNavigation().pushTo(context, Employer_NewPaymentInvoice(InvoiceModel:invoice_data,ttl:paymentTitle,RedirectToPage:getEmployerAddStartingBalance,liveModel:widget.liveModelObj!));

    /*----------------22-2-2023 end----------*/

  }
//
}
