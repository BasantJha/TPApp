
import 'dart:math';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

const personImage = AssetImage(Employer_Icon_ProfileGrey);
const gClr = Color(0xffF4F4F4);

List presentDates = [];
List absentDates = [];
List halfDates = [];

var newDateData = <DateTime, String>{
  DateTime(2022, 11, 2): "present",
  DateTime(2022, 11, 3): "present",
  DateTime(2022, 11, 4): "present",
  DateTime(2022, 11, 5): "absent",
  DateTime(2022, 11, 6): "absent",
  DateTime(2022, 11, 7): "present",
  DateTime(2022, 11, 8): "present",
  DateTime(2022, 11, 9): "half",
  DateTime(2022, 11, 10): "present",
};

class Employer_WorkPlace_MarkAttendanceCalendar extends StatefulWidget {
  final String? image;
  final String? name;
  const Employer_WorkPlace_MarkAttendanceCalendar({super.key, this.image, this.name});

  @override
  State<Employer_WorkPlace_MarkAttendanceCalendar> createState() => _Employer_WorkPlace_MarkAttendanceCalendar();
}

class _Employer_WorkPlace_MarkAttendanceCalendar extends State<Employer_WorkPlace_MarkAttendanceCalendar> {
  String? Img;
  String? Name;

  List<DateTime>? tempPDS = [];
  var nDD = newDateData;

  // List

  @override
  void initState() {
    super.initState();
    Img = widget.image;
    Name = widget.name;

    print("show the new view");
  }

  DateTime _currentDate = DateTime.now();

  CalendarCarousel? _calendarCarouselNoHeader;

  var len = min(absentDates.length, presentDates.length);
  double? cHeight;

   Widget _presentIcon(String day) => Container(
    color: Color(0xff7FC26E),
    child: Text(
      day,
      style: TextStyle(color: Colors.black),
    ),
  );

   Widget _absentIcon(String day) => Container(
      color: Color(0xffD84647),
      child: Text(
        day,
        style: TextStyle(color: Colors.black),
      ));

