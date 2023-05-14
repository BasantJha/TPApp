
/*-------------USE FOR REGISTRATION  7-12-2022 START-------------*/
const kEmployer_FLAG_SU="SU";//SIGN UP
const kEmployer_FLAG_BI="BI";//BUSINESS INFO
const kEmployer_STATUS_SIGNUP=0;//BUSINESS INFO

/*-------------USE FOR REGISTRATION  7-12-2022 EN-------------*/

/*-------------USE FOR KYC INFO 8-12-2022 START-------------*/



/*----------12-12-20222 KYC START--------*/
const kEmployer_FLAG_AV="AV"; //ACCOUNT VERIFY
const kEmployer_FLAG_KYCGST="KYC_GST";
const kEmployer_FLAG_KYCPAN="KYC_PAN";
const kEmployer_FLAG_KYCAADHAR="KYC_AADHAR";
const kEmployer_FLAG_CD="CD"; //company details
const kEmployer_FLAG_EA="EA"; //Employer aggreement means terms and conditions
const kEmployer_FLAG_SP="SP";

const kEmployer_FLAG_SPI="SPI"; //means (EA )

//starting payment

const kEmployer_STATUS_AV=1; //ACCOUNT VERIFY
const kEmployer_STATUS_KYC=2; //KYC MEANS GST,PAN,AADHAR
const kEmployer_STATUS_CD=3; //COMPANY DETAILS
const kEmployer_STATUS_EA=4; //EMPLOYER AGGREEMENT means terms and conditions
const kEmployer_STATUS_REJECT=5; //REJECTED
const kEmployer_STATUS_SP=6; //Starting payment

/*----------12-12-20222 KYC END--------*/

/*------------self status manage the joiner index-----------*/
const kEmployer_STATUS_KYC_TEMP=1; //KYC MEANS GST,PAN,AADHAR
const kEmployer_STATUS_CD_TEMP=2; //COMPANY DETAILS
const kEmployer_STATUS_EA_TEMP=3; //EMPLOYER AGGREEMENT means terms and conditions
const kEmployer_STATUS_SP_TEMP=4; //Starting payment



//const kEmployer_AadhaarNo_FLAG="AADHAR_Y";(not use in the employer module)

const kEmployer_USERTYPE_Business="Business";
const kEmployer_USERTYPE_Individual="Individual";

/*-------------USE FOR KYC INFO 8-12-2022 END-------------*/


/*---------Employer common keys------------*/
const kEmployer_Common_FlagKey="flag";
const kEmployer_Common_DeviceTypeKey="device_type";
const kEmployer_Common_UserIPKey="user_ip";
const kEmployer_Common_MobileKey="employer_mobile";


/*--------------------Employer Signup Info keys-----------------------*/
const kEmployer_SignUpInfo_FullNameKey="full_name";
const kEmployer_SignUpInfo_EmailIdKey="employer_email";
const kEmployer_SignUpInfo_PinCodeKey="employer_pincode";


/*--------------------Employer verify mobile keys-----------------------*/
const kEmployer_SignUpVerifyOTP_OTPKey="otp";
/*--------------------Employer Business Info keys-----------------------*/

const kEmployer_BusinessInfo_UserTypeKey="user_type";
const kEmployer_BusinessInfo_GSTStatusKey="gst_in_y_n";
const kEmployer_BusinessInfo_AreaOfWorkKey="area_of_work";
const kEmployer_BusinessInfo_NoOfEmployeeKey="no_of_employee";


//USE FOR GST
const kEmployer_KYC_UpdateGSTNoStatusKey="gstin_no_isverify_y_n";


//USE FOR Company details
const kEmployer_CompanyDetails_NameKey="company_name";
const kEmployer_CompanyDetails_AddressKey="company_address";
const kEmployer_CompanyDetails_StateKey="company_state";
const kEmployer_CompanyDetails_CityKey="company_town_city";
const kEmployer_CompanyDetails_PinCodeKey="company_pincode";
const kEmployer_CompanyDetails_WebsiteLinkKey="website_app_link";
//four common parameters
//USE FOR Company details

/*-----USE FOR Employer Aggreements------*/
const kEmployer_Aggreement_AcceptOnboardKey="accept_onboarded_akal_y_n";
const kEmployer_Aggreement_AcceptAdditionalKey="accept_additional_charges_y_n";
const kEmployer_Aggreement_AcceptPFESICKey="accept_pf_esic_y_n";
const kEmployer_Aggreement_AcceptTermsConditionsKey="accept_term_conditions_y_n";

const getAggreementStatus="Y";
//four common parameters



