class Employer_AggreementModelClass {
  List<CommonAggreementList>? commonAggreementList;

  Employer_AggreementModelClass({this.commonAggreementList});

  Employer_AggreementModelClass.fromJson(Map<String, dynamic> json) {
    if (json['commonAggreementList'] != null) {
      commonAggreementList = <CommonAggreementList>[];
      json['commonAggreementList'].forEach((v) {
        commonAggreementList!.add(new CommonAggreementList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commonAggreementList != null) {
      data['commonAggreementList'] =
          this.commonAggreementList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommonAggreementList {
  int? id;
  String? employerAggreementDesc;
  String? employeeAggreementDesc;
  String? type;
  bool? status;

  CommonAggreementList({this.id, this.employerAggreementDesc, this.employeeAggreementDesc,this.type});

  CommonAggreementList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employerAggreementDesc = json['employer_aggreement_desc'];
    employeeAggreementDesc = json['employee_aggreement_desc'];

    type = json['type'];
    status=false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employer_aggreement_desc'] = this.employerAggreementDesc;
    data['employee_aggreement_desc'] = this.employeeAggreementDesc;

    data['type'] = this.type;
    data['status']=false;
    return data;
  }
}