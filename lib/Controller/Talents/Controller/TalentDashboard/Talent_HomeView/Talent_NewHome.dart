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

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/CJJobSeekerService/CJJobSeekerServiceRequest.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../ModelClasses/CJTalentCommonModelClass.dart';
import '../../../TalentNavigation/TalentNavigation.dart';
import '../Talent_Employer/Talent_Employer/Talent_AddEmployer.dart';
import '../Talent_LeftDrawer/Talent_LeftDrawer.dart';
import 'Talent_HomeChild.dart';
import 'Talent_NewHomeChild.dart';

class Talent_NewHome extends StatefulWidget
{
  const Talent_NewHome({Key? key}) : super(key: key);

  @override
  State<Talent_NewHome> createState() => _Talent_NewHome();
}

class _Talent_NewHome extends State<Talent_NewHome>
{

  static const profileTitleColor = Color(0xff107A9D);
  static const profileSubTitleColor = Color(0xff282828);

  static const downColor1 = Color(0xffE6E6E6);
  static const downColor2 = Color(0xffE0E0D4);
  static const greyColor = Color(0xffA9A9A9);
  final List<CircleInfo> circles = getCircleInfoForHome;

  bool checkBoxValue = false;
  static List<CJHomeModelClass> cjList = getNewHomeChildList;
   BuildContext? contextType;
   String completeEmpCode="";

  @override
  Widget build(BuildContext context)
  {
    contextType=context;
    return Scaffold(
      drawer:  Navigation_Drawer(),
      backgroundColor: Colors.white,
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


  CirclesBackground MainfunctionUi()
  {
    return CirclesBackground(
      circles:circles,
      child: SingleChildScrollView(
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
                                  'Welcome Navin!',
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
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundColor: greyColor,
                                child: CircleAvatar(
                                  radius: 48.0,
                                  backgroundColor: greyColor,
                                  backgroundImage: AssetImage(Talent_Icon_BoyImage),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),

                            Padding(
                              padding: EdgeInsets.fromLTRB(60, 2, 0, 0),
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
                                                  "CJ Code:",
                                                  style: TextStyle(
                                                    fontFamily: robotoFontFamily,
                                                    fontSize: small_FontSize,
                                                    fontWeight: semiBold_FontWeight,
                                                    color: blackColor,
                                                  ),
                                                ),
                                                SizedBox(width:10),
                                                Text(
                                                  "45655",
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: Image(
                                      image: AssetImage(Talent_Icon_KYC),
                                      height: 38,
                                      width: 44,
                                    ),
                                  ),
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

                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: cjList.length,
                        physics: NeverScrollableScrollPhysics(),

                        itemBuilder: (context, index) => cjCardTemplate(cjList[index],index),
                      )

                    ],
                  ))
          ),
        )
    ),);
  }

  Widget cjCardTemplate(dynamicObj,int selectedIndex)
  {
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
                    colors: [Color(0xffe4eff5), Color(0xffadbcc5)],
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
                              title: Text("${dynamicObj.name}",
                                  style: TextStyle(
                                    color: profileTitleColor,
                                    fontWeight: bold_FontWeight,
                                    fontFamily: robotoFontFamily,
                                    fontSize: listTitle_FontSize,
                                  )),
                              subtitle: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
                                child: Text("${dynamicObj.profile}",
                                    style: TextStyle(
                                      color: profileSubTitleColor,
                                      fontWeight: normal_FontWeight,
                                      fontFamily: robotoFontFamily,
                                      fontSize: listSubTitle_FontSize,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 20, 8, 20),
                              child: Container(
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
                                      print("show the selected index $selectedIndex");

                                      var obj=cjList[selectedIndex];

                                      if(obj.selectedViewType==CJTALENT_SalaryStatus)
                                        {
                                          TalentNavigation().pushTo(context, Talent_SalaryStatus());
                                        }
                                      else if(obj.selectedViewType==CJTALENT_InvestmentDeclaration)
                                      {
                                        TalentNavigation().pushTo(context, investment_declaration());
                                      }
                                      else if(obj.selectedViewType==CJTALENT_HealthInsurance)
                                      {
                                        insuranceStatusServiceBodyRequest();
                                       // TalentNavigation().pushTo(context, insurance_ViewInsuranceCard());

                                      }
                                      else
                                        {

                                        }
                                    },
                                    label: Text(
                                      "Click Here",
                                      style: TextStyle(
                                          fontWeight: bold_FontWeight,
                                          fontSize: medium_FontSize,
                                          fontFamily: robotoFontFamily),
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
                              image: AssetImage("${dynamicObj.image}"),
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

  /*--------------hit the insurance status service request start(25-11-2022)---------------*/

  insuranceStatusServiceBodyRequest()
  {
    completeEmpCode="9569734648CJHUB5610CJHUB14/05/1988";

    print("show the request111");
    var mapObject=getCJHub_InsuranceStatus_RequestBody(completeEmpCode);
    serviceRequest(mapObject);
  }

  serviceRequest(Map mapObj)
  {
    print("show the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.get_Emp_Insurance_Status,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();

          validateToTheInsuranceData(success as InsuranceStatus_ModelResponse, contextType!);

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();

          print("show the request failure");
          CJSnackBar(context, "data not found...");
          InsuranceStatus_ModelResponse insuranceStatus_ModelResponse=failure as InsuranceStatus_ModelResponse;
          if (insuranceStatus_ModelResponse.message==null || insuranceStatus_ModelResponse.message=="")
          {
          CJSnackBar(context, "data not found...");
          }
          else
          {
            CJSnackBar(context, insuranceStatus_ModelResponse.message);
          }

        }, talentHandleExceptionBlock: <T>(handleException)
        {
          CJTalentCommonModelClass commonObject= handleException as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }

        }));

  }

/*--------------hit the insurance status service request end(25-11-2022)----------------*/

}


