import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Controller/LoginView/Controller/LoginOptionController.dart';
import 'package:contractjobs/Controller/LoginView/IntroView/IntroFirstSlide.dart';
import 'package:contractjobs/Controller/LoginView/IntroView/IntroSecondSlide.dart';
import 'package:contractjobs/Controller/LoginView/IntroView/IntroThirdSlide.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/CJAnimationClass/CJAnimationClass.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceBody.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceKey.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceRequest.dart';
import 'package:contractjobs/Services/CJJobSeekerService/CJJobSeekerServiceURL.dart';
import 'package:contractjobs/Services/LocalizationFile/LocalizationFile.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroSwipeController extends StatefulWidget
{
  const IntroSwipeController({Key? key}) : super(key: key);

  @override
  State<IntroSwipeController> createState() => _IntroSwipeController();
}

class _IntroSwipeController extends State<IntroSwipeController>
{
  PageController _controller = PageController();
  bool onLastPage = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
          child: PageView(
            controller: _controller,
            onPageChanged: (index)
            {
              print("show the selected page $index");
              setState(()
              {
                onLastPage = (index == 2);
              });


            },
            children: [
              IntroFirstSlide(),
              IntroSecondSlide(),
              IntroThirdSlide(),
            ],
          ),
        ),
        bottomSheet: Container(
          color: lightBlueColor,
          //padding: EdgeInsets.symmetric(horizontal: 20),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                //alignment: Alignment.topLeft,
                children: [
                  // Center(
                  Container(
                    padding: EdgeInsets.fromLTRB(80, 0, 0, 60),
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: WormEffect(
                        // spacing: 16,
                        dotColor: darkGreyColor,
                        activeDotColor: whiteColor,
                      ),
                    ),
                  ),

                  // ),

                  Container(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Image(
                          image: AssetImage('introSkipBg.png'))),

                 Container(width: 220,
                    padding: EdgeInsets.fromLTRB(1, 45, 0, 10),
                    child: onLastPage
                        ?
                    InkWell(onTap: ()
                      {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );

                        TalentAnimationNavigation().pushTopToBottom(context, LoginOptionController());

                      },child: Align(alignment: Alignment.center,child: Text(
                      "Let's Go",
                      style: TextStyle(color: Colors.white,fontFamily: robotoFontFamily),
                    ),),)
                        :
                    InkWell(onTap: ()
                      {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                        TalentAnimationNavigation().pushTopToBottom(context, LoginOptionController());
                      },child:Align(alignment: Alignment.center,
                      child:Text("Skip",
                        style: TextStyle(color: Colors.white,fontFamily:robotoFontFamily ),
                      ) ,) ,),

                  )
                  ,
                ],
              ),
            ],
          ),
        ));
  }




}
