


//import 'dart:js';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_Billing/Talent_BillingsChild.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/MarginSizeBox/MarginSizeBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:overlay_container/overlay_container.dart';


class Talent_Billings extends StatefulWidget
{
  @override
  _Talent_Billings createState() => _Talent_Billings();
}

/*final List<Widget> transactionDataList = [
  (name, "5 Sep 2022, 2 PM", 8000,status: "Recevived" ),
  (Name: "Xyz",DateSpan: "5 Sep 2022, 2 PM",rupees:8000,status: "Pending" ),
];
*/

List transactionDataList=[
  TalentBillingData(transactionType: "Abc", transactionDateTime: '5 Sep 2022, 2 PM', transactionAmount: '5000', transactionStatus: 'Pending'),
  TalentBillingData(transactionType: "PQR", transactionDateTime: '5 Sep 2022, 2 PM', transactionAmount: '5000', transactionStatus: 'Received')];

bool _dropdownShown = false;

List<String> filterListData =[
  "Current Activity","This Week","Last Week","This Month - Oct 2022",
  "This Month - Oct 2022",
  "This Month - Oct 2022",
  "This Month - Oct 2022",
];

String selectedStartDate = 'Sep 26,2022';
String selectedEndDate = 'Oct 2, 2022';
String selectedDateRange = 'Aug 15, 2022-Sep 14 2022';
var monthList = ["jun","feb","mar","apr","may","june","jul","Aug","Sep","Oct","Nov","Dec"];

