class chatApiResponse {
  String? code;
  bool? statusCode;
  String? message;
  String? commonData;

  chatApiResponse({this.code, this.statusCode, this.message, this.commonData});

  chatApiResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    statusCode = json['statusCode'];
    message = json['message'];
    commonData = json['commonData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['commonData'] = this.commonData;
    return data;
  }
}
