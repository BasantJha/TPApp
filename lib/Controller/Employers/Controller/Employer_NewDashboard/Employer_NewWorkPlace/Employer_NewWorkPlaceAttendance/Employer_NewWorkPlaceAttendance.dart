
import 'package:contractjobs/Controller/Talents/ModelClasses/CJTalentCommonModelClass.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/Services/AESAlgo/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';


import '../../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../../Constant/ConstantIcon.dart';
import '../../../../../../Constant/Constants.dart';
import '../../../../../../Constant/Responsive.dart';
import '../../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../../Services/Messages/Message.dart';
import '../../../../../TankhaPayModule/Controller/ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfileChild.dart';
import '../../../EmployerModelClasses/EmployerAttendanceModelClass/Employer_NewWorkPlaceAttendaceModelClasses/EmployerNewWorkPlaceAttendanceModelClass.dart';
import '../../../EmployerModelClasses/EmployerAttendanceModelClass/Employer_New_WorkPlaceAttendanceDetailsModelClass/Employer_New_WorkPlaceAttendanceDetailsModelClass.dart';
import '../../../EmployerModelClasses/EmployerSignUpModelClasses/EmployerSignUpModelClass.dart';
import '../../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'Employer_NewWorkPlaceAttendanceCalendar.dart';
import 'Employer_NewWorkPlaceAttendanceDetails.dart';
import 'Employer_NewWorkPlaceLeaveSettingAttendance.dart';


class Employer_NewWorkPlaceAttendance extends StatefulWidget

{
  const Employer_NewWorkPlaceAttendance({Key? key,
   this.liveModelObj
  }) : super(key: key);
  final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  _Employer_NewWorkPlaceAttendance createState() => _Employer_NewWorkPlaceAttendance();

}

class _Employer_NewWorkPlaceAttendance extends State<Employer_NewWorkPlaceAttendance>

{


  var showUIAfterApICalled = false;
  String employeeIcon = Employer_Icon_SelectEmployeeListIcon;
  String arrowIcon = double_right_black_arrow_Icon;
  String verifiedIcon = verifiedAttendence_Blue_Icon;
  String smallCalendaerIcon = calendar_Black_Icon;




  var colorForTodayAttendance;
  var todayAttendanceStatus;
  List<String> monthList = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec"];

  //Today Attendance Data variable List
  String totalAttendanceData = " ";
  String presentData = " ";
  String absentdata = " ";
  String leaveData = " ";
   List<Map<String,dynamic>> employer_NewWorkPlace_Attendance_Details = [];
  List<Map<String,dynamic>> found_Employer_Attendance_Details = [];
  List<Map<String,dynamic>> present_Employee_Attendance_Details = [];
  List<Map<String,dynamic>> absent_Employee_Attendance_Details = [];
  List<Map<String,dynamic>> Leave_Employee_Attendance_Details = [];
  String? empCode;




  String month = DateTime.now().month.toString();
  String day = DateTime.now().day.toString();
  String year = DateTime.now().year.toString();
  late  var selectedDate = "${DateTime.now().day} ${monthList[DateTime.now().month-1]}'${DateTime.now().year}";

  var displayMessage="Attendance needs to be approved to generate payouts";
  var payoutSettingStatus="";


  Widget ImageCalender()
  {
    return  Image.asset(smallCalendaerIcon,
      height: 18,width: 18,color: darkGreyColor,);
  }

  var fonsizeforData = 30.0;

  @override
  void initState()
  {
    super.initState();
   // print("TPCODE ${widget.liveModelObj!.tpAccountId}");
    createBodyWebApi_NewWorkPlaceAttendance();
  }

  @override
  Widget build(BuildContext context)

