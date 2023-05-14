class InsuranceStatus_ModelResponse {
  bool? statusCode;
  var message;
  Data? data;

  InsuranceStatus_ModelResponse({this.statusCode, this.message, this.data});

  InsuranceStatus_ModelResponse.fromJson(Map<String, dynamic> json) {
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
  String insuranceStatusCode="";

  Data({required this.insuranceStatusCode});

  Data.fromJson(Map<String, dynamic> json) {
    insuranceStatusCode = json['insurance_status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['insurance_status_code'] = this.insuranceStatusCode;
    return data;
  }
}