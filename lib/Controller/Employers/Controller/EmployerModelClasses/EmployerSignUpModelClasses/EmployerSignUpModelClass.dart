
class EmployerSignUpModelClass {
  String? message;
  String? registrationType;
  String? employerMobile;
  bool? isMobileOtpVerify;

  EmployerSignUpModelClass(
      {this.message,
        this.registrationType,
        this.employerMobile,
        this.isMobileOtpVerify});

  EmployerSignUpModelClass.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    registrationType = json['registration_type'];
    employerMobile = json['employer_mobile'];
    isMobileOtpVerify = json['is_mobile_otp_verify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['registration_type'] = this.registrationType;
    data['employer_mobile'] = this.employerMobile;
    data['is_mobile_otp_verify'] = this.isMobileOtpVerify;
    return data;
  }
}