class Employer_CityModelClass {
  List<CommonCityList>? commonCityList;

  Employer_CityModelClass({this.commonCityList});

  Employer_CityModelClass.fromJson(Map<String, dynamic> json) {
    if (json['commonCityList'] != null) {
      commonCityList = <CommonCityList>[];
      json['commonCityList'].forEach((v) {
        commonCityList!.add(new CommonCityList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commonCityList != null) {
      data['commonCityList'] =
          this.commonCityList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommonCityList {
  int? id;
  String? district;

  CommonCityList({this.id, this.district});

  CommonCityList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['district'] = this.district;
    return data;
  }
}