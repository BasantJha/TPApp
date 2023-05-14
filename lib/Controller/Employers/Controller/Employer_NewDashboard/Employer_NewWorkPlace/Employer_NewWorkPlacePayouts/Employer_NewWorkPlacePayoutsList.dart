import 'package:contractjobs/Controller/Employers/Controller/Employer_KYC/Employer_JoinerAggrementChild.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../../Constant/ConstantIcon.dart';
import '../../../../../../Constant/Constants.dart';
import '../../../../../../Constant/Responsive.dart';
import '../../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../../Services/Messages/Message.dart';
import '../../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../EmployerModelClasses/EmployerPayoutModelClass/EmployerPayOutModelClass.dart';
import '../../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../../Employer_NewPayment/Employer_NewPaymentPlan.dart';
import '../../Employer_NewProfile/Employer_NewProfile.dart';
import '../Employer_NewWorkPlaceEmployees/Employer_NewWorkPlaceEmployeeChild.dart';
import 'Employer_NewWorkPlacePayoutsChild.dart';
import 'Employer_NewWorkPlacePayoutsManageStatus.dart';
import 'Employer_PayoutFilter.dart';
//

class Employer_NewWorkPlacePayoutsList extends StatefulWidget {

  const Employer_NewWorkPlacePayoutsList({Key? key, this.liveModelObj}) : super(key: key);
  final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  State<Employer_NewWorkPlacePayoutsList> createState() => _Employer_NewWorkPlacePayoutsList();
}

class _Employer_NewWorkPlacePayoutsList extends State<Employer_NewWorkPlacePayoutsList> {

  List<CommonPayoutList>? commonPayoutList;

  List<CommonPayoutList>? serverResponsePayoutList;

  String monthYearName="";
  bool apihitstatus=false;


  int radioButton_StatusValue=0;

