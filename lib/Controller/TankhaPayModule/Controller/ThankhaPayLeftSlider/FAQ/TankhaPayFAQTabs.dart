

import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/CJHubInsuranceModule/Insurance_DummyPage.dart';
import 'package:contractjobs/Controller/Talents/Controller/CJHubInsuranceModule/insuranceStatus_ModelResponse.dart';
import 'package:contractjobs/Controller/Talents/Controller/CJHubInsuranceModule/insurance_ViewInsuranceCard.dart';
import 'package:contractjobs/Controller/Talents/Controller/CJHubInsuranceModule/insurance_addInsurancePolicy.dart';
import 'package:contractjobs/Controller/Talents/Controller/CJHubInsuranceModule/insurance_editInsurancePolicy.dart';
import 'package:contractjobs/Controller/Talents/Controller/CJHubInvestment_DeclarationModule/investment_declarationClasses/investment_declaration.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_SalaryStatus/Talent_SalaryStatus.dart';
import 'package:contractjobs/CustomView/CJHubCustomView/palatte_Textstyle.dart';
import 'package:contractjobs/Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/CJJobSeekerService/CJJobSeekerServiceRequest.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../TankhaPayDrawer/TankhaPayDrawer.dart';
import 'TankhaPayFAQ.dart';
import 'TankhaPaySocialFAQ.dart';



class TankhaPayFAQTabs extends StatefulWidget
{
  const TankhaPayFAQTabs({Key? key}) : super(key: key);

  @override
  State<TankhaPayFAQTabs> createState() => _TankhaPayFAQTabs();
}

class _TankhaPayFAQTabs extends State<TankhaPayFAQTabs>with TickerProviderStateMixin
{

  static const profileTitleColor = Color(0xff107A9D);
  static const profileSubTitleColor = Color(0xff282828);

  static const downColor1 = Color(0xffE6E6E6);
  static const downColor2 = Color(0xffE0E0D4);
  static const greyColor = Color(0xffA9A9A9);

  bool checkBoxValue = false;
  BuildContext? contextType;
  String completeEmpCode="";

  TabController? tabController;

  bool tankhaPayAttendance_Visibility=true;
  double? attendanceViewHeight=300;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    tabController?.addListener(()
    {
      /*if(tabController?.index==0)
      {
        setState(() {
          attendanceViewHeight=300;

        });
        //Today use for the map
      }
      else
      {
        //use for the Calendar
        setState(() {
          attendanceViewHeight=450;

        });        }
*/
    });

  }

  @override
  Widget build(BuildContext context)
  {
    contextType=context;
    return Scaffold(
      drawer:  TankhaPayDrawer(),
      backgroundColor:whiteColor,
      appBar: CJAppBarBgBlue("", appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show 1the action 1type");
        Navigator.pop(context);
      })),
      body: getResponsiveUI(),
    );
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


  CirclesBackground  MainfunctionUi()
  {
    return CirclesBackground(
      circles:getCircleInfoForHome,
      child: getTheCustomColumn(),);
  }

  SingleChildScrollView getTheCustomColumn()
  {
    return  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Text("FAQs",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: whiteColor,
                      fontFamily: robotoFontFamily,
                      fontSize: 20.0),
                ),
                tileColor: getOneHundredGreyColor(),


              ) ,
              Container(height: 50,
                decoration: BoxDecoration(
                    color: getOneHundredGreyColor(),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        offset: Offset(0,5),
                        color: getTabBGGreyColor(),
                      )
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 1,right: 1),
                  child: TabBar(
                    controller: tabController,
                    labelColor: darkBlueColor,
                    unselectedLabelColor: Colors.black,
                    labelStyle: TextStyle(
                        fontFamily: robotoFontFamily,
                        fontWeight: semiBold_FontWeight,
                        fontSize: large_FontSize
                    ),
                    tabs: [
                      Tab(
                        text: ("General FAQs"),
                      ),
                      Tab(
                        text: ("Social Security FAQs"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 520,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TankhaPayFAQ(),
                    ),
                    TankhaPaySocialFAQ()
                  ],
                ),
              ),
            ],
          ),
        )
    );

  }

}

/*
CirclesBackground MainfunctionUI(){
  return CirclesBackground(
      circles:circles,
      child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 520,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: PolylineScreen(),
                      ),
                      AttendenceCalender()
                    ],
                  ),
                ),
              ],
            ),
          )
      )
  );
}*/
