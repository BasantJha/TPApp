
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../../../Constant/Constants.dart';
import '../../../../../../../Constant/Responsive.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../Employer_NewWorkPlaceAddCalculator.dart';
import '../Employer_NewWorkPlaceEmployeeChild.dart';
import 'Employer_NewWorkPlaceAddDOJ.dart';
import 'Employer_UpdateWorkPlaceAddCalculator.dart';


class Employer_NewWorkPlaceEmployeeSetupSalary extends StatefulWidget
{

  const Employer_NewWorkPlaceEmployeeSetupSalary({super.key,  this.mapObj, this.liveModelObj});
  final Map? mapObj;
  final Employer_VerifyMobileNoModelClass? liveModelObj;


  @override
  State<Employer_NewWorkPlaceEmployeeSetupSalary> createState() => _Employer_NewWorkPlaceEmployeeSetupSalary();
}


class _Employer_NewWorkPlaceEmployeeSetupSalary extends State<Employer_NewWorkPlaceEmployeeSetupSalary>
{


  // ignore: non_constant_identifier_names
  String phoneImage_Icon = "assets/cjhubappicons/call.png";

  Map<String,List<dynamic>> salaryCondition = {
    "Health Benefits":[
      "An employee is eligible for health benefits (ESIC scheme) only when his gross salary is less than or equal to Rs. 21000.",
      "The ESI contribution proportion is 3.25% for the employer and 0.75% for employees"
    ],
    "Retirement & Insurance Benefits" :[
      "If the employee’s basic salary is less than or equal to  Rs. 15000, only then he is eligible for retirement & Insurance benefits (PF scheme)",
      "If the employee is already registered under the PF scheme it is  mandatory to provide PF",
      "The PF contribution proportion is 13% for the employer and 12% for employees"
    ],
    "Superannuation Benefits":[
      "If the employee completes more than five years at your workplace, he becomes eligible for gratuity"
    ]
  };

  String empName="", empTpCode="", empMobileNo="", profileURL="";
 // String minWageState="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    empName=widget.mapObj!["name"];
    empTpCode=widget.mapObj!["tpcode"];
    empMobileNo=widget.mapObj!["mob_no"];
    profileURL=widget.mapObj!["Image"];
    //minWageState=widget.mapObj!["employeeProfileUpdateStatus"];

  }

  @override
  Widget build(BuildContext context)

  {
//
    return SafeArea(
        child: Scaffold(
            appBar: CJAppBar("Setup Salary", appBarBlock: AppBarBlock(appBarAction: ()
            {
              print("show 1the action 1type");
              Navigator.pop(context);
            })),
            backgroundColor:whiteColor,
            body:getResponsiveUI()
        )
    );
  }
  Responsive getResponsiveUI()
  {
    return Responsive(
      mobile: MainfunctionUI(),
      tablet: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUI(),
        ),
      ),
      desktop: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUI(),
        ),
      ),
    );
  }


  SingleChildScrollView MainfunctionUI()
  {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 25,),
          getTheEmployeeInfoCard(empName,empTpCode,empMobileNo,profileURL),
          Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  child: Column(
                    children: [
                      Text("Social Benefit Rules",
                        style: TextStyle(
                            fontFamily: robotoFontFamily,
                            fontSize: large_FontSize,
                            color: darkBlueColor,
                            fontWeight: semiBold_FontWeight
                        ),
                      ),
                      Text("(as per Govt. of India)",
                        style: TextStyle(
                            fontFamily: robotoFontFamily,
                            fontSize: medium_FontSize,
                            color: blackColor,
                            fontWeight: normal_FontWeight
                        ),
                      ),
                    ],
                  )
              )
          ),
          Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text("The social benefits for the employees are\ndependent on their salary scale as under:",textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: robotoFontFamily,
                          fontSize: medium_FontSize,
                          color: blackColor,
                          //fontWeight: normal_FontWeight
                        ),
                      ),

                    ],
                  )
              )
          ),


          ListView.builder(
              itemCount: salaryCondition.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index)
              {
                var heading = salaryCondition.keys.elementAt(index);
                var benifitList = salaryCondition.values.elementAt(index);

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: Container(
                    //height: 100,
                    // width: 350,
                    decoration: BoxDecoration(
                        color: Color(0xffeef5fd),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(heading,
                          style: TextStyle(
                              fontFamily: robotoFontFamily,
                              fontSize: medium_FontSize,
                              color: blackColor,
                              fontWeight: normal_FontWeight
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                            itemCount: benifitList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index)
                            {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 2),
                                    child: Icon( Icons.arrow_forward_ios_outlined,size: 15),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(benifitList[index],
                                            // style: TextStyle(
                                            //     fontFamily: Projectconst.robotoFontFamily,
                                            //     fontSize: Projectconst.medium_FontSize,
                                            //     fontWeight: Projectconst.normal_FontWeight,
                                            //     color: Color(0xff292926)
                                            // ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      )
                                  )
                                ],
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                );
              }),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: darkBlueColor,
                  //elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  minimumSize: Size(170, 60),
                ),
                onPressed: ()
                {
                  //setUpSalaryCalculatorBottomSheet(context,widget.liveModelObj,widget.mapObj!);//

                  TalentNavigation().pushTo(context, Employer_NewWorkPlaceAddDOJ(liveModelObj:widget.liveModelObj!,mapObj:widget.mapObj!));
                },
                child: Text("Continue",
                  style: TextStyle(
                      fontSize: large_FontSize,
                      fontWeight: normal_FontWeight,
                      fontFamily: robotoFontFamily
                  ),
                )
            ),
          )

        ],
      ),
    );
  }


}



