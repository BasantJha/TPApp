class Employer_StateModelClass
{
  List<CommonStateList>? commonStateList;

  Employer_StateModelClass({this.commonStateList});

  Employer_StateModelClass.fromJson(Map<String, dynamic> json) {
    if (json['commonStateList'] != null) {
      commonStateList = <CommonStateList>[];
      json['commonStateList'].forEach((v) {
        commonStateList!.add(new CommonStateList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commonStateList != null) {
      data['commonStateList'] =
          this.commonStateList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommonStateList {
  int? id;
  String? state;

  CommonStateList({this.id, this.state});

  CommonStateList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    return data;
  }
}