  {


    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey[100],
            body: Responsive(
                mobile: MainfunctionUI(),
                tablet: MainfunctionUI(),
                desktop: Center(
                  child: Container(
                    width: webResponsive_TD_Width,
                    child: MainfunctionUI(),
                  ),
                )

            )
        )
    );
  }

  SingleChildScrollView MainfunctionUI()

  {
    return SingleChildScrollView(
        child: showUIAfterApICalled == true?
        Padding(
          padding: EdgeInsets.only(left: 15,right: 15,top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [


             /* InkWell(onTap: ()
              {
               TalentNavigation().pushTo(context, Employer_NewWorkPlaceLeaveSettingAttendance(liveModelObj: widget.liveModelObj,));

              },child: Container(
                height: 50,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 8,right: 8),
                decoration: BoxDecoration(
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Image.asset(smallCalendaerIcon,
                              height: 25,width: 25,),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Yearly Leave Setting",
                              style: TextStyle(
                                  fontFamily: robotoFontFamily,
                                  fontSize: large_FontSize,
                                  fontWeight: normal_FontWeight,
                                  color: darkBlueColor
                              ),
                            )
                          ],
                        )
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Image.asset(arrowIcon),
                    )
                  ],
                ),
              ),),*/

              SizedBox(
                height: 10,
              ),

              Container(
                //height: 50,
                alignment: Alignment.center,
               // padding: EdgeInsets.symmetric(horizontal: 28,vertical: 10),
                decoration: BoxDecoration(

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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35,vertical: 10),
                  child:displayMessage==""?Container():Text(displayMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: blackColor,
                        fontSize: medium_FontSize,
                        fontFamily: robotoFontFamily,
                        fontWeight: normal_FontWeight
                    ),
                  ),
                )
              ),


              SizedBox(
                height: 20,
              ),

              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text("Attendence Status",
              //     style: TextStyle(
              //         fontSize: large_FontSize,
              //         fontWeight: semiBold_FontWeight,
              //         fontFamily: robotoFontFamily,
              //         color: darkBlueColor
              //     ),
              //
              //   ),
              // ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child:Text("Attendence Status",
                      style: TextStyle(
                          fontSize: large_FontSize,
                          fontWeight: semiBold_FontWeight,
                          fontFamily: robotoFontFamily,
                          color: Color(0xff117da1)
                      ),

                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  /*---  Start 05-05-2023 ----------------------*/
                  InkWell(
                    onTap: selectDate,
                    child: Row(
                      children: [
                        Text(selectedDate,
                          style: TextStyle(
                              color: darkGreyColor,
                              fontWeight: normal_FontWeight,
                              fontFamily: robotoFontFamily,
                              fontSize: medium_FontSize
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.keyboard_arrow_down_outlined),
                        /*
                      InkWell(
                        onTap: selectDate,
                        child: Icon(Icons.keyboard_arrow_down_outlined),
                      )

                       */
                      ],
                    ),
                  )
                  /*---  End 05-05-2023 ----------------------*/
                ],
              ),

              SizedBox(
                height: 10,
              ),

              //Attendence Deatils List
              Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [

                      ClipPath(
                        clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)))),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              found_Employer_Attendance_Details = employer_NewWorkPlace_Attendance_Details;
                            });
                          },
                          child: Container(
                            height: 100,
                            width: 110,
                            decoration: BoxDecoration(
                                color : whiteColor,
                                border: Border(

                                  bottom: BorderSide(
                                      color: Colors.blue, width: 3
                                  ),
                                )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$totalAttendanceData",
                                  style: TextStyle(
                                      fontFamily: robotoFontFamily,
                                      fontSize: fonsizeforData,
                                      fontWeight: normal_FontWeight,
                                      color: blackColor
                                  ),
                                ),
                                Text("Employees",
                                  style: TextStyle(
                                      fontFamily: robotoFontFamily,
                                      fontSize: medium_FontSize,
                                      fontWeight: normal_FontWeight,
                                      color: darkBlueColor
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                      ),

                      SizedBox(
                        width: 10,
                      ),

                      ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)))),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                found_Employer_Attendance_Details = present_Employee_Attendance_Details;
                              });
                            },
                            child: Container(
                              height: 100,
                              width: 110,
                              decoration: BoxDecoration(
                                  color : whiteColor,
                                  border: Border(

                                    bottom: BorderSide(
                                        color: Colors.blue, width: 3
                                    ),
                                  )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("$presentData",
                                    style: TextStyle(
                                        fontFamily: robotoFontFamily,
                                        fontSize: fonsizeforData,
                                        fontWeight: normal_FontWeight,
                                        color: Colors.green
                                    ),
                                  ),
                                  Text("Present",
                                    style: TextStyle(
                                        fontFamily: robotoFontFamily,
                                        fontSize: medium_FontSize,
                                        fontWeight: normal_FontWeight,
                                        color: darkBlueColor
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )

                      ),

                      SizedBox(
                        width: 10,
                      ),

                      ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)))),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                found_Employer_Attendance_Details = absent_Employee_Attendance_Details;
                              });
                            },
                            child: Container(
                              height: 100,
                              width: 110,
                              //padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                              decoration: BoxDecoration(
                                  color : whiteColor,
                                  border: Border(

                                    bottom: BorderSide(
                                        color: Colors.blue, width: 3
                                    ),
                                  )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("$absentdata",
                                    style: TextStyle(
                                        fontFamily: robotoFontFamily,
                                        fontSize: fonsizeforData,
                                        fontWeight: normal_FontWeight,
                                        color: Colors.red
                                    ),
                                  ),
                                  Text("Absent",
                                    style: TextStyle(
                                        fontFamily: robotoFontFamily,
                                        fontSize: medium_FontSize,
                                        fontWeight: normal_FontWeight,
                                        color: darkBlueColor
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )

                      ),

                      // SizedBox(
                      //   width: 10,
                      // ),

                      /*
                      ClipPath(
                        clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)))),
                        child: GestureDetector(
                          onTap: (){
                            setState(()
                            {
                              found_Employer_Attendance_Details = Leave_Employee_Attendance_Details;
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color : whiteColor,
                                border: Border(

                                  bottom: BorderSide(
                                      color: Colors.blue, width: 3
                                  ),
                                )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$leaveData",
                                  style: TextStyle(
                                      fontFamily: robotoFontFamily,
                                      fontSize: fonsizeforData,
                                      fontWeight: normal_FontWeight,
                                      color: Colors.red
                                  ),
                                ),
                                Text("Leave",
                                  style: TextStyle(
                                      fontFamily: robotoFontFamily,
                                      fontSize: medium_FontSize,
                                      fontWeight: normal_FontWeight,
                                      color: darkBlueColor
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                      ),
                       */

                    ],
                  )
              ),

              SizedBox(
                height: 20,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child:Text("Employees' Monthly Attendance Status",
                      style: TextStyle(
                          fontSize: large_FontSize,
                          fontWeight: semiBold_FontWeight,
                          fontFamily: robotoFontFamily,
                          color: Color(0xff107d9c)
                      ),

                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("${monthList[int.parse(month)-1]}'$year",
                    style: TextStyle(
                        fontFamily: robotoFontFamily,
                        fontSize: medium_FontSize,
                        color: Color(0xff121212),
                        fontWeight: normal_FontWeight
                    ),

                  ),
                ],
              ),

              /*
              Row(
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Text("${monthList[DateTime.now().month-1]}'${DateTime.now().year}",
                            style: TextStyle(
                                fontFamily: robotoFontFamily,
                                fontSize: medium_FontSize,
                                color: blackColor,
                                fontWeight: semiBold_FontWeight
                            ),

                          ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          // Text("${DateTime.now().year}",
                          //   style: TextStyle(
                          //       fontFamily: robotoFontFamily,
                          //       fontSize: medium_FontSize,
                          //       color: blackColor,
                          //       fontWeight: semiBold_FontWeight
                          //   ),
                          //
                          // )
                        ],
                      )
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                /*  Row(
                    children: [
                      Text("Filter",
                        style: TextStyle(
                            fontFamily: robotoFontFamily,
                            fontSize: medium_FontSize,
                            color: darkGreyColor,
                            fontWeight: semiBold_FontWeight
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(filter_Icon,color: darkGreyColor,height: 15,)
                    ],
                  )*/
                ],
              ),

               */

              SizedBox(
                height: 10,
              ),

           /*
              TextField(
                textAlign: TextAlign.left,
                onChanged: (value){
                  print("value $value");
                  searchResult(value);
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    suffixIcon: Container(
                        child:  IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: Align(
                            alignment: Alignment.centerLeft,
                            child: ImageIcon(
                              AssetImage(search_Icon),
                            ),
                          ),
                        )
                    ),
                    hintText: 'Search Employee....',
                    border: InputBorder.none),
              ),

            */

              SizedBox(
                height: 10,
              ),


              /*--------------------Card UI----------------------------------------------------------*/

             found_Employer_Attendance_Details.isNotEmpty?
              ListView.builder(
                  itemCount: found_Employer_Attendance_Details.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index)
                  {
                    var attendanceDetails= found_Employer_Attendance_Details[index];
                    // if(attendanceDetails["todayAttendanceStatus"] == "PP" || attendanceDetails["todayAttendanceStatus"] == "HD")
                    // {
                    //   colorForTodayAttendance = Colors.green;
                    // }
                    // else if(attendanceDetails["todayAttendanceStatus"] == "HO" || attendanceDetails["todayAttendanceStatus"] == "LL"
                    // ||attendanceDetails["todayAttendanceStatus"] == "WO" || attendanceDetails["todayAttendanceStatus"] == "AA")
                    // {
                    //   colorForTodayAttendance = Colors.red;
                    // }
                    if(attendanceDetails["todayAttendanceStatus"] == "PP")
                      {
                        colorForTodayAttendance = Colors.green;
                       // todayAttendanceStatus  = "Present";
                      }
                    else if(attendanceDetails["todayAttendanceStatus"] == "AA")
                      {
                        colorForTodayAttendance = Colors.red;
                       // todayAttendanceStatus  = "Absent";
                      }
                    else if(attendanceDetails["todayAttendanceStatus"] == "LL")
                    {
                      colorForTodayAttendance = Colors.orange;
                     // todayAttendanceStatus  = "Leave";
                    }
                    else if(attendanceDetails["todayAttendanceStatus"] == "HO")
                    {
                      colorForTodayAttendance = Colors.blue;
                     // todayAttendanceStatus  = "Holiday";
                    }
                    else if(attendanceDetails["todayAttendanceStatus"] == "HD")
                    {
                      colorForTodayAttendance = Color(0xffFFA800);
                    //  todayAttendanceStatus  = "HalfDay";
                    }
                    return  GestureDetector(onTap: ()
                    {
                      print(found_Employer_Attendance_Details[index]["name"]);
                      var empName = found_Employer_Attendance_Details[index]["name"];
                      var dob = found_Employer_Attendance_Details[index]["DOB"];
                      var mobileno = found_Employer_Attendance_Details[index]["mobileNo"];
                      var designation = found_Employer_Attendance_Details[index]["designation"];
                      var emp_code = found_Employer_Attendance_Details[index][ "empCode"];
                      var completeEmpCode = mobileno + "CJHUB" + emp_code.toString() + "CJHUB" + dob;
                      var ImagePath = found_Employer_Attendance_Details[index]["Image"];

                      print("Image Path $ImagePath");

                      //TalentAnimationNavigation().pushBottomToTop(context, Employer_NewWorkPlaceAttendanceDetails(EmpName,year,EMPID));
                       //showAttendanceDetailsInModalBottomSheet
                      //  createServiceBodyRequestForAttendanceDetails(String empName,String year,String empCode,String designation)

                      createServiceBodyRequestForAttendanceDetails(empName,completeEmpCode,designation,ImagePath);

                    },
                      child:Column(
                        children: [
                          Container(
                            //height: 150,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 3,
                                          color: darkBlueColor
                                      )
                                  )
                              ),
                              padding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 2),
                              child: Row(

                                children: [
                                  Expanded(
                                    child: Container(
                                   // color: Colors.red,
                                    padding: EdgeInsets.only(right: 4),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        /*
                                        (found_Employer_Attendance_Details[index]["Image"] == null || found_Employer_Attendance_Details[index]["Image"] == "")?
                                        CircleAvatar(
                                          child: Text(getProfileEmpName(found_Employer_Attendance_Details[index]["name"])),
                                        ) :
                                        Image.asset(found_Employer_Attendance_Details[index]["Image"]),
                                        SizedBox(
                                          width: 10,
                                        ),

                                         */
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Row(
                                                children: [
                                                  Image(image: AssetImage(Employer_Icon_ProfileGrey),
                                                    width: Employer_SmallIcon_W_H,height: Employer_SmallIcon_W_H,color: addBlackColor,),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Expanded(child: Text(found_Employer_Attendance_Details[index]["name"],
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color: darkBlueColor,
                                                        fontSize: medium_FontSize,
                                                        fontFamily: robotoFontFamily,
                                                        fontWeight: semiBold_FontWeight
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(smallCalendaerIcon,
                                                  height: Employer_SmallIcon_W_H,width: Employer_SmallIcon_W_H,color: addBlackColor,),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(selectedDate,
                                                  style: TextStyle(
                                                      fontSize: medium_FontSize,
                                                      fontFamily: robotoFontFamily,
                                                      color: addBlackColor
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                found_Employer_Attendance_Details[index]["todayAttendanceStatus"] == ""?
                                                    Container():
                                                Container(
                                                  padding: EdgeInsets.only(left: 8,right: 8,top: 3,bottom: 3),
                                                  decoration: BoxDecoration(
                                                      color: whiteColor,
                                                      border: Border.all(
                                                        color: colorForTodayAttendance),

                                                      borderRadius: BorderRadius.all(Radius.circular(18.0))
                                                  ),
                                                  child: Text(found_Employer_Attendance_Details[index]["todayAttenStatus"],
                                                    style: TextStyle(
                                                      fontFamily: robotoFontFamily,
                                                      fontSize: medium_FontSize,
                                                      fontWeight: normal_FontWeight,
                                                      color: colorForTodayAttendance
                                                      //fontWeight: semiBold_FontWeight

                                                    ),),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(smallCalendaerIcon,
                                                  height: Employer_SmallIcon_W_H,width: Employer_SmallIcon_W_H,color: addBlackColor,),
                                                SizedBox(width: 5),
                                                Text("Marked Attendance:",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: medium_FontSize,
                                                      fontFamily: robotoFontFamily,
                                                      color: addBlackColor
                                                  ),
                                                ),
                                                SizedBox(width: 5),

                                               Container(
                                                 width: 50,
                                                 child: Row(
                                                   children: [
                                                     Expanded(child: Text(found_Employer_Attendance_Details[index]["totalMarked"],
                                                       maxLines: 2,
                                                       style: TextStyle(
                                                           color: Colors.orange
                                                       ),
                                                     )),
                                                   ],
                                                 )
                                               )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            payoutSettingStatus==kEmployerAttendance_PayoutSettingStatus? Row(
                                              children: [
                                                Image.asset(smallCalendaerIcon,
                                                  height: Employer_SmallIcon_W_H,width: Employer_SmallIcon_W_H,color: addBlackColor,),
                                                SizedBox(width: 5),
                                                Text("Approved Attendance:",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: medium_FontSize,
                                                      fontFamily: robotoFontFamily,
                                                      color: addBlackColor
                                                  ),
                                                ),
                                                SizedBox(width: 5),

                                                Container(
                                                  width: 50,
                                                  child: Row(
                                                    children: [
                                                      Expanded(child: Text(found_Employer_Attendance_Details[index]["totalApproved"],
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            color: Colors.green
                                                        ),
                                                      ))
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ):Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  ),
                                  Padding(

                                    padding: EdgeInsets.only(right: 10.0,top: 10.0,bottom: 10.0,left: 7.0),
                                    child: GestureDetector(
                                      onTap:(){
                                        var ImagePath = found_Employer_Attendance_Details[index]["Image"];
                                        var empName = found_Employer_Attendance_Details[index]["name"];
                                        var todayAttendance = found_Employer_Attendance_Details[index]["todayAttendanceStatus"];
                                        var approvalStatus = found_Employer_Attendance_Details[index]["AttendenceApproval"];
                                        var dob = found_Employer_Attendance_Details[index]["DOB"];
                                        var mobileno = found_Employer_Attendance_Details[index]["mobileNo"];
                                        var emp_code = found_Employer_Attendance_Details[index][ "empCode"];
                                        var doj = found_Employer_Attendance_Details[index]["doj"];
                                        var dateofrelieveing = found_Employer_Attendance_Details[index]["dateofrelieveing"];




                                        var empid = mobileno + "CJHUB" + emp_code.toString() + "CJHUB" + dob;
                                        var EMPID = empid;

                                        print("show the empid $EMPID");

                                         pushTo(context, Employer_NewWorkPlaceAttendanceCalendar(EMPID,ImagePath,empName,todayAttendance,approvalStatus,year,month,todayAttendanceStatus,widget.liveModelObj,doj,dateofrelieveing,payoutSettingStatus));

                                      },//dateofrelieveing
                                      child: Container(
                                          height: 50,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              color:darkBlueColor,
                                              borderRadius: BorderRadius.circular(10.0)
                                          ),
                                          child: Center(
                                              child: Text(payoutSettingStatus==kEmployerAttendance_PayoutSettingStatus?"Approve Attendance":"Attendance",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontSize: small_FontSize,
                                                    fontFamily: robotoFontFamily
                                                ),
                                              )
                                          )
                                      ),
                                    )

                                  )
                                ],
                              )
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ));

                  }):
               Center(
               child: Text("No data Found",
                 style: TextStyle(
                     fontFamily: robotoFontFamily,
                   fontWeight: bold_FontWeight,
                   fontSize: medium_FontSize
                 ),
               ),
             )

            ],
          ),
        ) : Container()
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
      createBodyWebApi_NewWorkPlaceAttendance();
    });
  }




  createBodyWebApi_NewWorkPlaceAttendance()

  {
    var customeraccountid = widget.liveModelObj!.tpAccountId;
    var att_date = day + "-" + month + "-" + year;
    var emp_name ="";
    var approval_status = "";
    var mapObject= getEmployer_getTodayAttendance(customeraccountid,att_date,emp_name,approval_status);
    serviceRequest_NewWorkPlaceAttendance(mapObject);
  }

  serviceRequest_NewWorkPlaceAttendance(Map mapObj)

  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_Employer_NewWorkPlaceAttendance,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          EmployerNewWorkPlaceAttendanceModelClass AttendanceModelClass=modelResponse as EmployerNewWorkPlaceAttendanceModelClass;
          CJTalentCommonModelClass commonModelObj=commonResponse as CJTalentCommonModelClass;

          if(AttendanceModelClass?.statusCode==true)
          {
            print("Status Is true");
            setState(()
            {
              totalAttendanceData = (AttendanceModelClass?.data?.attendancesummary?.totalAtt).toString();
              presentData = (AttendanceModelClass?.data?.attendancesummary?.presentAtt).toString();
              absentdata = (AttendanceModelClass?.data?.attendancesummary?.absentAtt).toString();

              payoutSettingStatus=(AttendanceModelClass?.data?.attendancesummary?.payoutSettings).toString();

              leaveData = (AttendanceModelClass?.data?.attendancesummary?.leaveAtt).toString();
              showUIAfterApICalled = true;
              addListdataToUI(AttendanceModelClass?.data?.attendancedetail);

              displayMessage=commonModelObj?.displayMessage;
              if(displayMessage=="" || displayMessage==null)
                {
                  displayMessage="Attendance needs to be approved to generate payouts";
                }
              print("show the displayMessage $displayMessage");

            });
          }

          }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonModelObj=commonResponse as CJTalentCommonModelClass;
          if (commonModelObj?.message==null || commonModelObj?.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context, commonModelObj!.message!);
          }

        }));
  }

  addListdataToUI(var data)

  {

    employer_NewWorkPlace_Attendance_Details=[];
    found_Employer_Attendance_Details=[];

    present_Employee_Attendance_Details.clear();
    absent_Employee_Attendance_Details.clear();
    Leave_Employee_Attendance_Details.clear();
    for(var i =0;i<data.length;i++)
    {
      // var name = toBeginningOfSentenceCase(data[i].empName);
      // print("Name first Character $name");
     // var doj = found_Employer_Attendance_Details[index][ "doj"];
      var map = {
        "Image":data[i].photopath,
        "name":toBeginningOfSentenceCase(data[i].empName),
        "approvalStatus":data[i].approvalStatus,
        "todayAttendanceStatus":data[i].attendanceType,
        "AttendenceApproval":data[i].approvalStatus,
        "mobileNo": data[i].mobile,
        "DOB": data[i].dateofbirth,
        "empCode":data[i].empCode,
        "designation": data[i].empDesignation,
        "totalApproved":data[i].approved_attendance,
        "totalMarked":data[i].marked_attendance,
        "todayAttenStatus":data[i].today_status,
        "doj": data[i].dateofjoining,
        "dateofrelieveing":data[i].dateofrelieveing
      };
      if(data[i].attendanceType == "PP" || data[i].attendanceType == "HD")
      {
        present_Employee_Attendance_Details.add(map);
        employer_NewWorkPlace_Attendance_Details.add(map);
      }
      else if(data[i].attendanceType == "AA")
      {
        absent_Employee_Attendance_Details.add(map);
        employer_NewWorkPlace_Attendance_Details.add(map);
      }
      else if(data[i].attendanceType == "LL")
      {

        Leave_Employee_Attendance_Details.add(map);
        employer_NewWorkPlace_Attendance_Details.add(map);
      }
      else
      {
        employer_NewWorkPlace_Attendance_Details.add(map);
      }
      setState(() {
        found_Employer_Attendance_Details = employer_NewWorkPlace_Attendance_Details;
      });
    }
    print("List Data $employer_NewWorkPlace_Attendance_Details");
    print("Present Employee list ${present_Employee_Attendance_Details}");
    print("Absent Employee list ${absent_Employee_Attendance_Details}");
    print("Leave Employee List $Leave_Employee_Attendance_Details");
  }

  void searchResult(String query)
  {
    print("In Result");
    List<Map<String,dynamic>> results = [];
    if (query.isEmpty) {
      results = employer_NewWorkPlace_Attendance_Details;
    }
    else {
      results = employer_NewWorkPlace_Attendance_Details
          .where((user) =>
          user["name"].toLowerCase().contains(query.toLowerCase())).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    setState(() {
      found_Employer_Attendance_Details = results;
      print("found User In search Box $found_Employer_Attendance_Details");
    });
  }


  selectDate()
  async {
    final DateTime? picked = await showDatePicker(
        initialDate: DateTime.now(),
        context: context,
        firstDate: DateTime.now().subtract(Duration(days: 500)),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        //selectedDate = "${picked.day}/${picked.month}/${picked.year}";
        day = picked.day.toString();
        month = picked.month.toString();
        year = picked.year.toString();
        selectedDate = "${picked.day} ${monthList[picked.month-1]}'${picked.year}";
        createBodyWebApi_NewWorkPlaceAttendance();
        print("Selected date $selectedDate");
      });
    }
  }

  createServiceBodyRequestForAttendanceDetails(var empName,var empCode,var designation,var ImagePath)
  {
    print("Inside Create Body Of Attendance Details");
    var mapObj = getAttendanceDetails_RequestBody(empCode,year);
    serviceRequestForGetAttendanceDetails(mapObj,empName,designation,ImagePath);
  }


  serviceRequestForGetAttendanceDetails(var mapObj,var EmpName,var Designation,var ImagePath)
  {
    print("show the request2");
    print("show the request object $mapObj");
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj, Employer_NewWorkPlace_Attendance_getAttendanceDetails,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {

          EasyLoading.dismiss();

          Employer_New_WorkPlaceAttendanceDetailsModelClass modelclasss = modelResponse as Employer_New_WorkPlaceAttendanceDetailsModelClass;
          List<Details>? detailsModelClassList = modelclasss.details;
          addDataToList(detailsModelClassList);
          showAttendanceDetailsInModalBottomSheet(context,EmpName,Designation,ImagePath);

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









