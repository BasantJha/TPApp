class EmployeePANVerifyModelClass {
  bool? statusCode;
  String? message;
  Data? data;

  EmployeePANVerifyModelClass({this.statusCode, this.message, this.data});

  EmployeePANVerifyModelClass.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? jsId;
  String? panNumber;
  String? fullName;
  String? clientId;
  String? responseStatus;
  String? jsonResponse;
  String? createdDate;
  String? ipAddress;

  Data(
      {this.id,
        this.jsId,
        this.panNumber,
        this.fullName,
        this.clientId,
        this.responseStatus,
        this.jsonResponse,
        this.createdDate,
        this.ipAddress});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jsId = json['js_id'];
    panNumber = json['pan_number'];
    fullName = json['full_name'];
    clientId = json['client_id'];
    responseStatus = json['response_status'];
    jsonResponse = json['json_response'];
    createdDate = json['created_date'];
    ipAddress = json['ip_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['js_id'] = this.jsId;
    data['pan_number'] = this.panNumber;
    data['full_name'] = this.fullName;
    data['client_id'] = this.clientId;
    data['response_status'] = this.responseStatus;
    data['json_response'] = this.jsonResponse;
    data['created_date'] = this.createdDate;
    data['ip_address'] = this.ipAddress;
    return data;
  }
}