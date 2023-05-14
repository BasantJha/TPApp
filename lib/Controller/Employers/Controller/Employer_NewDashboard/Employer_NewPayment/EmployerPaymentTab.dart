import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Controller/Employers/Controller/Employer_NewDashboard/Employer_NewPayment/tankha_payment_model.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/Services/CJEmployerService/CJEmployerServiceURL.dart';
import 'package:contractjobs/Services/CJTalentsService/CJTalentServiceBody.dart';
import 'package:contractjobs/Services/CJTalentsService/CJTalentServiceRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../Constant/ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../EmployerDashboard/Employer_LeftDrawer/Employer_LeftDrawer.dart';
import '../../EmployerModelClasses/EmployerPaymentModelClass/EmployerAvailable_Balance_Model.dart';
import '../../EmployerModelClasses/EmployerPaymentModelClass/EmployerLatestTransactionModelClass.dart';
import '../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'EmployerLatestTransaction.dart';
import 'Employer_NewPaymentPlan.dart';

var lttranslist = [
  EmployerLatestTransaction(
      title: "Oct'22 Salary Paid",
      status: "Success",
      date: "13 oct 2002",
      time: "09.55 AM",
      amount: "4,5000"),
  EmployerLatestTransaction(
      title: "Sep'22 Salary Paid",
      status: "Success",
      date: "13 sep 2002",
      time: "09.55 AM",
      amount: "4,5000"),
];

class EmployerPaymentTab extends StatefulWidget
{
  const EmployerPaymentTab({super.key, this.liveModelObj, this.employerPaymentVisibility});
  final Employer_VerifyMobileNoModelClass? liveModelObj;
  final bool? employerPaymentVisibility;


  @override
  State<EmployerPaymentTab> createState() => _EmployerPaymentTab();
}

class _EmployerPaymentTab extends State<EmployerPaymentTab> {
  final List<CircleInfo> circles = [
    CircleInfo(
        size: Size(500, 180),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff93d9fd), Color(0xff3cbbfb)]),
        alignment: Alignment.topCenter),
  ];

  String availableAmount = "0";
  String customerAccountId = "";

  String transaction_flag = "";
  String status = "";
  bool apiRequest=false;

  EmployerLatestTransactionModelClass? lt_transactions;

