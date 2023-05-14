
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circles_background/circles_background.dart';

import '../../../../../Constant/ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../EmployerDashboard/Employer_LeftDrawer/Employer_LeftDrawer.dart';
import '../../EmployerDashboard/Employer_WorkPlace/ModelDataClass/All_Contracts.dart';
import '../../EmployerDashboard/Employer_WorkPlace/ModelDataClass/Emp_Attendence.dart';
import '../../EmployerDashboard/Employer_WorkPlace/ModelDataClass/cnrt_employees.dart';
import '../../EmployerDashboard/Employer_WorkPlace/ModelDataClass/contracts.dart';
import '../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'Employer_NewWorkPlaceAttendance/Employer_NewWorkPlaceAttendance.dart';
import 'Employer_NewWorkPlaceEmployees/Employer_NewWorkPlaceEmployee.dart';
import 'Employer_NewWorkPlacePayouts/Employer_NewWorkPlacePayoutsList.dart';



class Employer_NewWorkPlaceTabs extends StatefulWidget
{

  const Employer_NewWorkPlaceTabs({Key? key, this.liveModelObj, this.employerWorkplaceVisibility}) : super(key: key);
  final Employer_VerifyMobileNoModelClass? liveModelObj;
  final bool? employerWorkplaceVisibility;

  @override
  State<Employer_NewWorkPlaceTabs> createState() => _Employer_NewWorkPlaceTabs();


}

class _Employer_NewWorkPlaceTabs extends State<Employer_NewWorkPlaceTabs> with TickerProviderStateMixin{


  TabController? tabController;

  final List<CircleInfo> circles = [
    CircleInfo(
        size: const Size(double.infinity, 60),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff93d9fd),
              Color(0xff3cbbfb)
            ]
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        alignment: Alignment.topCenter
    ),
  ];


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: EmployerNavigation_Drawer(liveModelObj: widget.liveModelObj,),
            appBar: widget.employerWorkplaceVisibility! ? CJAppBarBgBlue("", appBarBlock: AppBarBlock(appBarAction: ()
            {
              print("show 1the action 1type");
              Navigator.pop(context);
            })): null,

            backgroundColor: oneHunGreyColor,
            body: respnsiveUI()
        )
    );
  }

  Responsive respnsiveUI()
  {
    return Responsive(
        mobile: MainfunctionUI(),
        tablet: MainfunctionUI(),
        desktop: Center(
          child: Container(
            width: webResponsive_TD_Width,
            child: MainfunctionUI(),
          ),
        )

    );
  }

  /*CirclesBackground MainfunctionUI()
  {
    return CirclesBackground(
        circles:getCircleInfoForHome,
        child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text("WorkPlace",
                      style: TextStyle(fontSize: largeExcel_FontSize,fontFamily: robotoFontFamily,fontWeight: bold_FontWeight,color: whiteColor),),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(0,5),
                            color: Color(0xffe6e6e6),
                          )
                        ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 1,right: 1),
                      child: TabBar(
                        controller: tabController,
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.black,
                        labelStyle: TextStyle(
                            fontFamily: robotoFontFamily,
                            fontWeight: semiBold_FontWeight,
                            fontSize: 13
                        ),
                        tabs: [

                          Text("EMPLOYEES"),
                          Text("ATTENDANCE"),
                          Text("PAYOUTS")
                         *//* Tab(
                            text: ("Employee"),
                          ),
                          Tab(
                            text: ("Attendance"),
                          ),
                          Tab(
                            text: ("Payouts"),
                          ),*//*
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: TabBarView(
                      controller: tabController,
                      children: [

                        Employer_NewWorkPlaceEmployee(showStatus: true,liveModelObj: widget.liveModelObj,),
                        Employer_NewWorkPlaceAttendance(liveModelObj: widget.liveModelObj,),
                        Employer_NewWorkPlacePayoutsList(liveModelObj: widget.liveModelObj,)

                      ],
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }*/

  CirclesBackground MainfunctionUI()
  {
    return CirclesBackground(
        circles:getCircleInfoForHome,
        /*child: SingleChildScrollView(*/
            child: Padding(
              padding: EdgeInsets.only(top: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 17,),
                  Center(
                    child: Text("Workplace",
                      style: TextStyle(fontSize: largeExcel_FontSize,fontFamily: robotoFontFamily,fontWeight: bold_FontWeight,color: whiteColor),),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(height: 30,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5.0,
                            offset: Offset(0,5),
                            color: Color(0xffe6e6e6),
                          )
                        ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 1,right: 1),
                      child: TabBar(
                        controller: tabController,
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.black,
                        labelStyle: TextStyle(
                            fontFamily: robotoFontFamily,
                            fontWeight: semiBold_FontWeight,
                            fontSize: 13
                        ),
                        tabs: [

                          Text("EMPLOYEES"),
                          Text("ATTENDANCE"),
                          Text("PAYOUTS")
                          /* Tab(
                            text: ("Employee"),
                          ),
                          Tab(
                            text: ("Attendance"),
                          ),
                          Tab(
                            text: ("Payouts"),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //
                 Expanded(flex: 1,child:  SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.7,
                   child: TabBarView(
                     controller: tabController,
                     children: [

                       Employer_NewWorkPlaceEmployee(showStatus: true,liveModelObj: widget.liveModelObj,),
                       Employer_NewWorkPlaceAttendance(liveModelObj: widget.liveModelObj,),
                       Employer_NewWorkPlacePayoutsList(liveModelObj: widget.liveModelObj,)

                     ],
                   ),
                 )),
                ],
              ),
            )
       // )
    );
  }


}


