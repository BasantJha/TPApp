
import 'dart:async';

import 'package:flutter/material.dart';

import 'Constant/Constants.dart';
import 'Constant/Responsive.dart';
import 'CustomView/AppBar/CustomAppBar.dart';

class DemoUpiPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _DemoUpiPage();

}


class _DemoUpiPage extends State<DemoUpiPage>
{

  var time = 2;
  var sec = 00;
  static Timer? timerforisqrassigncheck;


  setTimer()
  {
    var totalSec = 10 * 60;
     timerforisqrassigncheck = Timer.periodic(Duration(seconds: 40), (timer) {
       totalSec = totalSec - 1;
       setState(() {
         time = totalSec ~/ 60;
         sec = totalSec % 60;
       });
    });
  }


  @override
  void initState()
  {
    super.initState();
    var totalSec = time * 60;
    timerforisqrassigncheck = Timer.periodic(Duration(seconds: 1), (timer) {
      totalSec = totalSec - 1;
      setState(() {
        time = totalSec ~/ 60;
        sec = totalSec % 60;
      });
      if(totalSec == 0)
        {
          timerforisqrassigncheck!.cancel();
        }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CJAppBar("Amazon Pay",
          appBarBlock: AppBarBlock(appBarAction: ()
          {
            // print("show the action type");
            Navigator.pop(context);
          })),
      backgroundColor: whiteColor,
      body: Responsive(
        mobile: MainFunctionUI(),
        tablet: Center(
          child: Container(
            width: flutterWeb_desktopWidth,
            child: MainFunctionUI(),
          ),
        ),
        desktop: Center(
          child: Container(
            width: flutterWeb_desktopWidth,
            child: MainFunctionUI(),
          ),
        ),

      ),
      bottomNavigationBar: Container(
        color: Color(0xfffdedcc),
        height: 40,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text("Please do not press back button until payment is completed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: normal_FontWeight,
                      fontSize: medium_FontSize,
                      fontFamily: robotoFontFamily
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }



  SingleChildScrollView MainFunctionUI()
  {
    return SingleChildScrollView(
       child: Padding(
         padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Container(
               width: MediaQuery.of(context).size.width,
               child: Card(
                   child: Container(
                     decoration: BoxDecoration(
                       border: Border(
                         left: BorderSide(color: Color(0xff0c98a9), width: 5),
                         right: BorderSide(color: Color(0xff2a8298), width: 2),
                         top: BorderSide(color: Color(0xff2a8298), width: 2),
                         bottom: BorderSide(color: Color(0xff2a8298), width: 2),
                       ),
                     ),
                     child: Padding(
                       padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                       child: Row(
                         children: [
                           Expanded(
                             child: Text("Note: Please do not press back button or close the screen until the payment is complete",
                              style: TextStyle(
                                fontWeight: normal_FontWeight,
                                fontSize: medium_FontSize,
                                fontFamily: robotoFontFamily
                              ),

                             ),
                           )
                         ],
                       ),
                     ),
                   )
               ),
             ),
             SizedBox(
               height: 20,
             ),
             Text("Complete Payment",
               style: TextStyle(
                   fontFamily: robotoFontFamily,
                   fontSize: large_FontSize,
                   fontWeight: bold_FontWeight,
                   color: blackColor
               ),
             ),
             SizedBox(
               height: 20,
             ),
             Row(
               children: [
                 Expanded(
                   child: Text("Entered UPI Address : 9569734648@paytm",
                     style: TextStyle(
                         fontWeight: normal_FontWeight,
                         fontSize: medium_FontSize,
                         fontFamily: robotoFontFamily,
                         color: darkGreyColor
                     ),
                   ),
                 )
               ],
             ),
             SizedBox(
               height: 40,
             ),
             Center(
               child: Text("PAGE EXPIRES IN",
                 style: TextStyle(
                     fontWeight: normal_FontWeight,
                     fontSize: medium_FontSize,
                     fontFamily: robotoFontFamily,
                     color: Color(0xff6e6e6e)
                 ),
               ),
             ),
             SizedBox(
               height: 20,
             ),
             Center(
               child: Container(
                 width: 150,
                 height: 70,
                 color: Color(0xfff3f7f8),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Column(
                           children: [
                             time<10?
                             Text("0$time",style: TextStyle(
                               color: Color(0xff212322),
                               fontFamily: robotoFontFamily,
                               fontSize: medium_FontSize,
                               fontWeight: normal_FontWeight
                             ),
                             ):Text("$time",
                               style: TextStyle(
                                   color: Color(0xff212322),
                                   fontFamily: robotoFontFamily,
                                   fontSize: medium_FontSize,
                                   fontWeight: normal_FontWeight
                               ),
                             ),
                             Text("MIN",
                               style: TextStyle(
                                 color: Color(0xff858786),
                                   fontFamily: robotoFontFamily,
                                   fontSize: medium_FontSize,
                                   fontWeight: normal_FontWeight
                               ),
                             )
                           ],
                         ),
                         SizedBox(
                           width: 3,
                         ),
                         Column(
                           children: [
                             Text(":"),
                             Text("")
                           ],
                         ),
                         SizedBox(
                           width: 3,
                         ),
                         Column(
                           children: [
                             sec<10?Text("0$sec",
                               style: TextStyle(
                                   color: Color(0xff212322),
                                   fontFamily: robotoFontFamily,
                                   fontSize: medium_FontSize,
                                   fontWeight: normal_FontWeight
                               ),
                             ):
                             Text("$sec",
                               style: TextStyle(
                                   color: Color(0xff212322),
                                   fontFamily: robotoFontFamily,
                                   fontSize: medium_FontSize,
                                   fontWeight: normal_FontWeight
                               ),
                             ),
                             Text("SEC",
                               style: TextStyle(
                                   color: Color(0xff858786),
                                   fontFamily: robotoFontFamily,
                                   fontSize: medium_FontSize,
                                   fontWeight: normal_FontWeight
                               ),
                             )
                           ],
                         ),
                       ],
                     ),
                   ],
                 )
               ),
             ),
           ],
         ),
       ),
    );
  }


}

