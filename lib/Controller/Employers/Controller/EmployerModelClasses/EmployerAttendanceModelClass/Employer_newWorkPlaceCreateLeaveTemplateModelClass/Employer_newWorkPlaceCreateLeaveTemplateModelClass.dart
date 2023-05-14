class Employer_newWorkPlaceCreateLeaveTemplateModelClass {
  bool? statusCode;
  String? message;
  List<Data>? data;

  Employer_newWorkPlaceCreateLeaveTemplateModelClass(
      {this.statusCode, this.message, this.data});

  Employer_newWorkPlaceCreateLeaveTemplateModelClass.fromJson(
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
  String? leavetype;

  Data({this.leavetype});

  Data.fromJson(Map<String, dynamic> json) {
    leavetype = json['leavetype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leavetype'] = this.leavetype;
    return data;
  }
}