
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../../Controller/Talents/ModelClasses/CJHubModelClasses/Verify_Mobile_ModelResponse.dart';
import '../../Services/AESAlgo/encrypt.dart';


class SharedPreference {


  /*--------EMPLOYEE KYC STATUS START---------*/
  static setEmpoyeePAN(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empoyeePAN', value);
  }

  static getEmpoyeePAN() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('empoyeePAN');
  }

  static setEmpoyeeUAN(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empoyeeUAN', value);
  }


  static getEmpoyeeUAN() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('empoyeeUAN');
  }

  static setEmpoyeeBankAccountStatus(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bankAccountStatus', value);
  }

  static getEmpoyeeBankAccountStatus() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('bankAccountStatus');
  }



  /*--------EMPLOYEE KYC STATUS END---------*/

  static setEmpoyerPAN(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empoyerPAN', value);
  }

  static getEmpoyerPAN() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('empoyerPAN');
  }

  static setEmpId(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empid', value);
  }

  static getEmpId() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getId = prefs.getString('empid');
    return await getId;
  }

  static setQREmpId(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('qrempid', value);
  }

  static getQREmpId() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getId = prefs.getString('qrempid');
    return await getId;
  }

  static void setEmpGender(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empGender', value);
  }

  static getEmpGender() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('empGender');
  }

  static setEmpJobType(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empJobType', value);
  }

  static getEmpJobType() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('empJobType');
  }

  static setEmpAddress(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empAddress', value);
  }

  static getEmpAddress() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('empAddress');
  }

  static setEmp_AadhaarCard_PermanentAddress(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empAadhaarCardPermanentAddress', value);
  }

  static getEmp_AadhaarCard_PermanentAddress() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('empAadhaarCardPermanentAddress');
  }

  static setEmp_AadhaarCard_FatherName(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empAadhaarCardFatherName', value);
  }

  static getEmp_AadhaarCard_FatherName() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('empAadhaarCardFatherName');
  }



  static setEmpFatherName(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empFatherName', value);
  }

  static getEmpFatherName() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('empFatherName');
  }

  static setEmp_ProfileImage(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('EmpProfileImage', value);
  }

  static getEmp_ProfileImage() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('EmpProfileImage');
  }

  static setEmpDateOfBirth(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('dateofbirth', value);
  }

  static getEmpDateOfBirth() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('dateofbirth');
  }

  static setEmpMobileNo(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empMobileNo', value);
  }

  static getEmpMobileNo() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('empMobileNo');
  }

  static setEmpEmailId(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empEmailId', value);
  }

  static getEmpEmailId() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('empEmailId');
  }

  static setEmpCode(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empCode', value);
  }

  static getEmpCode() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('empCode');
  }

  /*------------11-10-2022 start--------------*/

  static  set_CJCode(String cjCode) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cjCode', cjCode);
  }
  static  get_CJCode() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('cjCode');
  }

  /*------------11-10-2022 end--------------*/


  /*------------11-1-2022 start------------*/
  static setJSId(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jsId', value);
  }

  static getJSId() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('jsId');
  }
  /*------------11-1-2022 end------------*/


  static setEmpPanCardNumber(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('panCardNumber', value);
  }

  static getEmpPanCardNumber() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('panCardNumber');
  }

  static setEmpName(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empName', value);
  }

  static  getEmpName() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('empName');
  }

  static setLoginStatus(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('loginStatus', value);
  }

  static  getLoginStatus() async
  {
    String? loginStatus="";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginStatus=prefs.getString('loginStatus');

    if (loginStatus=="" || loginStatus==null)
    {
      loginStatus="false";
    }
    else
    {
    }
    return loginStatus;
  }

  /*------------4-1-2022 start--------------*/
  static  setEC_STATUS(String ecStatus) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ecstatus', ecStatus);
  }
  static  getEC_STATUS() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('ecstatus');
  }

  static  setRecord_Source(String recordSource) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('recordSource', recordSource);
  }
  static  getRecord_Source() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('recordSource');
  }
  /*------------4-1-2022 end--------------*/

  /*------------9-5-2022 start--------------*/

  static  setRider_GigECCode(String recordSource) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ridergigeccode', recordSource);
  }
  static  getRider_GigECCode() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('ridergigeccode');
  }







  /*---------29-7-2021 salary slip start-------------*/

  static  setSalaryMonthNumber(String salary_month) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('salary_month_number', salary_month);
  }
  static  getSalaryMonthNumber() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('salary_month_number');
  }

  static  setSalaryYear(String salary_year) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('salary_year', salary_year);
  }
  static  getSalaryYear() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('salary_year');
  }

  static  setSalaryMonthName(String monthNameByNumber) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('salarymonthName', monthNameByNumber);
  }
  static  getSalaryMonthName() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('salarymonthName');
  }

  /*---------29-7-2021 salary slip start-------------*/

