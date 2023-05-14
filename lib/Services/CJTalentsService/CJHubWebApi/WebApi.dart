
import '../../../Constant/Constants.dart';

class WebApi
{

////
   static  const service_Content_Type="application/x-www-form-urlencoded; charset=UTF-8";
   //static  const base_URL= "https://demoarea.1akal.in/cj/mobile_api/";
   //static  const base_URL= "https://api.contract-jobs.com/mobile_api/";
  //static  const service_Content_Type="application/json";

   //Production Employer/TankhaPay Api base Url=> https://tankhapayapi.azurewebsites.net

   static  const base_URL= "https://$TankhaPayURL.azurewebsites.net/mobile_api/";
   static  const base_URL_HUB= "https://$TankhaPayURL.azurewebsites.net/";



   /*----------19-12-2022 START----------*/
   static  const  tankhaPayVerifyMobile_api = base_URL+""+"employee/verify_emp_mobile";
   static  const  tankhaPayVerifyOTP_api = base_URL+""+"employee/submit_emp_otp";
   /*----------19-12-2022 END----------*/

  /*--------------update profile picture 23-12-2022 start-----------------*/
  static  const  tankhaPayUpdateProfilePicture_api = base_URL+""+"employee/User_profile/insert_profile_photo";


   /*----------------tankhapay attendance module start 20-12-2022--------------------------*/

   //map
   static const TankhaPay_ApiMethod_get_TodayAttendance = base_URL + "employee/attendance/get_employee_today_attendance";
   static const TankhaPay_ApiMethod_Employee_checkIn = base_URL + "employee/attendance/check_in";
  //attendance
   static const TankhaPay_ApiMethod_get_MonthlyAttendance = base_URL+"employee/attendance/get_monthly_attendance";
   static const TankhaPay_ApiMethod_save_MonthlyAttendance = base_URL + "employee/attendance/save_monthly_attendance";


   /*----------------tankhapay attendance module end 20-12-2022--------------------------*/



   static  const  verifyMobile_api = base_URL+""+"employee/user/verify_emp_mobile";
  static  const  sendOTP_api = base_URL+""+"employee/user/send_otp_to_employe";
  static  const  verifyOTP_api = base_URL+""+"employee/user/verify_employee_otp";
  static const  getApp_VersionCode = base_URL+""+"App_version/mobile";


  static  const  viewEmp_CardIdDetails = base_URL+""+"employee/User_profile/id_card_details";
  static  const  insert_Emp_ProfilePhoto = base_URL+""+"employee/User_profile/insert_profile_photo";

  /*------------salary module--------------*/
  static  const  get_Salary_Status = base_URL+""+"employee/salary/salary_status";
  static  const  get_Salary_Slip = base_URL+""+"employee/salary/salary_slip";
  /*------------tax module start--------------*/


  /*------------investment declaration 4/8/2021 start--------------*/
  static  const  tax_get_Emp_RegimeType = base_URL+""+"employee/tax/emp_regime";
  static  const  tax_save_Emp_RegimeType = base_URL+""+"employee/tax/save_emp_regime";
  static  const  get_Tax_Calculation = base_URL+""+"employee/tax/tax_projection";
  /*------------investment declaration end--------------*/


  /*------------tax module start--------------*/
  static  const  tax_investment_heads = base_URL+""+"employee/tax/investment_heads";
  static  const  tax_investment_sections = base_URL+""+"employee/tax/investment_sections";
  static  const  tax_save_employee_investment = base_URL+""+"employee/tax/save_emp_investment";


  /*--------other income details start----------*/
  static  const  tax_get_previous_employer_income = base_URL+""+"employee/tax/previous_employer_income";
  static  const  tax_save_previous_employer_income_details = base_URL+""+"employee/tax/save_previous_employer_income_details";


/*--------other income details end----------*/


  /*-------- home loan details start----------*/
  static  const  tax_get_house_Loan = base_URL+""+"employee/tax/home_loan";
  static  const  tax_save_house_Loan = base_URL+""+"employee/tax/save_home_loans_details";
 /*-------- home loan details end----------*/


