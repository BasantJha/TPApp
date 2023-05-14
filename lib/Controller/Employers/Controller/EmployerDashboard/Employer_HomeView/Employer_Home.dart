
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/CJHubSupport/HrConnect.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/Services/AESAlgo/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:circles_background/circles_background.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:marquee/marquee.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../CustomView/CircleAvatar/CircleAvatar.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../../TankhaPayModule/Controller/ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfileChild.dart';
import '../../EmployerModelClasses/EmployerAttendanceModelClass/Employer_HomeNotificationModelClass.dart';
import '../../Employer_KYC/EmployerAadhaar_Verification.dart';
import '../../Employer_KYCModelClass/Employer_KYCStatusModelClass.dart';
import '../../Employer_NewDashboard/Employer_NewPayment/EmployerPaymentTab.dart';
import '../../Employer_NewDashboard/Employer_NewProfile/Employer_NewProfile.dart';
import '../../Employer_NewDashboard/Employer_NewWorkPlace/Employer_NewWorkPlaceTabs.dart';
import '../../Employer_NewDashboard/Employer_PayoutSetting/Employer_PayoutSetting.dart';
import '../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../Employer_LeftDrawer/Employer_LeftDrawer.dart';

/*import 'package:tuple/tuple.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';*/
//
// ignore: camel_case_types
class Employer_Home extends StatefulWidget
{
  const Employer_Home({Key? key, this.liveModelObj}) : super(key: key);
  final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  State<Employer_Home> createState() => _Employer_Home();
}

//
// ignore: camel_case_types
class _Employer_Home extends State<Employer_Home>
{


  late final Map<String,List<Container>> map= {
    "Recent Activities": [
     // recentActivityUI(Employer_Icon_TaskPending,"tasks are pending for approval","4","TaskPending","12:am 16-09-2022",Color(0xffEAF5F9)),
     // recentActivityUI(JobSeeker_Icon_Rupee,"Attendence is due for 5 employee for the month of","Sep 2022","Attendencedue","12:am 16-09-2022",Color(0xffF3F0C5)),
     // recentActivityUI(Employer_Icon_Calendar,"Reena Devi is requesting payment of","35000","PaymentRequest","12:am 16-09-2022",Color(0xffFBF4E1)),
    ],

  };


  bool ApiHitStatus = false;
  List<Notifications>? notificationList;
  List<Recentactivities>? recentActivityList;


  var empName="",photoPath="";

  String checkAadharVerificationStatus="";
  bool checkAadharVerification_Visibility=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //console.log(originalText);

    print("show the employerName ${widget.liveModelObj?.employerName}");

    empName=widget.liveModelObj?.employerName;

    /*-----------3-3-2023 start------------*/
    if(widget.liveModelObj?.profilePhotoPath==null||widget.liveModelObj?.profilePhotoPath=="")
      {
        photoPath="";
      }
    else
      {
        photoPath=widget.liveModelObj?.profilePhotoPath;
      }
    /*-----------3-3-2023 end------------*/


//
    /*----------17-2-2023 start-----------*/
    String checkAadharVerificationStatus=widget.liveModelObj?.aadharNoIsverifyYN;

    print("show the aadhar verification status $checkAadharVerification_Visibility");
    if(checkAadharVerificationStatus==TankhaPay_Aadhaar_NR)
      {
        checkAadharVerification_Visibility=true;
      }
    /*----------17-2-2023 end-----------*/

    print("show the checkAadharVerificationStatus $checkAadharVerificationStatus");

    createBody_WebApiForNotification();

    print("show the login decrypted data ${getDecryptedData("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")}");

  }

