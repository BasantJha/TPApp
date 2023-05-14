class SendOTP_ModelResponse {
  bool? statusCode;
  String? message;
  Data? data;

  SendOTP_ModelResponse({this.statusCode, this.message, this.data});

  SendOTP_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  var empMobile;
  var empEmail;
  var empPancardNumber;
  var empMobileOtp;

  Data(
      {this.empCode,
        this.empName,
        this.empMobile,
        this.empEmail,
        this.empPancardNumber,
        this.empMobileOtp});

  Data.fromJson(Map<String, dynamic> json) {
    empCode = json['emp_code'];
    empName = json['emp_name'];
    empMobile = json['emp_mobile'];
    empEmail = json['emp_email'];
    empPancardNumber = json['emp_pancard_number'];
    empMobileOtp = json['emp_mobile_otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_code'] = this.empCode;
    data['emp_name'] = this.empName;
    data['emp_mobile'] = this.empMobile;
    data['emp_email'] = this.empEmail;
    data['emp_pancard_number'] = this.empPancardNumber;
    data['emp_mobile_otp'] = this.empMobileOtp;
    return data;
  }
}