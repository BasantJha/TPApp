import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/ModelClasses/CJTalentCommonModelClass.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/Services/CJEmployerService/CJEmployerServiceRequest.dart';
import 'package:contractjobs/Services/CJEmployerService/CJEmployerServiceURL.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../../CustomView/CustomRow/AstricRow.dart';
import '../../../../../../CustomView/MarginSizeBox/MarginSizeBox.dart';
import '../../../../../../CustomView/ViewHint/CustomViewHint.dart';
import '../../../../../../CustomView/ViewHint/ViewHintText.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../../Services/Messages/Message.dart';
import '../../../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../../../EmployerModelClasses/EmployerAddEmployeeModelClass/CalculatorModelClass.dart';
import '../../../EmployerModelClasses/EmployerSignUpModelClasses/EmployerSignUpModelClass.dart';
import '../../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import 'Employer_NewWorkPlaceAddEmployee.dart';

enum MonthlySalaryRadioButton {firstradiobutton, secondradiobutton}

class Employer_NewWorkPlaceAddCalculator extends StatefulWidget
{
  const Employer_NewWorkPlaceAddCalculator({Key? key, this.liveModelObj}) : super(key: key);
  final Employer_VerifyMobileNoModelClass? liveModelObj;


  @override
  State<Employer_NewWorkPlaceAddCalculator> createState() => _Employer_NewWorkPlaceAddCalculator();
}

class _Employer_NewWorkPlaceAddCalculator extends State<Employer_NewWorkPlaceAddCalculator>
{

  MonthlySalaryRadioButton? _radioValue = MonthlySalaryRadioButton.firstradiobutton;
  bool _firstContainerVisible = false;
  bool _secondContainerVisible = false;
  String searchValue='';

  void radioButtonSelection(MonthlySalaryRadioButton? value) {
    setState(() {
      _radioValue = value;
      _firstContainerVisible = value == MonthlySalaryRadioButton.firstradiobutton;
      _secondContainerVisible = value == MonthlySalaryRadioButton.secondradiobutton;
    });
  }

  TextEditingController searchController = new TextEditingController();

  List basicSalaryAmountsList=[0,0,0,0];
  List socialSecurityEmployerAmountsList=[0,0,0,0];
  List socialSecurityEmployeeAmountsList=[0,0,0,0];
  List salaryInhandEmployeeSalaryList=['0'];
  List salaryCtcEmployeeSalaryList=['0'];
  List AllSalaryList=[];

  final List<String> basicSalary = <String>['Basic', 'HRA', 'Special Allowance', 'Sub Total (A)'];
  final List<int> basicSalaryAmounts = <int>[0, 0, 0, 10];

  final List<String> socialSecurityEmployer = <String>['EPF', 'ESIC', 'Gratutity', 'Sub Total (B)'];
  final List<int> socialSecurityEmployerAmounts = <int>[0, 0, 0, 10];

  final List<String> socialSecurityEmployee = <String>['EPF', 'ESIC', 'Sub Total (B)'];
  final List<int> socialSecurityEmployeeAmounts = <int>[0, 0, 10];

  var showTheTravelSalaryAmount="";
  var showTheTravelSalaryAmountCtc="";
  var balance_MapObject=Map();

  bool inhandSalaryApiRequest=false;
  bool monthlySalaryApiRequest=false;

  String salaryInhand="";


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor: whiteColor,
      appBar:CJAppBar(getEmployer_PayoutCalculatorTitle, appBarBlock: AppBarBlock(appBarAction: ()
      {
        // print("show the action type");
        Navigator.pop(context);
      })),
      body: getResponsiveUI(),
      bottomNavigationBar: Padding(padding: EdgeInsets.only(left: 90,right: 90),child: elevatedButtonBottomBar(),),
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
            Center(
              child: getViewHintTextBlue(getEmployee_MonthlySalaryHint),
            ),
            SizedBox(
              height: 30,
            ),

