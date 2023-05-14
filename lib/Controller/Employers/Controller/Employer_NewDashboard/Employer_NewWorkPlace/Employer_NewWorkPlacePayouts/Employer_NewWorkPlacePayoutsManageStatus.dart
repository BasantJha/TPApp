import 'dart:core';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/Services/AESAlgo/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../../Constant/Constants.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../../../../Constant/Responsive.dart';
import '../../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../../Services/AESAlgo/Keys.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../../Services/Messages/Message.dart';
import '../../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../../../TankhaPayModule/Controller/ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfileChild.dart';
import '../../../EmployerModelClasses/EmployerAttendanceModelClass/Employer_NewWorkPlaceAttendanceCalendarModelClasses/Employer_NewWorkPlaceAttendanceCalender_SaveMonthlyAttendance_ModelClass.dart';
import '../../../EmployerModelClasses/EmployerPaymentModelClass/PaymentInvoiceModelClass.dart';
import '../../../EmployerModelClasses/EmployerPayoutModelClass/EmployerPayOutDetailsModelClass.dart';
import '../../../EmployerModelClasses/EmployerPayoutModelClass/EmployerPayOutModelClass.dart';
import '../../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../../Employer_NewPayment/Employer_NewPaymentInvoice.dart';
import '../../Employer_NewPayment/Employer_NewPaymentPlan.dart';
import '../../Employer_NewProfile/Employer_NewProfile.dart';
import '../Employer_NewWorkPlaceEmployees/Employer_NewWorkPlaceEmployeeChild.dart';
import 'Employer_NewWorkPlacePayoutsChild.dart';

class Employer_NewWorkPlacePayoutsManageStatus extends StatefulWidget {

   Employer_NewWorkPlacePayoutsManageStatus({Key? key, required this.payOutObj,this.liveModelObj}) : super(key: key);
   final CommonPayoutList payOutObj;
   final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  State<Employer_NewWorkPlacePayoutsManageStatus> createState() => _Employer_NewWorkPlacePayoutsManageStatus();
}

class _Employer_NewWorkPlacePayoutsManageStatus extends State<Employer_NewWorkPlacePayoutsManageStatus> {
  bool apihitstatus=false;
  Map<dynamic,dynamic> finaldata={};
  List<Map<String, dynamic>> Data = [];


  List<CustomerPayoutSummary>? customerPayoutSummary;
  List<CustomerPayoutDetails>? customerPayoutDetails;

  List<String> dropDownList = <String>["Approved","Hold"];
  String selectedValue="";

  String monthYearName="";
//
  String amount="";
  String totalWorkers="";
  String payoutDate="";
  String status="";
  String monthShortName="";
  
  String paymentTitle="Payout";

  String selectedYear="",selectedMonth="",selectedEmpCode="";


  String displayMessage="";

  String paymentStatus="",daysLeft="";
  String salaryNotGeneratedMessage="Click on the pay button to generate payouts for your employees";
  String confirmPayoutDate="";

  //lightGreenColor

