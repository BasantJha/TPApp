

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/Services/CJEmployerService/CJEmployerServiceURL.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../../Services/Messages/Message.dart';
import '../../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../../../../../TankhaPayModule/Controller/ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfileChild.dart';
import '../../../EmployerModelClasses/EmployerAddEmployeeModelClass/EmployerDetailsModelClass.dart';
import '../../../EmployerModelClasses/EmployerSignUpModelClasses/EmployerSignUpModelClass.dart';
import '../../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'Employer_FlexibleCalculator/Employer_ViewSalaryCalculator.dart';
import 'Employer_NewWorkPlaceAddEmployee.dart';
import 'Employer_NewWorkPlaceEmployeeChild.dart';
import 'Employer_NewWorkPlaceEmployeeLinkSent/Employer_NewWorkPlaceEmployeeLinkSent.dart';
import 'Employer_NewWorkPlaceEmployeeLinkSent/Employer_NewWorkPlaceNewAddEmployee.dart';


const searchImg = AssetImage(search_Icon);
const personImageCircular = AssetImage(Employer_Icon_ProfileGrey);
const personImageSimple = AssetImage(Employer_Icon_WorkPlacePersonGrey);
const phoneImg = AssetImage(phone_Icon_Grey);
const mailImg = AssetImage(Employer_Icon_EmailGrey);
const calenderImg = AssetImage(Talent_Icon_Passbook_calendar);
const rupeeImg = AssetImage(rupees_Gray_Icon);

//var textStyle_GREY= TextStyle(fontFamily: robotoFontFamily, fontSize: small_FontSize, color: addDarkGrayColor, fontWeight: normal_FontWeight,);

class Employer_NewWorkPlaceEmployee extends StatefulWidget
{
//
  final bool? showStatus;
  const Employer_NewWorkPlaceEmployee({super.key, this.showStatus, this.liveModelObj});
  final Employer_VerifyMobileNoModelClass? liveModelObj;


  @override
  State<Employer_NewWorkPlaceEmployee> createState() => _Employer_NewWorkPlaceEmployee();
}

class _Employer_NewWorkPlaceEmployee extends State<Employer_NewWorkPlaceEmployee> {


  String? heading;
  BuildContext? getContext;
  List emps = [];
  List foundEmp =[];
  bool viewVisibilityStatus=true;

  String IPAddress="";

  String selectedDate="";
  double uiTextHeight=23;
  bool apiRequest=false;

  @override
  void initState()
  {
    super.initState();

    getBasicInfo();
    createBodyWebApi_EmployerDetails();

    foundEmp = emps;
    // heading = widget.title;

    print("show the revert back");
  }

