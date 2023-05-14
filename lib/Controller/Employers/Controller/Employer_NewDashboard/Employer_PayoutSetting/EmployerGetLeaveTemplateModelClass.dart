

class EmployerGetLeaveTemplateModelClass {
  String? leaveDays;
  String? payoutType;
  String? payoutDate;

  EmployerGetLeaveTemplateModelClass(
      {this.leaveDays, this.payoutType, this.payoutDate});

  EmployerGetLeaveTemplateModelClass.fromJson(Map<String, dynamic> json) {
    leaveDays = json['leaveDays'];
    payoutType = json['payoutType'];
    payoutDate = json['payoutDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leaveDays'] = this.leaveDays;
    data['payoutType'] = this.payoutType;
    data['payoutDate'] = this.payoutDate;
    return data;
  }
}

