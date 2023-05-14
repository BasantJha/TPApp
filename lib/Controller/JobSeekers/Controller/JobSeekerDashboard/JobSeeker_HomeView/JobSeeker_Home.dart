import 'dart:ui';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeekerDashboard/JobSeeker_HomeView/JobSeeker_HomeChild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class JobSeeker_Home extends StatefulWidget {
  const JobSeeker_Home({super.key});

  @override
  State<JobSeeker_Home> createState() => _JobSeeker_Home();
}

class _JobSeeker_Home extends State<JobSeeker_Home> {
  // double? items = 4;

  //double? progress;
 var carouselCardListData=jobSeekerCarouselCardListData;
 var trendingCardListData=jobSeekerTrendingCardListData;

 @override
  void initState()
  {
    super.initState();
   /* double totalProgress = 100 / 4;
    double? progressValue = totalProgress * 0.01;
    progress = progressValue * 1;*/

  }

  final List<CircleInfo> circles = [
    CircleInfo(
        size: Size(500, 100),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff93d9fd), Color(0xff3cbbfb)]),
        alignment: Alignment.topCenter),
  ];

  @override
  Widget build(BuildContext context)
  {

    return Scaffold(body: CirclesBackground(
      circles: circles,
      child: SingleChildScrollView(
        child: Container(padding: EdgeInsets.only(left: 15,right: 15),child: Center(
          child: Column(
            children: [

              profileCardUI(),

              SizedBox(
                height: 15,
              ),
              Container(
                //padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListTile(
                  title: Text(
                    "Trending on Contract Jobs",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: robotoFontFamily,
                      fontSize: 16.0,
                    ),
                  ),
                  subtitle: Text(
                    "Search for the best career opportunities with our job categories",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // color: Colors.blue,
                      fontFamily: robotoFontFamily,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child:CarouselSlider.builder(itemCount: carouselCardListData.length, itemBuilder: (BuildContext context,int index,int page)
                            {
                              var jobSeekerModelClass=carouselCardListData[index];
                              return carouselSliderCard(jobSeekerModelClass.titleName,jobSeekerModelClass.titleIcon, jobSeekerModelClass.totalJobPosition);
                            },
                          options: carouselOptions,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                          child:CarouselSlider.builder(itemCount: carouselCardListData.length, itemBuilder: (BuildContext context,int index,int page)
                          {
                            var jobSeekerModelClass=carouselCardListData[index];
                            return carouselSliderCard(jobSeekerModelClass.titleName,jobSeekerModelClass.titleIcon, jobSeekerModelClass.totalJobPosition);
                          },
                            options: carouselOptions,
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListTile(
                  title: Text(
                    "Full Time Work Opportunitiess",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: robotoFontFamily,
                      fontSize: large_FontSize,
                    ),
                  ),
                  subtitle: Text(
                    "Search for the best career opportunities with our job categories",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // color: Colors.blue,
                      fontFamily: robotoFontFamily,
                      fontSize: small_FontSize,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                child:
                ListView.builder(shrinkWrap: true,scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: trendingCardListData.length,itemBuilder: (BuildContext context,int index)
                {
                  var trendingObject=trendingCardListData[index];

                  return trendingJobCard(trendingObject.companyName, trendingObject.jobPostedDays, trendingObject.jobType,
                      trendingObject.jobLocation, trendingObject.salaryPackage, trendingObject.workExperience, trendingObject.schooling,
                      trendingObject.companyLogo, trendingObject.colorCode);
                }),
              )
            ],
          ),
        ),),
      ),
    ),);

  }


}
