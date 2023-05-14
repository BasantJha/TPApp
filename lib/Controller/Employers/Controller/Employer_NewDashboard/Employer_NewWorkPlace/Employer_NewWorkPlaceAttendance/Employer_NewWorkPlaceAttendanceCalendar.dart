

import 'dart:math';

import 'package:flutter/material.dart';


import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';


import '../../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../../Constant/ConstantIcon.dart';
import '../../../../../../Constant/Constants.dart';
import '../../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../../CustomView/CJHubCustomView/palatte_Textstyle.dart';
import '../../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../../Services/Messages/Message.dart';
import '../../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../../../TankhaPayModule/Controller/ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfileChild.dart';
import '../../../EmployerModelClasses/EmployerAttendanceModelClass/Employer_NewWorkPlaceAttendanceCalendarModelClasses/Employer_NewWorkPlaceAttendanceCalendar_Get_MonthlyAttendance_ModelClass.dart';
import '../../../EmployerModelClasses/EmployerAttendanceModelClass/Employer_NewWorkPlaceAttendanceCalendarModelClasses/Employer_NewWorkPlaceAttendanceCalender_SaveMonthlyAttendance_ModelClass.dart';
import '../../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';



// ignore: must_be_immutable
class Employer_NewWorkPlaceAttendanceCalendar extends StatefulWidget {

  String? empcode;
  String? empImagePath;
  String? empName;
  String? todayAttendanceStatus;
  String? attendanceApprovalStatus;
  String? month;
  String? year;
  String? todayAttendance;
  String? doj;
  String? dateOfReleiving;
  String? payoutSettingStatus;

  Employer_NewWorkPlaceAttendanceCalendar(
      this.empcode,this.empImagePath,this.empName,this.todayAttendanceStatus,this.attendanceApprovalStatus,this.year,
      this.month,this.todayAttendance,this.liveModelObj,this.doj,this.dateOfReleiving,this.payoutSettingStatus);
  final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  _Employer_NewWorkPlaceAttendanceCalendarState createState() => new _Employer_NewWorkPlaceAttendanceCalendarState();
}


Color presentColor = Color(0xff01a14b);
Color absentColor = Color(0xfffe0000);
Color halfDayColor = Color(0xff8dc53e);
Color leaveColor = Color(0xfff5b259);
Color hoLiDayColor = Color(0xff22409a);
Color clearColor = Color(0xffcdcdcd);
Color approveBtnColor = Colors.orange;

List<DateTime> presentDates = [];

List<DateTime> absentDates = [];

List<DateTime> halfDayDates = [];

List<DateTime> hoLiDayDates = [];

List<DateTime> leaveDates = [];

List<DateTime> selectedDate =[];



class _Employer_NewWorkPlaceAttendanceCalendarState extends State<Employer_NewWorkPlaceAttendanceCalendar>

{



