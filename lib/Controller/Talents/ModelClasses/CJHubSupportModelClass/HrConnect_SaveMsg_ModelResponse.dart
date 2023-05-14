class HrConnect_SaveMsg_ModelResponse {
  bool? statusCode;
  String? message;

  HrConnect_SaveMsg_ModelResponse({this.statusCode, this.message});

  HrConnect_SaveMsg_ModelResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}
