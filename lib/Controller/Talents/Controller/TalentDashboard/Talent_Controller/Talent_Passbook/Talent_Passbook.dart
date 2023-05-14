import 'dart:ui';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_Passbook/Talent_Passbook_CashKhata.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_Passbook/Talent_Passbook_Constant.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/Messages/Talent_TextMessages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


class Talent_Passbook extends StatefulWidget {
  const Talent_Passbook({super.key});

  @override
  State<Talent_Passbook> createState() => _Talent_Passbook();
}

class _Talent_Passbook extends State<Talent_Passbook> {


  var passBookCashKhataList=getPassbookCaskKhataList;

  @override
  Widget build(BuildContext context)
  {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 65,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 12, 0, 12),
            child: CJElevatedPassbookButton(elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
            {
                Navigator.pop(context);
            })),
          ),
          title: getPassbookText,
          centerTitle: true,
          bottom: getPassbook_PreferredSize(),
        ),
        body: getResponsiveUI(),
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
  TabBarView  MainfunctionUi(){

    return TabBarView(
      children: [
        cash_khata(),
        benefit_khata(),
      ],
    );
  }

  Container benefit_khata() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BK_exp_tile("EPF", "₹ 11,250.00"),
            Divider(
              height: 1,
              thickness: 1,
              color: darkGreyColor,
            ),
            BK_exp_tile("ESIC", "₹ 3,000.00"),
            Divider(
              height: 1,
              thickness: 1,
              color: darkGreyColor,
            ),
            BK_exp_tile("Gratuity", "₹ 2,160.00"),
            Divider(
              height: 1,
              thickness: 1,
              color: darkGreyColor,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                BK_bottom_tile("View EPF passbook using", "EPFO portal",
                    Talent_Icon_Passbook_Benefit_EPF),
                BK_bottom_tile("View ESIC contribution on", "ESIC portal",
                    Talent_Icon_Passbook_Benefit_ESC),
              ],
            )
          ],
        ),
      ),
    );
  }

  ListTile BK_bottom_tile(String title, String link_text, String image) {
    return ListTile(
      leading: Image(image: AssetImage(image)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15.0,
          fontFamily: viewHeadingFontfamily,
          fontWeight: bold_FontWeight,
        ),
      ),
      trailing: Text(
        link_text,
        style: TextStyle(
          color: darkBlueColor,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  ExpansionTile BK_exp_tile(String title, String amount) {
    return ExpansionTile(
      title: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: viewHeadingFontfamily,
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: bold_FontWeight,
          ),
        ),
        trailing: Text(
          amount,
          style: TextStyle(
            fontFamily: viewHeadingFontfamily,
            color: darkGreyColor,
            fontSize: 22.0,
            fontWeight: bold_FontWeight,
          ),
        ),
      ),
      children: [
        BK_statement_list("March 2022", "₹ 2,250.00"),
        BK_statement_list("March 2022", "₹ 2,250.00"),
        BK_statement_list("May 2022", "₹ 2,250.00"),
        BK_statement_list("June 2022", "₹ 2,250.00"),
        BK_statement_list("July 2022", "₹ 2,250.00"),
      ],
    );
  }

  ListTile BK_statement_list(String date, String amount) {
    return ListTile(
      title: Text(
        date,
        style: TextStyle(
          fontSize: 16.0,
          color: darkGreyColor,
          fontWeight: bold_FontWeight,
        ),
      ),
      trailing: Text(
        amount,
        style: TextStyle(
          fontSize: 16.0,
          color: darkGreyColor,
          fontWeight: bold_FontWeight,
        ),
      ),
    );
  }

  Container cash_khata() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          ListTile(
            title: Text("Aug 15, 2022 - Sep 14, 2022"),
            trailing: ImageIcon(
              AssetImage(Talent_Icon_Passbook_calendar),
              color: darkBlueColor,
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: darkGreyColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text("Balance"),
            subtitle: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: viewHeadingFontfamily,
                  fontWeight: bold_FontWeight,
                  fontSize: 40.0,
                  color: darkBlueColor,
                ),
                children: [
                  WidgetSpan(
                    child: Transform.translate(
                      offset: const Offset(0.0, -20.0),
                      child: Text(
                        '₹',
                        style: TextStyle(
                            fontFamily: viewHeadingFontfamily,
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
                            fontFamily: viewHeadingFontfamily,
                            fontWeight: bold_FontWeight,
                            fontSize: 20,
                            color: darkBlueColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            trailing:
            Image(image: AssetImage(Talent_Icon_PassbookBank)),
          ),
          Divider(
            height: 12,
            thickness: 1,
            color: darkBlueColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Wrap(
                children: [
                  Text(
                    "Download Statement",
                    style: TextStyle(
                        fontSize: 15, color: darkBlueColor),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.download,
                    color: Colors.grey,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(child: ListView.builder(itemCount: passBookCashKhataList.length,itemBuilder: (BuildContext context,index)
              {
                var obj=passBookCashKhataList[index];
              return  Talent_Passbook_CashKhata().cashKhataColumn(obj.transactionType.toString(),
                  obj.transactionDateTime.toString(),
                  obj.transactionAmt.toString(),
                  obj.transactionAmtZero.toString());
              }
          )),

        ],
      ),
    );
  }

}

