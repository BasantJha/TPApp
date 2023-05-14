
import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Controller/Employers/Controller/Employer_KYC/Employer_JoinerAggrementChild.dart';
import 'package:contractjobs/Controller/TankhaPayModule/Controller/TankhaPayBenefits/TankaPayBenefits/TankhaPayBenefitsChild.dart';
import 'package:contractjobs/CustomView/AlertView/Alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../../Constant/ConstantIcon.dart';
import '../../../../../../Constant/Constants.dart';
import '../../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceKey.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../../../TankhaPayModelClasses/TankhaPayFAQModelClass/TankhaPayFAQModelClass.dart';
import '../../../TankhaPayModelClasses/TankhaPaySupportModelClass/TankhaPaySupportGetPendingQueryModelClass.dart';
import '../../../TankhaPayModelClasses/TankhaPaySupportModelClass/TankhaPaySupportSubjectList.dart';
import 'TankhaPayCreateTickets.dart';
import 'TankhaPaySupportFilter.dart';
import 'TankhaPayTrailQuery.dart';


class TankhaPayHelpSupport extends StatefulWidget {
  const TankhaPayHelpSupport({Key? key, this.completedEmpCode, this.empName}) : super(key: key);
  final String? completedEmpCode;
  final String? empName;


  @override
  State<TankhaPayHelpSupport> createState() => _TankhaPayHelpSupport();
}

class _TankhaPayHelpSupport extends State<TankhaPayHelpSupport> {


  List<Queries>? pendingQueryList=[];

  String selectedFilterValue="";
  int radioButton_StatusValue=0;
  
