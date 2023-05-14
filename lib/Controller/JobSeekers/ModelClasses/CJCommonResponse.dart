class CJCommonResponse {

  String? code;
  bool? status;
  String? data;

  CJCommonResponse({this.code, this.status, this.data});

  CJCommonResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }
}