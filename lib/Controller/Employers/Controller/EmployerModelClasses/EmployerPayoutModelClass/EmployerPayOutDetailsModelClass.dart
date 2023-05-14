class EmployerPayOutDetailsModelClass {
  List<CustomerPayoutSummary>? customerPayoutSummary;
  List<CustomerPayoutDetails>? customerPayoutDetails;

  EmployerPayOutDetailsModelClass(
      {this.customerPayoutSummary, this.customerPayoutDetails});

  EmployerPayOutDetailsModelClass.fromJson(Map<String, dynamic> json) {
    if (json['customerPayoutSummary'] != null) {
      customerPayoutSummary = <CustomerPayoutSummary>[];
      json['customerPayoutSummary'].forEach((v) {
        customerPayoutSummary!.add(new CustomerPayoutSummary.fromJson(v));
      });
    }
    if (json['customerPayoutDetails'] != null) {
      customerPayoutDetails = <CustomerPayoutDetails>[];
      json['customerPayoutDetails'].forEach((v) {
        customerPayoutDetails!.add(new CustomerPayoutDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerPayoutSummary != null) {
      data['customerPayoutSummary'] =
          this.customerPayoutSummary!.map((v) => v.toJson()).toList();
    }
    if (this.customerPayoutDetails != null) {
      data['customerPayoutDetails'] =
          this.customerPayoutDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerPayoutSummary {
  var id;
  var workers;
  var payoutdate;
  var mprmonth;
  var mpryear;
  var amount;
  var status;
  var monthName;
  var monthFullName;
  var daysLeft;
  var paymentStatus;
  var approvedattendance;
  var totalemployees;
  var payoutdate1;

  CustomerPayoutSummary(
      {this.id,
        this.workers,
        this.payoutdate,
        this.mprmonth,
        this.mpryear,
        this.amount,
        this.status,
        this.monthName,
        this.monthFullName,
  this.daysLeft, this.paymentStatus, this.approvedattendance,this.totalemployees,
      this.payoutdate1});

  CustomerPayoutSummary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workers = json['workers'];
    payoutdate = json['payoutdate'];
    mprmonth = json['mprmonth'];
    mpryear = json['mpryear'];
    amount = json['amount'];
    status = json['status'];
    monthName = json['month_name'];
    monthFullName = json['month_full_name'];
    daysLeft = json['days_left'];
    paymentStatus = json['payment_status'];
    approvedattendance = json['approvedattendance'];
    totalemployees = json['totalemployees'];
    payoutdate1 = json['payoutdate1'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workers'] = this.workers;
    data['payoutdate'] = this.payoutdate;
    data['mprmonth'] = this.mprmonth;
    data['mpryear'] = this.mpryear;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['month_name'] = this.monthName;
    data['month_full_name'] = this.monthFullName;
    data['days_left'] = this.daysLeft;
    data['payment_status'] = this.paymentStatus;
    data['approvedattendance'] = this.approvedattendance;
    data['totalemployees'] = this.totalemployees;
    data['payoutdate1'] = this.payoutdate1;

    return data;
  }
}

class CustomerPayoutDetails {
  var empCode;
  var empName;
  var paiddays;
  var mprmonth;
  var mpryear;
  var amount;
  var approvalstatus;
  var photopath;
  var mobile;
  var dateofbirth;
  var payoutday;

  CustomerPayoutDetails(
      {this.empCode,
        this.empName,
        this.paiddays,
        this.mprmonth,
        this.mpryear,
        this.amount,
        this.approvalstatus,
        this.photopath,
        this.mobile,
        this.dateofbirth,
        this.payoutday});

  CustomerPayoutDetails.fromJson(Map<String, dynamic> json) {
    empCode = json['emp_code'];
    empName = json['emp_name'];
    paiddays = json['paiddays'];
    mprmonth = json['mprmonth'];
    mpryear = json['mpryear'];
    amount = json['amount'];
    approvalstatus = json['approvalstatus'];
    photopath = json['photopath'];
    mobile = json['mobile'];
    dateofbirth = json['dateofbirth'];
    payoutday = json['payoutday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_code'] = this.empCode;
    data['emp_name'] = this.empName;
    data['paiddays'] = this.paiddays;
    data['mprmonth'] = this.mprmonth;
    data['mpryear'] = this.mpryear;
    data['amount'] = this.amount;
    data['approvalstatus'] = this.approvalstatus;
    data['photopath'] = this.photopath;
    data['mobile'] = this.mobile;
    data['dateofbirth'] = this.dateofbirth;
    data['payoutday'] = this.payoutday;
    return data;
  }
}