class HRA_Save_ModelResponse
{
  bool? statusCode;
  var message;

  HRA_Save_ModelResponse({this.statusCode, this.message});

  HRA_Save_ModelResponse.fromJson(Map<String, dynamic> json) {
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