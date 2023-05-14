
class TankhaPaySaveAttendanceModelClass {
  bool? statusCode;
  String? message;
  DataSave? data;

  TankhaPaySaveAttendanceModelClass({this.statusCode, this.message, this.data});

  TankhaPaySaveAttendanceModelClass.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new DataSave.fromJson(json['data']) : null;
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

class DataSave {
  bool? statusCode;
  String? message;
  String? commonData;

  DataSave({this.statusCode, this.message, this.commonData});

  DataSave.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    commonData = json['commonData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['commonData'] = this.commonData;
    return data;
  }
}