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
import '../../../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../../../../Employer_TabBarController/Employer_TabBarController.dart';
import '../Employer_NewWorkPlaceAddEmployee.dart';
import 'Employer_NewWorkPlaceAddDOJ.dart';



enum MonthlySalaryRadioButton {firstradiobutton, secondradiobutton}

class Employer_UpdateWorkPlaceAddCalculator extends StatefulWidget
{
  const Employer_UpdateWorkPlaceAddCalculator({Key? key, this.liveModelObj, this.selectedSalaryCalculatorType, this.mapObj, this.employeeAddObj}) : super(key: key);
  final Employer_VerifyMobileNoModelClass? liveModelObj;
  final String? selectedSalaryCalculatorType;
  final Map? mapObj;
  final Map? employeeAddObj;




  @override
  State<Employer_UpdateWorkPlaceAddCalculator> createState() => _Employer_UpdateWorkPlaceAddCalculator();
}

class _Employer_UpdateWorkPlaceAddCalculator extends State<Employer_UpdateWorkPlaceAddCalculator>
{

  MonthlySalaryRadioButton? _radioValue = MonthlySalaryRadioButton.firstradiobutton;
  bool _firstContainerVisible = false;
  bool _secondContainerVisible = false;

  String salaryOffered='',getInHandSalary="",getCTCSalary="";



  TextEditingController searchController = new TextEditingController();

  List basicSalaryAmountsList=[0,0,0,0];
  List socialSecurityEmployerAmountsList=[0,0,0,0];
  List socialSecurityEmployeeAmountsList=[0,0,0,0];
  List salaryInhandEmployeeSalaryList=['0'];
  List salaryCtcEmployeeSalaryList=['0'];
  List AllSalaryList=[];

  final List<String> basicSalary = <String>['Basic', 'HRA', 'Special Allowance', 'Sub Total (A)'];
  final List<int> basicSalaryAmounts = <int>[0, 0, 0, 10];

 /* final List<String> socialSecurityEmployer = <String>['EPF', 'ESIC', 'Gratutity', 'Sub Total (B)'];
  final List<int> socialSecurityEmployerAmounts = <int>[0, 0, 0, 10];*/

  final List<String> socialSecurityEmployer = <String>['EPF', 'ESIC', 'Sub Total (B)'];
  final List<int> socialSecurityEmployerAmounts = <int>[0, 0, 10];

  final List<String> socialSecurityEmployee = <String>['EPF', 'ESIC', 'Sub Total (C)'];
  final List<int> socialSecurityEmployeeAmounts = <int>[0, 0, 10];

  var showTheTravelSalaryAmount="";
  var showTheTravelSalaryAmountCtc="";
  var balance_MapObject=Map();

  bool inhandSalaryApiRequest=false;
  bool monthlySalaryApiRequest=false;

  String salaryInhand="";

  String hintText="Enter Monthly CTC";
  String subHintText="Monthly CTC";

  bool selectButton_Visibility=false;


  bool healthBenefit_Check = false;
  bool retirementBenefit_Check = false;
  String check_ESIC="0",check_PF="0";

  final GlobalKey esicGlobalKey = GlobalKey();
  final GlobalKey pfGlobalKey = GlobalKey();

  String showSalaryMinRangeErrorMsg="";
  bool showSalaryMinRangeErrorMsg_Visibility=false;

  String calPFOptedValue=""; //first time send blank and second time dependent on the basic amount::
  bool calPFOptedStatus=false;

  String hitApiRequestType="";


//
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("show the salary status ${widget.selectedSalaryCalculatorType}");

    if(widget.selectedSalaryCalculatorType==Employee_FixedGrossSalary)
      {
        _firstContainerVisible = true;
        hintText="Enter In-hand Salary";
        subHintText="In-hand Salary";
      }
     else
      {
        //Employee_CostToEmployee
        _secondContainerVisible = true;
        hintText="Enter Monthly CTC";
        subHintText="Monthly CTC";

      }

