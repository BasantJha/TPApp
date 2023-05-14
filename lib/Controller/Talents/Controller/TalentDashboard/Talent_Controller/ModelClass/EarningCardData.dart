import 'package:flutter/cupertino.dart';

class Ernd {
  String? title;
  String? subtitle;
  String? image;
  String? buttontxt;
  Widget? page;

  Ernd({this.title, this.subtitle, this.image, this.buttontxt, this.page});
}

class PassbookCashKhata {
  String? transactionType;
  String? transactionDateTime;
  String? transactionAmt;
  String? transactionAmtZero;

  PassbookCashKhata({this.transactionType, this.transactionDateTime, this.transactionAmt, this.transactionAmtZero});
}

class BillRaiseChooseEmployer
{
  final String companyname;
  final String mobileno;
  final String email;
  final  companylogo;

  BillRaiseChooseEmployer({required this.companyname, required this.mobileno,  required this.email, this.companylogo});
}

class Talent_SalaryStatusM
{
   String? month;
   String? dateRange;

   Talent_SalaryStatusM({this.month,this.dateRange});

}


//Sl_slip(month: "August 2022", dateRange: "01/08/2022 - 31/08/2022"),
