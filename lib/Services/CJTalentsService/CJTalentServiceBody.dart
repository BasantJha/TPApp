

/*------------------CJHub app 18-11-2022 start----------------------*/

import 'package:contractjobs/CustomView/CJHubCustomView/QRConstants/QRConstants.dart';
import 'package:contractjobs/Services/AESAlgo/encrypt.dart';

import '../../Controller/Talents/ModelClasses/CJHubModelClasses/SendOTP_ModelResponse.dart';
import '../../Controller/Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../Controller/Talents/ModelClasses/CJHubModelClasses/Verify_Mobile_ModelResponse.dart';
import '../AESAlgo/EncryptedMapBody.dart';
import '../AESAlgo/Keys.dart';
import 'CJTalentServiceKey.dart';

Map getCJHub_SupportCreateQuery_RequestBody(String empCode,String subjectId,String subjectDesc,String comment,String ipAddrrss)
{
  var dummyBody=Map();
  dummyBody[kCJHub_EmpCodeKey]=getEncrypted_EmpCode(empCode);
  dummyBody[kCJHub_CreatedIpKey]=ipAddrrss;
  dummyBody[kCJHub_Support_SubjectIdKey]=subjectId;
  dummyBody[kCJHub_Support_SubjectDescKey]=subjectDesc;
  dummyBody[kCJHub_Support_SubjectCommentKey]=comment;

  return dummyBody;
}

Map getCJHub_InsuranceStatus_RequestBody(String empCode)
{
  var dummyBody=Map();
  dummyBody[kCJHub_EmpCodeKey]=getEncrypted_EmpCode(empCode);
  return dummyBody;
}
Map getCJHub_SalaryStatus_RequestBody(String completedEmpCode)
{
  var dummyBody=Map();
  dummyBody[kCJHub_EmpCodeKey] = getEncrypted_EmpCode(completedEmpCode);

  return dummyBody;
}
Map getCJHub_SalarySlip_RequestBody(String empCode)
{
  var dummyBody=Map();
  dummyBody[kCJHub_EmpCodeKey]=empCode;
  return dummyBody;
}
/*------------------CJHub app 18-11-2022 end----------------------*/

/*------------------TankhaPay login app 1-12-2022 start----------------------*/
Map getCJHub_VerifyMobileNo_RequestBody(String mobileNo)
{
  var dummyBody=Map();
  dummyBody[kCJHub_Login_EmpMobileKey]=getEncryptedData(mobileNo);
  dummyBody[kCJHub_Login_EmpSecretKeyKey]=getEncryptedData(Keys.get_SaltKey);
  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
 // return dummyBody;
}

/*Map getCJHub_SendOTP_RequestBody(Verify_Mobile_ModelResponse obj,String deviceId,String empIP)
{
  var dummyBody=Map();
  dummyBody[kCJHub_SendOTP_SMSSendResponseKey]="Y";
  dummyBody[kCJHub_SendOTP_EmpCodeKey]=obj.data?.empCode;
  dummyBody[kCJHub_SendOTP_EmpEmailKey]=obj.data?.empEmail;
  dummyBody[kCJHub_SendOTP_EmpNameKey]=obj.data?.empName;
  dummyBody[kCJHub_SendOTP_EmpMobileKey]=obj.data?.empMobile;
  dummyBody[kCJHub_SendOTP_EmpPANNumberKey]=obj.data?.empPancardNumber;
  //dummyBody[kCJHub_SendOTP_EmpPANNumberKey]="CRRPK7011F";

  dummyBody[kCJHub_SendOTP_EmpDeviceIdKey]=deviceId;
  dummyBody[kCJHub_SendOTP_EmpIPKey]=empIP;
  dummyBody[kCJHub_SendOTP_EmpDeviceTypeKey]="android";

  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
}*/

