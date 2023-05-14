




import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Controller/Employers/Controller/Employer_KYC/Employer_JoinerAggrementChild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../Constant/Constants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../../CustomView/CJSnackBar/CJSnackBar.dart';
import '../../../../../Services/CJTalentsService/CJHubWebApi/WebApi.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceBody.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceKey.dart';
import '../../../../../Services/CJTalentsService/CJTalentServiceRequest.dart';
import '../../../../../Services/Messages/Message.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../../../../Talents/ModelClasses/CJTalentCommonModelClass.dart';
import '../../../TankhaPayModelClasses/TankhaPayFAQModelClass/TankhaPayFAQModelClass.dart';
import 'TankhaPayFAQChild.dart';


var faqs = getFAQList;

class TankhaPayFAQ extends StatefulWidget {
  const TankhaPayFAQ({super.key});

  @override
  State<TankhaPayFAQ> createState() => _TankhaPayFAQ();
}

class _TankhaPayFAQ extends State<TankhaPayFAQ>
{
  int? selected = 0;
  double previousOffset = 0.0;

  TankhaPayFAQModelClass? tankhaPayFAQModelClass=  TankhaPayFAQModelClass(statusCode:false, message:"", data:[Data(question: "",answer: "")]);
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    createBodyWebApi_GeneralFAQ();
  }
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(backgroundColor: whiteColor,

      body: getResponsiveUI(context),
    );
  }


  Responsive getResponsiveUI(BuildContext context)
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

  Padding MainfunctionUi()
  {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child:tankhaPayFAQModelClass!.data!.isNotEmpty ?
      ListView.separated(
        //key: Key('builder ${selected.toString()}'),
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: tankhaPayFAQModelClass!.data!.length,
        itemBuilder: (context, index)
        {
          Data faqDataObj = tankhaPayFAQModelClass!.data![index];
          final GlobalKey expansionTileKey = GlobalKey();
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ExpansionTile(
              key: expansionTileKey,
              initiallyExpanded: index == selected,
              backgroundColor: Color(0xffEFF7FD),
              iconColor: blackColor,
              onExpansionChanged: (newState)
              {
                if (newState) {
                  // print(value);
                  setState(() {
                    const Duration(seconds: 10);
                    previousOffset = _scrollController.offset;
                    //print("Print prvious offset $previousOffset");
                    selected = index;
                    var d = expansionTileKey.currentContext;
                    //print("Current context $d");
                    if(index>3){
                      _scrollToSelectedContent(newState,previousOffset,index,expansionTileKey,tankhaPayFAQModelClass!.data);
                    }
                  });
                }
                else {
                  setState(() {
                    selected = -1;
                  });
                }
              },
              title: Html(data:faqDataObj.question.toString()),
              /*Text(
                faqDataObj.question.toString(),
                style: TextStyle(color: blackColor),
              )*/
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15, vertical: 5),
                  child: /*Text(faqDataObj.answer.toString())*/ Html(data:faqDataObj.answer.toString()),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              height: 1,
              thickness: 2,
            ),
          );
        },
      ): Container()
    );

  }

  void _scrollToSelectedContent(bool isExpanded, double previousOffset, int index, var myKey,var dataList)
  {
    final keyContext = myKey.currentContext;

    if (keyContext != null) {
      // make sure that your widget is visible
      final box = keyContext.findRenderObject() as RenderBox;
      if(dataList.length-1 == index || dataList.length-2 == index)
      {
        _scrollController.animateTo(isExpanded ? (box.size.height* 1.2 *index) : previousOffset,
            duration: Duration(milliseconds: 500), curve: Curves.linear);
      }
      else
      {
        _scrollController.animateTo(isExpanded ? (box.size.height* index) : previousOffset,
            duration: Duration(milliseconds: 500), curve: Curves.linear);
      }
      print("Previous offset $previousOffset");
      print("Box Size Height ${box.size.height}");
      print("Height in scrollToIndex ${box.size.height * index}");
    }
  }


  createBodyWebApi_GeneralFAQ()
  {
    var mapObject=getCJHub_EmployeeFAQ_RequestBody(kTankhaPay_FAQ_CategoryTypeGEN_Value);
    serviceRequest_GeneralFAQ(mapObject);
  }

  serviceRequest_GeneralFAQ(Map mapObj)
  {
    print("show 1the request12");
    print("show the// request object $mapObj");

    EasyLoading.show(status: Message.get_LoaderMessage);

    CJTalentServiceRequest().postDataServiceRequest(mapObj, WebApi.getTankhaPay_FAQ,
        cjTalentResponseBlock: CJTalentResponseBlock(talentSuccessBlock: <T>(success)
        {
          EasyLoading.dismiss();
          TankhaPayFAQModelClass faqModelClass=success as TankhaPayFAQModelClass;
          if(faqModelClass?.statusCode==true)
          {
            setState(() {
              tankhaPayFAQModelClass=faqModelClass;
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




}


