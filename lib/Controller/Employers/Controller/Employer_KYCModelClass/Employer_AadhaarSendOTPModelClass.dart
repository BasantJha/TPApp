class Employer_AadhaarSendOTPModelClass {
  String? clientId;
  bool? otpSent;
  bool? ifNumber;
  bool? validAadhaar;

  Employer_AadhaarSendOTPModelClass({this.clientId, this.otpSent, this.ifNumber, this.validAadhaar});

  Employer_AadhaarSendOTPModelClass.fromJson(Map<String, dynamic> json) {
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