class Employer_PanVerifyModelClass
{
  String? message;
  String? registrationType;
  String? employerMobile;
  int? employerStatus;

  Employer_PanVerifyModelClass(
      {this.message,
        this.registrationType,
        this.employerMobile,
        this.employerStatus});

  Employer_PanVerifyModelClass.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    registrationType = json['registration_type'];
    employerMobile = json['employer_mobile'];
    employerStatus = json['employer_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['registration_type'] = this.registrationType;
    data['employer_mobile'] = this.employerMobile;
    data['employer_status'] = this.employerStatus;
    return data;
  }
}