import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../Constant/ConstantIcon.dart';
import '../../../../Constant/Constants.dart';
import '../../../../Constant/Responsive.dart';
import '../../../../CustomView/AppBar/AppBarTitle.dart';
import '../../../../CustomView/AppBar/CustomAppBar.dart';
import '../../../../CustomView/CJHubCustomView/AutoLogout.dart';
import '../../../../Services/Messages/Message.dart';
import 'HrConnect_closedquery.dart';
import 'HrConnect_createquery.dart';
import 'HrConnect_pendingquery.dart';

Timer? _rootTimer;

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff00BFFF)
  ));
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CJ Hub',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HrConnect(title: 'CJ Hub'),
    );
  }
}
class HrConnect extends StatefulWidget
{
  HrConnect({Key? key, this.title,this.pendingQueryValue}) : super(key: key);

  final String? title;
  final int? pendingQueryValue;

  @override
  _HrConnect createState() => _HrConnect(pendingQueryValue!);

}

class _HrConnect extends State<HrConnect> {
  // This widget is the root of your application.

   int? selectedPage;
   int? pageNumber;
   Function? onPressed;


  int _selectedPage = 0;
  PageController? _pageController;

  int? selectedPendingQueryValue;

  _HrConnect(int pendingQueryValue)
  {
    this.selectedPendingQueryValue=pendingQueryValue!;
    if(selectedPendingQueryValue==1)
    {
      //print("show selectedPendingQueryValue $selectedPendingQueryValue");

      _selectedPage=1;
      ChangeThePageCreateQueryToPendingQuery();
    }
    else
    {
      //print("show selectedPendingQueryValue $selectedPendingQueryValue");

    }
  }

  ChangeThePageCreateQueryToPendingQuery()
  {
    Timer(Duration(seconds: 1),
            ()=>
            _changePage(1)
    );

  }

  void _changePage(int pageNum)
  {
    setState(() {
      _selectedPage = pageNum;
      _pageController!.animateToPage(
        pageNum,
        duration: Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  @override
  void initState() {
    _pageController = PageController();

    if(kIsWeb){

      //print("This CJ Hub Web");

      //AutoLogout.initializeTimer(context);

    }
    else{

      //print('this is mobile App');
    }

    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  Container mainFunction_UI(){
    return Container(
      // color: Colors.greenAccent,

      padding: const EdgeInsets.fromLTRB(10,10,10,10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          create_headingContainer("HR Connect"),

          SizedBox(
            height: 20,
          ),

          Container(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex:1,
                  child: TabButton(
                    text: "Create A Query",
                    pageNumber: 0,
                    selectedPage: _selectedPage,
                    onPressed: ()
                    {
                      _changePage(0);
                    },
                  ),),

                Expanded(
                  flex:1,
                  child:
                  TabButton(
                    text: "Pending Queries",
                    pageNumber: 1,
                    selectedPage: _selectedPage,
                    onPressed: ()
                    {
                      _changePage(1);
                    },
                  ),
                ),

                Expanded(
                  flex:1,
                  child:
                  TabButton(
                    text: "Closed Queries",
                    pageNumber: 2,
                    selectedPage: _selectedPage,
                    onPressed: ()
                    {
                      print("show the selected page no $_selectedPage");
                      _changePage(2);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: (int page)
              {
                setState(()
                {
                  _selectedPage = page;
                });
              },
              controller: _pageController,
              children: [
                Container(
                  decoration: new BoxDecoration(
                    // color: Colors.orange,
                      shape: BoxShape.rectangle,
                      borderRadius: new BorderRadius.circular(0.0),
                      border: Border.all(color: colors.borderColor,
                          width: 1.0,
                          style: BorderStyle.solid)
                  ),
                  child: Center(
                    child: HrConnect_createquery(),

                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    // color:Colors.blue,
                      shape: BoxShape.rectangle,
                      borderRadius: new BorderRadius.circular(0.0),
                      border: Border.all(color: colors.borderColor,
                          width: 1.0,
                          style: BorderStyle.solid)
                  ),
                  child: Center(
                    child: HrConnect_pendingquery(),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    // color: Colors.lightGreen,
                      shape: BoxShape.rectangle,
                      borderRadius: new BorderRadius.circular(0.0),
                      border: Border.all(color: colors.borderColor,
                          width: 1.0,
                          style: BorderStyle.solid)
                  ),
                  child: Center(
                    child: HrConnect_closedquery(),
                  ),
                )
              ],
            ),
          )
        ],
      ),


    );
  }

  void _handleUserInteraction([_])
  {
    if (_rootTimer != null && !_rootTimer!.isActive) {
      // This means the user has been logged out
      return;
    }

    _rootTimer?.cancel();

    //print("HR Connect resetTimer:");

    //AutoLogout.initializeTimer(context);
  }

  @override
  Widget build(BuildContext context)
  {
    var size = MediaQuery.of(context).size;
    return  Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handleUserInteraction,
        onPointerMove: _handleUserInteraction,
        onPointerUp: _handleUserInteraction,
        child:
      Scaffold(
          backgroundColor: Colors.white,
          appBar:CJAppBar(getCJHUB_HelpAndSupportTitle, appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show the action type");
            Navigator.pop(context);

          })),
        body: WillPopScope(
          child: Responsive(

              mobile: mainFunction_UI(),
              tablet: Center(
                child:  Container(
                  width: size.width*support_tabletWidth,
                  child: mainFunction_UI(),
                ),
              ) ,

              desktop: Center(
                child: Container(
                  width: size.width*support_desktopWidth,
                  child: mainFunction_UI(),
                ),
              )

          ),
         onWillPop: () async
          {
            Message.alert_dialogAppExit(context);
            return false;
          } ,

          //onWillPop: () async => false,
        )
    )
    );
  }

  Container create_headingContainer(String value){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,20,0,0),
        child: Row(
          children: [

            SizedBox(
              width: 20.0,
              height: 20.0,
              child: Image.asset(getCJHub_LineIcon,
              ),
            ),
            SizedBox(
                width: 1.0),
            Expanded(
              flex: 1,
              child: Text(value,
                style: TextStyle(color: Colors.black,fontSize: 18),),
            ),
          ],
        ),
      ),
    );
  }

}
class TabButton extends StatelessWidget
{
  final String? text;
  final int? selectedPage;
  final int? pageNumber;
  final Function() onPressed;

  TabButton({this.text, this.selectedPage, this.pageNumber, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(
            milliseconds: 1000
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
            color: selectedPage == pageNumber ? Colors.blue : Colors.transparent,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(0.0),
            border: selectedPage == pageNumber ?  Border.all(color: Colors.transparent,
                width: 1.0,
                style: BorderStyle.solid) : Border.all(color: colors.borderColor,
                width: 1.0,
                style: BorderStyle.solid)
        ),
        padding: const EdgeInsets.all(9),
        child: Text(
          text ?? "Tab Button",
          style: TextStyle(
            color: selectedPage == pageNumber ? Colors.white : Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class colors{
  static const borderColor = Color(0xffE0E0E0);
}