     print("show the employeeAddObj data ${widget.employeeAddObj}");


  }


  @override
  Widget build(BuildContext context)
  {
    //getEmployer_PayoutCalculatorTitle
    return Scaffold(backgroundColor: whiteColor,
      appBar:CJAppBar("Salary Calculator", appBarBlock: AppBarBlock(appBarAction: ()
      {
        // print("show the action type");
        Navigator.pop(context);
      })),
      body: getResponsiveUI(),
      bottomNavigationBar: selectButton_Visibility?Padding(padding: EdgeInsets.only(left: 90,right: 90),child: elevatedButtonBottomBar(),):null,
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
              /*  ListTile(
                    horizontalTitleGap: 0.0,
                    title: Text('Employer takes the responsibilities of both employer & employee',
                      style: TextStyle(
                          fontSize: small_FontSize,
                          fontWeight: normal_FontWeight,
                          fontFamily: robotoFontFamily,
                          color: blackColor
                      ),
                    ),
                    leading: Radio(
                      value: MonthlySalaryRadioButton.firstradiobutton,
                      groupValue: _radioValue,
                      onChanged: radioButtonSelection,
                    )
                ),
                ListTile(
                    horizontalTitleGap: 0.0,
                    title: Text('Equally shared between employer and employee',
                      style: TextStyle(
                          fontSize: small_FontSize,
                          fontWeight: normal_FontWeight,
                          fontFamily: robotoFontFamily,
                          color: blackColor
                      ),
                    ),
                    leading: Radio(
                      value: MonthlySalaryRadioButton.secondradiobutton,
                      groupValue: _radioValue,
                      onChanged: radioButtonSelection,
                    )
                ),*/
                SizedBox_22px,
                if (_firstContainerVisible)
                  FirstRadioButtonContainer(),
                if (_secondContainerVisible)
                  SecondRadioButtonContainer(),
                if (_firstContainerVisible==false && _secondContainerVisible==false)
                  FirstRadioButtonContainer(),
                SizedBox_20px,

              ],
            ),

          ],
        ),
      ),
    );
  }


  FirstRadioButtonContainer(){
    return
      Column(
        children: [
          Text("Proposed in hand salary for employee",
            style: TextStyle(
                fontSize: medium_FontSize,
                fontWeight: normal_FontWeight,
                fontFamily: robotoFontFamily,
                color: blackColor
            ),
          ),
          // SizedBox(height:20),

          Padding(
            padding:
            const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: TextField( inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
              keyboardType: TextInputType.number,
              // controller: searchController,
              onChanged: (value){

                            if(value=="" || value==null)
                            {
                              setState((){
                                showSalaryMinRangeErrorMsg_Visibility=false;
                                selectButton_Visibility=false;
                                inhandSalaryApiRequest=false;


                              });
                            }
                            else
                            {
                              salaryOffered=value;
                              getInHandSalary=value;
                              getCTCSalary="";
                            }

              },
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.fromLTRB(
                    20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(15.0)),
              ),
            ),
          ),
          SizedBox(height: 7,),


          showSalaryMinRangeErrorMsg_Visibility?
          Text(showSalaryMinRangeErrorMsg,textAlign: TextAlign.center,
            style: TextStyle(fontFamily: robotoFontFamily,color: redColor,fontSize: medium_FontSize,fontWeight: semiBold_FontWeight),):Container(),

          Padding(
            padding: const EdgeInsets.only(right: 2,top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(
                        backgroundColor: whiteColor,
                        elevation: 0,
                        textStyle: const TextStyle(fontSize: 20)
                    ),
                    onPressed: (){

                      //createBodyWebApi_InHandSalaryCalculator();

                      hitApiRequestType=Employee_InHandSalaryEmployee;
                      createBodyWebApi_CommonSalaryCalculatorApi();
                    },
                    child: Text("Calculate",
                      style: TextStyle(
                          backgroundColor: whiteColor,
                          fontSize: 20,
                          color: lightBlueColor,
                          fontFamily: robotoFontFamily,
                          fontWeight: bold_FontWeight
                      ),
                    )
                )

              ],
            ),
          ),



          selectButton_Visibility?getHealthBenefitColumn():Container(),

          SizedBox_20px,

          inhandSalaryApiRequest == true ?  Container(child: Column(children:
          [
            Center(
              child: Text(
                'Gross Salary Calculations',
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
              height: 50,
              decoration: BoxDecoration(
                  color: lightBlueColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )
              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      "Base Salary",
                      style: TextStyle(
                          fontSize: large_FontSize,
                          color: whiteColor,
                          fontWeight: normal_FontWeight,
                          fontFamily: robotoFontFamily),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: darkGreyColor),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  )
              ),
              child: Column(
                children: [
                  ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    itemCount: basicSalary.length,
                    itemBuilder:
                        (BuildContext context, int index) {
                      if (index == basicSalary.length - 1)
                      {
                        return Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 40,
                              height: 0.2,
                              color: darkGreyColor,
                            ),
                            ListTile(
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                              title: Text(
                                basicSalary[index],
                                style: TextStyle(
                                    color: lightBlueColor,
                                    fontSize: medium_FontSize,
                                    fontFamily: robotoFontFamily,
                                    fontWeight:
                                    semiBold_FontWeight),
                              ),
                              trailing: Text('${basicSalaryAmountsList[index]}',
                                  style: TextStyle(
                                      color: lightBlueColor,
                                      fontSize: medium_FontSize,
                                      fontFamily:
                                      robotoFontFamily,
                                      fontWeight:
                                      semiBold_FontWeight)),
                            ),
                          ],
                        );
                      }
                      return
                        Column(
                          children: [
                            ListTile(
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                              title: Text(basicSalary[index],style:
                              TextStyle(color: blackColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight)),
                              trailing: Text('${basicSalaryAmountsList[index]}',style:
                              TextStyle(color: blackColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight)),
                            ),
                            Container(
                                width: MediaQuery.of(context).size
                                    .width - 40, height: 1,
                                color: darkGreyColor),
                          ],
                        );
                    },
                  ),
                ],
              ),
            ),
            SizedBox_10px,
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: lightBlueColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )
              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      "Social Security Employer Part",
                      style: TextStyle(
                          fontSize: large_FontSize,
                          color: whiteColor,
                          fontWeight: normal_FontWeight,
                          fontFamily: robotoFontFamily),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: darkGreyColor),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  )
              ),
              child: Column(
                children: [
                  ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    itemCount: socialSecurityEmployer.length,
                    itemBuilder:
                        (BuildContext context, int index) {
                      if (index == socialSecurityEmployer.length - 1)
                      {
                        return Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 40,
                              height: 0.2,
                              color: darkGreyColor,
                            ),
                            ListTile(
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                              title: Text(
                                socialSecurityEmployer[index],
                                style: TextStyle(
                                    color: lightBlueColor,
                                    fontSize: medium_FontSize,
                                    fontFamily: robotoFontFamily,
                                    fontWeight:
                                    semiBold_FontWeight),
                              ),
                              trailing: Text('${socialSecurityEmployerAmountsList[index]}',
                                style: TextStyle(
                                    color: lightBlueColor,
                                    fontSize: medium_FontSize,
                                    fontFamily: robotoFontFamily,
                                    fontWeight:
                                    semiBold_FontWeight),
                              ),
                            ),
                          ],
                        );
                      }
                      return
                        Column(
                          children: [
                            ListTile(
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                              title: Text(socialSecurityEmployer[index],style:
                              TextStyle(color: blackColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight)),
                              trailing: Text('${socialSecurityEmployerAmountsList[index]}',style:
                              TextStyle(color: blackColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight)),
                            ),
                            Container(
                                width: MediaQuery.of(context).size
                                    .width - 40, height: 1,
                                color: darkGreyColor),
                          ],
                        );
                    },
                  ),
                ],
              ),
            ),

            /*----------4-2-2023 start------------*/
            SizedBox_10px,
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: lightBlueColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )
              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      "Social Security Employee Part",
                      style: TextStyle(
                          fontSize: large_FontSize,
                          color: whiteColor,
                          fontWeight: normal_FontWeight,
                          fontFamily: robotoFontFamily),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: darkGreyColor),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  )
              ),
              child: Column(
                children: [
                  ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    // padding: EdgeInsets.all(10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    itemCount: socialSecurityEmployee.length,
                    itemBuilder:
                        (BuildContext context, int index) {
                      if (index == socialSecurityEmployee.length - 1)
                      {
                        return Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 40,
                              height: 0.2,
                              color: darkGreyColor,
                            ),
                            ListTile(
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                              title: Text(
                                socialSecurityEmployee[index],
                                style: TextStyle(
                                    color: lightBlueColor,
                                    fontSize: medium_FontSize,
                                    fontFamily: robotoFontFamily,
                                    fontWeight:
                                    semiBold_FontWeight),
                              ),
                              trailing: Text('${socialSecurityEmployeeAmountsList[index]}',
                                style: TextStyle(
                                    color: lightBlueColor,
                                    fontSize: medium_FontSize,
                                    fontFamily: robotoFontFamily,
                                    fontWeight:
                                    semiBold_FontWeight),
                              ),
                            ),
                          ],
                        );
                      }
                      return
                        Column(
                          children: [
                            ListTile(
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                              title: Text(socialSecurityEmployee[index],style:
                              TextStyle(color: blackColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight)),
                              trailing: Text('${socialSecurityEmployeeAmountsList[index]}',style:
                              TextStyle(color: blackColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight)),
                            ),
                            Container(
                                width: MediaQuery.of(context).size
                                    .width - 40, height: 1,
                                color: darkGreyColor),
                          ],
                        );
                    },
                  ),
                ],
              ),
            ),


            /*----------------4-2-2023 end-------------------*/
            SizedBox_20px,
            Center(
                child: Text(
                  'Cost to Employer',
                  style: TextStyle(
                      fontSize: large_FontSize,
                      fontWeight: bold_FontWeight,
                      color: lightBlueColor,
                      fontFamily: robotoFontFamily),
                )),
            SizedBox_5px,
            Center(
                child: Text(
                  '₹: ${salaryCtcEmployeeSalaryList.first}',
                  // '₹ 25000.00',
                  style: TextStyle(
                      fontSize: large_FontSize,
                      fontWeight: bold_FontWeight,
                      color: blackColor,
                      fontFamily: robotoFontFamily),
                )),

            SizedBox_10px,

            SizedBox(height: 1,child: Container(width: 300,color: darkGreyColor,),),
            SizedBox_10px,

            Center(
                child: Text(
                  'Employee In Hand Salary',
                  style: TextStyle(
                      fontSize: large_FontSize,
                      fontWeight: bold_FontWeight,
                      color: lightBlueColor,
                      fontFamily: robotoFontFamily),
                )),
            SizedBox_5px,
            Center(
                child: Text(
                  '₹: ${showTheTravelSalaryAmount}',
                  // '₹ 25000.00',
                  style: TextStyle(
                      fontSize: large_FontSize,
                      fontWeight: bold_FontWeight,
                      color: blackColor,
                      fontFamily: robotoFontFamily),
                )),
          ],),):Container()

          // SizedBox_10px,

        ],
      );


  }

  SecondRadioButtonContainer(){
    return Column(
      children: [
        Text("Proposed Cost to employer (Monthly CTC)",
          style: TextStyle(
              fontSize: medium_FontSize,
              fontWeight: normal_FontWeight,
              fontFamily: robotoFontFamily,
              color: blackColor
          ),
        ),
        // SizedBox(height:20),
        Padding(
          padding:
          const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: TextFormField(inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
            keyboardType: TextInputType.number,
            // controller: searchController,
            onChanged: (value){

            if(value=="" || value==null)
              {
                setState((){
                  showSalaryMinRangeErrorMsg_Visibility=false;
                  selectButton_Visibility=false;
                  monthlySalaryApiRequest=false;

                });
              }
              else
                {
                  salaryOffered=value;
                  getCTCSalary=value;
                  getInHandSalary="";
                }

            },
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.fromLTRB(
                  20.0, 15.0, 20.0, 15.0),
              border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(15.0)),
            ),
          ),
        ),

        SizedBox(height: 7,),

        showSalaryMinRangeErrorMsg_Visibility?
        Text(showSalaryMinRangeErrorMsg,textAlign: TextAlign.center,
          style: TextStyle(fontFamily: robotoFontFamily,color: redColor,fontSize: medium_FontSize,fontWeight: semiBold_FontWeight),):Container(),


        Padding(
          padding: const EdgeInsets.only(right: 2,top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(
                      backgroundColor: whiteColor,
                      elevation: 0,
                      textStyle: const TextStyle(fontSize: 20)
                  ),
                  onPressed: (){
                    //createBodyWebApi_MonthlyCtcCalculator();
                    hitApiRequestType=Employee_CTCEmployee;
                    createBodyWebApi_CommonSalaryCalculatorApi();

                  },
                  child: Text("Calculate",
                    style: TextStyle(
                        backgroundColor: whiteColor,
                        fontSize: 20,
                        color: darkBlueColor,
                        fontFamily: robotoFontFamily,
                        fontWeight: bold_FontWeight
                    ),
                  )
              )

            ],
          ),
        ),


        selectButton_Visibility?getHealthBenefitColumn():Container(),
        SizedBox_20px,
        monthlySalaryApiRequest==true ?  Container(child: Column(children:
        [
          Center(
              child: Text(
                'Gross Salary Calculations',
                style: TextStyle(
                    fontSize: medium_FontSize,
                    color: blackColor,
                    fontFamily: robotoFontFamily,
                    fontWeight: bold_FontWeight
                ),
              )),
          SizedBox_20px,
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: lightBlueColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text(
                    "Base Salary",
                    style: TextStyle(
                        fontSize: large_FontSize,
                        color: whiteColor,
                        fontWeight: normal_FontWeight,
                        fontFamily: robotoFontFamily),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: darkGreyColor),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                )
            ),
            child: Column(
              children: [
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  itemCount: basicSalary.length,
                  itemBuilder:
                      (BuildContext context, int index) {
                    if (index == basicSalary.length - 1)
                      // print("print index $index");
                        {
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 0.2,
                            color: darkGreyColor,
                          ),
                          ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            title: Text(
                              basicSalary[index],
                              style: TextStyle(
                                  color: lightBlueColor,
                                  fontSize: medium_FontSize,
                                  fontFamily: robotoFontFamily,
                                  fontWeight:
                                  semiBold_FontWeight),
                            ),
                            trailing: Text('${basicSalaryAmountsList[index]}',
                              style: TextStyle(
                                  color: lightBlueColor,
                                  fontSize: medium_FontSize,
                                  fontFamily: robotoFontFamily,
                                  fontWeight:
                                  semiBold_FontWeight),
                            ),
                          ),
                        ],
                      );
                    }
                    return
                      Column(
                        children: [
                          ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            title: Text(basicSalary[index],style:
                            TextStyle(color: blackColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight)),
                            trailing: Text('${basicSalaryAmountsList[index]}',style:
                            TextStyle(color: blackColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight)),
                          ),
                          Container(
                              width: MediaQuery.of(context).size
                                  .width - 40, height: 1,
                              color: Colors.grey),
                        ],
                      );
                  },
                ),
              ],
            ),
          ),
          SizedBox_10px,
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: lightBlueColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text(
                    "Social Security Employer Part",
                    style: TextStyle(
                        fontSize: large_FontSize,
                        color: whiteColor,
                        fontWeight: normal_FontWeight,
                        fontFamily: robotoFontFamily),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: darkGreyColor),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                )
            ),
            child: Column(
              children: [
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  itemCount: socialSecurityEmployer.length,
                  itemBuilder:
                      (BuildContext context, int index) {
                    if (index == socialSecurityEmployer.length - 1)
                    {
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 0.2,
                            color: darkGreyColor,
                          ),
                          ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            title: Text(
                              socialSecurityEmployer[index],
                              style: TextStyle(
                                  color: lightBlueColor,
                                  fontSize: medium_FontSize,
                                  fontFamily: robotoFontFamily,
                                  fontWeight:
                                  semiBold_FontWeight),
                            ),
                            trailing: Text('${socialSecurityEmployerAmountsList[index]}',
                              style: TextStyle(
                                  color: lightBlueColor,
                                  fontSize: medium_FontSize,
                                  fontFamily: robotoFontFamily,
                                  fontWeight:
                                  semiBold_FontWeight),
                            ),
                          ),
                        ],
                      );
                    }
                    return
                      Column(
                        children: [
                          ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            title: Text(socialSecurityEmployer[index],style:
                            TextStyle(color: blackColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight)),
                            trailing: Text('${socialSecurityEmployerAmountsList[index]}',style:
                            TextStyle(color: blackColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight)),
                          ),
                          Container(
                              width: MediaQuery.of(context).size
                                  .width - 40, height: 1,
                              color: darkGreyColor),
                        ],
                      );
                  },
                ),
              ],
            ),
          ),
          SizedBox_10px,
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: lightBlueColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text(
                    "Social Security Employee Part",
                    style: TextStyle(
                        fontSize: large_FontSize,
                        color: whiteColor,
                        fontWeight: normal_FontWeight,
                        fontFamily: robotoFontFamily),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: darkGreyColor),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                )
            ),
            child: Column(
              children: [
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  // padding: EdgeInsets.all(10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  itemCount: socialSecurityEmployee.length,
                  itemBuilder:
                      (BuildContext context, int index) {
                    if (index == socialSecurityEmployee.length - 1)
                    {
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 0.2,
                            color: darkGreyColor,
                          ),
                          ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            title: Text(
                              socialSecurityEmployee[index],
                              style: TextStyle(
                                  color: lightBlueColor,
                                  fontSize: medium_FontSize,
                                  fontFamily: robotoFontFamily,
                                  fontWeight:
                                  semiBold_FontWeight),
                            ),
                            trailing: Text('${socialSecurityEmployeeAmountsList[index]}',
                              style: TextStyle(
                                  color: lightBlueColor,
                                  fontSize: medium_FontSize,
                                  fontFamily: robotoFontFamily,
                                  fontWeight:
                                  semiBold_FontWeight),
                            ),
                          ),
                        ],
                      );
                    }
                    return
                      Column(
                        children: [
                          ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            title: Text(socialSecurityEmployee[index],style:
                            TextStyle(color: blackColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight)),
                            trailing: Text('${socialSecurityEmployeeAmountsList[index]}',style:
                            TextStyle(color: blackColor,fontSize: small_FontSize,fontFamily: robotoFontFamily,fontWeight: normal_FontWeight)),
                          ),
                          Container(
                              width: MediaQuery.of(context).size
                                  .width - 40, height: 1,
                              color: darkGreyColor),
                        ],
                      );
                  },
                ),
              ],
            ),
          ),

          /*-------4-2-2023 START------*/

          SizedBox_20px,
          Center(
              child: Text(
                'Cost to Employer',
                style: TextStyle(
                    fontSize: large_FontSize,
                    fontWeight: bold_FontWeight,
                    color: lightBlueColor,
                    fontFamily: robotoFontFamily),
              )),
          SizedBox_5px,
          Center(
              child: Text(
                '₹: ${salaryCtcEmployeeSalaryList.first}',
                // '₹ 25000.00',
                style: TextStyle(
                    fontSize: large_FontSize,
                    fontWeight: bold_FontWeight,
                    color: blackColor,
                    fontFamily: robotoFontFamily),
              )),

          SizedBox_10px,

          /*--------4-2-2023 END---------*/

          SizedBox_20px,
          Center(
              child: Text(
                'Employee Monthly Gross Salary (In-hand)',
                style: TextStyle(
                    fontSize: large_FontSize,
                    fontWeight: bold_FontWeight,
                    color: lightBlueColor,
                    fontFamily: robotoFontFamily),
              )),
          SizedBox_5px,
          Center(
              child: Text(
                '₹: ${salaryInhandEmployeeSalaryList.first}',
                style: TextStyle(
                    fontSize: large_FontSize,
                    fontWeight: bold_FontWeight,
                    color: blackColor,
                    fontFamily: robotoFontFamily),
              )),
        ],),):Container()
        // SizedBox_10px,

      ],
    );
  }


  Column getHealthBenefitColumn()
  {
    return  Column(
      children: [
        SizedBox(height: 10,),
        Text('Social Security Eligibility',textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: large_FontSize,
              fontWeight: semiBold_FontWeight,
              fontFamily: robotoFontFamily,
              color: blackColor
          ),
        ),
        SizedBox(height: 10,),
        Text('Based on the desired $subHintText chosen by you, your employee shall be eligible for the following:',
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
        retirementBenefitsCheckbox("Retirement & Insurance (PF Scheme)")

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

            HintWidget(globalKey: esicGlobalKey,title: "",description: getHealthBenefit_ESIScheme,child:InkWell(onTap: ()
            {

              WidgetsBinding.instance.addPostFrameCallback((_) =>
                  ShowCaseWidget.of(context)
                      .startShowCase([esicGlobalKey]));

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


     /* if(check_PF=="" || check_PF==null || check_PF=="0")
      {
        //if PF Not avaialble then show the unselected checkbox
        retirementBenefit_Check=false;
      }
      else
      {
        //if PF avaialble then show the selected checkbox grey color
        retirementBenefit_Check=true;
      }*/




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
                  (states) => BorderSide(width: 1.0, color: calPFOptedStatus==true?greenColor:blackColor),
            ),
            value: retirementBenefit_Check,
            onChanged: (bool? value)
            {
             // print("show the change status value $value");

              if(calPFOptedStatus==true)
                {
                    //use for only read only
                }else
                  {
                    //use for editable

                    if(value==true)
                      {
                        calPFOptedValue="Y";
                        setState(() {
                          retirementBenefit_Check = true;
                        });
                      }
                    else
                      {
                        calPFOptedValue="N";
                        setState(() {
                          retirementBenefit_Check = false;
                        });
                      }

                    print("show the calPFOptedValue status value $calPFOptedValue");
                    createBodyWebApi_CommonSalaryCalculatorApi();
                  }

            },
          ),
          Flexible(
              child:  Text(schemeText,
                style: TextStyle(
                    color: calPFOptedStatus==true?greenColor:darkGreyColor,
                    fontWeight: normal_FontWeight,
                    fontFamily: robotoFontFamily,
                    fontSize: medium_FontSize
                ),
              )
          ),
          SizedBox(width: 5,),

          HintWidget(globalKey: pfGlobalKey,title: "",description: getHealthBenefit_PFScheme,child:InkWell(onTap: ()
          {

            WidgetsBinding.instance.addPostFrameCallback((_) =>
                ShowCaseWidget.of(context)
                    .startShowCase([pfGlobalKey]));

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


  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Confirm", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      // print("show the continue action");
      // print("total,${balance_MapObject}");

     // Navigator.pop(context,[Employer_NewWorkPlaceAddEmployee(),showTheTravelSalaryAmountCtc,balance_MapObject]);

      //TalentNavigation().pushTo(context, Employer_NewWorkPlaceAddDOJ(liveModelObj: widget.liveModelObj,mapObj: widget.mapObj,salaryCalMap: balance_MapObject,));

      createBodyWebApi_EmployerAddEmployee();
    }
    )) ;

  }


  /*--------------hit the Monthly CTC Calculator service request start 19-12-2022..pratibha---------------*/

  monthlyCtcCalculatorData(data)
  {

    print("show the data records $data");
    print("show the data employergratuity ${data.employergratuity}");
    print("show the data epfEmployer ${data.epfEmployer}");
    print("show the data gross ${data.gross}");

    setState(() {

      monthlySalaryApiRequest=true;
      selectButton_Visibility=true;

      balance_MapObject.clear();
      balance_MapObject = {
        "monthlyofferedpackage": data.monthlyofferedpackage,
        "basic": data.basic,
        "hra": data.hra,
        "allowances": data.allowances,
        "gross": data.gross,
        "epf_employer": data.epfEmployer,
        "epf_employee": data.epfEmployee,
        "esi_employer": data.esiEmployer,
        "esi_employee": data.esiEmployee,
        "ctc": data.ctc,
        "salary_in_hand": data.salaryInHand,
        "employersocialsecurity": data.employeesocialsecurity,
        "employeesocialsecurity": data.employeesocialsecurity,
        "salarygenerationbase": data.salarygenerationbase,
        "personalinfoid":data.personalinfoid,
        "salarycategoryname":data.salarycategoryname,
        "esiexceptionalcase":data.esiexceptionalcase,
        "salarydays":data.salarydays,
        "salarydaysopted":data.pSalarydaysopted,
        "minwagescategoryid":data.minwagescategoryid,
        "minimumwagessalary":data.minimumwagessalary,
        "uannumber":data.uannumber,
        "calcresult": data.calcresult,
        "suggestivesalary": data.suggestivesalary,
        "salmessage": data.salmessage,
        "minwagescategoryname":data.minwagescategoryname,
        "minwagestatename":data.minwagestatename

      };

      /*--------------pf manage by basic salary and uan number 3-2-2023 start----------------*/
      var basicSalaryList=data.basic;
      String uanNumber=data.uannumber;
      if(uanNumber=="" || uanNumber==null || uanNumber=="0")
      {
        uanNumber="";
      }

      if(int.parse(basicSalaryList)<=15000 || uanNumber != "" || data.salarycategoryname=="PF")
      {
        print("// show the selected status 1");
        if(calPFOptedValue=="Y" && data.salarycategoryname=="PF")
          {
            print("show the selected status one true");

            calPFOptedStatus=false;
            retirementBenefit_Check=true;
          }
        else  if(calPFOptedValue=="N" && data.salarycategoryname != "PF")
        {
          print("show the selected status one false");

          calPFOptedStatus=false;
          retirementBenefit_Check=false;
        }
        else
          {
            print("show the selected status two");

            calPFOptedValue="";
            calPFOptedStatus=true;
            retirementBenefit_Check=true;
          }

      }
      else
      {
        print("show the selected status three");

        calPFOptedStatus=false;
        retirementBenefit_Check=false;

      }
      /*--------------pf manage by basic salary and uan number 3-2-2023 end----------------*/


      var hraSalaryList=data.hra;
      var allowancesSalaryList=data.allowances;
      var grossSalaryList=data.gross;

      var epfEmployerSalaryList=data.epfEmployer;
      var esiEmployerSalaryList=data.esiEmployer;
      var gratuitySalaryList=data.employergratuity;
      var employerTotalSalaryList=data.employersocialsecurity;
      var epfEmployeeSalaryList=data.epfEmployee;
      var esiEmployeeSalaryList=data.esiEmployee;
      var employeeTotalSalaryList=data.employeesocialsecurity;

      var salaryinhand=data.salaryInHand;
      var salaryCtc=data.ctc;


      /*------30-1-2023 start-------*/
      check_PF=epfEmployerSalaryList.toString();
      check_ESIC=esiEmployerSalaryList.toString();
      /*------30-1-2023 end-------*/



      salaryCtcEmployeeSalaryList.clear();
      salaryCtcEmployeeSalaryList.add(salaryCtc);

      salaryInhandEmployeeSalaryList.clear();
      salaryInhandEmployeeSalaryList.add(salaryinhand);

      showTheTravelSalaryAmount=salaryinhand.toString();
      showTheTravelSalaryAmountCtc=salaryCtc.toString();
      // print("salary in hand, $salaryInhandEmployeeSalaryList");

      basicSalaryAmountsList.clear();
      basicSalaryAmountsList.add(basicSalaryList);
      basicSalaryAmountsList.add(hraSalaryList);
      basicSalaryAmountsList.add(allowancesSalaryList);
      basicSalaryAmountsList.add(grossSalaryList);
      // print("print basiclist, $basicSalaryAmountsList");

      socialSecurityEmployerAmountsList.clear();
      socialSecurityEmployerAmountsList.add(epfEmployerSalaryList);
      socialSecurityEmployerAmountsList.add(esiEmployerSalaryList);
      //socialSecurityEmployerAmountsList.add(gratuitySalaryList);
      socialSecurityEmployerAmountsList.add(employerTotalSalaryList);
      // print("print socialemployerlist, $socialSecurityEmployerAmountsList");

      socialSecurityEmployeeAmountsList.clear();
      socialSecurityEmployeeAmountsList.add(epfEmployeeSalaryList);
      socialSecurityEmployeeAmountsList.add(esiEmployeeSalaryList);
      socialSecurityEmployeeAmountsList.add(employeeTotalSalaryList);
      // print("print socialemployeelist, $socialSecurityEmployeeAmountsList");

    });
  }

   /*-----------19-12-2022 end--------------*/

  /*--------------hit the InHand Salary Calculator service request start 23-12-2022..pratibha---------------*/

  inHandSalaryCalculatorData(data)
  {
    setState(() {
//
      inhandSalaryApiRequest=true;
      selectButton_Visibility=true;

      balance_MapObject.clear();
      balance_MapObject = {
        "monthlyofferedpackage": data.monthlyofferedpackage,
        "basic": data.basic,
        "hra": data.hra,
        "allowances": data.allowances,
        "gross": data.gross,
        "epf_employer": data.epfEmployer,
        "epf_employee": data.epfEmployee,
        "esi_employer": data.esiEmployer,
        "esi_employee": data.esiEmployee,
        "ctc": data.ctc,
        "salary_in_hand": data.salaryInHand,
        "employersocialsecurity": data.employeesocialsecurity,
        "employeesocialsecurity": data.employeesocialsecurity,
        "salarygenerationbase": data.salarygenerationbase,
        "personalinfoid":data.personalinfoid,
        "salarycategoryname":data.salarycategoryname,
        "esiexceptionalcase":data.esiexceptionalcase,
        "salarydays":data.salarydays,
        "salarydaysopted":data.pSalarydaysopted,
        "minwagescategoryid":data.minwagescategoryid,
        "minimumwagessalary":data.minimumwagessalary,
        "uannumber":data.uannumber,
        "calcresult": data.calcresult,
        "suggestivesalary": data.suggestivesalary,
        "salmessage": data.salmessage,
        "minwagescategoryname":data.minwagescategoryname,
        "minwagestatename":data.minwagestatename

      };

      /*--------------pf manage by basic salary and uan number 3-2-2023 start----------------*/
      var basicSalaryList=data.basic;
      String uanNumber=data.uannumber;
      if(uanNumber=="" || uanNumber==null || uanNumber=="0")
      {
        uanNumber="";
      }

      if(int.parse(basicSalaryList)<=15000 || uanNumber != "" || data.salarycategoryname=="PF")
      {
        print("// show the selected status 1");
        if(calPFOptedValue=="Y" && data.salarycategoryname=="PF")
        {
          print("show the selected status one true");

          calPFOptedStatus=false;
          retirementBenefit_Check=true;
        }
        else  if(calPFOptedValue=="N" && data.salarycategoryname != "PF")
        {
          print("show the selected status one false");

          calPFOptedStatus=false;
          retirementBenefit_Check=false;
        }
        else
        {
          print("show the selected status two");

          calPFOptedValue="";
          calPFOptedStatus=true;
          retirementBenefit_Check=true;
        }
      }
      else
      {
        print("show the selected status 2");

        calPFOptedStatus=false;
        retirementBenefit_Check=false;

      }
      /*--------------pf manage by basic salary and uan number 3-2-2023 end----------------*/

      var hraSalaryList=data.hra;
      var allowancesSalaryList=data.allowances;
      var grossSalaryList=data.gross;
      var epfEmployerSalaryList=data.epfEmployer;
      var esiEmployerSalaryList=data.esiEmployer;
      var gratuitySalaryList=data.employergratuity;
      var employerTotalSalaryList=data.employersocialsecurity;
      var epfEmployeeSalaryList=data.epfEmployee;
      var esiEmployeeSalaryList=data.esiEmployee;
      var employeeTotalSalaryList=data.employeesocialsecurity;
      var salaryCtc=data.ctc;
      var salaryinhand=data.salaryInHand;

      /*------30-1-2023 start-------*/
      check_PF=epfEmployerSalaryList.toString();
      check_ESIC=esiEmployerSalaryList.toString();
      /*------30-1-2023 end-------*/

      // print("salary CTC, $salaryCtc");
      salaryCtcEmployeeSalaryList.clear();
      salaryCtcEmployeeSalaryList.add(salaryCtc);
      // print("salary Ctc, $salaryCtcEmployeeSalaryList");

      showTheTravelSalaryAmount=salaryinhand.toString();
      showTheTravelSalaryAmountCtc=salaryCtc.toString();

      // print("salary in hand, $salaryInhandEmployeeSalaryList");
      salaryInhandEmployeeSalaryList.clear();
      salaryInhandEmployeeSalaryList.add(salaryinhand);
      basicSalaryAmountsList.clear();
      basicSalaryAmountsList.add(basicSalaryList);
      basicSalaryAmountsList.add(hraSalaryList);
      basicSalaryAmountsList.add(allowancesSalaryList);
      basicSalaryAmountsList.add(grossSalaryList);
      // print("print basiclist, $basicSalaryAmountsList");
      // print("print calllist, $grossSalaryAmountsList");
      socialSecurityEmployerAmountsList.clear();
      socialSecurityEmployerAmountsList.add(epfEmployerSalaryList);
      socialSecurityEmployerAmountsList.add(esiEmployerSalaryList);
      //socialSecurityEmployerAmountsList.add(gratuitySalaryList);
      socialSecurityEmployerAmountsList.add(employerTotalSalaryList);
      // print("print socialemployerlist, $socialSecurityEmployerAmountsList");
      socialSecurityEmployeeAmountsList.clear();
      socialSecurityEmployeeAmountsList.add(epfEmployeeSalaryList);
      socialSecurityEmployeeAmountsList.add(esiEmployeeSalaryList);
      socialSecurityEmployeeAmountsList.add(employeeTotalSalaryList);
      // print("print socialemployeelist, $socialSecurityEmployeeAmountsList");

    });
  }

/*-----------23-12-2022 end--------------*/


/*------------------common api method for salary calculator start 29-1-2023------------------*/
  createBodyWebApi_CommonSalaryCalculatorApi()
  {

    //  String hintText="Enter Monthly CTC/ In-hand Salary";
    if(hitApiRequestType==Employee_InHandSalaryEmployee)
      {
        //inhandsalary
        salaryOffered=getInHandSalary;
        hintText="Enter In-hand Salary";
      }else
        {
          //ctc
          salaryOffered=getCTCSalary;
          hintText="Enter Monthly CTC";

        }

    if(salaryOffered=="")
      {
        CJSnackBar(context, hintText);
        return;
      }

    var mapObject=Map();
    mapObject["js_id"]=widget.mapObj!["jsId"];
    mapObject["minwages_state"]=widget.employeeAddObj!["minWageStateName"];
    mapObject["doj"]=widget.employeeAddObj!["dateOfJoining"];

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
          InHandSalaryCalculatorModelClass calModel=modelResponse as InHandSalaryCalculatorModelClass;

          setState(() {
            showSalaryMinRangeErrorMsg_Visibility=false;
          });
          if(salaryCalculateType==Employee_InHandSalaryEmployee)
          {
            //inhandsalary
            print("show the server response inhand salary");
            inHandSalaryCalculatorData(calModel);
          }else
          {
            //ctc
            print("show the server response ctc salary");

            monthlyCtcCalculatorData(calModel);

          }


        }, employerFailureBlock:<T>(commonResponse,failure)
        {
          EasyLoading.dismiss();

          setState(() {
            inhandSalaryApiRequest=false;
            monthlySalaryApiRequest=false;

          });


          CJTalentCommonModelClass commonModelClass=failure as CJTalentCommonModelClass;
          if (commonModelClass?.message==null || commonModelClass?.message=="")
          {
            setState(() {
              showSalaryMinRangeErrorMsg_Visibility=false;
            });
            CJSnackBar(context, "server error!");
          }else
          {
            if(commonModelClass.errorMessage==null || commonModelClass.errorMessage=="")
              {
                setState(() {
                  showSalaryMinRangeErrorMsg_Visibility=false;
                });
                CJSnackBar(context, commonModelClass!.message!);
              }
            else
              {
                setState(() {
                  showSalaryMinRangeErrorMsg_Visibility=true;
                  showSalaryMinRangeErrorMsg=commonModelClass.message!;
                  selectButton_Visibility=false;

                });

              }
          }

        }));
  }



