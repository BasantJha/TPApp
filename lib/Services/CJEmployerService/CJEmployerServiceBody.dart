

import 'package:contractjobs/CustomView/CJHubCustomView/Method.dart';

import '../AESAlgo/EncryptedMapBody.dart';
import '../AESAlgo/Keys.dart';
import '../AESAlgo/encrypt.dart';
import '../CJTalentsService/CJTalentServiceKey.dart';
import 'CJEmployerServiceKey.dart';


/*------------------USE THIS API FOR THE (LOGIN VERIFY MOBILE NO & SEND THE OTP) START--------------------*/

Map getEmployer_VerifyMobileNO_RequestBody(String mobileNo,String userIP)
{

  var dummyBody=Map();
  dummyBody[kEmployer_Common_MobileKey]=mobileNo;
  dummyBody[kEmployer_Common_UserIPKey]=userIP;

  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}
/*------------------USE THIS API FOR THE (LOGIN VERIFY MOBILE NO & SEND THE OTP) END--------------------*/

Map getEmployer_SignUpInfo_RequestBody(String fullName,String mobileNo,String emailId,String pinCode,String deviceType,String IPAddress)
{
  var dummyBody=Map();
  dummyBody[kEmployer_SignUpInfo_FullNameKey]=fullName;
  dummyBody[kEmployer_SignUpInfo_EmailIdKey]=emailId;
  dummyBody[kEmployer_SignUpInfo_PinCodeKey]=pinCode;
  dummyBody[kEmployer_Common_MobileKey]=mobileNo;
  dummyBody[kEmployer_Common_FlagKey]=kEmployer_FLAG_SU;
  dummyBody[kEmployer_Common_DeviceTypeKey]=deviceType;
  dummyBody[kEmployer_Common_UserIPKey]=IPAddress;

  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}

/*------------------USE THIS API FOR THE (LOGIN & SIGNUP) START--------------------*/
Map getEmployer_VerifyOTP_RequestBody(String mobileNo,String otp,String userIP)
{

  var dummyBody=Map();
  dummyBody[kEmployer_Common_MobileKey]=mobileNo;
  dummyBody[kEmployer_SignUpVerifyOTP_OTPKey]=otp;
  dummyBody[kEmployer_Common_UserIPKey]=userIP;

  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}
/*------------------USE THIS API FOR THE (LOGIN & SIGNUP) END--------------------*/

Map getEmployer_BusinessInfo_RequestBody(String userType,String gstStatus,String areaOfWork,String noOfEmployee,String mobileNo,String deviceType,String IPAddress)
{
  var dummyBody=Map();
  dummyBody[kEmployer_BusinessInfo_UserTypeKey]=userType;
  dummyBody[kEmployer_BusinessInfo_GSTStatusKey]=gstStatus;
  dummyBody[kEmployer_BusinessInfo_AreaOfWorkKey]=areaOfWork;
  dummyBody[kEmployer_BusinessInfo_NoOfEmployeeKey]=noOfEmployee;

  dummyBody[kEmployer_Common_FlagKey]=kEmployer_FLAG_BI;
  dummyBody[kEmployer_Common_MobileKey]=mobileNo;
  dummyBody[kEmployer_Common_DeviceTypeKey]=deviceType;
  dummyBody[kEmployer_Common_UserIPKey]=IPAddress;

  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}


/*------------------Employer KYC 8-12-2022 start --------------------*/

Map getEmployer_PANVerify_RequestBody(String panNo,String mobileNo,String deviceType,String IPAddress)
{

  var dummyBody=Map();
  dummyBody[kEmployer_KYC_PANNoKey]=panNo;
  dummyBody[kEmployer_Common_FlagKey]=kEmployer_FLAG_KYCPAN;
  dummyBody[kEmployer_Common_MobileKey]=mobileNo;
  dummyBody[kEmployer_Common_DeviceTypeKey]=deviceType;
  dummyBody[kEmployer_Common_UserIPKey]=IPAddress;

  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;

}
/*--------------------Aadhaar verify 17-12-2022-----------------*/
Map getEmployer_KYC_AadharSendOTP_RequestBody(String employerId,String aadharNO)
{

  var dummyBody=Map();
  dummyBody[kEmployer_KYC_EmployerIdKey]=getEncrypted_EmpCode(employerId);
  dummyBody[kEmployer_KYC_AadhaarNoKey]=getEncrypted_EmpCode(aadharNO);

  print("show the send aadhar otp $dummyBody");

  return getEncrypted_MapBody(dummyBody);
}

