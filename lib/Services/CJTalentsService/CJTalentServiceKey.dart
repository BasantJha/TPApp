/*------------------CJHub app 18-11-2022 start----------------------*/

const kCJHub_EmpCodeKey="emp_code";
const kCJHub_CreatedIpKey="created_ip";
const kCJHub_CreatedByKey="created_by";


/*-----------support module keys-----------------*/

//get subject master list
//use the empcode

//get query list api
//use empcode
const kCJHub_Support_QueryTypeKey="query_type";
const kCJHub_Support_QueryType_AllValue="Open";
const kCJHub_Support_QueryType_OpenValue="Open";
const kCJHub_Support_QueryType_CloseValue="Close";

//save query
//use empcode and created_ip
const kCJHub_Support_SubjectIdKey="subject_id";
const kCJHub_Support_SubjectDescKey="subject_desc";
const kCJHub_Support_SubjectCommentKey="query_comment";
const kCJHub_Support_DocumentPathCommentKey="document";
const kCJHub_Support_DocumentNameCommentKey="documentname";
const kCJHub_Support_DocumentExtensionCommentKey="documenttype";


/*--------save query trail---------*/
//empcode
const kCJHub_Support_QueryIdKey="query_id";
const kCJHub_Support_ReplyStatusKey="reply_status";
const kCJHub_Support_QueryCommentKey="query_comment";
//created_ip,document,documentname,documenttype

/*sdMap["emp_code"] = getEncryptedData("9569734648CJHUB5610CJHUB14/05/1988");
sdMap["query_id"] = getEncryptedData("588");
sdMap["reply_status"] = "close";
sdMap["query_comment"] = sMsg.toString();
sdMap["created_ip"] = "1.1.1.1";
sdMap["document"] = "";
sdMap["documentname"] = "";
sdMap["documenttype"] = "";*/

/*------------------CJHub app 18-11-2022 end----------------------*/



/*------------------TankhaPay app login 1-12-2022 start----------------------*/

const kCJHub_Login_EmpMobileKey="emp_mobile";
const kCJHub_Login_EmpSecretKeyKey="emp_secret_key";


/*------------------TankhaPay app send OTP 1-12-2022 end----------------------*/
const kCJHub_SendOTP_SMSSendResponseKey="sms_send_response";
const kCJHub_SendOTP_EmpCodeKey="emp_code";
const kCJHub_SendOTP_EmpEmailKey="emp_email";
const kCJHub_SendOTP_EmpNameKey="emp_name";
const kCJHub_SendOTP_EmpMobileKey="emp_mobile";
const kCJHub_SendOTP_EmpPANNumberKey="emp_pancard_number";
const kCJHub_SendOTP_EmpDeviceIdKey="device_id";
const kCJHub_SendOTP_EmpIPKey="device_ip";
const kCJHub_SendOTP_EmpDeviceTypeKey="device_type";


/*------------------TankhaPay send OTP 1-12-2022 start----------------------*/

/*------------------TankhaPay Verify OTP 1-12-2022 start----------------------*/
const kCJHub_VerifyOTP_EmpVerifyOTPKey="otp";

/*------------------TankhaPay send OTP 1-12-2022 start----------------------*/



/*---------------Employee KYC start 12-12-2022-----------------*/

const kTankhaPay_CommonKYC_JSIdKey="js_id";
const kTankhaPay_CommonKYC_IdNumberKey="id_number";
const kTankhaPay_CommonKYC_CreatedByKey="createdby";
const kTankhaPay_CommonKYC_MobileNoKey="mobile_number";


//AADHAR
const kTankhaPay_KYCAadharSendOTP_JSIdKey=kTankhaPay_CommonKYC_JSIdKey;
const kTankhaPay_KYCAadharSendOTP_AadharNoKey=kTankhaPay_CommonKYC_IdNumberKey;

//Verify Aadhar OTP
const kTankhaPay_KYCAadharVerifyOTP_ClientIdKey="client_id";
const kTankhaPay_KYCAadharVerifyOTP_OTPKey="otp";
const kTankhaPay_KYCAadharVerifyOTP_JSIdKey=kTankhaPay_CommonKYC_JSIdKey;
const kTankhaPay_KYCAadharVerifyOTP_MobileNoKey=kTankhaPay_CommonKYC_MobileNoKey;
const kTankhaPay_KYCAadharVerifyOTP_AadharNoKey="adhar_no";


//PAN
const kTankhaPay_KYCPAN_JSIdKey=kTankhaPay_CommonKYC_JSIdKey;
const kTankhaPay_KYCPAN_PANNoKey=kTankhaPay_CommonKYC_IdNumberKey;



//UAN
const kTankhaPay_KYCUAN_JSIdKey=kTankhaPay_CommonKYC_JSIdKey;
const kTankhaPay_KYCUAN_UANNoKey="uannumber";
const kTankhaPay_KYCUAN_CreatedByKey=kTankhaPay_CommonKYC_CreatedByKey;
const kTankhaPay_KYCUAN_ActionKey="action";
const kTankhaPay_KYCUAN_ActionValue="UpdateUAN";