  String displayMessage="Attendance needs to be approved for the payout amount to be reflected";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    serviceBodyRequestPayOutSummary();

 }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Colors.white,
    /*  appBar: CJAppBar(getEmployer_PayoutTitle, appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show the action type");
            Navigator.pop(context);

          })),*/
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
    return SingleChildScrollView(
      child: apihitstatus == true ? Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            /*----------22-2-2023 start---------*/
           /* Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      monthYearName,
                      style: TextStyle(fontFamily: robotoFontFamily,
                        color: textFieldHeadingColor,
                        fontWeight: bold_FontWeight,
                      ),
                    ),
                  ),
                ),

                InkWell(onTap: ()
                  {
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context)
                        {

                          return Container(child:Employer_PayoutFilter(selectedDatePresetRadioButton: radioButton_StatusValue,onChanged: (value)
                          {
                            print("filter the records according to the date  value :: $value");
                            Navigator.of(context).pop();
                            setState(() {
                              //dateFilter=listDatePresets[value];
                              radioButton_StatusValue=value;
                            });



                            commonPayoutList=[];
                            int i=0;
                            for(i=0;i<serverResponsePayoutList!.length;i++)
                              {
                                CommonPayoutList obj=serverResponsePayoutList![i];
                                if(value==filterStatus_All)
                                {
                                  //show the all objects
                                  commonPayoutList?.add(obj);
                                }

                               else if(value==filterStatus_Auto)
                                {
                                  if(obj.status==filterTitle_Auto)
                                  {
                                    commonPayoutList?.add(obj);
                                  }
                                }

                               else if(value==filterStatus_Completed)
                                {
                                  if(obj.status==filterTitle_Completed)
                                  {
                                    commonPayoutList?.add(obj);
                                  }
                                }

                              else  if(value==filterStatus_PartiallyCompleted)
                                {
                                  if(obj.status==filterTitle_PartiallyCompleted)
                                  {
                                    commonPayoutList?.add(obj);
                                  }
                                }

                               else if(value==filterStatus_Pending)
                                {
                                  if(obj.status==filterTitle_Pending)
                                  {
                                    commonPayoutList?.add(obj);
                                  }
                                }

                              else  if(value==filterStatus_PartiallyPending)
                                {
                                  if(obj.status==filterTitle_PartiallyPending)
                                  {
                                    commonPayoutList?.add(obj);
                                  }
                                }
                              else
                                {

                                }

                              }

                            setState(() {
                              commonPayoutList=commonPayoutList;
                            });

                          },));

                        });

                  },child:Container(width: 65,height: 40,child: Row(
                  children: [
                    Text(
                      'Filter',
                      style: TextStyle(
                        color: darkGreyColor,
                        fontWeight: bold_FontWeight,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Image.asset(filter_Grey_Icon)

                  ],
                ),) ,),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'All Payouts',
                  style: TextStyle(
                    color: darkGreyColor,
                    fontWeight: bold_FontWeight,
                  ), //
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                    onTap: () {},
                    child: Image.asset(dropdown_arrow_Icon)),
              ],
            ),*/

            Container(child:Padding(padding: EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 10),child: Text("Monthly Payout Summary",textAlign: TextAlign.center,style: TextStyle(color: darkBlueColor,fontSize: large_FontSize,fontFamily: robotoFontFamily,fontWeight: semiBold_FontWeight),),) ,),


            displayMessage=="" ? Container() :Container(decoration: BoxDecoration(color: lightGreyColor,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),child:Padding(padding: EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 10),child: Text(displayMessage,textAlign: TextAlign.center,),) ,),

            /*----------22-2-2023 end---------*/

            SizedBox(
              height: 20,
            ),
            commonPayoutList!.isNotEmpty ?
            ListView.builder(
                itemCount: commonPayoutList!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index)
                {
                  CommonPayoutList obj=commonPayoutList![index];

                  print("show the CommonPayoutList $index");
                  String totalEmployee=obj.totalemployees!.toString();
                  String payoutDate=obj.payoutdate!.toString();
                  String status=obj.status!.toString();


                  String monthShortName=obj.monthName!.toString();

                  /*--------22-2-2023 start--------*/
                  if(monthShortName =="" || monthShortName==null)
                    {

                    }else
                      {
                        var obj=monthShortName.split("-");
                        monthShortName=obj[0];
                      }
                  /*--------22-2-2023 end--------*/

                  String leftDays=obj.daysLeft!.toString();
                  String paymentStatus=obj.paymentStatus!.toString();
                  String approvedAttendance=obj.approvedattendance!.toString();

                  String amount=obj.amount!.toString();

                  if(paymentStatus=="Not Generated" && amount=="0")
                    {
                      amount=paymentStatus;
                    }
                  else
                    {
                     // if(amount)
                      amount=obj.amount!.toString();
                    }


                  String payoutSettingStatus=obj.payoutSettings!.toString();
                  String confirmPayoutDate=obj.payoutdate1!.toString();


//////
                  return Column(
                    children: [

                      Container(
                        //height: 130,//not use
                        decoration: getContainerBoxDecoration,
                        child: Column(children: [
                          Container(child: Padding(padding: EdgeInsets.only(left: 50,top: 10,right: 10),child:Row(
                            children: [
                              Text(
                                'Payout Amount:',
                                style: TextStyle(fontFamily: robotoFontFamily,
                                  color: darkBlueColor,
                                  fontWeight: bold_FontWeight,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              amount=="Not Generated"?Container():Image.asset(rupees_Gray_Icon,
                                color: darkBlueColor,
                                height: 10,
                                width: 10,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Expanded(child: Text(
                                amount,maxLines: 2,
                                style: TextStyle(fontFamily: robotoFontFamily,
                                  color: amount=="Not Generated"?redColor:darkBlueColor,
                                  fontWeight: amount=="Not Generated"?normal_FontWeight:bold_FontWeight,
                                ),
                              )),
                            ],
                          )),),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [

                                      Container(width: 45,child: Padding(padding: EdgeInsets.only(bottom: 35,),child: Column(
                                        children: [
                                          InkWell(onTap: ()
                                          {

                                            //calendar
                                            CommonPayoutList OBJ=commonPayoutList![index] as CommonPayoutList;
                                            pushTo(context, Employer_NewWorkPlacePayoutsManageStatus(payOutObj:OBJ,liveModelObj: widget.liveModelObj,));

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
                                      )),),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.spaceAround,//not use
                                        children: [

/*
                                        Container(width: 200,child: Padding(padding: EdgeInsets.only(top: 10),child:Row(
                                          children: [
                                            Text(
                                              'Payout Amount:',
                                              style: TextStyle(fontFamily: robotoFontFamily,
                                                color: darkBlueColor,
                                                fontWeight: bold_FontWeight,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            amount=="Not Generated"?Container():Image.asset(rupees_Gray_Icon,
                                              color: darkBlueColor,
                                              height: 10,
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Expanded(child: Text(
                                              amount,maxLines: 2,
                                              style: TextStyle(fontFamily: robotoFontFamily,
                                                color: amount=="Not Generated"?redColor:darkBlueColor,
                                                fontWeight: amount=="Not Generated"?normal_FontWeight:bold_FontWeight,
                                              ),
                                            )),
                                          ],
                                        )),),
*/

                                          Padding(padding: EdgeInsets.only(top: 5),child:payoutList('Staff Strength:', totalEmployee+" "+"Employees")),

                                          payoutSettingStatus=="Auto"?Container():Padding(padding: EdgeInsets.only(top: 5),child:payoutList('Attendance Approval:', approvedAttendance+" "+"Employees")),
                                          // payoutList('Payout Date:', "$payoutDate${getDayNumberSuffix(int.parse(payoutDate))}" + "' "+monthShortName),
//
                                          Padding(padding: EdgeInsets.only(top: 5),child:payoutList('Payout Date:', confirmPayoutDate)),

                                          /*---------2-3-2023 start(discuss yatendar sir)----------*/
                                          // paymentStatus=="Not Generated"?Padding(padding: EdgeInsets.only(top: 5),child:payoutListOrange('Days to Payout:', leftDays)):Container(),
                                          Padding(padding: EdgeInsets.only(top: 5),child:payoutListOrange('Days to Payout:', leftDays)),

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
                                              /*Container(
                                              height: 25,
                                              padding: EdgeInsets.only(
                                                  left: 3, right: 3),
                                              child: ElevatedButton(
                                                onPressed: (){},
                                                child: Text(status,
                                                  style: TextStyle(
                                                      color: status == "Pending" ? Colors.red:
                                                      status == "Completed"? Colors.green:
                                                      status == "Auto" ? Colors.green:
                                                      status == "Low Balance" ? Colors.red:Colors.orange),
                                                ),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                    MaterialStateProperty
                                                        .all(Colors.white),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                        RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(18.0),
                                                            side: status == "Pending" ? BorderSide(color: Colors.red):
                                                            status == "Completed"? BorderSide(color: Colors.green):
                                                            status == "Auto" ? BorderSide(color: Colors.green):
                                                            BorderSide(color: Colors.orange)))),
                                              ),
                                            ),*/
                                            ],
                                          )),

                                          SizedBox(height: 10,),

                                        ],
                                      ),

                                    ],
                                  )),

                              Padding(padding: EdgeInsets.only(bottom: 35,),child: Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: ()
                                  {

                                    if(status == "Completed" || status == "Auto" || paymentStatus=="Not Generated")
                                    {
                                      CommonPayoutList OBJ=commonPayoutList![index] as CommonPayoutList;
                                      pushTo(context, Employer_NewWorkPlacePayoutsManageStatus(payOutObj:OBJ,liveModelObj: widget.liveModelObj,));

                                    }
                                    else
                                    {
                                      TalentNavigation().pushTo(context, Employer_NewPaymentPlan(liveModelObj: widget.liveModelObj,));
                                    }

                                  },
                                  child: status == "Completed" ? Image.asset(attendance_green_round_Icon,height: 60,width: 60,)
                                      : status == "Auto" ? Image.asset(AutoPay_Icon,height: 60,width: 60,):Image.asset(verifiedAttendence_Blue_Icon),
                                ),
                              ) ,),
                            ],
                          )
                        ],),//
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                }):dataNotFoundText,
          ],
        ),
      ):Container()
    );
  }

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
      serviceBodyRequestPayOutSummary();
    });
  }

