
//import 'dart:js';

import 'package:badges/badges.dart';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employees_Payments/Employees_Payments.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_HomeView/Employer_Home.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_LeftDrawer/Employer_LeftDrawer.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_Profile/Employer_Profile.dart';

import 'package:contractjobs/CustomView/TabBar/TabBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../Services/Messages/Message.dart';
import '../../../Employers/Controller/EmployerDashboard/Employer_WorkPlace/Employer_NewWorkPlace.dart';
import '../../../Employers/Controller/EmployerModelClasses/TankhaPayNotificationListModelClass/TankhaPayNotificationListModelClass.dart';
import '../../../Talents/Controller/TalentDashboard/Talent_Controller/Talent_SalaryStatus/Talent_SalaryStatus.dart';
import '../../../Talents/Controller/TalentDashboard/Talent_LeftDrawer/Talent_LeftDrawer.dart';
import '../../../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../TankhaPayAttendanceTabs/TankhaPayAttendanceTabs.dart';
import '../TankhaPayBenefits/TankaPayBenefits/TankhaPayBenefits.dart';
import '../TankhaPayDrawer/TankhaPayDrawer.dart';
import '../TankhaPayHome/TankhaPayHome.dart';
import '../TankhaPayNotifications/TankhaPayNotifications.dart';


class TankhaPay_TabBarController extends StatefulWidget
{

  const TankhaPay_TabBarController({Key? key,this.liveModelObject}) : super(key: key);

  //final selectedRegistrationType;
  final VerifyOTP_ModelResponse? liveModelObject;


  @override
  State<TankhaPay_TabBarController> createState() => _TankhaPay_TabBarController();
}

class _TankhaPay_TabBarController extends State<TankhaPay_TabBarController> {

  int _selectedindex = 0;
  var scaffoldkey = GlobalKey<ScaffoldState>();


  List<Widget> _widgetOptions = <Widget>[];

  List<TankhaPayNotificationList>? notificationList;
  int unViewCount=0;