Map getCJHub_VerifyOTP_RequestBody(String mobileNo,String otp)
{
  var dummyBody=Map();
  /*dummyBody[kCJHub_SendOTP_EmpCodeKey]=obj.data?.empCode;
  dummyBody[kCJHub_SendOTP_EmpEmailKey]=obj.data?.empEmail;
  dummyBody[kCJHub_SendOTP_EmpNameKey]=obj.data?.empName;*/

  dummyBody[kCJHub_Login_EmpMobileKey]=getEncryptedData(mobileNo);
  dummyBody[kCJHub_Login_EmpSecretKeyKey]=getEncryptedData(Keys.get_SaltKey);
  dummyBody[kCJHub_VerifyOTP_EmpVerifyOTPKey]=otp;

  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
}
/*------------------TankhaPay login app 1-12-2022 end----------------------*/

/*---------------Employee Attendance means checkin in Map start 5-12-2022-----------------*/
/*
Map getCJHub_EmployeeCheckIn_RequestBody(String latitude,String longitude)
{
  var dummyBody=Map();
  dummyBody[kCJHub_EmpCodeKey]="";
  dummyBody[kCJHub_CreatedIpKey]="";
  dummyBody[kCJHub_CreatedByKey]="";
  dummyBody[kTankhaPay_RidderCheckIn_CheckInLatitudeKey]=latitude;
  dummyBody[kTankhaPay_RidderCheckIn_CheckInLongitudeKey]=longitude;

  print("show the mobile verify request $dummyBody");

  return getEncrypted_MapBody(dummyBody);
}*/


/*------------------Employee KYC PART START------------------*/

Map getCJHub_EmployeeKYCStatus_RequestBody(String jsId)
{
  var dummyBody=Map();
  dummyBody[kTankhaPay_KYCPAN_JSIdKey]=getEncryptedData(jsId);
  //dummyBody[kTankhaPay_KYCPAN_JSIdKey]="TUEIT92uJacMAE5qNl3r0Q==";
  print("show the 1dummyBodyt $dummyBody");

  ////return dummyBody;

  return getEncrypted_MapBody(dummyBody);
}

Map getCJHub_EmployeeKYCPAN_RequestBody(String jsId,String PANNO,String panOptedStatus)
{
  //
  var dummyBody=Map();
  dummyBody[kTankhaPay_KYCPAN_JSIdKey]=getEncrypted_EmpCode(jsId);
  dummyBody[kTankhaPay_KYCPAN_PANNoKey]=PANNO;
  dummyBody["panOpted"]=panOptedStatus;


  print("show the mobile verify request $dummyBody");

  return getEncrypted_MapBody(dummyBody);
}
Map getCJHub_EmployeeKYCUAN_RequestBody(String jsId,String UANNO,String createdBy,String uanStatus)
{
  //
  var dummyBody=Map();
  dummyBody[kTankhaPay_KYCUAN_JSIdKey]=getEncrypted_EmpCode(jsId);
  dummyBody[kTankhaPay_KYCUAN_UANNoKey]=UANNO;
  dummyBody[kTankhaPay_KYCUAN_CreatedByKey]=createdBy;
  dummyBody[kTankhaPay_KYCUAN_ActionKey]=kTankhaPay_KYCUAN_ActionValue;
  dummyBody[kTankhaPay_KYCUAN_PFStatusKey]=uanStatus;


  print("show the mobile verify request $dummyBody");

  return getEncrypted_MapBody(dummyBody);
}

Map getCJHub_EmployeeUpdateProfileAddress_RequestBody(String jsId,String address)
{
  //
  var dummyBody=Map();
  dummyBody[kTankhaPay_KYCUAN_JSIdKey]=getEncrypted_EmpCode(jsId);
  dummyBody[kTankhaPay_Profile_AddressKey]=address;
  dummyBody[kTankhaPay_KYCUAN_CreatedByKey]=jsId;
  dummyBody[kTankhaPay_KYCUAN_ActionKey]=kTankhaPay_ProfileAddress_ActionValue;

  print("show the mobile  verify request $dummyBody");

  return getEncrypted_MapBody(dummyBody);
}

