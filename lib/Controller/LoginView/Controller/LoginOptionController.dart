

import 'dart:io';

import 'package:contractjobs/Constant/CJAppFlowConstants.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/LoginView/Controller/LoginViewController.dart';
import 'package:contractjobs/Controller/LoginView/ModelClasses/IntroModelClass.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CJSnackBar/CJSnackBar.dart';
import 'package:contractjobs/CustomView/Messages/Talent_TextMessages.dart';
import 'package:contractjobs/CustomView/RichText/RichTextClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import '../../../Constant/ConstantIcon.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceBody.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceKey.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceRequest.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceURL.dart';
import 'package:contractjobs/Services/LocalizationFile/LocalizationFile.dart';
//import 'package:getwidget/components/avatar/gf_avatar.dart';

import '../../../CustomView/CJHubCustomView/Method.dart';
import '../../../CustomView/ContainerView/CustomContainer.dart';
import '../../../CustomView/Method.dart';
import '../../../Services/Messages/Message.dart';


class LoginOptionController extends StatefulWidget
{
  const LoginOptionController({Key? key}) : super(key: key);

  @override
  State<LoginOptionController> createState() => _LoginOptionController();

}


class _LoginOptionController extends State<LoginOptionController> {

  List loginOptionList=getLoginOptionList();
  late List<IntroDetails> screenListData=[];
  String loginTitle="",loginSubTitle="",banner="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //serviceBodyRequest();


