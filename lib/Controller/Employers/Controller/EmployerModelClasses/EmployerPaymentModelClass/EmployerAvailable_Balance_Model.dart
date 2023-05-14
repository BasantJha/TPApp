class EmployerAvailable_Balance_Model {
  var customeraccountid;
  var customeraccountname;
  var credit;
  var debit;
  var balance;

  EmployerAvailable_Balance_Model(
      {this.customeraccountid,
        this.customeraccountname,
        this.credit,
        this.debit,
        this.balance});

  EmployerAvailable_Balance_Model.fromJson(Map<String, dynamic> json) {
    customeraccountid = json['customeraccountid'];
    customeraccountname = json['customeraccountname'];
    credit = json['credit'];
    debit = json['debit'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customeraccountid'] = this.customeraccountid;
    data['customeraccountname'] = this.customeraccountname;
    data['credit'] = this.credit;
    data['debit'] = this.debit;
    data['balance'] = this.balance;
    return data;
  }
}
