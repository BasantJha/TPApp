class EmployerAadhaarSendOTPModelClass {
  bool? statusCode;
  bool? aadharVerifiedStatus;
  String? message;
  Data? data;

  EmployerAadhaarSendOTPModelClass(
      {this.statusCode, this.aadharVerifiedStatus, this.message, this.data});

  EmployerAadhaarSendOTPModelClass.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    aadharVerifiedStatus = json['aadhar_verified_status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['aadhar_verified_status'] = this.aadharVerifiedStatus;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? clientId;
  bool? otpSent;
  bool? ifNumber;
  bool? validAadhaar;

  Data({this.clientId, this.otpSent, this.ifNumber, this.validAadhaar});

  Data.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    otpSent = json['otp_sent'];
    ifNumber = json['if_number'];
    validAadhaar = json['valid_aadhaar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.clientId;
    data['otp_sent'] = this.otpSent;
    data['if_number'] = this.ifNumber;
    data['valid_aadhaar'] = this.validAadhaar;
    return data;
  }
}