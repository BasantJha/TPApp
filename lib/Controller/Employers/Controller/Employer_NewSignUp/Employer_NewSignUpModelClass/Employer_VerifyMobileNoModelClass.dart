

class Employer_VerifyMobileNoModelClass {

  int? employerStatus;
  var employerId;
  var tpLeadId;
  var userType;
  //var gstInYN;
  var employerName;
  var employerMobile;
  var employerEmail;
  //var deviceType;
  //var websiteAppLink;
  var signupFlag;
 // var userIp;
  //var userid;
 // var defaulturl;
  var registrationType;
  //var isPasswordchange;
  //int? tokTeamId;
  //var parentAdminId;
  var isMobileOtpVerify;


  var tpCode;
  var tpAccountId;
  var gstInYN;
  var loginPin;
  var loginPinIsverifyYN;
  var aadharNoIsverifyYN;
  var panNoIsverifyYN;
  var gstinNoIsverifyYN;
  var panNo;
  var gstinNo;
  var profilePhotoPath;
  int? payoutFrequencyDt;

  var token;
  var companyName;

  var useForAddDOJStatus;//(personal define)use for user arrive from the Employer_NewWorkPlaceAddDOJ to tab bar controller workplace(31-1-2023)

  var pinNumber;
  var pinStatus;

  var accountNo; //discuss with chandra mohan--4-3-2023 start(use for Home account no)

  var supportNumber;//use for the 15-3-2023




  Employer_VerifyMobileNoModelClass(
      {this.employerStatus,
        this.employerId,
        this.tpLeadId,
        this.userType,
        //this.gstInYN,
        this.employerName,
        this.employerMobile,
        this.employerEmail,
       // this.deviceType,
        //this.websiteAppLink,
        this.signupFlag,
       // this.userIp,
        //this.userid,
        //this.defaulturl,
        this.registrationType,
        //this.isPasswordchange,
        //this.tokTeamId,
        //this.parentAdminId,
        this.isMobileOtpVerify,this.tpCode,
        this.tpAccountId,
        this.gstInYN,
        this.loginPin,
        this.loginPinIsverifyYN,
        this.aadharNoIsverifyYN,
        this.panNoIsverifyYN,
        this.gstinNoIsverifyYN,
        this.panNo,
        this.gstinNo,
        this.profilePhotoPath,
        this.payoutFrequencyDt,
        this.token,this.companyName,
        this.useForAddDOJStatus,
        this.pinNumber,
        this.pinStatus,
      this.accountNo,this.supportNumber});

  Employer_VerifyMobileNoModelClass.fromJson(Map<String, dynamic> json) {
    employerStatus = json['employer_status'];
    employerId = json['employer_id'];
    tpLeadId = json['tp_lead_id'];
    userType = json['user_type'];
   // gstInYN = json['gst_in_y_n'];
    employerName = json['employer_name'];
    employerMobile = json['employer_mobile'];
    employerEmail = json['employer_email'];
    //deviceType = json['device_type'];
    //websiteAppLink = json['website_app_link'];
    signupFlag = json['signup_flag'];
    //userIp = json['user_ip'];
   // userid = json['userid'];
   // defaulturl = json['defaulturl'];
    registrationType = json['registration_type'];
   // isPasswordchange = json['is_passwordchange'];
   // tokTeamId = json['tok_team_id'];
    //parentAdminId = json['parent_admin_id'];
    isMobileOtpVerify = json['is_mobile_otp_verify'];

    tpCode = json['tp_code'];
    tpAccountId = json['tp_account_id'];
    gstInYN = json['gst_in_y_n'];
    loginPin = json['login_pin'];
    loginPinIsverifyYN = json['login_pin_isverify_y_n'];
    aadharNoIsverifyYN = json['aadhar_no_isverify_y_n'];
    panNoIsverifyYN = json['pan_no_isverify_y_n'];
    gstinNoIsverifyYN = json['gstin_no_isverify_y_n'];
    panNo = json['pan_no'];
    gstinNo = json['gstin_no'];
    profilePhotoPath = json['profile_photo_path'];
    payoutFrequencyDt = json['payout_frequency_dt'];
    token = json['token'];
    companyName = json['company_name'];
    useForAddDOJStatus="";
    pinNumber = json['pin_number'];
    pinStatus = json['pin_status'];
    accountNo = json['account_no'];
    supportNumber = json['supportNumber'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employer_status'] = this.employerStatus;
    data['employer_id'] = this.employerId;
    data['tp_lead_id'] = this.tpLeadId;
    data['user_type'] = this.userType;
    ///data['gst_in_y_n'] = this.gstInYN;
    data['employer_name'] = this.employerName;
    data['employer_mobile'] = this.employerMobile;
    data['employer_email'] = this.employerEmail;
    //data['device_type'] = this.deviceType;
   // data['website_app_link'] = this.websiteAppLink;
    data['signup_flag'] = this.signupFlag;
    //data['user_ip'] = this.userIp;
    //data['userid'] = this.userid;
    //data['defaulturl'] = this.defaulturl;
    data['registration_type'] = this.registrationType;
    //data['is_passwordchange'] = this.isPasswordchange;
    //data['tok_team_id'] = this.tokTeamId;
    //data['parent_admin_id'] = this.parentAdminId;
    data['is_mobile_otp_verify'] = this.isMobileOtpVerify;

    data['tp_code'] = this.tpCode;
    data['tp_account_id'] = this.tpAccountId;
    data['gst_in_y_n'] = this.gstInYN;
    data['login_pin'] = this.loginPin;
    data['login_pin_isverify_y_n'] = this.loginPinIsverifyYN;
    data['aadhar_no_isverify_y_n'] = this.aadharNoIsverifyYN;
    data['pan_no_isverify_y_n'] = this.panNoIsverifyYN;
    data['gstin_no_isverify_y_n'] = this.gstinNoIsverifyYN;
    data['pan_no'] = this.panNo;
    data['gstin_no'] = this.gstinNo;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['payout_frequency_dt'] = this.payoutFrequencyDt;
    data['token'] = this.token;
    data['company_name'] = this.companyName;
    data["useForAddDOJStatus"]="";
    data['pin_number'] = this.pinNumber;
    data['pin_status'] = this.pinStatus;
    data['account_no'] = this.accountNo;
    data['supportNumber'] = this.supportNumber;

    return data;
  }
}

