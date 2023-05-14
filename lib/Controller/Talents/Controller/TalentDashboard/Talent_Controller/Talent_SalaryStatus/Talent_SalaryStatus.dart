import 'dart:developer';

import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/CJHubSalaryModule/salary_slip_detail.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/ModelClass/EarningCardData.dart';
import 'package:contractjobs/Controller/Talents/ModelClasses/CJHubModelClasses/SalaryStatus_ModelResponse.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/Messages/Talent_TextMessages.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../../CustomView/CJHubCustomView/SalaryYearMonth_List.dart';
import '../../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../../Services/AESAlgo/Keys.dart';
import '../../../../../../Services/AESAlgo/encrypt.dart';
import '../../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../../Services/Messages/Message.dart';
import '../../../../../TankhaPayModule/Controller/TankhaPayDrawer/TankhaPayDrawer.dart';
import '../../../../ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../../../ModelClasses/CJTalentCommonModelClass.dart';
import '../../../../TalentNavigation/TalentNavigation.dart';
import '../../Talent_HomeView/Talent_HomeChild.dart';
import '../../Talent_LeftDrawer/Talent_LeftDrawer.dart';
import 'Talent_SalaryStatusChild.dart';


var salaryStatusMonthList = salaryStatusList;

class Talent_SalaryStatus extends StatefulWidget
{
  const Talent_SalaryStatus({Key? key,this.visibilityStatusForSalaryStatus, this.liveModelObject}) : super(key: key);

  final bool? visibilityStatusForSalaryStatus;
  final VerifyOTP_ModelResponse? liveModelObject;

  @override
  State<Talent_SalaryStatus> createState() => _Talent_SalaryStatus(visibilityStatusForSalaryStatus!);
}

class _Talent_SalaryStatus extends State<Talent_SalaryStatus> {

  var completionState = 0;
  String salaryStatus="Salary Status";
  String checkRoleType="";
  String monthName="",monthNumber="";

  //Client Account Funded

  String clentAccountFundedDate="";
  String attendanceProcessingDate="",
      salaryProcessingDate="",
      bankTransferDate="";


  String attendanceProcessingTitle="Attendance Approved",
      salaryProcessingTitle="Payout Approved",
      bankTransferTitle="Bank Transfer Initiated";

  List<String> salaryMonth_StringList = [];
  BuildContext? contextType;

  bool salaryStatus_Visibility=true;
  String completeEmpCode="";

  _Talent_SalaryStatus(bool visibilityStatus)
  {
    this.salaryStatus_Visibility=visibilityStatus;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //checkEmp_JobType();
    //salaryStatusRequest();

    salaryStatusServiceBodyRequest();

  }

  @override
  Widget build(BuildContext context) {
    contextType=context;
    return Scaffold(
      drawer:  TankhaPayDrawer(liveModelObject: widget.liveModelObject,),
      backgroundColor: Colors.white,
     appBar: salaryStatus_Visibility ? CJAppBarBgBlue("", appBarBlock: AppBarBlock(appBarAction: ()
     {
       print("show the action 1type");
       Navigator.pop(context);
     })): null,

      body:getResponsiveUI() ,
    );
  }

