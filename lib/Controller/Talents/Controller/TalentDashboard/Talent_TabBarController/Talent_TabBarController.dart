
//import 'dart:js';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Earnings/Talent_Earnings.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Employer/Talent_Employer/Talent_Employer.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_HomeView/Talent_Home.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_LeftDrawer/Talent_LeftDrawer.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Profile/Talent_Profile.dart';
import 'package:contractjobs/CustomView/RichText/RichTextClass.dart';
import 'package:contractjobs/CustomView/TabBar/TabBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../Services/Messages/Message.dart';
import '../Talent_HomeView/Talent_NewHome.dart';


class Talent_TabBarController extends StatefulWidget {
  const Talent_TabBarController({super.key});

  @override
  State<Talent_TabBarController> createState() => _Talent_TabBarController();
}

class _Talent_TabBarController extends State<Talent_TabBarController> {

  int _selectedindex = 0;
  var scaffoldkey = GlobalKey<ScaffoldState>();

  static const List<Widget> _widgetOptions = <Widget>[
    Talent_NewHome(),
    Talent_Employer(),
    Talent_Earnings(),
    Talent_Profile(),
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
      child: WillPopScope(onWillPop:()
        {
          return  Message.alert_dialogAppExit(context);

        },child: Scaffold(key: scaffoldkey,
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
                ImageIcon(AssetImage(User_NavigationIcon))),
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
            TalentTab(Talent_Icon_EmployerTab, Talent_Name_EmployerTab),
            TalentTab(Talent_Icon_EarningsTab, Talent_Name_EarningsTab),
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
      )),
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
          color: Colors.black,
          fontSize: appBarTitleFontWeight,
          fontFamily: viewHeadingFontfamily,
          fontWeight: bold_FontWeight,
        ),
      ),
      centerTitle: true,
    );
  }
}


