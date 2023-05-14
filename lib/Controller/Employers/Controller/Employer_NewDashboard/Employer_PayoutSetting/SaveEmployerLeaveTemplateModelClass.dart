class SaveEmployerLeaveTemplateModelClass {
  int? payoutFrequencyDt;
  String? employermobile;
  String? customeraccountid;

  SaveEmployerLeaveTemplateModelClass(
      {this.payoutFrequencyDt, this.employermobile, this.customeraccountid});

  SaveEmployerLeaveTemplateModelClass.fromJson(Map<String, dynamic> json) {
    payoutFrequencyDt = json['payout_frequency_dt'];
    employermobile = json['employermobile'];
    customeraccountid = json['customeraccountid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payout_frequency_dt'] = this.payoutFrequencyDt;
    data['employermobile'] = this.employermobile;
    data['customeraccountid'] = this.customeraccountid;
    return data;
  }
}