
import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/CJHubCustomView/palatte_Textstyle.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../EmployerDashboard/Employer_LeftDrawer/Employer_LeftDrawer.dart';
import '../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../../Employer_TabBarController/Employer_TabBarController.dart';
import 'EmployerpayOutSettingModelClass.dart';
import 'EmployerGetLeaveTemplateModelClass.dart';
import 'SaveEmployerLeaveTemplateModelClass.dart';



class Employer_PayoutSetting extends StatefulWidget
{
  const Employer_PayoutSetting({super.key, this.liveModelObj});

  final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  State<StatefulWidget> createState() => _Employer_PayoutSetting();

}


class _Employer_PayoutSetting extends State<Employer_PayoutSetting>
{


  var radioValue = 0;
  bool visibleLeaveSetting = true;
  List<String> leavelist = [];

  var selectedLeaveSetting;
  var payOutType = "N";
  var leaveDays;
  bool ApiHitStatus = true;

  final _form = GlobalKey<FormState>();

  bool _Sunvalue = false;
  bool _Monvalue = false;
  bool _Tuevalue = false;
  bool _Wedvalue = false;
  bool _Thurvalue = false;
  bool _Frivalue = false;
  bool _Satvalue = false;

  final txtstyle = TextStyle(color: lightBlueColor);

  var weekCjeckBoxSide = BorderSide(color: Colors.grey, width: 0.8);
  var weekCheckColor = Colors.green;
  var weekActiveColor = Colors.grey[200];
  var weekCheckDensity = VisualDensity(horizontal: -4, vertical: -4);

  var screenSize;

  List<String> monthList = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec"];
  late  var selectedDate = "Select Payout Date";

  TextEditingController selectPayoutDateController = TextEditingController();

  var daySelected;



  @override
  void initState()
  {
    createServiceRequestBodyGetNoLeave();
    createServiceRequestBodyGetLeaveTemplate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    screenSize = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            drawer: EmployerNavigation_Drawer(
              liveModelObj: widget.liveModelObj,
            ),
            appBar: CJAppBarBgBlue("", appBarBlock: AppBarBlock(appBarAction: ()
            {
              print("show 1the action 1type");
              Navigator.pop(context);
            })),

            backgroundColor: oneHunGreyColor,
            body: respnsiveUI()
        )
    );
  }


  Responsive respnsiveUI()
  {
    return Responsive(
        mobile: MainfunctionUI(),
        tablet: MainfunctionUI(),
        desktop: Center(
          child: Container(
            width: webResponsive_TD_Width,
            child: MainfunctionUI(),
          ),
        )

    );
  }


  var dropdowntextStyle = TextStyle(
  color: getFourHundredGreyColor(),
  fontFamily: robotoFontFamily,
  fontSize: medium_FontSize,
  fontWeight: normal_FontWeight
  );

  CirclesBackground MainfunctionUI()
  {
    return CirclesBackground(
        circles:getCircleInfoForHome,
        /*child: SingleChildScrollView(*/
        child:  ApiHitStatus == true?
           Padding(
          padding: EdgeInsets.only(top: 1),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 17),
                Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 1),
                      child: Text("Payout Setting",
                        style: TextStyle(fontSize: largeExcel_FontSize,fontFamily: robotoFontFamily,fontWeight: bold_FontWeight,color: whiteColor)),
                    )
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(left:40,right: 40,top: 30),
                            child: Text("Following Steps must be completed for successful payout",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: blackColor,
                                  fontSize: medium_FontSize,
                                  fontFamily: robotoFontFamily,
                                  fontWeight: bold_FontWeight
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: darkBlueColor),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 33),
                                    child: Text("Set Payout Date",
                                      style: TextStyle(
                                          color: blackColor,
                                          fontSize: medium_FontSize,
                                          fontFamily: robotoFontFamily,
                                          fontWeight: normal_FontWeight
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),


                                  Padding(
                                    padding: EdgeInsets.only(left: 33,right: 30),
                                    child: Row(children: [Container(width: 150,
                                      child: TextFormField(
                                          validator: (value)
                                          {
                                            if(value == "" || value == null)
                                              return "Please Select Payout Date";
                                            else null;
                                          },
                                          controller: selectPayoutDateController,
                                          onChanged: (val) {
                                            setState(() {
                                              // mobile = val!;
                                            });
                                          },
                                          // enabled: false,
                                          keyboardType: TextInputType.none,
                                          onTap: (){
                                            showCalendarModalBottomSheet(context);
                                          },
                                          showCursor: false,
                                          style: TextStyle(fontFamily: robotoFontFamily,
                                              color: blackColor, fontSize: medium_FontSize),
                                          decoration: InputDecoration(

                                              suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,color: getFourHundredGreyColor()),
                                              hintText: "Payout Date",
                                              hintStyle: TextStyle(fontFamily: robotoFontFamily,
                                                  color: getFourHundredGreyColor(), fontSize: medium_FontSize),
                                              focusedBorder:OutlineInputBorder(
                                                borderSide: const BorderSide(color: darkGreyColor),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: darkGreyColor,
                                                ),
                                                borderRadius: BorderRadius.circular(0.0),
                                              ))
                                      ),
                                    ),Text(" every month")],),),





