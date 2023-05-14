

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';


import '../../../../Constant/CJAppFlowConstants.dart';
import '../../../../Constant/ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
import '../../../../CustomView/CJHubCustomView/palatte_Textstyle.dart';
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../Services/CJJobSeekerService/CJJobSeekerServiceRequest.dart';
import '../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../Services/CJTalentsService/CJTalentServiceURL.dart';
import '../../../../Services/Messages/Message.dart';
import '../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../TankhaPayModelClasses/TankhaPayAttendanceTabsModelClass/TankhaPayAttendanceModelClass.dart';
import '../../TankhaPayModelClasses/TankhaPayAttendanceTabsModelClass/TankhaPaySaveAttendanceModelClass.dart';


class TankhaPayCalendarAttendance extends StatefulWidget

{
  const TankhaPayCalendarAttendance({Key? key,
    required this.empCode, required this.mobileNo, required this.dateOfBirth, required this.customerAccountNo, required this.jsId,required this.doj
  }) : super(key: key);
  final String empCode;
  final String mobileNo;
  final String dateOfBirth;
  final String customerAccountNo;
  final String jsId;
  final String doj;


  @override
  _TankhaPayCalendarAttendance createState() => _TankhaPayCalendarAttendance();

}


Color presentColor = Color(0xff01a14b);
Color absentColor = Color(0xfffe0000);
Color halfDayColor = Color(0xff8dc53e);
Color leaveColor = Color(0xfff5b259);
Color hoLiDayColor = Color(0xff22409a);
Color clearColor = Color(0xffcdcdcd);


List<DateTime> presentDates = [];
List<DateTime> absentDates = [];
List<DateTime> halfDayDates = [];

List<DateTime> hoLiDayDates = [];

List<DateTime> leaveDates = [];

List<DateTime> selectedDate =[];



class _TankhaPayCalendarAttendance extends State<TankhaPayCalendarAttendance>

{


  DateTime _currentDate2 = DateTime.now();

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




  CalendarCarousel _calendarCarouselNoHeader = CalendarCarousel();
  List<Data> attendanceData = [];

  var len = min(absentDates.length, presentDates.length);
  double? cHeight;
  var lockStatus;
  Map<DateTime,dynamic> approvalStatus = {};
  var  monthOfAttendance = DateTime.now().month;
  var yearOfAttendance = DateTime.now().year;
  List dateOfJoining = [];

  List<Map<String,dynamic>> attendanceUpdate = [];
  Map<DateTime,dynamic> dataPassedToSaveAttendance = {};


  addDateOfJoining(String joiningDate)

  {
    if(joiningDate == "" || joiningDate == null)
    {
      dateOfJoining.add(DateTime.now().year);
      dateOfJoining.add(DateTime.now().month);
      dateOfJoining.add(DateTime.now().day);
    }
    else
    {
      var dates = joiningDate.split('/');
      dateOfJoining.add(int.parse(dates[2]));
      dateOfJoining.add(int.parse(dates[1]));
      dateOfJoining.add(int.parse(dates[0]));
    }
  }



  adddata()
  {
    /*-------- Start Date 22 March 2023 -------------------*/
    _markedDateMap = EventList<Event>(
      events: {},
    );

    /*-------- End Date 22 March 2023 -------------------*/

    for (int i = 0; i < presentDates.length; i++) {
      statusKeep[presentDates[i]] = "PP";
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
    }

    for (int i = 0; i < absentDates.length; i++) {
      statusKeep[absentDates[i]] = "AA";
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
    }
    for (int i = 0; i < halfDayDates.length; i++) {
      statusKeep[halfDayDates[i]] = "HD";
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
    }
    for (int i = 0; i < hoLiDayDates.length; i++) {
      statusKeep[hoLiDayDates[i]] = "HO";
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
    }

    for (int i = 0; i < leaveDates.length; i++) {
      statusKeep[leaveDates[i]] = "LL";
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
    }
    print("Status Keeper $statusKeep");
    print("marked Map${_markedDateMap.events}");
  }


