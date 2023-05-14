
import 'dart:ui';

import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../../Constant/ConstantIcon.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../Constant/ConstantIcon.dart';
import '../../../../../../Constant/Constants.dart';
import 'package:circles_background/circles_background.dart';

import '../../../../../../Constant/Responsive.dart';
import '../../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../../Services/Messages/Message.dart';
import '../../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../EmployerModelClasses/EmployerAttendanceModelClass/Employer_NewWorkPlaceLeaveSettingAttendanceModelClass/Employer_NewWorkPlaceLeaveSettingAttendanceModelClass.dart';
import '../../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'Employer_NewWorkPlaceAttendanceChild.dart';
import 'Employer_NewWorkPlaceCreateLeaveTemplate.dart';

class Employer_NewWorkPlaceLeaveSettingAttendance extends StatefulWidget

{
  const Employer_NewWorkPlaceLeaveSettingAttendance({Key? key, this.liveModelObj}) : super(key: key);
  final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  _Employer_NewWorkPlaceLeaveSettingAttendance createState() => _Employer_NewWorkPlaceLeaveSettingAttendance();
}

class _Employer_NewWorkPlaceLeaveSettingAttendance extends State<Employer_NewWorkPlaceLeaveSettingAttendance>

{
  String calendarIcon =  calendar_White_Icon;


  bool UIShown = false;




  ImageCalender(){
    return  Image.asset(calendarIcon,height: 10,width: 10,);
  }






  var employer_NewWorkPlace_dataList;



  @override
  void initState()

  {
    super.initState();

    serviceRequestMapBody_NewWorkPlaceLeaveSettingAttendance();
  }



  leaveCalendarType(String calendarType)

  {
    return
      Row(
        children: [
          Text("Leaves Calendar :",
            style: TextStyle(
                fontFamily: robotoFontFamily,
                fontSize: medium_FontSize,
                fontWeight: normal_FontWeight,
                color: darkGreyColor
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(child: Text("$calendarType",
            style: TextStyle(
                fontWeight: normal_FontWeight,
                fontSize: medium_FontSize,
                fontFamily: robotoFontFamily
            ),
          ))
        ],
      );
  }


  @override
  Widget build(BuildContext context)

  {
    return SafeArea(
        child: Scaffold(
          // backgroundColor: Colors.grey[100],
          appBar:CJAppBar(getEmployer_AttendanceYearlyLeaveSettings, appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show the action type");
            Navigator.pop(context);
          })) ,

          body: Responsive(
              mobile: MainfunctionUI(),
              tablet:  Center(
                child: Container(
                  width: webResponsive_TD_Width,
                  child: MainfunctionUI(),
                ),
              ),
              desktop: Center(
                child: Container(
                  width: webResponsive_TD_Width,
                  child: MainfunctionUI(),
                ),
              )

          ),
          bottomNavigationBar:Padding(padding: EdgeInsets.only(left: 10,right: 10,bottom: 20,top: 15),
            child: createTheCustomLeaveTemplate(context),
          ) ,
        )
    );
  }
  Container createTheCustomLeaveTemplate(BuildContext context)
  {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 8,right: 8),
      decoration: BoxDecoration(
        border: Border.all(
            color: darkGreyColor
        ),
        gradient: LinearGradient(
          colors: [
            Color(0xfffdfdfd),
            Color(0xffdddddd)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child:  InkWell(onTap: ()
      {
        pushTo(context, Employer_NewWorkPlaceCreateLeaveTemplate(liveModelObj: widget.liveModelObj,));

      },child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Create Custom Template",
            style: TextStyle(
                fontFamily: robotoFontFamily,
                fontSize: large_FontSize,
                fontWeight: normal_FontWeight,
                color: darkBlueColor
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Image.asset(plusIcon,height: 20,width: 20,),
        ],
      ),),
    );
  }

  pushTo<T>(BuildContext context,navigateView)
  {
    Navigator.push(context, MaterialPageRoute(builder: (_)=>

        Responsive(
            mobile: navigateView,
            tablet: Center(
              child: Container(
                width: webResponsive_TD_Width,
                child: navigateView,
              ),
            ),

            desktop: Center(
              child: Container(
                width: webResponsive_TD_Width,
                child: navigateView,
              ),
            )
        )
    )
    ).then((value)
    {
      serviceRequestMapBody_NewWorkPlaceLeaveSettingAttendance();

    });
  }