//

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    availableBalance_ServiceRequestBody();
    latestTransactionServiceBodyRequest("Latest","Paid");

  }

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: Scaffold(
        drawer: EmployerNavigation_Drawer(liveModelObj: widget.liveModelObj,),
        backgroundColor: whiteColor,
        appBar: widget.employerPaymentVisibility! ? CJAppBarBgBlue("", appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show 1the action 1type");
          Navigator.pop(context);
        })): null,
        body:
           CirclesBackground(
            circles: circles,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Text(
                      "Payments",
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 25,
                          fontFamily: robotoFontFamily,
                          fontWeight: bold_FontWeight),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "Available Balance",
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: medium_FontSize,
                            fontWeight: semiBold_FontWeight,
                          ),
                        ),
                        Text(
                          "₹ ${availableAmount.toString()}",
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minimumSize: Size(350, 50)),
                      onPressed: ()
                      {
                        pushTo(context, Employer_NewPaymentPlan(liveModelObj: widget.liveModelObj,));
                      },
                      child: Text(
                        "ADD BALANCE",
                        style: TextStyle(color: Colors.grey[800], fontSize: 20),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Latest Transactions",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 20,
                              fontWeight: bold_FontWeight,
                            ),
                          ),
                          Center(
                            child: InkWell(
                              onTap: ()
                              {
                                latestTransactionServiceBodyRequest("All", "All");
                              },
                              child: Text(
                                "View All",
                                style: TextStyle(fontFamily: robotoFontFamily,fontWeight: FontWeight.bold,
                                  color: lightBlueColor,
                                  fontSize: medium_FontSize,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    apiRequest == true ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: lt_transactions!.data!.length,

                          itemBuilder: (context, index)
                          {
                            var lt = lt_transactions!.data![index];
                /*            return latestTransactionTile(
                                "${lt.tranmonth.toString()} ${lt.packagename.toString()}",
                                lt.status.toString(),
                                lt.trantime.toString(),
                                "",
                                lt.netamountreceived.toString());*/

                          return  latestTransactionTile(lt.transactionid.toString(),lt.dateofreceiving.toString(),lt.invoiceno.toString(),
                                lt.paymentmethod.toString(),
                                "${lt.tranmonth.toString()} ${lt.packagename.toString()}",
                                lt.status.toString(),
                                lt.trantime.toString(),
                                "",
                                lt.netamountreceived.toString());


                          },
                        ),
                      ),
                    ):Container()
                  ],
                ),
              ),
            ),
          ),

      ),
    );
  }
  pushTo<T>(BuildContext context,navigateView)
  {
    Navigator.push(context, MaterialPageRoute(builder: (_)=>

        Responsive(
            mobile: navigateView,
            tablet: Center(
              child: Container(
                width: webResponsive_TD_Width,
                child: navigateView,
              ),
            ),

            desktop: Center(
              child: Container(
                width: webResponsive_TD_Width,
                child: navigateView,
              ),
            )
        )
    )
    ).then((value)
    {
      latestTransactionServiceBodyRequest("Latest","Paid");

    });
  }

 /* Padding latestTransactionTile(
      String title, String status, String date, String time, String amount)*/

  Padding latestTransactionTile(
      String transactionId,String dateOfReceiving,String invoiceNo,String paymentMethod,
      String title, String status, String date, String time, String amount)

  {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          //<-- SEE HERE
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        margin: EdgeInsets.zero,
        elevation: 0,
        child:InkWell(onTap: ()
          async {

              await showTransactionDescription(context, transactionId,dateOfReceiving,invoiceNo,paymentMethod,
                title,status, date, time, amount);

          },child: Padding(padding: EdgeInsets.only(top: 4,bottom: 5),child:  ListTile(
          dense: true,
          minVerticalPadding: 0,
          leading: Image.asset(
            Employer_Icon_Paid,
            scale: 0.8,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: blackColor,
              fontSize: medium_FontSize,
              fontWeight: bold_FontWeight,
            ),
          ),
          subtitle: Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              Text(
                "$status, ",
                style: TextStyle(
                  color: status == "Paid" ? Colors.green : Colors.red,
                  fontWeight: bold_FontWeight,
                ),
              ),
              Text(
                "$date, $time",
                style: TextStyle(
                  fontSize: smallLess_FontSize,
                  fontWeight: bold_FontWeight,
                ),
              )
            ],
          ),
          trailing: Text(
            "₹$amount",
            style: TextStyle(
              fontSize: large_FontSize,
              fontWeight: bold_FontWeight,
              color: Colors.grey[700],
            ),
          ),
        ),),),
      ),
    );
  }
  availableBalance_ServiceRequestBody()
  {
    var mapObj = get_availableBalance_Requerst_Body(widget.liveModelObj?.tpAccountId);

    availableBalance_ServiceRequest(mapObj);
  }

  availableBalance_ServiceRequest(Map mapObj)
  {
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_Employer_AvailableBalance,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          print("print Details model response $modelResponse");
          EasyLoading.dismiss();

          EmployerAvailable_Balance_Model avBalanceData = modelResponse as EmployerAvailable_Balance_Model;

          setState(() {
           availableAmount = avBalanceData.balance!.toString();
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

  latestTransactionServiceBodyRequest(String flag,String status)
  {
    transaction_flag = flag;
    status = status;

    var mapObj = getLatestTransactionRequestBody(widget.liveModelObj?.tpAccountId, transaction_flag, status);

    latestServiceRequest(mapObj);
  }
//
  latestServiceRequest(Map mapObj) async
  {
    print("show the request");
    print("show the request object - $mapObj");

    //EasyLoading.show(status: Message.get_LoaderMessage);

    await CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_Employer_Latest_Transactions,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          print("print Details model response $modelResponse");
          //EasyLoading.dismiss();
          setState(() {
            apiRequest=true;
            lt_transactions = modelResponse as EmployerLatestTransactionModelClass;
          });


        }, employerFailureBlock:<T>(commonResponse,failure)
        {
          //EasyLoading.dismiss();

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
}
