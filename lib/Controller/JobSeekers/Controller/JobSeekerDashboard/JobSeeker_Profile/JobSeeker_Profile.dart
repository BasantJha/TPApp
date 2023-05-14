

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeekerDashboard/JobSeeker_HomeView/JobSeeker_HomeChild.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeekerDashboard/JobSeeker_Profile/JobSeeker_PersonalDetails/JobSeeker_PersonalDetails.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';


class JobSeeker_Profile extends StatefulWidget
{
  const JobSeeker_Profile({super.key});

  @override
  _JobSeeker_Profile createState() => _JobSeeker_Profile();
}

// ignore: camel_case_types
class _JobSeeker_Profile extends State<JobSeeker_Profile> {

  var profileupdate = 2;
  var borderradiusconst = BorderRadius.circular(15.0);
  var constcolorforprofilrgreycolor = Color(0xff686868);


  late final listuser = [
    userProfileUI(JobSeeker_Icon_PersonalDetails, "Personal Details"),
    userProfileUI(JobSeeker_Icon_EducationDetails, "Education Details"),
    userProfileUI(JobSeeker_Icon_ExperienceDetails, "Experience Details"),
    userProfileUI(JobSeeker_Icon_UploadResume, "Upload Resume"),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
        appBar:CJAppBar(getJobSeeker_TabProfileTitle, appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action type");
          Navigator.pop(context);
        })),

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

  SingleChildScrollView MainfunctionUi()
  {
    return SingleChildScrollView(
      child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:profileCardUI(),

                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: borderradiusconst,
                      ),
                      elevation: 5.0,
                      child: Padding(
                          padding: EdgeInsets.only(top: 5.0,bottom: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,scrollDirection: Axis.vertical,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: listuser.length,
                                          itemBuilder: (BuildContext context, int index)
                                          {
                                          return  GestureDetector(onTap: ()
                                              {
                                                if(index==0)
                                                  {
                                                    TalentNavigation().pushTo(context, JobSeeker_PersonalDetails());
                                                  }

                                              },child:Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 40,
                                                  child: Center(
                                                    child: listuser[index],
                                                  ),
                                                ),
                                                if(index == listuser.length-1)...[
                                                  Container(
                                                    width: 310,
                                                    color: Colors.red,
                                                  )
                                                ]
                                                else...[
                                                  Container(
                                                    padding: EdgeInsets.only(right: 5),
                                                    width: 310,
                                                    child: Divider(
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                ]
                                              ],
                                            ),
                                          ) ,);
                                          }
                                      )
                                  )
                                ],
                              )
                            ],
                          )

                      )
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 25),child:
                Container(
                  height: 156,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(JobSeeker_Icon_CJMitraBanner)
                      )
                  ),
                ),)

              ],
            ),
          )
      ),
    );
  }

  userProfileUI(String icon, String field){

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 1,
            child: Center(
              child: Container(
                child: Row(
                  children: [
                    field == "Personal Details"?
                    Icon(
                      Icons.person,
                      color: constcolorforprofilrgreycolor,
                    ) :ImageIcon(
                      AssetImage(icon),
                      color: constcolorforprofilrgreycolor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(field,
                          style: TextStyle(
                            fontSize: medium_FontSize,
                            color: constcolorforprofilrgreycolor,
                          ),
                        )
                    )
                  ],
                ),
              ),
            )
        ),
        SizedBox(
          width: 10,
        ),
        Center(
          child: IconButton(
            onPressed: (){},
            icon: ImageIcon(
              AssetImage(rightArrow_Icon),
              color: constcolorforprofilrgreycolor,
            ),
          ),
        )
      ],
    );
  }


}