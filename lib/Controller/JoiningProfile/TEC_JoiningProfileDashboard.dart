import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/JoiningProfile/KYCModule/Aadhar_Verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../Constant/CJAppFlowConstants.dart';
import '../../CustomView/AlertView/Alert.dart';
import '../../CustomView/CJAnimationClass/CJAnimationClass.dart';
import '../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../CustomView/CircleAvatar/CircleAvatar.dart';
import '../../CustomView/LogoutView/Logout.dart';
import '../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../Services/Messages/Message.dart';
import '../Employers/Controller/EmployerDashboard/Employer_LeftDrawer/Employer_LeftDrawer.dart';
import '../LoginView/Controller/LoginOptionController.dart';
import '../Talents/Controller/CJHubTECModule/CJHubTECView/profile_personalDetails_edit.dart';
import '../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../Talents/Controller/TalentDashboard/Talent_LeftDrawer/Talent_LeftDrawer.dart';
import '../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../Talents/ModelClasses/CJHubModelClasses/Verify_Mobile_ModelResponse.dart';
import '../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../Talents/TalentNavigation/TalentNavigation.dart';
import '../TankhaPayModule/Controller/TankhaPayDrawer/TankhaPayDrawer.dart';
import '../TankhaPayModule/Controller/TankhaPayTabBarController/TankhaPay_TabBarController.dart';
import '../TankhaPayModule/Controller/ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfileChild.dart';
import 'JoiningProfileModelClass/EmployeeKYCStatusModelClass.dart';
import 'KYCModule/PAN_Verification.dart';
import 'KYCModule/UAN_Verification.dart';
import 'TEC_BankInfoVerify.dart';
import 'TEC_JoiningProfileChild.dart';
import 'TEC_JoiningProfileUpdate.dart';


class TEC_JoiningProfileDashboard extends StatefulWidget
{
  TEC_JoiningProfileDashboard({ Key? key, this.verifyOTP_ModelResponse}) : super(key: key);
  final VerifyOTP_ModelResponse? verifyOTP_ModelResponse;


  @override
  State<TEC_JoiningProfileDashboard> createState() => _TEC_JoiningProfileDashboard();
}

class _TEC_JoiningProfileDashboard extends State<TEC_JoiningProfileDashboard>
{


  static const downColor1 = Color(0xffE6E6E6);
  static const greyColor = Color(0xffA9A9A9);

  //var joiningProfileScaffoldkey = GlobalKey<ScaffoldState>();
  final List<CircleInfo> circles = getCircleInfoForHome;

  bool checkBoxValue = false;
  List<CJJoiningProfile> cjJoiningProfileArr = cjJoiningProfileList;
  BuildContext? buildContext;
  String jsId="",empName="-",tpCode="",photoPath="";

  String showTheHintMessage="Please follow the steps below to complete setting up your account";


  var hintTextColor = Colors.black;

  String aadhaarVerificationStatus="";


  //3708

  EmployeeKYCStatusModelClass? employeeKYCStatusModelClass;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBasicInfo();
  }

  getBasicInfo()
  {

    jsId=widget.verifyOTP_ModelResponse!.data!.jsId;
    print("show the joining profile jsid $jsId");

    createBodyWebApi_VerifyKYCStatusForEmployee();
  }
