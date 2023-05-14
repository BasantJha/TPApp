import 'package:carousel_slider/carousel_slider.dart';
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
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../CustomView/HintWidget/HintWidget.dart';
import '../../../../../Services/CJJobSeekerService/CJJobSeekerServiceRequest.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../JoiningProfile/JoiningProfileModelClass/EmployeeKYCStatusModelClass.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../TankhaPayDrawer/TankhaPayDrawer.dart';
import '../../TankhaPayHome/TankhaPayHomeChild.dart';
import '../TankhaPaySocialSecurityBenefits/TankhaPaySocialSecurityBenefits.dart';
import 'TankhaPayBenefitsChild.dart';



class TankhaPayBenefits extends StatefulWidget
{
  const TankhaPayBenefits({Key? key,this.visibilityStatusForTankhaPayBenefits, this.liveModelObject}) : super(key: key);
  final bool? visibilityStatusForTankhaPayBenefits;
  final VerifyOTP_ModelResponse? liveModelObject;

  @override
  State<TankhaPayBenefits> createState() => _TankhaPayBenefits();
}

class _TankhaPayBenefits extends State<TankhaPayBenefits>
{


  final GlobalKey globalKeyOne = GlobalKey();
  final GlobalKey globalKeyTwo = GlobalKey();
  final GlobalKey globalKeyThree = GlobalKey();

  bool checkBoxValue = false;
  BuildContext? contextType;
  String completeEmpCode="";

  var benifitCardList = getThankaPayData;
  var lstcard = <Widget>[];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  bool tankhaPayBenefits_Visibility=true;

  EmployeeKYCStatusModelClass? profileData;

  var uanNumber;
  var esicNumber;
  var dispensaryNumber;
  String jsId="";
  String benefitMessage="";

  /*_TankhaPayBenefits(bool visibilityStatusForTankhaPayBenefits)
  {
    tankhaPayBenefits_Visibility=visibilityStatusForTankhaPayBenefits;
  }*/

