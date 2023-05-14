import 'package:contractjobs/Controller/Talents/Controller/CJHubInsuranceModule/insuranceStatus_ModelResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../Constant/ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
import '../../../Talents/Controller/TalentDashboard/Talent_Controller/Talent_SalaryStatus/Talent_SalaryStatus.dart';
import '../../../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../TankhaPayAttendanceTabs/TankhaPayAttendanceTabs.dart';
import '../TankhaPayBenefits/TankaPayBenefits/TankhaPayBenefits.dart';

class CJTankhaPayHomeModelClass
{
  String name;
  String profile;
  String image;
  String selectedViewType;

  CJTankhaPayHomeModelClass({required this.name, required this.profile, required this.image,required this.selectedViewType});
}

var getTankhaPayHomeChildList=[

  CJTankhaPayHomeModelClass(
      name: "Mark Attendance",
      profile: "Mark your daily attendance.",
      image: TankhaPay_Icon_TankhaMarkAttendanceIcon,selectedViewType: CJTALENT_MarkAttendance),
  CJTankhaPayHomeModelClass(
      name: "Salary Status",
      profile: "Check your salary status & download salary slip",
      image: Talent_Icon_SalaryStatus,
      selectedViewType:CJTALENT_SalaryStatus ),
  CJTankhaPayHomeModelClass(
      name: "Benefits",
      profile: "Learn more about healthcare and retirement benefits",
      image: TankhaPay_Icon_Benefits,selectedViewType: CJTALENT_Benefits),
];

Widget cjCardTemplate(dynamicObj,int selectedIndex,VerifyOTP_ModelResponse? liveModelObject,BuildContext context)
{
   const profileTitleColor = Color(0xff107A9D);
   const profileSubTitleColor = Color(0xff282828);
   const downColor1 = Color(0xffE6E6E6);
   const downColor2 = Color(0xffE0E0D4);
   const greyColor = Color(0xffA9A9A9);

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
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ElevatedButton.icon(
                                  onPressed: ()
                                  {
                                    print("show the selected index $selectedIndex");

                                   // var obj=cjList[selectedIndex];

                                    if(dynamicObj.selectedViewType==CJTALENT_SalaryStatus)
                                    {
                                      TalentNavigation().pushTo(context, Talent_SalaryStatus(visibilityStatusForSalaryStatus:true,liveModelObject: liveModelObject));
                                    }
                                    else if(dynamicObj.selectedViewType==CJTALENT_MarkAttendance)
                                    {
                                      TalentNavigation().pushTo(context, TankhaPayAttendanceTabs(visibilityStatusForTankhaPayAttendance:true,liveModelObject: liveModelObject));
                                    }
                                    else if(dynamicObj.selectedViewType==CJTALENT_Benefits)
                                    {
                                      //TalentNavigation().pushTo(context, TankhaPayBenefits(visibilityStatusForTankhaPayBenefits:true,liveModelObject: liveModelObject));

                                      TalentNavigation().pushTo(context,  ShowCaseWidget(
                                          builder: Builder(
                                            builder: (context) => TankhaPayBenefits(visibilityStatusForTankhaPayBenefits:true,liveModelObject: liveModelObject),
                                          )));

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
