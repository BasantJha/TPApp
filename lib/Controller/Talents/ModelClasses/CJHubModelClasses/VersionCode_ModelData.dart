class VersionCode_ModelData
{
  bool? statusCode;
  Data? data;

  VersionCode_ModelData({this.statusCode, this.data});

  VersionCode_ModelData.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  var deviceType;
  var versionCode;
  var versionDate;

  Data({this.deviceType, this.versionCode, this.versionDate});

  Data.fromJson(Map<String, dynamic> json) {
    deviceType = json['device_type'];
    versionCode = json['version_code'];
    versionDate = json['version_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device_type'] = this.deviceType;
    data['version_code'] = this.versionCode;
    data['version_date'] = this.versionDate;
    return data;
  }
}