Map getEmployer_KYC_AadharVerifyOTP_RequestBody(String clientId,String otp,String employerId,String mobileNo)
{

  var dummyBody=Map();
  dummyBody[kEmployer_KYC_ClientIdKey]=clientId;
  dummyBody[kEmployer_KYC_OTPKey]=otp;
  dummyBody[kEmployer_KYC_EmployerIdKey]=getEncrypted_EmpCode(employerId);
  dummyBody[kEmployer_KYC_MobileNoKey]=mobileNo;

  print("show the send aadhar otp $dummyBody");

  return getEncrypted_MapBody(dummyBody);
}

/*-----------------GST--17-12-2022 start--------------*/
Map getEmployer_KYC_GSTSendOTP_RequestBody(String employerId,String gstNO)
{

  var dummyBody=Map();
  dummyBody[kEmployer_KYC_GSTEmployerIdKey]=employerId;
  dummyBody[kEmployer_KYC_GSTNoKey]=gstNO;
  print("show the send aadhar otp $dummyBody");

  return getEncrypted_MapBody(dummyBody);
}
Map getEmployer_KYC_GSTVerifyOTP_RequestBody(String clientId,String otp,String employerId,String gstNo)
{

  var dummyBody=Map();
  dummyBody[kEmployer_KYC_ClientIdKey]=clientId;
  dummyBody[kEmployer_KYC_OTPKey]=otp;
  dummyBody[kEmployer_KYC_GSTEmployerIdKey]=employerId;
  dummyBody[kEmployer_KYC_GSTNoKey]=gstNo;
  print("show the send aadhar otp $dummyBody");

  return getEncrypted_MapBody(dummyBody);
}
/*------------company details start 17-12-2022 start ----------------*/

Map getEmployer_CompanyDetailsAllCities_RequestBody(String stateId)
{

  var dummyBody=Map();
  dummyBody[kEmployer_KYC_StateIdKey]=stateId;
  print("show the company details district list $dummyBody");
  return getEncrypted_MapBody(dummyBody);
}
Map getEmployer_CompanyDetails_RequestBody(String companyName,String address,String state,String city,String pinCode,String website,String mobileNo,String deviceType,String IPAddress)
{
  var dummyBody=Map();
  dummyBody[kEmployer_CompanyDetails_NameKey]=companyName;
  dummyBody[kEmployer_CompanyDetails_AddressKey]=address;
  dummyBody[kEmployer_CompanyDetails_StateKey]=state;
  dummyBody[kEmployer_CompanyDetails_CityKey]=city;
  dummyBody[kEmployer_CompanyDetails_PinCodeKey]=pinCode;
  dummyBody[kEmployer_CompanyDetails_WebsiteLinkKey]=website;

  dummyBody[kEmployer_Common_FlagKey]=kEmployer_FLAG_CD;
  dummyBody[kEmployer_Common_MobileKey]=mobileNo;
  dummyBody[kEmployer_Common_DeviceTypeKey]=deviceType;
  dummyBody[kEmployer_Common_UserIPKey]=IPAddress;

  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}

/*------------employer aggreements start 16-12-2022 start (save the Terms and condition means aggreement)----------------*/
Map getEmployer_SaveEmployerAggreement_RequestBody(/*String acceptOnboard,String acceptAdditional,String acceptPFESIC,String acceptTermsConditions,*/String mobileNo,String deviceType,String IPAddress)
{
  var dummyBody=Map();
  dummyBody[kEmployer_Aggreement_AcceptOnboardKey]=getAggreementStatus;
  dummyBody[kEmployer_Aggreement_AcceptAdditionalKey]=getAggreementStatus;
  dummyBody[kEmployer_Aggreement_AcceptPFESICKey]=getAggreementStatus;
  dummyBody[kEmployer_Aggreement_AcceptTermsConditionsKey]=getAggreementStatus;

  dummyBody[kEmployer_Common_FlagKey]=kEmployer_FLAG_EA;
  dummyBody[kEmployer_Common_MobileKey]=mobileNo;
  dummyBody[kEmployer_Common_DeviceTypeKey]=deviceType;
  dummyBody[kEmployer_Common_UserIPKey]=IPAddress;

  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}

/*------------------Employer KYC 17-12-2022 end --------------------*/

Map getEmployer_EmployerKYCStatus_RequestBody(String mobileNo)
{
  var dummyBody=Map();

  dummyBody[kEmployer_Common_MobileKey]=mobileNo;
  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}


