
//import 'dart:js';

import 'package:badges/badges.dart';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employees_Payments/Employees_Payments.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_HomeView/Employer_Home.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_LeftDrawer/Employer_LeftDrawer.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employer_Profile/Employer_Profile.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';

import 'package:contractjobs/CustomView/TabBar/TabBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../Constant/CJAppFlowConstants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../Services/Messages/Message.dart';
import '../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../EmployerDashboard/Employer_WorkPlace/Employer_NewWorkPlace.dart';
import '../EmployerModelClasses/TankhaPayNotificationListModelClass/TankhaPayNotificationListModelClass.dart';
import '../Employer_NewDashboard/Employer_Benefits/Employer_Benefits.dart';
import '../Employer_NewDashboard/Employer_NewPayment/EmployerPaymentTab.dart';
import '../Employer_NewDashboard/Employer_NewPayment/Employer_NewPaymentPlan.dart';
import '../Employer_NewDashboard/Employer_NewProfile/Employer_NewProfile.dart';
import '../Employer_NewDashboard/Employer_NewWorkPlace/Employer_NewWorkPlaceEmployees/Employer_NewWorkPlaceAddEmployee.dart';
import '../Employer_NewDashboard/Employer_NewWorkPlace/Employer_NewWorkPlaceTabs.dart';
import '../Employer_NewDashboard/Employer_Notifications/Employer_Notifications.dart';
import '../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';


class Employer_TabBarController extends StatefulWidget
{
  //const Employer_TabBarController({super.key, this.selectedRegistrationType});

  const Employer_TabBarController({Key? key, this.liveModelObj}) : super(key: key);
  final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  State<Employer_TabBarController> createState() => _Employer_TabBarController();
}

class _Employer_TabBarController extends State<Employer_TabBarController> {

  int _selectedindex = 0;
  var employerScaffoldkey = GlobalKey<ScaffoldState>();

   List<Widget> _widgetOptions = <Widget>[];

  List<TankhaPayNotificationList>? notificationList;
  int unViewCount=0;

  int checkPayoutFrequencyDate=0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkPayoutFrequencyDate=widget.liveModelObj!.payoutFrequencyDt!;


    if(widget.liveModelObj?.useForAddDOJStatus==Employee_ADDD0JStatus)
      {
        _selectedindex = 1;
      }
     else if(widget.liveModelObj?.useForAddDOJStatus==Employee_UpdateManualBankTransfer)
      {
        _selectedindex = 2;
      }
     else
        {
          _selectedindex = 0;//THIS USE FOR //10-2-2023

        }


    widget.liveModelObj?.useForAddDOJStatus="";
    loadData();

    createBody_getNotificationList();

  }

  loadData()
  {

    _widgetOptions = <Widget>[
      Employer_Home(liveModelObj: widget.liveModelObj,),
      Employer_NewWorkPlaceTabs(liveModelObj: widget.liveModelObj,employerWorkplaceVisibility: false,),
      EmployerPaymentTab(liveModelObj: widget.liveModelObj,employerPaymentVisibility: false,),
      //Employer_NewProfile(liveModelObj: widget.liveModelObj,employerProfileVisibility: false,),
      Employer_Benefits(liveModelObj: widget.liveModelObj,)
    ];
  }

  void _onItemTapped(int index)
  {
    setState(() {

          /*----------27-2-2023 start------------------*/
      // _selectedindex = index; //THIS USE FOR//10-2-2023
      if(checkPayoutFrequencyDate==0)
        {
          _selectedindex=0;
        }
      else
        {
          _selectedindex = index; //THIS USE FOR//10-2-2023
        }
      /*----------27-2-2023 end------------------*/

      if(index==0)
        {

        }else
          {
            createBody_getNotificationList();
          }

    });


  }

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: WillPopScope(onWillPop: ()
      {
      return  Message.alert_dialogAppExit(context);

      }, child: Scaffold(key: employerScaffoldkey,
        backgroundColor: Colors.white,
        appBar: (_selectedindex == 0) ? getAppBarFor_EmployerCommon() :
      (_selectedindex == 1) ? getAppBarFor_EmployerCommon() :
      (_selectedindex == 2) ? getAppBarFor_EmployerCommon() :
      (_selectedindex == 3) ? getAppBarFor_EmployerCommon() :null,

       drawer: (_selectedindex == 0) ? EmployerNavigation_Drawer(liveModelObj: widget.liveModelObj,) :
       (_selectedindex == 1) ? EmployerNavigation_Drawer(liveModelObj: widget.liveModelObj,) :
       (_selectedindex == 2) ? EmployerNavigation_Drawer(liveModelObj: widget.liveModelObj,):
       (_selectedindex == 3) ? EmployerNavigation_Drawer(liveModelObj: widget.liveModelObj,):null,

        body: _widgetOptions.elementAt(_selectedindex),
        bottomNavigationBar: BottomNavigationBar(
          // iconSize: 10.0,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            TalentTab(Common_Icon_HomeTab, Common_Name_HomeTab),
            TalentTab(Employer_Icon_WorkPlaceTab, Employer_Name_WorkPlaceTab),
            TalentTab(Employer_Icon_PaymentsTab, Employer_Name_PaymentsTab),
           // TalentTab(Common_Icon_ProfileTab, Common_Name_ProfileTab),
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

  AppBar getAppBarFor_EmployerHome()
  {
    return AppBar(
      backgroundColor: Color(0xff93d9fd),
      leading: IconButton(
        icon: ImageIcon(
            AssetImage(Menu_Icon)),
        onPressed: ()
        {
          employerScaffoldkey.currentState?.openDrawer();
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
  AppBar getAppBarFor_EmployerCommon()
  {
    return AppBar(
      backgroundColor: Color(0xff93d9fd),
      leading: IconButton(
        icon: ImageIcon(
            AssetImage(Menu_Icon)),
        onPressed: ()
        {
          print("show the salary status");
          employerScaffoldkey.currentState?.openDrawer();
        },
      ),
      elevation: 0,
      actions: [

       /* IconButton(
            onPressed: ()
            {

              TalentNavigation().pushTo(context, Employer_Notifications(liveModelObj: widget.liveModelObj,));
            },
            icon: ImageIcon(
                AssetImage(TankhaPay_Notification_Icon))),*/


        Padding(padding: EdgeInsets.only(top: 15),child:unViewCount==0?Container(child: IconButton(
            onPressed: ()
            {

              pushTo(context, Employer_Notifications(liveModelObj: widget.liveModelObj,notificationList: notificationList,unreadNotificationCount: unViewCount,));
            },
            icon: ImageIcon(AssetImage(TankhaPay_Notification_Icon))),):Badge(
          child: IconButton(
              onPressed: ()
              {

                pushTo(context, Employer_Notifications(liveModelObj: widget.liveModelObj,notificationList: notificationList,unreadNotificationCount: unViewCount,));
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
      setState(() {
        unViewCount=0;
      });
      //createBody_getNotificationList();
    });
  }
//

  createBody_getNotificationList()
  {
    var mapObject = getEmployer_GetNotificationList_RequestBody(kEmployer_NotificationList_AlertUserTypeEmployer,widget.liveModelObj?.tpAccountId);
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

          });

        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
         /* EasyLoading.dismiss();
          print("show failure");

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


//