  getBasicInfo()
  {
   /* Method.getDeviceId().then((value) => {
      deviceId=value,
      //print('show device id $value'),
    });*/

    Method.getIPAddress().then((value) => {
      IPAddress=value,
    });
  }
  void searchResult(String query)
  {
    List results = [];
    if (query.isEmpty) {
      results = emps;
    }
    else {
      results = emps
          .where((user) =>
          user["name"].toLowerCase().contains(query.toLowerCase())).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    setState(() {
      foundEmp = results;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    this.getContext=context;

    return SafeArea(
      child: Scaffold(backgroundColor: whiteColor,
        body: getResponsiveUI(),
      ),
    );
  }

  Responsive getResponsiveUI()
  {
    return Responsive(
      mobile:  foundEmp.isEmpty? MainfunctionUi_A():MainfunctionUi_B(),
      tablet: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child:  foundEmp.isEmpty? MainfunctionUi_A():MainfunctionUi_B(),
        ),
      ),
      desktop: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child:  foundEmp.isEmpty? MainfunctionUi_A():MainfunctionUi_B(),
        ),
      ),
    );
  }


  MainfunctionUi_A()
  {
    return apiRequest==true ?Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("You have not added any\nemployee in TankhaPay",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: largeExcel_FontSize,
                  fontFamily: robotoFontFamily
              ),
            ),
          ),
          SizedBox(height: 40,),
          addEmployeeButton(),
        ],
      ),

    ):MainfunctionUi_B();
  }
  Container addEmployeeButton()
  {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
            width: 190,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                onPressed: ()
                {


                  pushTo(context, Employer_NewWorkPlaceNewAddEmployee(liveModelObj: widget.liveModelObj,));

                },
                label: Text(
                  "Add Employee",
                  style: TextStyle(
                      fontWeight: bold_FontWeight,
                      color: lightBlueColor,
                      fontSize: medium_FontSize,
                      fontFamily: robotoFontFamily),
                ),

                icon: Image.asset(user_plus_Icon,color: lightBlueColor),
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 1.0,
                      color: lightBlueColor,
                    ),
                    backgroundColor: whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(20),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Padding MainfunctionUi_B()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          InkWell(onTap: ()
          {
            pushTo(context, Employer_NewWorkPlaceNewAddEmployee(liveModelObj: widget.liveModelObj,));

          },child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Add Employee",
                style: TextStyle(
                    fontFamily: robotoFontFamily,
                    fontSize: medium_FontSize,
                    color: Color(0xff1B1B1B),
                    fontWeight: semiBold_FontWeight
                ),
              ),
              SizedBox(
                width: 10,
              ),

              Image.asset(Employer_Icon_AddEmployee,color: Color(0xff1B1B1B),)

            ],
          ),),

          SizedBox(
            height: 13,
          ),

         /* Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Filter",
                style: TextStyle(
                    fontFamily: robotoFontFamily,
                    fontSize: medium_FontSize,
                    color: darkGreyColor,
                    fontWeight: semiBold_FontWeight
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: (){},
                  child: Image.asset(filter_Icon,color: darkGreyColor,)
              )
            ],
          ),*/
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child:  TextField(
              textAlign: TextAlign.left,
              onChanged: (value){
                searchResult(value);
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixIcon: Container(
                      child:  IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: Align(
                          alignment: Alignment.centerLeft,
                          child: ImageIcon(
                              searchImg
                          ),
                        ),
                      )
                  ),
                  hintText: "Search Employee....",
                  border: InputBorder.none),
            ),
          ),
          foundEmp.isNotEmpty ?
          Expanded(
            child: ListView.builder(
              itemCount: foundEmp.length,
              itemBuilder: (context, index)
              {
                final emp = foundEmp[index];
                return Padding(padding: EdgeInsets.only(top: 2,bottom: 10),
                  child: emp_card(emp,index),
                );

              },
            ),
          ) :
          Align(alignment: Alignment.center,child:  /*Text(
            'No results found',
            style: TextStyle(fontSize: 24),
          )*/Container(),),
        ],
      ),
    );
  }
