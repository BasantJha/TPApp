


import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/Services/AESAlgo/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../../../Constant/ConstantIcon.dart';
import '../../../../../../../Constant/Constants.dart';
import '../../../../../../../Constant/Responsive.dart';
import '../../../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../../../../Services/Messages/Message.dart';
import '../../../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../../../../TankhaPayModule/Controller/ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfileChild.dart';
import '../../../../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../Employer_NewWorkPlaceEmployeeChild.dart';
import 'Employer_NewWorkPlaceEmployeeSetupSalary.dart';


class Employer_NewWorkPlaceEmployeeLinkSent extends StatefulWidget
{
  const Employer_NewWorkPlaceEmployeeLinkSent({super.key,  this.mapObj, this.liveModelObj});
  final Map? mapObj;
  final Employer_VerifyMobileNoModelClass? liveModelObj;


  @override
  State<Employer_NewWorkPlaceEmployeeLinkSent> createState() => _Employer_NewWorkPlaceEmployeeLinkSent();
}

class _Employer_NewWorkPlaceEmployeeLinkSent extends State<Employer_NewWorkPlaceEmployeeLinkSent>

{

  // ignore: non_constant_identifier_names
  String phoneImage_Icon = "assets/cjhubappicons/call.png";

  String empName="", empTpCode="", empMobileNo="", profileURL="",deputedDate="";
  var status = 1;

  var updateProfileStatus="";
  var aadharVerificationStatus="N";
  var accountVerificationStatus="N";
  var panVerificationStatus="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    empName=widget.mapObj!["name"];
    empTpCode=widget.mapObj!["tpcode"];
    empMobileNo=widget.mapObj!["mob_no"];
    profileURL=widget.mapObj!["Image"];
    deputedDate=widget.mapObj!["deputedDate"];


     updateProfileStatus=widget.mapObj!["employeeProfileUpdateStatus"];
     aadharVerificationStatus=widget.mapObj!["aadharVerficationStatus"];
     accountVerificationStatus=widget.mapObj!["accountVerificationStatus"];

     panVerificationStatus=widget.mapObj!["panVerficationStatus"];//16-3-2023


    /* print("show the updateProfileStatus $updateProfileStatus");
    print("show the aadharVerificationStatus $aadharVerificationStatus");
    print("show the accountVerificationStatus $accountVerificationStatus");*/

/* ---------use only testing purpose 28-1-2023 start -------------*/
   /* updateProfileStatus="12";
    aadharVerificationStatus="Y";
    accountVerificationStatus="Y";*/
/*
    ---------use only testing purpose 28-1-2023 end -------------
*/
//

    /*-------------16-3-2023 START---------------*/

    if(aadharVerificationStatus==TankhaPay_Aadhaar_NR && panVerificationStatus=="Y")
      {
        aadharVerificationStatus="Y";
      }
    else if(aadharVerificationStatus=="Y")
      {
        aadharVerificationStatus="Y";
      }
     else
       {
         aadharVerificationStatus="N";
       }
    /*-------------16-3-2023 END---------------*/


    if(updateProfileStatus != "" && aadharVerificationStatus=="Y" && accountVerificationStatus=="Y")
      {
        status=2;
      }