/*---------11-8-2021 investment declaration start-------------*/
  static  setIncomeTax_HeadsDescription(String headsDescription) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('HeadsDescription', headsDescription);
  }
  static  getIncomeTax_HeadsDescription() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('HeadsDescription');
  }

  static  setIncomeTax_HeadsFinancialYear(String headsFinancialYear) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('HeadsFinancialYear', headsFinancialYear);
  }
  static  getIncomeTax_HeadsFinancialYear() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('HeadsFinancialYear');
  }

  static  setIncomeTax_HeadsId(String headsId) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('HeadsId', headsId);
  }
  static  getIncomeTax_HeadsId() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('HeadsId');
  }
/*---------11-8-2021 investment declaration end-------------*/


  static  setEmp_PinNumber(String empPinNmuber) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empPinNmuber', empPinNmuber);
  }
  static  getEmp_PinNumber() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('empPinNmuber');
  }

  static  setEmp_PinNumberScreen(String screenType) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('pinNumberScreen', screenType);
  }
  static  getEmp_PinNumberScreen() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('pinNumberScreen');
  }

/*---------------------insurance status---------------------------------*/
  static  setInsuranceStatus(String insuranceStatus) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('insuranceStatus', insuranceStatus);
  }
  static  getInsuranceStatus() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('insuranceStatus');
  }
  static  setInsuranceMessage(String message) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('insuranceMessage', message);
  }
  static  getInsuranceMessage() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('insuranceMessage');
  }
  ///28-1-2022 start
  static  setEmpJobStatus(String empJobStatus) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empJobStatus', empJobStatus);
  }
  static  getEmpJobStatus() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('empJobStatus');
  }
  ///28-1-2022 end

/*---------------------support module ---------------------------------*/
  static  setSupportQueryId(String queryId) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('queryId', queryId);
  }
  static  getSupportQueryId() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('queryId');
  }


  static Future<String?> networkImageToBase64(String imageUrl) async
  {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }


  /*------------TEC MODULE 24-3-2022 start--------------*/
  static  setKYC_STATUSCode(String ecStatus) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('kycStatusCode', ecStatus);
  }
  static  getKYC_STATUSCode() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('kycStatusCode');
  }

  static  setPANCard_STATUS(String ecStatus) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('panCardStatus', ecStatus);
  }
  static  getPANCard_STATUS() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('panCardStatus');
  }

  static  setAadhaarCard_STATUS(String ecStatus) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('aadhaarCardStatus', ecStatus);
  }
  static  getAadhaarCard_STATUS() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('aadhaarCardStatus');
  }
