import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../Constant/Constants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../CustomView/ButtonDecoration/CustomButtonAction.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceBody.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceKey.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceRequest.dart';
import '../../../../Services/CJEmployerService/CJEmployerServiceURL.dart';
import '../../../../Services/Messages/Message.dart';
import '../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../Employer_KYCModelClass/Employer_AggreementModelClass.dart';
import '../Employer_NewSignUp/Employer_NewSignUpModelClass/Employer_VerifyMobileNoModelClass.dart';
import '../Employer_TabBarController/Employer_TabBarController.dart';
import 'Employer_JoinerAggrementChild.dart';
import 'Employer_JoinerHome.dart';


class Employer_JoinerAggrement extends StatefulWidget
{
  const Employer_JoinerAggrement({super.key, this.liveModelObj});
  final Employer_VerifyMobileNoModelClass? liveModelObj;

  @override
  State<Employer_JoinerAggrement> createState() => _Employer_JoinerAggrement();
}

class _Employer_JoinerAggrement extends State<Employer_JoinerAggrement> {

  List<CommonAggreementList> employerAggreementList=[];
  String headingTitle="",headingDesc="";

  String deviceType="",IPAddress="";
  bool btnStatus=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();




    getServiceRequest_AggreementList();

    getBasicInfo();

  }

  getBasicInfo()
  {

    Method.getIPAddress().then((value) => {
      IPAddress=value,

    });
    Method.getDeviceId().then((value) => {
      deviceType=value,

    });
  }
  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
        child: Scaffold(
            appBar:CJAppBar(getEmployer_EmployerAggreementTitle, appBarBlock: AppBarBlock(appBarAction: ()
            {
              print("show the action type");
              Navigator.pop(context);
            })),
            body:getResponsiveUI() ,
          bottomNavigationBar: Padding(padding: EdgeInsets.only(left: elevatedButtonLeftRightPadding,right:elevatedButtonLeftRightPadding ),
            child: elevatedButtonBottomBar(),) ,
        ));
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

  SingleChildScrollView MainfunctionUi() {

    return SingleChildScrollView(
        child: Container(color: whiteColor, child: Column(
          children: [
            /*Text(
              headingTitle,
              style: const TextStyle(
                fontSize: 16,
                color: darkBlueColor,
                fontWeight: FontWeight.bold,
              ),
            ),*/

//
            Container(child:employerAggreementList.isNotEmpty ? ListView.builder(
                shrinkWrap: true,
                itemCount: employerAggreementList!.length,
                itemBuilder: (context, index)
                {
                  print("show the load index value $index");

                  var descObj;
                  descObj=employerAggreementList![index].employerAggreementDesc;

                  print("show the load data $descObj");

                  return  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.8,
                          child: Checkbox(
                            checkColor: Colors.green,
                            activeColor: Colors.white,
                            side: BorderSide(color: Colors.grey, width: 0.2),
                            value: employerAggreementList[index].status,
                            onChanged: (val)
                            {
                              setState(()
                              {
                                employerAggreementList[index].status = val;
                              });

                              int count = 0;
                              for (int i = 0; i < employerAggreementList.length; i++)
                              {
                                if (employerAggreementList[i].status == false)
                                {
                                  break;
                                } else {
                                  count = count + 1;
                                }
                              }
                              if (count == employerAggreementList.length)
                              {
                                setState(()
                                {
                                  btnStatus=true;
                                });
                              }
                              else
                                {
                                  setState(()
                                  {
                                    btnStatus=false;
                                  });
                                }

                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Text(descObj, style: TextStyle(fontSize: 16),
                            )),
                      ],
                    ),
                  );;
                }):Container() ,),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 25.0, vertical: 10),
              child: headingDesc=="" ? Text(
                headingDesc,
                style: const TextStyle(
                    color: blackColor, fontSize: 16),
              ):Html(data:headingDesc.toString()),
            ),
          ],
        ),));
  }
  elevatedButtonBottomBar()
  {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 15),
          SizedBox(
            height: 50,
            width: 160,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                // elevation: 0,
                // shadowColor: whiteColor,
                  backgroundColor: lightBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
              ),
              onPressed: btnStatus ? btnAction:null,
              child: Text(
                "I Accept",
                style: TextStyle(
                    fontWeight: bold_FontWeight,
                    color: whiteColor,
                    fontSize: ElevatedButtonTextFontWeight,
                    fontFamily: robotoFontFamily),
              ),
            ),

          ),
          // ),
        ],
      ),
    );
  }

  btnAction()
  {
    print("show the continue action 111");

    int count = 0;
    for (int i = 0; i < employerAggreementList.length; i++)
    {
      if (employerAggreementList[i].status == false)
      {
        /*String msg = "Kindly accept all Terms & Conditions";
        showSnackBar(context, msg, Colors.red);*/
        break;
      } else {
        count = count + 1;
      }
    }
    if (count == employerAggreementList.length)
    {
      createBodyWebApi_SaveEmployerAggreement();
    }
  }


  getServiceRequest_AggreementList()
  {
    print("show 1the request2");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().getDataServiceRequest(JG_ApiMethod_EmployerAggreement,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          Employer_AggreementModelClass employer_aggreementModelClass=modelResponse as Employer_AggreementModelClass;
          print("show the data obj ${employer_aggreementModelClass.commonAggreementList}");

          if(employer_aggreementModelClass.commonAggreementList!.length>0)
          {
            setState(() {

               List<CommonAggreementList>tempObj=[];
               for(var i in employer_aggreementModelClass.commonAggreementList!)
                 {
                  var objType=i as CommonAggreementList;
                  if(objType.type=="Heading")
                  {

                    headingTitle=objType.type!;
                    headingDesc=objType.employerAggreementDesc!;
                  }
                  else
                  {
                    //terms_conditons
                    tempObj.add(objType);
                  }
                 }
               employerAggreementList=tempObj;
            });
          }
          else
          {
            CJSnackBar(context, (commonResponse as CJTalentCommonModelClass).message!);

          }
        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          CJTalentCommonModelClass modelClass=modelResponse as CJTalentCommonModelClass;
          if (modelClass?.message==null || modelClass?.message=="")
          {
            CJSnackBar(context, "server error!");
          }else {
            CJSnackBar(context, modelClass!.message!);
          }
        }));
  }

  createBodyWebApi_SaveEmployerAggreement()
  {
    var mapObject=getEmployer_SaveEmployerAggreement_RequestBody(widget.liveModelObj!.employerMobile,deviceType,IPAddress);
    serviceRequestForEmployer(mapObject);
  }
////
  /*-----------employee login web api start--------------*/
  serviceRequestForEmployer(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequestFor_EmployerSignUp(mapObj,JG_ApiMethod_EmployerCommonRegistration,kEmployer_FLAG_EA,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          CJTalentCommonModelClass modelObject=commonResponse as CJTalentCommonModelClass;
          if(modelObject.statusCode==true)
          {
            print("show the success aggreement");

            CJSnackBar(context, modelObject.message!);

            //Navigator.pop(context,[Employer_JoinerHome]);
            TalentNavigation().pushTo(context, Employer_JoinerHome(liveModelObj: widget.liveModelObj));

//
          }

        }, employerFailureBlock:<T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          print("show the false aggreement");

          CJTalentCommonModelClass modelObject=commonResponse as CJTalentCommonModelClass;
          print("show the verify message ${modelObject.message}");
          if (modelObject?.message==null || modelObject?.message=="")
          {
            CJSnackBar(context, "server  error!");
          }else
          {
            CJSnackBar(context, modelObject!.message!);
          }
        }));
  }
}
//

