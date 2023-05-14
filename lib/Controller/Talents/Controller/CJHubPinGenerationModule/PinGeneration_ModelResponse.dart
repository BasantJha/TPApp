class PinGeneration_ModelResponse {
  bool? statusCode;
  var message;

  PinGeneration_ModelResponse({this.statusCode, this.message});

  PinGeneration_ModelResponse.fromJson(Map<String, dynamic> json) {
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