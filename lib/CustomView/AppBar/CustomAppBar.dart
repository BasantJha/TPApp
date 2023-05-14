
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Employer/Talent_Employer/Talent_AddEmployer.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:flutter/material.dart';

import '../../Constant/ConstantIcon.dart';
import '../../Controller/Talents/TalentNavigation/TalentNavigation.dart';

class AppBarBlock
{
  final void Function() appBarAction;
  AppBarBlock({required this.appBarAction});
}

AppBar CJAppBar(String titleType,{required AppBarBlock appBarBlock})
{
  var iconVisibility=true;
  if(titleType==getTalent_TabProfileTitle ||
      titleType==getTalent_EarningsTitle ||
      titleType==getTalent_EmployersTitle ||
      titleType==getJobSeeker_MyJobsTitle ||
      titleType==getJobSeeker_FindWorkTitle ||
      titleType==getEmployer_WorkPlace)
    {
      iconVisibility=false;
    }else
      {
        iconVisibility=true;
      }
  return AppBar(
    toolbarHeight: 70,
    elevation: 0,
    backgroundColor: whiteColor,

    leading: Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 12, 0, 12),
      child:Visibility(visible:iconVisibility ,child: ElevatedButton(
        onPressed: ()
        {
          appBarBlock.appBarAction();
        },
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Color(0xFFD9D9D9),
            minimumSize: Size.zero,
            padding: EdgeInsets.all(-12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            maximumSize: Size.zero),

        child: Icon(
          Icons.arrow_back_ios_rounded,
          size: 25,
          color: appBarBackButtonColor,
        ),
      ) ,) ,
    ),
    title: Text(
      titleType,
      style: TextStyle(
        color: Colors.black,
        fontSize: appBarTitleFontWeight,
        fontFamily: viewHeadingFontfamily,
        fontWeight: bold_FontWeight,
      ),
    ),

    centerTitle: true,
  );
}

AppBar CJAppBarBgBlue(String titleType,{required AppBarBlock appBarBlock})
{
  var iconVisibility=true;

  return AppBar(
    toolbarHeight: 50,
    elevation: 0,
    backgroundColor: Color(0xff93d9fd),
    leading: Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 1, 0, 1),
      child:Visibility(visible:iconVisibility ,child: ElevatedButton(
        onPressed: ()
        {
          appBarBlock.appBarAction();
        },
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Color(0xff93d9fd),
            minimumSize: Size.zero,
            //padding: EdgeInsets.all(-12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            maximumSize: Size.zero),

        child: Icon(
          Icons.arrow_back_ios_rounded,
          size: 25,
          color: whiteColor,
        ),
      ) ,) ,
    ),
    title: Text(
      titleType,
      style: TextStyle(
        color: Colors.black,
        fontSize: appBarTitleFontWeight,
        fontFamily: viewHeadingFontfamily,
        fontWeight: bold_FontWeight,
      ),
    ),
   /* actions: [

      IconButton(
          onPressed: ()
          {

          },
         */
    /* icon: ImageIcon(
              AssetImage(Testimonial_NavigationIcon))),*/
    /*

          icon: ImageIcon(
              AssetImage(TankhaPay_Notification_Icon))),
    ],
*/
    centerTitle: true,
  );
}

AppBar CJAppBarBgBlueWithoutBackButton(String titleType,{required AppBarBlock appBarBlock})
{
  var iconVisibility=true;

  return AppBar(
    toolbarHeight: 50,
    elevation: 0,
    backgroundColor: Color(0xff93d9fd),
    leading: Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 1, 0, 1),
      child:Visibility(visible:iconVisibility ,child: Container(),) ,
    ),
    title: Text(
      titleType,
      style: TextStyle(
        color: Colors.black,
        fontSize: appBarTitleFontWeight,
        fontFamily: viewHeadingFontfamily,
        fontWeight: bold_FontWeight,
      ),
    ),
    centerTitle: true,
  );
}
AppBar CJAppBarBgBlueForHTMLView(String titleType,{required AppBarBlock appBarBlock})
{
  var iconVisibility=true;

  return AppBar(
    toolbarHeight: 50,
    elevation: 0,
    backgroundColor: Color(0xff93d9fd),
    leading: Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 1, 0, 1),
      child:Visibility(visible:iconVisibility ,child: ElevatedButton(
        onPressed: ()
        {
          appBarBlock.appBarAction();
        },
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Color(0xff93d9fd),
            minimumSize: Size.zero,
            //padding: EdgeInsets.all(-12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            maximumSize: Size.zero),

        child: Icon(
          Icons.arrow_back_ios_rounded,
          size: 25,
          color: whiteColor,
        ),
      ) ,) ,
    ),
    title: Text(
      titleType,
      style: TextStyle(
        color: Colors.black,
        fontSize: appBarTitleFontWeight,
        fontFamily: viewHeadingFontfamily,
        fontWeight: bold_FontWeight,
      ),
    ),
   /* actions: [

      IconButton(
          onPressed: ()
          {

          },
          *//* icon: ImageIcon(
              AssetImage(Testimonial_NavigationIcon))),*//*
          icon: ImageIcon(
              AssetImage(TankhaPay_Notification_Icon))),
    ],*/

    centerTitle: true,
  );
}
AppBar CJAppBarWithRightIcon(String titleType,BuildContext context,{required AppBarBlock appBarBlock})
{
  var iconVisibility=true;
  var rightIconVisibility=true;

  if(titleType==getTalent_EmployersTitle)
  {
    iconVisibility=false;
    rightIconVisibility=true;
  }else
  {
    iconVisibility=true;
    rightIconVisibility=false;
  }
  return AppBar(
    toolbarHeight: 70,
    elevation: 0,
    backgroundColor: Colors.white,
    leading: Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 12, 0, 12),
      child:Visibility(visible:iconVisibility ,child: ElevatedButton(
        onPressed: ()
        {
          appBarBlock.appBarAction();
        },
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Color(0xFFD9D9D9),
            minimumSize: Size.zero,
            padding: EdgeInsets.all(-12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            maximumSize: Size.zero),

        child: Icon(
          Icons.arrow_back_ios_rounded,
          size: 25,
          color: appBarBackButtonColor,
        ),
      ) ,) ,
    ),
    title: Text(
      titleType,
      style: TextStyle(
        color: Colors.black,
        fontSize: appBarTitleFontWeight,
        fontFamily: viewHeadingFontfamily,
        fontWeight: bold_FontWeight,
      ),
    ),
    actions: [
      Visibility(visible: rightIconVisibility,child: IconButton(
          onPressed: ()
          {
            TalentNavigation().pushTo(context, Talent_AddEmployer());

          },
          icon:Icon(Icons.add,color: blackColor,)),)
    ],
    centerTitle: true,
  );
}
