class Employer_GSTSendOTPModelClass {
  String? accountId;
  String? employerMobile;
  String? gstinNoIsverifyYN;
  String? acGstinNo;
  int? tpLeadId;
  String? employerId;
  String? employerName;
  String? acVerifyStatusid;
  String? signupFlag;
  int? employerStatus;
  String? accountStatus;
  String? clientId;


  Employer_GSTSendOTPModelClass(
      {this.accountId,
        this.employerMobile,
        this.gstinNoIsverifyYN,
        this.acGstinNo,
        this.tpLeadId,
        this.employerId,
        this.employerName,
        this.acVerifyStatusid,
        this.signupFlag,
        this.employerStatus,
        this.accountStatus,this.clientId});

  Employer_GSTSendOTPModelClass.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    employerMobile = json['employer_mobile'];
    gstinNoIsverifyYN = json['gstin_no_isverify_y_n'];
    acGstinNo = json['ac_gstin_no'];
    tpLeadId = json['tp_lead_id'];
    employerId = json['employer_id'];
    employerName = json['employer_name'];
    acVerifyStatusid = json['ac_verify_statusid'];
    signupFlag = json['signup_flag'];
    employerStatus = json['employer_status'];
    accountStatus = json['account_status'];
    clientId = json['client_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_id'] = this.accountId;
    data['employer_mobile'] = this.employerMobile;
    data['gstin_no_isverify_y_n'] = this.gstinNoIsverifyYN;
    data['ac_gstin_no'] = this.acGstinNo;
    data['tp_lead_id'] = this.tpLeadId;
    data['employer_id'] = this.employerId;
    data['employer_name'] = this.employerName;
    data['ac_verify_statusid'] = this.acVerifyStatusid;
    data['signup_flag'] = this.signupFlag;
    data['employer_status'] = this.employerStatus;
    data['account_status'] = this.accountStatus;
    data['client_id'] = this.clientId;

    return data;
  }
}