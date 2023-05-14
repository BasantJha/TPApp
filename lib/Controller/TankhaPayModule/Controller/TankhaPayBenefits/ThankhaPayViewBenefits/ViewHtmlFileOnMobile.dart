import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';
import '../../../../../Constant/Responsive.dart';
import '../../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import '../TankhaPaySocialSecurityBenefits/TankhaPaySocialSecurityBenefitsChild.dart';

class ViewHtmlFileOnMobile extends StatefulWidget
{
  const ViewHtmlFileOnMobile({Key? key, required this.showFileName, this.titleName}) : super(key: key);
  final String? showFileName;
  final String? titleName;


  @override
  State<ViewHtmlFileOnMobile> createState() => _ViewHtmlFileOnMobile();
}

class _ViewHtmlFileOnMobile extends State<ViewHtmlFileOnMobile> {

  WebViewController? _webViewController;

  String showHeading="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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

  }


  @override
  Widget build(BuildContext context)
  {

    return Scaffold(

      backgroundColor: whiteColor,
      appBar: CJAppBarBgBlue("", appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),

      body: getResponsiveUI(),
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
          Expanded(flex: 1,child:  Container(
    // padding: EdgeInsets.all(2),
         child: WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController)
        {
        _webViewController = webViewController;
        _loadHtmlFromAssets();
          },

    )))

        ]));
  }

  _loadHtmlFromAssets() async {
    String fileHtmlContents = await rootBundle.loadString(getBenefitHTMLLoadPath(widget.showFileName!));
    _webViewController!.loadUrl(Uri.dataFromString(fileHtmlContents,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}

