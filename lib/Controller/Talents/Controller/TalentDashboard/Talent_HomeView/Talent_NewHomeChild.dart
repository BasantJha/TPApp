import 'package:contractjobs/Controller/Talents/Controller/CJHubInsuranceModule/insuranceStatus_ModelResponse.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../Constant/ConstantIcon.dart';
import '../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../TalentNavigation/TalentNavigation.dart';
import '../../CJHubInsuranceModule/Insurance_DummyPage.dart';
import '../../CJHubInsuranceModule/insurance_ViewInsuranceCard.dart';
import '../../CJHubInsuranceModule/insurance_notenrolledpolicy.dart';

class CJHomeModelClass
{
  String name;
  String profile;
  String image;
  String selectedViewType;

  CJHomeModelClass({required this.name, required this.profile, required this.image,required this.selectedViewType});
}

var getNewHomeChildList=[
  CJHomeModelClass(
      name: "Salary Status",
      profile: "Lorem ipsum dolor sit amet,consectetur adipiscing elit.",
      image: Talent_Icon_SalaryStatus,
      selectedViewType:CJTALENT_SalaryStatus ),
  CJHomeModelClass(
      name: "Investment Declaration",
      profile: "Lorem ipsum dolor sit amet,consectetur adipiscing elit.",
      image: Talent_Icon_IncomeTaxReturn,selectedViewType: CJTALENT_InvestmentDeclaration),
  CJHomeModelClass(
      name: "Health insurance",
      profile: "Lorem ipsum dolor sit amet,consectetur adipiscing elit.",
      image: Talent_Icon_HealthIcon,selectedViewType: CJTALENT_HealthInsurance),
];

validateToTheInsuranceData(InsuranceStatus_ModelResponse insuranceStatus_ModelResponse,BuildContext context)
{
  print("show the insurance status");

  if(insuranceStatus_ModelResponse.statusCode==true)
  {
    /*--------------28-1-2022 start-------------*/
    String insuranceStatus=insuranceStatus_ModelResponse!.data!.insuranceStatusCode;

    if(insuranceStatus.length>1)
    {
      /*--1CJHUBActive--(Job Status==Active-means->emp continue,--*/
      /*--Job Status==inActive-means->emp full and final means Logout from the App)--*/
      /*--Job Status==Relieve-means->emp Relieve the office means Health card&Id card not showing from the App)--*/

      var empStatus=insuranceStatus.split("CJHUB");
      var getEmpInsuranceStatusCode=empStatus[0];
      var getEmp_JobStatus=empStatus[1];

      // //print('show getEmpInsuranceStatusCode status $getEmpInsuranceStatusCode');
      // //print('show getEmp_JobStatus  $getEmp_JobStatus');

      SharedPreference.setInsuranceStatus(getEmpInsuranceStatusCode);
      SharedPreference.setInsuranceMessage(insuranceStatus_ModelResponse.message);
      SharedPreference.setEmpJobStatus(getEmp_JobStatus); //28-1-2022 new tasks

      /*---------14-2-2022 start---------*/
      //SharedPreference.setEC_STATUS("");
      //SharedPreference.setEmpCode("");
      //ecStatus="";
      /*---------14-2-2022 end---------*/
      print("show the insurance status $insuranceStatus");

      if(getEmp_JobStatus=="Active")
      {
        checkInsuranceStatus(getEmpInsuranceStatusCode,context);
      }
      else
      {
        /*---Disable the Health Card when emp  Relieving the company---*/
        //Insurance_DummyPage();
        TalentNavigation().pushTo(context, Insurance_DummyPage());

      }

    }
    /*--------------28-1-2022 end-------------*/

  }


}
checkInsuranceStatus(String insuranceStatus,BuildContext context)
{
  print("show the insurance status $insuranceStatus");
  if(insuranceStatus=="1")
  {
    //1 => Medical Insurance
    // insurance_ViewInsuranceCard()
    TalentNavigation().pushTo(context, insurance_ViewInsuranceCard());

  }
  else if(insuranceStatus=="2")
  {
    // 2 => ESI
    TalentNavigation().pushTo(context, insurance_notenrolledpolicy());

  }
  else if(insuranceStatus=="3")
  {
    //3 => Third Party Insurance
    TalentNavigation().pushTo(context, insurance_notenrolledpolicy());

  }
  else if(insuranceStatus=="4")
  {
    //Pending for approval
    TalentNavigation().pushTo(context, insurance_notenrolledpolicy());

  }
  else if(insuranceStatus=="5")
  {
    //4 => Apply Insurance Button
    // insurance_notenrolledpolicy();
    TalentNavigation().pushTo(context, insurance_notenrolledpolicy());

  }
  else
  {
    //check for other cases
    // //print('show insurance status');

    CJSnackBar(context, "server error...");

  }

}