  addUpdatedAttendance(){
    attendanceUpdate.clear();
    dataPassedToSaveAttendance.forEach((key, value) {
      var boolean = false;
      //statusKeep[key] == "A";

      if(!boolean){
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
        print("Date passed : $date");
        var attenData = value;
        print("Attendata $attenData");
        attendanceUpdate.add(
            {
              "attendancedate": "${date.toString()}",
              "attendancetype": "${attenData.toString()}"
            }
        );
        print("Attendance Data: $attendanceUpdate");
      }
    });

    /*-----------4-3-2023 start---------*/
    serviceBodyRequestforSaveAttendance();
    /*-----------4-3-2023 end---------*/


  }

  @override
  void initState() {

    //dateOfJoining=widget.doj;

    print("show the dateOfJoining ${widget.doj}");
    serviceBodyRequestforGetAttendance();
    addDateOfJoining(widget.doj);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


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

        else if(events.isNotEmpty && !selectedDate.contains(day) && approveStatus)
       // else if(events.isNotEmpty && !selectedDate.contains(day))//4-3-2023 start

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

      //pageScrollPhysics: NeverScrollableScrollPhysics(),
      isScrollable: false,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateIconMargin: 0.0,
      daysHaveCircularBorder: false,
      todayBorderColor: Colors.grey,
      todayButtonColor: Colors.transparent,
      todayTextStyle: TextStyle(
          color: Colors.black
      ),
      // pageScrollPhysics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      thisMonthDayBorderColor: Colors.grey,
      minSelectedDate: DateTime(dateOfJoining[0],dateOfJoining[1],dateOfJoining[2]),
      maxSelectedDate: DateTime.now(),
      // viewportFraction: 1,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal: null,
      showOnlyCurrentMonthDate: true,
      onCalendarChanged: monthChanged,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );

