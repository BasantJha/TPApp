
import 'package:contractjobs/Services/AESAlgo/EncryptedMapBody.dart';
import 'package:flutter/material.dart';

import '../../../../../../Constant/ConstantIcon.dart';
import '../../../../../../Constant/Constants.dart';
import '../../../../../../CustomView/CJHubCustomView/SalaryYearMonth_List.dart';
import '../../../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../TalentNavigation/TalentNavigation.dart';
import '../../../CJHubSalaryModule/salary_slip_detail.dart';

CircleAvatar greenCircleAvatar()
{
  return CircleAvatar(
    backgroundColor: Colors.green,
    child: Icon(
      Icons.check,
      size: 15,
      color: Colors.white,
    ),
  );
}
CircleAvatar greyCircleAvatar()
{
  return CircleAvatar(
    backgroundColor: Colors.grey,
  );
}

ListTile getCustomListTileForSalaryStatus(String icon,String salaryStatusText,String salaryStatusDate)
{
  return ListTile(
    leading: Image(/*width: 40,height: 40,*/
      image: AssetImage(icon),
    ),
    title: Text(
      salaryStatusText,
      style: TextStyle(
        fontSize: large_FontSize,
        fontWeight: bold_FontWeight,
      ),
    ),
    subtitle: Text(
      salaryStatusDate,
      style: TextStyle(
        color: darkGreyColor,
        fontWeight: bold_FontWeight,
        fontSize: small_FontSize
      ),
    ),
  );
}

Column getCustomListTileForSalarySlip(String month_year, String date_range, int index,
    List<String> monthArray,BuildContext context,String completeEmpCode)
{

 return Column(children: [

    ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: ImageIcon(
          AssetImage("calendar.png"),
          color: index % 2 == 0
              ? Colors.orange
              : index % 3 == 0
              ? Colors.pink
              : darkBlueColor,
        ),
      ),
      title: Text(
        month_year,
        style: TextStyle(
          fontSize: large_FontSize,
          fontFamily: viewHeadingFontfamily,
          fontWeight: bold_FontWeight,
        ),
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, elevation: 0),
        onPressed: ()
        {
          print("download clicked at index - $index");
          String selected_year_month = monthArray[index];

          print("show the selected index $index");


          List<String> separated = selected_year_month.split(" ");
          String selected_MonthName=separated[0];
          String selected_Year=separated[1];

          String monthNumber_byMonthName=SalaryYearMonth_List.FindMonthNumber_ByMonthName(selected_MonthName);

       /*   SharedPreference.setSalaryMonthNumber(monthNumber_byMonthName);
          SharedPreference.setSalaryMonthName(selected_MonthName);
          SharedPreference.setSalaryYear(selected_Year);*/

         String empCode=getEncrypted_EmpCodeSalaryDetailsTankhaPay(completeEmpCode, monthNumber_byMonthName, selected_Year);

          TalentNavigation().pushTo(context, salary_slip_detail(completedEmpCode: empCode,salaryYearType:
          selected_Year,salaryMonthNameType: selected_MonthName,));
        },
        child: Image(
          image: AssetImage(Talent_Icon_salarypage_download),
        ),
      ),

    ),

   Padding(padding: EdgeInsets.only(left: 20,right: 30),
           child:Container(color: lightGreyColor,height: 2,) ,),


  ],);


  /*return ListTile(
    leading: Padding(
      padding: const EdgeInsets.only(top: 0),
      child: ImageIcon(
        AssetImage("calendar.png"),
        color: index % 2 == 0
            ? Colors.orange
            : index % 3 == 0
            ? Colors.pink
            : darkBlueColor,
      ),
    ),
    title: Text(
      month_year,
      style: TextStyle(
        fontSize: large_FontSize,
        fontFamily: viewHeadingFontfamily,
        fontWeight: bold_FontWeight,
      ),
    ),
   *//* subtitle: Text(date_range, style: TextStyle(
      fontSize: small_FontSize,
      fontFamily: viewHeadingFontfamily,
      //fontWeight: bold_FontWeight,
    )),*//*
    trailing: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, elevation: 0),
      onPressed: ()
      {
        print("download clicked at index - $index");
        String selected_year_month = monthArray[index];

        print("show the selected index $index");


        List<String> separated = selected_year_month.split(" ");
        String selected_MonthName=separated[0];
        String selected_Year=separated[1];

        String monthNumber_byMonthName=SalaryYearMonth_List.FindMonthNumber_ByMonthName(selected_MonthName);

        SharedPreference.setSalaryMonthNumber(monthNumber_byMonthName);
        SharedPreference.setSalaryMonthName(selected_MonthName);
        SharedPreference.setSalaryYear(selected_Year);

        TalentNavigation().pushTo(context, salary_slip_detail());
      },
      child: Image(
        image: AssetImage(Talent_Icon_salarypage_download),
      ),
    ),

  );*/
}

/*----------contractual employee salary status start----------------*/
/*
 SizedBox salary_progress(BuildContext context)
  {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Visibility(visible: accountFunded_Visibility,child:Expanded(
           flex: 3,
           child: TimelineTile(
             indicatorStyle: IndicatorStyle(
               indicator: completionState >= 1 ? greenCircleAvatar() : greyCircleAvatar(),
             ),
             isFirst: true,
             alignment: TimelineAlign.manual,
             lineXY: 0.1,
             afterLineStyle: LineStyle(
               color: completionState > 1 ? Colors.green : Colors.grey,
             ),
             endChild:getCustomListTileForSalaryStatus(Talent_Icon_salary_page_attendence,clentAccountFundedTitle,"Date: $attendanceProcessingDate"),
           ),
         ) ,) ,

          accountFunded_Visibility==true ? Expanded(
            flex: 3,
            child: TimelineTile(
              indicatorStyle: IndicatorStyle(
                indicator: completionState >= 2 ? greenCircleAvatar() : greyCircleAvatar(),
              ),
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              beforeLineStyle: LineStyle(
                color: completionState > 1 ? Colors.green : Colors.grey,
              ),
              afterLineStyle: LineStyle(
                color: completionState > 2 ? Colors.green : Colors.grey,
              ),
              endChild:getCustomListTileForSalaryStatus(Talent_Icon_salary_page_attendence,attendanceProcessingTitle,"Date: $attendanceProcessingDate"),
            ),
          ):Expanded(
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

*/