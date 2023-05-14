import 'dart:async';

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
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/CJJobSeekerService/CJJobSeekerServiceRequest.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../CustomView/AlertView/Alert.dart';
import '../../../../CustomView/CJAnimationClass/CJAnimationClass.dart';
import '../../../../CustomView/CJHubCustomView/SharedPreference.dart';
import '../../../../CustomView/CircleAvatar/CircleAvatar.dart';
import '../../../../CustomView/LogoutView/Logout.dart';
import '../../../../CustomView/ViewHint/CustomViewHint.dart';
import '../../../../CustomView/ViewHint/ViewHintText.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../JoiningProfile/KYCModule/PAN_Verification.dart';
import '../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_NewHomeChild.dart';
import '../../../Talents/Controller/TalentDashboard/Talent_LeftDrawer/Talent_LeftDrawer.dart';
import '../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../../../TankhaPayModule/Controller/TankhaPayDrawer/TankhaPayDrawer.dart';
import '../Employer_KYCModelClass/Employer_KYCStatusModelClass.dart';
import '../Employer_NewDashboard/Employer_NewPayment/Employer_NewPaymentPlan.dart';
import '../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../Employer_TabBarController/Employer_TabBarController.dart';
import 'EmployerAadhaar_Verification.dart';
import 'EmployerGST_Verification.dart';
import 'Employer_AddStartingBalance.dart';
import 'Employer_JoinerAggrement.dart';
import 'Employer_JoinerCompanyDetails.dart';
import 'Employer_JoinerHomeChild.dart';
import 'Employer_PANVerification.dart';



class Employer_JoinerHome extends StatefulWidget
{
  const Employer_JoinerHome({Key? key,   this.liveModelObj}) : super(key: key);
  final Employer_VerifyMobileNoModelClass? liveModelObj;


  @override
  State<Employer_JoinerHome> createState() => _Employer_JoinerHome();
}

class _Employer_JoinerHome extends State<Employer_JoinerHome>
{

  static const profileTitleColor = Color(0xff107A9D);
  static const profileSubTitleColor = Color(0xff282828);

  static const downColor1 = Color(0xffE6E6E6);
  static const downColor2 = Color(0xffE0E0D4);
  static const greyColor = Color(0xffA9A9A9);
  final List<CircleInfo> circles = getCircleInfoForHome;

  bool checkBoxValue = false;
  static List<CJEmployerHomeModelClass> cjList = getEmployerJoinerHomeChildList;
  BuildContext? contextType;
  String completeEmpCode="";

  String showEmpName="",showTPCode="";
  Employer_KYCStatusModelClass? modelClass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    employerKYCStatusServiceBodyRequest();

  }