  /*-------- let_out_property_details start----------*/
  static  const tax_get_house_let_out_property_details = base_URL+""+"employee/tax/let_out_property_details";
  static  const save_let_out_house_property_details = base_URL+""+"employee/tax/save_let_out_property_details";
/*-------- let_out_property_details end----------*/

  /*-------- rent_details start----------*/
  static  const String tax_get_rent_details = base_URL+""+"employee/tax/employee_rent_details";
  static  const String tax_save_rent_details = base_URL+""+"employee/tax/save_emp_rent_details";
/*-------- rent_details end----------*/

  /*-------- car_details start----------*/
  static  const String tax_get_car_details = base_URL+""+"employee/tax/car_details";
  static  const String tax_save_car_details = base_URL+""+"employee/tax/save_car_details";
/*-------- car_details end----------*/

  /*-------- save employee pin number start----------*/
  static  const String save_Emp_Pin_Number = base_URL+""+"employee/user/save_emp_pin";
  /*-------- save employee pin number end----------*/


/*------------------insurance module start---------------*/

  static  const String get_Emp_Insurance_Status = base_URL+""+"employee/Insurance/emp_insurance_status";
  static  const String get_Emp_Insurance_Card = base_URL+""+"employee/Insurance/insurance_card";
  static  const String save_Emp_Insurance_Details = base_URL+""+"employee/Insurance/save_insurance_details";

/*------------------HR CONNECT(SUPPORT) module start---------------*/

  static  const String get_HRConnect_Subject_Tickets = base_URL+""+"employee/query/tickets";
  static  const String save_HRConnect_CreateQuery = base_URL+""+"employee/query/save_query";
  static  const String get_HRConnect_PendingQuery = base_URL+""+"employee/query/type";

  static  const String get_HRConnect_PendingThread = base_URL+""+"employee/query/query_trail";
  static  const String get_HRConnect_SavePendingQuery_Trail = base_URL+""+"employee/query/save_query_trail";


/*------------------UploadInvestmentProof HRA  module start---------------*/

  //static  const String get_UploadInvestmentProof_Tenure = base_URL+""+"employee/master/tenure";
  //static  const String get_UploadInvestmentProof_States = base_URL+""+"employee/master/states";
  static  const String get_UploadInvestmentProof_States_Tenure = base_URL+""+"employee/master/states_tenure";

  static  const String save_UploadInvestmentProof_HRA = base_URL+""+"employee/Investment/save_investment_details";
  static  const String get_UploadInvestmentProof_HRA = base_URL+""+"employee/Investment/investment_details";



  /*------------------UploadInvestmentProof 80c module start---------------*/
  static  const String save_UploadInvestmentProof_80C = base_URL+""+"employee/Investment/save_eighty_c_details";
  static  const String gate_UploadInvestmentProof_80C = base_URL+""+"employee/Investment/eighty_c_details";


  /*------------------home_loan_details  module start---------------*/
  static  const String save_UploadInvestmentProof_HomeLoanDetails = base_URL+""+"employee/Investment/save_home_loan";
  static  const String gate_UploadInvestmentProof_HomeLoanDetails = base_URL+""+"employee/Investment/home_loan_details";


  /*------------------UploadInvestmentProof chapter-VI module start---------------*/
  static  const String save_UploadInvestmentProof_chapterVI = base_URL+""+"employee/Investment/save_CH6";
  static  const String gate_UploadInvestmentProof_chapterVI = base_URL+""+"employee/Investment/CH6_details";


  /*---------KYC Details module start -10-1-2022--------------*/
  static  const String save_KYCDetails = base_URL+""+"employee/user_profile/save_kyc_details";
  static  const String get_KYCDetails = base_URL+""+"employee/user_profile/kyc_details";
  /*--------Upload documents module start-----------*/

  //static  const String get_DocumentTypeList = base_URL+""+"employee/master/docs_lists";
  static  const String get_DocumentData = base_URL+""+"employee/user_profile/docs_details";
  static  const String save_DocumentData = base_URL+""+"employee/user_profile/save_docs_details";

