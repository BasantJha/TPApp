
 import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSize getPassbook_PreferredSize()
{
 return PreferredSize(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(
              color: darkGreyColor,
            )),
        child: TabBar(
          isScrollable: true,
          labelStyle: TextStyle(
            fontFamily: viewHeadingFontfamily,
            fontSize: 16.0,
            fontWeight: bold_FontWeight,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Color(0xff434343),
          indicator: BoxDecoration(
            color: ElevatedButtonBgBlueColor,
          ),
          tabs: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: passbook_tab("Cash Khata"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: passbook_tab("Benefit Khata"),
            )
          ],
        ),
      ),
      preferredSize: Size.fromHeight(80.0));
}

 Tab passbook_tab(String title) {
   return Tab(
     height: 40,
     text: title,
   );
 }

 var getPassbookText=Text(
   getTalent_PassbookTitle,
   style: TextStyle(
     color: Colors.black,
     fontSize: appBarTitleFontWeight,
     fontFamily: viewHeadingFontfamily,
     fontWeight: bold_FontWeight,
   ),
 );