/*------------TEC MODULE 24-3-2022 end--------------*/


  /*------------Rider module 12-4-2022 start--------------*/
  static  setRider_PANCardStatus(String status) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('riderpancardstatus', status);
  }
  static  getRider_PANCardStatus() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('riderpancardstatus');
  }

  static  setRider_AadhaarCardStatus(String status) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('riderAadhaarCardStatus', status);
  }
  static  getRider_AadhaarCardStatus() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('riderAadhaarCardStatus');
  }
  static  setRider_DriverLicenseUploadStatus(String status) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('driverLicenseUploadStatus', status);
  }
  static  getRider_DriverLicenseUploadStatus() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('driverLicenseUploadStatus');
  }

  static  setRider_AadhaarCardNumber(String status) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('riderAadhaarCardNumber', status);
  }
  static  getRider_AadhaarCardNumber() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('riderAadhaarCardNumber');
  }


  static  setRider_BankName(String status) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('riderbankname', status);
  }
  static  getRider_BankName() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('riderbankname');
  }
  static  setRider_BankAccountNo(String status) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('riderbankaccountno', status);
  }
  static  getRider_BankAccountNo() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('riderbankaccountno');
  }
  static  setRider_BankIFSCCode(String status) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('riderBankIFSCCode', status);
  }
  static  getRider_BankIFSCCode() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('riderBankIFSCCode');
  }

  /*-------------Nominee details start 15-4-2022---------------*/
  static  setRider_NomineeAadhaarCardStatus(String status) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('riderNomineeAadhaarCardStatus', status);
  }
  static  getRider_NomineeAadhaarCardStatus() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('riderNomineeAadhaarCardStatus');
  }





  static setRider_NomineeName(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('riderNomineeName', value);
  }

  static  getRider_NomineeName() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('riderNomineeName');
  }

  static setRider_NomineeMobileNo(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('riderNomineeMobileNo', value);
  }

  static  getRider_NomineeMobileNo() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('riderNomineeMobileNo');
  }




  static setRider_NomineeDateOfBirth(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('riderNomineeDateOfBirth', value);
  }

  static  getRider_NomineeDateOfBirth() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('riderNomineeDateOfBirth');
  }


  static  setRider_NomineeIdProofUploadStatus(String status) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('NomineeIdProofUploadStatus', status);
  }
  static  getRider_NomineeIdProofUploadStatus() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('NomineeIdProofUploadStatus');
  }

/*-------------------22-4-2022 start(check by server)-----------------------*/

  static setRider_NomineeDetails_SaveStatus(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('riderNomineeDetailsSaveStatus', value);
  }

  static  getRider_NomineeDetails_SaveStatus() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('riderNomineeDetailsSaveStatus');
  }
/*-------------------22-4-2022 start(check by server)-----------------------*/

/*-------------Nominee details end 15-4-2022---------------*/


  /*-----APP LOG ACTIVATION STATUS SAVE BY API  HERE 18-4-2022 START use for(RTEC and REC)---------------*/
  static set_AppLogActivationSaveInCRMStatus(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('AppLogActivationSaveInCRMStatus', value);
  }

  static  get_AppLogActivationSaveInCRMStatus() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('AppLogActivationSaveInCRMStatus');
  }
/*-----APP LOG ACTIVATION STATUS SAVE BY API  HERE 18-4-2022 END use for(RTEC and REC)---------------*/




/*-------------27-01-2023 start----------------*/

  static  setTankhaPay_NotificationToken(String notificationToken) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tankhaPayNotificationToken', notificationToken);
  }
  static  getTankhaPay_NotificationToken() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var  notificationToken=prefs.get('tankhaPayNotificationToken');
    if(notificationToken==null)
    {
      notificationToken="";
    }
    return notificationToken;
  }

  static  setTankhaPay_UserId(String status) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tankhaPayUserId', status);
  }
  static  getTankhaPay_UserId() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var  getUserId=prefs.get('tankhaPayUserId');
    if(getUserId==null)
      {
        getUserId="";
      }
    return getUserId;
  }

  static setTankhaPay_UserType(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tankhaPayUserType', value);
  }

  static  getTankhaPay_UserType() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var  getUserType=prefs.get('tankhaPayUserType');
    if(getUserType==null)
    {
      getUserType="";
    }
    return getUserType;
  }

