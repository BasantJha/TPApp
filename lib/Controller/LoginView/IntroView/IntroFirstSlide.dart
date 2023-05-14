import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/LoginView/ModelClasses/IntroModelClass.dart';
import 'package:contractjobs/CustomView/Messages/Talent_TextMessages.dart';
import 'package:contractjobs/CustomView/Text/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceBody.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceKey.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceRequest.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceURL.dart';
import 'package:contractjobs/Services/LocalizationFile/LocalizationFile.dart';
//import 'package:getwidget/components/avatar/gf_avatar.dart';

class IntroFirstSlide extends StatefulWidget {
  const IntroFirstSlide({Key? key}) : super(key: key);

  @override
  State<IntroFirstSlide> createState() => _IntroFirstSlide();
}

class _IntroFirstSlide extends State<IntroFirstSlide> {
  //final PageController controller = PageController();
  bool animate = false;
  late List<IntroDetails> screenListData=[];
  String title="",subTitle="",banner="",btnName="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //serviceBodyRequest();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: getResponsiveUI(),
      bottomNavigationBar: firstSlideBottomBar(),

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

  MainfunctionUi() {
    return Container(
       color: whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showTheFirstSlide(),
        //showTheLocalizationPopUp()

        ],
      ),
    );
  }

  Container showTheFirstSlide()
  {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        image: DecorationImage(
          //image: banner!="" ? GFAvatar(backgroundImage:NetworkImage("agency_LogoURL")):AssetImage(getIntroFirstSlide) ,
            image:AssetImage(getIntroFirstSlide)

        ),

      ),
    );
  }

  Container firstSlideBottomBar()
  {

    return Container(
      padding: introScreenBottomPadding,
      height: 200,
      width: 600,
      decoration: BoxDecoration(
          color: lightBlueColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

         /* Text(getIntroF_Heading,
            style: textStyle_IntroHeading,
          ),*/
          Text(title != "" ? title:getIntroF_Heading,
            style: textStyle_IntroHeading,
          ),
          SizedBox(
            height: 9,
          ),

         /* Text(getIntroF_SubHeading,
            textAlign: TextAlign.center,
            style: textStyle_IntroSubHeading,
          ),*/
          Text(subTitle != "" ? subTitle: getIntroF_SubHeading,
            textAlign: TextAlign.center,
            style: textStyle_IntroSubHeading,
          ),
          //Container(child: showTheLocalizationPopUp(),)
        ],
      ),
    );
  }

 /* showTheLocalizationPopUp()
  {
    String? lang = "english";
    List? lngs = ["english", "hindi"];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String language = lang!;
        return AlertDialog(
          scrollable: true,
          title: Text("Select Language"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              print(lang);

              return Column(
                children: [
                  Container(
                    width: 200,
                    height: 120,
                    child: ListView.builder(
                      itemCount: lngs!.length,
                      itemBuilder: (context, index)
                      {
                        return RadioListTile(
                          title: Text(
                              lngs![index].toString().toUpperCase()),
                          value: lngs![index].toString(),
                          groupValue: language,
                          onChanged: (value)
                          {
                            setState(() {
                              language = value.toString();
                              lang = value.toString();
                            });
                          },
                        );
                      },
                    ),
                  ),
                  // RadioListTile(
                  //   title: Text("English"),
                  //   value: "english",
                  //   groupValue: language,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       language = value.toString();
                  //       lang = value.toString();
                  //     });
                  //   },
                  // ),
                  // RadioListTile(
                  //   title: Text("Hindi"),
                  //   value: "hindi",
                  //   groupValue: language,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       language = value.toString();
                  //       lang = value.toString();
                  //     });
                  //   },
                  // ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(100, 40),
                      ),
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
*/

  /*--------------hit the intro service request start---------------*/

  serviceBodyRequest()
  {
    print("show the request111");
    var mapObject=getJS_Intro_RequestBody(kJS_ServiceValue_Intro1,kLoclizationValue_English);
    serviceRequest(mapObject);

  }
  serviceRequest(Map mapObj)
  {
       print("show the request2");
       print("show the request object $mapObj");

    CJJobSeekerServiceRequest().postDataServiceRequest(mapObj, JS_ApiMethod_Intro,
        cjJobSeekerResponseBlock: CJJobSeekerResponseBlock(jobSeekerSuccessBlock: <T>(success)
        {
          var response=success as IntroModelClass;
          print("show the request success $response");
          screenListData=response.introDetails!;



          setState(() {

            for(var obj in screenListData)
            {
              var checkScreenType=obj.screenName != "" ? obj.screenName:"";


              if(checkScreenType=="Intro1banner")
              {
                banner=obj.labelValue!;
              }
              else if(checkScreenType=="Intro1title")
              {
                title=obj.labelValue!;
              }
              else if(checkScreenType=="Intro1subtitle")
              {
                subTitle=obj.labelValue!;
              }
              else if(checkScreenType=="Introaction")
              {
                btnName=obj.labelValue!;
              }
              else
              {

              }
            }
          });


        }, jobSeekerFailureBlock:<T>(failure)
        {
          print("show the request failure");

        }));

  }

/*--------------hit the intro service request end---------------*/
}