   Widget _halfdayicon(String day) => Container(
      color: Color(0xffFFA800),
      child: Text(
        day,
        style: TextStyle(color: Colors.black),
      ));

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );
  EventList<Event> _markedDateMap2 = new EventList<Event>(
    events: {},
  );

  @override
  Widget build(BuildContext context)
  {
    cHeight = MediaQuery.of(context).size.height;
    /*for (int i = 0; i < presentDates.length; i++)
    {
      // print("present loop $i");
      _markedDateMap.add(
          presentDates[i],
          new Event(
              date: presentDates[i],
              title: 'Event 5',
              icon: _presentIcon(presentDates[i].day.toString())));
    }

    for (int i = 0; i < absentDates.length; i++) {
      _markedDateMap.add(
        absentDates[i],
        new Event(
          date: absentDates[i],
          title: 'Event 5',
          icon: _absentIcon(
            absentDates[i].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < halfDates.length; i++) {
      _markedDateMap.add(
        halfDates[i],
        new Event(
          date: halfDates[i],
          title: 'Event 5',
          icon: _halfdayicon(
            halfDates[i].day.toString(),
          ),
        ),
      );
    }*/

    nDD.forEach((key, value)
    {
      //widget=
      print("show the load data $nDD");
      var ndate = key;
      if (value == 'present')
      {
        _markedDateMap2.add(
            ndate,
            new Event(
                date: ndate,
                title: "present",
                icon: _presentIcon(ndate.day.toString())));
      }
      if (value == 'absent')
      {
        _markedDateMap2.add(
            ndate,
            new Event(
                date: ndate,
                title: "absent",
                icon: _absentIcon(ndate.day.toString())));
      }
      if (value == 'half')
      {
        _markedDateMap2.add(
            ndate,
            new Event(
                date: ndate,
                title: "half",
                icon: _halfdayicon(ndate.day.toString())));
      }

      print("show the load _markedDateMap2: $_markedDateMap2");

    });


    // print("absent dates = $absentDates");
    // print("present dates = $presentDates");
    // print("marked dates = $_markedDateMap");

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: cHeight! * 0.6,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      markedDateIconMargin: 0.0,
      todayButtonColor: Colors.blue,
      markedDatesMap: _markedDateMap2,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal: null, // null for not showing hidden events indicator
      markedDateIconBuilder: (event)
      {
       /* print("load data again: ${event.date}");
        print("load data again:: ${event.description}");*/
        //print("load data again:: ${event.icon}");

        return event.icon;
      },
      thisMonthDayBorderColor: Colors.grey,
      daysHaveCircularBorder: false,
      onDayPressed: ((p0, p1)
      {
       /* print("show the po selected date ${p0}");
        print("show the p1 selected date ${p1}");
        DateTime obj=p0;
        Event dd=new Event(
            date: p0,);

        _markedDateMap2.remove(obj, dd);*/

        print("show the p1 -p1 records $p1");
        //p1.clear();
        // print("temp dates = $tempPDS");
        // _markedDateMap2.clear();
        tempPDS = [];
        setState(() {
          tempPDS!.add(p0);
          // presentDates.add(p0);
          // absentDates.add(p0);
          // _markedDateMap2.clear();
        });

        // print("temp dates after setstate = $tempPDS");
      }),
    );

    return SafeArea(
      child: Scaffold(backgroundColor: whiteColor,
        appBar:CJAppBar(getEmployer_WorkPlace_MarkAttendance, appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action type");
          Navigator.pop(context);
        })),
        body: getResponsiveUI(),
      ),
    );
  }

  Responsive getResponsiveUI()
  {
    return Responsive(
      mobile: MainfunctionUi(),
      tablet: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(),
        ),
      ),
      desktop: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(),
        ),
      ),
    );
  }
  Column MainfunctionUi()
  {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          //padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),

          child: Card(
            shape: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: darkBlueColor,
              ),
            ),
            color: gClr,
            margin: EdgeInsets.zero,
            elevation: 5,
            child: Padding(padding: const EdgeInsets.only(top: 10,bottom: 10),child: ListTile(
              //tileColor: gClr,
              leading: Image(image: AssetImage(Img.toString())),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Image(image: personImage),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      Name.toString(),
                      style: TextStyle(
                        fontFamily: robotoFontFamily,
                        color: darkBlueColor,
                        fontWeight: bold_FontWeight,
                        fontSize: small_FontSize,
                      ),
                    )
                  ],
                ),
              ),
            ),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _calendarCarouselNoHeader!,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff187A00),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {
                      print("new data before update = $nDD");
                      for (int i = 0; i < tempPDS!.length; i++) {
                        // setState(() {
                        //   presentDates.add(tempPDS![i]);
                        // });

                        nDD.update(tempPDS![i], (value) => "present",
                            ifAbsent: () => "present");
                        setState(() {
                          // newDateData[tempPDS![i].toString()] = "present";
                          // newDateData.remove(tempPDS![i]);
                          // _markedDateMap2.clear();
                          // nDD.update(tempPDS![i], (value) => "present",
                          //     ifAbsent: () => "present");

                          nDD = nDD;
                        });
                      }
                      tempPDS!.clear();
                      print("new data after update = $nDD");
                      print("printing tempPDS = $tempPDS");
                    },
                    child: Text("Present"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFE0000),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: ()
                    {
                      print("new data before update = $nDD");
                      for (int i = 0; i < tempPDS!.length; i++) {
                        // setState(() {
                        //   absentDates.add(tempPDS![i]);
                        // });
                        nDD.update(tempPDS![i], (value) => "absent",
                            ifAbsent: () => "absent");


                        setState(()
                        {
                          // newDateData[tempPDS![i].toString()] = "present";
                          // nDD.update(tempPDS![i], (value) => "absent",
                          //     ifAbsent: () => "absent");
                          nDD = nDD;
                        });
                      }
                      tempPDS!.clear();

                      print("new data after update = $nDD");
                    },
                    child: Text("Absent"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFFA800),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: ()
                    {
                      for (int i = 0; i < tempPDS!.length; i++)
                      {
                        // setState(() {
                        //   halfDates.add(tempPDS![i]);
                        // });
                        setState(()
                        {
                          // newDateData[tempPDS![i].toString()] = "present";
                          nDD.update(tempPDS![i], (value) => "half",
                              ifAbsent: () => "half");
                        });
                      }
                      tempPDS!.clear();
                    },
                    child: Text("Half day"),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 50),
                    backgroundColor: darkBlueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10)), //////// HERE
                  ),
                  onPressed: () {},
                  child: Text("Mark Attendence"))
            ],
          ),
        )
      ],
    );
  }


}