    return new Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _calendarCarouselNoHeader,
                ),

                SizedBox(
                  height: 1,
                ),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        /*------present-------*/
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getOneHundredGreyColor(),
                            minimumSize: Size(89, 35),
                            side: BorderSide(
                              color: lockStatus != "Locked"?
                              presentColor:getFourHundredGreyColor(),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: (){
                            if(lockStatus != "Locked")
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

                            }
                            else
                            {

                            }
                          },
                          child: Text("Present",
                            style: TextStyle(
                              fontFamily: robotoFontFamily,
                              fontSize: small_FontSize,
                              fontWeight: semiBold_FontWeight,
                              color: lockStatus != "Locked"?
                              presentColor:getFourHundredGreyColor(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),

                        /*------absent-------*/

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getOneHundredGreyColor(),
                            minimumSize: Size(89, 35),
                            side: BorderSide(
                              color: lockStatus != "Locked"?
                              absentColor:getFourHundredGreyColor(),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: (){
                            if(lockStatus != "Locked")
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

                            }
                            else
                            {

                            }
                          },
                          child: Text("Absent",style: TextStyle(
                            fontFamily: robotoFontFamily,
                            fontSize: small_FontSize,
                            fontWeight: semiBold_FontWeight,
                            color: lockStatus != "Locked"?
                            absentColor:getFourHundredGreyColor(),
                          ),),
                        ),
                        SizedBox(
                          width: 20,
                        ),

                        /*----------leave---------*/
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getOneHundredGreyColor(),
                            minimumSize: Size(89, 35),
                            side: BorderSide(
                              color: lockStatus != "Locked"?
                              leaveColor:getFourHundredGreyColor(),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: (){
                            if(lockStatus != "Locked")
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

                            }
                            else
                            {

                            }
                          },
                          child: Text("Leave",
                            style: TextStyle(
                              fontFamily: robotoFontFamily,
                              fontSize: small_FontSize,
                              fontWeight: semiBold_FontWeight,
                              color: lockStatus != "Locked"?
                              leaveColor:getFourHundredGreyColor(),
                            ),
                          ),

                        )

                        /*------half day 14-3-2023-------*/

                       /* ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getOneHundredGreyColor(),
                            minimumSize: Size(89, 35),
                            side: BorderSide(
                              color: lockStatus != "Locked"?
                              halfDayColor:getFourHundredGreyColor(),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: (){
                            if(lockStatus != "Locked")
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

                            }
                            else
                            {

                            }
                          },
                          child: Text("Half day",style: TextStyle(
                            fontFamily: robotoFontFamily,
                            fontSize: small_FontSize,
                            fontWeight: semiBold_FontWeight,
                            color: lockStatus != "Locked"?
                            halfDayColor:getFourHundredGreyColor(),
                          ),),

                        ),*/
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                   /*-------14-3-2023 start--------*/
                   /* Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        *//*------leave-------*//*

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getOneHundredGreyColor(),
                            minimumSize: Size(89, 35),
                            side: BorderSide(
                              color: lockStatus != "Locked"?
                              leaveColor:getFourHundredGreyColor(),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: (){
                            if(lockStatus != "Locked")
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

                            }
                            else
                            {

                            }
                          },
                          child: Text("Leave",
                            style: TextStyle(
                              fontFamily: robotoFontFamily,
                              fontSize: small_FontSize,
                              fontWeight: semiBold_FontWeight,
                              color: lockStatus != "Locked"?
                              leaveColor:getFourHundredGreyColor(),
                            ),
                          ),

                        ),
                        SizedBox(
                          width: 20,
                        ),

                        *//*------holiday-------*//*

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getOneHundredGreyColor(),
                            minimumSize: Size(89, 35),
                            side: BorderSide(
                              color: lockStatus != "Locked"?
                              hoLiDayColor:getFourHundredGreyColor(),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: (){
                            if(lockStatus != "Locked")
                            {
                              for(var i = 0;i<selectedDate.length;i++)
                              {
                                // print("${selectedDate[i]}${_markedDateMap.events.containsKey(selectedDate[i])}");
                                setState(() {
                                  dataPassedToSaveAttendance[selectedDate[i]] = "HO";
                                  statusKeep[selectedDate[i]] = "HO";
                                  _markedDateMap.events[selectedDate[i]] = [Event(
                                    date: selectedDate[i],
                                    title: 'HO',
                                    icon: _holidayIconIcon(
                                      selectedDate[i].day.toString(),
                                    ),
                                  )];
                                });
                              }
                              selectedDate.clear();
                              addUpdatedAttendance();

                            }
                            else
                            {

                            }
                          },
                          child: Text("Holiday",style: TextStyle(
                            fontFamily: robotoFontFamily,
                            fontSize: small_FontSize,
                            fontWeight: semiBold_FontWeight,
                            color: lockStatus != "Locked"?
                            hoLiDayColor:getFourHundredGreyColor(),
                          ),),

                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 35,
                          width: 89,
                        )
                      ],
                    ),*/

                    /*-------14-3-2023 end--------*/

                  ],
                ),


                SizedBox(
                  height: 20,
                ),

                //lockStatus == "Locked"? Container():
                /*------------4-3-2023 start-------------*/
             /*   Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(100, 50),
                        side: BorderSide(
                          color: lockStatus != "Locked"?
                          Color(0xff33b8fd):getFourHundredGreyColor(),
                        ),
                        backgroundColor: lockStatus != "Locked"?
                        Colors.blue : getOneHundredGreyColor(),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        serviceBodyRequestforSaveAttendance();
                      },
                      child: Text("Mark Attendence",
                        style: TextStyle(
                          color: lockStatus != "Locked"?
                          whiteColor : getFourHundredGreyColor(),
                        ),
                      )),
                ),*/

                /*------------4-3-2023 end-------------*/

                SizedBox(
                  height: 20,
                )
              ],
            ),
          )
      ),
    );

  }

  monthChanged(DateTime currentpage)
  {
    setState(() {
      monthOfAttendance = currentpage.month;
      yearOfAttendance = currentpage.year;
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
      serviceBodyRequestforGetAttendance();
    });
    print("Current Month and year ${currentpage.month} ${currentpage.year}");
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




  serviceBodyRequestforGetAttendance()
  {
    var month = monthOfAttendance.toString();
    var year = yearOfAttendance.toString();
    var mapObj = get_MonthlyAttendance_RequestBody(
        widget.empCode,widget.mobileNo,widget.dateOfBirth,
        month,year
    );

    print("Map Data Passed $mapObj");
    serviceRequestForGetAttendance(mapObj);
  }


  serviceRequestForGetAttendance(Map mapObj)
  {
    print("show the request2");
    print("show the request object $mapObj");
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.TankhaPay_ApiMethod_get_MonthlyAttendance,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          print("success in Attendance");
          var modelclasss = success as TankhaPayAttendanceModelClass;
          //getMonthlyAttendance model = modelclasss["commonData"] as getMonthlyAttendance;
          print("Success");
          attendanceData = modelclasss.data!;
          print("Massege in request : $attendanceData");
          //addData(data as List<Data>);
          print("Attendance List length ${attendanceData.length}");
          presentDates.clear();
          absentDates.clear();
          halfDayDates.clear();
          hoLiDayDates.clear();
          leaveDates.clear();
          for(var i = 0; i<attendanceData.length;i++)
          {
            var attendanceType = attendanceData[i].attendanceType;
            print("Attendance Type = $attendanceType");
            print("AttendanceDate ${attendanceData[i].attyear} ${attendanceData[i].attmonth} ${attendanceData[i].attday}");
            var year = int.parse(attendanceData[i].attyear.toString());
            var month = int.parse(attendanceData[i].attmonth.toString());
            var day = int.parse(attendanceData[i].attday.toString());
            var joiningDate = attendanceData[i].dateofjoining;
            lockStatus = attendanceData[i].lockstatus;
            addDateOfJoining(joiningDate!);
            approvalStatus[DateTime(year,month,day)] = attendanceData[i].approvalStatus;
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
          setState(() {
            adddata();
          });

        }, talentFailureBlock:<T>(failure)
        {
          print("show the request failure");
          EasyLoading.dismiss();

          var tankhaPayModelObj=failure as CJTalentCommonModelClass;
          if (tankhaPayModelObj!.message==null || tankhaPayModelObj!.message=="")
          {
            CJSnackBar(context, "server1 1111 error!");
          }else {
            CJSnackBar(context, tankhaPayModelObj!.message!);
          }

        }, talentHandleExceptionBlock: <T>(handleException)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= handleException as CJTalentCommonModelClass;
          CJSnackBar(context,commonObject!.message as String);

        }));
  }


  serviceBodyRequestforSaveAttendance()
  {

    List<Map<String,dynamic>> attendanceList = attendanceUpdate;
    var mapObj = save_MonthlyAttendance_RequestBody(attendanceList,
        widget.empCode,widget.mobileNo,
        widget.dateOfBirth,widget.customerAccountNo,widget.jsId
    );
    print("Map Data Passed $mapObj");

    if(attendanceUpdate.isNotEmpty)
    {
      serviceRequestforSaveAttendance(mapObj);
    }
  }

  serviceRequestforSaveAttendance(Map mapObj)
  {
    print("show the request2");
    print("show the request object $mapObj");

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.TankhaPay_ApiMethod_save_MonthlyAttendance,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();


          var modelclasss = success as TankhaPaySaveAttendanceModelClass;
          print("Success");
          var data = modelclasss.data;
          print("Massege in request save Attendance: ${data?.statusCode}");
          if(data?.statusCode == true){

            attendanceUpdate.clear();
            dataPassedToSaveAttendance.clear();

            CJSnackBar(context, modelclasss.message.toString());
          }
          else{
            CJSnackBar(context, modelclasss.message.toString());
          }
          // attendanceUpdate.clear();
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

}


