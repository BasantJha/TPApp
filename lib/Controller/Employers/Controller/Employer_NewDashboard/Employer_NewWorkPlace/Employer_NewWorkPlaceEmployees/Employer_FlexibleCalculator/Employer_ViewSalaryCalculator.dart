import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/ModelClasses/CJTalentCommonModelClass.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/Services/AESAlgo/encrypt.dart';
import 'package:contractjobs/Services/CJEmployerService/CJEmployerServiceRequest.dart';
import 'package:contractjobs/Services/CJEmployerService/CJEmployerServiceURL.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../../../../CustomView/CJHubCustomView/palatte_Textstyle.dart';
import '../../../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../../../CustomView/CustomRow/AstricRow.dart';
import '../../../../../../../CustomView/HintWidget/HintMessage.dart';
import '../../../../../../../CustomView/HintWidget/HintWidget.dart';
import '../../../../../../../CustomView/MarginSizeBox/MarginSizeBox.dart';
import '../../../../../../../CustomView/ViewHint/CustomViewHint.dart';
import '../../../../../../../CustomView/ViewHint/ViewHintText.dart';
import '../../../../../../../Services/AESAlgo/EncryptedMapBody.dart';
import '../../../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../../../Services/Messages/Message.dart';
import '../../../../EmployerModelClasses/EmployerAddEmployeeModelClass/CalculatorModelClass.dart';
import '../../../../EmployerModelClasses/EmployerAddEmployeeModelClass/EmployerFlexibleCalculatorModelClass.dart';
import '../../../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../../../../Employer_TabBarController/Employer_TabBarController.dart';
import '../Employer_NewWorkPlaceAddEmployee.dart';

//
enum MonthlySalaryRadioButton {firstradiobutton, secondradiobutton}

class Employer_ViewSalaryCalculator extends StatefulWidget
{
  const Employer_ViewSalaryCalculator({Key? key, this.liveModelObj,  this.mapObj}) : super(key: key);
  final Employer_VerifyMobileNoModelClass? liveModelObj;
  final Map? mapObj;


  @override
  State<Employer_ViewSalaryCalculator> createState() => _Employer_ViewSalaryCalculator();
}

class _Employer_ViewSalaryCalculator extends State<Employer_ViewSalaryCalculator>
{

  String subHintText="payout",hintText="";//use for flexible time
  //String subHintText="monthly in-hand salary"; //use for full time


  bool selectButton_Visibility=true;


  bool healthBenefit_Check = false;
  bool retirementBenefit_Check = false;
  String check_ESIC="0",check_PF="0";

  final GlobalKey viewSalaryESICGlobalKey = GlobalKey();
  final GlobalKey viewSalaryPFGlobalKey = GlobalKey();



  String showSalaryMinRangeErrorMsg="";
  bool showSalaryMinRangeErrorMsg_Visibility=false;

  String calPFOptedValue=""; //first time send blank and second time dependent on the basic amount::
  bool calPFOptedStatus=false;

  String hitApiRequestType="";
  String salaryOffered='';
  var balance_MapObject=Map();

  String flexibleSalary="";

  EmployerFlexibleCalculatorModelClass? salaryCalModelClass;

  /*-----------25-2-2023 start-----------*/

  String inhandSalary="",esicContribution="",epfContribution="",
      totalCostToEmployer="",totalInHandSalaryToEmployee="";

  bool flexibleAndFullTimeStatus=true;
  int checkFlexibleCalculatorStatus=1; //1 use for the Flexible time and 2 use for the Full-time

  //var controller=EditTextFieldContrller();
  /*-----------25-2-2023 end-----------*/

  TextEditingController viewSalaryCal_Controller = TextEditingController();

  bool suffixIconStatus=true;
  String minWageMessage="";
  bool hitApiRequestStatus=false;
  String resetPayoutStatus="";

  bool uanNumberStatus=false;

  String stateName="",IPAddress="";
  var leaveTemplateId="";

//
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBasicInfo();

