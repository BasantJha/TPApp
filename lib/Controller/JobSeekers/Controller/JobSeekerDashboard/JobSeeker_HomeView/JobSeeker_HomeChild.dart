

import 'package:carousel_slider/carousel_options.dart';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

Card profileCardUI()
{
  var profileupdate = 2;
  var borderradiusconst = BorderRadius.circular(15.0);
  var constcolorforprofilrgreycolor = Color(0xff686868);

  return  Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: darkGreyColor),
      borderRadius: BorderRadius.circular(15),
    ),
    child:  Container(height: 250,
      //color: Color(0xffDFDFDF),
      decoration: BoxDecoration(
        border: Border.all(
            color: Color(0xffDFDFDF)
        ),
        borderRadius: borderradiusconst,
        gradient: LinearGradient(
          colors: [
            Color(0xfffefefe),
            Color(0xffe6e6e6)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text("Welcome Navin!",
              style: TextStyle(color: Color(0xff5C5C5C),
                fontSize: large_FontSize,
                fontFamily: robotoFontFamily,
                fontWeight: bold_FontWeight,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                child:  Text(
                  'No Photo',
                  style: TextStyle(
                    fontSize: small_FontSize,
                    color: Colors.white,
                    fontFamily: robotoFontFamily,
                  ),
                ),
                backgroundColor: darkBlueColor,
              ),
              Positioned(
                  right: 2.0,
                  top: 0.0,
                  child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),
                      child: InkWell(
                        onTap: (){},
                        child: ImageIcon(
                          AssetImage(Talent_Icon_cameraDrawer),
                          size: 15,
                          color: Colors.grey,
                        ),
                      )
                  )
              )
            ],
          ),
          SizedBox(
            height: 2,
          ),

          Container(
            //padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                    AssetImage(email_Icon)
                ),
                Flexible(
                  child: Text("n@gmail.com",
                    style: TextStyle(
                        color: Color(0xff2E2E2E),
                        fontSize: small_FontSize,
                        fontFamily: robotoFontFamily,
                        fontWeight:normal_FontWeight
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                ImageIcon(
                  AssetImage(Verification_Icon),
                  size: 15,
                  color: darkBlueColor,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Container(
            // padding: EdgeInsets.only(left: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                    AssetImage(phone_Icon)
                ),
                Flexible(
                  child: Text("0994884858  ",
                    style: TextStyle(
                        color: Color(0xff2E2E2E),
                        fontSize: small_FontSize,
                        fontFamily: robotoFontFamily,
                        fontWeight: normal_FontWeight
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                ImageIcon(
                  AssetImage(Verification_Icon),
                  size: 15,
                  color: darkBlueColor,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Container(
              child: Row(
                children: [
                  Text("Profile Complete",
                    style: TextStyle(
                        color: Color(0xff2E2E2E),
                        fontSize: small_FontSize,
                        fontFamily: robotoFontFamily,
                        fontWeight: normal_FontWeight
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: (){},
                    child: ImageIcon(
                      AssetImage(Edit_Icon),
                      size: 15,
                      color: Color(0xff2E2E2E),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10,right: 20),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        height:10,
                        padding: EdgeInsets.only(left: 8,right: 8),
                        child: LinearProgressBar(
                          maxSteps: 4,
                          progressType: LinearProgressBar.progressTypeLinear, // Use Linear progress
                          currentStep: profileupdate,
                          progressColor: darkBlueColor,
                          backgroundColor: darkGreyColor,
                        ),
                      )
                  ),
                  Text("${((profileupdate/4) * 100).round().toString()+ "%"}",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: robotoFontFamily,
                        fontSize: small_FontSize,
                        fontWeight: normal_FontWeight
                    ),
                  )
                ],
              )
          )
        ],
      ),
    ),
  );
}

class JobSeekerModelClass
{
  String titleName;
  String titleIcon;
  String totalJobPosition;

  JobSeekerModelClass({required this.titleName,required this.titleIcon,required this.totalJobPosition});
}


var carouselOptions = CarouselOptions(
height: 190,
// enlargeCenterPage: true,
// disableCenter: true,
padEnds: false,
autoPlay: true,
enableInfiniteScroll: true,
aspectRatio: 16 / 9,
viewportFraction: 0.5,
);

var jobSeekerCarouselCardListData=[JobSeekerModelClass(titleName: "Finance & Accounting",titleIcon:JobSeeker_Icon_FinanceAccounting,totalJobPosition:"9"),
  JobSeekerModelClass(titleName: "Desktop Support Engineer",titleIcon:JobSeeker_Icon_Desktop_Support,totalJobPosition:"685"),
  JobSeekerModelClass(titleName: "Account Manager",titleIcon:JobSeeker_Icon_Account_Manager,totalJobPosition:"134"),
  JobSeekerModelClass(titleName: "Automation Testing",titleIcon:JobSeeker_Icon_Automation_Testing,totalJobPosition:"60")];


Container carouselSliderCard(String title,String image,  String posistions)
{
  return Container(
    //margin: EdgeInsets.symmetric(horizontal: 5),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: darkGreyColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        // height: 100,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xffC3C3C3),
                  radius: 50.0,
                  child: CircleAvatar(
                    radius: 49,
                    backgroundColor: Color(0xffF7F7F7),
                    child: Image(
                      image: AssetImage(image),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 125,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: darkBlueColor,
                      fontFamily: robotoFontFamily,
                      fontSize: small_FontSize,
                      fontWeight: semiBold_FontWeight,
                    ),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "$posistions Positions",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: robotoFontFamily,
                    fontSize: smallLess_FontSize,
                    fontWeight: semiBold_FontWeight,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}


class JobSeekerTrendingModelClass
{
  String companyName;
  String jobPostedDays;
  String jobType;
  String jobLocation;
  String salaryPackage;
  String workExperience;
  String schooling;
  String companyLogo;
  Color colorCode;


  JobSeekerTrendingModelClass({required this.companyName,required this.jobPostedDays,required this.jobType,
  required this.jobLocation,required this.salaryPackage,required this.workExperience,
    required this.schooling,required this.companyLogo,required this.colorCode});
}

var jobSeekerTrendingCardListData=[JobSeekerTrendingModelClass(companyName: "punjab civil secretariat", jobPostedDays:"1 Day ago",
    jobType:"Paython Developer",jobLocation:"Amritsar, Punjab",salaryPackage:"2.85-2.85 Lakhs Per Annum",
    workExperience:"NA-2 Years",schooling:"Schooling",companyLogo:JobSeeker_Icon_CivilSecretry,colorCode:lightGreyColor),
  JobSeekerTrendingModelClass(companyName: "bida", jobPostedDays:"1 Day ago",
      jobType:"Paython Developer",jobLocation:"Office Helper",salaryPackage:"2.85-2.85 Lakhs Per Annum",
      workExperience:"NA-2 Years",schooling:"Schooling",companyLogo:JobSeeker_Icon_beeda,colorCode:whiteColor),

];
Card trendingJobCard(String companyName, String jobPostedDays, String jobType,
    String jobLocation, String salaryPackage, String workExperience, String schooling, String companyLogo,Color colorCode)

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
                  /*  Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ImageIcon(
                            AssetImage(JobSeeker_Icon_SavedJob)
                        ),
                        ImageIcon(
                            AssetImage(delete_Icon)
                        )]
                    ),*/

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