  static Widget _presentIcon(String day) => Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: presentColor),
      padding: EdgeInsets.only(left: 2,top: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text( day.toString(),style: TextStyle(fontSize:12,color: Color(0xff363636)),),
            ],
          ),
          day.length ==1 ? SizedBox(width: 5,):SizedBox(width: 2,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("P",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      //fontFamily: "Roboto",
                      fontWeight: FontWeight.w500
                  )
              ),
            ],
          )
        ],
      )
  );


  static Widget _absentIcon(String day) =>  Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: absentColor),
      padding: EdgeInsets.only(left: 2,top: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text( day.toString(),style: TextStyle(fontSize:12,color: Color(0xff363636)),),
            ],
          ),
          day.length ==1 ? SizedBox(width: 5,):SizedBox(width: 2,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("A",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      //fontFamily: "Roboto",
                      fontWeight: FontWeight.w500
                  )
              ),
            ],
          )
        ],
      )
  );

  static Widget _halfDayIcon(String day) =>  Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: halfDayColor),
      padding: EdgeInsets.only(left: 2,top: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text( day.toString(),style: TextStyle(fontSize:12,color: Color(0xff363636)),),
            ],
          ),
          day.length ==1 ? SizedBox(width: 5,):SizedBox(width: 2,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("H",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      //fontFamily: "Roboto",
                      fontWeight: FontWeight.w500
                  )
              ),
            ],
          )
        ],
      )
  );

  static Widget _holidayIconIcon(String day) =>  Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: hoLiDayColor),
      padding: EdgeInsets.only(left: 2,top: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text( day.toString(),style: TextStyle(fontSize:12,color: Color(0xff363636)),),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("HO",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      //fontFamily: "Roboto",
                      fontWeight: FontWeight.w500
                  )
              ),
            ],
          )
        ],
      )
  );

  static Widget _leaveIcon(String day) {
    print("day Length ${day.length} $day");
    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: leaveColor),
        padding: EdgeInsets.only(left: 2,top: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text( day.toString(),style: TextStyle(fontSize:12,color: Color(0xff363636)),),
              ],
            ),
            day.length ==1 ? SizedBox(width: 5,):SizedBox(width: 2,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("L",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        //fontFamily: "Roboto",
                        fontWeight: FontWeight.w500
                    )
                ),
              ],
            )
          ],
        )
    );
  }


  static Widget _selectedDateIcon(String day ) =>  Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      // borderRadius: BorderRadius.circular(20.0),
      shape: BoxShape.rectangle,
      color: Color(0xff5b5b5b),),
    child: Image.asset(TankhaPay_Icon_AttendanceSelectionIcon,height: 50,width: 50,),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  Map<DateTime,dynamic> statusKeep = {};


  var checkAttendanceApproveStatus="";
  var checkAttendanceApproveMessage="";
  String approvalStatusOfAttendance = "";

  String? payOutDate = "";




  CalendarCarousel _calendarCarouselNoHeader = CalendarCarousel();
  List<Data> attendanceData = [];

  var len = min(absentDates.length, presentDates.length);
  double? cHeight;
  var lockStatus;
  Map<DateTime,dynamic> approvalStatus = {};
  var  monthOfAttendance;
  var yearOfAttendance;
  var dayOfAttendance = DateTime.now().day;
  List dateOfJoining = [];
  List dateOfRelieveing = [];
  DateTime? firstDayOnCalendar;
  DateTime? lastDateOnCalendar;

  bool? buttonStatusOnReLeaveDay;


  List<Map<String,dynamic>> attendanceUpdate = [];
  List<Map<String,dynamic>> attendanceToApprove = [];
  Map<DateTime,dynamic> dataPassedToSaveAttendance = {};

  Map<DateTime,dynamic> statusKeepForLock = {};
  List<Map<String,dynamic>> attendanceToLock = [];
  //Start 05-05-2023
  DateTime _targetDateTime = DateTime.now();
  //End 05-05-2023
  String _currentMonth = "";

  int counter = 0;
  var prevMonth;

  @override
  void initState() {

    //widget.dateOfReleiving = "1/1/2023";
    /*------- Start 05-05-2023 ---------------------------------*/
    if(widget.month == "" || widget.month == null || widget.year == "" || widget.year == null)
      {
        _targetDateTime = DateTime.now();
        monthOfAttendance = DateTime.now().month;
        yearOfAttendance = DateTime.now().year;
        _currentMonth =  DateFormat.yMMM().format(_targetDateTime);
      }
    else
      {
        _targetDateTime = DateTime(int.parse(widget.year.toString()),int.parse(widget.month.toString()));
        monthOfAttendance = int.parse(widget.month.toString());
        yearOfAttendance = int.parse(widget.year.toString());
        _currentMonth =  DateFormat.yMMM().format(_targetDateTime);
      }

    /*------- end 05-05-2023 ---------------------------------*/


    // _targetDateTime = DateTime(int.parse(widget.year.toString()),int.parse(widget.month.toString()));
    // monthOfAttendance = int.parse(widget.month.toString());
    // yearOfAttendance = int.parse(widget.year.toString());
    // _currentMonth =  DateFormat.yMMM().format(_targetDateTime);
    /*------- End 05-05-2023 ---------------------------------*/

    print("Year and Month $monthOfAttendance $yearOfAttendance");
    //widget.dateOfReleiving="4/03/2023"; //testing purpose


    print("show the dateofjoining ${widget.doj}");
    print("show the dateofReleaving ${widget.dateOfReleiving}");


    //widget.dateOfReleiving=""; //USE FOR TRESTING PURPOSE--21-3-2023

    serviceBodyRequestforGetEmployerAttendance();
    addDateOfJoining(widget.doj.toString());
    addDateOfReleiveing(widget.dateOfReleiving.toString());



    super.initState();
  }

  dispose()
  {
    super.dispose();
  }


  addDateOfJoining(String joiningDate)
  {
    dateOfJoining.clear();
    if(joiningDate == "" || joiningDate == null)
    {
      dateOfJoining.add(DateTime.now().year);
      dateOfJoining.add(DateTime.now().month);
      dateOfJoining.add(DateTime.now().day);
      var datejoining = DateTime(dateOfJoining[0],dateOfJoining[1],dateOfJoining[2]);
      firstDayOnCalendar = datejoining;
    }
    else
    {
      var dates = joiningDate.split('/');
      dateOfJoining.add(int.parse(dates[2]));
      dateOfJoining.add(int.parse(dates[1]));
      dateOfJoining.add(int.parse(dates[0]));
      var datejoining = DateTime(dateOfJoining[0],dateOfJoining[1],dateOfJoining[2]);
      if(datejoining.month>DateTime.now().month && datejoining.year==DateTime.now().year)
      {
        firstDayOnCalendar = DateTime.now();
      }
      else
      {
        firstDayOnCalendar = datejoining;
      }
    }
    print("date OF Joining $dateOfJoining");
  }

  addDateOfReleiveing(String releivingDate)
  {
    var relieveDay;
    dateOfRelieveing.clear();
    print("Releaving date $releivingDate");
    if(releivingDate == "" || releivingDate == null)
    {
      dateOfRelieveing.add(DateTime.now().year);
      dateOfRelieveing.add(DateTime.now().month);
      dateOfRelieveing.add(DateTime.now().day);
      var relieveDay = DateTime(dateOfRelieveing[0],dateOfRelieveing[1],dateOfRelieveing[2]);
      lastDateOnCalendar  = relieveDay;

    }
    else
    {
      print("Inside else block of Releaving Day");
      var dates = releivingDate.split('/');
      dateOfRelieveing.add(int.parse(dates[2]));
      dateOfRelieveing.add(int.parse(dates[1]));
      dateOfRelieveing.add(int.parse(dates[0]));
      relieveDay = DateTime(dateOfRelieveing[0],dateOfRelieveing[1],dateOfRelieveing[2]);

      setState(() {
        if(relieveDay.month < monthOfAttendance && relieveDay.year == yearOfAttendance)
        {
          setState(() {
            checkAttendanceApproveStatus= "Locked";
            lastDateOnCalendar  = DateTime(DateTime.now().year,DateTime.now().month,1);
          });
        }
        else
        {
          setState(() {
            print("Inside else block");
            lastDateOnCalendar  = relieveDay;
          });
        }
       // DateTime(yearOfAttendance,monthOfAttendance,dayOfAttendance)
        if(relieveDay.isAfter(DateTime.now()))
        {
          setState(() {
            buttonStatusOnReLeaveDay = true;
          });
        }
        else
        {
          /*------ Start Date 13-04-2022  -----------------------------------*/
          setState(() {
           buttonStatusOnReLeaveDay = false;
          });
          /*------ End Date 13-04-2022  -----------------------------------*/


        }
      });
    }
    print("Relieve day is after");
    print("day year month $dayOfAttendance $monthOfAttendance $yearOfAttendance");
    print("Button Condition");
    print((checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false));
   print("date OF Releiving $dateOfRelieveing");
   print("Lock Status $checkAttendanceApproveStatus");
    print("Button Status On Releave Day in add dateOfReleaving $buttonStatusOnReLeaveDay");
    print("Last date On calendar $lastDateOnCalendar");
  }



  adddata()
  {
    /*------- Start date 28-04-2023 ------------*/

    var statusOnReleaveDay;
    print("Date of Releaving ${widget.dateOfReleiving}");
    print("Button Status on releave Day in add data when releaving date is null $buttonStatusOnReLeaveDay");
    print("Releave Day Condition ${widget.dateOfReleiving != ""} or ${widget.dateOfReleiving != null}");
    if(widget.dateOfReleiving == "" || widget.dateOfReleiving == null)
    {
      if(lockStatus == "Locked")
        {
          statusOnReleaveDay = false;
        }
      else
        {
          print("When Not Locked");
          // This is for not Locked
          statusOnReleaveDay = true;
        }
      setState(() {
        buttonStatusOnReLeaveDay = statusOnReleaveDay;
      });


       print("Button Status on releave Day in add data when releaving date is null $buttonStatusOnReLeaveDay");
    }
    else
      {
        print("Releave day is present");
        for(var v in approvalStatus.values)
        {
          if(v == "P")
          {
            print("Value v $v");
            statusOnReleaveDay = true;
            break;
          }
          else
          {
            print("Value v1 $v");
            statusOnReleaveDay = false;
          }
        }
        setState(() {
          buttonStatusOnReLeaveDay = statusOnReleaveDay;
        });

      }

    /*------- End date 28-04-2023 ------------*/

    /*-------- Start Date 22 March 2023 -------------------*/
    _markedDateMap = EventList<Event>(
      events: {},
    );

    /*-------- End Date 22 March 2023 -------------------*/

    for (int i = 0; i < presentDates.length; i++) {
      _markedDateMap.add(
        presentDates[i],
        new Event(
          date: presentDates[i],
          title: 'PP',
          icon: _presentIcon(
            presentDates[i].day.toString(),
          ),
        ),
      );
      statusKeep[presentDates[i]] = "PP";
    }

    for (int i = 0; i < absentDates.length; i++) {
      _markedDateMap.add(
        absentDates[i],
        new Event(
          date: absentDates[i],
          title: 'AA',
          icon: _absentIcon(
            absentDates[i].day.toString(),
          ),
        ),
      );
      statusKeep[absentDates[i]] = "AA";
    }


    for (int i = 0; i < halfDayDates.length; i++)
    {
      _markedDateMap.add(
        halfDayDates[i],
        new Event(
          date: halfDayDates[i],
          title: 'HD',
          icon: _halfDayIcon(
            halfDayDates[i].day.toString(),
          ),
        ),
      );
      statusKeep[halfDayDates[i]] = "HD";
    }
    for (int i = 0; i < hoLiDayDates.length; i++) {
      _markedDateMap.add(
        hoLiDayDates[i],
        new Event(
          date: hoLiDayDates[i],
          title: 'HO',
          icon: _holidayIconIcon(
            hoLiDayDates[i].day.toString(),
          ),
        ),
      );
      statusKeep[hoLiDayDates[i]] = "HO";
    }

    for (int i = 0; i < leaveDates.length; i++) {
      _markedDateMap.add(
        leaveDates[i],
        new Event(
          date: leaveDates[i],
          title: 'LL',
          icon: _leaveIcon(
            leaveDates[i].day.toString(),
          ),
        ),
      );
      statusKeep[leaveDates[i]] = "LL";
    }
    // print("Status Keeper $statusKeep");
    // print("marked Map${_markedDateMap.events}");
    // print("Approval List $attendanceToApprove");
    // print("Lock Attendance $attendanceToLock");
    // print("Attendance To approve length ${attendanceToApprove.length}");
    // print("Attendance To Lock length ${attendanceToLock.length}");
    // print("Marked Map Attendance length ${_markedDateMap.events.length}");


    /*------- Attendance Lock and Approve List Code Start ------------*/


    if(attendanceToApprove.isNotEmpty)
    {
      print("Attendance to Approve is notEmpty in addData");
      attendanceToApprove.clear();
      _markedDateMap.events.forEach((key, value) {
        print("Value of Marked map ${value.first.title}");
        var attendanceType = value.first.title;
        /*------- Approval List Code Start -------------*/

       // if(approvalStatus[key] == "P" || approvalStatus[key] == "A")
        if(true)
        {
          var day = key.day;
          var month = key.month;
          var year = key.year;
          var date;
          var monthToUpdate;
          if(day<10)
          {
            if(month<10)
            {
              print("Month to Update month Less Than one 10");
              monthToUpdate = "0$month";
              date = "0$day/$monthToUpdate/$year";
            }
            else
            {
              print("Month to Update month Greater one 10");
              date = "0$day/$month/$year";
            }
          }
          else
          {
            if(month<10)
            {
              print("Month to Update month Less two 10");
              monthToUpdate = "0$month";
              date = "$day/$monthToUpdate/$year";
            }
            else
            {
              print("Month to Update month Greater two 10");
              date = "$day/$month/$year";
            }
          }
          var attenData = attendanceType;
          attendanceToApprove.add({
            "attendancedate": "${date.toString()}",
            "attendancetype": "${attenData.toString()}"
          });
        }

        /*------- Approval List Code End -------------*/


      });
    }
    else
    {
      print("Attendance to Approve is Empty in addData");
      _markedDateMap.events.forEach((key, value) {
        print("Value of Marked map ${value.first.title}");
        var attendanceType = value.first.title;
        /*------- Approval List Code Start -------------*/

        if(true)
        {
          var day = key.day;
          var month = key.month;
          var year = key.year;
          var date;
          var monthToUpdate;
          if(day<10)
          {
            if(month<10)
            {
              print("Month to Update month Less Than one 10");
              monthToUpdate = "0$month";
              date = "0$day/$monthToUpdate/$year";
            }
            else
            {
              print("Month to Update month Greater one 10");
              date = "0$day/$month/$year";
            }
          }
          else
          {
            if(month<10)
            {
              print("Month to Update month Less two 10");
              monthToUpdate = "0$month";
              date = "$day/$monthToUpdate/$year";
            }
            else
            {
              print("Month to Update month Greater two 10");
              date = "$day/$month/$year";
            }
          }
          var attenData = attendanceType;
          attendanceToApprove.add({
            "attendancedate": "${date.toString()}",
            "attendancetype": "${attenData.toString()}"
          });
        }

        /*------- Approval List Code End -------------*/


      });
    }

    if(attendanceToLock.isNotEmpty)
    {
      print("Attendance to Lock is notEmpty in addData");
      attendanceToLock.clear();
      _markedDateMap.events.forEach((key, value) {
        print("Value of Marked map ${value.first.title}");
        var attendanceType = value.first.title;

        /*------- Locked List Code Start -------------*/
        if( !(statusKeepForLock[key] == "Locked"))
        {
          var day = key.day;
          var month = key.month;
          var year = key.year;
          var date;
          var monthToUpdate;
          if(day<10){
            if(month<10)
            {
              print("Month to Update month Less Than one 10");
              monthToUpdate = "0$month";
              date = "0$day/$monthToUpdate/$year";
            }
            else
            {
              print("Month to Update month Greater one 10");
              date = "0$day/$month/$year";
            }
          }
          else{
            if(month<10)
            {
              print("Month to Update month Less two 10");
              monthToUpdate = "0$month";
              date = "$day/$monthToUpdate/$year";
            }
            else
            {
              print("Month to Update month Greater two 10");
              date = "$day/$month/$year";
            }
          }
          var attenData = attendanceType;
          attendanceToLock.add(
              {
                "attendancedate": "${date.toString()}",
                "attendancetype": "${attenData.toString()}"
              });


        }

      });
    }
    else
    {
      print("Attendance to Lock is Empty in addData");
      _markedDateMap.events.forEach((key, value) {
        print("Value of Marked map ${value.first.title}");
        var attendanceType = value.first.title;

        /*------- Locked List Code Start -------------*/
        if( !(statusKeepForLock[key] == "Locked"))
        {
          var day = key.day;
          var month = key.month;
          var year = key.year;
          var date;
          var monthToUpdate;
          if(day<10){
            if(month<10)
            {
              print("Month to Update month Less Than one 10");
              monthToUpdate = "0$month";
              date = "0$day/$monthToUpdate/$year";
            }
            else{
              print("Month to Update month Greater one 10");
              date = "0$day/$month/$year";
            }
          }
          else{
            if(month<10)
            {
              print("Month to Update month Less two 10");
              monthToUpdate = "0$month";
              date = "$day/$monthToUpdate/$year";
            }
            else
            {
              print("Month to Update month Greater two 10");
              date = "$day/$month/$year";
            }
          }
          var attenData = attendanceType;
          attendanceToLock.add(
              {
                "attendancedate": "${date.toString()}",
                "attendancetype": "${attenData.toString()}"
              });


        }

      });
    }

    /*------- Locked List Code End -------------*/


    /*------- Attendance Lock and Approve List Code End ------------*/




    /*------- Attendance Lock and Approve List Code End ------------*/



    print("Status Keeper $statusKeep");
    print("marked Map${_markedDateMap.events}");
    print("Approval List $attendanceToApprove");
    print("Lock Attendance $attendanceToLock");
    print("Attendance To approve length ${attendanceToApprove.length}");
    print("Attendance To Lock length ${attendanceToLock.length}");
    print("Marked Map Attendance length ${_markedDateMap.events.length}");
    print("Payout date $payOutDate");
    print("ButtonStatus On Releave day $buttonStatusOnReLeaveDay");


  }


  addUpdatedAttendance(){

    /*------    Attendance Update Code Start ------------*/

    if(attendanceUpdate.isNotEmpty)
    {
      print("Attendance Update is not Empty");
      attendanceUpdate.clear();
      dataPassedToSaveAttendance.forEach((key, value) {
        var boolean = statusKeep[key] == "A";

        //if(statusKeep[key] == "A" || statusKeep[key] == "P")
        if(true)
        {
          var day = key.day;
          var month = key.month;
          var year = key.year;
          var date;
          var monthToUpdate;
          if(day<10){
            if(month<10)
            {
              //print("Month to Update month Less Than one 10");
              monthToUpdate = "0$month";
              date = "0$day/$monthToUpdate/$year";
            }
            else{
              // print("Month to Update month Greater one 10");
              date = "0$day/$month/$year";
            }
          }
          else{
            if(month<10)
            {
              // print("Month to Update month Less two 10");
              monthToUpdate = "0$month";
              date = "$day/$monthToUpdate/$year";
            }
            else
            {
              //print("Month to Update month Greater two 10");
              date = "$day/$month/$year";
            }
          }
          // print("Date passed : $date");
          var attenData = value;
          // print("Attendata $attenData");
          attendanceUpdate.add(
              {
                "attendancedate": "${date.toString()}",
                "attendancetype": "${attenData.toString()}"
              }
          );
          //print("Attendance Data: $attendanceUpdate");
        }
      });
    }
    else
    {
      print("Attendance Update is  Empty");
      dataPassedToSaveAttendance.forEach((key, value) {
        var boolean = statusKeep[key] == "A";

        //if(statusKeep[key] == "A" || statusKeep[key] == "P")
        if(true)
        {
          var day = key.day;
          var month = key.month;
          var year = key.year;
          var date;
          var monthToUpdate;
          if(day<10){
            if(month<10)
            {
              //print("Month to Update month Less Than one 10");
              monthToUpdate = "0$month";
              date = "0$day/$monthToUpdate/$year";
            }
            else{
              // print("Month to Update month Greater one 10");
              date = "0$day/$month/$year";
            }
          }
          else{
            if(month<10)
            {
              // print("Month to Update month Less two 10");
              monthToUpdate = "0$month";
              date = "$day/$monthToUpdate/$year";
            }
            else
            {
              //print("Month to Update month Greater two 10");
              date = "$day/$month/$year";
            }
          }
          // print("Date passed : $date");
          var attenData = value;
          // print("Attendata $attenData");
          attendanceUpdate.add(
              {
                "attendancedate": "${date.toString()}",
                "attendancetype": "${attenData.toString()}"
              }
          );
          //print("Attendance Data: $attendanceUpdate");
        }
      });
    }


    /*------    Attendance Update Code End ------------*/


    /*------- Attendance Lock and Approve List Code Start ------------*/
    if(attendanceToApprove.isNotEmpty)
    {
      print("Attendance to Approve is not Empty");
      attendanceToApprove.clear();
      _markedDateMap.events.forEach((key, value) {
        print("Value of Marked map ${value.first.title}");
        var attendanceType = value.first.title;
        /*------- Approval List Code Start -------------*/

        //if(approvalStatus[key] == "P" || approvalStatus[key] == "A")
        if(true)
        {
          var day = key.day;
          var month = key.month;
          var year = key.year;
          var date;
          var monthToUpdate;
          if(day<10)
          {
            if(month<10)
            {
              print("Month to Update month Less Than one 10");
              monthToUpdate = "0$month";
              date = "0$day/$monthToUpdate/$year";
            }
            else
            {
              print("Month to Update month Greater one 10");
              date = "0$day/$month/$year";
            }
          }
          else
          {
            if(month<10)
            {
              print("Month to Update month Less two 10");
              monthToUpdate = "0$month";
              date = "$day/$monthToUpdate/$year";
            }
            else
            {
              print("Month to Update month Greater two 10");
              date = "$day/$month/$year";
            }
          }
          var attenData = attendanceType;
          attendanceToApprove.add({
            "attendancedate": "${date.toString()}",
            "attendancetype": "${attenData.toString()}"
          });
        }

        /*------- Approval List Code End -------------*/


      });
    }
    else
    {
      print("Attendance to Approve is Empty");
      _markedDateMap.events.forEach((key, value) {
        print("Value of Marked map ${value.first.title}");
        var attendanceType = value.first.title;
        /*------- Approval List Code Start -------------*/

        //if(approvalStatus[key] == "P" || approvalStatus[key] == "A")
        if(true)
        {
          var day = key.day;
          var month = key.month;
          var year = key.year;
          var date;
          var monthToUpdate;
          if(day<10)
          {
            if(month<10)
            {
              print("Month to Update month Less Than one 10");
              monthToUpdate = "0$month";
              date = "0$day/$monthToUpdate/$year";
            }
            else
            {
              print("Month to Update month Greater one 10");
              date = "0$day/$month/$year";
            }
          }
          else
          {
            if(month<10)
            {
              print("Month to Update month Less two 10");
              monthToUpdate = "0$month";
              date = "$day/$monthToUpdate/$year";
            }
            else
            {
              print("Month to Update month Greater two 10");
              date = "$day/$month/$year";
            }
          }
          var attenData = attendanceType;
          attendanceToApprove.add({
            "attendancedate": "${date.toString()}",
            "attendancetype": "${attenData.toString()}"
          });
        }

        /*------- Approval List Code End -------------*/


      });
    }


    if(attendanceToLock.isNotEmpty)
    {
      print("Attendance to Lock is not Empty");
      attendanceToLock.clear();
      _markedDateMap.events.forEach((key, value) {
        print("Value of Marked map ${value.first.title}");
        var attendanceType = value.first.title;

        /*------- Locked List Code Start -------------*/
        if( !(statusKeepForLock[key] == "Locked"))
        {
          var day = key.day;
          var month = key.month;
          var year = key.year;
          var date;
          var monthToUpdate;
          if(day<10){
            if(month<10)
            {
              print("Month to Update month Less Than one 10");
              monthToUpdate = "0$month";
              date = "0$day/$monthToUpdate/$year";
            }
            else{
              print("Month to Update month Greater one 10");
              date = "0$day/$month/$year";
            }
          }
          else{
            if(month<10)
            {
              print("Month to Update month Less two 10");
              monthToUpdate = "0$month";
              date = "$day/$monthToUpdate/$year";
            }
            else
            {
              print("Month to Update month Greater two 10");
              date = "$day/$month/$year";
            }
          }
          var attenData = attendanceType;
          attendanceToLock.add(
              {
                "attendancedate": "${date.toString()}",
                "attendancetype": "${attenData.toString()}"
              });


        }

      });
    }
    else
    {
      print("Attendance to Lock is Empty");
      _markedDateMap.events.forEach((key, value) {
        print("Value of Marked map ${value.first.title}");
        var attendanceType = value.first.title;

        /*------- Locked List Code Start -------------*/
        if( !(statusKeepForLock[key] == "Locked"))
        {
          var day = key.day;
          var month = key.month;
          var year = key.year;
          var date;
          var monthToUpdate;
          if(day<10)
          {
            if(month<10)
            {
              print("Month to Update month Less Than one 10");
              monthToUpdate = "0$month";
              date = "0$day/$monthToUpdate/$year";
            }
            else
            {
              print("Month to Update month Greater one 10");
              date = "0$day/$month/$year";
            }
          }
          else
          {
            if(month<10)
            {
              print("Month to Update month Less two 10");
              monthToUpdate = "0$month";
              date = "$day/$monthToUpdate/$year";
            }
            else
            {
              print("Month to Update month Greater two 10");
              date = "$day/$month/$year";
            }
          }
          var attenData = attendanceType;
          attendanceToLock.add(
              {
                "attendancedate": "${date.toString()}",
                "attendancetype": "${attenData.toString()}"
              });


        }

      });
    }

    print("Attendance To Lock $attendanceToLock");

    /*------- Attendance Lock and Approve List Code End ------------*/


    print("Status Keeper $statusKeep");
    print("marked Map${_markedDateMap.events}");
    print("Approval List $attendanceToApprove");
    print("Lock Attendance $attendanceToLock");
    print("Attendance To approve length ${attendanceToApprove.length}");
    print("Attendance To Lock length ${attendanceToLock.length}");
    print("Marked Map Attendance length ${_markedDateMap.events.length}");

  }



  @override
  Widget build(BuildContext context) {

    //lastDateOnCalendar = DateTime(2023,5,1);

    cHeight = MediaQuery.of(context).size.height;


    weekDayStyle(int dayNo, String dayName)
    {
      print("Day No $dayNo");
      print("dayName $dayName");
      var textColor;
      if(dayName == "Sun" || dayName == "Sat")
        textColor = redColor;
      else
        textColor = blackColor;

      return Container(
        padding: EdgeInsets.only(right: 17),
        child: Text(dayName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
          ),
        ),
      );
    }


    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: cHeight! * 0.5,

      headerTextStyle: TextStyle(
          color: blackColor,
          fontSize: large_FontSize,
          fontFamily: robotoFontFamily,
          fontWeight: semiBold_FontWeight
      ),
      iconColor: blackColor,
      customWeekDayBuilder: weekDayStyle,

      onDayPressed: (day,events)
      {
        var approveStatus = approvalStatus[day] == "P";
        print("Approval Status $approveStatus");
        print("Status Keep on day ${statusKeep[day]}");
        print("selected Date Contains ${selectedDate.contains(day)}");
        print("Status Keep contains ${statusKeep.containsKey(day)}");
        if(events.isEmpty)
        {
          print("First Condition");
          selectedDate.add(day);
          events.clear();
          setState(() {
            _markedDateMap.add(
                day,
                Event(
                  date: day,
                  title: "selectedDate",
                  icon: _selectedDateIcon(
                    day.day.toString(),
                  ),
                )
            );
          });
        }
        /*------------ 04-03-2023 Changes Start ----------------------------*/
       // else if(events.isNotEmpty && !selectedDate.contains(day) && approveStatus)
        /*------------ 04-03-2023 Changes End ----------------------------*/
        else if(events.isNotEmpty && !selectedDate.contains(day))
        {
          print("Second Condition");
          selectedDate.add(day);
          events.clear();
          setState(() {
            _markedDateMap.add(
                day,
                Event(
                  date: day,
                  title: "selectedDate",
                  icon: _selectedDateIcon(
                    day.day.toString(),
                  ),
                )
            );
          });
        }

        else if(events.isNotEmpty && !selectedDate.contains(day) && dataPassedToSaveAttendance.containsKey(day))
        {
          print("Third Condition");
          selectedDate.add(day);
          events.clear();
          setState(() {
            _markedDateMap.add(
                day,
                Event(
                  date: day,
                  title: "selectedDate",
                  icon: _selectedDateIcon(
                    day.day.toString(),
                  ),
                )
            );
          });
        }

        else if(selectedDate.contains(day) && statusKeep.containsKey(day))
        {
          print("Fourth Condition");
          print("Deselect The Date");
          if(statusKeep[day] == "PP")
          {
            events.first == Event(
              date: day,
              title: 'PP',
              icon: _presentIcon(
                day.day.toString(),
              ),
            );
          }
          else if(statusKeep[day] == "AA")
          {
            events.first = Event(
              date: day,
              title: 'AA',
              icon: _absentIcon(
                day.day.toString(),
              ),
            );
          }
          else if(statusKeep[day] == "HD")
          {
            events.first = Event(
              date: day,
              title: 'HD',
              icon: _halfDayIcon(
                day.day.toString(),
              ),
            );
          }
          else if(statusKeep[day] == "LL")
          {
            events.first = Event(
              date: day,
              title: 'LL',
              icon: _leaveIcon(
                day.day.toString(),
              ),
            );
          }
          else if(statusKeep[day] == "HO")
          {
            events.first = Event(
              date: day,
              title: 'HO',
              icon: _holidayIconIcon(
                day.day.toString(),
              ),
            );
          }

          setState(() {
            selectedDate.remove(day);
            if(statusKeep[day] == "PP")
            {
              _markedDateMap.events[day]!.first = Event(
                date: day,
                title: 'PP',
                icon: _presentIcon(
                  day.day.toString(),
                ),
              );
            }
            else if(statusKeep[day] == "AA")
            {
              _markedDateMap.events[day]!.first = Event(
                date: day,
                title: 'AA',
                icon: _absentIcon(
                  day.day.toString(),
                ),
              );
            }
            else if(statusKeep[day] == "HD")
            {
              _markedDateMap.events[day]!.first = Event(
                date: day,
                title: 'HD',
                icon: _halfDayIcon(
                  day.day.toString(),
                ),
              );
            }
            else if(statusKeep[day] == "LL")
            {
              _markedDateMap.events[day]!.first = Event(
                date: day,
                title: 'LL',
                icon: _leaveIcon(
                  day.day.toString(),
                ),
              );
            }
            else if(statusKeep[day] == "HO")
            {
              _markedDateMap.events[day]!.first = Event(
                date: day,
                title: 'HO',
                icon: _holidayIconIcon(
                  day.day.toString(),
                ),
              );
            }
          });
        }
        else if(selectedDate.contains(day) && !statusKeep.containsKey(day))
        {
          print("Fifth Condition");
          setState(() {
            events.clear();
            selectedDate.remove(day);
          });
        }
      },
      dayPadding: 1,
        customGridViewPhysics: NeverScrollableScrollPhysics(),
      //pageScrollPhysics: NeverScrollableScrollPhysics(),

      markedDateIconMargin: 0.0,
      daysHaveCircularBorder: false,
      todayBorderColor: Colors.grey,
      todayButtonColor: Colors.transparent,
      todayTextStyle: TextStyle(
          color: Colors.black
      ),
      //scrollDirection: Axis.horizontal,
      isScrollable:false,
      thisMonthDayBorderColor: Colors.grey,
      minSelectedDate: firstDayOnCalendar,
      maxSelectedDate: lastDateOnCalendar,

      //DateTime(dateOfRelieveing[0],dateOfRelieveing[1],dateOfRelieveing[2]),
      // viewportFraction: 1,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal: null,
      showOnlyCurrentMonthDate: true,
      /*--  Start 05-05-2023 --------------*/
      targetDateTime: _targetDateTime,
      //onCalendarChanged: monthChanged,
      onLeftArrowPressed: (){
        if(firstDayOnCalendar!.isBefore(_targetDateTime))
          {
            print("Is Before called on left button");
            _targetDateTime = DateTime(
                _targetDateTime.year, _targetDateTime.month - 1);
            var dataToAPI = DateTime(_targetDateTime.year,_targetDateTime.month,1);
            monthChanged(dataToAPI);
          }
      },
      onRightArrowPressed: (){
        print("moment check ${lastDateOnCalendar!.month>_targetDateTime.month}");
        if(lastDateOnCalendar!.year>_targetDateTime.year)
          {
            print("inside last date Year greater");
            if(lastDateOnCalendar!.isAfter(_targetDateTime))
            //&& (lastDateOnCalendar!.month>_targetDateTime.month)
            {
              print("Is After called on right button");
              _targetDateTime = DateTime(
                  _targetDateTime.year, _targetDateTime.month + 1);
              var dataToAPI = DateTime(_targetDateTime.year,_targetDateTime.month,1);
              monthChanged(dataToAPI);
            }
          }
        else if(lastDateOnCalendar!.year == _targetDateTime.year)
          {
            print("inside last date Year equal");
            if(lastDateOnCalendar!.isAfter(_targetDateTime) && (lastDateOnCalendar!.month>_targetDateTime.month))
                {
                print("Is After called on right button");
              _targetDateTime = DateTime(
                  _targetDateTime.year, _targetDateTime.month + 1);
                var dataToAPI = DateTime(_targetDateTime.year,_targetDateTime.month,1);
                monthChanged(dataToAPI);
            }
          }
      },

      /*--  End 05-05-2023 --------------*/
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );

    return new Scaffold(
      backgroundColor: getOneHundredGreyColor(),

      appBar:CJAppBar(getEmployer_WorkPlaceAttendanceCalendar, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })) ,

      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Padding(
                  //padding: EdgeInsets.symmetric(vertical: 20,horizontal: 25),
                  padding:EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                  child:  GestureDetector(
                    onTap: ()
                    {
////
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 1,bottom: 10,right: 4),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border(
                              bottom: BorderSide(
                                  width: 3,
                                  color: darkBlueColor
                              )
                          )
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5,right: 5,left: 5),
                            child: Align(
                                alignment: Alignment.topCenter,
                                child:  (widget.empImagePath == null || widget.empImagePath == "")?
                                CircleAvatar(
                                  child: Text(getProfileEmpName(widget.empName.toString())),
                                ) :
                                //Image.network(widget.empImagePath.toString(),height: 32,width: 32,),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(widget.empImagePath.toString()),
                                  radius: 30,
                                )
                            ),
                          ),

                          SizedBox(
                            width: 5,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20),child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 200,
                                child: Row(
                                  children: [
                                    /* Image(image: AssetImage(Employer_Icon_ProfileGrey,),
                                 width: Employer_SmallIcon_W_H,height: Employer_SmallIcon_W_H,color: addBlackColor,),*/
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Expanded(child: Text(widget.empName.toString(),
                                      maxLines: 2,
                                      style:TextStyle(
                                          color: darkBlueColor,
                                          fontSize: medium_FontSize,
                                          fontFamily: robotoFontFamily,
                                          fontWeight: semiBold_FontWeight
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                              /* SizedBox(
                            height: 5,
                          ),*/

                              /*  Row(

                            children: [
                              Image(image: calenderImg,height: Employer_SmallIcon_W_H,width: Employer_SmallIcon_W_H,color: addBlackColor,),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Today",
                                style: TextStyle(
                                    fontSize: medium_FontSize,
                                    fontFamily: robotoFontFamily,
                                    color: addBlackColor
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),

                              widget.todayAttendanceStatus == ""?
                              Container() : Container(
                                padding: EdgeInsets.all(5.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: colorForTodayAttendance,
                                    //widget.colorForTodayAttendance,
                                    shape: BoxShape.circle
                                ),
                                child: Text(todayAttendanceStatus,
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: medium_FontSize,
                                      fontFamily: robotoFontFamily
                                  ),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Row(
                              children: [
                                Image(image: calenderImg,height: Employer_SmallIcon_W_H,width: Employer_SmallIcon_W_H,color: addBlackColor,),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Attendance",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: medium_FontSize,
                                      fontFamily: robotoFontFamily,
                                      color: addBlackColor
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  //height: 25,
                                  //width: 120,
                                  padding: EdgeInsets.only(left: 3,right: 3,),

                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text( widget.attendanceApprovalStatus == "A"?
                                    "Approved" : widget.attendanceApprovalStatus == "P"? "Pending" : "Not Marked",
                                      style: TextStyle(
                                        color: widget.attendanceApprovalStatus == "A"?
                                        Color(0xff54B060) :  widget.attendanceApprovalStatus == "P"?
                                        Color(0xffFFA800) : Colors.red,

                                      ),),
                                    style: ButtonStyle(

                                        backgroundColor: MaterialStateProperty.all(Colors.white),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(18.0),
                                                side:
                                                BorderSide(color: widget.attendanceApprovalStatus == "A"?
                                                Color(0xff54B060) :  widget.attendanceApprovalStatus == "P"?
                                                Color(0xffFFA800) : Colors.red,)
                                            )
                                        )
                                    ),
                                  ),
                                )
                              ],
                            ),)*/
                            ],
                          ),),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Container(
                    //color: Colors.blue,
                    child: _calendarCarouselNoHeader
                        /*
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              child: Text('PREV'),
                              onPressed: () {
                                setState(() {
                                  _targetDateTime = DateTime(
                                      _targetDateTime.year, _targetDateTime.month - 1);
                                  _currentMonth =
                                      DateFormat.yMMM().format(_targetDateTime);
                                });
                              },
                            ),
                            Text(
                              _currentMonth,
                              style: TextStyle(
                                  color: blackColor,
                                  fontSize: large_FontSize,
                                  fontFamily: robotoFontFamily,
                                  fontWeight: semiBold_FontWeight
                              )
                            ),
                            ElevatedButton(
                              child: Text('NEXT'),
                              onPressed: () {
                                setState(() {
                                  _targetDateTime = DateTime(
                                      _targetDateTime.year, _targetDateTime.month + 1);
                                  _currentMonth =
                                      DateFormat.yMMM().format(_targetDateTime);
                                });
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        _calendarCarouselNoHeader
                      ],
                    ),

                         */
                  ),
                ),
                // _calendarCarouselNoHeader,




               // checkAttendanceApproveStatus=="Locked"? Container():

                SizedBox(
                  height: 1,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /*-------prsent-------*/
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getOneHundredGreyColor(),
                            minimumSize: Size(89, 35),
                            side: BorderSide(
                              color: (checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)?
                              getFourHundredGreyColor():presentColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: (){
                            if(checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)
                              {

                              }
                            else
                              {
                                for(var i = 0;i<selectedDate.length;i++)
                                {
                                  dataPassedToSaveAttendance[selectedDate[i]] = "PP";
                                  statusKeep[selectedDate[i]] = "PP";
                                  // print("${selectedDate[i]}${_markedDateMap.events.containsKey(selectedDate[i])}");
                                  setState(() {
                                    _markedDateMap.events[selectedDate[i]] = [Event(
                                      date: selectedDate[i],
                                      title: 'PP',
                                      icon: _presentIcon(
                                        selectedDate[i].day.toString(),
                                      ),
                                    )];
                                  });
                                }
                                selectedDate.clear();
                                addUpdatedAttendance();
                                serViceBodyRequestForSaveEmployerAttendance();
                              }
                          },
                          child: Text("Present",
                            style: TextStyle(
                                fontFamily: robotoFontFamily,
                                fontSize: small_FontSize,
                                fontWeight: semiBold_FontWeight,
                                color: (checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)?
                                getFourHundredGreyColor():presentColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),

                        /*-------absent-------*/

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getOneHundredGreyColor(),
                            minimumSize: Size(89, 35),
                            side: BorderSide(
                              color: (checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)?
                              getFourHundredGreyColor():absentColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: (){
                            if(checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)
                              {

                              }
                            else
                              {
                                for(var i = 0;i<selectedDate.length;i++)
                                {
                                  // print("${selectedDate[i]}${_markedDateMap.events.containsKey(selectedDate[i])}");
                                  setState(() {
                                    dataPassedToSaveAttendance[selectedDate[i]] = "AA";
                                    statusKeep[selectedDate[i]] = "AA";
                                    _markedDateMap.events[selectedDate[i]] = [Event(
                                      date: selectedDate[i],
                                      title: 'AA',
                                      icon: _absentIcon(
                                        selectedDate[i].day.toString(),
                                      ),
                                    )];
                                  });
                                }
                                selectedDate.clear();
                                addUpdatedAttendance();
                                serViceBodyRequestForSaveEmployerAttendance();
                              }
                          },
                          child: Text("Absent",style: TextStyle(
                              fontFamily: robotoFontFamily,
                              fontSize: small_FontSize,
                              fontWeight: semiBold_FontWeight,
                              color: (checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)?
                              getFourHundredGreyColor():absentColor,
                          ),),
                        ),
                        SizedBox(
                          width: 20,
                        ),

                        /*-------half day-------*/

                      /*  ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getOneHundredGreyColor(),
                            minimumSize: Size(89, 35),
                            side: BorderSide(
                              color: (checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)?
                              getFourHundredGreyColor():halfDayColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: (){
                            if(checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)
                              {

                              }
                            else
                              {
                                for(var i = 0;i<selectedDate.length;i++)
                                {
                                  // print("${selectedDate[i]}${_markedDateMap.events.containsKey(selectedDate[i])}");
                                  setState(() {
                                    dataPassedToSaveAttendance[selectedDate[i]] = "HD";
                                    statusKeep[selectedDate[i]] = "HD";
                                    _markedDateMap.events[selectedDate[i]] = [Event(
                                      date: selectedDate[i],
                                      title: 'HD',
                                      icon: _halfDayIcon(
                                        selectedDate[i].day.toString(),
                                      ),
                                    )];
                                  });
                                }
                                selectedDate.clear();
                                addUpdatedAttendance();
                                serViceBodyRequestForSaveEmployerAttendance();
                              }
                          },
                          child: Text("Half day",style: TextStyle(
                              fontFamily: robotoFontFamily,
                              fontSize: small_FontSize,
                              fontWeight: semiBold_FontWeight,
                              color: (checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)?
                              getFourHundredGreyColor():halfDayColor,
                          ),),

                        ),*/


                        /*-------leave-------*/

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getOneHundredGreyColor(),
                            minimumSize: Size(89, 35),
                            side: BorderSide(
                              color: (checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)?
                              getFourHundredGreyColor():leaveColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: (){
                            if(checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)
                            {

                            }
                            else
                            {
                              for(var i = 0;i<selectedDate.length;i++)
                              {
                                // print("${selectedDate[i]}${_markedDateMap.events.containsKey(selectedDate[i])}");
                                setState(() {
                                  dataPassedToSaveAttendance[selectedDate[i]] = "LL";
                                  statusKeep[selectedDate[i]] = "LL";
                                  _markedDateMap.events[selectedDate[i]] = [Event(
                                    date: selectedDate[i],
                                    title: 'LL',
                                    icon: _leaveIcon(
                                      selectedDate[i].day.toString(),
                                    ),
                                  )];
                                });
                              }
                              selectedDate.clear();
                              addUpdatedAttendance();
                              serViceBodyRequestForSaveEmployerAttendance();
                            }
                          },
                          child: Text("Leave",
                            style: TextStyle(
                              fontFamily: robotoFontFamily,
                              fontSize: small_FontSize,
                              fontWeight: semiBold_FontWeight,
                              color: (checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)?
                              getFourHundredGreyColor():leaveColor,
                            ),
                          ),

                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),



                SizedBox(
                  height: 20,
                ),

                //checkAttendanceApproveStatus=="Locked"? Container():
                widget.payoutSettingStatus==kEmployerAttendance_PayoutSettingStatus?
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
                    child: Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100, 50),
                                  side: BorderSide(
                                    color: (checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)?
                                    getFourHundredGreyColor():Color(0xff33b8fd),
                                  ),
                                  backgroundColor: (checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)?
                                  getOneHundredGreyColor():Color(0xff33b8fd),
                                  //darkBlueColor,

                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)), //////// HERE
                                ),
                                onPressed: () {
                                  if(checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)
                                    {

                                    }
                                  else
                                    {
                                      serViceBodyRequestForApproveEmployerAttendance();
                                    }

                                },
                                child: Text("Approve Attendance",
                                  style: TextStyle(
                                      fontSize: large_FontSize,
                                      fontFamily: robotoFontFamily,
                                      fontWeight: semiBold_FontWeight,
                                    color: (checkAttendanceApproveStatus == "Locked" || buttonStatusOnReLeaveDay == false)?
                                    getFourHundredGreyColor():whiteColor,
                                  ),
                                )
                            )
                        )
                      ],
                    ),
                    // Wrap(
                    //   alignment:WrapAlignment.spaceBetween,
                    //   //crossAxisAlignment: WrapCrossAlignment.end,
                    //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   //runSpacing: 5.0,
                    //   spacing: 10.0,
                    //   children: [
                    //     ElevatedButton(
                    //         style: ElevatedButton.styleFrom(
                    //           minimumSize: Size(100, 50),
                    //           backgroundColor: Colors.blue,
                    //           //darkBlueColor,
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius:
                    //               BorderRadius.circular(10)), //////// HERE
                    //         ),
                    //         onPressed: () {
                    //           serViceBodyRequestForSaveEmployerAttendance();
                    //         },
                    //         child: Text("Mark Attendence")),
                    //
                    //     ElevatedButton(
                    //         style: ElevatedButton.styleFrom(
                    //           minimumSize: Size(100, 50),
                    //           //backgroundColor: Color(0xffA6A6A6),
                    //           backgroundColor: approveBtnColor,
                    //
                    //           //darkBlueColor,
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius:
                    //               BorderRadius.circular(10)), //////// HERE
                    //         ),
                    //         onPressed: ()
                    //         {
                    //           /*---------18-1-2023 start(navin)----------*/
                    //           if(checkAttendanceApproveStatus==getAttendanceStatusLocked)
                    //           {
                    //             //only display the message
                    //
                    //             if(checkAttendanceApproveMessage == "" || checkAttendanceApproveMessage == null)
                    //             {
                    //             }
                    //             else
                    //             {
                    //               CJSnackBar(context, checkAttendanceApproveMessage);
                    //             }
                    //
                    //           }
                    //           else
                    //           {
                    //             if(DateTime.now().year == int.parse(yearOfAttendance.toString()) && DateTime.now().month == int.parse(monthOfAttendance.toString()))
                    //             {
                    //               if (DateTime.now().day == DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day)
                    //               {
                    //                 showDialog(context: context, builder: (_) => approveAttendanceDialogBox());
                    //               }
                    //
                    //               else
                    //               {
                    //                 serViceBodyRequestForApproveEmployerAttendance(kEmployer_Attendance_ApproveBulkAttendance_ActionValue, attendanceToApprove);
                    //               }
                    //             }
                    //             else if((DateTime.now().year == int.parse(yearOfAttendance.toString()) &&
                    //                 int.parse(monthOfAttendance.toString()) < DateTime.now().month) ||
                    //                 DateTime.now().year > int.parse(yearOfAttendance.toString()))
                    //             {
                    //               showDialog(context: context, builder: (_)=>approveAttendanceDialogBox());
                    //             }
                    //           }
                    //         },
                    //         child: Text("Approve Attendance"))
                    //   ],
                    // ),
                  ),
                ):Container()
              ],
            ),
          )
      ),
    );

  }

  monthChanged(DateTime currentPage)
  {
    //if(prevMonth != currentPage) {
      //prevMonth = currentPage;
      setState(() {
      monthOfAttendance = currentPage.month;
      yearOfAttendance = currentPage.year;
      if (monthOfAttendance == DateTime
          .now()
          .month && yearOfAttendance == DateTime
          .now()
          .year) {
        dayOfAttendance = DateTime
            .now()
            .day;
      }
      else {
        dayOfAttendance = currentPage.day;
      }
      presentDates.clear();
      absentDates.clear();
      halfDayDates.clear();
      hoLiDayDates.clear();
      leaveDates.clear();
      /*-------- Start Date 22 March 2023 -------------------*/
      _markedDateMap = EventList<Event>(
        events: {},
      );
      /*-------- End Date 22 March 2023 -------------------*/
      lockStatus = "";
      attendanceToLock.clear();
      dataPassedToSaveAttendance.clear();
      attendanceToApprove.clear();
      attendanceUpdate.clear();
      statusKeep.clear();
      checkAttendanceApproveStatus = "";
      checkAttendanceApproveMessage = "";
      approvalStatusOfAttendance = "";
      payOutDate = "";
      approvalStatus.clear();
      statusKeepForLock.clear();
      serviceBodyRequestforGetEmployerAttendance();
      print("Counter ${++counter}");
      //addDateOfReleiveing(widget.dateOfReleiving.toString());
      });
      print("Current Month and year ${currentPage.month} ${currentPage.year}");
   // }
  }

  Widget markerRepresent(Color color, String data) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        radius: cHeight! * 0.022,
      ),
      title: new Text(
        data,
      ),
    );
  }




  /*-----------18-1-2023 start(navin)-----------*/

  /*
  Dialog approveAttendanceDialogBox()
  {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child:
      approveAttendanceDialogBoxChild(),
    );
  }

  approveAttendanceDialogBoxChild() =>
      Container(
          width: 300,
          height: 170,
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(children: [
            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 25, top: 8),
              child: Container(
                width: 200,
                height: 80,
                child: Text(
                  "Do you confirm that you want to pay your employees based on the attendance approved?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black,fontFamily: robotoFontFamily,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Center(
                child: Padding(padding: EdgeInsets.only(left: 70,top: 12),child: Row(children: [
                  InkWell(
                    onTap: ()
                    {
                      Navigator.of(context).pop();
                      serViceBodyRequestForApproveEmployerAttendance(kEmployer_Attendance_LockAttendance_ActionValue,attendanceToLock);
                    },
                    child: Text(
                      "YES",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: Colors.blueAccent),
                    ),
                  ),
                  SizedBox(width: 60,),

                  InkWell(
                    onTap: ()
                    {
                      Navigator.of(context).pop();
                      serViceBodyRequestForApproveEmployerAttendance(kEmployer_Attendance_ApproveBulkAttendance_ActionValue,attendanceToApprove);
                    },
                    child: Text(
                      "NO",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: Colors.blueAccent),
                    ),
                  )
                ],),))
          ]));

*/


  /*-----------18-1-2023 end(navin)-----------*/


  dategetter(DateTime date)
  {
    print("Month Current in header ${date.month}");
  }



  serviceBodyRequestforGetEmployerAttendance()
  {
    var emp_code = widget.empcode;
    var month = monthOfAttendance.toString();
    var year = yearOfAttendance.toString();
    var mapObj = getEmployer_MonthlyAttendance_RequestBody(emp_code!,month,year);
    serviceRequestForGetEmployerAttendance(mapObj);
  }

  serviceRequestForGetEmployerAttendance(Map mapObj)
  {
    print("show the request2");
    print("show the request object $mapObj");
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj, JG_ApiMethod_Employer_AttendanceCalendar_GetMonthlyAttendance,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          var modelclasss = modelResponse as Employer_NewWorkPlaceAttendanceCalendar_Get_MonthlyAttendance_ModelClass;
          print("Status get In Success");
          var relieveingDate;
          attendanceData = modelclasss.data!;
          presentDates.clear();
          absentDates.clear();
          halfDayDates.clear();
          hoLiDayDates.clear();
          leaveDates.clear();

          for(var i = 0; i<attendanceData.length;i++)
          {


            var manageLockUnlockStatus=0;
            var lockedStatus="";

            var attendanceType = attendanceData[i].attendanceType;
            //print("Attendance Type = $attendanceType");
            //print("AttendanceDate ${attendanceData[i].attyear} ${attendanceData[i].attmonth} ${attendanceData[i].attday}");

            var year = int.parse(attendanceData[i].attyear.toString());
            var month = int.parse(attendanceData[i].attmonth.toString());
            var day = int.parse(attendanceData[i].attday.toString());

            lockStatus = attendanceData[i].lockstatus;


            /*-------------21-3-2023 start---------------*/
            //var joiningDate = attendanceData[i].dateofjoining;
            // relieveingDate = attendanceData[i].dateofrelieveing;
            //addDateOfJoining(joiningDate!);
            /*-------------21-3-2023 end---------------*/

            approvalStatus[DateTime(year,month,day)] = attendanceData[i].approvalStatus;
            statusKeepForLock[DateTime(year,month,day)] = "${attendanceData[i].lockstatus}";

             //print("Releaving Date ${attendanceData[i].dateofrelieveing}");
            payOutDate = attendanceData[i].payoutday!;

            /*---------18-1-2023 start(navin)----------*/
            var  selectedAttendanceApproveStatus=attendanceData[i].lockstatus!;
            checkAttendanceApproveMessage=attendanceData[i].lockmessage!;

            if(selectedAttendanceApproveStatus==getAttendanceStatusLocked)
            {
              //change the color code(Grey)

              approveBtnColor=darkGreyColor;
              checkAttendanceApproveStatus=selectedAttendanceApproveStatus;
              lockedStatus=selectedAttendanceApproveStatus;
              manageLockUnlockStatus=1;

            }
            else
            {
              //change the color code(Orange)
              if(manageLockUnlockStatus==1)
              {
                approveBtnColor=darkGreyColor;
                checkAttendanceApproveStatus=lockedStatus;
              }
              else
              {
                approveBtnColor=Colors.orange;
                checkAttendanceApproveStatus=selectedAttendanceApproveStatus;
              }
            }
            /*---------18-1-2023 end(navin)----------*/


            if(attendanceType == "PP")
            {
              presentDates.add(DateTime(year,month,day));
            }
            else if(attendanceType == "AA")
            {
              absentDates.add(DateTime(year,month,day));
            }
            else if(attendanceType == "HD")
            {
              halfDayDates.add(DateTime(year,month,day));
            }
            else if(attendanceType == "LL")
            {
              leaveDates.add(DateTime(year,month,day));
            }
            else if(attendanceType == "HO")
            {
              hoLiDayDates.add(DateTime(year,month,day));
            }
          }
          //setState(() {


            /*-------------21-3-2023 start---------------*/
            //print("show the relieveingDate $relieveingDate");
            //addDateOfReleiveing(relieveingDate);

            /*-------------21-3-2023 end---------------*/

            adddata();

         // });



        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          print("Failure Block");
          setState((){

            checkAttendanceApproveMessage="";
          });

          CJTalentCommonModelClass commonModelObj=commonResponse as CJTalentCommonModelClass;
          if (commonModelObj?.message==null || commonModelObj?.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context, commonModelObj!.message!);
          }
        }));
  }

  serViceBodyRequestForSaveEmployerAttendance()
  {
    var emp_code = widget.empcode.toString();
    List<Map<String,dynamic>> attendanceList = attendanceUpdate;
    var createdby = widget.liveModelObj?.employerId;
    var customerAccountId = widget.liveModelObj!.tpAccountId;
    var mapObj = saveEmployer_MonthlyAttendance_RequestBody(emp_code, attendanceList, createdby, customerAccountId,kEmployer_Attendance_SaveBulkAttendance_ActionValue);


    /*--------19-1-2023 start---------*/
    if(attendanceUpdate.isNotEmpty)
    {
      serviceRequestForSaveEmployerAttendance(mapObj);
    }
    /*--------19-1-2023 end---------*/

  }

  serviceRequestForSaveEmployerAttendance(Map mapObj)
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj, JG_ApiMethod_Employer_AttendanceCalendar_SaveMonthlyAttendance,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {

          EasyLoading.dismiss();

          var modelclasss = modelResponse as Employer_NewWorkPlaceAttendanceCalender_SaveMonthlyAttendance_ModelClass;
          var data = modelclasss.data;
          if(data?.statusCode == true)
          {
            /*--------19-1-2023 start---------*/
            attendanceUpdate.clear();
            dataPassedToSaveAttendance.clear();
            adddata();
            print("Attendance Update $attendanceUpdate");
            serviceBodyRequestforGetEmployerAttendance();

            /*--------19-1-2023 end---------*/

            CJSnackBar(context, data!.message.toString());

          }
          else
          {
            CJSnackBar(context, data!.message.toString());
          }
        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonModelObj=commonResponse as CJTalentCommonModelClass;
          if (commonModelObj?.message==null || commonModelObj?.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context, commonModelObj!.message!);
          }

        }));

  }

  serViceBodyRequestForApproveEmployerAttendance()
  {
    var emp_code =widget.empcode.toString();
    List<Map<String,dynamic>> attendanceList = attendanceToApprove;
    var createdby = widget.liveModelObj?.employerId;
    var customerAccountId = widget.liveModelObj!.tpAccountId;
    var mapObj = saveEmployer_MonthlyAttendance_RequestBody(emp_code, attendanceList, createdby, customerAccountId,kEmployer_Attendance_ApproveBulkAttendance_ActionValue);
    print("Map Data Passed $mapObj");
    if(attendanceToApprove.isNotEmpty)
    {
      if(payOutDate == null || payOutDate == "")
      {
        CJSnackBar(context, "Please set the payoutdate");
      }
      else
      {
        serviceRequestForApproveEmployerAttendance(mapObj);
      }
    }
    else
    {
      // CJSnackBar(context, "No Attendance To Approve");
    }
  }

  serviceRequestForApproveEmployerAttendance(Map mapObj)
  {
    print("show the request2");
    print("show the request object $mapObj");


    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj, JG_ApiMethod_Employer_AttendanceCalendar_SaveMonthlyAttendance,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          var modelclasss = modelResponse as Employer_NewWorkPlaceAttendanceCalender_SaveMonthlyAttendance_ModelClass;
          var data = modelclasss.data;
          if(data?.statusCode == true){
            CJSnackBar(context, data!.message.toString());

            /*---------19-1-2023 start--------*/
            attendanceToLock.clear();
            attendanceToApprove.clear();
            serviceBodyRequestforGetEmployerAttendance();

            /*---------19-1-2023 end--------*/

          }
          else{
            CJSnackBar(context, data!.message.toString());
          }
        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {

          EasyLoading.dismiss();

          CJTalentCommonModelClass commonModelObj=commonResponse as CJTalentCommonModelClass;
          if (commonModelObj?.message==null || commonModelObj?.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context, commonModelObj!.message!);
          }
        }));

  }





}



