import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../Constant/ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';

class tankhaPaymentModel {
  String? title;
  String? amount;
  String? worker;

  tankhaPaymentModel({this.title, this.amount, this.worker});

  tankhaPaymentModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    amount = json['amount'];
    worker = json['worker'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['worker'] = this.worker;
    return data;
  }
}

var getEmployerPayment=[
  tankhaPaymentModel(
      title: "1 month Payroll Amount", amount: "30,000", worker: "4"),
  tankhaPaymentModel(
      title: "3 month Payroll Amount", amount: "90,000", worker: "4"),
  tankhaPaymentModel(
      title: "6 month Payroll Amount", amount: "180,000", worker: "4"),
  tankhaPaymentModel(
      title: "9 month Payroll Amount", amount: "270,000", worker: "4"),
  tankhaPaymentModel(
      title: "12 month Payroll Amount", amount: "360,000", worker: "4"),
];



Future<Future> showTransactionDescription(BuildContext context,String transactionId,String dateOfReceiving,String invoiceNo,String PaymentMethod,
    String title, String status, String date, String time, String amount)async
{

  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
   /* constraints: BoxConstraints(
      maxWidth:  MediaQuery.of(context).size.width>=1100 ? webResponsive_TD_Width:MediaQuery.of(context).size.width,
    ),*/
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child:  Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                color: Colors.transparent,
                // padding: EdgeInsets.only(top: topSpace),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: mainUILeftRightPadding,
                          bottom: mainUILeftRightPadding),
                      child: FloatingActionButton(
                        onPressed: () => Navigator.pop(context),
                        backgroundColor: Colors.white,
                        child: Image(
                            image: AssetImage(TankhaPay_Icon_CloseCrossIcon)),
                      ),
                    ),
                  ],
                ),
              ),
              /*-----use below--*/
              Container(
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      )),
                  child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("$title",
                              style: TextStyle(
                                color: darkBlueColor,
                                fontSize: large_FontSize,fontFamily: robotoFontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            ),//
                            SizedBox(height: 10),
                            Text(
                              "₹ $amount",
                              style: TextStyle(
                                  fontWeight: bold_FontWeight,
                                  fontSize: large_FontSize,
                                  fontFamily: robotoFontFamily
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                status == "Paid" ?
                                Image.asset(Payment_CheckMark_Icon,height: 20,width: 20,)
                                    : Image.asset(Payment_CheckMark_Icon,height: 20,width: 20,color: redColor,),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(status),
                              ],
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              width: 250,
                              child: Divider(
                                color: darkGreyColor,
                                height: 8,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("$date $time",
                              style: TextStyle(
                                  color: darkGreyColor,
                                  fontFamily: robotoFontFamily,
                                  fontSize: medium_FontSize,
                                  fontWeight: normal_FontWeight
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(top: 5,bottom: 5,left: 20,right: 50),
                              decoration: BoxDecoration(
                                  color:  Color(0xffE5E5E5),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Invoice No.",
                                        style: TextStyle(
                                            fontWeight: bold_FontWeight,
                                            fontSize: medium_FontSize),
                                      ),
                                      Text(invoiceNo),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Transaction-ID",
                                        style: TextStyle(
                                            fontWeight: bold_FontWeight,
                                            fontSize: medium_FontSize),
                                      ),
                                      Text(transactionId),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Transaction date",
                                        style: TextStyle(
                                            fontWeight: bold_FontWeight,
                                            fontSize: medium_FontSize),
                                      ),
                                      Text(dateOfReceiving),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Payment Mode",
                                        style: TextStyle(
                                            fontWeight: bold_FontWeight,
                                            fontSize: medium_FontSize),
                                      ),
                                      Text(PaymentMethod),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  )),
            ],
          ),
        ),
      );
    },
  );
}