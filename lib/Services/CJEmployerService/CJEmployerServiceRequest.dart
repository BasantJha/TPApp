
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerAddBalanceModelClass/EmployerAmountFromInvoiceModel.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerAddBalanceModelClass/EmployerInvoiceModel.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerAddBalanceModelClass/EmployerOrderIdForInvoiceModel.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerAddEmployeeModelClass/CalculatorModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerAddEmployeeModelClass/EmployerDetailsModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerAddEmployeeModelClass/EmployerFlexibleCalculatorModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerAddEmployeeModelClass/LeaveTemplateModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerAttendanceModelClass/Employer_HomeNotificationModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerAttendanceModelClass/Employer_NewWorkPlaceAttendaceModelClasses/EmployerNewWorkPlaceAttendanceModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerAttendanceModelClass/Employer_NewWorkPlaceAttendanceCalendarModelClasses/Employer_NewWorkPlaceAttendanceCalendar_Get_MonthlyAttendance_ModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerAttendanceModelClass/Employer_NewWorkPlaceAttendanceCalendarModelClasses/Employer_NewWorkPlaceAttendanceCalender_SaveMonthlyAttendance_ModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerAttendanceModelClass/Employer_NewWorkPlaceLeaveSettingAttendanceModelClass/Employer_NewWorkPlaceLeaveSettingAttendanceModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerAttendanceModelClass/Employer_New_WorkPlaceAttendanceDetailsModelClass/Employer_New_WorkPlaceAttendanceDetailsModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerAttendanceModelClass/Employer_newWorkPlaceCreateLeaveTemplateModelClass/Employer_newWorkPlaceCreateLeaveTemplateModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerPaymentModelClass/EmployerAvailable_Balance_Model.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerPaymentModelClass/EmployerLatestTransactionModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerPaymentModelClass/EmployerPaymentPlanModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerPaymentModelClass/EmployerTransactionModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerPaymentModelClass/PaymentInvoiceModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerPayoutModelClass/EmployerPayOutDetailsModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerPayoutModelClass/EmployerPayOutModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerProfileModelClasses/EmployerProfileModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerSignUpModelClasses/EmployerSignUpModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/EmployerUPITransactionModelClass/EmployerUPITransactionModelClass.dart';
import '../../Controller/Employers/Controller/EmployerModelClasses/TankhaPayNotificationListModelClass/TankhaPayNotificationListModelClass.dart';
import '../../Controller/Employers/Controller/Employer_KYCModelClass/Employer_AadhaarSendOTPModelClass.dart';
import '../../Controller/Employers/Controller/Employer_KYCModelClass/Employer_AggreementModelClass.dart';
import '../../Controller/Employers/Controller/Employer_KYCModelClass/Employer_CityModelClass.dart';
import '../../Controller/Employers/Controller/Employer_KYCModelClass/Employer_GSTSendOTPModelClass.dart';
import '../../Controller/Employers/Controller/Employer_KYCModelClass/Employer_KYCStatusModelClass.dart';
import '../../Controller/Employers/Controller/Employer_KYCModelClass/Employer_PanVerifyModelClass.dart';
import '../../Controller/Employers/Controller/Employer_KYCModelClass/Employer_StateModelClass.dart';
import '../../Controller/Employers/Controller/Employer_NewDashboard/Employer_PayoutSetting/EmployerGetLeaveTemplateModelClass.dart';
import '../../Controller/Employers/Controller/Employer_NewDashboard/Employer_PayoutSetting/EmployerpayOutSettingModelClass.dart';
import '../../Controller/Employers/Controller/Employer_NewDashboard/Employer_PayoutSetting/SaveEmployerLeaveTemplateModelClass.dart';
import '../../Controller/Employers/Controller/Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_AreaOfWorkModelClass.dart';
import '../../Controller/Employers/Controller/Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_SignUpNewBusinessModelClass.dart';
import '../../Controller/Employers/Controller/Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../../Controller/JoiningProfile/JoiningProfileModelClass/EmployeeAadhaarSendOTPModelClass.dart';
import '../../Controller/JoiningProfile/JoiningProfileModelClass/EmployeeKYCStatusModelClass.dart';
import '../../Controller/Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../Controller/TankhaPayModule/TankhaPayModelClasses/TankhaPayNotificationModelClass/TankhaPayNotificationModelClass.dart';
import '../AESAlgo/encrypt.dart';
import '../CJJobSeekerService/CJJobSeekerServiceURL.dart';
import 'package:http/http.dart'as http;

