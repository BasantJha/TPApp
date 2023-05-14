
class VerifyOTP_ModelResponse {
  bool? statusCode;
  String? message;
  Data? data;

  VerifyOTP_ModelResponse({this.statusCode, this.message, this.data});

  VerifyOTP_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var userId;
  var empCode;
  var empId;
  var jsId;
  var empName;
  var empMobile;
  var empEmail;
  var empPancardNumber;
  var empGender;
  var jobType;
  var empFatherName;
  var empResidentialAddress;
  var empPhotoPath;
  var empDob;
  var empPinStatus;
  var empPin;
  var recordSource;
  var ecStatus;
  var customeraccountid;
  var financialYear;
  var tpCode;
  var termsConditionsAccepted;
  var doj;
  var supportNumber;


  Data(
      {this.userId,
        this.empCode,
        this.empId,
        this.jsId,
        this.empName,
        this.empMobile,
        this.empEmail,
        this.empPancardNumber,
        this.empGender,
        this.jobType,
        this.empFatherName,
        this.empResidentialAddress,
        this.empPhotoPath,
        this.empDob,
        this.empPinStatus,
        this.empPin,
        this.recordSource,
        this.ecStatus,
        this.customeraccountid,
        this.financialYear,
        this.tpCode,
        this.termsConditionsAccepted,
      this.doj,
      this.supportNumber});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    empCode = json['emp_code'];
    empId = json['emp_id'];
    jsId = json['js_id'];
    empName = json['emp_name'];
    empMobile = json['emp_mobile'];
    empEmail = json['emp_email'];
    empPancardNumber = json['emp_pancard_number'];
    empGender = json['emp_gender'];
    jobType = json['job_type'];
    empFatherName = json['emp_father_name'];
    empResidentialAddress = json['emp_residential_address'];
    empPhotoPath = json['emp_photo_path'];
    empDob = json['emp_dob'];
    empPinStatus = json['emp_pin_status'];
    empPin = json['emp_pin'];
    recordSource = json['record_source'];
    ecStatus = json['ec_status'];
    customeraccountid = json['customeraccountid'];
    financialYear = json['financial_year'];
    tpCode = json['tpCode'];
    termsConditionsAccepted = json['terms_conditions_accepted'];
    doj = json['doj'];
    supportNumber = json['supportNumber'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['emp_code'] = this.empCode;
    data['emp_id'] = this.empId;
    data['js_id'] = this.jsId;
    data['emp_name'] = this.empName;
    data['emp_mobile'] = this.empMobile;
    data['emp_email'] = this.empEmail;
    data['emp_pancard_number'] = this.empPancardNumber;
    data['emp_gender'] = this.empGender;
    data['job_type'] = this.jobType;
    data['emp_father_name'] = this.empFatherName;
    data['emp_residential_address'] = this.empResidentialAddress;
    data['emp_photo_path'] = this.empPhotoPath;
    data['emp_dob'] = this.empDob;
    data['emp_pin_status'] = this.empPinStatus;
    data['emp_pin'] = this.empPin;
    data['record_source'] = this.recordSource;
    data['ec_status'] = this.ecStatus;
    data['customeraccountid'] = this.customeraccountid;
    data['financial_year'] = this.financialYear;
    data['tpCode'] = this.tpCode;
    data['terms_conditions_accepted'] = this.termsConditionsAccepted;
    data['doj'] = this.doj;
    data['supportNumber'] = this.supportNumber;

    return data;
  }
}