class EmployerPaymentPlanModelClass {
  bool? statusCode;
  String? message;
  Data? data;

  EmployerPaymentPlanModelClass({this.statusCode, this.message, this.data});

  EmployerPaymentPlanModelClass.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
 /* int? customeraccountid;
  String? employees;
  int? numberofemployees;*/
  var customeraccountid;
  var employees;
  var numberofemployees;
  List<Plandesc>? plandesc;

  Data(
      {this.customeraccountid,
        this.employees,
        this.numberofemployees,
        this.plandesc});

  Data.fromJson(Map<String, dynamic> json) {
    customeraccountid = json['customeraccountid'];
    employees = json['employees'];
    numberofemployees = json['numberofemployees'];
    if (json['plandesc'] != null) {
      plandesc = <Plandesc>[];
      json['plandesc'].forEach((v) {
        plandesc!.add(new Plandesc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customeraccountid'] = this.customeraccountid;
    data['employees'] = this.employees;
    data['numberofemployees'] = this.numberofemployees;
    if (this.plandesc != null) {
      data['plandesc'] = this.plandesc!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plandesc {

 /* double? amount;
  int? planid;
  int? workers;
  String? plandesc;*/

  var amount;
  var planid;
  var workers;
  var plandesc;

  Plandesc({this.amount, this.planid, this.workers, this.plandesc});

  Plandesc.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    planid = json['planid'];
    workers = json['workers'];
    plandesc = json['plandesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['planid'] = this.planid;
    data['workers'] = this.workers;
    data['plandesc'] = this.plandesc;
    return data;
  }
}