class _Talent_Billings extends State<Talent_Billings> {

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),

      appBar: CJAppBar(
          getTalent_Billing, appBarBlock: AppBarBlock(appBarAction: () {
        print("show the action type");
        Navigator.pop(context);
      })),
      body: getResponsiveUI(),
    );
  }


  Responsive getResponsiveUI() {
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


  GestureDetector MainfunctionUi() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _dropdownShown = false;
        });
      },
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Container(
                  height: 47,
                  decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      border: Border.all(color: Color(0xffEEECEC))
                  ),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text("$selectedDateRange",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: robotoFontFamily,
                                color: Color(0xff535353)
                            ),
                          )
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _dropdownShown = !_dropdownShown;
                            print("shown dropdown ${_dropdownShown}");
                          });
                        },
                        child: ImageIcon(
                          AssetImage("calendar.png"),
                          size: 30,
                          color: lightBlueColor,
                        ),
                      )
                    ],
                  ),
                ),
                openOverlay(),
                SizedBox(
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text("Total bill amount",
                          style: TextStyle(
                              fontFamily: robotoFontFamily,
                              fontSize: textFieldHeadingFontWeight,
                              color: textFieldHeadingColor
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: robotoFontFamily,
                              fontWeight: normal_FontWeight,
                              fontSize: 30.0,
                              color: darkBlueColor,
                            ),
                            children: [
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(0.0, -20.0),
                                  child: Text(
                                    '₹',
                                    style: TextStyle(
                                        fontFamily: robotoFontFamily,
                                        fontWeight: bold_FontWeight,
                                        fontSize: 20,
                                        color: darkBlueColor),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: "8000.",
                              ),
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(0.0, 3.0),
                                  child: Text(
                                    '00',
                                    style: TextStyle(
                                        fontFamily: robotoFontFamily,
                                        fontWeight: bold_FontWeight,
                                        fontSize: 20,
                                        color: darkBlueColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Divider(
                    height: 1,
                    color: Color(0xff40BCFD),
                  ),
                ),
                SizedBox(
                    height: 75.0 * transactionDataList.length,
                    child: ListView.builder(
                      itemCount: transactionDataList.length,
                      itemBuilder: (BuildContext context, int index)
                      {
                        TalentBillingData billingData=transactionDataList[index];
                        String transactionType=billingData.transactionType;
                        String transactionDateTime=billingData.transactionDateTime;
                        String transactionAmount=billingData.transactionAmount;
                        String transactionStatus=billingData.transactionStatus;

                        Color colorCode;
                        if(transactionStatus=="Pending")
                        {
                          colorCode=redColor;
                        }else
                        {
                          colorCode=greenColor;
                        }

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // transactionDataList[index],

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    height: 50,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: ListTile(
                                          title: Flex(
                                            direction: Axis.horizontal,
                                            children: [
                                              Expanded(
                                                child: Text(transactionType,
                                                  style: TextStyle(
                                                      color: blackColor,
                                                      fontSize: 16,
                                                      fontFamily: robotoFontFamily,
                                                      fontWeight: semiBold_FontWeight
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          subtitle: Text(transactionDateTime,
                                            style: TextStyle(
                                                fontWeight: textFieldFontWeightType,
                                                fontFamily: robotoFontFamily,
                                                fontSize: 11
                                            ),
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              height: 50,
                                              child: ListTile(
                                                  title: RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        fontFamily: robotoFontFamily,
                                                        fontWeight: semiBold_FontWeight,
                                                        fontSize: 18,
                                                        color: textFieldHintTextColor,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: "₹$transactionAmount.",
                                                        ),
                                                        WidgetSpan(
                                                          child: Transform.translate(
                                                            offset: const Offset(0.0, 3.0),
                                                            child: Text(
                                                              '00',
                                                              style: TextStyle(
                                                                  fontFamily: robotoFontFamily,
                                                                  fontWeight: semiBold_FontWeight,
                                                                  fontSize: 14,
                                                                  color: textFieldHintTextColor),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  subtitle:Container(padding: EdgeInsets.only(left: 10.0),child: Text(transactionStatus,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontFamily: robotoFontFamily,
                                                        color: colorCode
                                                    ),
                                                  ),)
                                              ),
                                            )
                                        ),
                                        transactionStatus == "Received" ?
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              padding: EdgeInsets.only(top: 23),
                                              height: 50,
                                              child:InkWell(child: ImageIcon(
                                                AssetImage(Visible_Icon),
                                                size: 10,
                                                color: darkBlueColor,
                                              ),onTap: ()
                                              {

                                              },)
                                          ),
                                        ) : Expanded(
                                          flex: 1,
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.4,
                                            padding: EdgeInsets.only(top: 23),
                                            height: 50,
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  InkWell(child:ImageIcon(
                                                    AssetImage(Visible_Icon),
                                                    color: darkBlueColor,
                                                    size: 20,
                                                  ) ,onTap: ()
                                                  {

                                                  },)

                                                  ,
                                                  //SizedBox(width: 2,),
                                                  InkWell(child:ImageIcon(
                                                    AssetImage(Share_Icon),
                                                    color: darkBlueColor,
                                                    size: 16,
                                                  ) ,onTap: ()
                                                  {

                                                  },)

                                                ]),
                                          ),
                                        )
                                      ],
                                    )
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Divider(
                                height: 1,
                                color: Color(0xff9D9D9D),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  openOverlay()
  {
/*
    return OverlayContainer(
      show: _dropdownShown,
      position: OverlayContainerPosition(
        // Left position.
        0,
        // Bottom position.
        0,
      ),
      child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color(0xffEEECEC),
              )
          ),
          child: Container(
            height: 300,
            width: webResponsive_TD_Width-50,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.only(top: 5,right: 5,left: 5,bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.grey),
                              left: BorderSide(width: 1.0, color: Colors.grey),
                              right: BorderSide(width: 1.0, color: Colors.grey),
                              bottom: BorderSide(width: 1.0,
                                  color: Colors.grey),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: [
                                Text(
                                    "$selectedStartDate",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Color(0xFF000000))
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _dropdownShown = !_dropdownShown;
                                  print("shown dropdown ${_dropdownShown}");
                                });
                                selectStartDate(context);
                              },
                              child: ImageIcon(
                                AssetImage(Talent_Icon_Passbook_calendar),
                                size: 20,
                                color: lightBlueColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.grey),
                              left: BorderSide(width: 1.0, color: Colors.grey),
                              right: BorderSide(width: 1.0, color: Colors.grey),
                              bottom: BorderSide(width: 1.0,
                                  color: Colors.grey),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: [
                                Text(
                                    "$selectedEndDate",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Color(0xFF000000))
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                selectEndDate(context);

                                setState(() {
                                  _dropdownShown = !_dropdownShown;
                                  print("shown dropdown ${_dropdownShown}");
                                });
                              },
                              child: ImageIcon(
                                AssetImage(Talent_Icon_Passbook_calendar),
                                size: 20,
                                color: lightBlueColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    //side: BorderSide(color: Colors.red)
                                  )
                              )
                          ),
                          onPressed: () {
                            setState(() {
                              selectedDateRange =
                                  selectedStartDate + "-" + "$selectedEndDate";
                              setState(() {
                                _dropdownShown = !_dropdownShown;
                                print("shown dropdown ${_dropdownShown}");
                              });
                            });
                          },
                          child: Text("Go",
                            style: TextStyle(color: Colors.white),
                          )
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            itemCount: filterListData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _dropdownShown = !_dropdownShown;
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(filterListData[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            })
                    )
                )
              ],
            ),
          )
      ),
    );
*/
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (d != null)
      setState(() {
        print("Inside startdate selection");
        selectedStartDate = monthList[d.month - 1] + " ${d.day}" + " ${d.year}";
        _dropdownShown = !_dropdownShown;
        print("shown dropdown ${_dropdownShown}");
        d == null;
      });
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (d != null)
      setState(() {
        print("Inside enddate selection");
        selectedEndDate = monthList[d.month - 1] + " ${d.day}" + " ${d.year}";
        _dropdownShown = !_dropdownShown;
        print("shown dropdown ${_dropdownShown}");
      });
  }

}




