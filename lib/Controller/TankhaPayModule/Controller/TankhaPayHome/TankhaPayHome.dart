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
import 'package:contractjobs/Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:marquee/marquee.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/CJJobSeekerService/CJJobSeekerServiceRequest.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../CustomView/CircleAvatar/CircleAvatar.dart';
import '../../../JoiningProfile/JoiningProfileModelClass/EmployeeKYCStatusModelClass.dart';
import '../../../JoiningProfile/KYCModule/Aadhar_Verification.dart';
import '../../../JoiningProfile/KYCModule/UAN_Verification.dart';
import '../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_NewHomeChild.dart';
import '../../../Talents/Controller/TalentDashboard/Talent_LeftDrawer/Talent_LeftDrawer.dart';
import '../../../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../TankhaPayAttendanceTabs/TankhaPayAttendanceTabs.dart';
import '../TankhaPayBenefits/TankaPayBenefits/TankhaPayBenefits.dart';
import '../TankhaPayDrawer/TankhaPayDrawer.dart';
import '../TankhaPayProfile/TankhaPayProfile.dart';
import '../ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfileChild.dart';
import 'TankhaPayHomeChild.dart';


class TankhaPayHome extends StatefulWidget
{
  const TankhaPayHome({Key? key, this.liveModelObject}) : super(key: key);
  final VerifyOTP_ModelResponse? liveModelObject;

  //final EmployeeKYCStatusModelClass? profileData;


  @override
  State<TankhaPayHome> createState() => _TankhaPayHome();
}

class _TankhaPayHome extends State<TankhaPayHome>
{

  static const profileTitleColor = Color(0xff107A9D);
  static const profileSubTitleColor = Color(0xff282828);

  static const downColor1 = Color(0xffE6E6E6);
  static const downColor2 = Color(0xffE0E0D4);
  static const greyColor = Color(0xffA9A9A9);
  final List<CircleInfo> circles = getCircleInfoForHome;

  bool checkBoxValue = false;
  static List<CJTankhaPayHomeModelClass> cjList = getTankhaPayHomeChildList;
  BuildContext? contextType;
  String completeEmpCode="";

  String showEmpName="",showEmpCode="";
  EmployeeKYCStatusModelClass? profileData;
  String jsId="",empName="",tpCode="",photopath="";

  bool checkAadharVerification_Visibility=false;
  bool checkUANVerification_Visibility=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //getEmployeeDetails();

    jsId=widget.liveModelObject!.data!.jsId.toString();
    empName=widget.liveModelObject!.data!.empName.toString();
    tpCode=widget.liveModelObject!.data!.tpCode.toString();

    createBodyWebApi_VerifyKYCStatusForEmployee();

  }

  @override
  Widget build(BuildContext context)
  {
    contextType=context;
    return Scaffold(
      drawer:  TankhaPayDrawer(liveModelObject: widget.liveModelObject,),
      backgroundColor: Colors.white,
      body: getResponsiveUI(),
    );
  }
