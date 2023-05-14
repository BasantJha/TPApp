class EmployerAmountFromInvoiceModel {
  String? msgcd;
  String? msg;
  int? emprSts;
  String? vUserType;
  String? employerid;
  String? startingPayAmt;

  EmployerAmountFromInvoiceModel(
      {this.msgcd,
      this.msg,
      this.emprSts,
      this.vUserType,
      this.employerid,
      this.startingPayAmt});

  EmployerAmountFromInvoiceModel.fromJson(Map<String, dynamic> json) {
    msgcd = json['msgcd'];
    msg = json['msg'];
    emprSts = json['empr_sts'];
    vUserType = json['v_user_type'];
    employerid = json['employerid'];
    startingPayAmt = json['starting_pay_amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgcd'] = this.msgcd;
    data['msg'] = this.msg;
    data['empr_sts'] = this.emprSts;
    data['v_user_type'] = this.vUserType;
    data['employerid'] = this.employerid;
    data['starting_pay_amt'] = this.startingPayAmt;
    return data;
  }
}
