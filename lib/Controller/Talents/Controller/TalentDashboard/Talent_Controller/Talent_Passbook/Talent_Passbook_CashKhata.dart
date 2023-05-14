import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Talent_Passbook_CashKhata
{
  Column cashKhataColumn(String title, String date, String amount, String amt_dec)
  {
      return Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: TextStyle(
                fontFamily: viewHeadingFontfamily,
                fontSize: 18.0,
                fontWeight: bold_FontWeight,
              ),
            ),
            subtitle: Text(date,
                style: TextStyle(
                  fontFamily: viewHeadingFontfamily,
                  fontSize: 15.0,
                )),
            trailing: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: viewHeadingFontfamily,
                  fontWeight: bold_FontWeight,
                  fontSize: 30.0,
                  color: darkGreyColor,
                ),
                children: [
                  TextSpan(
                    text: amount,
                  ),
                  WidgetSpan(
                    child: Transform.translate(
                      offset: const Offset(0.0, 3.0),
                      child: Text(
                        amt_dec,
                        style: TextStyle(
                            fontFamily: viewHeadingFontfamily,
                            fontWeight: bold_FontWeight,
                            fontSize: 15,
                            color: darkGreyColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 10,
            thickness: 1,
            color: Colors.grey,
          )
        ],
      );

  }
}