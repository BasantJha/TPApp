
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeekerDashboard/JobSeeker_HomeView/JobSeeker_HomeChild.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeekerDashboard/JobSeeker_MyJobs/JobSeeker_MyJobsChild.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class JobSeeker_MyJobs extends StatefulWidget{
  const JobSeeker_MyJobs({Key? key}) : super(key: key);

  _JobSeeker_MyJobs createState() =>  _JobSeeker_MyJobs();
}

// ignore: camel_case_types
class _JobSeeker_MyJobs extends State<JobSeeker_MyJobs>{

  var appliedJobListData=jobSeekerTrendingCardListData;
  var savedJobListData=jobSeekerTrendingCardListData;
  //var customTabBarForTheMyJobs=getTheCustomTabBarForTheMyJobs;

  @override
  Widget build(BuildContext context)
  {
    return DefaultTabController(length: 2, child: Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
      toolbarHeight: 65,
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        getJobSeeker_MyJobsTitle,
        style: TextStyle(
          color: Colors.black,
          fontSize: appBarTitleFontWeight,
          fontFamily: viewHeadingFontfamily,
          fontWeight: bold_FontWeight,
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(preferredSize: Size.fromHeight(55.0),
        child: Padding(padding: EdgeInsets.only(left: 20,right: 20),child: Container(
          height: 45,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border.all(
                  color: darkGreyColor
              )
          ),
          child:getTheCustomTabBarForTheMyJob(),
        ),),),
    ),

      body: getResponsiveUI(),

    ));
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
  TabBar getTheCustomTabBarForTheMyJob()
  {
    return TabBar(
      indicator: BoxDecoration(
        color: Colors.blue,
      ) ,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.black,
      tabs:  [
        Row (
            children: [
              ImageIcon(
                  AssetImage(JobSeeker_Icon_AppliedJob)
              ),
              SizedBox(
                width: 10,
              ),
              Text("Applied Jobs")
            ]
        ),
        Row (
            children: [
              ImageIcon(
                  AssetImage(JobSeeker_Icon_SavedJob)
              ),
              SizedBox(
                width: 10,
              ),
              Text("Saved Jobs")
            ]
        ),
      ],
    );
  }

  Container MainfunctionUi()
  {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: TabBarView(
          children:  [
            appliedJobPage(),
            savedJobPage(),
          ],
        ) ,
      ),
    );
  }

  Container getTitleContainer()
  {
    return Container(padding: EdgeInsets.only(top: 0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 1,child: Text("2 Jobs Found",
                style: TextStyle(fontFamily: robotoFontFamily,fontSize: small_FontSize,fontWeight: normal_FontWeight),
              )
              ),
              SizedBox(
                width: 10,
              ),
              Container(height: 20,child: Row(
                children: [Text("Latest",
                  style: TextStyle(fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight,color: darkBlueColor),
                ),
                  Icon(Icons.keyboard_arrow_down,color:  darkBlueColor,),
                ],))]));
  }

  appliedJobPage()
  {
    return Container(child:
    Column(children: [
      getTitleContainer(),
      SizedBox(height: 15,),
      ListView.builder(shrinkWrap: true,itemCount: appliedJobListData.length,itemBuilder: (BuildContext context,int index)
      {
        var trendingObject=appliedJobListData[index];

        return myJobsListData(trendingObject.companyName, trendingObject.jobPostedDays, trendingObject.jobType,
            trendingObject.jobLocation, trendingObject.salaryPackage, trendingObject.workExperience, trendingObject.schooling,
            trendingObject.companyLogo, trendingObject.colorCode,false);
      }
      )
    ],),
    );

  }

  savedJobPage()
  {

    return Container(child:
    Column(children: [
      getTitleContainer(),
      SizedBox(height: 15,),
    ListView.builder(shrinkWrap: true,itemCount: appliedJobListData.length,itemBuilder: (BuildContext context,int index)
    {
      var trendingObject=appliedJobListData[index];

      return myJobsListData(trendingObject.companyName, trendingObject.jobPostedDays, trendingObject.jobType,
          trendingObject.jobLocation, trendingObject.salaryPackage, trendingObject.workExperience, trendingObject.schooling,
          trendingObject.companyLogo, trendingObject.colorCode,true);
    }),
      ],),
    );
  }

}