/*-------------USE FOR KYC INFO 8-12-2022 START-------------*/

//USE FOR PAN
const kEmployer_KYC_PANNoKey="ac_pan_no";

/*----------verify Aadhaar No---------*/
const kEmployer_KYC_AadhaarNoKey="aadhar_number";
const kEmployer_KYC_EmployerIdKey="employer_id";

/*----------verify Aadhaar OTP---------*/
const kEmployer_KYC_MobileNoKey="mobile_number";
const kEmployer_KYC_OTPKey="otp";
const kEmployer_KYC_ClientIdKey="client_id";

/*----------verify GST NO---------*/
const kEmployer_KYC_GSTNoKey="id_number";
const kEmployer_KYC_GSTEmployerIdKey="emp_id";


/*----------verify GST OTP(use below key)---------*/
/*const kEmployer_KYC_GSTNoKey="id_number";
const kEmployer_KYC_GSTEmployerIdKey="emp_id";
const kEmployer_KYC_OTPKey="otp";
const kEmployer_KYC_ClientIdKey="client_id";*/

/*-----------Company Details start-----------*/

const kEmployer_KYC_StateIdKey="state_code";


/*-------------update profile photo--------------*/


const kEmployer_UpdateProfile_ActionKey = "action";
const kEmployer_UpdateProfile_ActionValue = "ProfilePhotoUpload";

const kEmployer_Common_CustomerAccountIdKey = "customeraccountid";
const kEmployer_UpdateProfile_PayoutFreqDateKey = "payout_frequency_dt";
const kEmployer_UpdateProfile_PhotoNameKey = "emp_profile_photo_name";
const kEmployer_UpdateProfile_PhotoPathKey = "emp_profile_photo";

const kEmployer_UpdateProfile_PayoutDateActionValue = "PayoutDateSet";

/*-------------update billing address------------*/
const kEmployer_BillingAddressUpdate_AddressKey="address";
const kEmployer_BillingAddressUpdate_AddressKey2="adress_ii";
const kEmployer_BillingAddressUpdate_StateKey="state";
const kEmployer_BillingAddressUpdate_CityKey="city";
const kEmployer_BillingAddressUpdate_PinCodeKey="pincode";

const kEmployer_UpdateBillingAddress_ActionValue = "employerBillingAddres";


/*-------Employer PayOut Summary------*/
const kEmployer_PayOutSummary_PayoutTypeKey="payouttype";

/*-----Customer PayOut Details-------*/
const kEmployer_Common_MonthKey="month";
const kEmployer_Common_YearKey="year";
const kEmployer_PayOutDetails_EmpcodeKey="empcode";


const viewInvoivce_customerAccountId = "customerAccountId";
const viewInvoivce_baseAmount = "baseAmount";
const viewInvoivce_numberOfEmployees = "numberOfEmployees";



/*-----USE FOR Add Employee 17-12-2022 start....pratibha------*/

const kEmployer_AddEmployee_NameKey="employee_name";
const kEmployer_AddEmployee_MobileNumberKey="employee_mobile";
const kEmployer_AddEmployee_MonthlySalaryKey="monthly_salary";
const kEmployer_AddEmployee_DateOfJoiningKey="doj";
const kEmployer_AddEmployee_DesignationKey="designation";
const kEmployer_AddEmployee_EmailAddressKey="employee_email";
const kEmployer_AddEmployee_AccountIdKey="account_id";
const kEmployer_AddEmployee_EmployerIdKey="employer_id";
const kEmployer_AddEmployee_EmployerLeadIdKey="employer_leadid";
const kEmployer_AddEmployee_CreatedByKey="createdby";
const kEmployer_AddEmployee_CreatedIpKey="createdip";
const kEmployer_AddEmployee_SalaryStructureKey="salary_structure";
const kEmployer_AddEmployee_LeaveTemplateIdKey="leave_templateid";




/*-----USE FOR Add Employee leave template dropdown 26-12-2022 start....pratibha------*/



/*-----USE FOR Monthly CTC Calculator 19-12-2022 start....pratibha------*/
const kEmployer_MonthlyCtcCalculator_MonthlyPackageKey="monthly_package";
const kEmployer_Common_EmpCodeKey="emp_code";

/*-----USE FOR In Hand Calculator 23-12-2022 start....pratibha------*/

const kEmployer_InHandSalaryCalculator_InHandSalaryKey="inhandsalary";

/*-----USE FOR Calculator 29-12-2022 start....pratibha------*/




/*_____________Ritik 2/1/2023 Start________________*/
const TokenGenamount = "amt";
const TokenGenorderId = "orderId";
const TokenGencustomerAccountId = "customerAccountId";
const TokenGencurrency = "currency";
const TokenGenrequestType = "requestType";
/*_____________Ritik 2/1/2023 End________________*/

