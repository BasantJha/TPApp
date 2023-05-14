

import '../../Constant/Constants.dart';

const kJG_ContentType="application/x-www-form-urlencoded; charset=UTF-8";

const JG_BaseURL="https://$TankhaPayURL.azurewebsites.net/api/";
const JG_BaseURL_WithMobileApi="https://$TankhaPayURL.azurewebsites.net/mobile_api/";

/*---------------Employer login-------------------*/
const JG_ApiMethod_EmployerVerifyMobileNo=JG_BaseURL+""+"employer_login_otp_send";
const JG_ApiMethod_EmployerVerifyOTP=JG_BaseURL+""+"employer_user_login";

/*--EmployerCommonRegistration api use for the(Sign up(SU), Business(BI), PAN,Company Details, Employer Aggreement )--*/
const JG_ApiMethod_EmployerCommonRegistration=JG_BaseURL+""+"employer_register";

/*-------use for employer reistration---------*/
const JG_ApiMethod_EmployerAreaOfWork=JG_BaseURL+""+"get_area_of_work";

//
const JG_ApiMethod_AadhaarSendOTP=JG_BaseURL+""+"employer/send_aadhar_otp";
const JG_ApiMethod_AadhaarVerifyOTP=JG_BaseURL+""+"employer/verify_aadhar_otp";

const JG_ApiMethod_GSTSendOTP=JG_BaseURL+""+"send_gst_otp";
const JG_ApiMethod_GSTVerifyOTP=JG_BaseURL+""+"verfity_gst_otp";

/*----------------use for the joiner company details --------------------*/
const JG_ApiMethod_GetAllStates=JG_BaseURL+""+"employer/getAll_state";
const JG_ApiMethod_GetAllCities=JG_BaseURL+""+"employer/getAll_district";//not working

/*-----------use for the terms and conditions-----------*/
const JG_ApiMethod_EmployerAggreement=JG_BaseURL+""+"get_employer_aggreement";




const JG_ApiMethod_EmployerKYCStatus=JG_BaseURL+""+"employer/getEmployer_status";


const JG_ApiMethod_EmployerUpdateProfile = JG_BaseURL + "" + "employer/updateEmployerProfile";
const JG_ApiMethod_GETEmployerProfile = JG_BaseURL + "" + "employer/getEmployerProfile";

/*----------use for Employer PayOut Summary 30-12-2022------------*/
const JG_ApiMethod_EmployerPayOutList=JG_BaseURL+""+"TpCandidateAPI/CustomerPayoutSummary";

/*---------use for Customer PayOut Details 02-01-2023------------*/
const JG_ApiMethod_EmployerPayOutDetails=JG_BaseURL+""+"TpCandidateAPI/CustomerPayoutDetails";

const JG_ApiMethod_Employer_ViewInvoice = JG_BaseURL+""+"ReceivablesApi/CalcReciebaleFromBaseAmount";



/*---------------Add Employee 17-12-2022 start....pratibha-------------------*/
const JG_ApiMethod_AddEmployee=JG_BaseURL+""+"Employee/AddEmployee";
const JG_ApiMethod_UpdateAddEmployee=JG_BaseURL+""+"Employee/UpdateEmployee";
const JG_ApiMethod_SaveAddEmployee=JG_BaseURL+""+"Employee/SaveTpCandidateSalary";



/*---------------Add Employee 19-12-2022 start....pratibha-------------------*/
const JG_ApiMethod_MonthlyCtcCalculator=JG_BaseURL+""+"TpCandidateAPI/CalSalStructureFromCTC";
const JG_ApiMethod_InHandSalaryCalculator=JG_BaseURL+""+"TpCandidateAPI/CalSalStructureFromSalInHand";
const JG_ApiMethod_EmployerLeaveTemplate=JG_BaseURL+""+"attendence/leavetemplate";

/*-----------------29-1-2023 start(new api for salary calculator)--------------------*/
const JG_ApiMethod_EmployeeCommonSalaryCalculator=JG_BaseURL+""+"Employee/find_minwages";
/*-----------------29-1-2023 end--------------------*/




/*---------------Employee Details 29-12-2022 start....pratibha-------------------*/
const JG_ApiMethod_EmployerDetails=JG_BaseURL_WithMobileApi+""+"employer/attendance/employer_details";



/*--------------------Payment Page Url (RITIK)--------------------------------------*/
 const JG_ApiMethod_TransUrl = JG_BaseURL_WithMobileApi + "" + "employer/payment_gateway/paytm_transaction";
 const JG_ApiMethod_CallBackUrlForTxn = JG_BaseURL_WithMobileApi + "" + "employer/txnresponse/paytm_txnresponse";

/*--------------------Add Starting Payment (Ritik)----------------------------------*/
 //const JG_ApiMethod_InvoiceDetails = JG_BaseURL + "" + "ReceivablesApi/CalcReciebaleFromBaseAmount";
 const JG_ApiMethod_StartingPayment = JG_BaseURL + "" + "employer/employerStartingPaymentset";
 const JG_ApiMethod_GetOrderForInvoice = JG_BaseURL + "" + "save_receivables";


