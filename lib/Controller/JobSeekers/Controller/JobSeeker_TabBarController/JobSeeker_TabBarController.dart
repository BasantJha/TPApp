
//import 'dart:js';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeekerDashboard/JobSeeker_FindWork/JobSeeker_FindWork.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeekerDashboard/JobSeeker_HomeView/JobSeeker_Home.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeekerDashboard/JobSeeker_MyJobs/JobSeeker_MyJobs.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeekerDashboard/JobSeeker_Profile/JobSeeker_Profile.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Earnings/Talent_Earnings.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Employer/Talent_Employer/Talent_Employer.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_LeftDrawer/Talent_LeftDrawer.dart';
import 'package:contractjobs/CustomView/RichText/RichTextClass.dart';
import 'package:contractjobs/CustomView/TabBar/TabBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


class JobSeeker_TabBarController extends StatefulWidget {
  const JobSeeker_TabBarController({super.key});

  @override
  State<JobSeeker_TabBarController> createState() => _JobSeeker_TabBarController();
}

class _JobSeeker_TabBarController extends State<JobSeeker_TabBarController> {

  int _selectedindex = 0;
  var scaffoldkey = GlobalKey<ScaffoldState>();

  static const List<Widget> _widgetOptions = <Widget>[
    JobSeeker_Home(),
    JobSeeker_FindWork(),
    JobSeeker_MyJobs(),
    JobSeeker_Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: Scaffold(key: scaffoldkey,
        backgroundColor: Colors.white,
        appBar: (_selectedindex == 0)
            ? AppBar(
          backgroundColor: Color(0xff93d9fd),
          leading: IconButton(
            icon: ImageIcon(
                AssetImage(Menu_Icon)),
            onPressed: () {
              scaffoldkey.currentState?.openDrawer();
            },
          ),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon:
                ImageIcon(AssetImage(Talent_Icon_ShareUserIcon))),
            IconButton(
                onPressed: () {},
                icon: ImageIcon(
                    AssetImage(Testimonial_NavigationIcon))),
          ],
        )
            : (_selectedindex == 1)
            ? null
            : (_selectedindex == 2)
            ? null
            : null,
        drawer: _selectedindex == 0 ? Navigation_Drawer() : null,
        body: _widgetOptions.elementAt(_selectedindex),
        bottomNavigationBar: BottomNavigationBar(
          // iconSize: 10.0,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            TalentTab(Common_Icon_HomeTab, Common_Name_HomeTab),
            TalentTab(JobSeeker_Icon_NetworkTab, JobSeeker_Name_NetworkTab),
            TalentTab(JobSeeker_Icon_MyJobTab, JobSeeker_Name_MyJobTab),
            TalentTab(Common_Icon_ProfileTab, Common_Name_ProfileTab),
          ],
          currentIndex: _selectedindex,
          // fixedColor: Colors.grey,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  AppBar SAppBar(String title) {
    return AppBar(
      // toolbarHeight: 70,
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(
          color: blackColor,
          fontSize: largeExcel_FontSize,
          fontFamily: robotoFontFamily,
          fontWeight: bold_FontWeight,
        ),
      ),
      centerTitle: true,
    );
  }
}