 /* var selectRegistrationType;
  _TankhaPay_TabBarController(selectedRegistrationType)
  {
    selectRegistrationType=selectedRegistrationType;
    loadData(selectedRegistrationType);
  }*/

  
  void _onItemTapped(int index)
  {
    setState(() {
      _selectedindex = index;
    });
    createBody_getNotificationList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
    createBody_getNotificationList();

  }
  loadData()
  {

    _widgetOptions = <Widget>[
      TankhaPayHome(liveModelObject: widget.liveModelObject,),
      TankhaPayAttendanceTabs(visibilityStatusForTankhaPayAttendance:false,liveModelObject: widget.liveModelObject,),
      Talent_SalaryStatus(visibilityStatusForSalaryStatus:false,liveModelObject: widget.liveModelObject,),
      ShowCaseWidget(
          builder: Builder(
            builder: (context) => TankhaPayBenefits(visibilityStatusForTankhaPayBenefits:false,liveModelObject: widget.liveModelObject,),
          )),

    ];
  }

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: WillPopScope(onWillPop: ()
      {
        return  Message.alert_dialogAppExit(context);

      }, child: Scaffold(key: scaffoldkey,
        backgroundColor: Colors.white,
        appBar: (_selectedindex == 0) ? getAppBarFor_Common() :
        (_selectedindex == 1) ? getAppBarFor_Common() :
        (_selectedindex == 2) ? getAppBarFor_Common() :
        (_selectedindex == 3) ? getAppBarFor_Common() :null,
        drawer: (_selectedindex == 0) ? TankhaPayDrawer(liveModelObject: widget.liveModelObject,) :
        (_selectedindex == 1) ? TankhaPayDrawer(liveModelObject: widget.liveModelObject,) :
        (_selectedindex == 2) ? TankhaPayDrawer(liveModelObject: widget.liveModelObject,):
        (_selectedindex == 3) ? TankhaPayDrawer(liveModelObject: widget.liveModelObject,):null,

        body: _widgetOptions.elementAt(_selectedindex),
        bottomNavigationBar: BottomNavigationBar(
          // iconSize: 10.0,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            TalentTab(Common_Icon_HomeTab, Common_Name_HomeTab),
            TalentTab(TankhaPay_Icon_AttendanceTab, TankhaPay_Name_AttendanceTab),
            TalentTab(TankhaPay_Icon_SalaryTab, TankhaPay_Name_SalaryTab),
            TalentTab(TankhaPay_Icon_BenefitsTab, TankhaPay_Name_BenefitsTab),

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

  AppBar getAppBarFor_Home()
  {
    return AppBar(
      backgroundColor: Color(0xff93d9fd),
      leading: IconButton(
        icon: ImageIcon(
            AssetImage(Menu_Icon)),
        onPressed: ()
        {
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
    );
  }
  AppBar getAppBarFor_Common()
  {
    return AppBar(
      backgroundColor: Color(0xff93d9fd),
      leading: IconButton(
        icon: ImageIcon(
            AssetImage(Menu_Icon)),
        onPressed: ()
        {
          print("show the salary status");
          scaffoldkey.currentState?.openDrawer();
        },
      ),
      elevation: 0,
      actions: [

      /*  IconButton(
            onPressed: ()
            {

              pushTo(context, TankhaPayNotifications(liveModelObj: widget.liveModelObject,));

            },
            icon: ImageIcon(
                AssetImage(TankhaPay_Notification_Icon))),*/

        Padding(padding: EdgeInsets.only(top: 15),child:unViewCount==0?Container(child: IconButton(
            onPressed: ()
            {

              pushTo(context, TankhaPayNotifications(liveModelObj: widget.liveModelObject,notificationList: notificationList,unreadNotificationCount: unViewCount,));
            },
            icon: ImageIcon(AssetImage(TankhaPay_Notification_Icon))),):Badge(
          child: IconButton(
              onPressed: ()
              {

                pushTo(context, TankhaPayNotifications(liveModelObj: widget.liveModelObject,notificationList: notificationList,unreadNotificationCount: unViewCount,));
              },
              icon: ImageIcon(AssetImage(TankhaPay_Notification_Icon))),
          badgeContent: Padding(padding: EdgeInsets.only(top: 1),child: SizedBox(width: 12, height: 12,
              child:Center(child:Text(unViewCount.toString(), style: TextStyle(color: Colors.white,fontSize: 10 )),)),),
        ),),
        Container(child: Text("          "),),
      ],
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
      //createBody_getNotificationList();

      setState(() {
        unViewCount=0;
      });
    });
  }

  createBody_getNotificationList()
  {
    var mapObject = getEmployer_GetNotificationList_RequestBody(kEmployer_NotificationList_AlertUserTypeEmployee,widget.liveModelObject?.data?.jsId);
    serviceRequestBodyFor_Notification(mapObject);
  }

  serviceRequestBodyFor_Notification(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    // EasyLoading.show(status: Message.get_LoaderMessage);


    unViewCount=0;
    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_TankhaPayNotificationList_TPAlertApi,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          //EasyLoading.dismiss();
          print("show success");

          TankhaPayNotificationListModelClass objectModel = modelResponse as TankhaPayNotificationListModelClass;
          print("Notification in success Block $objectModel");

          notificationList = objectModel.tankhaPayNotificationList;
          print("Notification in success notificationList $notificationList");

          int i=0;
          for(i=0;i<notificationList!.length;i++)
          {
            var getViewType=notificationList![i].isviewed;
            if(getViewType=="N")
            {
              unViewCount=unViewCount+1;
            }

          }

          setState(() {
            //ApiHitStatus = true;
            unViewCount=unViewCount;

            print("show the unViewCount $unViewCount ");

          });

        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
           //EasyLoading.dismiss();
         /* print("show failure");

          CJTalentCommonModelClass getNotification=commonResponse as CJTalentCommonModelClass;
          if (getNotification.message==null || getNotification.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context,getNotification.message as String);
          }*/

        }));
  }

}


