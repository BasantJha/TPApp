import 'package:circles_background/circles_background/circles_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceKey.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Employers/Controller/Employer_KYC/Employer_JoinerAggrementChild.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../TankhaPayModelClasses/TankhaPayFAQModelClass/TankhaPayFAQModelClass.dart';


class CommonViewTextClass extends StatefulWidget
{
  const CommonViewTextClass({Key? key, required this.showFileName, this.titleName}) : super(key: key);
  final String? showFileName;
  final String? titleName;

  @override
  State<CommonViewTextClass> createState() => _CommonViewTextClass();
}

class _CommonViewTextClass extends State<CommonViewTextClass> {

  TankhaPayFAQModelClass? tankhaPayFAQModelClass=  TankhaPayFAQModelClass(statusCode:false, message:"", data:[Data(question: "",answer: "")]);
  String headingTitle="",headingDesc="";
  String deviceType="",IPAddress="";
  String showHeading="";

  String question="",answer="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.titleName==CJThankhaPay_PrivacyPolicy || widget.titleName==CJThankhaPay_TermsOfUse)
    {
      //privacy policy and terms of use
      showHeading=widget.titleName!;
    }
    else
    {
      //benefit html
      showHeading=getThankhaPay_SocialSecurityBenefitsTitle;

    }

    createBodyWebApiFor_Benefits();
  }


  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
        child: Scaffold(
          appBar:CJAppBarBgBlueForHTMLView("", appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show the action type");
            Navigator.pop(context);
          })),
          body:getResponsiveUI() ,
         /* bottomNavigationBar: Padding(padding: EdgeInsets.only(left: elevatedButtonLeftRightPadding,right:elevatedButtonLeftRightPadding ),
            child: elevatedButtonBottomBar(),) ,*/
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

  CirclesBackground  MainfunctionUi()
  {
    return CirclesBackground(
      circles:getCircleInfoForHome,
      child: getTheCustomColumn(),);
  }

  Container getTheCustomColumn() {
    return Container(
        padding: EdgeInsets.only(left: 5, right: 5), child: Column(
        children: [

          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(showHeading,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: whiteColor,
                  fontFamily: robotoFontFamily,
                  fontSize: 20.0),
            ),


          ),
          SizedBox(height: 10,),

          ListTile(
           // visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(question,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: blackColor,
                  fontFamily: robotoFontFamily,
                  fontSize: 20.0),
            ),


          ),

         // SizedBox(height: 20,),

          Expanded(flex: 1,child: SingleChildScrollView(scrollDirection: Axis.vertical,child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 15.0, vertical: 10),
            child: answer=="" ? Text(
              answer,
              style: const TextStyle(
                  color: blackColor, fontSize: 16),
            ):Html(data:answer.toString()),
          ) ,))



        ]));
  }


  createBodyWebApiFor_Benefits()
  {
    var mapObject=getCJHub_EmployeeFAQ_RequestBody(widget.showFileName!);
    serviceRequest_Benefits(mapObject);
  }
  serviceRequest_Benefits(Map mapObj)
  {
    print("show 1the request12");
    print("show the// request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.getTankhaPay_FAQ,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          TankhaPayFAQModelClass faqModelClass=success as TankhaPayFAQModelClass;
          if(faqModelClass?.statusCode==true)
          {
            setState(() {
              if(faqModelClass.data!.length>0)
                {
                  question=faqModelClass.data![0].question!;
                  answer=faqModelClass.data![0].answer!;
                }
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

}


