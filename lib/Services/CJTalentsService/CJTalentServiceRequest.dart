import 'dart:convert';

import 'package:contractjobs/Controller/Talents/ModelClasses/CJTalentCommonModelClass.dart';
import 'package:contractjobs/Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../Controller/JobSeekers/ModelClasses/CJCommonResponse.dart';
import '../../Controller/JoiningProfile/JoiningProfileModelClass/EmployeeAadhaarSendOTPModelClass.dart';
import '../../Controller/JoiningProfile/JoiningProfileModelClass/EmployeeBankAccountVerifyModelClass.dart';
import '../../Controller/JoiningProfile/JoiningProfileModelClass/EmployeeJoiningProfileUpdateModelClass.dart';
import '../../Controller/JoiningProfile/JoiningProfileModelClass/EmployeeKYCStatusModelClass.dart';
import '../../Controller/JoiningProfile/JoiningProfileModelClass/EmployeePANVerifyModelClass.dart';
import '../../Controller/JoiningProfile/JoiningProfileModelClass/EmployeeUANVerifyModelClass.dart';
import '../../Controller/Talents/Controller/CJHubInsuranceModule/insuranceStatus_ModelResponse.dart';
import '../../Controller/Talents/ModelClasses/CJHubModelClasses/SalarySlip_ModelResponse.dart';
import '../../Controller/Talents/ModelClasses/CJHubModelClasses/SalaryStatus_ModelResponse.dart';
import '../../Controller/Talents/ModelClasses/CJHubModelClasses/SendOTP_ModelResponse.dart';
import '../../Controller/Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../Controller/Talents/ModelClasses/CJHubModelClasses/Verify_Mobile_ModelResponse.dart';
import '../../Controller/Talents/ModelClasses/CJHubSupportModelClass/HrConnect_SaveMsg_ModelResponse.dart';
import '../../Controller/TankhaPayModule/TankhaPayModelClasses/TankhaPayAttendanceTabsModelClass/TankhaPayAttendanceModelClass.dart';
import '../../Controller/TankhaPayModule/TankhaPayModelClasses/TankhaPayAttendanceTabsModelClass/TankhaPayEmloyeeCheckInModelClass.dart';
import '../../Controller/TankhaPayModule/TankhaPayModelClasses/TankhaPayAttendanceTabsModelClass/TankhaPayGetTodayAttendance.dart';
import '../../Controller/TankhaPayModule/TankhaPayModelClasses/TankhaPayAttendanceTabsModelClass/TankhaPaySaveAttendanceModelClass.dart';
import '../../Controller/TankhaPayModule/TankhaPayModelClasses/TankhaPayFAQModelClass/TankhaPayFAQModelClass.dart';
import '../../Controller/TankhaPayModule/TankhaPayModelClasses/TankhaPayProfileModelClass/TankhaPayUpdateAddressModelClass.dart';
import '../../Controller/TankhaPayModule/TankhaPayModelClasses/TankhaPaySupportModelClass/TankhaPayGetPendingTrailModelClass.dart';
import '../../Controller/TankhaPayModule/TankhaPayModelClasses/TankhaPaySupportModelClass/TankhaPaySupportCreateQueryModelClass.dart';
import '../../Controller/TankhaPayModule/TankhaPayModelClasses/TankhaPaySupportModelClass/TankhaPaySupportGetPendingQueryModelClass.dart';
import '../../Controller/TankhaPayModule/TankhaPayModelClasses/TankhaPaySupportModelClass/TankhaPaySupportSubjectList.dart';
import '../AESAlgo/encrypt.dart';
import '../CJJobSeekerService/CJJobSeekerServiceURL.dart';
import 'package:http/http.dart'as http;

import 'CJTalentServiceKey.dart';
import 'CJTalentServiceKey.dart';

class CJTalentResponseBlock
{
  final void Function<T>(T successBlock) talentSuccessBlock;
  final void Function<T>(T failureblock) talentFailureBlock;
  final void Function<T>(T failureblock) talentHandleExceptionBlock;

  CJTalentResponseBlock({required this.talentSuccessBlock,required this.talentFailureBlock,required this.talentHandleExceptionBlock});

}
class CJTalentServiceRequest
{

  //max time 60 seconds
  int apiRequestTime=60;
  String showServerErrorMessage="Oops, something went wrong. Please try again later.";
  String showInterconnectionMessage="No Internet Connection Available";

  //String matchNetworkConnectionMessage="XMLHttpRequest error."; //use for web
  String matchNetworkConnectionMessage="Failed host lookup:"; //use for mobile