/*----------------------------- BottomSheet Code Start Salary Calculator -----------------------------------*//*

var dateRadioValue = 0;
var selectedSalaryCalculatorType=Employee_FixedGrossSalary; //default fixed gross salary
String Talent_close_Icon = "assets/tankhapayicons/close_cross_icon.png";

setUpSalaryCalculatorBottomSheet(BuildContext context,Employer_VerifyMobileNoModelClass? liveModelObj, Map mapObj)
{
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter state)
          {
            return SingleChildScrollView(
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.transparent,
                      // padding: EdgeInsets.only(top: topSpace),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 15.0,
                                bottom: 15.0),
                            child: FloatingActionButton(
                              onPressed: () => Navigator.pop(context),
                              backgroundColor: Colors.white,
                              child: Image(
                                  image: AssetImage(Talent_close_Icon)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    */
/*-----use below--*//*

                    Container(
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            )
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 25,horizontal: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: Text("Salary Calculator",
                                  style: TextStyle(
                                      color: blackColor,
                                      fontFamily: robotoFontFamily,
                                      fontSize: large_FontSize,
                                      fontWeight: bold_FontWeight
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15,bottom: 20,top: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Text("Select salary calculations for your employee based on any one of the options below:",
                                          style: TextStyle(
                                              fontFamily: robotoFontFamily,
                                              fontWeight: bold_FontWeight,
                                              fontSize: medium_FontSize
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                //padding: EdgeInsets.only(left: 20, right: 20),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: 0,
                                        groupValue: dateRadioValue,
                                        activeColor: Colors.blue,
                                        onChanged: (value) {

                                          print("show the dateRadioValue1 $value");
                                          selectedSalaryCalculatorType=Employee_FixedGrossSalary;

                                          state(()
                                          {
                                            dateRadioValue = int.parse(value.toString());
                                            print("show the dateRadioValue $dateRadioValue");
                                          });
                                        },),
                                      SizedBox(width: 5),
                                      Text('Based On Fixed Gross(in-hand) Salary',
                                        style: TextStyle(
                                            fontSize: medium_FontSize,
                                            fontFamily: robotoFontFamily,color: companyNameTextColor,
                                            fontWeight: bold_FontWeight
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: 1,
                                        groupValue: dateRadioValue,
                                        activeColor: Colors.blue,
                                        onChanged: (value) {

                                          print("show the dateRadioValue1 $value");
                                          selectedSalaryCalculatorType=Employee_CostToEmployee;

                                          state(()
                                          {
                                            dateRadioValue = int.parse(value.toString());
                                            print("show the dateRadioValue $dateRadioValue");

                                          });
                                        },),
                                      SizedBox(width: 5),
                                      Text('Based On Cost to Employer',
                                        style: TextStyle(
                                            fontSize: medium_FontSize,
                                            fontFamily: robotoFontFamily,color: companyNameTextColor,
                                            fontWeight: bold_FontWeight
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                             Padding(padding: EdgeInsets.only(top: 20,bottom: 10),child:  Center(
                               child: ElevatedButton(
                                   style: ElevatedButton.styleFrom(backgroundColor: darkBlueColor,
                                     //elevation: 3,
                                     shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(15.0)),
                                     minimumSize: Size(170, 60),
                                   ),
                                   onPressed: ()
                                   {


                                     Navigator.pop(context);
                                     TalentNavigation().pushTo(context, ShowCaseWidget(
                                         builder: Builder(
                                           builder: (context) => Employer_UpdateWorkPlaceAddCalculator(liveModelObj:liveModelObj,selectedSalaryCalculatorType:selectedSalaryCalculatorType,mapObj: mapObj,),
                                         )));


                                   },
                                   child: Text("Proceed",
                                     style: TextStyle(
                                         fontSize: large_FontSize,color: whiteColor,
                                         fontWeight: normal_FontWeight,
                                         fontFamily: robotoFontFamily
                                     ),
                                   )
                               ),
                             ),)
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            );
          }
      );
    },
  );
}
*/
