

class EmployerPayOutModelClass
{
  List<CommonPayoutList>? commonPayoutList;

  EmployerPayOutModelClass({this.commonPayoutList});

  EmployerPayOutModelClass.fromJson(Map<String, dynamic> json) {
    if (json['commonPayoutList'] != null) {
      commonPayoutList = <CommonPayoutList>[];
      json['commonPayoutList'].forEach((v) {
        commonPayoutList!.add(new CommonPayoutList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commonPayoutList != null) {
      data['commonPayoutList'] =
          this.commonPayoutList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommonPayoutList {
  var id;
  var workers;
  var payoutdate;
  var mprmonth;
  var pYear;
  var amount;
  var status;
  var monthName;
  var monthFullName;
  var mpryear;
  var daysLeft;
  var paymentStatus;
  var approvedattendance;
  var totalemployees;
  var payoutSettings;
  var payoutdate1;

  CommonPayoutList(
      {this.id,
        this.workers,
        this.payoutdate,
        this.mprmonth,
        this.pYear,
        this.amount,
        this.status,
        this.monthName,
        this.monthFullName,
        this.mpryear,this.daysLeft, this.paymentStatus, this.approvedattendance,this.totalemployees,
        this.payoutSettings,this.payoutdate1});

  CommonPayoutList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workers = json['workers'];
    payoutdate = json['payoutdate'];
    mprmonth = json['mprmonth'];
    pYear = json['p_year'];
    amount = json['amount'];
    status = json['status'];
    monthName = json['month_name'];
    monthFullName = json['month_full_name'];
    mpryear = json['mpryear'];
    daysLeft = json['days_left'];
    paymentStatus = json['payment_status'];
    approvedattendance = json['approvedattendance'];
    totalemployees = json['totalemployees'];
    payoutSettings = json['payout_settings'];
    payoutdate1 = json['payoutdate1'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workers'] = this.workers;
    data['payoutdate'] = this.payoutdate;
    data['mprmonth'] = this.mprmonth;
    data['p_year'] = this.pYear;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['month_name'] = this.monthName;
    data['month_full_name'] = this.monthFullName;
    data['mpryear'] = this.mpryear;
    data['days_left'] = this.daysLeft;
    data['payment_status'] = this.paymentStatus;
    data['approvedattendance'] = this.approvedattendance;
    data['totalemployees'] = this.totalemployees;
    data['payout_settings'] = this.payoutSettings;
    data['payoutdate1'] = this.payoutdate1;


    return data;
  }
}