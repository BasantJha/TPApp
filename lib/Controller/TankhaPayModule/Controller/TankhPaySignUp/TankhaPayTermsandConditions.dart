import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Controller/Talents/ModelClasses/CJTalentCommonModelClass.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/CJSnackBar/CJSnackBar.dart';
import 'package:contractjobs/Services/AESAlgo/encrypt.dart';
import 'package:contractjobs/Services/CJEmployerService/CJEmployerServiceBody.dart';
import 'package:contractjobs/Services/CJEmployerService/CJEmployerServiceRequest.dart';
import 'package:contractjobs/Services/CJEmployerService/CJEmployerServiceURL.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as Path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../CustomView/CJHubCustomView/Method.dart';
import '../../../Employers/Controller/Employer_KYC/Employer_JoinerAggrementChild.dart';
import '../../../Employers/Controller/Employer_KYCModelClass/Employer_AggreementModelClass.dart';
import '../../../JoiningProfile/TEC_JoiningProfileDashboard.dart';
import '../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import '../../../TankhaPayPinNumber/TankhaPaySet4DigitPin.dart';

class TankhaPayTermsandConditions extends StatefulWidget
{

  const TankhaPayTermsandConditions({Key? key,  this.verifyOTP_ModelResponse}) : super(key: key);
  final VerifyOTP_ModelResponse? verifyOTP_ModelResponse;


  @override
  State<TankhaPayTermsandConditions> createState() => _TankhaPayTermsandConditions();
}

class _TankhaPayTermsandConditions extends State<TankhaPayTermsandConditions> {


  List<CommonAggreementList> employerAggreementList=[];
  String headingTitle="",headingDesc="";

  String deviceType="",IPAddress="";
  bool btnStatus=true;
  ScrollController _controller = ScrollController();


  @override
  void initState() {
    super.initState();

    getServiceRequest_AggreementList();
    getBasicInfo();

    /*---------27-2-2023 start----------*/
     /* _controller.addListener(()
    {
      setState(() {
        if (_controller.position.atEdge)
        {
          bool isTop = _controller.position.pixels == 0;
          if (isTop) {
            print('At the top');
          } else {
            print('At the bottom');
            btnStatus=true;
          }
        }
      });

    });*/

    /*---------27-2-2023 end----------*/

  }

  getBasicInfo()
  {

    Method.getIPAddress().then((value) => {
      IPAddress=value,

    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: CJAppBarBgBlueForHTMLView("", appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show 1the action 1type");
            Navigator.pop(context);
          })),
          backgroundColor: whiteColor,
          body: MainfunctionUi(),

          bottomNavigationBar: Padding(padding: EdgeInsets.only(left: elevatedButtonLeftRightPadding,right:elevatedButtonLeftRightPadding ),
            child: elevatedButtonBottomBar(),) ,
        ));
  }

  Column MainfunctionUi()
  {
    return  Column(
      children: [

        CirclesBackground(
          circles: getCircleInfoForHome,
          child: ListTile(
            title: Text(
              "Terms & Conditions",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: largeExcel_FontSize,fontFamily: robotoFontFamily,fontWeight: bold_FontWeight,color: whiteColor),
            ),
          ),
        ),

       /* Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 25.0, vertical: 10),
          child: headingDesc=="" ? Text(
            headingDesc,
            style: const TextStyle(
                color: blackColor, fontSize: 16),
          ):Html(data:headingDesc.toString()),
        ),*/

        Expanded(flex: 1,child: ListView.builder(
            shrinkWrap: true,/*controller: _controller,*/
            itemCount: 1,
            itemBuilder: (context, index)
            {


              return  Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 10),
                child: headingDesc=="" ? Text(
                  headingDesc,
                  style: const TextStyle(
                      color: blackColor, fontSize: 16),
                ):Html(data:headingDesc.toString()),
              );
            }))

        //getTheCustomColumn()
      ],
    );



//
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

  /*  var dec=getDecryptedData("+YmQWoqlzTytkpZCzPzhpQUm+0hm+CCgsCEhpp22x+iOecQqkebS365FWepCqsf2ch18ifYdEnEZpLFV1uuM2x7MQzV1U6A3LzcH1wlhHJQ=");
   print("show the dec data $dec");*/

     createBodyWebApi_SaveEmployeeAggreement();
  }

  getServiceRequest_AggreementList()
  {
    print("show 1the request2");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().getDataServiceRequest(JG_ApiMethod_Employee_TermsandConditions,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();

          Employer_AggreementModelClass employer_aggreementModelClass=modelResponse as Employer_AggreementModelClass;
          print("show the data obj ${employer_aggreementModelClass.commonAggreementList}");

          if(employer_aggreementModelClass.commonAggreementList!.length>0)
          {
            setState(() {

              headingTitle=employer_aggreementModelClass.commonAggreementList![0].type!;
              headingDesc=employer_aggreementModelClass.commonAggreementList![0].employeeAggreementDesc!;


              print("show the headingTitle $headingTitle");

            /*  List<CommonAggreementList>tempObj=[];
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
              employerAggreementList=tempObj;*/
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
            CJSnackBar(context, "server 1 error!");
          }else {
            CJSnackBar(context, modelClass!.message!);
          }
        }));
  }


  createBodyWebApi_SaveEmployeeAggreement()
  {
    var mapObject=getEmployee_SaveTermsandConditions_RequestBody(widget.verifyOTP_ModelResponse!.data!.jsId,IPAddress,widget.verifyOTP_ModelResponse!.data!.empId);
    serviceRequestForEmployee(mapObject);
  }
////
  /*-----------employee login web api start--------------*/
  serviceRequestForEmployee(Map mapObj)
  {
    print("show 1the request2");
    print("show the request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJEmployerServiceRequest().postDataServiceRequest(mapObj,JG_ApiMethod_Employee_SaveTermsandConditions,
        cjEmployerResponseBlock: CJEmployerResponseBlock(employerSuccessBlock: <T>(commonResponse,modelResponse)
        {
          EasyLoading.dismiss();
          CJTalentCommonModelClass modelObject=commonResponse as CJTalentCommonModelClass;
          if(modelObject.statusCode==true)
          {
            print("show the success aggreement");

            CJSnackBar(context, modelObject.message!);

            /*---------14-2-2023 start-------------*/
            //TalentNavigation().pushTo(context, TEC_JoiningProfileDashboard(verifyOTP_ModelResponse: widget.verifyOTP_ModelResponse,));

            String employeePinNumber=widget.verifyOTP_ModelResponse!.data!.empPin;
            if(employeePinNumber=="" || employeePinNumber==null)
              {
                TalentNavigation().pushTo(context, TankhaPaySet4DigitPin(verifyOTP_ModelResponse: widget.verifyOTP_ModelResponse,employerMobileNo: "",));
              }else
                {
                  TalentNavigation().pushTo(context, TEC_JoiningProfileDashboard(verifyOTP_ModelResponse: widget.verifyOTP_ModelResponse,));
                }

            /*---------14-2-2023 end-------------*/

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