    createBodyWebApi_ViewSalaryCalculatorApi();

  }
  getBasicInfo()
  {
    Method.getIPAddress().then((value) => {
      IPAddress=value,
    });
  }

  @override
  Widget build(BuildContext context)
  {
    //getEmployer_PayoutCalculatorTitle
    return GestureDetector(onTap: ()
      {
        dismissTheFirstResponder();
      },child: Scaffold(backgroundColor: whiteColor,
      appBar:CJAppBar("Payout Calculator", appBarBlock: AppBarBlock(appBarAction: ()
      {
        // print("show the action type");
        Navigator.pop(context);
      })),
      body: getResponsiveUI(),
      bottomNavigationBar: hitApiRequestType==Employee_InHandSalaryEmployee?Padding(padding: EdgeInsets.only(left: 90,right: 90),child: elevatedButtonBottomBar(),):null,
    ),);
  }
  dismissTheFirstResponder()
  {
    FocusScope.of(context).requestFocus(new FocusNode());
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
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            /*   Center(
              child: getViewHintTextBlue(getEmployee_MonthlySalaryHint),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(padding: EdgeInsets.only(left: 23),child: getAstricRow("Social Security Responsibility"),),
            SizedBox(height: 7),*/
            Column(
              children: [

                SizedBox_22px,

                ViewSalaryCalculatorContainer(),

              ],
            ),

          ],
        ),
      ),
    );
  }

  getBoxDecoration()
  {
    return BoxDecoration(border: Border.all(color: darkGreyColor),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
          topLeft: Radius.circular(12),topRight: Radius.circular(12),
        )
    );
  }
  getPurpleLeftBoxDecoration()
  {
    return BoxDecoration(color: darkPurpleColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          topLeft: Radius.circular(12),
          // topRight: Radius.circular(12),
          // bottomRight: Radius.circular(12),
        )
    );
  }

  getWhiteRightBoxDecoration()
  {
    return BoxDecoration(color: whiteColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        )
    );
  }
  getWhiteLeftBoxDecoration()
  {
    return BoxDecoration(color: whiteColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        )
    );
  }
  getPurpleRightBoxDecoration()
  {
    return BoxDecoration(color: darkPurpleColor,
        borderRadius: BorderRadius.only(
          // bottomLeft: Radius.circular(12),
          //topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        )
    );
  }
//

  ViewSalaryCalculatorContainer()
  {

    return
      Column(
        children: [

          Padding(
            padding:
            const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: TextField( inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
              controller: viewSalaryCal_Controller,
              keyboardType: TextInputType.number,
              onChanged: (value)
              {

                flexibleSalary=value;
                if(flexibleSalary=="" || flexibleSalary==null)
                {
                  setState(()
                  {
                    hitApiRequestType="";

                  });
                }
              },
              decoration: InputDecoration(
                hintText: "Enter Monthly In-hand Payout",
                contentPadding: EdgeInsets.fromLTRB(
                    20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(15.0)),
                suffixIcon: suffixIconStatus==true?Container(
                  height: 30.0,
                  width: 30.0,

                  child: IconButton(
                    icon: Image.asset(flexible_SalaryCalculationRightBlue_Icon),
                    onPressed: ()
                    {

                      flexibleSalary=viewSalaryCal_Controller.text;
                      if(flexibleSalary=="" || flexibleSalary==null)
                      {
                        CJSnackBar(context, "Enter Monthly In-hand Payout");
                      }
                      else
                      {
                        setState(()
                        {
                          hitApiRequestType=Employee_InHandSalaryEmployee;
                          flexibleAndFullTimeStatus=true;
                        });

                        dismissTheFirstResponder();
                        createBodyWebApi_CommonSalaryCalculatorApi();

                      }

                    },
                  ),

                ):Container(),
              ),


            ),
          ),
          SizedBox(height: 30,),

          hitApiRequestStatus==true?Padding(padding: EdgeInsets.only(left: 2,right: 2),
            child: Container(decoration:getBoxDecoration() ,height: 50,
              child:Row(children: [


                Expanded(flex: 1,child: InkWell(onTap: ()
                {
                  setState(() {
                    flexibleAndFullTimeStatus=true;
                  });
                  checkFlexibleCalculatorStatus=1;
                  flexibleTimeCalculatorData(salaryCalModelClass!);

                },child: Container(height: 50,decoration:flexibleAndFullTimeStatus==true?getPurpleLeftBoxDecoration():getWhiteLeftBoxDecoration(),alignment: Alignment.center,child: Text("Flexible Time",style: TextStyle(color: flexibleAndFullTimeStatus==true?whiteColor:blackColor),),),)),

                Expanded(flex: 1,child: InkWell(onTap: ()
                {
                  setState(() {
                    flexibleAndFullTimeStatus=false;
                  });
                  checkFlexibleCalculatorStatus=2;
                  fullTimeCalculatorData(salaryCalModelClass!);

                },child: Container(height: 50,decoration: flexibleAndFullTimeStatus==true?getWhiteRightBoxDecoration():getPurpleRightBoxDecoration(),alignment: Alignment.center,child: Text("Full-time",style: TextStyle(color: flexibleAndFullTimeStatus==true?blackColor:whiteColor)),),)),



              ],) ,),):Container(),

          hitApiRequestType==Employee_InHandSalaryEmployee?Column(children:
          [
            showSalaryMinRangeErrorMsg_Visibility?
            Text(showSalaryMinRangeErrorMsg,textAlign: TextAlign.center,
              style: TextStyle(fontFamily: robotoFontFamily,color: redColor,fontSize: medium_FontSize,fontWeight: semiBold_FontWeight),):Container(),


            selectButton_Visibility?getHealthBenefitColumn():Container(),

            SizedBox_20px,

            Container(child: Column(children:
            [
              Center(
                child: Text(
                  'Social Security Calculations',
                  style: TextStyle(
                      fontSize: medium_FontSize,
                      color: blackColor,
                      fontFamily: robotoFontFamily,
                      fontWeight: bold_FontWeight
                  ),
                ),
              ),

              SizedBox_20px,

              Container(
                  decoration: BoxDecoration(border: Border.all(color: darkGreyColor),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        topLeft: Radius.circular(12),topRight: Radius.circular(12),
                      )
                  ),
                  child:Column(
                    children: [
                      ListTile(visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                        title: Text("In-hand Salary",style: TextStyle(color: blackColor,fontSize: small_FontSize-1,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight)),
                        trailing: Text(inhandSalary,style: TextStyle(color: blackColor,fontSize: small_FontSize-1,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight)),),
                      Container(width: MediaQuery.of(context).size.width - 70, height: 1, color: darkGreyColor),

                      ListTile(visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                        title: Text("ESIC Contribution",style: TextStyle(color: blackColor,fontSize: small_FontSize-1,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight)),
                        trailing: Text(esicContribution,style: TextStyle(color: blackColor,fontSize: small_FontSize-1,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight)),),
                      Container(width: MediaQuery.of(context).size.width - 70, height: 1, color: darkGreyColor),

                      ListTile(visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                        title: Text("EPF Contribution",style: TextStyle(color: blackColor,fontSize: small_FontSize-1,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight)),
                        trailing: Text(epfContribution,style: TextStyle(color: blackColor,fontSize: small_FontSize-1,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight)),),

                    ],
                  )),

              SizedBox_20px,

              Container(
                  decoration: BoxDecoration(color: darkPurpleColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        topLeft: Radius.circular(12),topRight: Radius.circular(12),
                      )
                  ),
                  child:Column(
                    children: [
                      ListTile(visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                        title: Text("Cost to Employer",style: TextStyle(color: whiteColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight)),
                        trailing: Text(totalCostToEmployer,style: TextStyle(color: whiteColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight)),),
                      Container(width: MediaQuery.of(context).size.width - 70, height: 1, color: whiteColor),

                      ListTile(visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                        title: Text("In-hand Salary to Employee",style: TextStyle(color: whiteColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight)),
                        trailing: Text(totalInHandSalaryToEmployee,style: TextStyle(color: whiteColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight)),),
                      Container(width: MediaQuery.of(context).size.width - 70, height: 1, color: darkGreyColor),


                    ],
                  )),

              SizedBox_30px,


            ],),)

          ],):Container(),

        /*----------3-3-2023 start-----------*/
        //  resetPayoutStatus==""?Container():getMinWagesMessageContainer()

          resetPayoutStatus==""?Container():minWageMessage==""||minWageMessage==null?Container():getMinWagesMessageContainer()

          /*----------3-3-2023 end-----------*/

//minWageMessage
          // SizedBox_10px,

        ],
      );


  }

  Container getMinWagesMessageContainer()
  {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          uanNumberStatus==true?Container():Text("Minimum wage Alert",
            style: TextStyle(
                color: redColor,
                fontFamily: robotoFontFamily,
                fontSize: large_FontSize,
                fontWeight: semiBold_FontWeight
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Text(minWageMessage,
                  style: TextStyle(
                      fontWeight: normal_FontWeight,
                      fontSize: medium_FontSize,
                      color: blackColor,
                      fontFamily: robotoFontFamily
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),

          uanNumberStatus==true?Container():Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkBlueColor,
                    minimumSize: Size(115, 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: (){


                    if(checkFlexibleCalculatorStatus==3)
                    {
                      //use for the flexible time accept(when minimum wage fail)
                      setState(() {
                        suffixIconStatus==false;
                        viewSalaryCal_Controller.text=salaryCalModelClass?.flexibleTime?.suggestivesalary;
                        resetPayoutStatus="";
                        hitApiRequestStatus=false;

                      });

                    }
                    else if(checkFlexibleCalculatorStatus==4)
                    {
                      //use for the full time accept
                      setState(() {
                        suffixIconStatus==false;
                        viewSalaryCal_Controller.text=salaryCalModelClass?.fullTime?.suggestivesalary;
                        resetPayoutStatus="";
                        hitApiRequestStatus=false;

                      });
                    }
                    else
                    {
//
                    }

                    createBodyWebApi_CommonSalaryCalculatorApi();


                  },
                  child: Text("I Accept",
                    style: TextStyle(
                        color: whiteColor,
                        fontFamily: robotoFontFamily
                    ),
                  )
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: getOneHundredGreyColor(),
                    minimumSize: Size(95, 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: (){

                    setState(()
                    {
                      viewSalaryCal_Controller.text="";
                      hitApiRequestStatus=false;
                      resetPayoutStatus="";
                      flexibleAndFullTimeStatus=true;

                    });
                  },
                  child: Text("Reset Payout",
                    style: TextStyle(
                        color: blackColor,
                        fontFamily: robotoFontFamily
                    ),
                  )
              ),
            ],
          )

        ],
      ),
    );
  }



  Column getHealthBenefitColumn()
  {
    return  Column(
        children: [
          SizedBox(height: 30,),
          Text('Social Security Eligibility',textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: large_FontSize,
                fontWeight: semiBold_FontWeight,
                fontFamily: robotoFontFamily,
                color: blackColor
            ),
          ),
          SizedBox(height: 10,),
          Text('Based on the $subHintText chosen by you, your employee shall be eligible for the following:',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: medium_FontSize,
                fontWeight: semiBold_FontWeight,
                fontFamily: robotoFontFamily,
                color: darkGreyColor
            ),
          ),
          SizedBox(height: 13,),
          healthBenefitsCheckbox("Health Benefit (ESI Scheme)"),
          SizedBox(height: 10,),
          checkFlexibleCalculatorStatus==1 || checkFlexibleCalculatorStatus==3?Container():retirementBenefitsCheckbox("Retirement & Insurance (PF Scheme)")

        ]);
  }


  healthBenefitsCheckbox(String schemeText)
  {
    if(check_ESIC=="0" || check_ESIC==null || check_ESIC =="")
    {
      //show grey color
      healthBenefit_Check=false;
    }
    else
    {
      //if esic avaialble then show the green color
      healthBenefit_Check=true;

    }

    Color getColor(Set<MaterialState> states) {
      return healthBenefit_Check ? greenColor:darkGreyColor;
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: healthBenefit_Check ? greenColor:darkGreyColor,width: 1)
      ),
      child: Row(
        children: [
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(width: 1.0, color: Color(0xff8d8d8d)),
            ),
            value: healthBenefit_Check,
            onChanged: (bool? value) {

              /* setState(() {
                  healthBenefit_Check = value!;

                });*/
            },
          ),
          Flexible(
              child:  Text(schemeText,
                style: TextStyle(
                    color: healthBenefit_Check ? greenColor:darkGreyColor,
                    fontWeight: normal_FontWeight,
                    fontFamily: robotoFontFamily,
                    fontSize: medium_FontSize
                ),
              )
          ),
          SizedBox(width: 5,),

          HintWidget(globalKey: viewSalaryESICGlobalKey,title: "",description: getHealthBenefit_ESIScheme,child:InkWell(onTap: ()
          {

            WidgetsBinding.instance.addPostFrameCallback((_) =>
                ShowCaseWidget.of(context)
                    .startShowCase([viewSalaryESICGlobalKey]));

          },child:   Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:  Colors.cyan[400]
            ),
            //alignment: Alignment.center,
            child: Center(
              child: Text("i",
                  style:TextStyle(
                      fontStyle: FontStyle.italic,
                      color: whiteColor,
                      fontSize: medium_FontSize
                  )
              ),
            ),
          ),) )

        ],
      ),
    );
  }

  retirementBenefitsCheckbox(String schemeText)
  {


    if(checkFlexibleCalculatorStatus==1 || checkFlexibleCalculatorStatus==3)
    {
      //use for the flexible full time
      //show grey color
      retirementBenefit_Check=false;
      calPFOptedStatus=false;
      checkFlexibleCalculatorStatus=1;

      print("show the server response step1");

      //
    }
    else
    {
      //use for the full time
      //if esic avaialble then show the green color
      //retirementBenefit_Check=true;
      print("show the server response step2");

//
    }

    Color getColor(Set<MaterialState> states) {
      return calPFOptedStatus==true?greenColor:darkGreyColor;
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: darkGreyColor,width: 1)
      ),
      child: Row(
        children: [
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(width: 1.0, color: calPFOptedStatus==true?greenColor:checkFlexibleCalculatorStatus==1?darkGreyColor:blackColor),
            ),
            value: retirementBenefit_Check,
            onChanged: (bool? value)
            {

              // print("show the change status value $value");
              print("show the server response step3 $value");

              if(checkFlexibleCalculatorStatus==2 || checkFlexibleCalculatorStatus==4)
              {
                //checkFlexibleCalculatorStatus==1
                if (calPFOptedStatus == true)
                {
                  //use for only read only
                }
                else {
                  //use for editable

                  if (value == true) {
                    calPFOptedValue = "Y";
                    setState(() {
                      retirementBenefit_Check = true;

                    });
                  }
                  else {
                    calPFOptedValue = "N";
                    setState(() {
                      retirementBenefit_Check = false;

                    });
                  }

                  print("show the calPFOptedValue status value $calPFOptedValue");
                  createBodyWebApi_CommonSalaryCalculatorApi();
                }
              }else
              {

              }

            },
          ),
          Flexible(
              child:  Text(schemeText,
                style: TextStyle(
                    color: calPFOptedStatus==true?greenColor:blackColor,
                    fontWeight: normal_FontWeight,
                    fontFamily: robotoFontFamily,
                    fontSize: medium_FontSize
                ),
              )
          ),
          SizedBox(width: 5,),

          HintWidget(globalKey: viewSalaryPFGlobalKey,title: "",description: getHealthBenefit_PFScheme,child:InkWell(onTap: ()
          {

            WidgetsBinding.instance.addPostFrameCallback((_) =>
                ShowCaseWidget.of(context)
                    .startShowCase([viewSalaryPFGlobalKey]));

          },child:   Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:  Colors.cyan[400]
            ),
            //alignment: Alignment.center,
            child: Center(
              child: Text("i",
                  style:TextStyle(
                      fontStyle: FontStyle.italic,
                      color: whiteColor,
                      fontSize: medium_FontSize
                  )
              ),
            ),
          ),) )


        ],
      ),
    );
  }
  ///

  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Change Salary", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {

      createBodyWebApi_EmployerAddEmployee();
    }
    )) ;

  }

  /*--------------hit the Monthly CTC Calculator service request start 19-12-2022..pratibha---------------*/

  flexibleTimeCalculatorData(EmployerFlexibleCalculatorModelClass modelObj)
  {

    FlexibleTime? data=modelObj.flexibleTime;
    checkFlexibleCalculatorStatus==1;

    if(data?.calcresult=="Pass") {
      setState(() {
//
        suffixIconStatus==true;
        resetPayoutStatus="";

        /*--------2-3-2023 start--------*/
        stateName=data?.minwagestatename;
        print("show the state name $stateName");
        /*--------2-3-2023 end--------*/

        hitApiRequestType = Employee_InHandSalaryEmployee;


        selectButton_Visibility = true;

        balance_MapObject = Map();
        balance_MapObject = {
          "monthlyofferedpackage": data?.monthlyofferedpackage,
          "basic": data?.basic,
          "hra": data?.hra,
          "allowances": data?.allowances,
          "gross": data?.gross,
          "epf_employer": data?.epfEmployer,
          "epf_employee": data?.epfEmployee,
          "esi_employer": data?.esiEmployer,
          "esi_employee": data?.esiEmployee,
          "ctc": data?.ctc,
          "salary_in_hand": data?.salaryInHand,
          "employersocialsecurity": data?.employeesocialsecurity,
          "employeesocialsecurity": data?.employeesocialsecurity,
          "salarygenerationbase": data?.salarygenerationbase,
          "personalinfoid": data?.personalinfoid,
          "salarycategoryname": data?.salarycategoryname,
          "esiexceptionalcase": data?.esiexceptionalcase,
          "salarydays": data?.salarydays,
          "salarydaysopted": data?.salarydaysopted, //discus with praveen today
          "minwagescategoryid": data?.minwagescategoryid,
          "minimumwagessalary": data?.minimumwagessalary,
          "uannumber": data?.uannumber,
          "calcresult": data?.calcresult,
          "suggestivesalary": data?.suggestivesalary,
          "salmessage": data?.salmessage,
          "minwagescategoryname": data?.minwagescategoryname,
          "minwagestatename": data?.minwagestatename,
          "timecriteria": data?.timecriteria,
          "salaryhours": data?.salaryhours
        };

        /*--------------pf manage by basic salary and uan number 3-2-2023 start----------------*/
        var basicSalaryList = data?.basic;

        print("show the flexible basicSalaryList $basicSalaryList");

        String uanNumber = data?.uannumber;
        if (uanNumber == "" || uanNumber == null || uanNumber == "0") {
          uanNumber = "";
        }

        if (int.parse(basicSalaryList) <= 15000 || uanNumber != "" ||
            data?.salarycategoryname == "PF") {
          print("// show the selected status 1");
          if (calPFOptedValue == "Y" && data?.salarycategoryname == "PF") {
            print("show the selected status one true");

            calPFOptedStatus = false;
            retirementBenefit_Check = true;
          }
          else if (calPFOptedValue == "N" && data?.salarycategoryname != "PF") {
            print("show the selected status one false");

            calPFOptedStatus = false;
            retirementBenefit_Check = false;
          }
          else {
            print("show the selected status two");

            /*---------25-2-2023 start----------*/
            calPFOptedValue = "";
            /* calPFOptedStatus = true;
            retirementBenefit_Check = true;*/

            calPFOptedStatus = false;
            retirementBenefit_Check = true;

            /*---------25-2-2023 end----------*/

          }
        }
        else {
          print("show the selected status 2");

          calPFOptedStatus = false;
          retirementBenefit_Check = false;
        }
        /*--------------pf manage by basic salary and uan number 3-2-2023 end----------------*/

        var epfEmployerSalaryList = data?.epfEmployer;
        var esiEmployerSalaryList = data?.esiEmployer;

        inhandSalary = data?.salaryInHand;


        /*----------28-2-2023 start---------*/
        //esicContribution = data?.esiEmployee;
        //epfContribution = data?.epfEmployee;

        double totalEsicContribution=double.parse(data?.esiEmployee)+double.parse(data?.esiEmployer);
        double totalEPFContribution=double.parse(data?.epfEmployee)+double.parse(data?.epfEmployer);

        esicContribution = totalEsicContribution.toString();
        epfContribution = totalEPFContribution.toString();

        /*----------28-2-2023 end---------*/

        totalCostToEmployer = data?.ctc;
        totalInHandSalaryToEmployee = data?.salaryInHand;


        /*------30-1-2023 start-------*/
        check_PF = epfEmployerSalaryList.toString();
        check_ESIC = esiEmployerSalaryList.toString();
        /*------30-1-2023 end-------*/


      });
    }
    else
    {
      //use for Fail
      String uanNumber = data?.uannumber;
//
      if(uanNumber=="UAN IS OPTED" || uanNumber.length==12 || uanNumber=="Request For UAN")
      {
        print("show the uan attempt first $uanNumber");
        setState(() {
          uanNumberStatus = true;
          hitApiRequestType = "";
          minWageMessage = data?.salmessage;
          resetPayoutStatus = "1";
          checkFlexibleCalculatorStatus = 3;
        });
      }
      else
      {
        setState(()
        {
          print("show the uan attempt second $uanNumber");

          uanNumberStatus=false;
          hitApiRequestType="";
          minWageMessage=data?.salmessage;
          resetPayoutStatus="1";
          checkFlexibleCalculatorStatus=3;
        });
      }
//
//
    }
  }

  //////
  fullTimeCalculatorData(EmployerFlexibleCalculatorModelClass modelObj)
  {
    FlexibleTime? data=modelObj.fullTime;
    checkFlexibleCalculatorStatus==2;

    if(data?.calcresult=="Pass") {

      setState(() {
        uanNumberStatus=false;

        suffixIconStatus==true;
        resetPayoutStatus="";

        /*--------2-3-2023 start--------*/
        stateName=data?.minwagestatename;
        print("show the full time state name $stateName");

        /*--------2-3-2023 end--------*/

        hitApiRequestType = Employee_InHandSalaryEmployee;

        selectButton_Visibility = true;

//
        balance_MapObject = Map();
        balance_MapObject = {
          "monthlyofferedpackage": data?.monthlyofferedpackage,
          "basic": data?.basic,
          "hra": data?.hra,
          "allowances": data?.allowances,
          "gross": data?.gross,
          "epf_employer": data?.epfEmployer,
          "epf_employee": data?.epfEmployee,
          "esi_employer": data?.esiEmployer,
          "esi_employee": data?.esiEmployee,
          "ctc": data?.ctc,
          "salary_in_hand": data?.salaryInHand,
          "employersocialsecurity": data?.employeesocialsecurity,
          "employeesocialsecurity": data?.employeesocialsecurity,
          "salarygenerationbase": data?.salarygenerationbase,
          "personalinfoid": data?.personalinfoid,
          "salarycategoryname": data?.salarycategoryname,
          "esiexceptionalcase": data?.esiexceptionalcase,
          "salarydays": data?.salarydays,
          "salarydaysopted": data?.salarydaysopted, //discus with praveen today
          "minwagescategoryid": data?.minwagescategoryid,
          "minimumwagessalary": data?.minimumwagessalary,
          "uannumber": data?.uannumber,
          "calcresult": data?.calcresult,
          "suggestivesalary": data?.suggestivesalary,
          "salmessage": data?.salmessage,
          "minwagescategoryname": data?.minwagescategoryname,
          "minwagestatename": data?.minwagestatename,
          "timecriteria": data?.timecriteria,
          "salaryhours": data?.salaryhours
        };

        /*--------------pf manage by basic salary and uan number 3-2-2023 start----------------*/
        var basicSalaryList = data?.basic;

        String uanNumber = data?.uannumber;
        if (uanNumber == "" || uanNumber == null || uanNumber == "0") {
          uanNumber = "";
        }

        if (int.parse(basicSalaryList) <= 15000 || uanNumber != "" ||
            data?.salarycategoryname == "PF") {
          print("// show the selected status 1");
          if (calPFOptedValue == "Y" && data?.salarycategoryname == "PF") {
            print("show the selected status one true");

            calPFOptedStatus = false;
            retirementBenefit_Check = true;
          }
          else if (calPFOptedValue == "N" && data?.salarycategoryname != "PF") {
            print("show the selected status one false");

            calPFOptedStatus = false;
            retirementBenefit_Check = false;
          }
          else {
            print("show the selected status two");

            calPFOptedValue = "";
            calPFOptedStatus = true;
            retirementBenefit_Check = true;
          }
        }
        else {
          print("show the selected status 2");

          calPFOptedStatus = false;
          retirementBenefit_Check = false;
        }
        /*--------------pf manage by basic salary and uan number 3-2-2023 end----------------*/

        var epfEmployerSalaryList = data?.epfEmployer;
        var esiEmployerSalaryList = data?.esiEmployer;

        inhandSalary = data?.salaryInHand;
        /*----------28-2-2023 start---------*/
        //esicContribution = data?.esiEmployee;
        //epfContribution = data?.epfEmployee;

        double totalEsicContribution=double.parse(data?.esiEmployee)+double.parse(data?.esiEmployer);
        double totalEPFContribution=double.parse(data?.epfEmployee)+double.parse(data?.epfEmployer);

        esicContribution = totalEsicContribution.toString();
        epfContribution = totalEPFContribution.toString();


        /*----------28-2-2023 end---------*/


        totalCostToEmployer = data?.ctc;
        totalInHandSalaryToEmployee = data?.salaryInHand;

        /*------30-1-2023 start-------*/
        check_PF = epfEmployerSalaryList.toString();
        check_ESIC = esiEmployerSalaryList.toString();
        /*------30-1-2023 end-------*/

      });
    }
    else
    {
      //use for Fail
      setState(()
      {
        uanNumberStatus=false;

        hitApiRequestType="";
        minWageMessage=data?.salmessage;
        resetPayoutStatus="1";
        checkFlexibleCalculatorStatus=4;

      });


    }
  }