//
                                /*  Padding(
                                    padding: EdgeInsets.only(left: 27,right: 20),
                                    child: Container(
                                        child: TextFormField(
                                            validator: (value)
                                            {
                                              if(value == "" || value == null)
                                                return "Please Select Payout Date";
                                              else null;
                                            },
                                            controller: selectPayoutDateController,
                                            onChanged: (val) {
                                              setState(() {
                                                // mobile = val!;
                                              });
                                            },
                                            // enabled: false,
                                            keyboardType: TextInputType.none,
                                            onTap: (){
                                              showCalendarModalBottomSheet(context);
                                            },
                                            showCursor: false,
                                            style: TextStyle(fontFamily: robotoFontFamily,
                                                color: blackColor, fontSize: medium_FontSize),
                                            decoration: InputDecoration(

                                                suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,color: getFourHundredGreyColor()),
                                                hintText: "Select Payout Date",
                                                hintStyle: TextStyle(fontFamily: robotoFontFamily,
                                                    color: getFourHundredGreyColor(), fontSize: medium_FontSize),
                                                focusedBorder:OutlineInputBorder(
                                                  borderSide: const BorderSide(color: darkGreyColor),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: darkGreyColor,
                                                  ),
                                                  borderRadius: BorderRadius.circular(0.0),
                                                ))
                                        ),
                                      ),

                                  ),*/

                                  SizedBox(height: 15,),

                                  ListTile(
                                      horizontalTitleGap: 0.0,
                                      title: Text('I want to auto-pay salaries on the set payout date each month(attendance approval not required).',
                                        style: TextStyle(
                                            fontSize: medium_FontSize,
                                            fontWeight: normal_FontWeight,
                                            fontFamily: robotoFontFamily,
                                            color: getFourHundredGreyColor()
                                        ),
                                      ),
                                      leading: Radio(
                                        value: 0,
                                        groupValue: radioValue,
                                        onChanged: (val){
                                          setState(() {
                                            radioValue = 0;
                                            payOutType = "N";
                                            //visibleLeaveSetting = true;
                                          });
                                        },
                                      )
                                  ),
                                  ListTile(
                                      horizontalTitleGap: 0.0,
                                      title: Text('I want to approve salary disbursals each month before the payout date(attendance approval required).',
                                        style: TextStyle(
                                            fontSize: medium_FontSize,
                                            fontWeight: normal_FontWeight,
                                            fontFamily: robotoFontFamily,
                                            color: getFourHundredGreyColor()
                                        ),
                                      ),
                                      leading: Radio(
                                        value: 1,
                                        groupValue: radioValue,
                                        onChanged: (val){
                                          setState(() {
                                            radioValue = 1;
                                            payOutType = "Y";
                                            //visibleLeaveSetting = false;
                                          });
                                        },
                                      )
                                  ),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        /*------14-3-2023 start discuss with yatendra sir-----*/
                      /*  Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              // height: 100,
                              //width: 300,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: darkBlueColor),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 27,top: 10),
                                    child: Text("Leave Settings",
                                      style: TextStyle(
                                          color: blackColor,
                                          fontSize: medium_FontSize,
                                          fontFamily: robotoFontFamily,
                                          fontWeight: normal_FontWeight
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 27,top: 1),
                                    child: Text("Please choose the number of paid leaves you want to give to your employees each month",
                                      style: TextStyle(
                                          color: darkGreyColor,
                                          fontSize: small_FontSize,
                                          fontFamily: robotoFontFamily,
                                          fontWeight: normal_FontWeight
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                                    child: Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      //padding: EdgeInsets.only(bottom: 5),
                                      child: DropdownButtonFormField2(
                                        isExpanded: true,
                                       // alignment: Alignment.center,
                                        dropdownWidth: kIsWeb==true?webResponsive_TD_Width-40:MediaQuery.of(context).size.width-75,
                                        dropdownMaxHeight: 200,
                                        scrollbarThickness: 6,
                                        scrollbarAlwaysShow: true,
                                        //dropdownPadding: EdgeInsets.symmetric(vertical: -10),
                                        offset: Offset(-15, -15),
                                        decoration: decorationimage("Set Monthly Leaves"),
                                        icon: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: getFourHundredGreyColor()
                                        ),
                                        value: leaveDays,
                                        style: TextStyle(fontFamily: robotoFontFamily,
                                            color: blackColor, fontSize: medium_FontSize),
                                        items: leavelist
                                            ?.map((item) => DropdownMenuItem<String>(
                                          value: item.toString(),
                                          child: Text(
                                            item,
                                            style: TextStyle(fontFamily: robotoFontFamily,
                                                color: blackColor, fontSize: medium_FontSize),
                                          ),
                                        ))
                                            .toList(),
                                        onChanged: (value) {
                                          leaveDays = value;
                                          FocusScope.of(context).requestFocus(FocusNode());

                                        },
                                        onSaved: (value) {
                                          leaveDays = value!;
                                        },
                                        validator: LeaveSettingValidator,
                                      ),
                                    )
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )

                                ],
                              ),
                            )
                        ),*/

                        /*------14-3-2023 end discuss with yatendra sir-----*/

                        SizedBox(
                          height: 20,
                        ),
                        Padding(padding: EdgeInsets.only(left: 20,right: 20),child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: darkBlueColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            minimumSize: Size(screenSize.width * 0.9, 47),
                          ),
                          onPressed: (){
                            createServiceRequestForSaveTemplate();
                          },
                          child: Text("Save",
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: large_FontSize,
                              fontWeight: bold_FontWeight,
                            ),
                          ),
                        ),),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ):Container()
      // )
    );
  }


  String? LeaveSettingValidator(value)
  {
    if (value == null || value.isEmpty) {
      return 'Please Select Leave Template';
    }
    return null;
  }

  InputDecoration decorationimage(String hintimage) {
    return InputDecoration(
      hintText: hintimage,
      hintStyle:  TextStyle(
        color: getFourHundredGreyColor(),
    fontFamily: robotoFontFamily,
    fontSize: medium_FontSize,
    fontWeight: normal_FontWeight
    ),
      // prefixIcon: Iconimg(Icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    );
  }

  selectDate()
  async {
    final DateTime? picked = await showDatePicker(
        initialDate: DateTime.now(),
        context: context,
        firstDate: DateTime(DateTime
            .now()
            .year, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        //selectedDate = "${picked.day}/${picked.month}/${picked.year}";
        selectedDate = "${picked.day} ${monthList[picked.month-1]}'${picked.year}";
        print("Selected date $selectedDate");
      });
    }
  }


  showCalendarModalBottomSheet(BuildContext context)
  {

    return showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Text("Edit Payout date",
                    style: TextStyle(
                        fontSize: large_FontSize,
                        fontFamily: robotoFontFamily,
                        color: Color(0xff3b3c3e)
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 280,
                  child: CalendarDatePicker(
                    currentDate: DateTime.now(),
                    initialDate: DateTime(DateTime.now().year,DateTime.now().month,1),
                    firstDate:DateTime(DateTime.now().year,DateTime.now().month,1),
                    lastDate: DateTime(DateTime.now().year,DateTime.now().month+1,0),
                    onDateChanged: (DateTime value) {
                      print("Date Selected $value");
                      setState(() {
                        daySelected = value.day;
                        selectPayoutDateController.text = "${value.day}";
                      });
                    },
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkBlueColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 47),
                    ),
                    onPressed: (){
                      setState(() {
                        if(daySelected == null)
                        {
                          selectPayoutDateController.text = "${DateTime.now().day}";
                          Navigator.pop(context);
                        }
                        else
                        {
                          selectPayoutDateController.text = "${daySelected}";
                          Navigator.pop(context);
                        }

                      });
                    },
                    child: Text("CONFIRM")
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )
        );

      },
    );
  }


  createServiceRequestBodyGetNoLeave()
  {
    var map = {};
    ServiceRequestGetNoLeave(map);
  }

  ServiceRequestGetNoLeave(Map mapObj)
  {
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj, JG_ApiMethod_Employer_PayoutSetting_NOOfLeave,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          var modelClass = modelResponse as EmployerpayOutSettingModelClass;
          //print("Success Block $modelClass");
          //print("API List Data Length ${modelClass.data.length}");
          var leaveData = modelClass.leaveDetails;
           for(var i =0;i<leaveData!.length;i++)
             {
               print("data from API $i ${leaveData[i].leaveid}");
               leavelist.add(leaveData[i].leaveid.toString());
             }
           setState(() {
            //selectedLeaveSetting = leavelist[0];
            ApiHitStatus = true;

          });
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

  createServiceRequestForSaveTemplate()
  {
    if(_form.currentState!.validate())
      {
        var customeraccountid = widget.liveModelObj?.tpAccountId;

        /*------14-3-2023 start discuss with yatendra sir-----*/

       // var leaveDayToPass = leaveDays;
        var leaveDayToPass = "0";

        /*------14-3-2023 end discuss with yatendra sir-----*/

        var payoutType = payOutType;
        var payoutDate = selectPayoutDateController.text;

        print("show the leaveDayToPass $leaveDayToPass");
        print("show the payoutType $payoutType");
        print("show the payoutDate $payoutDate");

        var mapObj = getEmployer_SaveLeaveTemplate(customeraccountid,leaveDayToPass,payoutType,payoutDate);
        ServiceRequestForSaveTemplate(mapObj);
      }
    //String customerAccountId,String leaveDays,String payoutType, String payoutDate
  }

  ServiceRequestForSaveTemplate(Map mapObj)
  {
    print("Map Body $mapObj");
    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj, JG_ApiMethod_Employer_PayoutSetting_SaveLeaveTemplate,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          var modelClass = modelResponse as SaveEmployerLeaveTemplateModelClass;
          CJTalentCommonModelClass commonModelClass = commonResponse as CJTalentCommonModelClass;
          CJSnackBar(context, commonModelClass.message!);

          /*--------27-2-223 start----------*/
          widget.liveModelObj?.payoutFrequencyDt=int.parse(selectPayoutDateController.text);
          /*--------27-2-223 end----------*/

          TalentNavigation().pushTo(context, Employer_TabBarController(liveModelObj: widget.liveModelObj,));

          //print("Success Block $modelClass");
          //print("API List Data Length ${modelClass.data.length}");
//

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

  createServiceRequestBodyGetLeaveTemplate()
  {
    var customeraccountid = widget.liveModelObj?.tpAccountId;

    var mapObj = getEmployer_payoutLeaveTemplate(customeraccountid);
    ServiceRequestGetLeaveTemplate(mapObj);
  }

  ServiceRequestGetLeaveTemplate(Map mapObj)
  {
    EasyLoading.show(status: Message.get_LoaderMessage);

    print("Map Body $mapObj");
    CJEmployerServiceRequest().postDataServiceRequest(mapObj, JG_ApiMethod_Employer_PayoutGet_LeaveTemplate,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          print("Success Block Of get Leave Template");
          var modelClass = modelResponse as EmployerGetLeaveTemplateModelClass;
          print("ModelClass get Leave Template $modelClass");
          setState(() {
            selectPayoutDateController.text = modelClass.payoutDate!;
            leaveDays = modelClass.leaveDays;
            payOutType= modelClass.payoutType!;

            print("show the leaveDays $leaveDays");
            if(payOutType == "N")
            {
              radioValue = 0;
            }
            else
            {
              radioValue = 1;
            }
          });

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




}