//
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
      child: SafeArea(
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
                                'Welcome $empName!',
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
                          SizedBox(
                            child: /*CircleAvatar(
                              radius: 50.0,
                              backgroundColor: greyColor,
                              child: CircleAvatar(
                                radius: 48.0,
                                backgroundColor: greyColor,
                                backgroundImage: AssetImage(Talent_Icon_BoyImage),
                              ),
                            )*/  CircleAvatar(
                                radius: 50,
                                child: photopath == null || photopath==""
                                    ? getProfileName(getProfileEmpName(empName))
                                    : ClipOval(child:Image.network(photopath!, width: 100, height: 100,
                                  fit: BoxFit.cover,) ,)
                            ),
                          ),


                          SizedBox(height: 10,),

                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'KYC Verified:',
                                                style: TextStyle(
                                                  fontFamily: robotoFontFamily,
                                                  fontSize: small_FontSize,
                                                  fontWeight: semiBold_FontWeight,
                                                  color: blackColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Image(image: AssetImage(Verification_Icon))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                getTPCode,
                                                style: TextStyle(
                                                  fontFamily: robotoFontFamily,
                                                  fontSize: small_FontSize,
                                                  fontWeight: semiBold_FontWeight,
                                                  color: blackColor,
                                                ),
                                              ),
                                              SizedBox(width:3),
                                              Text(tpCode,
                                                style: TextStyle(
                                                  fontFamily: robotoFontFamily,
                                                  fontSize: small_FontSize,
                                                  fontWeight: semiBold_FontWeight,
                                                  color: blackColor,
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    )),

                              ],
                            ),
                          )

                        ],
                      ),
                      padding: EdgeInsets.only(top: 5, bottom: 10),
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

                    /*---------17-2-2023 start-----*/
                    checkAadharVerification_Visibility==true ?Container(height: 35,padding: EdgeInsets.only(top: 5,bottom: 10),child:  InkWell(onTap: ()
                    {


                      pushToEmployeeAadharUAN(context, Aadhar_Verification(verifyOTP_ModelResponse: widget.liveModelObject,employeeAadharArriveFrom:TankhaPay_EmployeeHome));


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

                    checkUANVerification_Visibility==true ?Container(height: 35,padding: EdgeInsets.only(top: 5,bottom: 10),child:  InkWell(onTap: ()
                    {

                      //employeeUANArriveFrom
                      pushToEmployeeAadharUAN(context, UAN_Verification(verifyOTP_ModelResponse: widget.liveModelObject,employeeUANArriveFrom:TankhaPay_EmployeeHome));


                    },child: Marquee(
                      text: 'Please add your UAN with 15 days in order to receive your salary on time.',
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

                    Expanded(flex: 1,child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cjList.length,
                     // physics: NeverScrollableScrollPhysics(),

                      itemBuilder: (context, index) => cjCardTemplate(cjList[index],index,widget.liveModelObject!,context),
                    ))

                  ],
                ))
        ),
      ),);
  }
  pushToEmployeeAadharUAN<T>(BuildContext context,navigateView)
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



  getEmployeeDetails()
  {
    SharedPreference.getEmpName().then((value) =>  {
      print('show emp showEmpName $value'),
      setState(() {
        showEmpName=value;
      })

    });
    SharedPreference.getEmpCode().then((value) =>  {
      print('show emp showEmpCode $value'),

      setState(() {
      showEmpCode=value;
    })

    });
  }
  /*-------------GET BENEFIT DATA START-----------------*/

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

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.get_EmployeeKYC_Status,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();

          EmployeeKYCStatusModelClass profileData=success as EmployeeKYCStatusModelClass;
          if(profileData.statusCode==true)
          {

            setState(() {
              jsId=profileData.data!.jsId.toString();
              empName=profileData.data!.empName.toString();
              photopath=profileData.data!.photopath;

              /*--------17-2-2023 start-------*/
              String checkAadhaarVerificationStatus=profileData.data!.aadharverficationStatus.toString();
              //checkAadhaarVerificationStatus=TankhaPay_Aadhaar_NR;
               if(checkAadhaarVerificationStatus==TankhaPay_Aadhaar_NR)
                 {
                   checkAadharVerification_Visibility=true;
                 }
                else
                 {
                   checkAadharVerification_Visibility=false;
                 }

              String checkUANVerificationStatus=profileData.data!.pfopted.toString();

             // checkUANVerificationStatus=TankhaPay_UANIsOpted;
              if(checkUANVerificationStatus==TankhaPay_UANIsOpted)
              {
                checkUANVerification_Visibility=true;
              }
              else
              {
                checkUANVerification_Visibility=false;
              }

                //checkUANVerification_Visibility
              /*--------17-2-2023 end-------*/

            });
          }

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();
          CJTalentCommonModelClass commonObject= failure as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }
        }, talentHandleExceptionBlock: <T>(handleException)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= handleException as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }

        }));
  }
/*-------------GET BENEFIT DATA END-----------------*/

}