/*------------------common api method for salary calculator end 29-1-2023------------------*/

  /*------------31-1-2023 start------------*/
  createBodyWebApi_EmployerAddEmployee()
  {

   /* var mainMapBody=Map();
    mainMapBody["jsId"]=getEncryptedData(widget.mapObj!["jsId"]);
    mainMapBody["dateOfJoining"]=doj;
    mainMapBody["tpSalaryStructure"]=[widget.salaryCalMap];
    mainMapBody["jobRole"]=designation;
    mainMapBody["customerAccountId"]=getEncryptedData(widget.liveModelObj?.tpAccountId);
    mainMapBody["tpLeaveTemplateId"]=leaveTemplateId;
    mainMapBody["creatdBy"]=widget.liveModelObj?.tpAccountId;
    mainMapBody["createdbyIp"]=IPAddress;

    serviceRequest_AddEmployee(getEncrypted_MapBody(mainMapBody));*/


    widget.employeeAddObj!["tpSalaryStructure"]=[balance_MapObject];



    serviceRequest_AddEmployee(getEncrypted_MapBody(widget.employeeAddObj!));


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



/*createBodyWebApi_MonthlyCtcCalculator()
{
  *//* var emp_code="5216";
    var customeraccountid= "75";*//*
  var mapObject=getEmployer_MonthlyCtcCalculator_RequestBody(salaryOffered,widget.liveModelObj?.employerId,widget.liveModelObj?.tpAccountId);
  serviceRequest_MonthlyCtcCalculator(mapObject);
}

serviceRequest_MonthlyCtcCalculator(Map mapObject)
{

  EasyLoading.show(status: Message.get_LoaderMessage);

  CJEmployerServiceRequest().postDataServiceRequest(mapObject,JG_ApiMethod_MonthlyCtcCalculator,
      cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
      {
        // print("print model response $modelResponse");
        EasyLoading.dismiss();
        MonthlyCtcCalculatorModelClass calModel=modelResponse as MonthlyCtcCalculatorModelClass;
        monthlyCtcCalculatorData(calModel);

      }, employerFailureBlock:<T>(commonResponse,failure)
      {
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

createBodyWebApi_InHandSalaryCalculator()
{
  var emp_code="";
  //var customeraccountid= "75";

  var mapObject=getEmployer_InHandSalaryCalculator_RequestBody(salaryOffered,emp_code,widget.liveModelObj?.tpAccountId);
  serviceRequest_InHandSalaryCalculator(mapObject);

}

serviceRequest_InHandSalaryCalculator(Map mapObject)
{

  EasyLoading.show(status: Message.get_LoaderMessage);

  CJEmployerServiceRequest().postDataServiceRequest(mapObject,JG_ApiMethod_InHandSalaryCalculator,
      cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
      {

        // print("print model response $modelResponse");
        EasyLoading.dismiss();
        InHandSalaryCalculatorModelClass calModel=modelResponse as InHandSalaryCalculatorModelClass;
        inHandSalaryCalculatorData(calModel);

      }, employerFailureBlock:<T>(commonResponse,failure)
      {
        EasyLoading.dismiss();

        CJTalentCommonModelClass commonModelClass=failure as CJTalentCommonModelClass;
        if (commonModelClass?.message==null || commonModelClass?.message=="")
        {
          CJSnackBar(context, "server error!");
        }else {
          CJSnackBar(context, commonModelClass!.message!);
        }

      }));
}*/