//
//
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
        createBodyWebApi_EmployerDetails();
      });
    }


  Card emp_card(emp,int index)
  {



    var buttonColor;
    if(emp["satusOfDeputedDate"] == "Onboarding Pending" || emp["satusOfDeputedDate"] == "App Link Sent"){
      buttonColor = Color(0xffFFAC4A);
    }
    else if(emp["satusOfDeputedDate"] == "Active"){
      buttonColor = Color(0xff3FC500);
    }
    else
      {
        buttonColor = Color(0xff6B6B6B);
      }


    var emailVisibilityStatus=false;
    var emailId=emp["email_Id"];
    if(emailId=="" || emailId==null)
      {
        emailVisibilityStatus=false;
      }else
        {
          emailVisibilityStatus=true;

        }

    /*----------start 16-1-20223 -----------*/

    var employerStatus=emp["employerStatus"];
    var employerExitSuspendedDate=emp["employerExitSuspendedDate"];
    bool visibility_employerExitSuspendedDate=false;
    var employerExitSuspendedDate_TitleName="";

    var showEmployeeStatus="";
    if(employerStatus == "0" || employerStatus=="2")
    {
      //use for Exit the Employee
      employerExitSuspendedDate_TitleName="Exit Date";
      visibility_employerExitSuspendedDate=true;
      buttonColor = bannerTextColor;
      showEmployeeStatus="Exit";

    }
    else if(employerStatus == "15")
    {
      //use for Suspended the Employee
      employerExitSuspendedDate_TitleName="Suspended Date";
      visibility_employerExitSuspendedDate=true;
      buttonColor = sixHunGreyColor;
      showEmployeeStatus="Suspended";
    }
    else
      {
        if(emp["satusOfDeputedDate"] == "App Link Sent" || emp["satusOfDeputedDate"] == "Onboarding Pending"){

          //showEmployeeStatus = emp["satusOfDeputedDate"];
         // showEmployeeStatus = "In Process";
          showEmployeeStatus = "Set up Salary";
//

        }else
          {
            //use for the active employee(1 active and onboarding employee)
            visibility_employerExitSuspendedDate=false;
            showEmployeeStatus = emp["satusOfDeputedDate"];
          }


      }



    /*----------end 16-1-20223 -----------*/



    return Card(
        shape: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: darkBlueColor,
          ),
        ),
        color: whiteColor,
        margin: EdgeInsets.zero,
        elevation: 4,
        child: Padding(
            padding: const EdgeInsets.only(top: 5,bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5,top: 5,right: 5),
                  child: (emp["Image"]== "" || emp["Image"]==null)
                      ? CircleAvatar(
                    child: Text(getProfileEmpName(emp["name"])),
                  ) : CircleAvatar(backgroundImage: NetworkImage(emp["Image"])),
                ),
                SizedBox(
                  width: 3,
                ),
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex:1,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      children: [
                                        Image(image: personImageCircular,color: addDarkGrayColor,),

                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          emp["name"],
                                          style: TextStyle(
                                            fontFamily: robotoFontFamily,
                                            color: darkBlueColor,
                                            fontWeight: bold_FontWeight,
                                            fontSize: small_FontSize,
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        Text(emp["tpcode"]==""?"":
                                          "(${emp["tpcode"]})",
                                          style: TextStyle(
                                            fontFamily: robotoFontFamily,
                                            color: darkBlueColor,
                                            fontWeight: bold_FontWeight,
                                            fontSize: small_FontSize,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              if(emp["satusOfDeputedDate"] == "Active" && employerStatus=="1")
                                PopupMenuButton(
                                  shape: Border(
                                      left: BorderSide(
                                        width: 3,
                                        color: darkBlueColor,
                                      )),
                                  icon: Icon(Icons.more_vert),
                                  iconSize: 30,
                                  splashRadius: 5,
                                  padding: EdgeInsets.zero,

                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: TextButton(
                                          onPressed: ()
                                          async {
                                            print("show the exit records1");

                                            Navigator.pop(context);

                                            final emp = foundEmp[index];
                                            var selectedEmpCode=emp["empCode"];

                                            openTheDatePicker(kEmployer_Exit_Value,selectedEmpCode);

                                          },
                                          child: Text(
                                            "Exit",textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: blackColor,fontFamily: robotoFontFamily,
                                                fontSize: large_FontSize,fontWeight: normal_FontWeight
                                            ),
                                          )),),

                                    PopupMenuItem(
                                      child: TextButton(
                                          onPressed: ()
                                          {
                                            print("show the suspended records");

                                            Navigator.pop(context);

                                            final emp = foundEmp[index];
                                            var selectedEmpCode=emp["empCode"];

                                            openTheDatePicker(kEmployer_Suspended_Value,selectedEmpCode);


                                          },
                                          child: Text(
                                            "Suspend",textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: blackColor,fontFamily: robotoFontFamily,
                                                fontSize: large_FontSize,fontWeight: normal_FontWeight
                                            ),
                                          )),),

                                    /*--------2-3-2023 start(View Salary)-----------*/
                                    PopupMenuItem(
                                      child: TextButton(
                                          onPressed: ()
                                          {
                                            Navigator.pop(context);

                                            TalentNavigation().pushTo(context, ShowCaseWidget(
                                                builder: Builder(
                                                  builder: (context) => Employer_ViewSalaryCalculator(liveModelObj: widget.liveModelObj,mapObj: emp),
                                                )));

                                          },
                                          child: Text(
                                            "View Salary",textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: blackColor,fontFamily: robotoFontFamily,
                                                fontSize: large_FontSize,fontWeight: normal_FontWeight
                                            ),
                                          )),),

                                    /*--------2-3-2023 end-----------*/

                                  ],
                                )
                             else if(employerStatus == "15")
                                PopupMenuButton(
                                  shape: Border(
                                      left: BorderSide(
                                        width: 3,
                                        color: darkBlueColor,
                                      )),
                                  icon: Icon(Icons.more_vert),
                                  iconSize: 30,
                                  splashRadius: 5,
                                  padding: EdgeInsets.zero,

                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: TextButton(
                                          onPressed: ()
                                          {
                                            print("show the suspended records");

                                            Navigator.pop(context);

                                            final emp = foundEmp[index];
                                            var selectedEmpCode=emp["empCode"];

                                            selectedDate=Method.getCurrentDateYear();
                                            createBodyWebApi_EmployerExitSuspend(kEmployer_Resume_Value,selectedEmpCode);

                                          },
                                          child: Text(
                                            "Resume",textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: blackColor,fontFamily: robotoFontFamily,
                                                fontSize: large_FontSize,fontWeight: normal_FontWeight
                                            ),
                                          )),),
                                  ],
                                )
                              else  if(emp["satusOfDeputedDate"] == "App Link Sent" || emp["satusOfDeputedDate"] == "Onboarding Pending")


                                  PopupMenuButton(
                                    shape: Border(
                                        left: BorderSide(
                                          width: 3,
                                          color: darkBlueColor,
                                        )),
                                    icon: Icon(Icons.more_vert),
                                    iconSize: 30,
                                    splashRadius: 5,
                                    padding: EdgeInsets.zero,

                                    itemBuilder: (context) => [

                                      PopupMenuItem(
                                        child: TextButton(
                                            onPressed: ()
                                            async {
                                              print("show the exit records1");

                                              Navigator.pop(context);

                                              final emp = foundEmp[index];
                                              TalentNavigation().pushTo(context, Employer_NewWorkPlaceEmployeeLinkSent(mapObj: emp,liveModelObj: widget.liveModelObj,));
//

                                            },
                                            child: Text(
                                              "View Detail",textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: blackColor,fontFamily: robotoFontFamily,
                                                  fontSize: large_FontSize,fontWeight: normal_FontWeight
                                              ),
                                            )),),
                                      PopupMenuItem(
                                        child: TextButton(
                                            onPressed: ()
                                            async {
                                              print("show the exit records1");

                                              Navigator.pop(context);

                                              final emp = foundEmp[index];
                                              var selectedJSId=emp["jsId"];
                                              var selectedEmpCode=emp["empCode"];

                                              createBodyWebApi_EmployerDelete(selectedJSId,selectedEmpCode);

                                            },
                                            child: Text(
                                              "Delete",textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: blackColor,fontFamily: robotoFontFamily,
                                                  fontSize: large_FontSize,fontWeight: normal_FontWeight
                                              ),
                                            )),),

                                    ],
                                  )
                            ],
                          ),


                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex:1,
                                  child: Container(
                                      height: uiTextHeight,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Image(image: phoneImg,width: 12,height: 12,color: addDarkGrayColor,),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(emp["mob_no"],
                                                style: textStyle_GREY())
                                          ],
                                        ),
                                      )
                                  )
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: uiTextHeight,
                                //width: 120,
                                padding: EdgeInsets.only(left: 1,right: 1,),
                                child: ElevatedButton(
                                  onPressed: ()
                                  {
                                    var emp = foundEmp[index];
                                    if(emp["satusOfDeputedDate"] == "App Link Sent" || emp["satusOfDeputedDate"] == "Onboarding Pending")
                                    {
                                      TalentNavigation().pushTo(context, Employer_NewWorkPlaceEmployeeLinkSent(mapObj: emp,liveModelObj: widget.liveModelObj,));
                                    }


                                    },
                                  child: Text(showEmployeeStatus,
                                    style: TextStyle(
                                        fontSize: smallLess_FontSize,
                                        color: buttonColor
                                    ),),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              side: BorderSide(color: buttonColor)
                                          )
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),


                          Visibility(visible: emailVisibilityStatus,child:  Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex:1,
                                  child: Container(
                                      height: uiTextHeight,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Image(image: mailImg,width: 12,height: 12,color: addDarkGrayColor,),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(emp["email_Id"],
                                                style: textStyle_GREY())
                                          ],
                                        ),
                                      )
                                  )
                              ),
                              SizedBox(
                                width: 5,
                              ),

                            ],
                          ),),

                          Visibility(visible: visibility_employerExitSuspendedDate,child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex:1,
                                  child: Container(
                                      height: uiTextHeight,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Image(image: calenderImg,width: 12,height: 12,color: addDarkGrayColor,),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text("$employerExitSuspendedDate_TitleName: "+employerExitSuspendedDate,
                                                style: textStyle_GREY())//
                                          ],
                                        ),
                                      )
                                  )
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              /* Container(
                                height: 25,
                                //width: 120,
                                padding: EdgeInsets.only(left: 1,right: 1,),
                                child: ElevatedButton(
                                  onPressed: ()
                                  {

                                  },
                                  child: Text(emp["satusOfDeputedDate"],
                                    style: TextStyle(
                                        fontSize: smallLess_FontSize,
                                        color: buttonColor
                                    ),),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              side: BorderSide(color: buttonColor)
                                          )
                                      )
                                  ),
                                ),
                              )*/
                            ],
                          )),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex:1,
                                  child: Container(
                                      height: uiTextHeight,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Image(image: calenderImg,width: 12,height: 12,color: addDarkGrayColor,),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text("Salary Start Date: "+emp["deputedDate"],
                                                style: textStyle_GREY())//
                                          ],
                                        ),
                                      )
                                  )
                              ),
                              SizedBox(
                                width: 5,
                              ),
                             /* Container(
                                height: 25,
                                //width: 120,
                                padding: EdgeInsets.only(left: 1,right: 1,),
                                child: ElevatedButton(
                                  onPressed: ()
                                  {

                                  },
                                  child: Text(emp["satusOfDeputedDate"],
                                    style: TextStyle(
                                        fontSize: smallLess_FontSize,
                                        color: buttonColor
                                    ),),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              side: BorderSide(color: buttonColor)
                                          )
                                      )
                                  ),
                                ),
                              )*/
                            ],
                          ),


                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex:1,
                                  child: Container(
                                      height: uiTextHeight,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Image(image: rupeeImg,width: 12,height: 12,color: addDarkGrayColor,),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text("Cost to Employer: "+emp["ctc"],
                                                style: textStyle_GREY())
                                          ],
                                        ),
                                      )
                                  )
                              ),
                              SizedBox(
                                width: 5,
                              ),

                            ],
                          ),

                          emp["salaryInHand"]==""||emp["salaryInHand"]==null?Container():Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex:1,
                                  child: Container(
                                      height: uiTextHeight,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Image(image: rupeeImg,width: 12,height: 12,color: addDarkGrayColor,),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text("Salary in-hand: "+emp["salaryInHand"],
                                                style: textStyle_GREY())
                                          ],
                                        ),
                                      )
                                  )
                              ),
                              SizedBox(
                                width: 5,
                              ),

                            ],
                          ),

                        ]
                    ))
              ],
            ))
    );
  }

  DataCell dtcell(String val) => DataCell(
    Center(
      child: Text(
        val,
        textAlign: TextAlign.center,
      ),
    ),
  );

  DataCell dtcellM(String val) => DataCell(
    Text(
      val,
    ),
  );

  DataColumn tableCol(String title) {
    return DataColumn(
        label: Expanded(child: Text(
          title,
          textAlign: TextAlign.center,
        ),));
  }

  openTheDatePicker(String checkStatus,String selectedEmpCode)
  async {

    final DateTime? picked = await showDatePicker(
        initialDate:DateTime.now(),
        context: context,
        firstDate: DateTime(DateTime.now().year, 1),
        lastDate: DateTime(2101));

    if (picked != null)
    {
      selectedDate = "${picked.day}/${picked.month}/${picked.year}";

      if(checkStatus==kEmployer_Exit_Value)
        {
          createBodyWebApi_EmployerExitSuspend(kEmployer_Exit_Value,selectedEmpCode);
        }
      else
        {
          createBodyWebApi_EmployerExitSuspend(kEmployer_Suspended_Value,selectedEmpCode);
        }

      print("Selected date $selectedDate");
    }
  }


  /*--------------hit the Employer Details service request start 29-12-2022..pratibha---------------*/
  createBodyWebApi_EmployerDetails()
  {

    var mapObject=getEmployer_EmployerDetails_RequestBody(widget.liveModelObj?.tpAccountId);
    serviceRequest_EmployerDetails(mapObject);

  }

  serviceRequest_EmployerDetails(Map mapObject)
  {
    print("show 1the request2");
    print("show the request object $mapObject");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequestFor_EmployerDashboard(mapObject,JG_ApiMethod_EmployerDetails,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {

          print("print model response $modelResponse");

          EasyLoading.dismiss();

          EmployerDetailsModelClass employerDetailsModelClass=modelResponse as EmployerDetailsModelClass;
          addDataToList(employerDetailsModelClass.commonAddEmployeeWorkPlaceList);

        }, employerFailureBlock:<T>(commonResponse,failure)
        {
          EasyLoading.dismiss();

          setState(() {
            apiRequest=true;
          });

          CJTalentCommonModelClass commonModelClass=failure as CJTalentCommonModelClass;
          if (commonModelClass?.message==null || commonModelClass?.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
           // CJSnackBar(context, commonModelClass!.message!);
          }

        }));
  }

  addDataToList(data)
  {
    emps=[];

    List<CommonAddEmployeeWorkPlaceList>? newDataList=data;
    for(var i =0;i<newDataList!.length;i++)
    {
      var obj=newDataList![i] as CommonAddEmployeeWorkPlaceList;
      var Map =   {
        // "Image" : Employer_Icon_SelectEmployeeListIcon,
        "Image" : "${obj.photopath}",
        "name"  : "${obj.empName}",
        "tpcode" : "${obj.tpcode}",
        "jsId" : "${obj.jsId}",
        "empCode" : "${obj.empCode}",
        "mob_no": "${obj.mobile}",
        "email_Id" : "${obj.email}",
        "deputedDate" : "${obj.dateofjoining}",
        "ctc" : "${obj.ctc}",
        "satusOfDeputedDate" : "${obj.joiningstatus}",
        "employerStatus" : "${obj.suspendedinactivestatus}",
        "employerExitSuspendedDate" : "${obj.exitsuspensiondate}",
        "employeeProfileUpdateStatus" : "${obj.profileMinwagestate}",
        "aadharVerficationStatus" : "${obj.aadharverficationStatus}",
        "accountVerificationStatus" : "${obj.accountVerificationStatus}",
        "panVerficationStatus" : "${obj.panVerificationStatus}",
        "salaryInHand" : "${obj.salaryinhand}",
        "dateOfJoining" : "${obj.dateofjoining}",
        "jobRole" : "${obj.postOffered}",
        "stateName" : "${obj.profileMinwagestate}"

      };
      emps.add(Map);
    }
    setState(()
    {
      foundEmp=emps;
      apiRequest=false;
       print("show the all list data, $emps");
    });

  }


  createBodyWebApi_EmployerExitSuspend(String actionType,String empCode)
  {

    var mapObject=getEmployer_ExitSuspend_RequestBody(widget.liveModelObj?.tpAccountId,empCode,actionType,IPAddress,selectedDate);
    print("show the request object $mapObject");

    serviceRequest_EmployerExitSuspend(mapObject);
  }
  serviceRequest_EmployerExitSuspend(Map mapObject)
  {
    print("show 1the request2");
    print("show the request object $mapObject");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObject,JG_ApiMethod_Employer_EmployerExitSuspended,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {

          print("print model response $modelResponse");

          EasyLoading.dismiss();

          createBodyWebApi_EmployerDetails();
          CJTalentCommonModelClass commonModelClass=commonResponse as CJTalentCommonModelClass;
          if (commonModelClass?.message==null || commonModelClass?.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context, commonModelClass!.message!);
          }

        }, employerFailureBlock:<T>(commonResponse,failure)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonModelClass=commonResponse as CJTalentCommonModelClass;
          if (commonModelClass?.message==null || commonModelClass?.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context, commonModelClass!.message!);
          }

        }));
  }
/*-----------29-12-2022 end--------------*/


  createBodyWebApi_EmployerDelete(String jsId,String empCode)
  {

    var mapObject=getEmployer_DeleteEmployeeFromList_RequestBody(widget.liveModelObj?.tpAccountId,widget.liveModelObj?.employerId,jsId,empCode);
    print("show the request object $mapObject");
    serviceRequest_EmployerDelete(mapObject);
  }
  serviceRequest_EmployerDelete(Map mapObject)
  {
    print("show 1the request2");
    print("show the request object $mapObject");

    String token=widget.liveModelObj?.token;

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequestForAddEmployee(mapObject,JG_ApiMethod_Employer_EmployerDelete,token,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {

          print("print model response $modelResponse");

          EasyLoading.dismiss();

          createBodyWebApi_EmployerDetails();
          CJTalentCommonModelClass commonModelClass=commonResponse as CJTalentCommonModelClass;
          if (commonModelClass?.message==null || commonModelClass?.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context, commonModelClass!.message!);
          }

        }, employerFailureBlock:<T>(commonResponse,failure)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonModelClass=commonResponse as CJTalentCommonModelClass;
          if (commonModelClass?.message==null || commonModelClass?.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context, commonModelClass!.message!);
          }

        }));
  }

}