 @override
  void initState()
  {
    super.initState();


    tankhaPayBenefits_Visibility=widget.visibilityStatusForTankhaPayBenefits!;
    jsId=widget.liveModelObject!.data!.jsId;

    createBodyWebApi_VerifyKYCStatusForEmployee();

  }
  @override
  Widget build(BuildContext context)
  {
    contextType=context;
    return Scaffold(
      drawer:  TankhaPayDrawer(liveModelObject: widget.liveModelObject,),
      backgroundColor: whiteColor,
      appBar: tankhaPayBenefits_Visibility ? CJAppBarBgBlue("", appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action 1type");
        Navigator.pop(context);
      })): null,
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
  Padding getTheCustomColumn()
  {
    return Padding(padding: EdgeInsets.only(left: 15,right: 15),child: Column(
      children: [

        ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Text("Benefits",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: whiteColor,
                fontFamily: robotoFontFamily,
                fontSize: 20.0),
          ),


        ),
        SizedBox(height: 35,),

        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: darkGreyColor)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              /* title: Center(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Congratulations!",
                      style: TextStyle(
                        color: lightBlueColor,
                        fontSize: 25,
                        fontWeight: bold_FontWeight,
                        fontFamily: robotoFontFamily,
                      ),
                    ),
                    Image.asset(congratulations_Icon),
                  ],
                ),
              ),*/
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Center(
                  child: Text(
                    benefitMessage,
                    style: TextStyle(
                      color: blackColor,
                      // fontSize: small_FontSize,
                      fontWeight: semiBold_FontWeight,
                      fontFamily: robotoFontFamily,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 35,
        ),
        SizedBox(
          height: 180,
          child: ListView(
            children: [
              CarouselSlider(
                items: lstcard,
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: false,
                    padEnds: false,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: false,
                    aspectRatio: 16 / 5,
                    viewportFraction: 0.72,
                    onPageChanged: (index, reason)
                    {
                      setState(()
                      {
                        //_current = index;
                      });
                    }),
              ),
            ],
          ),
        ),
//
        Expanded(flex: 1,child: Container(height: 200,child: SingleChildScrollView(scrollDirection: Axis.vertical,child:raise_bill_card(context,
            "Social Security Benefits",
            "A comphrehensive guide to social security benefits",
            TankhaPay_Icon_Benefits,
            "Click here") ,),))

      ],
    ),);
  }

  SingleChildScrollView getTheCustomColumn1()
  {
    return SingleChildScrollView(padding: EdgeInsets.only(left: 15,right: 15),child: Column(
      children: [

        ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Text("Benefits",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: whiteColor,
                fontFamily: robotoFontFamily,
                fontSize: 20.0),
          ),


        ),
        SizedBox(height: 35,),

        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: darkGreyColor)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
             /* title: Center(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Congratulations!",
                      style: TextStyle(
                        color: lightBlueColor,
                        fontSize: 25,
                        fontWeight: bold_FontWeight,
                        fontFamily: robotoFontFamily,
                      ),
                    ),
                    Image.asset(congratulations_Icon),
                  ],
                ),
              ),*/
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Center(
                  child: Text(
                    benefitMessage,
                    style: TextStyle(
                      color: blackColor,
                      // fontSize: small_FontSize,
                      fontWeight: semiBold_FontWeight,
                      fontFamily: robotoFontFamily,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 35,
        ),
        SizedBox(
          height: 180,
          child: ListView(
            children: [
              CarouselSlider(
                items: lstcard,
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: false,
                    padEnds: false,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: false,
                    aspectRatio: 16 / 5,
                    viewportFraction: 0.72,
                    onPageChanged: (index, reason)
                    {
                      setState(()
                      {
                        //_current = index;
                      });
                    }),
              ),
            ],
          ),
        ),

        raise_bill_card(context,
            "Social Security Benefits",
            "A comphrehensive guide to social security benefits",
            TankhaPay_Icon_Benefits,
            "Click here"),
      ],
    ),);
  }



  Padding benefitsCard(String index, String title, String num,String hint)
  {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Card(
        color: Colors.grey[300],
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: darkGreyColor,
            )),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey.shade300],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListTile(
            title: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: lightBlueColor,
                  child: Text(
                    index,
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: largeExcel_FontSize,
                      fontWeight: bold_FontWeight,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: bold_FontWeight,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                /*CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.cyan[400],
                  child: Text(
                    "i",
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: smallLess_FontSize,
                        fontStyle: FontStyle.italic),
                  ),
                )*/

                HintWidget(
                  globalKey: (index == "1")
                      ? globalKeyOne
                      : (index == "2")
                      ? globalKeyTwo
                      : globalKeyThree,
                  title: title,
                  description: hint,
                  child: InkWell(
                    onTap: ()
                    {
                      print("hello");
                      (index == "1")

                          ? WidgetsBinding.instance.addPostFrameCallback((_) =>
                          ShowCaseWidget.of(context)
                              .startShowCase([globalKeyOne]))
                          : (index == "2")
                          ? WidgetsBinding.instance.addPostFrameCallback(
                              (_) => ShowCaseWidget.of(context)
                              .startShowCase([globalKeyTwo]))
                          : WidgetsBinding.instance.addPostFrameCallback(
                              (_) => ShowCaseWidget.of(context)
                              .startShowCase([globalKeyThree]));
                    },
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.cyan[400],
                      child: Text(
                        "i",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: medium_FontSize,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                )
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
              child: (num == "null" || num == "") ? blinkDots :Text(
                /*(num == "null" || num == "") ? "In Process..." :*/ num,
                style:
                TextStyle(color: blackColor, fontSize: 16),
              ),
            ),

            trailing: (title == "ESIC IP no." && num != "")
                ? InkWell(onTap: ()
            {
              //download the ESIC Number
            },child: Icon(
              Icons.download,
              size: 20,
            ),)
                : null,
          ),
        ),
      ),
    );
  }
  var blinkDots = SpinKitThreeBounce(
    color: Colors.blue,
    size: 25.0,
  );

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
///
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.get_EmployeeKYC_Status,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();

          EmployeeKYCStatusModelClass employeeKYCStatusModelClass=success as EmployeeKYCStatusModelClass;
          if(employeeKYCStatusModelClass.statusCode==true)
          {

            print("show the benefit data");
            setState(() {
              profileData=employeeKYCStatusModelClass;

              benefitMessage=profileData!.data!.benifitmsg;

               uanNumber=profileData?.data?.uannumber;
               if(uanNumber=="" || uanNumber==null)
                 {
                   uanNumber="";
                 }
               benifitCardList[0].number=uanNumber;

               esicNumber=profileData?.data?.esinumber;
              if(esicNumber=="" || esicNumber==null)
              {
                esicNumber="";
              }
              benifitCardList[1].number=esicNumber;
//
              dispensaryNumber=profileData?.data?.dispensarydetails;
              if(dispensaryNumber=="" || dispensaryNumber==null)
              {
                dispensaryNumber="";
              }
              benifitCardList[2].number=dispensaryNumber;

              lstcard = benifitCardList.map((e) => benefitsCard(e.index.toString(), e.title.toString(), e.number.toString(), e.hint.toString())).toList();

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
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }

        }));
  }
   /*-------------GET BENEFIT DATA END-----------------*/

}



