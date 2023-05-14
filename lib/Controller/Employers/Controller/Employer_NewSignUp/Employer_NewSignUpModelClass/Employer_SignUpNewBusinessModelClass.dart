class Employer_SignUpNewBusinessModelClass {
  String? message;
  //String? registrationType;
  String? employerMobile;
  String? userType;
  int? employerStatus;

  Employer_SignUpNewBusinessModelClass({this.message, /*this.registrationType,*/ this.employerMobile,this.userType, this.employerStatus});

  Employer_SignUpNewBusinessModelClass.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    //registrationType = json['registration_type'];
    employerMobile = json['employer_mobile'];
    userType = json['user_type'];
    employerStatus = json['employer_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    //data['registration_type'] = this.registrationType;
    data['employer_mobile'] = this.employerMobile;
    data['user_type'] = this.userType;
    data['employer_status'] = this.employerStatus;
    return data;
  }
}