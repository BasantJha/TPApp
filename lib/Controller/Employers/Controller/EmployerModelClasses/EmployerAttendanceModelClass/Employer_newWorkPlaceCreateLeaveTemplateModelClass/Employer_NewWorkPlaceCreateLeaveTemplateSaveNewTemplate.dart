class Employer_NewWorkPlaceCreateLeaveTemplateSaveNewTemplate {
  bool? statusCode;
  String? message;
  List<Data>? data;

  Employer_NewWorkPlaceCreateLeaveTemplateSaveNewTemplate(
      {this.statusCode, this.message, this.data});

  Employer_NewWorkPlaceCreateLeaveTemplateSaveNewTemplate.fromJson(
      Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  bool? msgcd;
  String? msg;

  Data({this.msgcd, this.msg});

  Data.fromJson(Map<String, dynamic> json) {
    msgcd = json['msgcd'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgcd'] = this.msgcd;
    data['msg'] = this.msg;
    return data;
  }
}