  postDataServiceRequest(Map bodyMap,String serviceType,{required CJTalentResponseBlock cjTalentResponseBlock})
  async {


    try {
      final response = await http.post(
        Uri.parse(serviceType),
        headers: <String, String>{
          'Content-Type': kJS_ContentType,
        },
        body:bodyMap,
      ).timeout(
        Duration(seconds: apiRequestTime),
        onTimeout: ()
        {
          // Time has run out, do what you wanted to do.
          //return http.Response('Error', 408); // Request Timeout response status code
//

          /* CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: "Oops, something went wrong. Please try again later.");
          cjTalentResponseBlock.talentHandleExceptionBlock(commonResponse);
*/
          print("show the server request error");
          return http.Response('Error', 408);

        },
      );
      print(response.statusCode);
      print("show1 the first api response ${response.body}");
      if (response.statusCode == 200)
      {

        print("show the response ${jsonDecode(response.body)}");

        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));

        var decryptedData="";
        if(commonResponse.commonData=="" || commonResponse.commonData==null || commonResponse.statusCode==false)
        {
          if(commonResponse.statusCode==true)
          {
            cjTalentResponseBlock.talentSuccessBlock(commonResponse);
          }
          else
          {
            cjTalentResponseBlock.talentFailureBlock(commonResponse);
          }

          return;
        }

        decryptedData=getDecryptedData(commonResponse.commonData.toString());
        print("show the model screenDetails $decryptedData");

        var jsonDecryptedData=jsonDecode(decryptedData);

        var modelClass;
        if(serviceType==WebApi.get_Emp_Insurance_Status)
        {
          modelClass=InsuranceStatus_ModelResponse.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.get_Salary_Status)
        {
          modelClass=SalaryStatus_ModelResponse.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.get_Salary_Slip)
        {
          modelClass=SalarySlip_ModelResponse.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.tankhaPayVerifyMobile_api)
        {
          modelClass=Verify_Mobile_ModelResponse.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.tankhaPayVerifyOTP_api || serviceType==WebApi.verifyTankhaPay_4DigitPinNumber)
        {
          modelClass=VerifyOTP_ModelResponse.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.verify_PAN_Number)
        {
          modelClass=EmployeePANVerifyModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.verify_UANNumber_and_UpdateProfileAddress)
        {
          modelClass=EmployeeUANVerifyModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.verify_BankAccount_Number)
        {
          modelClass=EmployeeBankAccountVerifyModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.get_EmployeeKYC_Status)
        {
          modelClass=EmployeeKYCStatusModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.verify_Aadhaar_Number || serviceType==WebApi.verify_Aadhaar_OTP)
        {
          modelClass=EmployerAadhaarSendOTPModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.getTankhaPay_FAQ)
        {
          modelClass=TankhaPayFAQModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        //map
        else if(serviceType==WebApi.TankhaPay_ApiMethod_get_TodayAttendance)
        {
          print("Inside Get Today Map Attendance");
          modelClass = TankhaPayGetTodayAttendance.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType == WebApi.TankhaPay_ApiMethod_Employee_checkIn){
          modelClass = TankhaPayEmloyeeCheckInModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        //attendance
        else if(serviceType==WebApi.TankhaPay_ApiMethod_get_MonthlyAttendance)
        {
          modelClass=TankhaPayAttendanceModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.TankhaPay_ApiMethod_save_MonthlyAttendance){
          print("Inside Save Attendance");
          modelClass = TankhaPaySaveAttendanceModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        /*----------support module start 21-12-2022--------------*/

        else if(serviceType==WebApi.get_HRConnect_Subject_Tickets){
          modelClass = TankhaPaySupportSubjectList.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.get_HRConnect_PendingQuery){
          modelClass = TankhaPaySupportGetPendingQueryModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.save_HRConnect_CreateQuery){
          modelClass = TankhaPaySupportCreateQueryModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.get_HRConnect_PendingThread){
          modelClass = TankhaPayGetPendingTrailModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.get_HRConnect_SavePendingQuery_Trail){
          modelClass = HrConnect_SaveMsg_ModelResponse.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }

        /*----------update profile picture module end 22-12-2022--------------*/
        else if(serviceType==WebApi.tankhaPayUpdateProfilePicture_api){
          modelClass = TankhaPayUpdateAddressModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.tankhaPayUpdateProfilePicture_api){
          modelClass = TankhaPayUpdateAddressModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        else if(serviceType==WebApi.TankhaPay_Update_EmployeeProfile){

          //modelClass = EmployeeJoiningProfileUpdateModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
          modelClass=commonResponse;
        }
        else if(serviceType==WebApi.setTankhaPay_4DigitPinNumber){
          modelClass=commonResponse;
        }




        if(commonResponse.statusCode==true)
        {
          print("show the help and support success");
          cjTalentResponseBlock.talentSuccessBlock(modelClass);
        }else
        {
          print("show the help and support failure");

          cjTalentResponseBlock.talentFailureBlock(commonResponse);
        }

        // EasyLoading.dismiss();

      }
      else {

        // EasyLoading.dismiss();
        var modelClass;

        /*  if(serviceType==WebApi.verify_PAN_Number)
        {
          CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
          var decryptedData=getDecryptedData(commonResponse.commonData.toString());
          var jsonDecryptedData=jsonDecode(decryptedData);
          modelClass=EmployeePANVerifyModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));

          if(commonResponse.statusCode==true)
          {
            cjTalentResponseBlock.talentSuccessBlock(modelClass);
          }else
          {
            cjTalentResponseBlock.talentFailureBlock(commonResponse);
          }

        }
        else if(serviceType==WebApi.verify_Aadhaar_Number || serviceType==WebApi.verify_Aadhaar_OTP)
        {
          CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
          var decryptedData=getDecryptedData(commonResponse.commonData.toString());
          var jsonDecryptedData=jsonDecode(decryptedData);
          modelClass=EmployerAadhaarSendOTPModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));

          if(commonResponse.statusCode==true)
          {
            cjTalentResponseBlock.talentSuccessBlock(modelClass);
          }else
          {
            cjTalentResponseBlock.talentFailureBlock(commonResponse);
          }

        }
        else
          {
            //talentHandleExceptionBlock
            CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
            cjTalentResponseBlock.talentHandleExceptionBlock(commonResponse);

          }*/

        print("aadhaar api 1");
        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
        cjTalentResponseBlock.talentHandleExceptionBlock(commonResponse);
        print("aadhaar api 11");

        //throw Exception('Failed to create get product.');
      }
    }catch(e){

      print("aadhaar api 2");

      if(e.toString().contains(matchNetworkConnectionMessage))
      {

        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showInterconnectionMessage);
        cjTalentResponseBlock.talentHandleExceptionBlock(commonResponse);

      }
      else
      {
        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showServerErrorMessage);
        cjTalentResponseBlock.talentHandleExceptionBlock(commonResponse);

      }
      print("aadhaar api 22");

      print(e);
    }
  }