Map getCJHub_EmployeeKYCBankInfoVerify_RequestBody(String jsId,String bankNo,String ifscCode,
    String fullName,String ipAddress)
{
  //
  var dummyBody=Map();
  dummyBody[kTankhaPay_KYCBank_JSIdKey]=getEncrypted_EmpCode(jsId);
  dummyBody[kTankhaPay_KYCBank_IdNoKey]=bankNo;
  dummyBody[kTankhaPay_KYCBank_IFSCCodeKey]=ifscCode;
  dummyBody[kTankhaPay_KYCBank_FullNameKey]=fullName;
  dummyBody[kTankhaPay_KYCBank_CreatedByKey]=jsId;
  dummyBody[kTankhaPay_KYCBank_IPAddressKey]=ipAddress;

  print("show the mobile verify request $dummyBody");

  return getEncrypted_MapBody(dummyBody);
}
/*-------------------16-12-2022 start(use the Aadhaar verification start)-------------------*/
Map getCJHub_EmployeeKYCAadharSendOTP_RequestBody(String jsId,String aadharNO)
{
  //
  var dummyBody=Map();
  dummyBody[kTankhaPay_KYCAadharSendOTP_JSIdKey]=getEncrypted_EmpCode(jsId);
  dummyBody[kTankhaPay_KYCAadharSendOTP_AadharNoKey]=getEncrypted_EmpCode(aadharNO);
  print("show the send aadhar otp $dummyBody");


  return getEncrypted_MapBody(dummyBody);
}

Map getCJHub_EmployeeKYCAadharVerifyOTP_RequestBody(String clientId,String otp,String jsId,String mobileNo,String aadharNo)
{
  //
  var dummyBody=Map();
  dummyBody[kTankhaPay_KYCAadharVerifyOTP_ClientIdKey]=clientId;
  dummyBody[kTankhaPay_KYCAadharVerifyOTP_OTPKey]=otp;
  dummyBody[kTankhaPay_KYCAadharVerifyOTP_JSIdKey]=getEncrypted_EmpCode(jsId);;
  dummyBody[kTankhaPay_KYCAadharVerifyOTP_MobileNoKey]=mobileNo;
  dummyBody[kTankhaPay_KYCAadharVerifyOTP_MobileNoKey]=mobileNo;
  dummyBody[kTankhaPay_KYCAadharVerifyOTP_AadharNoKey]=aadharNo;

  print("show the send aadhar otp $dummyBody");

  return getEncrypted_MapBody(dummyBody);
}
/*-------------------16-12-2022 start(use the Aadhaar verification end)-------------------*/

Map getCJHub_EmployeeFAQ_RequestBody(String categoryType)
{
  //
  var dummyBody=Map();
  dummyBody[kTankhaPay_FAQ_CategoryTypeKey]=categoryType;

  print("show the send aadhar otp $dummyBody");

  return getEncrypted_MapBody(dummyBody);
}
/*
Map getCJHub_EmployeeProfileAddress_RequestBody(String updateAddress,String jsId,String createdBy)
{
  //
  var dummyBody=Map();
  dummyBody[kTankhaPay_ProfileAddress_ActionKey]=kTankhaPay_ProfileAddress_ActionValue;
  dummyBody[kTankhaPay_ProfileAddress_AddressKey]=updateAddress;
  dummyBody[kTankhaPay_CommonKYC_JSIdKey]=jsId;
  dummyBody[kTankhaPay_CommonKYC_CreatedByKey]=createdBy;

  print("show the send aadhar otp $dummyBody");

  return getEncrypted_MapBody(dummyBody);
}
*/

Map get_TodayAttendance_RequestBody(VerifyOTP_ModelResponse liveObj)
{
  var dummyBody = Map();
  dummyBody[kCJHub_EmpCodeKey] = getEncrypted_EmpCodeTankhaPay(liveObj.data!.empMobile, liveObj.data!.empCode, liveObj.data!.empDob);
  return getEncrypted_MapBody(dummyBody);
}