/*_____________Ritik 4/1/2023 Start________________*/
const InvoiceCustid = "customerAccountId";
const InvoiceBaseAmt = "baseAmount";
const InvoiceNoEmp = "numberOfEmployees";

//for amount api
const EmpIdForInvoiceAmount = "employer_id";

//for generation order
const customerId = "customeraccountid";
const noOfEmpl = "numberofemployees";
const netAmtRec = "netamountreceived";
const sChargeRate = "servicechargerate";
const sChargeAmt = "servicechargeamount";
const GstMode = "gstmode";
const sgsRate = "sgstrate";
const sgstAmt = "sgstamount";
const cGstRate = "cgstrate";
const cGstamt = "cgstamount";
const iGstrate = "igstrate";
const igstAmt = "igstamount";
const ntVal = "netvalue";
const src = "source";
const createdBy = "created_by";
const createdIP = "createdbyip";
const invoiceType = "invoicetype";
const serviceName = "service_name";
const packageName = "package_name";
/*_____________Ritik 4/1/2023 End________________*/




const paymentplans_customerID = "customeraccountid";
const latest_Transaction_Transaxction_Flag = "transaction_flag";
const latest_Transaction_status = "status";



/*---------------------------- Employer Attendance Keys Starts -------------- */

const kEmployer_Attendance_AttendanceDateKey = "att_date";
const kEmployer_Attendance_EmpNameKey = "emp_name";
const kEmployer_Attendance_ApprovalStatusKey = "approval_status";


/*---------------------------- Employer Attendance Keys Ends -------------- */


/*----------------------   EmployerNewWorkPlaceCalendarAttendance Key Start 20-12-2022  ------------------------ */

const kEmployer_Attendance_CalendarActionKey = "actionType";




const kEmployer_Attendance_CalendarMarkedbyUserTypeKey = "markedByUserType";
const kEmployer_Attendance_CalendarAttendanceListKey = "attendanceDates";
const kEmployer_Attendance_CalendarCreatedByKey = "created_by";

/*----------------------------  EmployerNewWorkPlaceCalendarAttendance Key End 20-12-2022 -------------------------*/


/*----------------------------  EmployerNewWorkPlaceLeaveSettingAttendance Key Start 22-12-2022 --------------------*/


const kEmployer_Attendance_LeaveSetting_ActionKey = "action";
const kEmployer_Attendance_LeaveSetting_ActionValue = "set_default_template";

const kEmployer_Attendance_LeaveSetting_DefaultTemplateIdKey = "default_templateId";

const kEmployer_Attendance_LeaveSetting_saveNewTemplate = "add_template_txt";
/*----------------------------  EmployerNewWorkPlaceLeaveSettingAttendance Key End 22-12-2022 --------------------*/


/*-----------------------    Employer WorkPlace Attendance Details Key Start 30-12-2022 ---------------------------*/

const kEmployer_Attendance_SaveBulkAttendance_ActionValue = "SaveBulkAttendance";
const kEmployer_Attendance_ApproveBulkAttendance_ActionValue = "ApproveBulkAttendance";
const kEmployer_Attendance_LockAttendance_ActionValue = "LockAttendance";

/*------------use for the payout description (24-2-2023 start)------------*/
const kEmployer_Payout_PaySalary_ActionValue = "PaySalary";
/*------------use for the payout description (24-2-2023 end)------------*/





const kEmployer_LeaveSetting_GETLeadType="get_lead_type";
const kEmployer_LeaveSetting_AddNewTemplate="add_new_template";
const kEmployer_AttendanceDetails_EmpCodeKey="empcode";


/*-----------------------    Employer WorkPlace Attendance Details Key End 30-12-2022 ---------------------------*/

/*--------------Employer Exit , Suspended and Resume(17-1-20223)-------------*/

const kEmployer_ExitSuspended_Key="status";
const kEmployer_Exit_Value="Inactive";
const kEmployer_Suspended_Value="Paused";
const kEmployer_Resume_Value="Resume";
const kEmployer_IPAddressKey="ip";
const kEmployer_EmpCodeKey="empcode";
const kEmployer_ExitDateKey="exit_date";

/*--------------Employer Payout module  APPROVED and HOLD(17-1-20223)-------------*/

const kEmployer_Payout_ActionTypeKey="action_type";
const kEmployer_Approved_Value="APPROVED";
const kEmployer_Hold_Value="HOLD";
const kEmployer_Remarks_Key="remarks";

