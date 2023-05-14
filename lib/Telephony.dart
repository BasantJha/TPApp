
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'Constant/ConstantIcon.dart';
import 'Constant/Constants.dart';
import 'Constant/Responsive.dart';
import 'package:telephony/telephony.dart';


backgrounMessageHandler(SmsMessage message) async {
  //Handle background message
  // You can also call other plugin in here
}

class TelePhonyUIStataeUI extends StatefulWidget
{
  @override
  TelePhonyUIStataeUIState createState() => TelePhonyUIStataeUIState();

}


class TelePhonyUIStataeUIState extends State<TelePhonyUIStataeUI>
{


  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  String rupeeIcon = "assets/tankhapayicons/tankhaSalaryIcon.png";
  var errortext = "";
  bool showCursor = false;

  final Telephony telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();

    telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          print("Massage Received ${message.body}");
        },
        listenInBackground: true,
        onBackgroundMessage: backgrounMessageHandler,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var transactionStatusCase = 3;

  @override
  Widget build(BuildContext context) {



      return SafeArea(
          child: Scaffold(
              backgroundColor: Colors.grey[100],
              appBar: AppBar(
                title: Text("Transaction Details"),
                backgroundColor: lightBlueColor,
                centerTitle: true,
                leading: Icon( Icons.arrow_back_outlined,color: whiteColor),
              ),
              body: Responsive(
                  mobile: MainfunctionUI(),
                  tablet: MainfunctionUI(),
                  desktop: Center(
                    child: Container(
                      width: webResponsive_TD_Width,
                      child: MainfunctionUI(),
                    ),
                  )

              )
          )
      );

  }

  SingleChildScrollView MainfunctionUI()
  {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            designUIofInsertAmount(),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              alignment: Alignment.center,
              child: Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  child: transactionStatusCase ==1 ?
                      IconUI("transactionDoneIcon.png"):
                  transactionStatusCase ==2 ?
                  IconUI("transactionfailure.png") :
                  IconUI("transactionfailure.png"),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: transactionStatusCase ==1 ? greenColor :transactionStatusCase ==2 ?
                    redColor : Colors.orange,
                  )
              ),
            ),
            transactionStatusCase == 1?
            TransactionStatusText("Transaction Successful",greenColor):
            transactionStatusCase == 2?
            TransactionStatusText("Transaction Failed",redColor):
            TransactionStatusText("Transaction Pending",Colors.orange),
            SizedBox(
              height: 40,
            ),
            payMentDetailsUI("TRANSACTION NUMBER", "88888888888"),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Divider(
                height: 8,
                color: darkGreyColor,
              ),
            ),
            payMentDetailsUI("TOTAL AMOUNT PAID", "\u{20B9}${"300000000"}"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Divider(
                height: 8,
                color: darkGreyColor,
              ),
            ),
            payMentDetailsUI("TRANSACTION DATE", "22 Aug 2022 5:25 AM"),
          ],
        ),
      ),
    );
  }





  IconUI(String iconPath)
  {
    return Image.asset(iconPath,
      color: whiteColor,
      width: 60,
      height: 60,
    );
  }

  TransactionStatusText(String TransationStatus, Color transactioncolor)
  {
    return Text(TransationStatus,
      style: TextStyle(
          fontFamily: robotoFontFamily,
          fontSize: large_FontSize,
          fontWeight: normal_FontWeight,
          color: transactioncolor
      ),
    );
  }


  payMentDetailsUI(String detailName,String detailDescription)
  {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 1,
              child: Text(detailName,
                style: TextStyle(
                    fontFamily: robotoFontFamily,
                    fontSize: medium_FontSize,
                    fontWeight: normal_FontWeight,
                    color: darkGreyColor
                ),
              )
          ),
          SizedBox(
            width: 10,
          ),
          Text(detailDescription,
            style: TextStyle(
                fontFamily: robotoFontFamily,
                fontSize: medium_FontSize,
                fontWeight: normal_FontWeight,
                color: blackColor
            ),
          ),
        ],
      ),
    );
  }

  designUIofInsertAmount()
  {
    return Container(
      child: Column(
        children: [
          Text("Enter Custom Amount",
            style: TextStyle(
              color: darkGreyColor,
              fontFamily: robotoFontFamily,
              fontWeight: normal_FontWeight,
              fontSize: large_FontSize
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  cursorColor: blackColor,
                  showCursor: true,
                  onChanged: (val){
                    if(val.isNotEmpty)
                    {
                      if(int.parse(val) < 1000)
                      {
                        setState(() {
                          errortext = "Note: Min Amount \u{20B9} 1000";
                        });
                      }
                      else
                      {
                        setState(() {
                          errortext = "";
                        });
                      }
                    }
                  },
                  style: TextStyle(
                      fontWeight: bold_FontWeight,
                      fontSize: 35,
                      color: blackColor
                  ),
                  decoration: InputDecoration(
                    prefixIcon: _controller.text.isEmpty
                        ? Center(
                      child: Text("\u{20B9}",
                        style: TextStyle(
                            fontWeight: bold_FontWeight,
                            fontSize: 35,
                            color: blackColor
                        ),
                      ),
                    ) :
                         Padding(
                      padding: _controller.text.length == 0 ?
                      EdgeInsets.only(left: MediaQuery.of(context).size.width*0.5 -10):
                      EdgeInsets.only(left: MediaQuery.of(context).size.width*0.5 - _controller.text.length*10),
                      child: Text("\u{20B9}",
                        style: TextStyle(
                            fontWeight: bold_FontWeight,
                            fontSize: 35,
                            color: blackColor
                        ),
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(minWidth: 10, minHeight: 0),
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide.none,
                    //   //borderRadius: BorderRadius.circular(20),
                    // ),
                  ),
                ),
              ),
            ),
          ),


          SizedBox(
            height: 5,
          ),
          Text(errortext,style: TextStyle(color: redColor))
        ],
      ),
    );
  }



}