//
  @override
  Widget build(BuildContext context)
  {
    //
    buildContext=context;
    return WillPopScope(onWillPop: ()
    {
      return  Message.alert_dialogAppExit(context);

    }, child:Scaffold(/*key:joiningProfileScaffoldkey,*/backgroundColor: whiteColor ,
        appBar:AppBar(
          backgroundColor: Color(0xff93d9fd),
          leading: IconButton(
            icon: ImageIcon(
                AssetImage(Menu_Icon),color: Color(0xff93d9fd),),
            onPressed: ()
            {
              //joiningProfileScaffoldkey.currentState?.openDrawer();
            },
          ),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: ()
                {
                  logout(context);
                },
                icon: ImageIcon(
                    AssetImage(TankhaPay_JoinerLogout_Icon))),
          ],
        ),
        // drawer: Navigation_Drawer(),
        body: WillPopScope(
          child:getResponsiveUI(),
          onWillPop: ()
          {
            return Message.alert_dialogAppExit(context);
          },
        )
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



  MainfunctionUi()
  {
    return CirclesBackground(
      circles:circles,
      child:  SafeArea(
            child: Center(
                child: Padding(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Container(
                                  padding: EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    'Welcome $empName',
                                    style: TextStyle(
                                      color: Color(0xff5C5C5C),
                                      fontSize: large_FontSize,
                                      fontFamily: robotoFontFamily,
                                      fontWeight: bold_FontWeight,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                             // SizedBox(child: getCircleAvatarJoiner(empName),),

                              SizedBox(
                                child:  CircleAvatar(
                                    radius: 50,
                                    child: photoPath == null || photoPath==""
                                        ? getProfileName(getProfileEmpName(empName))
                                        : ClipOval(child:Image.network(photoPath, width: 100, height: 100,
                                      fit: BoxFit.cover,) ,)
                                ),
                              ),



                              Center(
                                child: Container(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Support Number',
                                        style: TextStyle(
                                          fontFamily: robotoFontFamily,
                                          fontSize: small_FontSize,
                                          fontWeight: semiBold_FontWeight,
                                          color: darkBlueColor,
                                        ),
                                      ),
                                      /*  SizedBox(
                                        width: 10,
                                      ),
                                      Image(image: AssetImage(unVerify_Icon))*/
                                    ],
                                  ),
                                ),
                              ),


                              Center(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${widget.verifyOTP_ModelResponse?.data?.supportNumber}",
                                        style: TextStyle(
                                          fontFamily: robotoFontFamily,
                                          fontSize: medium_FontSize,
                                          fontWeight: semiBold_FontWeight,
                                          color: blackColor,
                                        ),
                                      ),
                                      /* SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        '$tpCode ',
                                        style: TextStyle(
                                          fontFamily: robotoFontFamily,
                                          fontSize: small_FontSize,
                                          fontWeight: semiBold_FontWeight,
                                          color: blackColor,
                                        ),
                                      ),*/
                                    ],
                                  ),
                                ),
                              ),


                            ],
                          ),
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          margin: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: downColor1),
                            borderRadius: BorderRadius.circular(15.0),
                            gradient: LinearGradient(
                              colors: [Color(0xffFEFEFE), Color(0xffE6E6E6)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),

                        Container(child: Padding(padding: EdgeInsets.only(left: 20,right: 20),
                          child: Text(showTheHintMessage,
                            textAlign: TextAlign.center,style: TextStyle(fontSize: medium_FontSize,color:
                            hintTextColor,fontWeight: bold_FontWeight,fontFamily: robotoFontFamily),),),),

                        SizedBox(height: 10,),
                       Expanded(flex: 1,child:  ListView.builder(

                         itemCount: cjJoiningProfileArr.length,
                         itemBuilder: (context, index)
                         {
                           return cjJoiningProfileCardTemplate(cjJoiningProfileArr,cjJoiningProfileArr[index],index,buildContext!,widget.verifyOTP_ModelResponse);
                         },
                       ))

                      ],
                    ))
            ),
          )
     );

  }


  Container  cjJoiningProfileCardTemplate(List<CJJoiningProfile> cjJoiningProfileList,
      cjJoiningObj,int selectedIndex,BuildContext context,VerifyOTP_ModelResponse? verifyOTP_ModelResponse)
  {
    const profileTitleColor = Color(0xff107A9D);
    const profileSubTitleColor = Color(0xff282828);
    const downColor2 = Color(0xffE0E0D4);
    var kycStatus_Visibility=false;

    print("show the cjJoiningProfileList $cjJoiningProfileList");
    print("show the selectedIndex $selectedIndex");

    if(cjJoiningProfileList[selectedIndex].kycStatus=="N")
    {
      //N
      kycStatus_Visibility=false;
    }
    else
    {
      //Y
      kycStatus_Visibility=true;
    }


    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        //elevation: 12,
          margin: EdgeInsets.all(15),
          color: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: downColor2),
                  gradient: LinearGradient(
                    colors: [Color(0xffF6F6F6), Color(0xffE0E0D4)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                  "${cjJoiningObj.title}",

                                  style: TextStyle(
                                    color: profileTitleColor,
                                    fontWeight: bold_FontWeight,
                                    fontFamily: robotoFontFamily,
                                    fontSize: listTitle_FontSize,
                                  )
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
                                child: Text(
                                    "${cjJoiningObj.subTitle}",

                                    style: TextStyle(
                                      color: profileSubTitleColor,
                                      fontWeight: normal_FontWeight,
                                      fontFamily: robotoFontFamily,
                                      fontSize: listSubTitle_FontSize,
                                    )
                                ),
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                              child: kycStatus_Visibility ?
                              Container(
                                height: 35,

                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Image.asset(checkGreen_Icon),
                                ),
                              ):Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff12ADDD),
                                      Color(0xff0F8FB6),
                                      Color(0xff0C708E)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ElevatedButton.icon(
                                    onPressed: ()
                                    {
                                      print("show the response");
                                      var selectedObj=cjJoiningProfileList[selectedIndex];
                                      var actionType=selectedObj.actionStatus;
                                      var kycAAPPUU_Object=selectedObj.kycAAPPUU;
//

                                      if(actionType==CJJoiningProfile_UpdatePersonalDetails)
                                      {
                                       TalentNavigation().pushTo(context, TEC_JoiningProfileUpdate(liveModelObj: verifyOTP_ModelResponse,));
                                      }
                                      else if(actionType==CJJoiningProfile_UpdateKYC)
                                      {
                                        if(kycAAPPUU_Object=="1")
                                        {
                                          pushBottomToTop(context, Aadhar_Verification(verifyOTP_ModelResponse: verifyOTP_ModelResponse,));
                                        }
                                        else if(kycAAPPUU_Object=="2")
                                        {
                                          pushBottomToTop(context, PAN_Verification(verifyOTP_ModelResponse: verifyOTP_ModelResponse,aadharVerificationStatus: aadhaarVerificationStatus,));

                                        }
                                        else if(kycAAPPUU_Object=="3")
                                        {
                                          pushBottomToTop(context, UAN_Verification(verifyOTP_ModelResponse: verifyOTP_ModelResponse,));

                                        }


                                      }
                                      else if(actionType==CJJoiningProfile_UpdateBankDetails)
                                      {
                                        //TalentNavigation().pushTo(context, TEC_BankInfoVerify(verifyOTP_ModelResponse: verifyOTP_ModelResponse,));

                                        /*--------23-2-2023 start----------*/
                                       // pushBottomToTop(context, TEC_BankInfoVerify(verifyOTP_ModelResponse: verifyOTP_ModelResponse,));

                                        pushTo(context, ShowCaseWidget(
                                            builder: Builder(
                                              builder: (context) => TEC_BankInfoVerify(verifyOTP_ModelResponse: verifyOTP_ModelResponse,),
                                            )));

                                        /*--------23-2-2023 end----------*/

                                      }
                                      else if(actionType==CJJoiningProfile_UpdateDocuments)
                                      {
                                        //TalentNavigation().pushTo(context, Profile_Document());
                                        CJSnackBar(context, "comming soon");
                                      }
                                      else
                                      {

                                      }

                                    },
                                    label: Text(
                                      "Click Here",

                                      style: TextStyle(
                                          fontWeight: bold_FontWeight,
                                          fontSize: medium_FontSize,fontFamily: robotoFontFamily),
                                    ),
                                    icon: Image.asset(
                                        doubleRightArrow_White_Icon),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(30),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(top:35),
                          Image(
                              image: AssetImage("${cjJoiningObj.logoIcon}"),
                              width: 70,
                              height: 70),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }


