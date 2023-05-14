class TankhaPaySupportCreateQueryModelClass {
  bool? statusCode;
  String? message;

  TankhaPaySupportCreateQueryModelClass({this.statusCode, this.message});

  TankhaPaySupportCreateQueryModelClass.fromJson(Map<String, dynamic> json) {
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