/*-------------27-01-2023 end----------------*/


  /*---------------14-2-2023 start---------------*/
  static setTankhaPay_PinNumber(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tankhaPayPinNumber', value);
  }

  static  getTankhaPay_PinNumber() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var  getPinType=prefs.get('tankhaPayPinNumber');
    if(getPinType==null)
    {
      getPinType="";
    }
    return getPinType;
  }
  /*static setTankhaPay_MobileNO(String value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tankhaPayMobileNo', value);
  }

  static  getTankhaPay_MobileNO() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var  getMobileNo=prefs.get('tankhaPayMobileNo');
    if(getMobileNo==null)
    {
      getMobileNo="";
    }
    return getMobileNo;
  }*/
/*---------------14-2-2023 end---------------*/


}

/*
saveTheLoginDataIntoTheLocalDB(Verify_Mobile_ModelResponse _verify_mobile_modelResponse)
{
  SharedPreference.setEmpId(_verify_mobile_modelResponse.data?.userId);
  SharedPreference.setEmpGender(_verify_mobile_modelResponse.data?.empGender);
  SharedPreference.setEmpJobType(_verify_mobile_modelResponse.data?.jobType);
  SharedPreference.setEmpAddress(_verify_mobile_modelResponse.data?.empResidentialAddress);
  SharedPreference.setEmpFatherName(_verify_mobile_modelResponse.data?.empFatherName);
  SharedPreference.setEmpDateOfBirth(_verify_mobile_modelResponse.data?.empDob);
  SharedPreference.setEmp_ProfileImage(_verify_mobile_modelResponse.data?.empPhotoPath);

  SharedPreference.setEmpMobileNo(_verify_mobile_modelResponse.data?.empMobile);
  SharedPreference.setEmpEmailId(_verify_mobile_modelResponse.data?.empEmail);
  SharedPreference.setEmpCode(_verify_mobile_modelResponse.data?.empCode);

  SharedPreference.setEmpPanCardNumber(_verify_mobile_modelResponse.data?.empPancardNumber);
  SharedPreference.setEmpName(_verify_mobile_modelResponse.data?.empName);

  //11-1-20222 start::'CRM','PartialBatch','HUBCRM'
  SharedPreference.setEC_STATUS(_verify_mobile_modelResponse.data?.ecStatus);

  SharedPreference.setRecord_Source(_verify_mobile_modelResponse.data?.recordSource);
  SharedPreference.setJSId(_verify_mobile_modelResponse.data?.jsId);
  SharedPreference.setIncomeTax_HeadsFinancialYear(_verify_mobile_modelResponse.data?.financialYear);
  //11-1-20222 end

  //24-3-20222 atRT
  SharedPreference.setKYC_STATUSCode(_verify_mobile_modelResponse.data?.kycStatusCode);
  SharedPreference.setPANCard_STATUS(_verify_mobile_modelResponse.data?.panCardStatus);
  SharedPreference.setAadhaarCard_STATUS(_verify_mobile_modelResponse.data?.aadhaarCardStatus);

  //24-3-20222 END

  //9-5-20222 start
  SharedPreference.setRider_GigECCode(_verify_mobile_modelResponse.data?.gigEc);
  //9-5-20222 end

  //11-10-20222 start
  SharedPreference.set_CJCode(_verify_mobile_modelResponse.data?.cjCode);
  SharedPreference.setQREmpId(_verify_mobile_modelResponse.data?.empId);

  //11-10-20222 end

  //print("print the data into the local database ${_verify_mobile_modelResponse.data?.jobType}");
  */
