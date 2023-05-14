import 'dart:ui';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/material.dart';


Card myJobsListData(String companyName, String jobPostedDays, String jobType,
    String jobLocation, String salaryPackage, String workExperience, String schooling, String companyLogo,Color colorCode,bool savedJobsVisibilityStatus)

{
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    elevation: 4.0,
    child: Container(
      height: 170,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colorCode
      ),
      padding: EdgeInsets.all(10.0),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.end,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      // color: Colors.blue,
                        padding: EdgeInsets.only(left: 5),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: Text(
                                companyName.toUpperCase(),
                                style: TextStyle(
                                    color: blackColor,
                                    fontFamily: robotoFontFamily,
                                    fontSize: small_FontSize,
                                    fontWeight: semiBold_FontWeight),
                              ),
                            )
                          ],
                        )
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      //color: Colors.yellow,
                        padding: EdgeInsets.only(left: 5),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: Text("$jobType",
                                style: TextStyle(
                                    fontWeight: semiBold_FontWeight,
                                    fontSize: medium_FontSize,
                                    fontFamily: robotoFontFamily,
                                    color: darkBlueColor
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    row(JobSeeker_Icon_Location, jobLocation),
                    row(JobSeeker_Icon_Rupee, salaryPackage),
                    row(JobSeeker_Icon_Work, workExperience),
                    row(JobSeeker_Icon_School, schooling),
                  ],
                ),
              )
          ),

          Expanded(
              flex: 1,
              child: Container(/*color: Colors.green,alignment: Alignment.centerRight,*/
                //padding: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        ImageIcon(
                            AssetImage(JobSeeker_Icon_Clock)
                        ),

                        SizedBox(
                          width: 2,
                        ),

                        Text("$jobPostedDays",
                          style: TextStyle(
                              fontSize: smallLess_FontSize,
                              fontFamily: robotoFontFamily,
                              color: Color(0xff7C7C7C)
                          ),

                        )
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(visible: savedJobsVisibilityStatus,child:ImageIcon(
                              AssetImage(JobSeeker_Icon_SavedJob)
                          ) ,),
                          ImageIcon(
                              AssetImage(delete_Icon)
                          )]
                    ),

                    Expanded(flex: 2,child:  Padding(
                      padding: EdgeInsets.only(right: 1,bottom: 5),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 64,
                          width: 67,
                          decoration: BoxDecoration(
                            //color: Colors.green,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Color(0xffD1D1D1)),
                              image: DecorationImage(
                                  image: AssetImage(companyLogo)
                              )
                          ),
                        ),
                      ),
                    ))

                  ],
                ),
              )
          ),

        ],
      ),
    ),
  );
}

row(String icon, String variable){
  return Row(
    children: [
      ImageIcon(
        AssetImage(icon),
      ),
      SizedBox(
        width: 2,
      ),
      Expanded(
          child: Text("$variable",
            style: TextStyle(
                fontSize: small_FontSize,
                fontFamily: robotoFontFamily,
                fontWeight: normal_FontWeight
            ),
          )
      )
    ],
  );
}