Map checkIn_MarkAttendance_RequestBody(VerifyOTP_ModelResponse liveObj,String latitude,String longitude,String created_IP)
{

  var dummyBody = Map();
  dummyBody[kCJHub_EmpCodeKey] = getEncrypted_EmpCodeTankhaPay(liveObj.data!.empMobile, liveObj.data!.empCode, liveObj.data!.empDob);
  dummyBody[kTankhaPay_RidderCheckIn_CheckInLatitudeKey] = latitude;
  dummyBody[kTankhaPay_RidderCheckIn_CheckInLongitudeKey] = longitude;
  dummyBody[kCJHub_CreatedByKey] = liveObj.data!.jsId;
  dummyBody [kCJHub_CreatedIpKey] = created_IP;
  dummyBody[kTankhaPay_RidderCheckIn_customerAccountIdKey] = getEncryptedData(liveObj.data!.customeraccountid);

  return getEncrypted_MapBody(dummyBody);
}

Map get_MonthlyAttendance_RequestBody(String empCode,String mobileNo,String dateOfBirth,String month,String year)
{
  var dummyBody = Map();
  dummyBody[kCJHub_EmpCodeKey] = getEncrypted_EmpCodeTankhaPay(mobileNo, empCode, dateOfBirth);;
  dummyBody[kTankhaPay_GetAttendance_MonthNameKey] = month;
  dummyBody[kTankhaPay_GetAttendance_YearNameKey] = year;
  print("Data Map $dummyBody");

  return getEncrypted_MapBody(dummyBody);
}

Map save_MonthlyAttendance_RequestBody(List attendanceDataList,String empCode,String mobileNo,String dateOfBirth, String customerAccountNo,String jsId,)
{
  var dummyBody = Map();
  dummyBody[kCJHub_EmpCodeKey] = getEncrypted_EmpCodeTankhaPay(mobileNo, empCode, dateOfBirth);
  dummyBody[kTankhaPay_SaveAttendance_MarkedByUserTypeKey] = kTankhaPay_SaveAttendance_MarkedByUserTypeValue;
  dummyBody[kTankhaPay_SaveAttendance_AttendanceListKey] = attendanceDataList;
  dummyBody[kCJHub_CreatedByKey] = jsId;
  dummyBody[kTankhaPay_SaveAttendance_CustomerAccount_IdKey] = customerAccountNo;
  dummyBody[kTankhaPay_SaveAttendance_ActionTypeKey] = getEncryptedData(kTankhaPay_SaveAttendance_ActionTypeValue);


  return getEncrypted_MapBody(dummyBody);
}

/*-----------support module  21-12-2022 start---------------*/
Map getCJHub_Support_SubjectTicketList_RequestBody(String completedEmpCode)
{
  var dummyBody=Map();
  dummyBody[kCJHub_EmpCodeKey]=getEncrypted_EmpCode(completedEmpCode);
  return getEncrypted_MapBody(dummyBody);
}
Map getCJHub_Support_GETQueryList_RequestBody(String completedEmpCode,String queryType)
{
  var dummyBody=Map();
  dummyBody[kCJHub_EmpCodeKey]=getEncrypted_EmpCode(completedEmpCode);
  dummyBody[kCJHub_Support_QueryTypeKey]=queryType;

  return getEncrypted_MapBody(dummyBody);
}
Map getCJHub_Support_SaveQuery_RequestBody(String completedEmpCode,
    String ipAddress,String subjectId,String subjectDesc,String queryComment,
    String documentPathBase64,String documentName,String documentExt)
{
  var dummyBody=Map();
  dummyBody[kCJHub_EmpCodeKey]=getEncrypted_EmpCode(completedEmpCode);
  dummyBody[kCJHub_CreatedIpKey]=ipAddress;
  dummyBody[kCJHub_Support_SubjectIdKey]=subjectId;
  dummyBody[kCJHub_Support_SubjectDescKey]=subjectDesc;
  dummyBody[kCJHub_Support_SubjectCommentKey]=queryComment;
  dummyBody[kCJHub_Support_DocumentPathCommentKey]=documentPathBase64;
  dummyBody[kCJHub_Support_DocumentNameCommentKey]=documentName;
  dummyBody[kCJHub_Support_DocumentExtensionCommentKey]=documentExt;
  return getEncrypted_MapBody(dummyBody);
}