/*------------------common api method for salary calculator start 29-1-2023------------------*/
  createBodyWebApi_ViewSalaryCalculatorApi()
  {

    salaryOffered=flexibleSalary;
    hitApiRequestType=Employee_InHandSalaryEmployee;


    var mapObj=getEmployer_ViewSalaryStructure(widget.liveModelObj?.tpAccountId,widget.mapObj!["jsId"]);
    print("show the request body $mapObj");
    serviceRequest_ViewSalaryCalculator(mapObj,hitApiRequestType);

  }
  serviceRequest_ViewSalaryCalculator(Map mapObject,String salaryCalculateType)
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObject,JG_ApiMethod_Employer_GetSalaryStructure,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {

          // print("print model response $modelResponse");
          EasyLoading.dismiss();
          salaryCalModelClass=modelResponse as EmployerFlexibleCalculatorModelClass;

          setState(() {
            showSalaryMinRangeErrorMsg_Visibility=false;
            hitApiRequestStatus=true;
          });

          //flexibleAndFullTimeStatus

          print("show the checkFlexibleCalculatorStatus $checkFlexibleCalculatorStatus");

           FlexibleTime? flexibleTime=salaryCalModelClass?.flexibleTime;
           FlexibleTime? fullTime=salaryCalModelClass?.fullTime;

//
          if(flexibleTime?.calcresult=="Pass")
            {
              //use for flexible time
              setState(() {
                viewSalaryCal_Controller.text=flexibleTime?.salaryInHand;
                checkFlexibleCalculatorStatus=1;
               // stateName=flexibleTime?.minwagestatename;
                leaveTemplateId=flexibleTime?.leavetemplateid;

              });
            }
          else
            {
              if(fullTime?.calcresult=="Pass")
              {
                //use for full time

                setState(() {
                  viewSalaryCal_Controller.text=flexibleTime?.salaryInHand;
                  checkFlexibleCalculatorStatus=2;
                 // stateName=flexibleTime?.minwagestatename;
                  leaveTemplateId=flexibleTime?.leavetemplateid;

                });

              }
            }


          setState(()
          {
            hitApiRequestType=Employee_InHandSalaryEmployee;
            //flexibleAndFullTimeStatus=true;
          });

          print("show the leaveTemplateId $leaveTemplateId");

          /*----------2-3-2023 start----------*/
          if(checkFlexibleCalculatorStatus==1 || checkFlexibleCalculatorStatus==3)
          {
            //use for flexible time
            flexibleAndFullTimeStatus=true;
            flexibleTimeCalculatorData(salaryCalModelClass!);
          }
          else
          {
            //use for full time
            flexibleAndFullTimeStatus=false;
            fullTimeCalculatorData(salaryCalModelClass!);

          }
          /*----------2-3-2023 end----------*/


        }, employerFailureBlock:<T>(commonResponse,failure)
        {
          EasyLoading.dismiss();

          setState(() {
            //inhandSalaryApiRequest=false;
            //monthlySalaryApiRequest=false;
            hitApiRequestStatus=false;

          });


          CJTalentCommonModelClass commonModelClass=failure as CJTalentCommonModelClass;
          if (commonModelClass?.message==null || commonModelClass?.message=="")
          {
            setState(() {
              showSalaryMinRangeErrorMsg_Visibility=false;
              hitApiRequestStatus=false;

            });
            CJSnackBar(context, "server error!");
          }else
          {
            if(commonModelClass.errorMessage==null || commonModelClass.errorMessage=="")
            {
              setState(() {
                showSalaryMinRangeErrorMsg_Visibility=false;
                hitApiRequestStatus=false;

              });
              CJSnackBar(context, commonModelClass!.message!);
            }
            else
            {
              setState(() {
                showSalaryMinRangeErrorMsg_Visibility=true;
                showSalaryMinRangeErrorMsg=commonModelClass.message!;
                selectButton_Visibility=false;
                hitApiRequestStatus=false;


              });

            }
          }

        }));
  }


  createBodyWebApi_CommonSalaryCalculatorApi()
  {

    salaryOffered=flexibleSalary;
    hitApiRequestType=Employee_InHandSalaryEmployee;

    if(salaryOffered=="")
    {
      CJSnackBar(context, hintText);
      return;
    }
    else
    {
      salaryOffered=viewSalaryCal_Controller.text;
    }
//
    var mapObject=Map();
    mapObject["js_id"]=widget.mapObj!["jsId"];
    mapObject["minwages_state"]=widget.mapObj!["stateName"];
    mapObject["doj"]=widget.mapObj!["dateOfJoining"];;

    mapObject["customeraccountid"]=widget.liveModelObj?.tpAccountId;
    mapObject["monthly_offered"]=salaryOffered;
    mapObject["type"]=hitApiRequestType;
    mapObject["pfopted"]=calPFOptedValue;


    print("show the request body $mapObject");
    serviceRequest_CommonSalaryCalculator(getEncrypted_MapBody(mapObject),hitApiRequestType);

  }
  serviceRequest_CommonSalaryCalculator(Map mapObject,String salaryCalculateType)
  {

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObject,JG_ApiMethod_EmployeeCommonSalaryCalculator,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {

          // print("print model response $modelResponse");
          EasyLoading.dismiss();
          salaryCalModelClass=modelResponse as EmployerFlexibleCalculatorModelClass;

          print("show the minwagecategoryname fullTime ${salaryCalModelClass?.fullTime?.minwagescategoryname}");
          print("show the minwagecategoryname flexibleTime ${salaryCalModelClass?.flexibleTime?.minwagescategoryname}");

          setState(() {
            showSalaryMinRangeErrorMsg_Visibility=false;
            hitApiRequestStatus=true;
          });

          //flexibleAndFullTimeStatus

          print("show the checkFlexibleCalculatorStatus $checkFlexibleCalculatorStatus");

          if(checkFlexibleCalculatorStatus==1 || checkFlexibleCalculatorStatus==3)
          {
            //use for flexible time
            flexibleAndFullTimeStatus=true;
            flexibleTimeCalculatorData(salaryCalModelClass!);
          }
          else
          {
            //use for full time
            flexibleAndFullTimeStatus=false;
            fullTimeCalculatorData(salaryCalModelClass!);

          }

//
        }, employerFailureBlock:<T>(commonResponse,failure)
        {
          EasyLoading.dismiss();

          setState(() {

            hitApiRequestStatus=false;

          });


          CJTalentCommonModelClass commonModelClass=failure as CJTalentCommonModelClass;
          if (commonModelClass?.message==null || commonModelClass?.message=="")
          {
            setState(() {
              showSalaryMinRangeErrorMsg_Visibility=false;
              hitApiRequestStatus=false;

            });
            CJSnackBar(context, "server error!");
          }else
          {
            if(commonModelClass.errorMessage==null || commonModelClass.errorMessage=="")
            {
              setState(() {
                showSalaryMinRangeErrorMsg_Visibility=false;
                hitApiRequestStatus=false;

              });
              CJSnackBar(context, commonModelClass!.message!);
            }
            else
            {
              setState(() {
                showSalaryMinRangeErrorMsg_Visibility=true;
                showSalaryMinRangeErrorMsg=commonModelClass.message!;
                selectButton_Visibility=false;
                hitApiRequestStatus=false;


              });

            }
          }

        }));
  }



  /*------------------common api method for salary calculator end 29-1-2023------------------*/

  /*------------31-1-2023 start------------*/
  createBodyWebApi_EmployerAddEmployee()
  {

    var finalMapObj=Map();
    finalMapObj["tpSalaryStructure"]=[balance_MapObject];


    finalMapObj["jsId"]=getEncryptedData(widget.mapObj!["jsId"]);
    finalMapObj["dateOfJoining"]=widget.mapObj!["dateOfJoining"];
    finalMapObj["jobRole"]=widget.mapObj!["jobRole"];
    finalMapObj["customerAccountId"]=getEncryptedData(widget.liveModelObj?.tpAccountId);
    finalMapObj["tpLeaveTemplateId"]=leaveTemplateId;
    finalMapObj["creatdBy"]=widget.liveModelObj?.tpAccountId;
    finalMapObj["createdbyIp"]=IPAddress;
    finalMapObj["minWageStateName"]=widget.mapObj!["stateName"];

    print("show the completed request $finalMapObj");
    serviceRequest_AddEmployee(getEncrypted_MapBody(finalMapObj));
  }

  serviceRequest_AddEmployee(Map mapObj)
  {

    String token=widget.liveModelObj?.token;
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequestForAddEmployee(mapObj, JG_ApiMethod_SaveAddEmployee,token,
        cjEmployerResponseBlock: CJEmployerResponseBlock(
            employerSuccessBlock: <T>(commonResponse, modelResponse)
            {

              EasyLoading.dismiss();

              CJTalentCommonModelClass commonModelClass=commonResponse as CJTalentCommonModelClass;
              if (commonModelClass?.message==null || commonModelClass?.message=="")
              {
                CJSnackBar(context, "server error!");
              }else {
                CJSnackBar(context, commonModelClass!.message!);
              }
//
              widget.liveModelObj?.useForAddDOJStatus=Employee_ADDD0JStatus;
              TalentNavigation().pushTo(context, Employer_TabBarController(liveModelObj: widget.liveModelObj,));

            }, employerFailureBlock: <T>(commonResponse, failure) {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonModelClass=failure as CJTalentCommonModelClass;
          if (commonModelClass?.message==null || commonModelClass?.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context, commonModelClass!.message!);
          }

        }));
  }
/*------------31-1-2023 end------------*/

}



