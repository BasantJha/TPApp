class EmployeeBankAccountVerifyModelClass {
  int? response;
  String? keyfield;
  String? verificationStatus;
  String? bankaccountno;
  String? ifsccode;
  String? bankname;
  String? bankbranch;
  String? fullname;
  String? cjcode;

  EmployeeBankAccountVerifyModelClass(
      {this.response,
        this.keyfield,
        this.verificationStatus,
        this.bankaccountno,
        this.ifsccode,
        this.bankname,
        this.bankbranch,
        this.fullname,
        this.cjcode});

  EmployeeBankAccountVerifyModelClass.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    keyfield = json['keyfield'];
    verificationStatus = json['verification_status'];
    bankaccountno = json['bankaccountno'];
    ifsccode = json['ifsccode'];
    bankname = json['bankname'];
    bankbranch = json['bankbranch'];
    fullname = json['fullname'];
    cjcode = json['cjcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['keyfield'] = this.keyfield;
    data['verification_status'] = this.verificationStatus;
    data['bankaccountno'] = this.bankaccountno;
    data['ifsccode'] = this.ifsccode;
    data['bankname'] = this.bankname;
    data['bankbranch'] = this.bankbranch;
    data['fullname'] = this.fullname;
    data['cjcode'] = this.cjcode;
    return data;
  }
}