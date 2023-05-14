import 'package:contractjobs/Controller/Employers/Controller/Employer_NewDashboard/Employer_NewPayment/tankha_payment_model.dart';
import 'package:contractjobs/Services/AESAlgo/encrypt.dart';
import 'package:contractjobs/Services/CJEmployerService/CJEmployerServiceURL.dart';
import 'package:contractjobs/Services/CJTalentsService/CJTalentServiceBody.dart';
import 'package:contractjobs/Services/CJTalentsService/CJTalentServiceRequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../Constant/ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../../EmployerModelClasses/EmployerAddBalanceModelClass/EmployerOrderIdForInvoiceModel.dart';
import '../../EmployerModelClasses/EmployerPaymentModelClass/EmployerPaymentPlanModelClass.dart';
import '../../EmployerModelClasses/EmployerPaymentModelClass/PaymentInvoiceModelClass.dart';
import '../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'Employer_NewPaymentGateway.dart';
import 'Employer_NewPaymentInvoice.dart';

var paymentsPlans = getEmployerPayment;

class Employer_NewPaymentPlan extends StatefulWidget {

  const Employer_NewPaymentPlan({super.key, this.liveModelObj});
  final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  State<Employer_NewPaymentPlan> createState() => _Employer_NewPaymentPlan();
}

class _Employer_NewPaymentPlan extends State<Employer_NewPaymentPlan> {
  int? _value;


  String paymentTitle = "";
  String amt = "";
  int wrkr = 0;

  String customerAccountId = "";
  String baseAmount = "";
  int numberOfEmployees = 0;


  bool apiRequest=false;

  EmployerPaymentPlanModelClass? payPlansData;