  @override
  void initState() {
    // TODO: implement initState


   /* String obj=getDecryptedData("TwSfB0qkyX6uitON+2OEp8ylSvXi3HbeHFeJ1SQfa1LdVU/yt00JGqSR16X7SS+F");
    print("show the empcode $obj");
*/
    serviceBodyRequestPayOutDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Colors.white,
      appBar: CJAppBar(getEmployer_PayoutTitle,
          appBarBlock: AppBarBlock(appBarAction: () {
            print("show the action type");
            Navigator.pop(context);
          })),
      body: getResponsiveUI(),
    ));
  }

  Responsive getResponsiveUI() {
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



  MainfunctionUi()
  {
   return  apihitstatus==true?
      Container(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [

            Container(child:Padding(padding: EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 0),child: Text("Employees' Payout Status",textAlign: TextAlign.center,style: TextStyle(color: darkBlueColor,fontSize: large_FontSize,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight),),) ,),

            paymentStatus=="Not Generated" ? Container(decoration: BoxDecoration(color: lightGreyColor,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),child:Padding(padding: EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 15),child: Text(salaryNotGeneratedMessage,textAlign: TextAlign.center,),) ,):Container(),


            displayMessage=="" ? Container() :Container(decoration: BoxDecoration(color: lightGreenColor,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),child:Padding(padding: EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 15),child: Text(displayMessage,textAlign: TextAlign.center,),) ,),

            SizedBox(height: 20,),

            Container(
              //height: 130,
              decoration: getContainerBoxDecoration,
              child: Column(children: [

                Container(child: Padding(padding: EdgeInsets.only(left: 55,top: 10,right: 10),child:Row(
                  children: [
                    Text(
                      'Payout Amount: ',
                      style: TextStyle(
                        color: darkBlueColor,
                        fontWeight: bold_FontWeight,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),

                    amount=="Not Generated"?Container():Image.asset(rupees_Gray_Icon,
                      color: darkBlueColor,
                      height: Employer_SmallIcon_W_H,
                      width: Employer_SmallIcon_W_H,
                    ),
                    SizedBox(
                      width: 2,
                    ),

                    Expanded(child:  Text(
                      amount,
                      style: TextStyle(fontFamily: robotoFontFamily,
                        color: amount=="Not Generated"?redColor:darkBlueColor,
                        fontWeight: amount=="Not Generated"?normal_FontWeight:bold_FontWeight,
                      ),
                    ))
                  ],
                )),),


                Row(crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(children: [

                        Padding(padding: EdgeInsets.only(bottom: 25),child:Column(
                          children: [
                            InkWell(onTap: ()
                            {


                            },child: Padding(
                              padding: EdgeInsets.only(
                                  top: 20, left: 10, right: 5),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  Employer_Icon_BlueCalendarIcon,
                                  color: textKeyColor,
                                  width: 35,
                                  height: 35,
                                ),
                              ),
                            ),),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              monthShortName,
                              style: TextStyle(fontFamily: robotoFontFamily,
                                color: textKeyColor,
                                fontWeight: bold_FontWeight,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        )),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

/*
                              Container(width: 180,child: Padding(padding: EdgeInsets.only(top: 10),child:Row(
                                children: [
                                  Text(
                                    'Payout Amount: ',
                                    style: TextStyle(
                                      color: darkBlueColor,
                                      fontWeight: bold_FontWeight,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),

                                  amount=="Not Generated"?Container():Image.asset(rupees_Gray_Icon,
                                    color: darkBlueColor,
                                    height: Employer_SmallIcon_W_H,
                                    width: Employer_SmallIcon_W_H,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),

                                  Expanded(child:  Text(
                                    amount,
                                    style: TextStyle(fontFamily: robotoFontFamily,
                                      color: amount=="Not Generated"?redColor:darkBlueColor,
                                      fontWeight: amount=="Not Generated"?normal_FontWeight:bold_FontWeight,
                                    ),
                                  ))
                                ],
                              )),),
*/


                              Padding(padding: EdgeInsets.only(top: 1),child:Row(
                                children: [
                                  Text(
                                      'Employees:',
                                      style: textStyle_GREY()),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    totalWorkers,
                                    style: textStyle_BLACK(),
                                  ),
                                ],
                              )),
                              Padding(padding: EdgeInsets.only(top: 5),child:Row(
                                children: [

                                  //payoutList('Payout Date:', "$payoutDate${getDayNumberSuffix(int.parse(payoutDate))}" + "' "+monthShortName),
                                  payoutList('Payout Date:', confirmPayoutDate),


                                ],
                              )),

                              /*---------2-3-2023 start(discuss yatendar sir)----------*/

                              //paymentStatus=="Not Generated"?Padding(padding: EdgeInsets.only(top: 5),child:payoutListOrange('Days Left:', daysLeft)):Container(),

                              Padding(padding: EdgeInsets.only(top: 5),child:payoutListOrange('Days Left:', daysLeft)),

                              /*---------2-3-2023 end(discuss yatendar sir)----------*/


                              paymentStatus=="Not Generated"? Container():Padding(padding: EdgeInsets.only(top: 5),child:Row(
                                children: [
                                  Text(
                                    "Status",
                                    style: textStyle_GREY(),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),

                                  Text(status,
                                    style: TextStyle(
                                        color: status == "Pending" ? Colors.red:
                                        status == "Completed"? Colors.green:
                                        status == "Auto" ? Colors.green:
                                        status == "Low Balance" ? Colors.red:Colors.orange),
                                  )
                                ],
                              )),
                              SizedBox(height: 10,)

                            ])

                      ],),
                    ),

                    Padding(padding: EdgeInsets.only(right: 10,bottom: 25),child: InkWell(onTap: ()
                    {

                      if(status == "Completed" || status=="Auto")
                      {

                      }
                      else if(paymentStatus=="Not Generated")
                      {
                        //right here the code


                        if(daysLeft==""||daysLeft=="0"||daysLeft==null)
                        {
                          showDialog(context: context, builder: (_)=>SalaryPayDialogBox());

                        }
                        else
                        {
                          //Payout can only be run after month's completions
                          showDialog(context: context, builder: (_)=>errorPayDialogBox());

                        }

                      }
                      else
                      {
                        viewInvoiceService_BodyRequest();
                      }

                    },child:Align(
                      alignment: Alignment.center,
                      child: status == "Completed" ? Container()
                          : status == "Auto" ? Image.asset(AutoPay_Icon,height: 60,width: 60,)
                          : paymentStatus == "Not Generated"? Container(
                          height: 50,
                          width: 60,
                          decoration: BoxDecoration(
                              color:daysLeft==""||daysLeft=="0"||daysLeft==null?darkBlueColor:darkGreyColor,
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Center(
                              child: Text("PAY",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: medium_FontSize,fontWeight: semiBold_FontWeight,
                                    fontFamily: robotoFontFamily
                                ),
                              )
                          )
                      ): Image.asset(verifiedAttendence_Blue_Icon),
                    ) ,),)

                  ],
                )
              ],),
            ),

            SizedBox(
              height: 20,
            ),
            Expanded(flex: 1,child: ListView.builder(
              itemCount: customerPayoutDetails!.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index)
              {

                CustomerPayoutDetails obj=customerPayoutDetails![index];
                String name=obj.empName!;
                String payDays=obj.paiddays.toString()!;
                String amount=obj.amount.toString()!;
                String imageURL=obj.photopath.toString();

//
                selectedValue=obj.approvalstatus.toString();

                return Column(children: [
                  Container(
                    //height: 130,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: lightGreyColor, //color of border
                        width: 2, //width of border
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                EdgeInsets.only(top: 0, left: 5, right: 5),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: (imageURL== "" || imageURL==null)
                                      ? CircleAvatar(
                                    child: Text(getProfileEmpName(name)),radius: 22,
                                  ) : CircleAvatar(
                                    backgroundImage: NetworkImage(imageURL),
                                    backgroundColor: whiteColor,
                                    radius: 25,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  SizedBox(height: 5,),
                                  Container(width: 150,child: Row(
                                    children: [
                                      Image.asset(
                                        Employer_Icon_ProfileGrey,color: addDarkGrayColor,),
                                      SizedBox(
                                        width: 5,
                                      ),

                                      Expanded(child: Text(
                                        name,
                                        style: TextStyle(
                                          color: darkBlueColor,
                                          fontSize: medium_FontSize,
                                          fontFamily: robotoFontFamily,
                                          fontWeight: semiBold_FontWeight,
                                        ),
                                      ))
                                    ],
                                  ),),
                                  SizedBox(height: 8,),

                                  Row(
                                    children: [
                                      Image.asset(
                                        calendar_Black_Icon,
                                        color: addDarkGrayColor,
                                        width: Employer_SmallIcon_W_H,
                                        height: Employer_SmallIcon_W_H,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Pay Days:",
                                        style: textStyle_GREY(),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                          payDays,
                                          style: textStyle_BLACK()),
                                    ],
                                  ),
                                  SizedBox(height: 8,),

                                  Row(
                                    children: [
                                      Image.asset(
                                        rupees_Gray_Icon,color: addDarkGrayColor,
                                        width: Employer_SmallIcon_W_H,
                                        height: Employer_SmallIcon_W_H,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Amount:",
                                        style:  textStyle_GREY(),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Image.asset(
                                        rupees_Gray_Icon,
                                        width: Employer_SmallIcon_W_H,
                                        height: Employer_SmallIcon_W_H,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                          amount,
                                          style: textStyle_BLACK()),
                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(flex: 2,
                          child: Container(
                            child: Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField2(
                                  scrollbarRadius: const Radius.circular(40),
                                  scrollbarThickness: 2,
                                  scrollbarAlwaysShow: true,
                                  dropdownWidth: 100,
                                  buttonPadding: const EdgeInsets.only(
                                      left: 2, right: 2/*,top: 5,bottom: 5*/),
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.white))),
                                  value: selectedValue,
                                  onChanged: (value)
                                  {

                                    print("show the selected index $index");

                                    CustomerPayoutDetails obj=customerPayoutDetails![index];
                                    selectedYear=obj.mpryear;
                                    selectedMonth=obj.mprmonth;
                                    selectedEmpCode=obj.mobile+getCJHUBKey+obj.empCode+getCJHUBKey+obj.dateofbirth;


                                    setState(()
                                    {
                                      print('${index} and ${value}');
                                    });

                                    if(value=="Approved")
                                    {
                                      //use for the approved
                                      if(status=="Completed")
                                        {

                                        }else
                                          {
                                            serviceBodyRequest_EmployerSalaryStatus(kEmployer_Approved_Value);

                                          }
                                    }
                                    else if(value=="Hold")
                                    {
                                      //use for the hold
                                      serviceBodyRequest_EmployerSalaryStatus(kEmployer_Hold_Value);
                                    }
                                    else
                                    {

                                    }


                                  },
                                  items: dropDownList.map((value)
                                  {
                                    // CustomerPayoutDetails obj=customerPayoutDetails![index];
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          Text(value,
                                              style: TextStyle(fontSize: 12,
                                                color: value ==
                                                    "Approved"
                                                    ? Colors.green
                                                    : Colors.red,
                                              )),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),padding: EdgeInsets.only(bottom: 15),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ]);
              },
            ))
            ,
          ],
        ),
      ):Container();
  }


//
  Dialog SalaryPayDialogBox()
  {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child:
      approveAttendanceDialogBoxChild(),
    );
  }

  approveAttendanceDialogBoxChild() =>
      Container(
          width: 300,
          height: 140,
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(children: [
            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 25, top: 8),
              child: Container(
                width: 200,
                height: 50,
                child: Text(
                  "Do you want to pay now?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black,fontFamily: robotoFontFamily,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Center(
                child: Padding(padding: EdgeInsets.only(left: 70,top: 12),child: Row(children: [
                  InkWell(
                    onTap: ()
                    {
                      Navigator.of(context).pop();
                      serviceBodyRequestForSalaryPay();
                    },
                    child: Text(
                      "YES",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: Colors.blueAccent),
                    ),
                  ),
                  SizedBox(width: 60,),

                  InkWell(
                    onTap: ()
                    {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "NO",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: Colors.blueAccent),
                    ),
                  )
                ],),))
          ]));

  Dialog errorPayDialogBox()
  {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child:
      errorDialogBoxChild(),
    );
  }

  errorDialogBoxChild() =>
      Container(
          width: 300,
          height: 100,
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(children: [
            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 25, top: 8),
              child: Container(
                width: 200,
                height: 50,
                child: Text(
                  "Payout can only be run after month's completions",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black,fontFamily: robotoFontFamily,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            /*Center(
                child: Padding(padding: EdgeInsets.only(left: 70,top: 12),child: Row(children: [
                  InkWell(
                    onTap: ()
                    {
                      Navigator.of(context).pop();
                      serviceBodyRequestForSalaryPay();
                    },
                    child: Text(
                      "YES",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: Colors.blueAccent),
                    ),
                  ),
                  SizedBox(width: 60,),

                  InkWell(
                    onTap: ()
                    {
                      Navigator.of(context).pop();
                      //serViceBodyRequestForApproveEmployerAttendance(kEmployer_Attendance_ApproveBulkAttendance_ActionValue,attendanceToApprove);
                    },
                    child: Text(
                      "NO",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: Colors.blueAccent),
                    ),
                  )
                ],),))*/
          ]));
//
  serviceBodyRequestPayOutDetails()
  {
    // print("ServiceBodyRequest");

    var accountID=widget.liveModelObj?.tpAccountId;
   // var empcode=int.parse(widget.liveModelObj?.employerId);
    var empcode="";


    var month=int.parse(widget.payOutObj.mprmonth);
    var year=int.parse(widget.payOutObj.mpryear);

    var mapObject=getEmployer_EmployeePayOutDetails_RequestBody(accountID,month,year,empcode);
    serviceRequest_PayOutDetails(mapObject);
  }

  serviceRequest_PayOutDetails(Map mapObj)
  {


    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequestFor_EmployerDashboard(mapObj,JG_ApiMethod_EmployerPayOutDetails,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          print("print Details model response $modelResponse");
          EasyLoading.dismiss();

          EmployerPayOutDetailsModelClass employerPayOutDetailsModelClass = modelResponse as EmployerPayOutDetailsModelClass;

          setState(() {
            apihitstatus=true;
            customerPayoutSummary=employerPayOutDetailsModelClass.customerPayoutSummary;
            customerPayoutDetails=employerPayOutDetailsModelClass.customerPayoutDetails;


            if(customerPayoutSummary!.length>0) {
              CustomerPayoutSummary obj = customerPayoutSummary![0];

              amount = obj.amount!.toString();
              totalWorkers = obj.totalemployees!.toString();
              payoutDate = obj.payoutdate!.toString();
              status = obj.status!.toString();
              monthShortName = obj.monthName!.toString();
              paymentStatus=obj.paymentStatus;
              daysLeft=obj.daysLeft;
              confirmPayoutDate=obj.payoutdate1!.toString();


              print("show the daysLeft $daysLeft");
              print("show the amount $amount");


              if(paymentStatus=="Not Generated" && amount=="0")
              {
                amount=paymentStatus;
              }
              else
              {
                amount=obj.amount!.toString();
              }


              /*--------22-2-2023 start--------*/
              if(monthShortName =="" || monthShortName==null)
              {

              }else
              {
                var obj=monthShortName.split("-");
                monthShortName=obj[0];
              }//
              /*--------22-2-2023 end--------*/
              monthYearName=obj.monthFullName.toString()+" '"+obj.mpryear.toString();


              String displayPayoutDate=payoutDate+getDayNumberSuffix(int.parse(obj.payoutdate));

              if(status=="Completed")
                {
                  displayMessage="Salaries for $totalWorkers employee were processed successfully and transferred to their bank account on ${displayPayoutDate+"' "+obj.monthFullName.toString()}";
                  dropDownList=["Approved"];
                }
              else if(status=="Auto")
                {
                  displayMessage="Sit back and relax! Your employees will receive auto-payment of their salaries on $displayPayoutDate";
                }
              else
                {
                  displayMessage="";
                }

              //String autoPayText="Sit back and relax! Your employees will receive auto-payment of their salaries on ${"payout date"}";
              //String completedText="Salaries for ${"x"} employee were processed successfully and transferred to their bank account on ${"date"}";


            }

              });

        }, employerFailureBlock:<T>(commonResponse,failure)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass payOutDetailsModelClass=commonResponse as CJTalentCommonModelClass;
          if (payOutDetailsModelClass?.message==null || payOutDetailsModelClass?.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context, payOutDetailsModelClass!.message!);
          }

        }
        )
    );
  }

  viewInvoiceService_BodyRequest()
  {
   
    EasyLoading.show(status: Message.get_LoaderMessage);

    var accountID=widget.liveModelObj?.tpAccountId;
    var mapObj = get_ViewInvoice_RequestBody(accountID, amount, int.parse(totalWorkers));
    serviceRequest(mapObj);

  }

  serviceRequest(Map mapObj)
  {
    print("sucess till now 1");


    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_Employer_ViewInvoice,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        async {
          print("print Details model response $modelResponse");
          EasyLoading.dismiss();

          //PaymentInvoiceModelClass invoice_data = modelResponse as PaymentInvoiceModelClass;
          //await Employer_NewPaymentInvoice().showBottomSheetMethod(context,invoice_data,paymentTitle,getEmployerAddPayout,widget.liveModelObj!);

          /*--------9-1-2023 start(discuss with anju maam)--------*/
          TalentNavigation().pushTo(context, Employer_NewPaymentPlan(liveModelObj: widget.liveModelObj,));
          /*--------9-1-2023 end--------*/

        }, employerFailureBlock:<T>(commonResponse,failure)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass paymentModelClass=commonResponse as CJTalentCommonModelClass;
          if (paymentModelClass?.message==null || paymentModelClass?.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context, paymentModelClass!.message!);
          }

        }
        )
    );
  }


  serviceBodyRequest_EmployerSalaryStatus(String actionType)
  {
    var accountID=widget.liveModelObj?.tpAccountId;
    var mapObj = getEmployer_PayoutSalaryHoldandApproved_RequestBody(accountID,selectedEmpCode,selectedYear,selectedMonth,actionType);
    serviceRequest_EmployerSalaryStatus(mapObj);
//
  }

  serviceRequest_EmployerSalaryStatus(Map mapObj)
  {
    print("salary status: $mapObj");


    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_Employer_EmployerUpdateSalaryStatus,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        async {
          print("print Details model response $modelResponse");
          EasyLoading.dismiss();

          CJTalentCommonModelClass paymentModelClass=commonResponse as CJTalentCommonModelClass;
          if (paymentModelClass?.message==null || paymentModelClass?.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context, paymentModelClass!.message!);
          }

          serviceBodyRequestPayOutDetails();

        }, employerFailureBlock:<T>(commonResponse,failure)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass paymentModelClass=commonResponse as CJTalentCommonModelClass;
          if (paymentModelClass?.message==null || paymentModelClass?.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context, paymentModelClass!.message!);
          }

        }
        )
    );
  }


  /*---------------24-2-2023 start--------------*/

  serviceBodyRequestForSalaryPay()
  {

    var month=widget.payOutObj.mprmonth;
    var year=widget.payOutObj.mpryear;

    var yearMonthMapObj=Map();
    yearMonthMapObj["Year"]=year;
    yearMonthMapObj["Month"]=month;


    var createdby = widget.liveModelObj?.employerId;
    var customerAccountId = widget.liveModelObj!.tpAccountId;
    var mapObj = saveEmployer_PayoytPaySalary_RequestBody("-9999", yearMonthMapObj, createdby, customerAccountId,kEmployer_Payout_PaySalary_ActionValue);
    print("Map Data Passed $mapObj");
    serviceRequestForSalaryPay(mapObj);

  }

  serviceRequestForSalaryPay(Map mapObj)
  {
    print("show the request2");
    print("show the request object $mapObj");


    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj, JG_ApiMethod_Employer_Payout_PaySalary,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonModelObj=commonResponse as CJTalentCommonModelClass;
          if (commonModelObj?.message==null || commonModelObj?.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context, commonModelObj!.message!);
          }

          serviceBodyRequestPayOutDetails();


        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {

          EasyLoading.dismiss();

          CJTalentCommonModelClass commonModelObj=commonResponse as CJTalentCommonModelClass;
          if (commonModelObj?.message==null || commonModelObj?.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context, commonModelObj!.message!);
          }
        }));

  }

  /*---------------24-2-2023 end--------------*/


}