/*--------22-4-2022 start(check show summary details or not(nomineestatus=1 means show summary and nomineestatus=0 means show document upload))-------*//*

  SharedPreference.setRider_NomineeDetails_SaveStatus(_verify_mobile_modelResponse.data?.nomineestatus);
  if(_verify_mobile_modelResponse.data?.nomineestatus=="1")
  {
    //means show the summary detaails
  }else
  {
    //show the document upload view
    //clearThe_RTEC_RecordsFromLocalDatabase();
  }
  */
/*--------22-4-2022 end-------*//*




  String ecStatus=_verify_mobile_modelResponse.data?.ecStatus;
  //print('show emp status $ecStatus');

  String pinstatus = _verify_mobile_modelResponse.data?.empPinStatus;

  if (_verify_mobile_modelResponse.data?.empPinStatus==null)
  {
    pinstatus="N";
  }else
  {
    pinstatus=_verify_mobile_modelResponse.data?.empPinStatus;
  }

  if(pinstatus=="Y")
  {
    //pin status Y means(YES)

    //pinStatus=pinstatus;

    SharedPreference.setEmp_PinNumber(_verify_mobile_modelResponse.data?.empPin);

    String showEmpPinStatus=getDecryptedData(_verify_mobile_modelResponse.data?.empPin);
    //print('show showEmpPinStatus status $showEmpPinStatus');


    SharedPreference.getLoginStatus().then((loginStatus) =>  {

      //print('show login status $loginStatus'),
      //loadData()

      if(loginStatus=="true")
        {
         */
/* Navigator.push(context, MaterialPageRoute(builder: (_)=>

              Responsive(
                mobile: Enter4DigitPin(),
                tablet: Center(
                  child: Container(
                    width: flutterWeb_tabletWidth,
                    child: Enter4DigitPin(),
                  ),
                ),
                desktop: Center(
                  child: Container(
                    width: flutterWeb_tabletWidth,
                    child: Enter4DigitPin(),
                  ),
                ),
              )
            // Enter4DigitPin()

          ))*//*


        }
      else
        {
        */
/*  pinStatus=pinstatus,

          setState(()
          {
            //_visible=!_visible;
            // Navigator.of(context).pop();

            *//*
*/
/*-------6-1-20222 start(start timer for android device)-------*//*
*/
/*


            isAndroid = Theme.of(context).platform == TargetPlatform.android;


            if(isAndroid || kIsWeb)
            {
              //use for android
              *//*
*/
/*----25-2-2022-timer start-----*//*
*/
/*
              showTimer_Visibility=true;
              *//*
*/
/*---25-2-2022-timer end-----*//*
*/
/*
              //print(('show start timer new android'));
              startTimer();

            }
            else
            {
              //use for iOS
              //print(('show start timer new ios'));

            }
            *//*
*/
/*-------6-1-20222 end-------*//*
*/
/*

            sendOTP_WebApi();

          }),*//*

          // alertDialogForVerifyMobile(context,"An OTP has been sent to your mobile number for verification.")
        }

    });

  }
  else
  {
    //pin status N means(NO)
   */
/* pinStatus=pinstatus;

    setState(()
    {
      //_visible=!_visible;
      // Navigator.of(context).pop();

      *//*
*/
/*-------6-1-20222 start(start timer for android device)-------*//*
*/
/*


      isAndroid = Theme.of(context).platform == TargetPlatform.android;


      if(isAndroid || kIsWeb)
      {
        //use for android
        *//*
*/
/*----25-2-2022-timer start-----*//*
*/
/*
        showTimer_Visibility=true;
        *//*
*/
/*---25-2-2022-timer end-----*//*
*/
/*
        //print(('show start timer new android'));
        startTimer();

      }
      else
      {
        //use for iOS
        //print(('show start timer new ios'));

      }
      *//*
*/
/*-------6-1-20222 end-------*//*
*/
/*

      sendOTP_WebApi();

    });*//*

    // alertDialogForVerifyMobile(context,"An OTP has been sent to your mobile number for verification.");

  }
}
*/