  //http://demoarea.1akal.in/cj/mobile_api/employee/user_profile/docs_details

  /*--------personal details  start-----------*/
  static  const String get_PersonalDetails = base_URL+""+"employee/user_profile/personal_details";
  static  const String save_PersonalDetails = base_URL+""+"employee/user_profile/save_personal_details";

  /*----------------notification start 8-2-2022 start------------------------*/
  static  const String get_NotificationList_EC_Employee = base_URL+""+"employee/Notification/listing";
  static  const String get_NotificationList_TEC_Employee = base_URL+""+"employee/Notification/js_listing";
  static  const String save_NotificationToken = base_URL+""+"Notification/insert_update_token";
  /*----------------notification end 8-2-2022 end------------------------*/


  /*----------------Rider Nominee details(RTEC) start 11-4-2022 start------------------------*/

  static  const String save_Rider_NomineeDetails = base_URL+""+"employee/ridder/save_update_nominee_details";
  static  const String get_Rider_NomineeDetails = base_URL+""+"employee/ridder/nominee_details";
  static  const String get_Rider_RTEC_Summary = base_URL+""+"employee/ridder/summary";

  /*----------------Rider Nominee details start 11-4-2022 end------------------------*/
  static  const String get_Employee_CheckInDetails = base_URL+""+"employee/ridder/check_in";
  static  const String save_Rider_CheckOutDetails = base_URL+""+"employee/ridder/check_out";


  /*--------------Rider module start (REC) start 19-4-2022 start--------*/
  static  const String get_Rider_Wallet = base_URL+""+"employee/ridder/get_gig_payment_details";


  /*-----------------20-5-2022 start(use for the save qrcode id)----------------*/

  static  const String save_QRCode_Details = base_URL+""+"employee/qr_code/assign_qr_code_to_user";
  static  const String save_QRCode_UniqueKey = base_URL+""+"employee/qr_code/save_unique_key";
  static  const String save_QRCode_IsAssignToUser = base_URL+""+"employee/qr_code/is_qr_code_assign_to_user";

  /*----------------notification  21-3-2022 START------------------------*/


 // static  const base_URL_HUB= "https://api.contract-jobs.com/crm_api/hub_kyc/candidate/";

  //static  const base_URL_HUB= "https://crmemployer.azurewebsites.net/";


  static  const String verify_PAN_Number = base_URL_HUB+""+"crm_api/hub_kyc/candidate/pan_kyc";
  static  const String verify_UANNumber_and_UpdateProfileAddress = base_URL_HUB+""+"mobile_api/employee/attendance/uan_bank_address";
  static  const String get_EmployeeKYC_Status = base_URL_HUB+""+"mobile_api/employee/attendance/GetKYCBenifitsData";

  static  const String verify_Aadhaar_Number = base_URL_HUB+""+"crm_api/hub_kyc/candidate/send_aadhar_otp";
  static  const String verify_Aadhaar_OTP = base_URL_HUB+""+"crm_api/hub_kyc/candidate/submit_aadhar_otp";
  static  const String save_kyc_verification_status = base_URL_HUB+""+"save_kyc_verification_status";
  static  const String save_AppActivationLogTo_CRM = base_URL_HUB+""+"save_activation_log";

  static  const String verify_BankAccount_Number = base_URL_HUB+""+"api/bank_verification";
  static  const String TankhaPay_Update_EmployeeProfile = base_URL_HUB+""+"api/TpCandidateAPI/UpdateProfile";



  static  const String getTankhaPay_FAQ = base_URL_HUB+""+"api/get_faq_category";


/*----------------------5-12-2022 start(use for the Beneficiary) means Employee--------------------------------*/


  /*----------------14-2-2023 start-----------------*/
  static  const String setTankhaPay_4DigitPinNumber = base_URL_HUB+""+"api/logincontroller/SaveTpPin";
  static  const String verifyTankhaPay_4DigitPinNumber = base_URL_HUB+""+"api/logincontroller/VerifyTpPin";


/*----------------14-2-2023 end-----------------*/

}