/*

{
"action_type" : "33PyreD6hkhGjzffE14F9Q==",
"customeraccountid" : "EqTraX5StRb4FiQjWzL90g==",
"empcode" : "4UTlE04Jt2ChvFPLYuUPh4ktam0q3G2RQUIGjNJX3ADc+Ym3C/IjsBa8B04UEFo/",
"remarks" : "Nhi Dunga tata bye bye",
"year" : "2022",
"month" : "3"
}*/


/*--------------Employee save Accept terms and conditions(21-1-20223)-------------*/

const kEmployee_Employee_TermsandConditions_ActionTypeKey="action_type";
const kEmployee_Employee_TermsandConditions_ActionTypeValue="AcceptTermsAndConditions";

const kEmployee_JSId_Key="js_id";
const kEmployee_IPAddress_Key="ip";
const kEmployee_CreatedBy_Key="createdby";


/*
{
"action_type" : "3X5U+eKRx7Tk2jt7PQYF4uCAOEqUJsb95OOqOorcwhc=",
"js_id" : "52CXn53fGt6WKDcCjYgOzg==",
"ip" : "::1",
"createdby" : "5610"
}
*/

const kEmployee_DeleteEmployee_CustomerAccIdKey="customeraccountid";
const kEmployee_DeleteEmployee_EmployerIdKey="employer_id";
const kEmployee_DeleteEmployee_RemarksKey="backout_remark";
const kEmployee_DeleteEmployee_JSIdKey="js_id";
const kEmployee_DeleteEmployee_CreatedByKey="createdby";


/*{
  "customeraccountid": "333",
  "employer_id": "359",
  "backout_remark": "hh",
  "js_id": "3666",
  "createdby": "testbypostman"
}*/

/*--------employee notification list------*/
const kEmployee_Notification_JSIdKey="js_id";


/*---------------9-2-2023 start-----------------*/

const kEmployer_UPITransaction_InputTextKey="input_text";

const kUPITransactionCallBack_CustomerAccountIdKey="customerAccountId";
const kUPITransactionCallBack_InvoiceNoKey="invoiceNo";


/*----------------4 digit pin number start 14-2-2023----------------*/
const kEmployer_PinNumber_MobilePinNumberKey="employerMobileNo";

/*----------------update manual bank transfer 16-2-2023----------------*/
const kEmployer_ManualBankTransfer_InvoiceNoKey="invoiceno";
const kEmployer_ManualBankTransfer_DateOfReceivingKey="dateofreceiving";
const kEmployer_ManualBankTransfer_ModifiedByKey="modified_by";
const kEmployer_ManualBankTransfer_AmountKey="amount";
const kEmployer_ManualBankTransfer_PaymentMethodKey="paymentmethod";
const kEmployer_ManualBankTransfer_PaymentMethodValue="Manual Bank Transfer";

/*--------------21-2-2023 start-----------------*/
//get the notification list
const kEmployer_NotificationList_ActionTypeKey="actionType";
const kEmployer_NotificationList_GetUnreadAlertsActionTypeValue="GetUnreadAlerts";
const kEmployer_NotificationList_AlertUserTypeKey="alertUserType";
const kEmployer_NotificationList_AlertUserTypeEmployer="Employer";
const kEmployer_NotificationList_EmpId="emp_id";

//use for the employee

const kEmployer_NotificationList_AlertUserTypeEmployee="Employee";


//update the notification list
const kEmployer_NotificationList_SetAlertViewdActionTypeValue="SetAlertViewd";



//actionType Must be GetUnreadAlerts - o9Z6RZyWd3L6km/Xj7ZbDw== OR SetAlertViewd - MXdEfPkwLLpzioGj2SqrpA==

/*{
"actionType":"o9Z6RZyWd3L6km/Xj7ZbDw==",
"alertUserType":"m93y/NzBMNUlqnp7NyGQ5w==", // alertUserType Must be Employer - m93y/NzBMNUlqnp7NyGQ5w== OR Employee -
"emp_id":"0t6rpbojIoSmPuwbm1brfQ==" if alertUserType is Employer then provide custumerAccountID.
if alertUserType is Employee then jsId value
}*/

/*-----------26-2-2023 start------------*/
const kEmployee_leaveDays="leaveDays";
const kEmployee_payoutType="payoutType";
const kEmployee_payoutDate="payoutDate";

/*-----------26-2-2023 end------------*/

/*-----------02-3-2023 start------------*/

const kEmployer_SalaryStructure_CustomerAccountId="customerAccountId";
const kEmployer_SalaryStructure_JSId="jsId";

/*-----------02-3-2023 end------------*/