import '../CJTalentsService/CJHubWebApi/WebApi.dart';
import 'CJEmployerServiceKey.dart';
import 'CJEmployerServiceURL.dart';
import 'CJEmployerServiceURL.dart';

class CJEmployerResponseBlock
{
  final void Function<T>(T commonModelResponse,T modelResponse) employerSuccessBlock;
  final void Function<T>(T commonModelResponse,T modelResponse) employerFailureBlock;
  CJEmployerResponseBlock({required this.employerSuccessBlock,required this.employerFailureBlock});
}

class CJEmployerServiceRequest
{
  int apiRequestTime=60;

  String showServerErrorMessage="Oops, something went wrong. Please try again later.";
  String showInterconnectionMessage="No Internet Connection Available";
  //String matchNetworkConnectionMessage="XMLHttpRequest error."; //use for web
  String matchNetworkConnectionMessage="Failed host lookup:"; //use for mobile


  postDataServiceRequestForAddEmployee(Map bodyMap, String serviceType, String token,{required CJEmployerResponseBlock cjEmployerResponseBlock})
  async {
    try {
      final response = await http.post(
        Uri.parse(serviceType),
        headers: <String, String>{
          'Content-Type': kJG_ContentType,'Authorization': 'Bearer $token',
        },
        body:bodyMap,
      ).timeout(
        Duration(seconds: apiRequestTime),
        onTimeout: ()
        {
//
          print("show the server request error");
          return http.Response('Error', 408);

        },
      );
      print(response.statusCode);
      print("show1 the first api response ${response.body}");
      if (response.statusCode == 200)
      {

        print("show the status 1");

        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
        print("show the status 2");

        var decryptedData;
        if(commonResponse.commonData=="" || commonResponse.commonData==null)
        {

          if(commonResponse.statusCode==false)
          {
            cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
            return;
          }
          else if(commonResponse.statusCode==true)
          {
            cjEmployerResponseBlock.employerSuccessBlock(commonResponse,commonResponse);
            return;
          }
          decryptedData={"code":commonResponse.code,"statusCode":commonResponse.statusCode,"message":commonResponse.message,"commonData":""};

          print("show the status 3");
//
        }
        else
        {
          if(commonResponse.statusCode==false)
          {
            cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
            return;
          }
          decryptedData=getDecryptedData(commonResponse.commonData.toString());
          decryptedData=jsonDecode(decryptedData);
        }
        print("show the model screenDetails1 $decryptedData");
        //var jsonDecryptedData=jsonDecode(decryptedData);

        var jsonDecryptedData=decryptedData;

        var modelClass;

         if(serviceType==JG_ApiMethod_UpdateAddEmployee)
        {
          modelClass = commonResponse;
        }
         if(serviceType == JG_ApiMethod_Employer_EmployerDelete)
         {
           print("show the model class response1 $modelClass");

         }
        if(serviceType == JG_ApiMethod_SaveAddEmployee)
        {
          print("show the model class response1 $modelClass");
          modelClass = commonResponse;

        }




        if(commonResponse.statusCode==true)
        {
          cjEmployerResponseBlock.employerSuccessBlock(commonResponse,modelClass);
        }else
        {
          cjEmployerResponseBlock.employerFailureBlock(commonResponse,modelClass);
        }

        // EasyLoading.dismiss();

      }
      else {

        // EasyLoading.dismiss();

          CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
          cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);

       // throw Exception('server error.');
      }
    }catch(e){
      print(e);
      if(e.toString().contains(matchNetworkConnectionMessage))
      {
        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showInterconnectionMessage);
        cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
      }
      else
      {
        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showServerErrorMessage);
        cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
      }
    }
  }

  postDataServiceRequest(Map bodyMap, String serviceType, {required CJEmployerResponseBlock cjEmployerResponseBlock})
   async {


    print("show the serviceType url $serviceType");

    try {
      final response = await http.post(
        Uri.parse(serviceType),
        headers: <String, String>{
          'Content-Type': kJG_ContentType,
        },
        body:bodyMap,
      ).timeout(
        Duration(seconds: apiRequestTime),
        onTimeout: ()
        {
//
          print("show the server request error");
          return http.Response('Error', 408);

        },
      );
      print(response.statusCode);
      print("show1 the first api response ${response.body}");
      if (response.statusCode == 200)
      {

        print("show the status 1");

        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
        print("show the commonResponse $commonResponse");

        var decryptedData;
        if(commonResponse.commonData=="" || commonResponse.commonData==null)
          {

            if(commonResponse.statusCode==false)
            {
              cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
              return;
            }
            else if(commonResponse.statusCode==true)
              {
                cjEmployerResponseBlock.employerSuccessBlock(commonResponse,commonResponse);
                return;
              }
            decryptedData={"code":commonResponse.code,"statusCode":commonResponse.statusCode,"message":commonResponse.message,"commonData":""};

             print("show the status 3");

          }
        else
          {
            if(commonResponse.statusCode==false)
              {
                cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
                return;
              }
//
            print("show the decryptedData $decryptedData");
            /*-----------9-2-2023 use for the upi transaction starr--------*/
            if(serviceType==JG_ApiMethod_UPITransactionAPI_MePayInetent)
            {
              /*-----------9-2-2023 use for the upi transaction end--------*/

            }else
              {
                decryptedData=getDecryptedData(commonResponse.commonData.toString());
                decryptedData=jsonDecode(decryptedData);
              }
          }

        print("show the decryptedData $decryptedData");

        var jsonDecryptedData=decryptedData;

        var modelClass;

        if(serviceType==JG_ApiMethod_EmployerVerifyMobileNo)
        {
          modelClass=EmployerSignUpModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        if(serviceType==JG_ApiMethod_EmployerVerifyOTP || serviceType==JG_ApiMethod_VerifyEmployer_4DigitPinNumber)
        {
          modelClass=Employer_VerifyMobileNoModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_EmployerCommonRegistration)
        {
          modelClass=EmployerSignUpModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_AadhaarSendOTP)
        {
          modelClass=Employer_AadhaarSendOTPModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_AadhaarVerifyOTP)
        {
          modelClass=EmployerAadhaarSendOTPModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_GSTSendOTP)
        {
          modelClass=Employer_GSTSendOTPModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_GSTVerifyOTP)
        {
          modelClass=Employer_GSTSendOTPModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_GetAllCities)
        {
          print("show city request");
          jsonDecryptedData=createTheMapBody(jsonDecryptedData,"commonCityList");
          modelClass=Employer_CityModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_EmployerKYCStatus)
        {
          modelClass=Employer_KYCStatusModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if (serviceType == JG_ApiMethod_EmployerUpdateProfile)
        {
          //modelClass = EmployerUpdateProfileModel.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if (serviceType == JG_ApiMethod_GETEmployerProfile)
        {
          modelClass = EmployerProfileModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_Employer_ViewInvoice){
          modelClass = PaymentInvoiceModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
       /* else if(serviceType==JG_ApiMethod_MonthlyCtcCalculator){
          modelClass = MonthlyCtcCalculatorModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_InHandSalaryCalculator){
          modelClass = InHandSalaryCalculatorModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }*/
        //use this---29-1-2023 start //JG_ApiMethod_Employer_GetSalaryStructure use for the 2-3-2023
        else if(serviceType==JG_ApiMethod_EmployeeCommonSalaryCalculator || serviceType==JG_ApiMethod_Employer_GetSalaryStructure){

          /*---------25-2-2023 start-----------*/
          //modelClass = InHandSalaryCalculatorModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));

          modelClass = EmployerFlexibleCalculatorModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
          /*---------25-2-2023 end-----------*/

        }
        //use this---29-1-2023 end
        else if(serviceType==JG_ApiMethod_AddEmployee)
        {
          modelClass = commonResponse;
        }
        else if(serviceType==JG_ApiMethod_EmployerLeaveTemplate){
          modelClass = LeaveTemplateModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        /*else if(serviceType==JG_ApiMethod_InvoiceDetails){
          modelClass = EmployerInvoiceModel.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }*/
        else if(serviceType==JG_ApiMethod_StartingPayment){
          modelClass = EmployerAmountFromInvoiceModel.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_GetOrderForInvoice){
          modelClass = EmployerOrderIdForInvoiceModel.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_TransUrl){
          modelClass = EmployerTransactionModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_Employer_AvailableBalance){
          modelClass = EmployerAvailable_Balance_Model.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_Employer_Latest_Transactions){
          modelClass = EmployerLatestTransactionModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_Employer_PaymentsPlan){
          modelClass = EmployerPaymentPlanModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        //Basant
        else if(serviceType==JG_ApiMethod_Employer_NewWorkPlaceAttendance){

          modelClass = EmployerNewWorkPlaceAttendanceModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_Employer_AttendanceCalendar_GetMonthlyAttendance){
          modelClass = Employer_NewWorkPlaceAttendanceCalendar_Get_MonthlyAttendance_ModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_Employer_AttendanceCalendar_SaveMonthlyAttendance){
          modelClass = Employer_NewWorkPlaceAttendanceCalender_SaveMonthlyAttendance_ModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==Employer_NewWorkPlace_Attendance_getAttendanceDetails)
        {
          jsonDecryptedData=createTheMapBody(jsonDecryptedData,"details");
          modelClass = Employer_New_WorkPlaceAttendanceDetailsModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType == Employer_Home_Notification)
        {
          print("show the model class response1 $modelClass");

          modelClass=Employer_HomeNotificationModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
          print("show the model class response2 $modelClass");
        }
        else if(serviceType == JG_ApiMethod_Employer_EmployerExitSuspended)
        {
          print("show the model class response1 $modelClass");

          modelClass=EmployerPaymentPlanModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
          print("show the model class response2 $modelClass");
        }
        else if(serviceType == JG_ApiMethod_Employer_EmployerUpdateSalaryStatus)
        {
          print("show the model class response1 $modelClass");

        }
        else if(serviceType == JG_ApiMethod_Employee_SaveTermsandConditions)
        {
          print("show the model class response1 $modelClass");

        }
        else if(serviceType==JG_ApiMethod_EmployeeNotification)
        {
          print("show the model class response1 $modelClass");

          modelClass=TankhaPayNotificationModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
          print("show the model class response2 $modelClass");
        }

        else if(serviceType==JG_ApiMethod_Employer_ResendLink)
        {
          modelClass=commonResponse;
        }
        /*------------8-2-2023 start----------*/
        else if(serviceType==WebApi.get_EmployeeKYC_Status)
        {
          modelClass=EmployeeKYCStatusModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        /*------------8-2-2023 end----------*/

        else if(serviceType==JG_ApiMethod_UPITransactionAPI_MePayInetent)
        {
          modelClass=commonResponse;
        }
        else if(serviceType==JG_ApiMethod_UPITransactionCallBackAPI)
        {
          modelClass=commonResponse;
        }
        else if(serviceType==JG_ApiMethod_SetEmployer_4DigitPinNumber)
        {
          modelClass=commonResponse;
        }
        else if(serviceType==JG_ApiMethod_Payment_UpdateBankTransfer)
        {
          modelClass=commonResponse;
        }
        /*----use for the employer and employee 21-2-2023 start---*/
        else if(serviceType==JG_ApiMethod_TankhaPayNotificationList_TPAlertApi)
        {
          jsonDecryptedData=createTheMapBody(jsonDecryptedData,"tankhaPayNotificationList");
          modelClass=TankhaPayNotificationListModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==JG_ApiMethod_Employer_Payout_PaySalary)
        {
          modelClass=commonResponse;
        }
        /*------payout setting start 26-2-2023-----------*/
        else if(serviceType==JG_ApiMethod_Employer_PayoutSetting_NOOfLeave)
        {
          //leaveDetails
          jsonDecryptedData=createTheMapBody(jsonDecryptedData,"leaveDetails");
          modelClass=EmployerpayOutSettingModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));

        }
        else if(serviceType==JG_ApiMethod_Employer_PayoutSetting_SaveLeaveTemplate)
        {
          modelClass=SaveEmployerLeaveTemplateModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));

        }
        else if(serviceType==JG_ApiMethod_Employer_PayoutGet_LeaveTemplate)
        {
          modelClass=EmployerGetLeaveTemplateModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));

        }
        /*------payout setting END 26-2-2023-----------*/




        if(commonResponse.statusCode==true)
        {
          cjEmployerResponseBlock.employerSuccessBlock(commonResponse,modelClass);
        }else
        {
          cjEmployerResponseBlock.employerFailureBlock(commonResponse,modelClass);
        }

        // EasyLoading.dismiss();

      } else {

        // EasyLoading.dismiss();

     if(serviceType==JG_ApiMethod_AadhaarSendOTP || serviceType==JG_ApiMethod_AadhaarVerifyOTP || serviceType==JG_ApiMethod_GSTSendOTP || serviceType==JG_ApiMethod_GSTVerifyOTP)
    {
      CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
      /*var decryptedData=getDecryptedData(commonResponse.commonData.toString());
      decryptedData=jsonDecode(decryptedData);
      var jsonDecryptedData=decryptedData;
      var modelClass;
      if(serviceType==JG_ApiMethod_AadhaarSendOTP)
      {
      modelClass=Employer_AadhaarSendOTPModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
      }
      else if(serviceType==JG_ApiMethod_GSTSendOTP)
        {
          modelClass=Employer_GSTSendOTPModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
      else
        {
        }
*/
     /* if(commonResponse.statusCode==true)
      {
        cjEmployerResponseBlock.employerSuccessBlock(commonResponse,modelClass);
      }else
      {
        cjEmployerResponseBlock.employerFailureBlock(commonResponse,modelClass);
      }*/

      cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);

    }

     else if(serviceType==JG_ApiMethod_EmployerVerifyOTP)
     {
       CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
       var decryptedData=getDecryptedData(commonResponse.commonData.toString());
       decryptedData=jsonDecode(decryptedData);
       var jsonDecryptedData=decryptedData;
       var modelClass;
       modelClass=Employer_VerifyMobileNoModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
       cjEmployerResponseBlock.employerFailureBlock(commonResponse,modelClass);

     }
     else
       {
         CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
         cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);

       }

        //throw Exception('server error.');
      }
    }catch(e)
    {
      print("show the employer login $e");

      if(e.toString().contains(matchNetworkConnectionMessage))
        {
          CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showInterconnectionMessage);
          cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
        }
      else
        {
          CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showServerErrorMessage);
          cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
        }

    }
  }

  postDataServiceRequestFor_EmployerSignUp(Map bodyMap, String serviceType, registrationType,{required CJEmployerResponseBlock cjEmployerResponseBlock})
  async {
    try {

      final response = await http.post(
        Uri.parse(serviceType),
        headers: <String, String>{
          'Content-Type': kJG_ContentType,
        },
        body:bodyMap,
      ).timeout(
        Duration(seconds: apiRequestTime),
        onTimeout: ()
        {
          print("show the server request error");
          return http.Response('Error', 408);
        },
      );;

      print(response.statusCode);
      print("show1 the first api response ${response.body}");
      if (response.statusCode == 200)
      {

        print("show the status 1");

        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
        print("show the status 2");

        var decryptedData;
        if(commonResponse.commonData=="" || commonResponse.commonData==null)
        {
          if(commonResponse.statusCode==false)
          {
            cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
            return;
          }
          decryptedData={"code":commonResponse.code,"statusCode":commonResponse.statusCode,"message":commonResponse.message,"commonData":""};
          print("show the status 3");

        }
        else
        {
          if(commonResponse.statusCode==false)
          {
            cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
            return;
          }


          decryptedData=getDecryptedData(commonResponse.commonData.toString());
          print("show the  decryptedData $decryptedData");

          decryptedData=jsonDecode(decryptedData);
        }
        print("show the model screenDetails1 $decryptedData");
        //var jsonDecryptedData=jsonDecode(decryptedData);

        var jsonDecryptedData=decryptedData;

        var modelClass;


        if(registrationType==kEmployer_FLAG_SU)
        {
         // modelClass=EmployerSignUpModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
          modelClass=Employer_VerifyMobileNoModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));

        }
         if(registrationType==kEmployer_FLAG_BI)
        {
          modelClass=Employer_SignUpNewBusinessModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        if(registrationType==kEmployer_FLAG_CD)
        {
          modelClass=Employer_SignUpNewBusinessModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        if(registrationType==kEmployer_FLAG_KYCPAN)
        {
          modelClass=Employer_PanVerifyModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        if(registrationType==kEmployer_FLAG_EA)
        {
         // modelClass=Employer_PanVerifyModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
          modelClass=commonResponse;
        }

        if(registrationType==kEmployer_LeaveSetting_AddNewTemplate)
        {
          print("show the first response 1");
          modelClass=commonResponse;
        }

        if(registrationType==kEmployer_LeaveSetting_GETLeadType)
        {
          print("show the first response 2");

          modelClass=Employer_newWorkPlaceCreateLeaveTemplateModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }

        if(registrationType==kEmployer_Attendance_LeaveSetting_ActionValue)
        {
          print("show the first response 3");

          modelClass=commonResponse;
        }
         if(registrationType=="employerAttendanceListType")
        {
          print("show the first response 4");

          modelClass = Employer_NewWorkPlaceLeaveSettingAttendanceModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }




        if(commonResponse.statusCode==true)
        {
          cjEmployerResponseBlock.employerSuccessBlock(commonResponse,modelClass);
        }else
        {
          cjEmployerResponseBlock.employerFailureBlock(commonResponse,modelClass);
        }

        // EasyLoading.dismiss();

      } else {

        // EasyLoading.dismiss();
        var modelClass;

        if(serviceType==kEmployer_FLAG_KYCPAN)
        {
          CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
          var decryptedData=getDecryptedData(commonResponse.commonData.toString());
          var jsonDecryptedData=jsonDecode(decryptedData);
          modelClass=Employer_PanVerifyModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));

          if(commonResponse.statusCode==true)
          {
            cjEmployerResponseBlock.employerSuccessBlock(commonResponse,modelClass);
          }else
          {
            cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse.message);
          }

        }
        else
          {

            CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
            cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
          }

        //throw Exception('server error.');
      }
    }catch(e)
    {
      print(e);
      if(e.toString().contains(matchNetworkConnectionMessage))
      {
        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showInterconnectionMessage);
        cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
      }
      else
      {
        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showServerErrorMessage);
        cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
      }
    }
  }

  getDataServiceRequest(String serviceType, {required CJEmployerResponseBlock cjEmployerResponseBlock})
  async {
    try {
      final response = await http.post(
        Uri.parse(serviceType),
        headers: <String, String>{
          'Content-Type': kJG_ContentType,
        },
        //body:bodyMap,
      ).timeout(
        Duration(seconds: apiRequestTime),
        onTimeout: ()
        {

          print("show the server request error");
          return http.Response('Error', 408);

        },
      );
      print(response.statusCode);
      print("show1 the first api response ${response.body}");
      if (response.statusCode == 200)
      {
        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
        var decryptedData;
        if(commonResponse.commonData=="" || commonResponse.commonData==null)
        {
          if(commonResponse.statusCode==false)
          {
            cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
            return;
          }
          decryptedData={"code":commonResponse.code,"statusCode":commonResponse.statusCode,"message":commonResponse.message,"commonData":""};
          print("show the status 3");

        }
        else
        {
          if(commonResponse.statusCode==false)
          {
            cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
            return;
          }
          decryptedData=getDecryptedData(commonResponse.commonData.toString());
          decryptedData=jsonDecode(decryptedData);
        }
        print("show the model screenDetails1 $decryptedData");
        //var jsonDecryptedData=jsonDecode(decryptedData);

        var jsonDecryptedData=decryptedData;


        var modelClass;

        if(serviceType==JG_ApiMethod_EmployerAreaOfWork)
        {
          jsonDecryptedData=createTheMapBody(jsonDecryptedData,"commonDataEmp");
          modelClass=Employer_AreaOfWorkModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        if(serviceType==JG_ApiMethod_GetAllStates)
        {
          jsonDecryptedData=createTheMapBody(jsonDecryptedData,"commonStateList");
          modelClass=Employer_StateModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        if(serviceType==JG_ApiMethod_EmployerAggreement)
        {
          jsonDecryptedData=createTheMapBody(jsonDecryptedData,"commonAggreementList");
          modelClass=Employer_AggreementModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        if(serviceType==JG_ApiMethod_Employee_TermsandConditions)
        {
          jsonDecryptedData=createTheMapBody(jsonDecryptedData,"commonAggreementList");
          modelClass=Employer_AggreementModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }





        if(commonResponse.statusCode==true)
        {
          print("success1");
          cjEmployerResponseBlock.employerSuccessBlock(commonResponse,modelClass);

        }else
        {
          print("failure1");

          cjEmployerResponseBlock.employerFailureBlock(commonResponse,modelClass);
        }

        // EasyLoading.dismiss();

      } else {

        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
        cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);


        // EasyLoading.dismiss();
//
       // throw Exception('server error.');
      }
    }catch(e){
      print(e);

      if(e.toString().contains(matchNetworkConnectionMessage))
      {
        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showInterconnectionMessage);
        cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
      }
      else
      {
        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showServerErrorMessage);
        cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
      }
    }
  }

  postDataServiceRequestFor_EmployerDashboard(Map bodyMap, String serviceType,{required CJEmployerResponseBlock cjEmployerResponseBlock})
  async {
    print("API URl $serviceType");
    print("Map Body $bodyMap");
    try {
      final response = await http.post(
        Uri.parse(serviceType),
        headers: <String, String>{
          'Content-Type': kJG_ContentType,
        },
        body:bodyMap,
      ).timeout(
        Duration(seconds: apiRequestTime),
        onTimeout: ()
        {

          print("show the server request error");
          return http.Response('Error', 408);

        },
      );;
      print(response.statusCode);
      print("show1 the first api response ${response.body}");
      if (response.statusCode == 200)
      {

        print("show the status 1");

        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
        print("show the status 2");

        var decryptedData;
        if(commonResponse.commonData=="" || commonResponse.commonData==null)
        {
          if(commonResponse.statusCode==false)
          {
            cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
            return;
          }
          decryptedData={"code":commonResponse.code,"statusCode":commonResponse.statusCode,"message":commonResponse.message,"commonData":""};
          print("show the status 3");


        }
        else
        {
          if(commonResponse.statusCode==false)
          {
            cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
            return;
          }
          decryptedData=getDecryptedData(commonResponse.commonData.toString());
          decryptedData=jsonDecode(decryptedData);
        }
        print("show the model screenDetails1 $decryptedData");

        var jsonDecryptedData=decryptedData;

        var modelClass;


         if(serviceType==JG_ApiMethod_EmployerPayOutList)
        {
          jsonDecryptedData=createTheMapBody(jsonDecryptedData,"commonPayoutList");
          modelClass=EmployerPayOutModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));;;
        }
        else if(serviceType==JG_ApiMethod_EmployerPayOutDetails)
        {
           modelClass=EmployerPayOutDetailsModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else  if(serviceType==JG_ApiMethod_EmployerDetails)
         {
           jsonDecryptedData=createTheMapBody(jsonDecryptedData,"commonAddEmployeeWorkPlaceList");
           modelClass=EmployerDetailsModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));;;
         }



        if(commonResponse.statusCode==true)
        {
          cjEmployerResponseBlock.employerSuccessBlock(commonResponse,modelClass);
        }else
        {
          cjEmployerResponseBlock.employerFailureBlock(commonResponse,modelClass);
        }

        // EasyLoading.dismiss();

      } else {

        var modelClass;
        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showServerErrorMessage);
        cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);

        //throw Exception('server error.');
      }
    }catch(e)
    {
      print(e);
      if(e.toString().contains(matchNetworkConnectionMessage))
      {
        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showInterconnectionMessage);
        cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
      }
      else
      {
        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showServerErrorMessage);
        cjEmployerResponseBlock.employerFailureBlock(commonResponse,commonResponse);
      }
    }
  }

 Map createTheMapBody(var decryptedData,String keyName)
  {
    var mapObj=Map();
    mapObj[keyName]=decryptedData;
    return mapObj;
  }

}

