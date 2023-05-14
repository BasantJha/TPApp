
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constant/ConstantIcon.dart';
import '../../Constant/Constants.dart';
import '../AppBar/AppBarTitle.dart';

SizedBox profileSupportUI()
{
  return SizedBox(
    //height: /*170*/90,
    width: /*376*/webResponsive_TD_Width-30,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: Color(0xffCCCBCB),
        ),
      ),
      color: Color(0xffFFFFFF),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          ListTile(
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 44,
                minHeight: 44,
                maxWidth: 64,
                maxHeight: 64,
              ),
              child: Image.asset(Talent_Icon_HRSupport, fit: BoxFit.cover),
            ),
            title: Text(getCJHUB_HelpAndSupportTitle,
              style: TextStyle(
                  fontFamily: robotoFontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w700
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("For queries related to salary, PF, ESIC etc.",
                  style: TextStyle(
                      fontFamily: robotoFontFamily,
                      fontSize: 12,
                      color: Color(0xff7B7B7B)
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Image.asset(RightArrow_Icon),
              onPressed: ()
              {

              //  TalentNavigation().pushTo(context, HrConnect(pendingQueryValue: 0,));

              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
         /* Divider(
            color: Colors.grey,
            height: 1,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 44,
                minHeight: 44,
                maxWidth: 64,
                maxHeight: 64,
              ),
              child: Image.asset(Talent_Icon_Chat_With_CJMitra, fit: BoxFit.cover),
            ),
            title: Text("Chat with CJ Mitra",
              style: TextStyle(
                  fontFamily: robotoFontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w700
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("For queries related to jobs, training, transaction etc",
                  style: TextStyle(
                      fontFamily: robotoFontFamily,
                      fontSize: 12,
                      color: Color(0xff7B7B7B)
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Image.asset(RightArrow_Icon),
              onPressed: () {},
            ),
          ),*/
        ],
      ),
    ),
  );

}