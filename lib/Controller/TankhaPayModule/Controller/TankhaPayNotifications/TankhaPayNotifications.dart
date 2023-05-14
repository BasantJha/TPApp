
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/CJHubSupport/HrConnect.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/Services/AESAlgo/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:circles_background/circles_background.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../CustomView/CircleAvatar/CircleAvatar.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../Employers/Controller/EmployerModelClasses/TankhaPayNotificationListModelClass/TankhaPayNotificationListModelClass.dart';
import '../../../Employers/Controller/Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../TankhaPayModelClasses/TankhaPayNotificationModelClass/TankhaPayNotificationModelClass.dart';

/*import 'package:tuple/tuple.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';*/

// ignore: camel_case_types
class TankhaPayNotifications extends StatefulWidget
{
  const TankhaPayNotifications({Key? key, this.liveModelObj, this.notificationList, required this.unreadNotificationCount}) : super(key: key);
  final VerifyOTP_ModelResponse? liveModelObj;
  final List<TankhaPayNotificationList>? notificationList;
  final int unreadNotificationCount;


  @override
  State<TankhaPayNotifications> createState() => _TankhaPayNotifications();
}

////
// ignore: camel_case_types
class _TankhaPayNotifications extends State<TankhaPayNotifications>
{


  bool ApiHitStatus = false;
  //List<Notifications>? notificationList;

  String empName="",photoPath="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //console.log(originalText);


    if(widget.notificationList=="" || widget.notificationList==null)
      {
        ApiHitStatus=false;
        print("show the notification false");

      }
    else
      {
        ApiHitStatus=true;
        print("show the notification true");


      }


    if(widget.unreadNotificationCount==0)
    {

    }else
    {
      createBody_SavedReadNotification();
    }


  }

//

  @override
  Widget build(BuildContext context)
  {
    return  SafeArea(
        child: Scaffold(
          appBar:CJAppBarBgBlueForHTMLView("", appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show the action type");
            Navigator.pop(context);
          })),
          backgroundColor: Colors.white,
          body: getResponsiveUI(),
        )
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


  Container getTheCustomColumn() {
    return Container(
        padding: EdgeInsets.only(left: 5, right: 5,top: 6), child: Column(
        children: [

          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text("Notifications",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: whiteColor,
                  fontFamily: robotoFontFamily,
                  fontSize: 20.0),
            ),


          ),
          SizedBox(height: 40,),
          ApiHitStatus==true ? Expanded(flex: 1,child: ListView.builder(
              itemCount: widget.notificationList!.length,
              shrinkWrap: true,
              itemBuilder: (context, index)
              {
                var message=widget.notificationList![index].alertmessage.toString();

                var color;
                if(index  == 0)
                  color = Color(0xffFBF4D7);
                else if(index % 2 == 1)
                  color = Color(0xffD9EDF6);
                else if(index % 2 == 0)
                  color = Color(0xffF7EFDA);
                return Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 5,bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: color
                        ),
                        child: ListTile(
                          leading:Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape. circle,
                                color: Colors.white
                            ),
                            child: Image.asset(Employer_Icon_Notification),
                          ),
                          title: Text(message,
                            style: TextStyle(
                                fontSize: medium_FontSize,
                                fontWeight: semiBold_FontWeight,
                                fontFamily: robotoFontFamily
                            ),
                          ),

                        )
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                );

              })):Container(),

        ]));
  }




  createBody_SavedReadNotification()
  {
    var mapObject = getEmployer_UpdateNotificationList_RequestBody(kEmployer_NotificationList_AlertUserTypeEmployee,widget.liveModelObj?.data?.jsId);
    serviceRequestBodyFor_Notification(mapObject);
  }

  serviceRequestBodyFor_Notification(Map mapObj)
  {
    print("show 1the request2//");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_TankhaPayNotificationList_TPAlertApi,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          print("show success");
          /*-----------2-3-2023 START(discus with yatendar sir)--------------*/

        /*
          CJTalentCommonModelClass getNotification=commonResponse as CJTalentCommonModelClass;
          if (getNotification.message==null || getNotification.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context,getNotification.message as String);
          }*/

          /*-----------2-3-2023 START(discus with yatendar sir)--------------*/


        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          print("show failure");

          CJTalentCommonModelClass getNotification=commonResponse as CJTalentCommonModelClass;
          if (getNotification.message==null || getNotification.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context,getNotification.message as String);
          }

        }));
  }


}



























