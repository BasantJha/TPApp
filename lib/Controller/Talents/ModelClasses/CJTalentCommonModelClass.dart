class CJTalentCommonModelClass {
  String? code;
  bool? statusCode;
  String? message;
  String? commonData;
  String? attendanceStatus;
  String? errorMessage;
  String? aadharVerificationStatus;

  var registrationFlag; //use for the phone number not registred(23-2-2023)
  var displayMessage;//use for the Attendance list top message and payout list top message(26-2-2023)





  CJTalentCommonModelClass({this.code, this.statusCode, this.message,
    this.commonData,this.attendanceStatus,this.errorMessage,
    this.aadharVerificationStatus,this.registrationFlag,this.displayMessage});

  CJTalentCommonModelClass.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    statusCode = json['statusCode'];
    message = json['message'];
    commonData = json['commonData'];
    attendanceStatus = json['attendanceStatus'];
    errorMessage = json['errorMessage'];
    aadharVerificationStatus = json['aadharVerificationStatus'];
    registrationFlag = json['registration_flag'];
    displayMessage = json['displayMessage'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['commonData'] = this.commonData;
    data['attendanceStatus'] = this.attendanceStatus;
    data['errorMessage'] = this.errorMessage;
    data['aadharVerificationStatus'] = this.aadharVerificationStatus;
    data['registration_flag'] = this.registrationFlag;
    data['displayMessage'] = this.displayMessage;

    return data;
  }
}