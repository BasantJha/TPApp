


class Verify_Mobile_ModelResponse {
  bool? statusCode;
  String? message;
  Data? data;

  Verify_Mobile_ModelResponse({this.statusCode, this.message, this.data});

  Verify_Mobile_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  String? empMobileOtp;

  Data({this.empMobileOtp});

  Data.fromJson(Map<String, dynamic> json) {
    empMobileOtp = json['emp_mobile_otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_mobile_otp'] = this.empMobileOtp;
    return data;
  }
}