//

  serviceBodyRequestPayOutSummary()
  {
    var payoutType="All";
    var mapObject=getEmployer_EmployeePayOut_RequestBody(widget.liveModelObj?.tpAccountId,payoutType);
    serviceRequest_PayOutSummary(mapObject);
  }

  serviceRequest_PayOutSummary(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequestFor_EmployerDashboard(mapObj,JG_ApiMethod_EmployerPayOutList,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          print("print model response $modelResponse");

          EasyLoading.dismiss();

          EmployerPayOutModelClass modelObject=modelResponse as EmployerPayOutModelClass;
          CJTalentCommonModelClass commonModelClass=commonResponse as CJTalentCommonModelClass;

          setState(() {
            apihitstatus=true;
            commonPayoutList=modelObject.commonPayoutList;
            serverResponsePayoutList=modelObject.commonPayoutList;
            if(commonPayoutList!.length>0)
              {
                CommonPayoutList obj=commonPayoutList![0] as CommonPayoutList;
                monthYearName=obj.monthFullName.toString()+" '"+obj.mpryear.toString();
              }

            displayMessage=commonModelClass?.displayMessage;
            if(displayMessage=="" || displayMessage==null)
            {
              displayMessage="Attendance needs to be approved for the payout amount to be reflected";
            }
            print("show the displayMessage $displayMessage");

          });

        }, employerFailureBlock:<T>(commonResponse,failure)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass payOutModelClass=commonResponse as CJTalentCommonModelClass;
          if (payOutModelClass?.message==null || payOutModelClass?.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context, payOutModelClass!.message!);
          }

        }
        )
    );
  }

}
