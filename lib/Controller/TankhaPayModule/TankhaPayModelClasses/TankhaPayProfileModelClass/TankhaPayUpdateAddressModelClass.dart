class TankhaPayUpdateAddressModelClass {
  String? code;
  bool? statusCode;
  String? message;
  CommonData? commonData;

  TankhaPayUpdateAddressModelClass({this.code, this.statusCode, this.message, this.commonData});

  TankhaPayUpdateAddressModelClass.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    statusCode = json['statusCode'];
    message = json['message'];
    commonData = json['commonData'] != null
        ? new CommonData.fromJson(json['commonData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.commonData != null) {
      data['commonData'] = this.commonData!.toJson();
    }
    return data;
  }
}

class CommonData {
  bool? statusCode;
  String? message;
  List<Null>? data;

  CommonData({this.statusCode, this.message, this.data});

  CommonData.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Null>[];
      json['data'].forEach((v) {
        //data!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    /*if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}