///


  @override
  Widget build(BuildContext context)
  {
    //
    contextType=context;

    return WillPopScope(onWillPop: ()
    {
      return  Message.alert_dialogAppExit(context);

    }, child:Scaffold(
      //drawer:  TankhaPayDrawer(),
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
      backgroundColor: Colors.white,
      body: getResponsiveUI(),
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
                                    'Welcome $showEmpName',
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

                              SizedBox(child: getCircleAvatarJoiner(showEmpName),),



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

                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Account Number:",
                                                    style: TextStyle(
                                                      fontFamily: robotoFontFamily,
                                                      fontSize: small_FontSize,
                                                      fontWeight: semiBold_FontWeight,
                                                      color: blackColor,
                                                    ),
                                                  ),
                                                  SizedBox(width:3),
                                                  Text(showTPCode,
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

                        Padding(padding: EdgeInsets.only(left: 15,right: 15,bottom: 5),
                          child:Center(child:getViewHintTextBlack(getEmployer_JoinerHint),) ,),


                        Expanded(flex: 1,child:ListView.builder(
                          shrinkWrap: true,
                          itemCount: cjList.length,
                          //physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index)
                            {
                            return  cjCardTemplate(cjList[index],index);
                            }

                        ))

                      ],
                    ))
            ),
          )
      ,);
  }

  Container cjCardTemplate(dynamicObj,int selectedIndex)
  {
    var btnStatus=cjList[selectedIndex].status;
    var verifyBtnStatus=cjList[selectedIndex].verifyStatus;

   /* print("show the btnStatus $btnStatus");
    if(selectedIndex==0 || selectedIndex==1|| selectedIndex==2 || selectedIndex==3)
      {
        verifyBtnStatus=true;
      }
*/
/*-------------1-2-2023 start use for the icons 1,2,3,4----------------*/
    String iconName="";
    if(verifyBtnStatus==true)
      {
        if(selectedIndex==0)
        {
          iconName=Employer_Icon_BlueOne;
        }else if(selectedIndex==1)
        {
          iconName=Employer_Icon_BlueTwo;

        }
        else if(selectedIndex==2)
        {
          iconName=Employer_Icon_BlueThree;

        }
        else if(selectedIndex==3)
        {
          iconName=Employer_Icon_BlueFour;
        }
        else
        {

        }
      }
/*-------------1-2-2023 end use for the icons 1,2,3,4----------------*/


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
                    colors: [Color(0xffEAF5F9), Color(0xffEAF5F9)],
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
                                child: btnStatus ? getActionBtn(selectedIndex):getDefaultBtn,
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
                         /* Image(
                              image: verifyBtnStatus ? AssetImage(pan_Verify_Icon):AssetImage("${dynamicObj.image}"),
                              width: 70,
                              height: 70),*/

                          Image(
                              image: verifyBtnStatus ? AssetImage(iconName):AssetImage("${dynamicObj.image}"),
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

  Directionality getActionBtn(int selectedIndex)
  {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ElevatedButton.icon(
        onPressed: ()
        {
          performAction(selectedIndex);
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
    );
  }

  performAction(int index)
  {
    print("show the1 selected index $index");

    var obj=cjList[index];

    if(obj.selectedViewType==CJEMPLOYER_KYCVerification)
    {

      if(obj.userType==kEmployer_USERTYPE_Individual)
      {
        //PAN AND aadhaar VERIFICATION
        if (modelClass!.panNoIsverifyYN == "N" && modelClass!.aadharNoIsverifyYN == "N")
        {
          pushBottomToTop(context, Employer_PANVerification(liveModelObj: widget.liveModelObj,aadhaarVerificationStatus:modelClass!.aadharNoIsverifyYN ,));
        }
        else
          {
            if (modelClass!.aadharNoIsverifyYN == "N")
            {
              pushBottomToTop(context, EmployerAadhaar_Verification(liveModelObj: widget.liveModelObj,));
            }
            else
              {
                if (modelClass!.panNoIsverifyYN == "N")
                {
                  pushBottomToTop(context, Employer_PANVerification(liveModelObj: widget.liveModelObj,aadhaarVerificationStatus:modelClass!.aadharNoIsverifyYN ));
                }
              }
          }
      }
      else
      {
        //use for business(ONLY GST VERIFICATION)

        pushTo(context, ShowCaseWidget(
            builder: Builder(
              builder: (context) => EmployerGST_Verification(liveModelObj: widget.liveModelObj,),
            )));

      }

    }
    else if(obj.selectedViewType==CJEMPLOYER_SetUpCompanyDetails)
    {

      pushTo(context, ShowCaseWidget(
          builder: Builder(
            builder: (context) => Employer_JoinerCompanyDetails(employer_kycStatusModelClass: modelClass!,liveModelObj: widget.liveModelObj,),
          )));
    }
    else if(obj.selectedViewType==CJEMPLOYER_EmployerTermsandConditions)
    {
      pushTo(context, Employer_JoinerAggrement(liveModelObj: widget.liveModelObj,));
    }
    else if(obj.selectedViewType==CJEMPLOYER_EmployerAddStartingBalance)
    {
      //CJSnackBar(context, "COMMING SOON");
      pushTo(context, Employer_AddStartingBalance(liveModelObj: widget.liveModelObj,));
    }
    else
    {

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
      employerKYCStatusServiceBodyRequest();
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
      employerKYCStatusServiceBodyRequest();

    });
  }
/*--------------hit the insurance status service request start(25-11-2022)---------------*/

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

           modelClass = modelResponse as Employer_KYCStatusModelClass;
          CJTalentCommonModelClass commonModelClass=commonResponse as CJTalentCommonModelClass;
          if(commonModelClass?.statusCode==true)
          {
            print("show the showEmpName $showEmpName");
            //if(modelClass.signupFlag==)

           if (modelClass?.signupFlag == kEmployer_FLAG_SP && modelClass?.employerStatus>=kEmployer_STATUS_SP)
           {
             /*-------9-2-2023 start---------*/
             widget.liveModelObj?.companyName=modelClass!.companyName;
             widget.liveModelObj?.gstinNo=modelClass!.gstinNo;
             widget.liveModelObj?.panNo=modelClass!.panNo;
             widget.liveModelObj?.employerEmail=modelClass!.employerEmail;
             widget.liveModelObj?.gstinNoIsverifyYN=modelClass!.gstinNoIsverifyYN;
             widget.liveModelObj?.aadharNoIsverifyYN=modelClass!.aadharNoIsverifyYN;
             widget.liveModelObj?.employerName=modelClass!.employerName; //use for aadhar no 14-3-2023 start


             /*----------4-3-2023 start--------*/
             if(modelClass!.accountNo=="" || modelClass!.accountNo==null)
               {
                 widget.liveModelObj?.accountNo="";
               }
             else
               {
                 widget.liveModelObj?.accountNo=modelClass!.accountNo;
               }
             /*----------4-3-2023 end--------*/



             /*-------9-2-2023 end---------*/

             TalentNavigation().pushTo(context, Employer_TabBarController(liveModelObj: widget.liveModelObj,));
           }
           else
             {
               tapToLoadTheData(modelClass!);
             }
//
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

  tapToLoadTheData(Employer_KYCStatusModelClass modelObj)
  {
    int statusCount=0;
    setState(() {
      showEmpName=modelObj.employerName;
      showTPCode=modelObj.tpCode;

      int i=0;
      for (i=0;i<cjList.length;i++)
      {
        if (i == 0)
        {
          if (modelObj.userType == kEmployer_USERTYPE_Business) {
            if (modelObj.gstinNoIsverifyYN == "N") {
              cjList[i].status = true;
            }
            else {
              cjList[i].status = false;
              //show the check icons in this condition
              statusCount=kEmployer_STATUS_KYC_TEMP;
            }
          }
          if (modelObj.userType == kEmployer_USERTYPE_Individual)
          {
            if (modelObj.panNoIsverifyYN == "N" &&
                modelObj.aadharNoIsverifyYN == "N") {
              cjList[i].status = true;
            }
            else if (modelObj.panNoIsverifyYN == "Y" &&
                modelObj.aadharNoIsverifyYN == "Y") {
              cjList[i].status = false;
              //show the check icons in this condition
              statusCount=kEmployer_STATUS_KYC_TEMP;

            }
            /*-------------17-2-2023 START--------------*/
            else if (modelObj.panNoIsverifyYN == "Y" &&
                modelObj.aadharNoIsverifyYN == TankhaPay_Aadhaar_NR) {
              cjList[i].status = false;
              //show the check icons in this condition
              statusCount=kEmployer_STATUS_KYC_TEMP;
            }
            /*-------------17-2-2023 END--------------*/
            else {
              if (modelObj.panNoIsverifyYN == "Y") {
                cjList[i].status = true;
              }
              else {
                if (modelObj.aadharNoIsverifyYN == "N") {
                  cjList[i].status = true;
                }
              }
            }
          }
        }
        else
          {
            if (modelObj.signupFlag == kEmployer_FLAG_CD)
              {
                statusCount=kEmployer_STATUS_CD_TEMP;
              }
            if (modelObj.signupFlag == kEmployer_FLAG_EA || modelObj.signupFlag==kEmployer_FLAG_SPI)
              {
                statusCount=kEmployer_STATUS_EA_TEMP;
              }
            if (modelObj.signupFlag == kEmployer_FLAG_SP)
              {
                statusCount=kEmployer_STATUS_SP_TEMP;
              }
          }

        cjList[i].userType = modelObj.userType;
      }


      int j=0;
      for(j=0;j<cjList.length;j++)
        {
          print("show the first request 1");
          if(j<statusCount)
            {
              print("show the first request 2");

              cjList[j].status = false;
              cjList[j].verifyStatus = true;
            }
          else
            {
              print("show the first request 3");

              if(j==statusCount)
              {
                print("show the first request 4");

                //active single button
                cjList[j].status = true;
                cjList[j].verifyStatus = false;
              }
              else
                {
                  print("show the first request 5");

                  if(statusCount==0)
                    {
                      print("show the first request 6");

                      //enable button
                      if(j==0)
                        {
                          cjList[j].status = true;
                          cjList[j].verifyStatus = false;
                        }
                      else
                        {
                          cjList[j].status = false;
                          cjList[j].verifyStatus = false;
                        }

                    }else
                      {
                        print("show the first request 7");

                        //disable button
                        cjList[j].status = false;
                        cjList[j].verifyStatus = false;
                      }
                }
            }
        }

      cjList=cjList;

      print("show the cjList $cjList");
//

    });
  }

/*--------------hit the insurance status service request end(25-11-2022)----------------*/

}


