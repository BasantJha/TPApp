class NotificationViewModelResponse {
  bool? statusCode;
  var message;
  List<Data>? data;

  NotificationViewModelResponse({this.statusCode, this.message, this.data});

  NotificationViewModelResponse.fromJson(Map<String, dynamic> json) {
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
  String? invMessage;
  String? remarks;

  Data({this.invMessage, this.remarks});

  Data.fromJson(Map<String, dynamic> json) {
    invMessage = json['inv_message'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inv_message'] = this.invMessage;
    data['remarks'] = this.remarks;
    return data;
  }
}