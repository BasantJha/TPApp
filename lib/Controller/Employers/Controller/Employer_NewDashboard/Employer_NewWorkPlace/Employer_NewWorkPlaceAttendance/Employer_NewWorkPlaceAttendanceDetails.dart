

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';


import '../../../../../../Constant/ConstantIcon.dart';
import '../../../../../../Constant/Constants.dart';
import '../../../../../../Constant/Responsive.dart';
import '../../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../../Services/Messages/Message.dart';
import '../../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../../../TankhaPayModule/Controller/ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfileChild.dart';
import '../../../EmployerDashboard/Employer_WorkPlace/ModelDataClass/Emp_Attendence.dart';
import '../../../EmployerModelClasses/EmployerAttendanceModelClass/Employer_New_WorkPlaceAttendanceDetailsModelClass/Employer_New_WorkPlaceAttendanceDetailsModelClass.dart';



//List<Details>? detailsValue;
//bool APIHitStatus = true;
var Attendence = [];
//
String Talent_close_Icon = TankhaPay_Icon_CloseCrossIcon;
String smallCalendarIcon=calendar_Black_Icon;

showAttendanceDetailsInModalBottomSheet(BuildContext context,String EmpName,String Designation,String ImagePath)
{

      print("Attendance Details Sheet");
      return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 150,),
                  Container(
                    color: Colors.transparent,
                    // padding: EdgeInsets.only(top: topSpace),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: mainUILeftRightPadding,
                              bottom: mainUILeftRightPadding),
                          child: FloatingActionButton(
                            onPressed: () => Navigator.pop(context),
                            backgroundColor: Colors.white,
                            child: Image(
                                image: AssetImage(TankhaPay_Icon_CloseCrossIcon)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*-----use below--*/
                  Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(40.0),
                        //   topRight: Radius.circular(40.0),
                        // )
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10,top: 15),
                              child: Text("Attendance Status",
                                style: TextStyle(
                                    color: darkBlueColor,
                                    fontFamily: robotoFontFamily,
                                    fontSize: large_FontSize,
                                    fontWeight: bold_FontWeight
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              //height: 150,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 3,
                                          color: darkBlueColor
                                      ),
                                      left: BorderSide(
                                          width: 1,
                                          color: darkGreyColor
                                      ),
                                      right: BorderSide(
                                          width: 1,
                                          color: darkGreyColor
                                      ),
                                      top: BorderSide(
                                          width: 1,
                                          color: darkGreyColor
                                      ),
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
                                            (ImagePath == "" || ImagePath == null)?
                                            CircleAvatar(
                                              child:Text(getProfileEmpName(EmpName.toString())),
                                            )
                                                :
                                            CircleAvatar(
                                              backgroundColor: Colors.transparent,
                                              radius: 30,
                                              backgroundImage: NetworkImage(ImagePath),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  width: 200,
                                                  child: Row(
                                                    children: [
                                                      Image(image: AssetImage(Employer_Icon_ProfileGrey),width: Employer_SmallIcon_W_H,height: Employer_SmallIcon_W_H,),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Expanded(child: Text(EmpName.toString(),
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
                                                    Image.asset(smallCalendarIcon,
                                                      height: Employer_SmallIcon_W_H,width: Employer_SmallIcon_W_H,color: darkGreyColor,),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(Designation.toString(),
                                                      style: TextStyle(
                                                          fontSize: medium_FontSize,
                                                          fontFamily: robotoFontFamily,
                                                          color: darkGreyColor
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                                itemCount: Attendence.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index)
                                {
                                  Emp_Attendance_Details data = Attendence[index];
//
                                  return Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2,color: lightGreyColor)
                                      ),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              border: Border.all(width: 1,color: darkGreyColor)
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("${data.month}'${data.year}",
                                                  style: TextStyle(
                                                    fontWeight: bold_FontWeight,
                                                    fontSize: medium_FontSize,
                                                    fontFamily: robotoFontFamily,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Divider(
                                                  height: 2,
                                                  color: darkGreyColor,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  //color: Colors.red,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text("Present",
                                                                style: TextStyle(
                                                                    fontWeight: bold_FontWeight,
                                                                    fontSize: medium_FontSize,
                                                                    fontFamily: robotoFontFamily,
                                                                    color: Color(0xff187A00)
                                                                ),
                                                              ),
                                                              Text(data.present.toString())
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text("Leave",
                                                                style: TextStyle(
                                                                    fontWeight: bold_FontWeight,
                                                                    fontSize: medium_FontSize,
                                                                    fontFamily: robotoFontFamily,
                                                                    color: Color(0xffFE0000)
                                                                ),
                                                              ),
                                                              Text(data.leave.toString())
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text("Total Paid Days",
                                                                style: TextStyle(
                                                                    fontWeight: bold_FontWeight,
                                                                    fontSize: medium_FontSize,
                                                                    fontFamily: robotoFontFamily,
                                                                    color: Colors.orange
                                                                ),
                                                              ),
                                                              Text(data.totalPaidDays.toString())
                                                            ],
                                                          ),
                                                          // Column(
                                                          //   children: [
                                                          //     Text("Half day",
                                                          //       style: TextStyle(
                                                          //           fontWeight: bold_FontWeight,
                                                          //           fontSize: medium_FontSize,
                                                          //           fontFamily: robotoFontFamily,
                                                          //           color: Color(0xffFFA800)
                                                          //       ),
                                                          //     ),
                                                          //     Text(data.halfDays.toString())
                                                          //   ],
                                                          // ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      );
    }



DataCell dtcell(String val) => DataCell(
  Center(
    child: Text(
      val,
      textAlign: TextAlign.center,
    ),
  ),
);

DataCell dtcellM(String val) => DataCell(
  Text(
    val,
  ),
);

DataColumn tableCol(String title) {
  return DataColumn(
      label: Text(
        title,
        textAlign: TextAlign.center,
      ));
}

addDataToList(data)
{

  print("Inside function toAddData");

  if(Attendence.isNotEmpty)
  {
    print("Inside If Block toAddData");
    print("List Length ${data.length}");
    Attendence.clear();
    for(var i = 0;i<data.length;i++)
    {

      var year = data[i].attyear;

      var MonthName = data[i].attmonthname;
      var totalPresent = data[i].totalpresent;
      var totalLeave = data[i].leavetaken;
      var totalPaidDays = data[i].totalpaiddays;
      Attendence.add(
        Emp_Attendance_Details(
            month: MonthName,
            year: year,
            present: totalPresent,
            leave: totalLeave,
            totalPaidDays: totalPaidDays
        ),
      );
    }
  }
  else
  {
    print("Inside else Block toAddData");
    print("List Length ${data.length}");
    for(var i = 0;i<data.length;i++)
    {

      var year = data[i].attyear;

      var MonthName = data[i].attmonthname;
      var totalPresent = data[i].totalpresent;
      var totalLeave = data[i].leavetaken;
      var totalPaidDays = data[i].totalpaiddays;
      Attendence.add(
        Emp_Attendance_Details(
            month: MonthName,
            year: year,
            present: totalPresent,
            leave: totalLeave,
            totalPaidDays: totalPaidDays
        ),
      );
    }
  }

}
