

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



// ignore: camel_case_types
class JobSeeker_FindWorkDetails extends StatefulWidget
{
  const JobSeeker_FindWorkDetails({Key? key}) : super(key: key);

  //findworknewstate createstate() => findworknewstate();

  @override
  State<StatefulWidget> createState()
  {
    return _JobSeeker_FindWorkDetails();
  }
}


// ignore: camel_case_types
class _JobSeeker_FindWorkDetails extends State<JobSeeker_FindWorkDetails>  with TickerProviderStateMixin{


  TabController? tabController;

  List dataforskillrequired = [
    "Proficiency in coding languages",
    "Including Python Java and C++",
    "Framework and Angular Git",
    "Excellent Knowlwdge of Software",
    "Dvelopment Life Cycle",
    "Proficiency in coding languages",
    "Including Python Java and C++",
    "Framework and Angular Git",
    "Excellent Knowlwdge of Software",
    "Dvelopment Life Cycle"
  ];

  List  responsibilities = [
    "Work With Developer to design algorithm and flowchart",
    "Produce clean code & efficient code based on specification",
    "Integrate software component and Third party programs",

  ];

  List aboutcompany =[
    "At Ohmium, we leverage our teams broad experience in and deep knowledge of renewable energy",
    "engineering, operations, and more to design and deploy state-of-the-art green Hydrogen solutions. Our range of expertise enables us to approach problems with creativity and innovative critical thinking, with a focus on cost reduction, efficiency, and economies of scale in order to maximize value for our customers",
    "Driven by the passion to create a sustainable world, the Ohmium team, through its innovation and speed of execution, is focused on delivering an efficient, affordable, scalable PEM-based electrolyzer",
  ];

  List companyinfo = [
    "https://akal.com",
    "3RD FLOOR, 19/3, BIKASIPURA ROAD OFF KANAKAPURA, BANGALORE, Bengaluru (Bangalore) Urban, Karnataka, BANGALORE, Karnataka, India"
  ];


  @override
  void initState()
  {
    super.initState();
  }


  @override
  Widget build(BuildContext context)
  {

    tabController = TabController(length: 2, vsync: this);


    return Scaffold(

      backgroundColor: lightBlueColor,

      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: lightBlueColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 15,top: 14,bottom: 14),
          child: InkWell(onTap: ()
          {
            Navigator.pop(context);

          },child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 2),
            decoration: BoxDecoration(
              borderRadius : BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color : lightGreyColor,
            ),
            child: Align(
              alignment: Alignment.center,
              child:Icon(
                Icons.arrow_back_ios_rounded,
                size: 25,
                color: appBarBackButtonColor,
              ),
            ),


          ),),
        ),
        //titleSpacing: 10,
        title: Text("Find Work",
          style: TextStyle(
              color: Colors.white,
              fontWeight: bold_FontWeight,
              fontFamily: robotoFontFamily,
              fontSize: large_FontSize
          ),
        ),
        centerTitle: true,
      ),


      body: getResponsiveUI(),


      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 15,top: 10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(color: whiteColor,height: 40,
              width: 105,
              child: ElevatedButton(
                onPressed: ()
                {

                },
                child: Text("Apply"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: ElevatedButtonBgBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Color(0xff989898),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(heartWhite_Icon)
                  )
              ),
            )
          ],
        ),
      )  ,
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

  Column MainfunctionUi()
  {
    return Column(
      children: [
        Container(
          //height: MediaQuery.of(context).size.height /3,
          padding: EdgeInsets.only(left: 20,top: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        //fit: BoxFit.fill,
                        image:  AssetImage(JobSeeker_Icon_beeda),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        // height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(padding: EdgeInsets.only(left: 6),
                              child: Text("Office Helper",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: normal_FontWeight,
                                    fontFamily: robotoFontFamily,
                                    fontSize: large_FontSize
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            row(JobSeeker_Icon_Location, "Alwar Rajsthan"),
                            row(JobSeeker_Icon_Rupee, "1.46-1.50 lakh per annum"),
                            row(JobSeeker_Icon_ExperienceDetails, "NA-2 Years"),
                            row(JobSeeker_Icon_School, "Schooling"),
                          ],
                        ),
                      )
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: (){},
                    child: Text("Full Time",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: small_FontSize,
                          fontFamily: robotoFontFamily,
                          fontWeight: normal_FontWeight
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xffBAE3FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: (){},
                    child: Text("Driver",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: small_FontSize,
                          fontFamily: robotoFontFamily,
                          fontWeight: normal_FontWeight
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xffBAE3FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: (){},
                    child: Text("Cab Driver",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: small_FontSize,
                          fontFamily: robotoFontFamily,
                          fontWeight: normal_FontWeight
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xffBAE3FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Container(
            //height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                )
            ),
            padding: EdgeInsets.only(top: 20,left: 20,right: 20),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(
                          color: darkGreyColor
                      )
                  ),
                  child:  TabBar(
                    controller: tabController,
                    indicator: BoxDecoration(
                      color: lightBlueColor,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs:  [
                      Text("Job Description",
                        style: TextStyle(
                            fontSize: large_FontSize,
                            fontFamily: robotoFontFamily,
                            fontWeight: semiBold_FontWeight
                        ),
                      ),
                      Text("Company",
                        style: TextStyle(
                            fontSize: large_FontSize,
                            fontFamily: robotoFontFamily,
                            fontWeight: semiBold_FontWeight
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child:TabBarView(
                    controller: tabController,
                    children:  [
                      jobDescription(),
                      companyInfo()
                    ],
                  ) ,)


              ],
            ),
          ),
        )
      ],
    );
  }


  ///Upper Section
  row(String icon, String variable)
  {
    return Row(
      children: [
        ImageIcon(
          AssetImage(icon),
          color: Colors.white,
        ),
        SizedBox(
          width: 2,
        ),
        Expanded(
            child: Text("$variable",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: small_FontSize,
                  fontFamily: robotoFontFamily,
                  fontWeight: normal_FontWeight
              ),
            )
        )
      ],
    );
  }


  row1(String data)
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape. circle,
              color: darkBlueColor,
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data,
                  style: TextStyle(
                      fontFamily: robotoFontFamily,
                      fontSize: medium_FontSize,
                      fontWeight: normal_FontWeight,
                      color: Color(0xff292926)
                  ),
                ),
              ],
            )
        )
      ],
    );
  }


  datawitheading(String heading,String type)
  {
    List list =[];
    if(type == "required"){
      list = dataforskillrequired;
    }
    else if(type == "responsibilities"){
      list = responsibilities;
    }
    else if(type == "aboutcompany"){
      list = aboutcompany;
    }
    else if(type == "companyInfo"){
      list = companyinfo;
    }
    return ListView.builder(
        itemCount: list.length,

        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        //scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index)
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(index == 0)
                Padding(
                    padding: EdgeInsets.only(top: 20,bottom: 5),
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child:  Container(
                        child: Text(heading,
                          style: TextStyle(
                              fontSize: medium_FontSize,
                              fontWeight: normal_FontWeight,
                              color: Color(0xff272727)
                          ),
                        ),
                      ),
                    )
                ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: row1(list[index]),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          );
        }
    );
  }


  jobDescription()
  {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        datawitheading("Python Developer Experience & Skill set Required","required"),
        datawitheading("Roles & Responsibilities Of Python Developer","responsibilities"),
      ],
    );
  }


  companyInfo()
  {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        datawitheading("About Company","aboutcompany"),
        datawitheading("Company Info","companyInfo"),
      ],
    );
  }


}






