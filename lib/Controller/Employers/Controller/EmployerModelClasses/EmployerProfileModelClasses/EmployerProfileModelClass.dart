class EmployerProfileModelClass {
  var accountId;
  var employerId;
  var tpCode;
  var employerName;
  var loginPin;
  var loginPinIsverifyYN;
  var aadharNoIsverifyYN;
  var panNoIsverifyYN;
  var gstinNoIsverifyYN;
  var panNo;
  var gstinNo;
  var userType;
  var deviceType;
  var isAttendanceApproval;
  var fullName;
  var employerMobile;
  var employerEmail;
  var isMobileOtpVerify;
  var companyName;
  var profilePhotoPath;
  var payoutFrequencyDt; //use the int type check the null value(important)
  var companyAddress;
  var companyAddress2;
  var companyTownCity;
  var companyState;
  var companyPincode;
  var billAddress;
  var billCity;
  int? cityId;
  var billState;
  int? stateId;
  var billPincode;
  var startPayment;

  EmployerProfileModelClass(
      {this.accountId,
        this.employerId,
        this.tpCode,
        this.employerName,
        this.loginPin,
        this.loginPinIsverifyYN,
        this.aadharNoIsverifyYN,
        this.panNoIsverifyYN,
        this.gstinNoIsverifyYN,
        this.panNo,
        this.gstinNo,
        this.userType,
        this.deviceType,
        this.isAttendanceApproval,
        this.fullName,
        this.employerMobile,
        this.employerEmail,
        this.isMobileOtpVerify,
        this.companyName,
        this.profilePhotoPath,
        this.payoutFrequencyDt,
        this.companyAddress,
        this.companyAddress2,
        this.companyTownCity,
        this.companyState,
        this.companyPincode,
        this.billAddress,
        this.billCity,
        this.cityId,
        this.billState,
        this.stateId,
        this.billPincode,
        this.startPayment});

  EmployerProfileModelClass.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    employerId = json['employer_id'];
    tpCode = json['tp_code'];
    employerName = json['employer_name'];
    loginPin = json['login_pin'];
    loginPinIsverifyYN = json['login_pin_isverify_y_n'];
    aadharNoIsverifyYN = json['aadhar_no_isverify_y_n'];
    panNoIsverifyYN = json['pan_no_isverify_y_n'];
    gstinNoIsverifyYN = json['gstin_no_isverify_y_n'];
    panNo = json['pan_no'];
    gstinNo = json['gstin_no'];
    userType = json['user_type'];
    deviceType = json['device_type'];
    isAttendanceApproval = json['is_attendance_approval'];
    fullName = json['full_name'];
    employerMobile = json['employer_mobile'];
    employerEmail = json['employer_email'];
    isMobileOtpVerify = json['is_mobile_otp_verify'];
    companyName = json['company_name'];
    profilePhotoPath = json['profile_photo_path'];
    payoutFrequencyDt = json['payout_frequency_dt'];
    companyAddress = json['company_address'];
    companyAddress2 = json['company_address_2'];
    companyTownCity = json['company_town_city'];
    companyState = json['company_state'];
    companyPincode = json['company_pincode'];
    billAddress = json['bill_address'];
    billCity = json['bill_city'];
    cityId = json['city_id'];
    billState = json['bill_state'];
    stateId = json['state_id'];
    billPincode = json['bill_pincode'];
    startPayment = json['start_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_id'] = this.accountId;
    data['employer_id'] = this.employerId;
    data['tp_code'] = this.tpCode;
    data['employer_name'] = this.employerName;
    data['login_pin'] = this.loginPin;
    data['login_pin_isverify_y_n'] = this.loginPinIsverifyYN;
    data['aadhar_no_isverify_y_n'] = this.aadharNoIsverifyYN;
    data['pan_no_isverify_y_n'] = this.panNoIsverifyYN;
    data['gstin_no_isverify_y_n'] = this.gstinNoIsverifyYN;
    data['pan_no'] = this.panNo;
    data['gstin_no'] = this.gstinNo;
    data['user_type'] = this.userType;
    data['device_type'] = this.deviceType;
    data['is_attendance_approval'] = this.isAttendanceApproval;
    data['full_name'] = this.fullName;
    data['employer_mobile'] = this.employerMobile;
    data['employer_email'] = this.employerEmail;
    data['is_mobile_otp_verify'] = this.isMobileOtpVerify;
    data['company_name'] = this.companyName;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['payout_frequency_dt'] = this.payoutFrequencyDt;
    data['company_address'] = this.companyAddress;
    data['company_address_2'] = this.companyAddress2;
    data['company_town_city'] = this.companyTownCity;
    data['company_state'] = this.companyState;
    data['company_pincode'] = this.companyPincode;
    data['bill_address'] = this.billAddress;
    data['bill_city'] = this.billCity;
    data['city_id'] = this.cityId;
    data['bill_state'] = this.billState;
    data['state_id'] = this.stateId;
    data['bill_pincode'] = this.billPincode;
    data['start_payment'] = this.startPayment;
    return data;
  }
}