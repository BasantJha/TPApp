/*
import 'dart:html';
import 'dart:ui' as ui;

import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../TankhaPaySocialSecurityBenefits/TankhaPaySocialSecurityBenefitsChild.dart';


class ViewHtmlFileOnWeb extends StatefulWidget
{
  const ViewHtmlFileOnWeb({Key? key, required this.showFileName, this.titleName}) : super(key: key);
  final String? showFileName;
  final String? titleName;

  @override
  State<ViewHtmlFileOnWeb> createState() => _ViewHtmlFileOnWeb();
}

class _ViewHtmlFileOnWeb extends State<ViewHtmlFileOnWeb>
{

//

  String showHeading="";


  @override
  void initState()
  {

    if(widget.titleName==CJThankhaPay_PrivacyPolicy || widget.titleName==CJThankhaPay_TermsOfUse)
    {
      //privacy policy and terms of use
      showHeading=widget.titleName!;
    }
    else
    {
      //benefit html
      showHeading=getThankhaPay_SocialSecurityBenefitsTitle;

    }


    IFrameElement iframeElement = IFrameElement()
      ..src = getBenefitHTMLLoadPath(widget.showFileName!)
      ..style.border = 'none'
      ..onLoad.listen((event) {
        // perform you logic here.
      });

    ui.platformViewRegistry.registerViewFactory(widget.showFileName!,
          (int viewId) => iframeElement,
    );
    // print(iframeElement.src);
    super.initState();

  }




  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor: whiteColor,
      appBar: CJAppBarBgBlue("", appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),      body: Container(
        // padding: EdgeInsets.all(2),
        child: getResponsiveUI(),
        // Text("demo"),
        // HtmlElementView(viewType: _loadHtmlFromAssets()),
      ),
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

  CirclesBackground  MainfunctionUi()
  {
    return CirclesBackground(
      circles:getCircleInfoForHome,
      child: getTheCustomColumn(),);
  }

  Container getTheCustomColumn() {
    return Container(
        padding: EdgeInsets.only(left: 5, right: 5), child: Column(
        children: [

          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(showHeading,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: whiteColor,
                  fontFamily: robotoFontFamily,
                  fontSize: 20.0),
            ),


          ),
          SizedBox(height: 20,),

          Expanded(flex: 1,child:  Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: HtmlElementView(viewType: widget.showFileName!),
              ),
            ),
          ))


        ]));
  }


}

*/