  List supportFilterList=["All","Open","Close"];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   createBodyWebApi_getQueryList(kCJHub_Support_QueryType_AllValue);
  }
  @override
  Widget build(BuildContext context)
  {
    return (Scaffold(
      backgroundColor: Colors.white,
      appBar: CJAppBarBgBlue("", appBarBlock: AppBarBlock(appBarAction: ()
          {
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

  CirclesBackground  MainfunctionUi()
  {
    return CirclesBackground(
      circles:getCircleInfoForHome,
      child: getTheCustomColumn(),);
  }

  Container getTheCustomColumn() {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15), child: Column(
        children: [

          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(getEmployee_HelpandSupportTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: whiteColor,
                  fontFamily: robotoFontFamily,
                  fontSize: 20.0),
            ),),

            SizedBox(height: 30,),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      "${widget.empName}",
                      style: TextStyle(
                          fontSize: large_FontSize,
                          fontFamily: robotoFontFamily,
                          fontWeight: bold_FontWeight,
                          color: blackColor
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Container(
              // height: Height-530,
              height:80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: darkGreyColor,),
                color: whiteColor,
              ),

              child: Padding(
                padding: const EdgeInsets.only(left: 7,right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("We are here to help you. If you are\nfacing any issues or have queries,\nplease raise a ticket, and someone\nwill get back to you shortly."),
                    Image(image: AssetImage(technical_support_Icon,),width: 50,),
                  ],
                ),
              ),
            ),
          ),

            SizedBox(height: 10,),

            Container(height: 70,
              // padding: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Expanded(flex: 1,child: Container(child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: ()
                      {
                        tapToCreateQuery();
                      },
                      label: Text(
                        "Create New Ticket",
                        style: TextStyle(
                            fontWeight: bold_FontWeight,
                            color: lightBlueColor,
                            fontSize: large_FontSize,
                            fontFamily: robotoFontFamily),
                      ),

                      icon: Image.asset(plus_Icon,
                        height: 16,width: 16,),
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 1.0,
                            color: darkGreyColor,
                          ),
                          backgroundColor: lightGreyColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          )),
                    ),
                  ),))
                ],
              ),
            ),
            
            SizedBox(height:20),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Row(
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
                  InkWell(onTap: ()
                    {
                      showModalBottomSheet<void>(
                          context: context,
                            builder: (BuildContext context)
                          {

                            return Container(child:TankhaPaySupportFilter(selectedStatusRadioButton: radioButton_StatusValue,onChanged: (value)
                            {
                              print("filter the records according to the status  value :: $value");
                              Navigator.of(context).pop();
                              //
                              setState(() {
                                selectedFilterValue=supportFilterList[value];
                                radioButton_StatusValue=value;

                              });

                              print("show the selected value $selectedFilterValue");
                              createBodyWebApi_getQueryList(selectedFilterValue);
                            },
                            ));

                          });
                    },child: Image.asset(filter_Icon,height: 20,width: 20,color: darkGreyColor,),)

                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

          SizedBox(height: 15,),
          Expanded(flex: 1,child: pendingQueryList!.isNotEmpty ?  ListView.builder(
              itemCount: pendingQueryList!.length,
              shrinkWrap: true,
              //physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index)
              {

                Queries queryObj=pendingQueryList![index];

                var queryId=queryObj.queryMasterId.toString();
                if(queryId=="" ||queryId==null)
                  {
                    queryId="";
                  }
                var queryStatus=queryObj.status;
                if(queryStatus=="" ||queryStatus==null)
                {
                  queryStatus="";
                }
                var queryCreatedDate=queryObj.createdon;
                if(queryCreatedDate=="" ||queryCreatedDate==null)
                {
                  queryCreatedDate="";
                }
                return GestureDetector(onTap:()
                {
                  Queries queryObj=pendingQueryList![index];
                  var queryId=queryObj.queryMasterId.toString();
                  var createdOn=queryObj.createdon.toString();
                  var status=queryObj.status.toString();

                  print("show the selected index $index");
                  TalentNavigation().pushTo(context, TankhaPayTrailQuery(completedEmpCode:widget.completedEmpCode,queryId:queryId ,createdOn: createdOn,status: status,empName: widget.empName!,));

                },child: Column(
                  children: [
                    Container(
                      height: 70,
                      decoration: getListviewContainerBoxDecoration,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 15, left: 10, right: 5),
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: darkGreyColor,
                                            child:CircleAvatar(
                                                backgroundColor: darkGreyColor,
                                                radius: 12,
                                                child: Image(image: AssetImage(health_support_Icon))
                                            ),
                                          ),
                                          //
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center
                                    ,
                                    children: [
                                      TicketList('Ticket ID:', queryId),
                                      TicketList('Created Date:', queryCreatedDate),
                                      Row(
                                        children: [
                                          Text(
                                            'Status: ',
                                            style: TextStyle(
                                              fontSize: small_FontSize,
                                              color: blackColor,
                                              fontWeight: bold_FontWeight,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(queryStatus,
                                            style: TextStyle(
                                                fontWeight: normal_FontWeight,
                                                fontFamily: robotoFontFamily,
                                                fontSize: small_FontSize,
                                                color: queryStatus ==
                                                    "Close"
                                                    ? Colors.red
                                                    : Colors.green),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Align(
                              alignment: Alignment.center,
                              child:
                              Image.asset(
                                  rightArrow_Icon,height: 40,
                                  width: 60,color: blackColor)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),);
              }):Container())

        ]));
  }
//
  createBodyWebApi_getQueryList(String filterStatus)
  {
    var mapObject=getCJHub_Support_GETQueryList_RequestBody(widget.completedEmpCode!,filterStatus);
    serviceRequest_getQueryList(mapObject);
  }
  serviceRequest_getQueryList(Map mapObj)
  {
    print("show 1the request12");
    print("show the// request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.get_HRConnect_PendingQuery,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          TankhaPaySupportGetPendingQueryModelClass pendingQueryObj=success as TankhaPaySupportGetPendingQueryModelClass;
          if(pendingQueryObj?.statusCode==true)
          {
            setState(() {
              pendingQueryList=pendingQueryObj.queries;

            });
          }

        }, talentFailureBlock:<T>(failure)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= failure as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }
        }, talentHandleExceptionBlock: <T>(handleException)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass commonObject= handleException as CJTalentCommonModelClass;
          if (commonObject.message==null || commonObject.message=="")
          {
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context,commonObject!.message as String);
          }

        }));
  }

  tapToCreateQuery()
  {

    Navigator.push(context, MaterialPageRoute(builder: (_)=>

        Responsive(
            mobile: TankhaPayCreateTickets(completedEmpCode: widget.completedEmpCode,),
            tablet: Center(
              child: Container(
                width: webResponsive_TD_Width,
                child: TankhaPayCreateTickets(completedEmpCode: widget.completedEmpCode,),
              ),
            ),

            desktop: Center(
              child: Container(
                width: webResponsive_TD_Width,
                child: TankhaPayCreateTickets(completedEmpCode: widget.completedEmpCode,),
              ),
            )
        )
    )
    ).then((value)
    {
      createBodyWebApi_getQueryList(kCJHub_Support_QueryType_AllValue);

    });
  }

}

Row TicketList(label,Value)
{
  return Row(
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: small_FontSize,
          color: blackColor,
          fontWeight: bold_FontWeight,
        ),
      ),
      SizedBox(
        width: 2,
      ),
      Text(
        Value,
        style: TextStyle(
            fontSize: small_FontSize,
            color: blackColor,
            fontWeight: normal_FontWeight,
            fontFamily: robotoFontFamily
        ),
      ),
    ],
  );
}


var getListviewContainerBoxDecoration=BoxDecoration(
    color: whiteColor,
    border: Border.all(color: darkGreyColor, width: 0.2)
);


