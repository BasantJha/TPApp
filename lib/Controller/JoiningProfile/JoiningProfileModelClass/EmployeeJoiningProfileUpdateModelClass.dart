class EmployeeJoiningProfileUpdateModelClass {
  String? code;
  bool? statusCode;
  String? message;
  CommonData? commonData;

  EmployeeJoiningProfileUpdateModelClass({this.code, this.statusCode, this.message, this.commonData});

  EmployeeJoiningProfileUpdateModelClass.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    statusCode = json['statusCode'];
    message = json['message'];
    commonData = json['commonData'] != null
        ? new CommonData.fromJson(json['commonData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.commonData != null) {
      data['commonData'] = this.commonData!.toJson();
    }
    return data;
  }
}

class CommonData {
  int? response;
  String? keyfield;
  String? verificationStatus;
  String? cjcode;

  CommonData(
      {this.response, this.keyfield, this.verificationStatus, this.cjcode});

  CommonData.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    keyfield = json['keyfield'];
    verificationStatus = json['verification_status'];
    cjcode = json['cjcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['keyfield'] = this.keyfield;
    data['verification_status'] = this.verificationStatus;
    data['cjcode'] = this.cjcode;
    return data;
  }
}