const kTankhaPay_KYCUAN_PFStatusKey="pfopted";


//update profile address
const kTankhaPay_ProfileAddress_ActionValue="UpdateAddress";
const kTankhaPay_Profile_AddressKey="address";

//update profile picture
const  kTankhaPay_ProfilePhoto_ProfilePhotoKey = "emp_profile_photo";

//BANK

const kTankhaPay_KYCBank_JSIdKey=kTankhaPay_CommonKYC_JSIdKey;
const kTankhaPay_KYCBank_IdNoKey=kTankhaPay_CommonKYC_IdNumberKey;
const kTankhaPay_KYCBank_IFSCCodeKey="ifsc";
const kTankhaPay_KYCBank_FullNameKey="full_name";
const kTankhaPay_KYCBank_CreatedByKey="createdby";
const kTankhaPay_KYCBank_IPAddressKey="createdByIp";

//FAQ 20-12-2022

const kTankhaPay_FAQ_CategoryTypeKey="category_cd";
const kTankhaPay_FAQ_CategoryTypeGEN_Value="TP-GEN-FAQ";
const kTankhaPay_FAQ_CategoryTypeSOCIAL_Value="TP-SOCIAL-SEC-FAQ";



const kTankhaPay_Benefit_CategoryType_Other="OTHER-BENEFITS";
const kTankhaPay_Benefit_CategoryType_Insurance="INSURANCE-BENEFITS";
const kTankhaPay_Benefit_CategoryType_HealthCare="HEALTHCARE-BENEFITS";
const kTankhaPay_Benefit_CategoryType_Benefit="RETIREMENT-BENEFITS";

const kTankhaPay_Benefit_CategoryType_PrivacyPolicy="TP-PRIVACY-POLICY";
const kTankhaPay_Benefit_CategoryType_TermsOfUse="TP-TERMS-OF-USE";


/*
1. For OTHER-BENEFITS

{"encrypted":"4b3RxFAD75+7+KOu13TmQrsSIlkLYtjEh1Ve1zO/yCw3ciLgYakkxZHNnCfqFj7U"
}

2. For INSURANCE-BENEFITS

{"encrypted":"4b3RxFAD75+7+KOu13TmQoQBrV+7CeuwrjY3v6TIo3fOsp1zNWugHCA+5R4cJk54"
}

3. For HEALTHCARE-BENEFITS

{"encrypted":"4b3RxFAD75+7+KOu13TmQuPtFqwdaQmfm/2D+rdhbitGpNrXmXQfKKDgPUJrhqaf"
}

4. For RETIREMENT-BENEFITS

{"encrypted":"4b3RxFAD75+7+KOu13TmQtiZgLTgkUJieAwthjLk0mtGpNrXmXQfKKDgPUJrhqaf"
}
*/






/*
{
"action": "UpdateAddress",
"js_id": 2715,
"address": "Green_PArk",
"createdby": "5610"
}
*/

/*------------basant 20-12-2022 start---------------*/


/*---------------Employee Attendance means checkin in Map start 17-12-2022-----------------*/
const kTankhaPay_RidderCheckIn_CheckInLatitudeKey="check_in_latitude";
const kTankhaPay_RidderCheckIn_CheckInLongitudeKey="check_in_longitude";
const kTankhaPay_RidderCheckIn_customerAccountIdKey = "customerAccountId";


/*-------------------------- Employee Get MonthlyAttendance in Calendar Start 19-12-2022----*/
const kTankhaPay_GetAttendance_MonthNameKey = "month";
const kTankhaPay_GetAttendance_YearNameKey = "year";

/*-------------------------- Save Employee MonthlyAttendance in Calendar Start 19-12-2022----*/
const kTankhaPay_SaveAttendance_MarkedByUserTypeKey = "markedByUserType";
const kTankhaPay_SaveAttendance_AttendanceListKey = "attendanceDates";
const kTankhaPay_SaveAttendance_CustomerAccount_IdKey = "customeraccountid";

const kTankhaPay_SaveAttendance_MarkedByUserTypeValue="Employee";

const kTankhaPay_SaveAttendance_ActionTypeKey="actionType";
const kTankhaPay_SaveAttendance_ActionTypeValue="SaveBulkAttendance";



/*------------basant 20-12-2022 end---------------*/



/*----------------update employee profile start 27-1-2023----------------*/
const kTankhaPay_UpdateEmployee_ActionTypeKey="action_type";
const kTankhaPay_UpdateEmployee_ActionTypeValue="UpdateProfile";
const kTankhaPay_UpdateEmployee_JSIdKey="js_id";
const kTankhaPay_UpdateEmployee_IPAddressKey="ip";
const kTankhaPay_UpdateEmployee_CreatedByKey="createdby";
const kTankhaPay_UpdateEmployee_StateNameKey="minwagestate";
const kTankhaPay_UpdateEmployee_EmailIdKey="email";

/*----------------4 digit pin number start 14-2-2023----------------*/
const kTankhaPay_PinNumber_MobilePinNumberKey="empMobileNo";

//verify Pin Number
const kTankhaPay_PinNumber_SaltKey="v_key";