//

  @override
  Widget build(BuildContext context)
  {
    return  SafeArea(
        child: Scaffold(
          drawer: EmployerNavigation_Drawer(liveModelObj: widget.liveModelObj,),
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

  CirclesBackground MainfunctionUi()
  {
    return CirclesBackground(
      circles:getCircleInfoForHome,
      child: SafeArea(child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            child: Column(
              children: [
               UICard(),

                /*---------17-2-2023 start-----*/
                checkAadharVerification_Visibility==true ?Container(height: 40,padding: EdgeInsets.only(top: 10,bottom: 10),child:  InkWell(onTap: ()
                  {

                    pushToAadhar(context, EmployerAadhaar_Verification(liveModelObj: widget.liveModelObj,employerAadharArriveFrom: TankhaPay_EmployerHome,));


                  },child: Marquee(
                  text: 'Please add your Aadhar with 15 days in order to receive your salary on time.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 100.0,
                 /* pauseAfterRound: Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: Duration(seconds: 1),*/
                  accelerationCurve: Curves.linear,
                  decelerationDuration: Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),),):Container(),
                /*---------17-2-2023 end-----*/


                ApiHitStatus == true? Expanded(
                  child:  ListView(
                    children: [

                      ApiHitStatus == true? notificationList!.length>0 == true ? Align(
                        alignment: Alignment.topLeft,
                        child: Text("Notifications",
                          style: TextStyle(
                              fontWeight: semiBold_FontWeight,
                              fontFamily: robotoFontFamily,
                              fontSize: largeExcel_FontSize,
                              color: blackColor
                          ),
                        ),): Container() :Container(),

                      SizedBox(
                        height: 10,
                      ),

                      ApiHitStatus == true?  ListView.builder(
                          itemCount: notificationList!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index)
                          {
                            var message=notificationList![index].msg.toString();
                            var checkActionItem=notificationList![index].actionitem.toString();


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
                                        trailing: TextButton(
                                          onPressed: ()
                                          {
                                            var selectedActionType=notificationList![index].actionitem;
                                            if(selectedActionType==kHomeActionStatus_AddEmployee)
                                            {
                                              //Add employee
                                              pushTo(context, Employer_NewWorkPlaceTabs(liveModelObj: widget.liveModelObj,employerWorkplaceVisibility: true,));


                                            }
                                            else  if(selectedActionType==kHomeActionStatus_SetupPayoutDate)
                                            {

                                              TalentNavigation().pushTo(context, Employer_PayoutSetting(liveModelObj: widget.liveModelObj));


                                            }
                                            else  if(selectedActionType==kHomeActionStatus_AddBalance)
                                            {
                                              //add balance(payment)
                                              pushTo(context, EmployerPaymentTab(liveModelObj: widget.liveModelObj,employerPaymentVisibility: true
                                                ,));

                                            }
                                            else
                                            {

                                            }

                                          },
                                          child: Text(
                                            checkActionItem==kHomeActionStatus_AddEmployee ||
                                                checkActionItem==kHomeActionStatus_SetupPayoutDate ||
                                                checkActionItem==kHomeActionStatus_AddBalance ? "Click Here":"",
                                            style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                decorationThickness: 2,
                                                color: darkBlueColor,
                                                fontFamily: robotoFontFamily,
                                                fontWeight: semiBold_FontWeight,
                                                fontSize: medium_FontSize
                                            ),
                                          ),
                                        )
                                    )
                                ),
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            );

                          }):Container(),

                      ApiHitStatus == true? recentActivityList!.length>0 == true ? Align(
                        alignment: Alignment.topLeft,
                        child: Text("Recent Activities",
                          style: TextStyle(
                              fontWeight: semiBold_FontWeight,
                              fontFamily: robotoFontFamily,
                              fontSize: largeExcel_FontSize,
                              color: blackColor
                          ),
                        ),): Container() :Container(),
                      SizedBox(
                        height: 1,
                      ),

                      ApiHitStatus == true?  ListView.builder(
                          itemCount: recentActivityList!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index)
                          {

                            var message=recentActivityList![index].msg.toString();
                            var notificationDateTime=recentActivityList![index].notificationdate.toString();
                            var countActivity=recentActivityList![index].cnt.toString();

                            if(countActivity=="" || countActivity==null)
                              countActivity="";

                            if(notificationDateTime=="" || notificationDateTime==null)
                              notificationDateTime="";

                            return recentActivityUI(Employer_Icon_TaskPending,message,countActivity,"TaskPending",notificationDateTime,Color(0xffEAF5F9));


                          }):Container(),
                    ],
                  ),
                ):Container()

              ],
            ),
          ))),

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
      createBody_WebApiForNotification();
    });
  }
  pushToAadhar<T>(BuildContext context,navigateView)
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
      employerKYCStatusServiceBodyRequest();
    });
  }


  Card UICard()
  {

    var profileupdate = 2;
    var borderradiusconst = BorderRadius.circular(15.0);
    var constcolorforprofilrgreycolor = Color(0xff686868);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: darkGreyColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child:  Container(
        padding: EdgeInsets.only(top: 10,bottom: 15),
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
              child: Text("Welcome $empName",
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

            SizedBox(
              child:  CircleAvatar(
                  radius: 50,
                  child: photoPath == null || photoPath==""
                      ? getProfileName(getProfileEmpName(empName))
                      : ClipOval(child:Image.network(photoPath, width: 100, height: 100,
                    fit: BoxFit.cover,) ,)
              ),
            ),

            SizedBox(
              height: 2,
            ),

         /*   Container(
              //padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("KYC Verified:",
                    style: TextStyle(
                        color: Color(0xff2E2E2E),
                        fontSize: medium_FontSize,
                        fontFamily: robotoFontFamily,
                        fontWeight:semiBold_FontWeight
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ImageIcon(
                    AssetImage(Verification_Icon),
                    size: 15,
                    color: greenColor,
                  ),
                ],
              ),
            ),*/
            SizedBox(
              height: 10,
            ),//
            Container(
              // padding: EdgeInsets.only(left: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Account Number:",
                    style: TextStyle(
                        color: Color(0xff2E2E2E),
                        fontSize: medium_FontSize,
                        fontFamily: robotoFontFamily,
                        fontWeight: semiBold_FontWeight
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                 /* Flexible(
                      child:*/ Text("${widget.liveModelObj?.accountNo!}",
                        style: TextStyle(
                            color: Color(0xff2E2E2E),
                            fontSize: medium_FontSize,
                            fontFamily: robotoFontFamily,
                            fontWeight: semiBold_FontWeight
                        ),
                      )
                 // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  recentActivityUI(String icon, String data, String datainbold, String typeofdata, String timespan,Color color)
  {
    return Container(
      margin: EdgeInsets.only(right: 20,top: 10),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: lightGreyColor),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          // height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape. circle,
                        color: Colors.white
                    ),
                    child: Image.asset(icon),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        child: ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              recentActivitydatasetUi(data, datainbold,typeofdata)
                            ],
                          ),
                          subtitle: Text(timespan,
                            style: TextStyle(
                                fontSize: small_FontSize,
                                fontFamily: robotoFontFamily,
                                fontWeight: normal_FontWeight,
                                color: darkBlueColor
                            ),
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  recentActivitydatasetUi( data,datainbold,type)
  {
    if(type == "TaskPending")
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: datainbold,
              style: TextStyle(
                  fontFamily: robotoFontFamily,
                  fontSize: largeExcel_FontSize,
                  fontWeight: semiBold_FontWeight,
                  color: Color(0xff292929)
              ),
            ),
            WidgetSpan(child: SizedBox(width: 3)),
            TextSpan(
              text: data,
              style: TextStyle(
                  fontFamily: robotoFontFamily,
                  fontSize: large_FontSize,
                  fontWeight: normal_FontWeight,
                  color: Color(0xff292929)
              ),
            ),
          ],
        ),
      );
    else if(type == "Attendencedue")
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: data,
              style: TextStyle(
                  fontFamily: robotoFontFamily,
                  fontSize: large_FontSize,
                  fontWeight: normal_FontWeight,
                  color: Color(0xff292929)
              ),
            ),
            WidgetSpan(child: SizedBox(width: 3)),
            TextSpan(
              text: datainbold,
              style: TextStyle(
                  fontFamily: robotoFontFamily,
                  fontSize: large_FontSize,
                  fontWeight: semiBold_FontWeight,
                  color: Color(0xff292929)
              ),
            ),
            TextSpan(
              text:".",
              style: TextStyle(
                  fontFamily: robotoFontFamily,
                  fontSize: large_FontSize,
                  fontWeight: normal_FontWeight,
                  color: Color(0xff292929)
              ),
            ),
          ],
        ),
      );
    else
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: data,
              style: TextStyle(
                  fontFamily: robotoFontFamily,
                  fontSize: large_FontSize,
                  fontWeight: normal_FontWeight,
                  color: Color(0xff292929)
              ),
            ),
            WidgetSpan(child: SizedBox(width: 3)),
            TextSpan(
              text: datainbold,
              style: TextStyle(
                  fontFamily: robotoFontFamily,
                  fontSize: large_FontSize,
                  fontWeight: semiBold_FontWeight,
                  color: Color(0xff292929)
              ),
            ),
            TextSpan(
              text: "/-",
              style: TextStyle(
                  fontFamily: robotoFontFamily,
                  fontSize: large_FontSize,
                  fontWeight: normal_FontWeight,
                  color: Color(0xff292929)
              ),
            ),
          ],
        ),
      );

  }

  createBody_WebApiForNotification()
  {
    var mapObject = getNotification_RequestBody(widget.liveModelObj?.tpAccountId);
    serviceRequestBodyFor_Notification(mapObject);
  }

  serviceRequestBodyFor_Notification(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);


    CJEmployerServiceRequest().postDataServiceRequest(mapObj,Employer_Home_Notification,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
         {
          EasyLoading.dismiss();
          print("show success");

          print("show the checkAadharVerificationStatus step 1");

          Employer_HomeNotificationModelClass objectModel = modelResponse as Employer_HomeNotificationModelClass;
          print("Notification in success Block ${objectModel.data!}");

          notificationList = objectModel.data!.notifications!;
          recentActivityList = objectModel.data!.recentactivities!;

          print("Notification in success notificationList $notificationList");

          //var getdec=getDecryptedData("yvzZPUav+3EJlrr3sxXjYCCp7rV7G2iULR7diEZfY1w70LgamngWwag+vDHl+d6x9kb/iyLAs4BcFkbB2Rf1s6F5EOO3tWPsgqNTNNYeeOplNOIzYlfIODWav1jPuIKFpJZ+pGjKEkKQt1lekYiuEa3J3HNyhWNRCAobKS4Iod5PxcmtWJ/BmhgIzBrRV9DIPIkdPTtPyp7NsLL2f1FHPrv1NFdRLFY8FTzgqI4oNK9GyQSdt1nIvcy8icRKe2SMuooZV1OR58vH/VHcMBhBAzCYz+4rW35pMzXxv0M9RXVHgiYSbIHt0059/uFCcTK8tJDBukjJF8hN5JgB5uau4/zLFhcrJQbMyv64VAsH3fzekvUYdlBJmTR8KRvEQzq8");
          //print("show the decrypted data $getdec");

          setState(() {
            ApiHitStatus = true;

          });
        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          print("show failure");

          CJTalentCommonModelClass getNotification=commonResponse as CJTalentCommonModelClass;
          if (getNotification.message==null || getNotification.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,getNotification.message as String);
          }

        }));
  }

  employerKYCStatusServiceBodyRequest()
  {
    print("show the request111 ${widget.liveModelObj?.employerMobile}");
    var mapObject=getEmployer_EmployerKYCStatus_RequestBody(widget.liveModelObj?.employerMobile);
    serviceRequestForEmployerKYCStatus(mapObject);
  }

  serviceRequestForEmployerKYCStatus(Map mapObj)
  {
    print("show 1the1 request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_EmployerKYCStatus,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          print("show sucess");

          Employer_KYCStatusModelClass  modelClass = modelResponse as Employer_KYCStatusModelClass;
          CJTalentCommonModelClass commonModelClass=commonResponse as CJTalentCommonModelClass;
          if(commonModelClass?.statusCode==true)
          {
            widget.liveModelObj?.aadharNoIsverifyYN=modelClass.aadharNoIsverifyYN;
            widget.liveModelObj?.employerName=modelClass.employerName;//use for aadhar no 14-3-2023 start

            if(modelClass.aadharNoIsverifyYN==TankhaPay_Aadhaar_NR)
            {

              setState((){
                checkAadharVerification_Visibility=true;
              });

            }
            else
              {
                setState((){
                  checkAadharVerification_Visibility=false;
                  empName=modelClass.employerName;//use for aadhar no 14-3-2023 start
                });
              }
          }
//
        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          print("show failure");
          CJTalentCommonModelClass commonModelClass=commonResponse as CJTalentCommonModelClass;
          if (commonModelClass!.message==null || commonModelClass!.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context,commonModelClass!.message as String);
          }

        }));
  }




}



