//
  createBodyWebApi_VerifyKYCStatusForEmployee()
  {
    var mapObject=getCJHub_EmployeeKYCStatus_RequestBody(jsId);
    serviceRequestForEmployee(mapObject);
  }
  serviceRequestForEmployee(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

   /* CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.get_EmployeeKYC_Status,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();

          employeeKYCStatusModelClass=success as EmployeeKYCStatusModelClass;
          if(employeeKYCStatusModelClass?.statusCode==true)
          {
            tapToNavigateToTheKYC(employeeKYCStatusModelClass!);
          }

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();

          EmployeeKYCStatusModelClass verify_mobile_modelResponseObj=failure as EmployeeKYCStatusModelClass;
          if (verify_mobile_modelResponseObj.message==null || verify_mobile_modelResponseObj.message=="")
          {
            CJSnackBar(context, "server  error!");
          }else {
            CJSnackBar(context, verify_mobile_modelResponseObj.message!);
          }
        }, talentHandleExceptionBlock: <T>(handleException)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= handleException as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server  error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }

        }));
*/

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,WebApi.get_EmployeeKYC_Status,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonModelClass=commonResponse as CJTalentCommonModelClass;

          employeeKYCStatusModelClass=modelResponse as EmployeeKYCStatusModelClass;
          if(employeeKYCStatusModelClass?.statusCode==true)
          {
            tapToNavigateToTheKYC(employeeKYCStatusModelClass!,commonModelClass.message!);
          }

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
  tapToNavigateToTheKYC(EmployeeKYCStatusModelClass modelClass,String msg)
  {

    var profileUpdateStatus=modelClass.data!.profileMinwagestate;

    var aadhaarVerificationNo=modelClass.data!.aadharverficationStatus;
    aadhaarVerificationStatus=aadhaarVerificationNo;
    var panVerificationNo=modelClass.data!.panVerificationStatus;
    //var uan_VerificationNo=modelClass.data!.uannumber;
    var uan_VerificationNo=modelClass.data!.pfopted;//use for the uan number


    var bankAccountVerificationStatus=modelClass.data!.accountVerificationStatus;
    var ecStatus=modelClass.data!.ecstatus;

    var checkTheKYCStatusFinalStatus="N";

//
    setState(() {

      //Note//
      empName=modelClass.data!.empName!;
      tpCode=modelClass.data!.tpcode.toString();
      photoPath=modelClass.data!.photopath;

      if(profileUpdateStatus=="")
      {
        cjJoiningProfileArr[0].kycStatus="N";
      }
      else
      {
        cjJoiningProfileArr[0].kycStatus="Y";
      }

      if(aadhaarVerificationNo=="N" && (panVerificationNo=="" || uan_VerificationNo==""))
      {
        print("show the 1");
        cjJoiningProfileArr[1].kycAAPPUU="1";
        cjJoiningProfileArr[1].kycStatus="N";

      }
      else
      {
        if(panVerificationNo=="")
        {
          print("show the 2");

          cjJoiningProfileArr[1].kycAAPPUU="2";
          cjJoiningProfileArr[1].kycStatus="N";
        }
        else
        {
          if(uan_VerificationNo=="")
          {
            print("show the 3");

            cjJoiningProfileArr[1].kycAAPPUU="3";
            cjJoiningProfileArr[1].kycStatus="N";
          }
          else
          {
            if(aadhaarVerificationNo=="N")
            {
              print("show the 4");

              cjJoiningProfileArr[1].kycAAPPUU="1";
              cjJoiningProfileArr[1].kycStatus="N";
            }
            print("show the 5");

          }
        }
      }

      if((aadhaarVerificationNo == "Y" || aadhaarVerificationNo == TankhaPay_Aadhaar_NR) && (panVerificationNo == "Y" || panVerificationNo == "N") && (uan_VerificationNo == "Y" || uan_VerificationNo == "N"))
      {
        print("show the 6");

        cjJoiningProfileArr[1].kycStatus="Y";
        checkTheKYCStatusFinalStatus="Y";
      }
      else
        {
          checkTheKYCStatusFinalStatus="N";
        }


      if(bankAccountVerificationStatus=="N")
      {
        cjJoiningProfileArr[2].kycStatus="N";
      }
      else
      {
        cjJoiningProfileArr[2].kycStatus="Y";
      }
    });



    if(profileUpdateStatus !="" && checkTheKYCStatusFinalStatus=="Y" && bankAccountVerificationStatus=="Y")
    {
      widget.verifyOTP_ModelResponse!.data!.empCode=modelClass.data!.empCode.toString();
      widget.verifyOTP_ModelResponse!.data!.empPhotoPath=modelClass.data!.photopath.toString();

      if(modelClass.data!.pancard != "" || modelClass.data!.pancard != null)
        {
          widget.verifyOTP_ModelResponse!.data!.empPancardNumber=modelClass.data!.pancard.toString();
        }
      else
        {
          widget.verifyOTP_ModelResponse!.data!.empPancardNumber="";
        }

      if(ecStatus==CJJOB_ECSTATUS)
      {
        TalentNavigation().pushTo(context, TankhaPay_TabBarController(liveModelObject: widget.verifyOTP_ModelResponse,));
      }
      else
      {
              //SHOW HERE THE MESSAGE IN CASE OF TEC, All kyc steps completed
        setState((){
          showTheHintMessage=msg;
          hintTextColor=greenColor;
        });

      }

    }
  }

  pushBottomToTop<T>(BuildContext context, navigateView)
  {
    Navigator.push(context, SlideBottomToTopRoute(page: Responsive(
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
    ) )).then((value)
    {
      createBodyWebApi_VerifyKYCStatusForEmployee();
    });
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
      createBodyWebApi_VerifyKYCStatusForEmployee();

    });
  }
}