  Responsive getResponsiveUI()
  {
    return Responsive(
      mobile: salaryStatus_Visibility ? MainfunctionUi():MainfunctionUi(),
      tablet: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: salaryStatus_Visibility ? MainfunctionUi():MainfunctionUi(),
        ),
      ),
      desktop: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: salaryStatus_Visibility ? MainfunctionUi():MainfunctionUi(),
        ),
      ),
    );
  }
  CirclesBackground  MainfunctionUi()
  {
    return CirclesBackground(
      circles:getCircleInfoForHome,
      child: getTheCustomColumn(),);
  }

  Column getTheCustomColumn()
  {
    return Column(
      children: [

        ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Text("Salary Status",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: salaryStatus_Visibility ? whiteColor:whiteColor,
                fontFamily: robotoFontFamily,
                fontSize: 20.0),
          ),

        ),
        SizedBox(height: 22,),
        Expanded(
          child:  SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  title: Text(monthName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: darkBlueColor,
                        fontFamily: robotoFontFamily,
                        fontSize: 18.0),
                  ),

                ),
                salary_progress(context),
                ListTile(

                  title: Text(
                    textAlign: TextAlign.center,
                    "DOWNLOAD SALARY SLIP",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: viewHeadingFontfamily,
                      color: darkBlueColor,
                    ),
                  ),

                ),
                Column(
                  children: salaryMonth_StringList
                      .map((obj) => getCustomListTileForSalarySlip(obj.toString(),
                      obj.toString(), salaryMonth_StringList.indexOf(obj),
                      salaryMonth_StringList,contextType!,completeEmpCode)).toList(),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
  SizedBox salary_progress(BuildContext context)
  {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: TimelineTile(
              indicatorStyle: IndicatorStyle(
                indicator: completionState >= 2 ? greenCircleAvatar() : greyCircleAvatar(),
              ),
              isFirst: true,
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              /* beforeLineStyle: LineStyle(
                color: completionState > 1 ? Colors.green : Colors.grey,
              ),*/
              afterLineStyle: LineStyle(
                color: completionState > 2 ? Colors.green : Colors.grey,
              ),
              endChild:getCustomListTileForSalaryStatus(Talent_Icon_salary_page_attendence,attendanceProcessingTitle,"Date: $attendanceProcessingDate"),
            ),
          ),

          Expanded(
            flex: 3,
            child: TimelineTile(
              indicatorStyle: IndicatorStyle(
                indicator: completionState >= 3 ? greenCircleAvatar() : greyCircleAvatar(),
              ),
              // isFirst: true,
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              beforeLineStyle: LineStyle(
                color: completionState > 2 ? Colors.green : Colors.grey,
              ),
              afterLineStyle: LineStyle(
                color: completionState > 3 ? Colors.green : Colors.grey,
              ),
              endChild:getCustomListTileForSalaryStatus(Talent_Icon_salary_page_salary_process,salaryProcessingTitle,"Date: $salaryProcessingDate"),
            ),
          ),
          Expanded(
            flex: 3,
            child: TimelineTile(
              indicatorStyle: IndicatorStyle(
                indicator: completionState >= 4 ? greenCircleAvatar() : greyCircleAvatar(),
              ),
              isLast: true,
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              beforeLineStyle: LineStyle(
                color: completionState > 3 ? Colors.green : Colors.grey,
              ),
              endChild: getCustomListTileForSalaryStatus(Talent_Icon_salary_page_bank_transfer,bankTransferTitle,"Date: $bankTransferDate"),
            ),
          ),
        ],
      ),
    );
  }



  /*--------------hit the salary status service request start---------------*/
  checkEmp_JobType()
  {
    SharedPreference.getEmpJobType().then((value) =>  {
      //print('show emp name2 $value'),
    });
  }


  salaryStatusServiceBodyRequest()
  {
    completeEmpCode=getTheCompletedEmpCodeByLiveObject(widget.liveModelObject!);
    var mapObject=getCJHub_SalaryStatus_RequestBody(completeEmpCode);
    serviceRequest(mapObject);

  }

  serviceRequest(Map mapObj)
  {
    print("show the request2 $mapObj");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.get_Salary_Status,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();

          SalaryStatus_ModelResponse salaryStatus_ModelResponse=success as SalaryStatus_ModelResponse;
          if(salaryStatus_ModelResponse.statusCode==true)
          {
            loadSalaryStatusData(salaryStatus_ModelResponse);
            loadLiveData(salaryStatus_ModelResponse);
          }

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();
          CJTalentCommonModelClass commonObject= failure as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }

        }, talentHandleExceptionBlock: <T>(handleException)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= handleException as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }

        }));
  }

  loadSalaryStatusData(SalaryStatus_ModelResponse salaryStatus_ModelResponse)
  {
    String checkSalaryStatus=salaryStatus_ModelResponse.data!.salaryStatus;

    String monthNameByMonthNumber=SalaryYearMonth_List.FindMonthName_ByNumber(salaryStatus_ModelResponse.data!.mprMonth);
    String  salaryYear = salaryStatus_ModelResponse.data!.mprYear;
    // String completeSalaryStatus="Salary Status for the\nmonth of "+""+monthNameByMonthNumber+" ' "+salaryYear;
    String completeSalaryStatus=monthNameByMonthNumber+" "+salaryYear;

    setState(() {

      //salaryStatus=completeSalaryStatus;
      monthNumber=salaryStatus_ModelResponse.data!.salaryMonths;
      monthName=completeSalaryStatus;

      if(checkSalaryStatus=="1")
      {
        Method.snackBar_OkText(context, "Salary Status not found");
        // show_OKAlert("Salary Status not found");
      }
      else if(checkSalaryStatus=="2")
      {
        //attendance received
        completionState=2;
        attendanceProcessingDate=salaryStatus_ModelResponse.data!.attendanceReceiveDate;
        attendanceProcessingTitle="Attendance Approved";
      }
      else if(checkSalaryStatus=="3")
      {
        //salary processed received
        completionState=3;

        attendanceProcessingDate=salaryStatus_ModelResponse.data!.attendanceReceiveDate;
        salaryProcessingDate=salaryStatus_ModelResponse.data!.payrollProcessingDate;
        attendanceProcessingTitle="Attendance Approved";
        salaryProcessingTitle="Payout Approved";
      }
      else if(checkSalaryStatus=="4")
      {

        completionState=4;

        attendanceProcessingDate=salaryStatus_ModelResponse.data!.attendanceReceiveDate;
        salaryProcessingDate=salaryStatus_ModelResponse.data!.payrollProcessingDate;
        bankTransferDate=salaryStatus_ModelResponse.data!.bankTransferDate;

        attendanceProcessingTitle="Attendance Approved";
        salaryProcessingTitle="Payout Approved";
      }
      else
      {

      }


    });

  }
/*--------------hit the salary status service request end---------------*/


/*----------------------------*/
  loadLiveData(SalaryStatus_ModelResponse checkSalaryStatusModelData)
  {
    salaryMonth_StringList=SalaryYearMonth_List.loadLiveData(checkSalaryStatusModelData);
    //print('show string list $heads_stringList');
    setState(() {
      salaryMonth_StringList=salaryMonth_StringList;
     /* if(salaryMonth_StringList.length>0)
        {
          monthName=salaryMonth_StringList[0];
        }*/
    });
    /*-----start new logic for the -------*/

  }

 /* loadTheSelectedYearMonth(String selected_year_month)
  {
    List<String> separated = selected_year_month.split(" ");
    String selected_MonthName=separated[0];
    String selected_Year=separated[1];

    String monthNumber_byMonthName=SalaryYearMonth_List.FindMonthNumber_ByMonthName(selected_MonthName);

    SharedPreference.setSalaryMonthNumber(monthNumber_byMonthName);
    SharedPreference.setSalaryMonthName(selected_MonthName);
    SharedPreference.setSalaryYear(selected_Year);

    TalentNavigation().pushTo(context, salary_slip_detail());

  }*/
}