    print("show the jsid ${getDecryptedData("j/EEIEhBFdZQ8iz/Gf4PDQmQHunEoClMSoQ6wTshfcQ=")}");
  }

  @override
  Widget build(BuildContext context)
  {

    return SafeArea(
        child: Scaffold(
            //backgroundColor:Color(0xffeef5fd),
            appBar: CJAppBarBgBlue("", appBarBlock: AppBarBlock(appBarAction: ()
            {
              print("show 1the action 1type");
              Navigator.pop(context);
            })),
            body: getResponsiveUI()
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

  CirclesBackground MainfunctionUI()
  {
    return CirclesBackground(
      circles:getCircleInfoForHome,
      child: SafeArea(child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [

                 ListTile(
                  title: Text(
                    "Employee",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: largeExcel_FontSize,fontFamily: robotoFontFamily,fontWeight: bold_FontWeight,color: whiteColor),
                  ),
                ),

                Expanded(flex: 1,child: SingleChildScrollView(child: Column(children: [

                  Container(height: 10,color: whiteColor,),

                  Container(
                    color: whiteColor,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [

                        getTheEmployeeInfoCard(empName,empTpCode,empMobileNo,profileURL),
                        Center(
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                                child: Column(
                                  children: [
                                    Text("Following Steps must be completed\nfor successful payout",textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: robotoFontFamily,
                                          fontSize: medium_FontSize,
                                          color: lightBlueColor,
                                          fontWeight: semiBold_FontWeight
                                      ),
                                    ),

                                  ],
                                )
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(color: Color(0xffeef5fd),
                    // width: MediaQuery.of(context).size.width,
                    // height:MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 30),
                        child: Column(
                          children: [
                            statusBox(heading: "App Link Sent",message: "Resend Link",fieldNo: 1),
                            SizedBox(height: 20),
                            statusBox(heading: "Onboarding",message: "Pending From Employee",fieldNo: 2),
                            SizedBox(
                              height: 35,
                            ),
                            Visibility(
                                visible: !(status>=2),
                                child: Center(
                                    child: Padding(
                                        padding: EdgeInsets.only(right: 10,left: 10,bottom: 25),
                                        child: Column(
                                          children: [
                                            Text("You will be able to setup salary\nwhen onboarding will be completed",textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: robotoFontFamily,
                                                  fontSize: medium_FontSize,
                                                  color: sixHunGreyColor,
                                                  fontWeight: semiBold_FontWeight
                                              ),
                                            ),

                                          ],
                                        )
                                    )
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: status >=2 ? Color(0xff33b8fd):darkGreyColor,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffeef5fd)),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: status >=2 ? darkBlueColor:lightGreyColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)),
                                    ),
                                    onPressed: ()
                                    {
                                      if(status==2)
                                        {
                                          TalentNavigation().pushTo(context, Employer_NewWorkPlaceEmployeeSetupSalary(mapObj: widget.mapObj,liveModelObj: widget.liveModelObj,));
                                        }
                                    },
                                    child: Text(
                                      "Setup Salary",
                                      style: TextStyle(
                                        color: status>=2 ? whiteColor:Color(0xffcdcdcd),
                                        fontSize: medium_FontSize,
                                        fontWeight:semiBold_FontWeight,
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      )
                  )
                ],),)),

              ],
            ),
          ))),

    );
  }


  statusBox({heading,message,fieldNo})
  {
    var color;
    if(fieldNo ==1)
    {
      if(status>=1)
      {
        color = Color(0xff1fc08e);
      }
      else
      {
        color = lightBlueColor;
      }
    }
    else
    {
      if(status>=2)
      {
        color = Color(0xff1fc08e);
      }
      else
      {
        color = lightBlueColor;
      }
    }
    return Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15,right: 10),
            child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(
                        color: color,
                        width: 2
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                padding: EdgeInsets.only(left: 30,right: 8),
                child: fieldNo == 1 ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(heading,
                          style: TextStyle(
                              color: blackColor,
                              fontWeight: semiBold_FontWeight,
                              fontSize: medium_FontSize,
                              fontFamily: robotoFontFamily
                          ),
                        ),
                        InkWell(onTap: ()
                          {
                            createBodyWebApi_ResendLink();

                          },child: Text("Resend Link",
                          style: TextStyle(
                              color: blackColor,
                              fontWeight: normal_FontWeight,
                              fontSize: medium_FontSize,
                              fontFamily: robotoFontFamily
                          ),
                        ),),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("App Link has been sent on\n$deputedDate",
                          style: TextStyle(
                              color: darkGreyColor,
                              fontFamily: robotoFontFamily,
                              fontSize: medium_FontSize,
                              fontWeight: normal_FontWeight
                          ),
                        ),

                      ],
                    )
                  ],
                ):
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(heading,
                          style: TextStyle(
                              color: blackColor,
                              fontWeight: semiBold_FontWeight,
                              fontSize: medium_FontSize,
                              fontFamily: robotoFontFamily
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Update profile",
                              style: TextStyle(
                                  color: darkGreyColor,
                                  fontFamily: robotoFontFamily
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.done,color: updateProfileStatus == ""? darkGreyColor:greenColor,size: 20,)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("KYC Details",
                              style: TextStyle(
                                  color: darkGreyColor,
                                  fontFamily: robotoFontFamily
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.done,color: aadharVerificationStatus == "Y"? greenColor:darkGreyColor,size: 20,)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Bank Details",
                              style: TextStyle(
                                  color: darkGreyColor,
                                  fontFamily: robotoFontFamily
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.done,color: accountVerificationStatus == "Y"? greenColor:darkGreyColor,size: 20,)
                          ],
                        ),
                      ],
                    ),
                    status == 2? Container(
                      width: 100,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.topRight,
                      child: Text("Completed",
                        style: TextStyle(
                            color: greenColor,
                            fontFamily: robotoFontFamily
                        ),
                      ),
                    ):
                    Container(
                        width: 100,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Pending From",
                              style: TextStyle(
                                  color: Color(0xfffe4244),
                                  fontWeight: normal_FontWeight,
                                  fontSize: medium_FontSize,
                                  fontFamily: robotoFontFamily
                              ),
                            ),
                            Text("Employee",
                              style: TextStyle(
                                  color: Color(0xfffe4244),
                                  fontWeight: normal_FontWeight,
                                  fontSize: medium_FontSize,
                                  fontFamily: robotoFontFamily
                              ),
                            ),
                          ],
                        )
                    )
                  ],
                )
            ),
          ),
          Positioned(
              bottom: 15,
              top: 15,
              child: fieldNo == 1 ?
              Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: status >=1?
                      Color(0xff1fc08e): whiteColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: color
                      )
                  ),
                  child: status >= 1?
                  Icon(Icons.done,color: whiteColor,):
                  Text("1",
                      style: TextStyle(
                          fontFamily: robotoFontFamily,
                          fontWeight: normal_FontWeight,
                          fontSize: medium_FontSize,
                          color: lightBlueColor
                      )
                  )
              ):
              Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: status >= 2?
                      Color(0xff1fc08e): whiteColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: color
                      )
                  ),
                  child: status >= 2?
                  Icon(Icons.done,color: whiteColor,):
                  Text("2",
                      style: TextStyle(
                          fontFamily: robotoFontFamily,
                          fontWeight: normal_FontWeight,
                          fontSize: medium_FontSize,
                          color: lightBlueColor
                      )
                  )
              )
          )
        ]);
  }
  createBodyWebApi_ResendLink()
  {
    var jsid=widget.mapObj!["jsId"];
    var mapObject = getEmployer_LinkSend_RequestBody(jsid);
    serviceRequest_ResendLink(mapObject);
  }

 serviceRequest_ResendLink(Map mapObj) {
    // print("show 1the request2");
    print("show the request object leave $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj, JG_ApiMethod_Employer_ResendLink,
        cjEmployerResponseBlock: CJEmployerResponseBlock(
            employerSuccessBlock: <T>(commonResponse, modelResponse) {

              EasyLoading.dismiss();

              CJTalentCommonModelClass commonModelClass=commonResponse as CJTalentCommonModelClass;
              CJSnackBar(context, commonModelClass.message!);


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
}