/*---------------3-1-2023 Employer profile start--------------*/
Map getEmployer_EmployerUpdateProfilePhoto_RequestBody(String customerAccountId, String profilePhotoName, String profilePhotoPath) {
  var dummyBody = Map();
  dummyBody[kEmployer_UpdateProfile_ActionKey] = kEmployer_UpdateProfile_ActionValue;
  dummyBody[kEmployer_Common_CustomerAccountIdKey] = customerAccountId;
  dummyBody[kEmployer_UpdateProfile_PhotoNameKey] = profilePhotoName;
  dummyBody[kEmployer_UpdateProfile_PhotoPathKey] = profilePhotoPath;

  print("show the update photo request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}

Map getEmployer_EmployerUpdatePayOutDate_RequestBody(String customerAccountId, String payoutFreqDate) {
  var dummyBody = Map();
  dummyBody[kEmployer_UpdateProfile_ActionKey] = kEmployer_UpdateProfile_PayoutDateActionValue;
  dummyBody[kEmployer_Common_CustomerAccountIdKey] = customerAccountId;
  dummyBody[kEmployer_UpdateProfile_PayoutFreqDateKey] = payoutFreqDate;

  print("show the updatedate request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}

Map getEmployer_GETEmployerProfile_RequestBody(String customerAccountId) {
  var dummyBody = Map();
  dummyBody[kEmployer_Common_CustomerAccountIdKey] = customerAccountId;

  print("show the updatedate request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}

Map getEmployer_UpdateBillingAddress_RequestBody(String accountid, String address, String address2, String state,String city,String pinCode)
{
  var dummyBody=Map();
  dummyBody[kEmployer_UpdateProfile_ActionKey]=kEmployer_UpdateBillingAddress_ActionValue;
  dummyBody[kEmployer_Common_CustomerAccountIdKey]=accountid;
  dummyBody[kEmployer_BillingAddressUpdate_AddressKey]=address;
  dummyBody[kEmployer_BillingAddressUpdate_AddressKey2]=address2;
  dummyBody[kEmployer_BillingAddressUpdate_StateKey]=state;
  dummyBody[kEmployer_BillingAddressUpdate_CityKey]=city;
  dummyBody[kEmployer_BillingAddressUpdate_PinCodeKey]=pinCode;

  print("show the  verify request $dummyBody");
  print(getEncrypted_MapBody(dummyBody));
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}

/*------------Employer PayOut 30-12-2022------------------*/
Map getEmployer_EmployeePayOut_RequestBody(String accountID,String payoutType)
{
  var dummyBody=Map();
  dummyBody[kEmployer_Common_CustomerAccountIdKey]=getEncryptedData(accountID);
  dummyBody[kEmployer_PayOutSummary_PayoutTypeKey]=payoutType;

  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}

/*------------Employer PayOut Details 02-01-2023------------------*/
Map getEmployer_EmployeePayOutDetails_RequestBody(String accountID,Month,Year,EmpCode)
{
  var dummyBody=Map();
  dummyBody[kEmployer_Common_CustomerAccountIdKey]=getEncryptedData(accountID);
  dummyBody[kEmployer_PayOutSummary_PayoutTypeKey]="All";
  dummyBody[kEmployer_Common_MonthKey]=Month;
  dummyBody[kEmployer_Common_YearKey]=Year;
  dummyBody[kEmployer_PayOutDetails_EmpcodeKey]=EmpCode;

  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}
Map get_ViewInvoice_RequestBody(String customerAccountId, String baseAmount, int numberOfEmployees)
{
  var dummyBody = Map();
  dummyBody[viewInvoivce_customerAccountId] = getEncryptedData(customerAccountId);
  dummyBody[viewInvoivce_baseAmount] = baseAmount;
  dummyBody[viewInvoivce_numberOfEmployees] = numberOfEmployees;

  return getEncrypted_MapBody(dummyBody);
}

/*------------------Add Employee 26-12-2022 start..pratibha --------------------*/

Map getEmployer_LeaveTemplate_RequestBody(String customerAccountId)
{
  var dummyBody=Map();
  //dummyBody[kEmployer_Common_CustomerAccountIdKey]=getEncryptedData(customerAccountId);
  dummyBody[kEmployer_Common_CustomerAccountIdKey]=customerAccountId;

  print("show the mobile verify request $dummyBody");
  print("print all details $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}

/*------------------Calculator 19-12-2022 start..pratibha --------------------*/

Map getEmployer_MonthlyCtcCalculator_RequestBody(String monthlyPackage,String empCode,String customerAccountId)
{

  var dummyBody=Map();
  dummyBody[kEmployer_MonthlyCtcCalculator_MonthlyPackageKey]=monthlyPackage;
  dummyBody[kEmployer_Common_EmpCodeKey]=getEncryptedData(empCode);
  dummyBody[kEmployer_Common_CustomerAccountIdKey]=getEncryptedData(customerAccountId);

  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}

/*------------------Calculator 23-12-2022 start..pratibha --------------------*/

Map getEmployer_InHandSalaryCalculator_RequestBody(String inHandSalary,String empCode,String customerAccountId)
{

  var dummyBody=Map();
  dummyBody[kEmployer_InHandSalaryCalculator_InHandSalaryKey]=inHandSalary;
  dummyBody[kEmployer_Common_EmpCodeKey]=empCode;
  dummyBody[kEmployer_Common_CustomerAccountIdKey]=getEncryptedData(customerAccountId);

  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}

/*------------------Calculator 29-12-2022 start..pratibha --------------------*/

Map getEmployer_EmployerDetails_RequestBody(String customerAccountId)
{
//
  var dummyBody=Map();
  dummyBody[kEmployer_Common_CustomerAccountIdKey]=getEncryptedData(customerAccountId);

  print("show the mobile verify request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}

Map getEmployer_AddEmployee_RequestBody(String employeeName,String employeeMobile,String employeeMonthlySalary,String employeeDoj,String employeeDesignation,String employeeEmail,String accountId,String employerId,String employerLeadId,String createdBy,String createdIp, List salaryStructure,String leaveTemplateId)
{

  var dummyBody=Map();
  dummyBody[kEmployer_AddEmployee_NameKey]=employeeName;
  dummyBody[kEmployer_AddEmployee_MobileNumberKey]=employeeMobile;
  dummyBody[kEmployer_AddEmployee_MonthlySalaryKey]=employeeMonthlySalary;
  dummyBody[kEmployer_AddEmployee_DateOfJoiningKey]=employeeDoj;
  dummyBody[kEmployer_AddEmployee_DesignationKey]=employeeDesignation;
  dummyBody[kEmployer_AddEmployee_EmailAddressKey]=employeeEmail;

  dummyBody[kEmployer_Common_CustomerAccountIdKey]=getEncryptedData(accountId);
  dummyBody[kEmployer_AddEmployee_EmployerIdKey]=employerId;
  dummyBody[kEmployer_AddEmployee_EmployerLeadIdKey]=employerLeadId;
  dummyBody[kEmployer_AddEmployee_CreatedByKey]=createdBy;
  dummyBody[kEmployer_AddEmployee_CreatedIpKey]=createdIp;
  dummyBody[kEmployer_AddEmployee_SalaryStructureKey]=salaryStructure;
  dummyBody[kEmployer_AddEmployee_LeaveTemplateIdKey]=leaveTemplateId;

  print("show the mobile verify request $dummyBody");
  print("print all details $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}

/*------------27-1-2023 update the add employee body request start--------------*/
Map getEmployer_NewAddEmployee_RequestBody(String employeeName,String employeeMobile,String employeeEmail,String accountId,String employerId,String employerLeadId,String createdBy,String createdIp)
{

  var dummyBody=Map();
  dummyBody[kEmployer_AddEmployee_NameKey]=employeeName;
  dummyBody[kEmployer_AddEmployee_MobileNumberKey]=employeeMobile;
  dummyBody[kEmployer_AddEmployee_EmailAddressKey]=employeeEmail;
  dummyBody[kEmployer_Common_CustomerAccountIdKey]=getEncryptedData(accountId);
  dummyBody[kEmployer_AddEmployee_EmployerIdKey]=employerId;
  dummyBody[kEmployer_AddEmployee_EmployerLeadIdKey]=employerLeadId;
  dummyBody[kEmployer_AddEmployee_CreatedByKey]=createdBy;
  dummyBody[kEmployer_AddEmployee_CreatedIpKey]=createdIp;

  print("show the mobile verify request $dummyBody");
  print("print all details $dummyBody");
  return getEncrypted_MapBody(dummyBody);
  // return dummyBody;
}
/*------------27-1-2023 update the add employee body request end--------------*/


/*___________Ritik (Payment Page Map)__________*/
Map getTransactionTokenMap(String amount, String txnOrderId, String custId,
    String curr, String reqType) {
  var dummyBody = Map();
  dummyBody[TokenGenamount] = amount;
  dummyBody[TokenGenorderId] = txnOrderId;
  dummyBody[TokenGencustomerAccountId] = custId;
  dummyBody[TokenGencurrency] = curr;
  dummyBody[TokenGenrequestType] = reqType;

  return getEncrypted_MapBody(dummyBody);
}

/*_________Ritik (Add Starting Payment)__________*/
Map getMapForInvoice(String custId, String amt, int noEmp) {
  var dummyBody = Map();
  dummyBody[InvoiceCustid] = getEncryptedData(custId);
  dummyBody[InvoiceBaseAmt] = amt;
  dummyBody[InvoiceNoEmp] = noEmp;

  return getEncrypted_MapBody(dummyBody);
}
//
Map getMapForAmountInInvoice(String id) {
  var dummyBody = Map();
  dummyBody[EmpIdForInvoiceAmount] = id;
  return getEncrypted_MapBody(dummyBody);
}

Map getMapForOrderId(
    String custaccountid,
    String no_of_emp,
    String netAmount,
    String sgRate,
    String sgAmount,
    String gst_mode,
    String sgstRate,
    String sgstAmount,
    String cgstRate,
    String cgstAmount,
    String igstRate,
    String igstAmount,
    String net_value,
    String source,
    String createdby,
    String created_ip,
    String invoice_type,
    String service_name,
    String package_name) {
  var dummyBody = Map();
  dummyBody[customerId] = custaccountid;
  dummyBody[noOfEmpl] = no_of_emp;
  dummyBody[netAmtRec] = netAmount;
  dummyBody[sChargeRate] = sgRate;
  dummyBody[sChargeAmt] = sgAmount;
  dummyBody[GstMode] = gst_mode;
  dummyBody[sgsRate] = sgstRate;
  dummyBody[sgstAmt] = sgstAmount;
  dummyBody[cGstRate] = cgstRate;
  dummyBody[cGstamt] = cgstAmount;
  dummyBody[iGstrate] = igstRate;
  dummyBody[igstAmt] = igstAmount;
  dummyBody[ntVal] = net_value;
  dummyBody[src] = source;
  dummyBody[createdBy] = createdby;
  dummyBody[createdIP] = created_ip;
  dummyBody[invoiceType] = invoice_type;
  dummyBody[serviceName] = service_name;
  dummyBody[packageName] = package_name;

  return getEncrypted_MapBody(dummyBody);
}

Map get_availableBalance_Requerst_Body(String customerAccountId) {
  var dummyBody = Map();

  dummyBody[viewInvoivce_customerAccountId] = getEncryptedData(customerAccountId);

  return getEncrypted_MapBody(dummyBody);
}


Map getLatestTransactionRequestBody(
    String customeraccountid, String transaction_flag, String status) {
  var dummyBody = Map();

  dummyBody[paymentplans_customerID] = getEncryptedData(customeraccountid);
  dummyBody[latest_Transaction_Transaxction_Flag] = transaction_flag;
  dummyBody[latest_Transaction_status] = status;

  return getEncrypted_MapBody(dummyBody);
}
Map get_paymentsPlans_requestBody(String customerAccountId) {
  var dummyBody = Map();

  dummyBody[paymentplans_customerID] = getEncryptedData(customerAccountId);

  return getEncrypted_MapBody(dummyBody);
}
/*----------------Basant----------------*/

Map getEmployer_getTodayAttendance(String customerAccountID,String att_date,
    String emp_name,String approved_status)
{
  var dummyBody=Map();
  dummyBody[kEmployer_Common_CustomerAccountIdKey]=getEncryptedData(customerAccountID);
  dummyBody[kEmployer_Attendance_AttendanceDateKey]=att_date;
  dummyBody[kEmployer_Attendance_EmpNameKey]=emp_name;
  dummyBody[kEmployer_Attendance_ApprovalStatusKey]=approved_status;
  return getEncrypted_MapBody(dummyBody);
}

Map getEmployer_MonthlyAttendance_RequestBody(String emp_code,String month,String year)
{
  var dummyBody = Map();
  dummyBody[kEmployer_Common_EmpCodeKey] = getEncryptedData(emp_code);
  dummyBody[kEmployer_Common_MonthKey] = month;
  dummyBody[kEmployer_Common_YearKey] = year;
  print("Data Map $dummyBody");


  return getEncrypted_MapBody(dummyBody);
}

Map saveEmployer_MonthlyAttendance_RequestBody(String emp_code, List attendancedates,String createdby,String customer_account_Id,String actionValue)
{

  var dummyBody = Map();
  dummyBody[kEmployer_Attendance_CalendarActionKey] = getEncryptedData(actionValue);
  dummyBody[kEmployer_Common_EmpCodeKey] = getEncryptedData(emp_code);
  dummyBody[kEmployer_Attendance_CalendarMarkedbyUserTypeKey] = "Employer";
  dummyBody[kEmployer_Attendance_CalendarAttendanceListKey] = attendancedates;
  dummyBody[kEmployer_Attendance_CalendarCreatedByKey] = createdby;
  dummyBody[kEmployer_Common_CustomerAccountIdKey] = customer_account_Id;
  print("Attendance To save Body $dummyBody");
  return getEncrypted_MapBody(dummyBody);


}

Map saveEmployer_PayoytPaySalary_RequestBody(String emp_code, Map attendancedates,String createdby,String customer_account_Id,String actionValue)
{

  var dummyBody = Map();
  dummyBody[kEmployer_Attendance_CalendarActionKey] = getEncryptedData(actionValue);
  dummyBody[kEmployer_Common_EmpCodeKey] = getEncryptedData(emp_code);
  dummyBody[kEmployer_Attendance_CalendarMarkedbyUserTypeKey] = "Employer";
  dummyBody[kEmployer_Attendance_CalendarAttendanceListKey] = attendancedates;
  dummyBody[kEmployer_Attendance_CalendarCreatedByKey] = createdby;
  dummyBody[kEmployer_Common_CustomerAccountIdKey] = customer_account_Id;
  return getEncrypted_MapBody(dummyBody);


}

Map getMasterLeaveTemplate_RequestBody(String customeraccountid)
{
  var dummyBody = Map();
  dummyBody[kEmployer_Common_CustomerAccountIdKey] = customeraccountid;
  return getEncrypted_MapBody(dummyBody);
}


Map getTemplatesetDefaultTemplate_RequestBody(String customeraccountid,String default_templateId){
  var dummyBody = Map();
  dummyBody[kEmployer_Attendance_LeaveSetting_ActionKey] = kEmployer_Attendance_LeaveSetting_ActionValue;
  dummyBody[kEmployer_Common_CustomerAccountIdKey] = customeraccountid;
  dummyBody[kEmployer_Attendance_LeaveSetting_DefaultTemplateIdKey] = default_templateId;
  return getEncrypted_MapBody(dummyBody);
}



Map getLeaveType_RequestBody(String customeraccountid)
{
  var dummyBody = Map();
  dummyBody[kEmployer_Attendance_LeaveSetting_ActionKey] = kEmployer_LeaveSetting_GETLeadType;
  dummyBody[kEmployer_Common_CustomerAccountIdKey] = customeraccountid;
  return getEncrypted_MapBody(dummyBody);
}

Map getSaveNewTemplate_RequestBody(String customerAccountId,Map<String,dynamic> addTemplateText)
{
  var dummyBody = Map();
  dummyBody[kEmployer_Attendance_LeaveSetting_ActionKey] = kEmployer_LeaveSetting_AddNewTemplate;
  dummyBody[kEmployer_Common_CustomerAccountIdKey] = customerAccountId;
  dummyBody[kEmployer_Attendance_LeaveSetting_saveNewTemplate] = addTemplateText;
  return getEncrypted_MapBody(dummyBody);
}
Map getAttendanceDetails_RequestBody(String empCode,String year)
{
  var dummyBody = Map();
  dummyBody[kEmployer_AttendanceDetails_EmpCodeKey] = getEncryptedData(empCode);
  dummyBody[kEmployer_Common_YearKey] = year;

  return getEncrypted_MapBody(dummyBody);

}
Map getNotification_RequestBody(String customerAccountId)
{
  var dummyBody = Map();
  dummyBody[kEmployer_Common_CustomerAccountIdKey] = getEncryptedData(customerAccountId);

  return getEncrypted_MapBody(dummyBody);
}

Map getEmployer_ExitSuspend_RequestBody(String customerAccountId,String empCode,String actionType,String ipAddress,String selectedDate)
{

  var dummyBody = Map();
  dummyBody[kEmployer_Common_CustomerAccountIdKey] = getEncryptedData(customerAccountId);
  dummyBody[kEmployer_EmpCodeKey] = empCode;
  dummyBody[kEmployer_ExitSuspended_Key] = actionType;
  dummyBody[kEmployer_ExitDateKey] = selectedDate;
  dummyBody[kEmployer_IPAddressKey] = ipAddress;

  return getEncrypted_MapBody(dummyBody);
}



/*const kEmployer_ExitSuspended_Key="status";
const kEmployer_Exit_Value="Inactive";
const kEmployer_Suspended_Value="Paused";*/
/*
const kEmployer_IPAddressKey="ip";
const kEmployer_EmpCodeKey="empcode";
const kEmployer_ExitDateKey="exit_date";*/

Map getEmployer_PayoutSalaryHoldandApproved_RequestBody(String customerAccountId,String empCode,String year,String month, String actionType)
{

  String remarks="";
  if(actionType==kEmployer_Approved_Value)
    {
      remarks="approved salary status";
    }
  else
    {
      remarks="hold salary status";
    }

  var dummyBody = Map();
  dummyBody[kEmployer_Common_CustomerAccountIdKey] = getEncryptedData(customerAccountId);
  dummyBody[kEmployer_EmpCodeKey] = getEncryptedData(empCode);;
  dummyBody[kEmployer_Common_YearKey] = year;
  dummyBody[kEmployer_Common_MonthKey] = month;
  dummyBody[kEmployer_Payout_ActionTypeKey] = getEncryptedData(actionType);
  dummyBody[kEmployer_Remarks_Key] = remarks;

  return getEncrypted_MapBody(dummyBody);

}
/*

{
"action_type" : "33PyreD6hkhGjzffE14F9Q==",
"customeraccountid" : "EqTraX5StRb4FiQjWzL90g==",
"empcode" : "4UTlE04Jt2ChvFPLYuUPh4ktam0q3G2RQUIGjNJX3ADc+Ym3C/IjsBa8B04UEFo/",
"remarks" : "Nhi Dunga tata bye bye",
"year" : "2022",
"month" : "3"
}*/



Map getEmployee_SaveTermsandConditions_RequestBody(String jsId,String ipAddress,String createdBy)
{

  var dummyBody = Map();
  dummyBody[kEmployee_Employee_TermsandConditions_ActionTypeKey] = getEncryptedData(kEmployee_Employee_TermsandConditions_ActionTypeValue);
  dummyBody[kEmployee_JSId_Key] = getEncryptedData(jsId);;
  dummyBody[kEmployee_IPAddress_Key] = ipAddress;
  dummyBody[kEmployee_CreatedBy_Key] = createdBy;

  return getEncrypted_MapBody(dummyBody);

}

/*
const kEmployee_Employee_TermsandConditions_ActionTypeKey="action_type";
const kEmployee_Employee_TermsandConditions_ActionTypeValue="AcceptTermsAndConditions";

const kEmployee_JSId_Key="js_id";
const kEmployee_IPAddress_Key="ip";
const kEmployee_CreatedBy_Key="createdby";
*/




Map getEmployer_DeleteEmployeeFromList_RequestBody(String customerAccountId,String employerId,String jsId,String createdBy)
{

  var dummyBody = Map();
  dummyBody[kEmployee_DeleteEmployee_CustomerAccIdKey] = customerAccountId;
  dummyBody[kEmployee_DeleteEmployee_EmployerIdKey] = employerId;
  dummyBody[kEmployee_DeleteEmployee_JSIdKey] = jsId;
  dummyBody[kEmployee_DeleteEmployee_CreatedByKey] = createdBy;
  dummyBody[kEmployee_DeleteEmployee_RemarksKey] = "delete employee from list";

  return getEncrypted_MapBody(dummyBody);

}


Map getNotificationForEmployee_RequestBody(String jsId)
{
  var dummyBody = Map();
  dummyBody[kEmployee_Notification_JSIdKey] = getEncryptedData(jsId);
  return getEncrypted_MapBody(dummyBody);
}
Map getEmployer_LinkSend_RequestBody(String jsId)
{
  var dummyBody = Map();
  dummyBody[kEmployee_Notification_JSIdKey] = jsId;
  return getEncrypted_MapBody(dummyBody);
}

Map getEmployer_UPITransaction_RequestBody(String upiTransactionRequest)
{
  var dummyBody = Map();
  dummyBody[kEmployer_UPITransaction_InputTextKey] = upiTransactionRequest;

  /*-------------15-2-2023 start-----------------*/
  //return getEncrypted_MapBody(dummyBody);
  return dummyBody;
  /*-------------15-2-2023 end-----------------*/

}

Map getEmployer_UPITransactionCallBackURL_RequestBody(String customerAccountId,String invoiceNo)
{
  var dummyBody = Map();
  dummyBody[kUPITransactionCallBack_CustomerAccountIdKey] = getEncryptedData(customerAccountId);
  dummyBody[kUPITransactionCallBack_InvoiceNoKey] = invoiceNo;
  return getEncrypted_MapBody(dummyBody);
}


/*------------------15-2-2023 start the 4 digit Pin Number----------------------*/
Map getEmployer_Set4DigitPin_RequestBody(String mobilePinNumber)
{
  var dummyBody=Map();
  dummyBody["encrypted"]=getEncryptedData(mobilePinNumber);
  return dummyBody;
}
Map getEmployer_Verify4DigitPin_RequestBody(String mobilePinNumber)
{
  var dummyBody=Map();
  dummyBody[kEmployer_PinNumber_MobilePinNumberKey]=getEncryptedData(mobilePinNumber);
  dummyBody[kTankhaPay_PinNumber_SaltKey]=getEncryptedData(Keys.get_SaltKey);

  return getEncrypted_MapBody(dummyBody);
}
/*------------------15-2-2023 start the 4 digit Pin Number----------------------*/


/*----------------update manual bank transfer 16-2-2023----------------*/

Map getEmployer_UpdateManualBankTransfer_RequestBody(String invoiceNo,String modifiedBy,String amount)
{
  var dummyBody=Map();
  dummyBody[kEmployer_ManualBankTransfer_InvoiceNoKey]=invoiceNo;
  dummyBody[kEmployer_ManualBankTransfer_DateOfReceivingKey]=Method.getTheCurrentDate_ForManualBankTransfer();
  dummyBody[kEmployer_ManualBankTransfer_ModifiedByKey]=modifiedBy;
  dummyBody[kEmployer_ManualBankTransfer_AmountKey]=amount;
  dummyBody[kEmployer_ManualBankTransfer_PaymentMethodKey]=kEmployer_ManualBankTransfer_PaymentMethodValue;

  return getEncrypted_MapBody(dummyBody);
}

/*----------------notification list 21-2-2023 start----------------*/

Map getEmployer_GetNotificationList_RequestBody(String tankhaPayUserType,tankhaPayUserIdType)
{
  var dummyBody=Map();
  dummyBody[kEmployer_NotificationList_ActionTypeKey]=getEncryptedData(kEmployer_NotificationList_GetUnreadAlertsActionTypeValue);
  dummyBody[kEmployer_NotificationList_AlertUserTypeKey]=getEncryptedData(tankhaPayUserType);
  dummyBody[kEmployer_NotificationList_EmpId]=getEncryptedData(tankhaPayUserIdType);

  return getEncrypted_MapBody(dummyBody);
}

Map getEmployer_UpdateNotificationList_RequestBody(String tankhaPayUserType,tankhaPayUserIdType)
{
  var dummyBody=Map();
  dummyBody[kEmployer_NotificationList_ActionTypeKey]=getEncryptedData(kEmployer_NotificationList_SetAlertViewdActionTypeValue);
  dummyBody[kEmployer_NotificationList_AlertUserTypeKey]=getEncryptedData(tankhaPayUserType);
  dummyBody[kEmployer_NotificationList_EmpId]=getEncryptedData(tankhaPayUserIdType);

  return getEncrypted_MapBody(dummyBody);
}
/*
const kEmployer_NotificationList_ActionTypeKey="actionType";
const kEmployer_NotificationList_GetUnreadAlertsActionTypeValue="GetUnreadAlerts";

const kEmployer_NotificationList_AlertUserTypeKey="alertUserType";
const kEmployer_NotificationList_AlertUserTypeValue="Employee";
const kEmployer_NotificationList_EmpId="emp_id";*/


/*----------26-2-2023 start--------------*/

Map getEmployer_SaveLeaveTemplate(String customerAccountId,String leaveDays,String payoutType, String payoutDate)
{
  var dummyBody = Map();
  dummyBody[customerId] = customerAccountId;
  dummyBody[kEmployee_leaveDays] = leaveDays;
  dummyBody[kEmployee_payoutType] = payoutType;
  dummyBody[kEmployee_payoutDate] = payoutDate;

  print("show the save leave request $dummyBody");
  return getEncrypted_MapBody(dummyBody);
}


Map getEmployer_payoutLeaveTemplate(String customerAccountId)
{

  var dummyBody = Map();
  dummyBody[customerId] = customerAccountId;
  return getEncrypted_MapBody(dummyBody);

}
/*-----------02-3-2023 start------------*/

Map getEmployer_ViewSalaryStructure(String customerAccountId,String jsId)
{

  var dummyBody = Map();
  dummyBody[kEmployer_SalaryStructure_CustomerAccountId] = getEncryptedData(customerAccountId);
  dummyBody[kEmployer_SalaryStructure_JSId] = getEncryptedData(jsId);

  return getEncrypted_MapBody(dummyBody);

}