            Padding(padding: EdgeInsets.only(left: 23),child: getAstricRow("Social Security Responsibility"),)
            ,
            SizedBox(height: 7),
            Column(
              children: [
                ListTile(
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
                ),
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
                searchValue=value;
              },
              decoration: InputDecoration(
                hintText: 'eg. 20,000',
                contentPadding: EdgeInsets.fromLTRB(
                    20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(15.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 2,top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor: whiteColor,
                        elevation: 0,
                        textStyle: const TextStyle(fontSize: 20)
                    ),
                    onPressed: (){
                      createBodyWebApi_InHandSalaryCalculator();
                    },
                    child: Text("Calculate",
                      style: TextStyle(
                        backgroundColor: whiteColor,
                        fontSize: large_FontSize,
                        color: lightBlueColor,
                        fontFamily: robotoFontFamily,
                        fontWeight: bold_FontWeight
                      ),
                    )
                )

              ],
            ),
          ),
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
              searchValue=value;
            },
            decoration: InputDecoration(
              hintText: 'eg. 20,000',
              contentPadding: EdgeInsets.fromLTRB(
                  20.0, 15.0, 20.0, 15.0),
              border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(15.0)),
            ),
          ),
        ),
       /* Padding(
          padding: const EdgeInsets.only(right: 15,top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(
                      backgroundColor: whiteColor,
                      elevation: 0,
                      textStyle: const TextStyle(fontSize: 20)
                  ),
                  onPressed: (){
                    createBodyWebApi_MonthlyCtcCalculator();
                    // getServiceRequest_Calculator();
                  },
                  child: Text("Calculate",
                    style: TextStyle(
                        backgroundColor: whiteColor,
                        fontSize: medium_FontSize,
                        color: lightBlueColor,
                        fontFamily: robotoFontFamily,
                        fontWeight: normal_FontWeight
                    ),
                  )
              )

            ],
          ),
        ),*/

        Padding(
          padding: const EdgeInsets.only(right: 2,top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(
                      backgroundColor: whiteColor,
                      elevation: 0,
                      textStyle: const TextStyle(fontSize: 20)
                  ),
                  onPressed: (){
                    createBodyWebApi_MonthlyCtcCalculator();

                  },
                  child: Text("Calculate",
                    style: TextStyle(
                        backgroundColor: whiteColor,
                        fontSize: large_FontSize,
                        color: lightBlueColor,
                        fontFamily: robotoFontFamily,
                        fontWeight: bold_FontWeight
                    ),
                  )
              )

            ],
          ),
        ),
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

  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Select", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      // print("show the continue action");
      // print("total,${balance_MapObject}");

      Navigator.pop(context,[Employer_NewWorkPlaceAddEmployee(),showTheTravelSalaryAmountCtc,balance_MapObject]);
    }
    )) ;

  }


  /*--------------hit the Monthly CTC Calculator service request start 19-12-2022..pratibha---------------*/
  createBodyWebApi_MonthlyCtcCalculator()
  {
   /* var emp_code="5216";
    var customeraccountid= "75";*/
    var mapObject=getEmployer_MonthlyCtcCalculator_RequestBody(searchValue,widget.liveModelObj?.employerId,widget.liveModelObj?.tpAccountId);
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

  monthlyCtcCalculatorData(data)
  {
    setState(() {

      monthlySalaryApiRequest=true;


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
        "employergratuity": data.employergratuity,
        "ctc": data.ctc,
        "salary_in_hand": data.salaryInHand,
        "employersocialsecurity": data.employeesocialsecurity,
        "employeesocialsecurity": data.employeesocialsecurity,
        "salarygenerationbase": data.salarygenerationbase
      };

      var basicSalaryList=data.basic;
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
      socialSecurityEmployerAmountsList.add(gratuitySalaryList);
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
  createBodyWebApi_InHandSalaryCalculator()
  {
    var emp_code="";
    //var customeraccountid= "75";

    var mapObject=getEmployer_InHandSalaryCalculator_RequestBody(searchValue,emp_code,widget.liveModelObj?.tpAccountId);
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
  }

  inHandSalaryCalculatorData(data)
  {
    setState(() {
//
      inhandSalaryApiRequest=true;

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
        "employergratuity": data.employergratuity,
        "ctc": data.ctc,
        "salary_in_hand": data.salaryInHand,
        "employersocialsecurity": data.employeesocialsecurity,
        "employeesocialsecurity": data.employeesocialsecurity,
        "salarygenerationbase": data.salarygenerationbase
      };

      var basicSalaryList=data.basic;
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
      socialSecurityEmployerAmountsList.add(gratuitySalaryList);
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

}

