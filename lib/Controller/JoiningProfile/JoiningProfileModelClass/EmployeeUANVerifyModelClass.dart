class EmployeeUANVerifyModelClass {
  bool? statusCode;
  String? message;
  //List<Null>? data;

  EmployeeUANVerifyModelClass({this.statusCode, this.message});

  EmployeeUANVerifyModelClass.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
   /* if (json['data'] != null) {
      data = <Null>[];
      json['data'].forEach((v) {
        data!.add(new Null.fromJson(v));
      });
    }*/
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