const JG_ApiMethod_Employer_AvailableBalance = JG_BaseURL + "" + "ReceivablesApi/GetCustomerLedgerSummary";
const JG_ApiMethod_Employer_Latest_Transactions = JG_BaseURL_WithMobileApi + "" + "employer/balance/employer_latest_transaction";
const JG_ApiMethod_Employer_PaymentsPlan = JG_BaseURL_WithMobileApi + "" + "employer/attendance/get_employer_montly_subscription";

//

const JG_ApiMethod_Employer_AttendanceCalendar_GetMonthlyAttendance = JG_BaseURL_WithMobileApi +""+"employee/attendance/get_monthly_attendance";
const JG_ApiMethod_Employer_AttendanceCalendar_SaveMonthlyAttendance = JG_BaseURL_WithMobileApi +""+ "employee/attendance/save_monthly_attendance";
const JG_ApiMethod_Employer_NewWorkPlaceAttendance = JG_BaseURL_WithMobileApi +""+"employer/attendance/get_employer_today_attendance";


const Employer_NewWorkPlace_Attendance_getAttendanceDetails = JG_BaseURL+""+"attendence/GetEmployeeLeaveSummary";


const JG_ApiMethod_Employer_NewWorkPlaceLeaveSettingAttendance = JG_BaseURL+""+"attendence/leavetemplate";


const JG_ApiMethod_Employer_NewWorkPlaceLeaveSettingAttendance_TemplatesetDefaultTemplate = JG_BaseURL+""+"attendence/getLeaveTemplate";
const Employer_NewWorkPlace_Attendance_ApiMethod_savenewTemplate = JG_BaseURL+"attendence/getLeaveTemplate";
const Employer_NewWorkPlace_ApiMethod_createLeavetemplate_getLeaveType = JG_BaseURL+""+"attendence/getLeaveTemplate";

const Employer_Home_Notification = JG_BaseURL_WithMobileApi + "employer/attendance/get_employer_notification";


const JG_ApiMethod_Employer_EmployerExitSuspended = JG_BaseURL+""+"TPCandidateApi/SyncEmployeeStatus";

//Hold or Approved
const JG_ApiMethod_Employer_EmployerUpdateSalaryStatus = JG_BaseURL+""+"attendence/UpdateSalaryStatus";
const JG_ApiMethod_Employer_EmployerDelete = JG_BaseURL+""+"Employee/DeleteEmployee";


const JG_ApiMethod_Employee_TermsandConditions = JG_BaseURL+""+"employer/get_associates_aggreement";
const JG_ApiMethod_Employee_SaveTermsandConditions = JG_BaseURL+""+"TpCandidateAPI/TermsandConditions";

//https://crmemployer.azurewebsites.net/mobile_api/employee/submit_emp_otp

const JG_ApiMethod_EmployeeNotification = JG_BaseURL + "TpCandidateAPI/TpEmployeeNotification";


const TankhaPay_SavePushNotificationTokenApi = JG_BaseURL + "TpCandidateAPI/Tpinsert_update_token";


const JG_ApiMethod_Employer_ResendLink = JG_BaseURL+""+"employeeaReSendlink";

const JG_ApiMethod_UPITransactionAPI_MePayInetent = JG_BaseURL+""+"mePayInetent";
const JG_ApiMethod_UPITransactionCallBackAPI = JG_BaseURL+""+"ReceivablesApi/getinvoice";


const JG_ApiMethod_SetEmployer_4DigitPinNumber = JG_BaseURL+""+"employer/employerSaveTpPin";
const JG_ApiMethod_VerifyEmployer_4DigitPinNumber = JG_BaseURL+""+"employer_pin_verify";

const JG_ApiMethod_Payment_UpdateBankTransfer = JG_BaseURL+""+"bank/manual_transfer";


/*------------21-2-20223 start use for the notification list(Employer and Employee)---------*/
const JG_ApiMethod_TankhaPayNotificationList_TPAlertApi = JG_BaseURL+""+"TpAlertsApi/getTpAlerts";

/*------------21-2-20223 end---------*/

/*---------------25-2-23 start(Payout pay salary)-------------------*/
const JG_ApiMethod_Employer_Payout_PaySalary = JG_BaseURL_WithMobileApi +""+ "employee/attendance/paysalary";

/*---------------25-2-23 end-------------------*/

/*-----------------26-2-2023 start use for Payout Setting------------------*/

const JG_ApiMethod_Employer_PayoutSetting_NOOfLeave = JG_BaseURL + "employer/get_mst_no_of_leave";
const JG_ApiMethod_Employer_PayoutSetting_SaveLeaveTemplate = JG_BaseURL + "attendence/saveLeaveTemplate";
const JG_ApiMethod_Employer_PayoutGet_LeaveTemplate = JG_BaseURL + "attendence/get_leave_template";


/*-----------------02-03-2023 start use for the salary restructure------------------*/
const JG_ApiMethod_Employer_GetSalaryStructure = JG_BaseURL +""+ "employer/GetTPSalaryStructure";
/*-----------------02-03-2023 end use for the salary restructure------------------*/