  @override
  void initState()
  {
    super.initState();
    paymentPlanService_BodyRequest();
    _value = -1;


    //var data=getDecryptedData("yvzZPUav+3EJlrr3sxXjYF16pRzup1By1BSIL/rizTJy8cWrLEUZwme9D8kLI0DchtRdxUs9kHqwqjrCalVYAsGZerq6HgPxXANHv7O32tqatxYLa5fxdOQRUAVOQIeJvPh8XcbOyy2AUyWtg0KfJPGO2Fj5WRTkpPx7grhUE7GLwbS3Kq13Qk8uCLn2ovqfqYVuT+/a22d7vlDpSpStJj9cVEy2GCuqGQsKfKF4xSpIkMXVQxb/Y2dNjAbySZ+q1yWAQzKQMhaADPu0uimBPaCyxWgiGP46gaohGY84q6w6yCEQw3TKgrmR9kXbbcb+ES9Cs58CSataaAXwnYtxEv8PpaEEwaaA3lvjHW6iBT9hqZ+x3OpUsGDWiHrKHO33vwzDM4WhG+ZYviZKhfDmKvXAO3Ax007vO/u37V00YxjzivTQP2Q6/CjlU3hCpuc2Z7QsE9+3vB005OUUpcmzxPgbtal8xN1dENUo8k0NKGlVynuySibKjfnLUwKQUfgGomF36flfuBxExnFeGXKnCf63NQIV8cjSi7/hwSL0O+MWKMT6uhOcc/LAlPAnlRGe8k5ZAWN8zAuNZ7dlSo5879nE5j3wMA1Ez4syM2oJxr3FPvVmmHNy1x6I0ALuwdt2aHAn3UINngtbMfIQrLX6uRAwH/uDjaG0TO6U+ICgBM1ixc/jLxxNFSrb4HL6racof5HQsyA9bunIvx/WHe9Zn4BxutZA+bhL9dlSxlZeHp7ySRO4hHFgr76IJU/1YTPMZCPyCAyTLmqAeSaNDAXdV1oFFxjwUZyeXm/POrk4QE4=");
    //print("show the total plans $data");

  }

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
        child: Scaffold(
      backgroundColor: whiteColor,
      appBar: CJAppBar(getEmployer_Payments,
          appBarBlock: AppBarBlock(appBarAction: () {
        print("show the action type");
        Navigator.pop(context);
      })),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Select the add-in amount of your choice:",
                  style: TextStyle(
                    color: darkBlueColor,
                    fontSize: largeExcel_FontSize,
                    fontWeight: bold_FontWeight,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 0,
                shape: Border(
                    left: BorderSide(color: darkGreyColor),
                    top: BorderSide(color: darkGreyColor),
                    right: BorderSide(color: darkGreyColor),
                    bottom: BorderSide(
                      width: 4,
                      color: lightBlueColor,
                    )),
                child: apiRequest ==true ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: payPlansData!.data!.plandesc!.length,
                    itemBuilder: (context, index)
                    {
                      
                      var pp = payPlansData!.data!.plandesc![index];
                      var totalWorkers=pp.workers!;
                      return payTile(pp.plandesc.toString(), pp.amount.toString(), totalWorkers, index);
                      
                    },
                    separatorBuilder: (context, index) {
                      return dividerM();
                    },
                  )):Container(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: _value! < 0 ? null : getPaymentNow(),
    ));
  }



  Padding getPaymentNow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: lightBlueColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () {

          viewInvoiceService_BodyRequest();
          // paymentModal(context);
        },
        child: ListTile(
          title: Text(
            paymentTitle,
            style: TextStyle(color: whiteColor, fontSize: medium_FontSize),
          ),
          subtitle: Text(amt,
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
    );
  }

  Widget payTile(String title, String amount, String worker, int index) {
    return Column(
      children: [
        ListTile(
          // leading: Icon(
          //   Icons.calendar_month,
          //   size: 50,
          //   color: lightBlueColor,
          // ),
          leading: ImageIcon(
            AssetImage(Employer_Icon_BlueCalendarIcon),
            color: lightBlueColor,
            size: 40,
          ),
          title: Text(
            title,
            style: TextStyle(color: blackColor, fontWeight: bold_FontWeight),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Amount Rs. $amount",
                style: TextStyle(
                  color: blackColor,
                ),
              ),
              Text("Employees: $worker"),
            ],
          ),
          trailing: Radio(
            activeColor: lightBlueColor,
            value: index,
            groupValue: _value,
            onChanged: (val)
            {
              setState(()
              {
                _value = val!;
                paymentTitle = title;
                amt = amount;
                wrkr=int.parse(worker);

                print("show the payment tile $paymentTitle");
                print("show the _value $_value");
                print("show the amt $amt");
                print("show the wrkr $wrkr");
//
              });
            },
          ),
        ),
        // dividerM(),
      ],
    );
  }

  viewInvoiceService_BodyRequest()
  {
    baseAmount = amt.toString();
    numberOfEmployees = wrkr.toInt();

    EasyLoading.show(status: Message.get_LoaderMessage);

    var mapObj = get_ViewInvoice_RequestBody(widget.liveModelObj?.tpAccountId, baseAmount, numberOfEmployees);
    serviceRequest(mapObj);

  }

  serviceRequest(Map mapObj)
  {
    print("sucess till now 1");


    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_Employer_ViewInvoice,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        async {
          print("print Details model response $modelResponse");
          EasyLoading.dismiss();

          PaymentInvoiceModelClass invoice_data = modelResponse as PaymentInvoiceModelClass;

          /*----------------22-2-2023 start----------*/
          //await Employer_NewPaymentInvoice().showBottomSheetMethod(context,invoice_data,paymentTitle,getEmployerAddPayment,widget.liveModelObj!);

          TalentNavigation().pushTo(context, Employer_NewPaymentInvoice(InvoiceModel:invoice_data,ttl:paymentTitle,RedirectToPage:getEmployerAddPayment,liveModel:widget.liveModelObj!));

          /*----------------22-2-2023 end----------*/


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


  paymentPlanService_BodyRequest() async
  {
    var mapObj = get_paymentsPlans_requestBody(widget.liveModelObj?.tpAccountId);

    await paymentPlan_ServiceRequest(mapObj);
  }

  paymentPlan_ServiceRequest(Map mapObj) async
  {
    print("show the request");
    print("show the request object - $mapObj");


    EasyLoading.show(status: Message.get_LoaderMessage);

    await CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_Employer_PaymentsPlan,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          print("print Details model response $modelResponse");
          EasyLoading.dismiss();

          setState(()
          {
            apiRequest=true;
            payPlansData = modelResponse as EmployerPaymentPlanModelClass;

            var pp = payPlansData!.data!.plandesc![0];
            var totalWorkers=pp.workers!;
            var amount=pp.amount!;
            var title=pp.plandesc!;

            _value = 0;
            paymentTitle = title;
            amt = amount;
            wrkr=int.parse(totalWorkers);

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


  Padding dividerM() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 10, 15),
      child: Divider(
        thickness: 1,
        height: 2,
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
}