  postDataServiceRequestFor_UANandAddress(Map bodyMap,String serviceType,actionType,{required CJTalentResponseBlock cjTalentResponseBlock})
  async {
    try {
      final response = await http.post(
        Uri.parse(serviceType),
        headers: <String, String>{
          'Content-Type': kJS_ContentType,
        },
        body:bodyMap,
      ).timeout(
        Duration(seconds: apiRequestTime),
        onTimeout: ()
        {
          // Time has run out, do what you wanted to do.
          /*  CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showServerErrorMessage);
          cjTalentResponseBlock.talentHandleExceptionBlock(commonResponse);*/
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );
      print(response.statusCode);
      print("show1 the first api response ${response.body}");
      if (response.statusCode == 200)
      {

        print("show the response ${jsonDecode(response.body)}");

        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));

        var decryptedData="";
        if(commonResponse.commonData=="" || commonResponse.commonData==null || commonResponse.statusCode==false)
        {
          cjTalentResponseBlock.talentFailureBlock(commonResponse);
          return;
        }
        decryptedData=getDecryptedData(commonResponse.commonData.toString());

        print("show the model screenDetails $decryptedData");

        var jsonDecryptedData=jsonDecode(decryptedData);

        var modelClass;


        if(actionType==kTankhaPay_KYCUAN_ActionValue)
        {
          modelClass=EmployeeUANVerifyModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }
        if(actionType==kTankhaPay_ProfileAddress_ActionValue)
        {
          modelClass=TankhaPayUpdateAddressModelClass.fromJson(jsonDecode(json.encode(jsonDecryptedData)));
        }

        if(commonResponse.statusCode==true)
        {
          cjTalentResponseBlock.talentSuccessBlock(commonResponse);
        }else
        {
          cjTalentResponseBlock.talentFailureBlock(commonResponse);
        }

        // EasyLoading.dismiss();

      }
      else {

        // EasyLoading.dismiss();

        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(response.body));
        cjTalentResponseBlock.talentHandleExceptionBlock(commonResponse);

        // throw Exception('Failed to create get product.');
      }
    }catch(e){
      print(e);

      if(e.toString().contains(matchNetworkConnectionMessage))
      {

        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showInterconnectionMessage);
        cjTalentResponseBlock.talentHandleExceptionBlock(commonResponse);

      }
      else
      {
        CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass(message: showServerErrorMessage);
        cjTalentResponseBlock.talentHandleExceptionBlock(commonResponse);

      }

    }
  }
  getDataServiceRequest(String serviceType,{required CJTalentResponseBlock cjTalentResponseBlock})
  {

  }


}

/*---------------18-11-2022 start-------------------*/

getTheDecryptedDataFromApiResponse(var serverApiResponse)
{
  CJTalentCommonModelClass commonResponse=CJTalentCommonModelClass.fromJson(jsonDecode(serverApiResponse));
  var decryptedData=getDecryptedData(commonResponse.commonData.toString());
  print("show the model screenDetails $decryptedData");
  return decryptedData;
}

/*---------------18-11-2022 end-------------------*/