    //start 31-03-2023
    WidgetsBinding.instance.addPostFrameCallback((_){
       authenticateUser();
    });
    //End 31-03-2023

  }


  //start 31-03-2023
  authenticateUser() async {
    //initialize Local Authentication plugin.
    final LocalAuthentication _localAuthentication = LocalAuthentication();

    //status of authentication.
    bool isAuthenticated = false;

    //check if device supports biometrics authentication.
    bool isBiometricSupported = await _localAuthentication.isDeviceSupported();


    List<BiometricType> biometricTypes =
    await _localAuthentication.getAvailableBiometrics();

    print("All available authentication available $biometricTypes");

    //if device supports biometrics, then authenticate.
    if (isBiometricSupported) {
      try {
        isAuthenticated = await _localAuthentication.authenticate(
            localizedReason: 'To continue, you must complete the biometrics',
            useErrorDialogs: true,
            stickyAuth: true);
        if(!isAuthenticated)
          {
            exit(0);
          }
      } on PlatformException catch (e) {
        print(e);
      }
    }

    return isAuthenticated;
  }
  //End 31-03-2023

    @override
  Widget build(BuildContext context)
  {

    return WillPopScope(child: Scaffold(backgroundColor: Colors.white,

      body: getResponsiveUI(),
      // bottomNavigationBar:companyNameContainerBottomSheet() ,

    ), onWillPop: ()
    {
      return Message.alert_dialogAppExit(context);
    }
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
  SingleChildScrollView  MainfunctionUi()
  {
    return SingleChildScrollView(
      child: Container(height: MediaQuery.of(context).size.height,
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          SizedBox(height: 70),
          getTheTankhaPayGrayLogoContainer,
          SizedBox(height: 100),

          listview(),

        ],
      ),),
    );
  }

  Expanded listview()
  {
    return Expanded(
      child: loginOptionList.isNotEmpty
          ?  ListView.builder(
          itemCount: loginOptionList.length,
          itemBuilder: (context, index)
          {
            String title="",subTitle="";
            bool selectionStatus=false;
            Color textColorType=blackColor;
            String iconType=getLoginOption_RightBlueIcon;
            Color cardBgColor=darkGreyColor;


            selectionStatus=loginOptionList[index]["selectionStatus"];
            if(selectionStatus==true)
            {
              title=loginOptionList[index]["title"];
              subTitle=loginOptionList[index]["subTitle"];
              textColorType=whiteColor;
              iconType=getLoginOption_RightBlueIcon;
              cardBgColor=lightBlueColor;
            }
            else
            {
              title=loginOptionList[index]["title"];
              subTitle=loginOptionList[index]["subTitle"];
              textColorType=blackColor;
              iconType=getLoginOption_RightGrayIcon;
              cardBgColor=lightGreyColor;
            }

            return   GestureDetector(
                onTap: ()
                {
                  print("show the selected index $index");
                  setState(() {

                    for(var i=0;i<loginOptionList.length;i++)
                      {
                        loginOptionList[i]["selectionStatus"]=false;
                      }
                    loginOptionList[index]["selectionStatus"]=true;
                  });

                  if(index==1)
                  {
                    //use for the Beneficiary
                    TalentNavigation().pushTo(context, LoginViewController(employeeRoleType: CJBENEFICIARY,navigationTitle: getTalent_LoginViewTitle,title: loginTitle,subTitle: loginSubTitle,));
                  }
                 /*else if(index==1)
                  {
                    //use for the Job Seeker
                    TalentNavigation().pushTo(context, LoginViewController(employeeRoleType: CJJOBSEEKER,navigationTitle: getJobSeeker_LoginViewTitle,title: loginTitle,subTitle: loginSubTitle,));
                  }*/
                  else  if(index==0)
                  {
                    //use for the Job Giver
                    TalentNavigation().pushTo(context, LoginViewController(employeeRoleType: CJJOBGIVER,navigationTitle: getJobGiver_LoginViewTitle,title: loginTitle,subTitle: loginSubTitle,));
                  }
                  else
                    {
                      CJSnackBar(context, "coming soon...");
                    }

                },
                child:Padding(
                  padding:  EdgeInsets.only(left: mainUILeftRightPadding,right: mainUILeftRightPadding),
                  child: Column(
                    children: [
                     Container(
                        height: 110,
                        padding: EdgeInsets.only(top: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.00)),
                          color: cardBgColor,
                          child:Row(
                            children: <Widget>[

                              Expanded(child: Row(
                                children: [
                                  Padding(padding:  EdgeInsets.only(left: 15,top: 1),
                                    child:Container(child:getRichTextForLoginOption(title, subTitle,textColorType) ,),
                                  ),
                                ],
                              ) ),

                              Container(width:46 ,child: Stack(
                                children: [
                                  Image(image: AssetImage(iconType),),
                                  Padding(padding:  EdgeInsets.only(top: 30.0, left: 20),
                                    child: Image(image: AssetImage(getLoginOption_RightWhiteArrow),),),
                                ],
                              ))

                            ],
                          ) ,
                        ),
                      ),
                    ],
                  ),
                )

            );
          }
      )
          :  Text(
        'No results found',
        style: TextStyle(fontSize: 15,color: Colors.black),
      ),
    );
  }

  /*--------------hit the LOGIN Option service request start---------------*/

  serviceBodyRequest()
  {
    print("show the request111");
    var mapObject=getJS_Intro_RequestBody(kJS_ServiceValue_LoginOption,kLoclizationValue_English);
    serviceRequest(mapObject);
  }

  serviceRequest(Map mapObj)
  {
    print("show the request2");
    print("show the request object $mapObj");

    CJJobSeekerServiceRequest().postDataServiceRequest(mapObj, JS_ApiMethod_Intro,
        cjJobSeekerResponseBlock: CJJobSeekerResponseBlock(jobSeekerSuccessBlock: <T>(success)
        {
          var response=success as IntroModelClass;
          print("show the request success");
          screenListData=response.introDetails!;

          var beneficiaryMap=Map();
          var jobSeekerMap=Map();
          var jobGiverMap=Map();

          setState(() {

            for(var obj in screenListData)
            {
              var checkScreenType=obj.screenName != "" ? obj.screenName:"";
              if(checkScreenType=="Login_Banner")
              {
                banner=obj.labelValue!;
              }
              else if(checkScreenType=="Login_title")
              {
                loginTitle=obj.labelValue!;
              }
              else if(checkScreenType=="Login_subtitle")
              {
                loginSubTitle=obj.labelValue!;
              }
              else if(checkScreenType=="Login_beneficiary_title")
              {
                beneficiaryMap["title"]=obj.labelValue != "" ? obj.labelValue:"";
              }
              else if(checkScreenType=="Login_beneficiary_subtitle")
              {
                beneficiaryMap["subTitle"]=obj.labelValue != "" ? obj.labelValue:"";
                beneficiaryMap["selectionStatus"]=true;
                print("show the login option beneficiaryMap 1 $beneficiaryMap");

              }
              else if(checkScreenType=="Login_jobseeker_title")
              {
                jobSeekerMap["title"]=obj.labelValue != "" ? obj.labelValue:"";
              }
              else if(checkScreenType=="Login_jobseeker_subtitle")
              {
                jobSeekerMap["subTitle"]=obj.labelValue != "" ? obj.labelValue:"";
                jobSeekerMap["selectionStatus"]=false;

              }
              else if(checkScreenType=="Login_jobgiver_title")
              {
                jobGiverMap["title"]=obj.labelValue != "" ? obj.labelValue:"";
              }
              else if(checkScreenType=="Login_jobgiver_subtitle")
              {
                jobGiverMap["subTitle"]=obj.labelValue != "" ? obj.labelValue:"";
                jobGiverMap["selectionStatus"]=false;
              }
              else
              {

              }
            }

            loginOptionList=[];
            loginOptionList.add(beneficiaryMap);
            loginOptionList.add(jobSeekerMap);
            loginOptionList.add(jobGiverMap);

          });


        }, jobSeekerFailureBlock:<T>(failure)
        {
          print("show the request failure");

        }));

  }

/*--------------hit the LOGIN Option service request end---------------*/

}

