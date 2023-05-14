import 'package:circles_background/circles_background/circles_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceKey.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../ThankhaPayViewBenefits/CommonViewTextClass.dart';
import '../ThankhaPayViewBenefits/ViewHtmlFileOnMobile.dart';
import '../ThankhaPayViewBenefits/ViewHtmlFileOnWeb.dart';
import 'TankhaPaySocialSecurityBenefitsChild.dart';

//

class TankhaPaySocialSecurityBenefits extends StatefulWidget {
  const TankhaPaySocialSecurityBenefits({super.key});

  @override
  State<TankhaPaySocialSecurityBenefits> createState() => _TankhaPaySocialSecurityBenefits();
}

class _TankhaPaySocialSecurityBenefits extends State<TankhaPaySocialSecurityBenefits>

{

  var socialSecurityList = socialSecurityBenefitModelList;

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CJAppBarBgBlue("", appBarBlock: AppBarBlock(appBarAction: ()
            {
              print("show the action 1type");
              Navigator.pop(context);
            })),
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
            title: Text(getThankhaPay_SocialSecurityBenefitsTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: whiteColor,
                  fontFamily: robotoFontFamily,
                  fontSize: 20.0),
            ),


          ),
          SizedBox(height: 20,),
          Expanded(flex: 1,child:  ListView.builder(shrinkWrap: true,
            itemCount: socialSecurityList.length,
            itemBuilder: (context, index)
            {
              var it = socialSecurityList[index];
              return ssbCard(it.title.toString(), it.image.toString(),socialSecurityList,index);
            },
          ))

        ]));
  }


  Padding ssbCard(String title, String image,List<socialSecurityBenefitModel> objList,int index)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Card(
        margin: EdgeInsets.all(15),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Color(0xff2D8BA8),
                              fontWeight: bold_FontWeight,
                              fontFamily: robotoFontFamily,
                              fontSize: listTitle_FontSize,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          width: 130,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: Color(0xff117C9E)),
                            onPressed: ()
                            {

                               var actionType=objList[index].status;
                               tapToNavigateView(actionType!);

                            },
                            child: Wrap(
                              children: [
                                Text(
                                  "Click here",
                                  style: TextStyle(
                                      fontWeight: bold_FontWeight,
                                      fontSize: medium_FontSize,
                                      fontFamily: robotoFontFamily),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.double_arrow,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Transform.scale(
                      scale: 1.2,
                      child: Image.asset(
                        image,width: 65,height: 65,
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  tapToNavigateView(String actionType)
  {
    /*if(actionType==CJThankhaPay_HealthCareBenefit)
    {
      viewHtml("medical",CJThankhaPay_HealthCareBenefit);
    }
    else if(actionType==CJThankhaPay_InsuranceBenefits)
    {
      viewHtml("Insurance",CJThankhaPay_InsuranceBenefits);

    }
    else if(actionType==CJThankhaPay_RetirementBenefits)
    {
      viewHtml("Retirement",CJThankhaPay_RetirementBenefits);

    }
    else if(actionType==CJThankhaPay_OtherBenefits)
    {
      viewHtml("Other",CJThankhaPay_OtherBenefits);

    }
    else
    {

    }*/

    if(actionType==CJThankhaPay_HealthCareBenefit)
    {
      view(kTankhaPay_Benefit_CategoryType_HealthCare,CJThankhaPay_HealthCareBenefit);
    }
    else if(actionType==CJThankhaPay_InsuranceBenefits)
    {
      view(kTankhaPay_Benefit_CategoryType_Insurance,CJThankhaPay_InsuranceBenefits);

    }
    else if(actionType==CJThankhaPay_RetirementBenefits)
    {
      view(kTankhaPay_Benefit_CategoryType_Benefit,CJThankhaPay_RetirementBenefits);

    }
    else if(actionType==CJThankhaPay_OtherBenefits)
    {
      view(kTankhaPay_Benefit_CategoryType_Other,CJThankhaPay_OtherBenefits);

    }
    else
    {

    }
  }
//
 /* viewHtml(String fileName,String viewTitle)
  {
    if(kIsWeb)
      {
       // TalentNavigation().pushTo(context, ViewHtmlFileOnWeb(showFileName: fileName,titleName: viewTitle,));
      }
     else
      {
        TalentNavigation().pushTo(context, ViewHtmlFileOnMobile(showFileName:fileName,titleName: viewTitle,));
      }
  }*/

  view(String fileName,String viewTitle)
  {

    TalentNavigation().pushTo(context, CommonViewTextClass(showFileName:fileName,titleName: viewTitle,));

  }


}
