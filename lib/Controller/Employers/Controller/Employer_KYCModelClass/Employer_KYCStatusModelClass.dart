

class Employer_KYCStatusModelClass {
  var employerId;
  var signupFlag;
  var employerStatus;
  var tpCode;
  var accountId;
  var tpAccountId;
  var tpLeadId;
  var tpContactId;
  var gstInYN;
  //int? areaOfWork;
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
  var employerMobile;
  var employerEmail;
  var isMobileOtpVerify;
  var companyName;
  var profilePhotoPath;
  var payoutFrequencyDt;
  var noOfEmployee;
  var gstPrincipalAddress;
  var gstAdditionalAddress;
  var state;
  var city;
  var accountNo; //discuss with chandra mohan--4-3-2023 start(use for Home account no)

  Employer_KYCStatusModelClass(
      {this.employerId,
        this.signupFlag,
        this.employerStatus,
        this.tpCode,
        this.accountId,
        this.tpAccountId,
        this.tpLeadId,
        this.tpContactId,
        this.gstInYN,
        //this.areaOfWork,
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
        this.employerMobile,
        this.employerEmail,
        this.isMobileOtpVerify,
        this.companyName,
        this.profilePhotoPath,
        this.payoutFrequencyDt,
        this.noOfEmployee,
        this.gstPrincipalAddress,
        this.gstAdditionalAddress,
        this.state,
        this.city,this.accountNo});

  Employer_KYCStatusModelClass.fromJson(Map<String, dynamic> json) {
    employerId = json['employer_id'];
    signupFlag = json['signup_flag'];
    employerStatus = json['employer_status'];
    tpCode = json['tp_code'];
    accountId = json['account_id'];
    tpAccountId = json['tp_account_id'];
    tpLeadId = json['tp_lead_id'];
    tpContactId = json['tp_contact_id'];
    gstInYN = json['gst_in_y_n'];
    //areaOfWork = json['area_of_work'];
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
    employerMobile = json['employer_mobile'];
    employerEmail = json['employer_email'];
    isMobileOtpVerify = json['is_mobile_otp_verify'];
    companyName = json['company_name'];
    profilePhotoPath = json['profile_photo_path'];
    payoutFrequencyDt = json['payout_frequency_dt'];
    noOfEmployee = json['no_of_employee'];
    gstPrincipalAddress = json['gst_principal_address'];
    gstAdditionalAddress = json['gst_additional_address'];
    state = json['state'];
    city = json['city'];
    accountNo = json['account_no'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employer_id'] = this.employerId;
    data['signup_flag'] = this.signupFlag;
    data['employer_status'] = this.employerStatus;
    data['tp_code'] = this.tpCode;
    data['account_id'] = this.accountId;
    data['tp_account_id'] = this.tpAccountId;
    data['tp_lead_id'] = this.tpLeadId;
    data['tp_contact_id'] = this.tpContactId;
    data['gst_in_y_n'] = this.gstInYN;
    //data['area_of_work'] = this.areaOfWork;
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
    data['employer_mobile'] = this.employerMobile;
    data['employer_email'] = this.employerEmail;
    data['is_mobile_otp_verify'] = this.isMobileOtpVerify;
    data['company_name'] = this.companyName;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['payout_frequency_dt'] = this.payoutFrequencyDt;
    data['no_of_employee'] = this.noOfEmployee;
    data['gst_principal_address'] = this.gstPrincipalAddress;
    data['gst_additional_address'] = this.gstAdditionalAddress;
    data['state'] = this.state;
    data['city'] = this.city;
    data['account_no'] = this.accountNo;

    return data;
  }
}