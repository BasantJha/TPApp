class ViewInsuranceCard_ModelResponse {
  bool? statusCode;
  var message;
  Data? data;

  ViewInsuranceCard_ModelResponse({this.statusCode, this.message, this.data});

  ViewInsuranceCard_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var empCode;
  var empName;
  var empGender;
  var empAge;
  var insuranceCompanyName;
  var policyStartDate;
  var policyEndDate;
  var policyNo;
  var premium;
  var memberStatus;
  var memberCount;
  var companyLogoPath;
  var insuranceProviderType;
  var thirdPartyDocumentPath;

  Data(
      {this.empCode,
        this.empName,
        this.empGender,
        this.empAge,
        this.insuranceCompanyName,
        this.policyStartDate,
        this.policyEndDate,
        this.policyNo,
        this.premium,
        this.memberStatus,
        this.memberCount,
        this.companyLogoPath,
        this.insuranceProviderType,
        this.thirdPartyDocumentPath});

  Data.fromJson(Map<String, dynamic> json) {
    empCode = json['emp_code'];
    empName = json['emp_name'];
    empGender = json['emp_gender'];
    empAge = json['emp_age'];
    insuranceCompanyName = json['insurance_company_name'];
    policyStartDate = json['policy_start_date'];
    policyEndDate = json['policy_end_date'];
    policyNo = json['policy_no'];
    premium = json['premium'];
    memberStatus = json['member_status'];
    memberCount = json['member_count'];
    companyLogoPath = json['company_logo_path'];
    insuranceProviderType = json['insurance_provider_type'];
    thirdPartyDocumentPath = json['third_party_document_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_code'] = this.empCode;
    data['emp_name'] = this.empName;
    data['emp_gender'] = this.empGender;
    data['emp_age'] = this.empAge;
    data['insurance_company_name'] = this.insuranceCompanyName;
    data['policy_start_date'] = this.policyStartDate;
    data['policy_end_date'] = this.policyEndDate;
    data['policy_no'] = this.policyNo;
    data['premium'] = this.premium;
    data['member_status'] = this.memberStatus;
    data['member_count'] = this.memberCount;
    data['company_logo_path'] = this.companyLogoPath;
    data['insurance_provider_type'] = this.insuranceProviderType;
    data['third_party_document_path'] = this.thirdPartyDocumentPath;
    return data;
  }
}