  //Employer_NewWorkPlaceCreateLeaveTemplate
  SingleChildScrollView MainfunctionUI()

  {
    return SingleChildScrollView(
        child: UIShown == true ?
        Padding(
          padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Select Your Leave Templates",
                    style: TextStyle(
                        fontSize: largeExcel_FontSize,
                        fontWeight: semiBold_FontWeight,
                        fontFamily: robotoFontFamily,
                        color: darkBlueColor
                    ),

                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                ListView.builder(
                    itemCount: employer_NewWorkPlace_dataList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      print("Length Inside UI ${employer_NewWorkPlace_dataList[index].leaveDetails.leaveType.length}");
                      var templateId = employer_NewWorkPlace_dataList[index].templateid.toString();
                      var templateName = employer_NewWorkPlace_dataList[index].templatedesc;
                      var noweeklyOfday = employer_NewWorkPlace_dataList[index].leaveDetails.weeklyOffDays;
                      var weeklyOffDayName = employer_NewWorkPlace_dataList[index].leaveDetails.weeklyOffDaysName;
                      var casualLeave;
                      var medicalLeave;
                      if(employer_NewWorkPlace_dataList[index].leaveDetails.leaveType.length == 1)
                        {
                          if(employer_NewWorkPlace_dataList[index].leaveDetails.leaveType.first.typecode == "CL")
                          {
                            casualLeave = employer_NewWorkPlace_dataList[index].leaveDetails.leaveType.first.days.toString();
                            medicalLeave = "0";
                          }
                          else
                            {
                              casualLeave = "0";
                              medicalLeave = employer_NewWorkPlace_dataList[index].leaveDetails.leaveType.first.days.toString();
                            }
                        }
                      else
                        {
                          if(employer_NewWorkPlace_dataList[index].leaveDetails.leaveType.first.typecode == "CL")
                            {
                              casualLeave = employer_NewWorkPlace_dataList[index].leaveDetails.leaveType[0].days.toString();
                              medicalLeave = employer_NewWorkPlace_dataList[index].leaveDetails.leaveType[1].days.toString();
                            }
                           else
                             {
                               casualLeave = employer_NewWorkPlace_dataList[index].leaveDetails.leaveType[1].days.toString();
                               medicalLeave = employer_NewWorkPlace_dataList[index].leaveDetails.leaveType[0].days.toString();
                          }
                        }

                      var attendanceApproval = employer_NewWorkPlace_dataList[index].leaveDetails.attendanceApprovalRequiredForPayout;
                      var calendarType = employer_NewWorkPlace_dataList[index].leaveDetails.leavesCalender;
                      var defaultemplate = employer_NewWorkPlace_dataList[index].defaultTemplate;
                     /* print("TemplateName $templateName");
                      print("NoofdaysInweek $noweeklyOfday");
                      print("WeeklyOffdays $weeklyOffDayName");
                      print("Casual Leave $casualLeave");
                      print("Medical Leave $medicalLeave");
                      print("Attendance Approval $attendanceApproval");
                      print("Calendar Required $calendarType");
                      print("default Status $defaultemplate");*/
                      var columnobj;
                      if(employer_NewWorkPlace_dataList[index].templatedesc == "Basic"){
                        columnobj =  Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BasicTemplateUI(templateId,templateName,casualLeave,medicalLeave,weeklyOffDayName,noweeklyOfday,calendarType,attendanceApproval,defaultemplate),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      }
                      else if(employer_NewWorkPlace_dataList[index].templatedesc == "Standard"){
                        columnobj = Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            StandardCalendarUI(templateId,templateName,casualLeave,medicalLeave,weeklyOffDayName,noweeklyOfday,calendarType,attendanceApproval,defaultemplate),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      }
                      else{
                        columnobj = Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomUI(templateId,templateName,casualLeave,medicalLeave,weeklyOffDayName,noweeklyOfday,calendarType,attendanceApproval,defaultemplate),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      }
                      return columnobj;

                    }),

              ]
          ),
        ) : Container()
    );
  }

  BasicTemplateUI(String templateID,String templateType,String casualLeaveDays,
      String medicalLeave,String weeklyOffDays,String noOfWeekLeave,String calendar,String attendanceApproval,bool defaultStatus)
  {
    print("Inside Basic Status $defaultStatus");
    var colorOfImageContainer;
    if(templateType == "Basic" )
    {
      colorOfImageContainer = Color(0xff006da5);
    }
    else if(templateType == "Standard")
    {
      colorOfImageContainer = Color(0xffc848c5);
    }
    else
    {
      colorOfImageContainer = Color(0xff535353);
    }
    return
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              padding: EdgeInsets.only(top: 5,bottom: 5,),
              decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border(
                      bottom: BorderSide(
                          width: 3,
                          color: colorOfImageContainer
                      )
                  )
              ),
              child: Card(
                  elevation: 0,
                  child:  Row(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          height:35,
                          width:35,
                          padding:EdgeInsets.all(6.0),
                          child: Container(
                            width: 20,
                            height: 20,
                            child: ImageCalender(),
                          ),
                          decoration: BoxDecoration(
                            color: colorOfImageContainer,
                            shape: BoxShape. circle,
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(templateType,
                              style: TextStyle(
                                  fontSize: medium_FontSize,
                                  fontWeight: semiBold_FontWeight,
                                  fontFamily: robotoFontFamily,
                                  color: darkBlueColor
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("Casual Leave",style: TextStyle(
                                    fontFamily: robotoFontFamily,
                                    fontSize: medium_FontSize,
                                    fontWeight: normal_FontWeight,
                                    color: darkGreyColor
                                ),),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colorOfImageContainer
                                  ),
                                  child: Text(casualLeaveDays,
                                    style: TextStyle(color: Colors.white,fontFamily: robotoFontFamily),),
                                )
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Expanded(child: Container(child: Row(
                                  children: [
                                    Text("Weekly Off",style: TextStyle(
                                        fontFamily: robotoFontFamily,
                                        fontSize: medium_FontSize,
                                        fontWeight: normal_FontWeight,
                                        color: darkGreyColor
                                    ),),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 20,
                                      width: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colorOfImageContainer
                                      ),
                                      child: Text(noOfWeekLeave,
                                        style: TextStyle(color: Colors.white,fontFamily: robotoFontFamily),),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(weeklyOffDays,
                                      style: TextStyle(
                                          fontWeight: normal_FontWeight,
                                          fontSize: medium_FontSize,
                                          fontFamily: robotoFontFamily
                                      ),)
                                  ],
                                ),),),
                                SizedBox(width: 10,),
                                defaultStatus == true ? Container(
                                  padding: EdgeInsets.only(left: 8,right: 8,top: 3,bottom: 3),
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      border: Border.all(
                                        color: defaultStatus == true? Colors.red: Color(0xffA6A6A6),
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(18.0))
                                  ),
                                  child: Text( defaultStatus == true ? "Default":"Set As Default",
                                    style: TextStyle(
                                      color:  defaultStatus == true ? Colors.red:Color(0xffA6A6A6),
                                      fontFamily: robotoFontFamily,
                                      fontSize: medium_FontSize,
                                      fontWeight: normal_FontWeight,
                                      //fontWeight: semiBold_FontWeight

                                    ),),
                                ):
                                Container(
                                  //height: 25,
                                  padding: EdgeInsets.only(left: 3,right: 3,),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        print("Template Id $templateID");
                                        print("default Id $defaultStatus");
                                        serviceRequestMapBody_setDefaultTemplate(templateID,defaultStatus);

                                      },
                                      child: Text( defaultStatus == true ? "Default":"Set As Default",
                                        style: TextStyle(
                                          color:  defaultStatus == true ? Colors.red:Color(0xffA6A6A6),
                                          fontSize: small_FontSize,
                                        ),),
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.white),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                  side: BorderSide(color: defaultStatus == true? Colors.red:
                                                  Color(0xffA6A6A6),))
                                          )
                                      )
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text("Leaves Calendar :",
                                  style: TextStyle(
                                      fontFamily: robotoFontFamily,
                                      fontSize: medium_FontSize,
                                      fontWeight: normal_FontWeight,
                                      color: darkGreyColor
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(calendar,
                                  style: TextStyle(
                                      fontWeight: normal_FontWeight,
                                      fontSize: medium_FontSize,
                                      fontFamily: robotoFontFamily
                                  ),
                                )
                                //  Text("${mapData["calendarStatus"]}",
                                //    style: TextStyle(
                                //        fontWeight: normal_FontWeight,
                                //        fontSize: medium_FontSize,
                                //        fontFamily: robotoFontFamily
                                //    ),
                                //  )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("Attendance Approval:",
                                  style: TextStyle(
                                      fontFamily: robotoFontFamily,
                                      fontSize: medium_FontSize,
                                      fontWeight: normal_FontWeight,
                                      color: darkGreyColor
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(attendanceApproval == "Y" ? "Required":"Not Required",
                                  style: TextStyle(
                                      fontWeight: normal_FontWeight,
                                      fontSize: medium_FontSize,
                                      fontFamily: robotoFontFamily
                                  ),
                                )

                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
              )
          ),
        ],
      );
  }

  CustomUI(String templateID,String templateType,String casualLeaveDays,
      String medicalLeave,String weeklyOffDays,String noOfWeekLeave,String calendar,String attendanceApproval,bool defaultStatus)

  {
    print("Inside Custom Status $defaultStatus");
    var colorOfImageContainer;
    if(templateType == "Basic" )
    {
      colorOfImageContainer = Colors.purple;
    }
    else if(templateType == "Standard")
    {
      colorOfImageContainer = Colors.blue;
    }
    else
    {
      colorOfImageContainer = Colors.green;
    }
    return
      Column(
        children: [
          Container(
              padding: EdgeInsets.only(top: 5,bottom: 5,),
              decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border(
                      bottom: BorderSide(
                          width: 3,
                          color: colorOfImageContainer
                      )
                  )
              ),
              child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.only(top: 4,left: 2),
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height:35,
                          width:35,
                          padding:EdgeInsets.all(6.0),
                          child: Container(
                            width: 20,
                            height: 20,
                            child: ImageCalender(),
                          ),
                          decoration: BoxDecoration(
                            color: colorOfImageContainer,
                            shape: BoxShape. circle,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("$templateType",
                                          style: TextStyle(
                                              fontSize: medium_FontSize,
                                              fontWeight: semiBold_FontWeight,
                                              fontFamily: robotoFontFamily,
                                              color: darkBlueColor
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text("Casual Leave",style: TextStyle(
                                                fontFamily: robotoFontFamily,
                                                fontSize: medium_FontSize,
                                                fontWeight: normal_FontWeight,
                                                color: darkGreyColor
                                            ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: colorOfImageContainer
                                              ),
                                              child: Text(casualLeaveDays,
                                                style: TextStyle(color: Colors.white,fontFamily: robotoFontFamily),),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),),
                                   /* SizedBox(width: 10,),
                                    InkWell(onTap: (){}, child: Icon(Icons.more_vert)),*/
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: Container(
                                      child: Row(
                                        children: [
                                          Text("Medical Leave",style: TextStyle(
                                              fontFamily: robotoFontFamily,
                                              fontSize: medium_FontSize,
                                              fontWeight: normal_FontWeight,
                                              color: darkGreyColor
                                          ),),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            height: 20,
                                            width: 20,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: colorOfImageContainer
                                            ),
                                            child: Text(medicalLeave,
                                              style: TextStyle(color: Colors.white,fontFamily: robotoFontFamily),),
                                          )
                                        ],
                                      ),
                                    )),
                                    SizedBox(width: 10,),
                                    defaultStatus == true ? Container(
                                      padding: EdgeInsets.only(left: 8,right: 8,top: 3,bottom: 3),
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          border: Border.all(
                                            color: defaultStatus == true? Colors.red: Color(0xffA6A6A6),
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(18.0))
                                      ),
                                      child: Text( defaultStatus == true ? "Default":"Set As Default",
                                        style: TextStyle(
                                          color:  defaultStatus == true ? Colors.red:Color(0xffA6A6A6),
                                          fontFamily: robotoFontFamily,
                                          fontSize: medium_FontSize,
                                          fontWeight: normal_FontWeight,
                                          //fontWeight: semiBold_FontWeight

                                        ),),
                                    ):
                                    Container(
                                      //height: 25,
                                      //width: 88,
                                      padding: EdgeInsets.only(left: 1,right: 1,top: 3,bottom: 3),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            print("Template Id $templateID");
                                            print("default Id $defaultStatus");
                                            serviceRequestMapBody_setDefaultTemplate(templateID,defaultStatus);
                                          },
                                          child: Text(defaultStatus == true?
                                          "Default":"Set As Default",
                                            style: TextStyle(
                                              color: defaultStatus == true? Colors.red:
                                              Color(0xffA6A6A6),
                                              fontSize: small_FontSize,
                                            ),),
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.white),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(18.0),
                                                      side: BorderSide(
                                                        color: defaultStatus == true? Colors.red:
                                                        Color(0xffA6A6A6),
                                                      ))
                                              )
                                          )
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Weekly Off",style: TextStyle(
                                        fontFamily: robotoFontFamily,
                                        fontSize: medium_FontSize,
                                        fontWeight: normal_FontWeight,
                                        color: darkGreyColor
                                    ),),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 20,
                                      width: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colorOfImageContainer
                                      ),
                                      child: Text(noOfWeekLeave,
                                        style: TextStyle(color: Colors.white),),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(weeklyOffDays,
                                          style: TextStyle(
                                              fontWeight: normal_FontWeight,
                                              fontSize: medium_FontSize,
                                              fontFamily: robotoFontFamily
                                          ),))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                leaveCalendarType(calendar),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Attendance Approval:",
                                      style: TextStyle(
                                          fontFamily: robotoFontFamily,
                                          fontSize: medium_FontSize,
                                          fontWeight: normal_FontWeight,
                                          color: darkGreyColor
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(attendanceApproval == "Y" ? "Required":"Not Required",
                                          style: TextStyle(
                                              fontWeight: normal_FontWeight,
                                              fontSize: medium_FontSize,
                                              fontFamily: robotoFontFamily
                                          ),
                                        )
                                    )

                                  ],
                                )
                              ],
                            )
                        )
                      ],
                    ),
                  )
              )
          ),
        ],
      );
  }

  StandardCalendarUI(String templateID,String templateType,String casualLeaveDays,
      String medicalLeave,String weeklyOffDays,String noOfWeekLeave,String calendar,String attendanceApproval,bool defaultStatus)
  {
    print("Inside Standard Status $defaultStatus");
    var colorOfImageContainer;
    if(templateType == "Basic" )
    {
      colorOfImageContainer = Colors.purple;
    }
    else if(templateType == "Standard")
    {
      colorOfImageContainer = Colors.blue;
    }
    else
    {
      colorOfImageContainer = Colors.green;
    }
    return
      Column(
        children: [
          Container(
              padding: EdgeInsets.only(top: 5,bottom: 5,),
              decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border(
                      bottom: BorderSide(
                          width: 3,
                          color: colorOfImageContainer
                      )
                  )
              ),
              child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.only(top: 4,left: 2),
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height:35,
                          width:35,
                          padding:EdgeInsets.all(6.0),
                          child: Container(
                            width: 20,
                            height: 20,
                            child: ImageCalender(),
                          ),
                          decoration: BoxDecoration(
                            color: colorOfImageContainer,
                            shape: BoxShape. circle,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(templateType,
                                  style: TextStyle(
                                      fontSize: medium_FontSize,
                                      fontWeight: semiBold_FontWeight,
                                      fontFamily: robotoFontFamily,
                                      color: darkBlueColor
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text("Casual Leave",style: TextStyle(
                                        fontFamily: robotoFontFamily,
                                        fontSize: medium_FontSize,
                                        fontWeight: normal_FontWeight,
                                        color: darkGreyColor
                                    ),),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 20,
                                      width: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colorOfImageContainer
                                      ),
                                      child: Text(casualLeaveDays,
                                        style: TextStyle(color: Colors.white),),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: Container(
                                      child: Row(
                                        children: [
                                          Text("Medical Leave",style: TextStyle(
                                              fontFamily: robotoFontFamily,
                                              fontSize: medium_FontSize,
                                              fontWeight: normal_FontWeight,
                                              color: darkGreyColor
                                          ),),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            height: 20,
                                            width: 20,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: colorOfImageContainer
                                            ),
                                            child: Text(medicalLeave,
                                              style: TextStyle(color: Colors.white),),
                                          )
                                        ],
                                      ),
                                    )),
                                    SizedBox(width: 10,),
                                    defaultStatus == true ? Container(
                                      padding: EdgeInsets.only(left: 8,right: 8,top: 3,bottom: 3),
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          border: Border.all(
                                            color: defaultStatus == true? Colors.red: Color(0xffA6A6A6),
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(18.0))
                                      ),
                                      child: Text( defaultStatus == true ? "Default":"Set As Default",
                                        style: TextStyle(
                                          color:  defaultStatus == true ? Colors.red:Color(0xffA6A6A6),
                                          fontFamily: robotoFontFamily,
                                          fontSize: medium_FontSize,
                                          fontWeight: normal_FontWeight,
                                          //fontWeight: semiBold_FontWeight

                                        ),),
                                    ):
                                    Container(
                                      //height: 25,
                                      //width: 88,
                                      padding: EdgeInsets.only(left: 1,right: 1,top: 3,bottom: 3),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            print("Template Id $templateID");
                                            print("default Id $defaultStatus");
                                            serviceRequestMapBody_setDefaultTemplate(templateID,defaultStatus);
                                          },
                                          child: Text(  defaultStatus == true?
                                          "Default":"Set As Default",
                                            style: TextStyle(
                                              color:
                                              defaultStatus == true? Colors.red:Color(0xffA6A6A6),

                                              fontSize: small_FontSize,
                                            ),),
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.white),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(18.0),
                                                      side: BorderSide(
                                                        color: defaultStatus == true? Colors.red :Color(0xffA6A6A6),
                                                      ))
                                              )
                                          )
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Weekly Off",style: TextStyle(
                                        fontFamily: robotoFontFamily,
                                        fontSize: medium_FontSize,
                                        fontWeight: normal_FontWeight,
                                        color: darkGreyColor
                                    ),),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 20,
                                      width: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colorOfImageContainer
                                      ),
                                      child: Text(noOfWeekLeave,
                                        style: TextStyle(color: Colors.white,fontFamily: robotoFontFamily),),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(weeklyOffDays,
                                          style: TextStyle(
                                              fontWeight: normal_FontWeight,
                                              fontSize: medium_FontSize,
                                              fontFamily: robotoFontFamily
                                          ),))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                leaveCalendarType(calendar),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Attendance Approval:",
                                      style: TextStyle(
                                          fontFamily: robotoFontFamily,
                                          fontSize: medium_FontSize,
                                          fontWeight: normal_FontWeight,
                                          color: darkGreyColor
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(attendanceApproval == "Y" ? "Required":"Not Required",
                                      style: TextStyle(
                                          fontWeight: normal_FontWeight,
                                          fontSize: medium_FontSize,
                                          fontFamily: robotoFontFamily
                                      ),
                                    )

                                  ],
                                )
                              ],
                            )
                        )
                      ],
                    ),
                  )
              )
          ),
        ],
      );
  }


  serviceRequestMapBody_NewWorkPlaceLeaveSettingAttendance()
  {
    var mapObject= getMasterLeaveTemplate_RequestBody(widget.liveModelObj?.tpAccountId);
    serviceRequest_NewWorkPlaceLeaveSettingAttendance(mapObject);
  }

  serviceRequest_NewWorkPlaceLeaveSettingAttendance(Map mapObj)
  {

    print("show the api response model class1");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequestFor_EmployerSignUp(mapObj,JG_ApiMethod_Employer_NewWorkPlaceLeaveSettingAttendance,"employerAttendanceListType",
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          Employer_NewWorkPlaceLeaveSettingAttendanceModelClass AttendanceModelClass=modelResponse as Employer_NewWorkPlaceLeaveSettingAttendanceModelClass;
          if(AttendanceModelClass?.statusCode==true)
          {
            setState(() {
              employer_NewWorkPlace_dataList = AttendanceModelClass.data;
              print("EmployerList Length : ${AttendanceModelClass.data!.length}");
              UIShown = true;
            });
            print("ListData ${employer_NewWorkPlace_dataList}");
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

  serviceRequestMapBody_setDefaultTemplate(String templateId,bool defaultStatus)
  {
    var customeraccountid = widget.liveModelObj?.tpAccountId;
    var default_templateId = templateId;
    var mapObject= getTemplatesetDefaultTemplate_RequestBody(customeraccountid,default_templateId);
    serviceRequest_setDefaultTemplate(mapObject);
  }

  serviceRequest_setDefaultTemplate(Map mapObj)
  {
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequestFor_EmployerSignUp(mapObj,JG_ApiMethod_Employer_NewWorkPlaceLeaveSettingAttendance_TemplatesetDefaultTemplate,kEmployer_Attendance_LeaveSetting_ActionValue,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          CJSnackBar(context, (commonResponse as CJTalentCommonModelClass).message!);
          serviceRequestMapBody_NewWorkPlaceLeaveSettingAttendance();

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

//