Map getCJHub_UpdateProfilePhoto_RequestBody(var empCode, var base64ProfilePicture, var createdIp, var createdBy,)
{
  var dummyBody = Map();
  dummyBody[kCJHub_EmpCodeKey] = empCode;
  dummyBody[kTankhaPay_ProfilePhoto_ProfilePhotoKey] = base64ProfilePicture;
  dummyBody[kCJHub_CreatedIpKey] = createdIp;
  dummyBody[kCJHub_CreatedByKey] = createdBy;

  print("show the insert profile photo request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
}


Map getCJHub_Support_SaveQueryTrail_RequestBody(String completedEmpCode,
    String ipAddress,String queryId,String replyStatus,String queryComment,
    String documentPathBase64,String documentName,String documentExt)
{
  var dummyBody=Map();
  dummyBody[kCJHub_EmpCodeKey]=getEncrypted_EmpCode(completedEmpCode);
  dummyBody[kCJHub_CreatedIpKey]=ipAddress;
  dummyBody[kCJHub_Support_QueryIdKey]=getEncrypted_EmpCode(queryId);
  dummyBody[kCJHub_Support_ReplyStatusKey]=replyStatus;
  dummyBody[kCJHub_Support_QueryCommentKey]=queryComment;
  dummyBody[kCJHub_Support_DocumentPathCommentKey]=documentPathBase64;
  dummyBody[kCJHub_Support_DocumentNameCommentKey]=documentName;
  dummyBody[kCJHub_Support_DocumentExtensionCommentKey]=documentExt;
  return getEncrypted_MapBody(dummyBody);
}
Map getCJHub_Support_GetQueryTrail_RequestBody(String completedEmpCode, String queryId)
{
  var dummyBody=Map();
  dummyBody[kCJHub_EmpCodeKey]=getEncrypted_EmpCode(completedEmpCode);
  dummyBody[kCJHub_Support_QueryIdKey]=getEncrypted_EmpCode(queryId);
  return getEncrypted_MapBody(dummyBody);
}

/*
const kCJHub_Support_QueryIdKey="query_id";
const kCJHub_Support_ReplyStatusKey="reply_status";
const kCJHub_Support_QueryCommentKey="query_comment";*/



Map getCJHub_KYCUpdateEmployeeProfile_RequestBody(String jsId, String ipAddress,String createdBy,String stateName,String emailId)
{
  var dummyBody=Map();
  dummyBody[kTankhaPay_UpdateEmployee_ActionTypeKey]=getEncryptedData(kTankhaPay_UpdateEmployee_ActionTypeValue);
  dummyBody[kTankhaPay_UpdateEmployee_JSIdKey]=getEncryptedData(jsId);
  dummyBody[kTankhaPay_UpdateEmployee_IPAddressKey]=ipAddress;
  dummyBody[kTankhaPay_UpdateEmployee_CreatedByKey]=createdBy;
  dummyBody[kTankhaPay_UpdateEmployee_StateNameKey]=stateName;
  dummyBody[kTankhaPay_UpdateEmployee_EmailIdKey]=emailId;

  return getEncrypted_MapBody(dummyBody);
}

/*------------------14-2-2023 start the 4 digit Pin Number----------------------*/
Map getCJHub_Set4DigitPin_RequestBody(String mobilePinNumber)
{
  var dummyBody=Map();
  dummyBody[kTankhaPay_PinNumber_MobilePinNumberKey]=getEncryptedData(mobilePinNumber);
  return getEncrypted_MapBody(dummyBody);
}
Map getCJHub_Verify4DigitPin_RequestBody(String mobilePinNumber)
{
  var dummyBody=Map();
  dummyBody[kTankhaPay_PinNumber_MobilePinNumberKey]=getEncryptedData(mobilePinNumber);
  dummyBody[kTankhaPay_PinNumber_SaltKey]=getEncryptedData(Keys.get_SaltKey);

  return getEncrypted_MapBody(dummyBody);
}
/*------------------14-2-2023 end the 4 digit Pin Number----------------------*/
