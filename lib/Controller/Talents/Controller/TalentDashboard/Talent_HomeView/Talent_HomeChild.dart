
import 'package:circles_background/circles_background.dart';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../Constant/CJAppFlowConstants.dart';

var getCircleInfoForHome=[
  CircleInfo(
      size:  Size(500, 50),
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff93d9fd),
            Color(0xff3cbbfb)
          ]
      ),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      alignment: Alignment.topCenter),
];

var getCircleInfoForProfile=[
  CircleInfo(
      size:  Size(500, 70),
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff93d9fd),
            Color(0xff3cbbfb)
          ]
      ),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      alignment: Alignment.topCenter),
];



class Talent_HomeChild
{
List<Widget> fractionSwipListCardForHome()
{
  return [
    fraction_FunctionWidget(text1: "Chat With CJ\nMitra",Imageurl: Talent_Icon_Home_ReferFriend,g1: Color(0xffcaed83),g2:Color(0xffafd397),colorfortext: Color(0xff435E32)),
    fraction_FunctionWidget(text1: "Refer a friends & get rewarded",Imageurl: Talent_Icon_Home_CJMitra,g1: Color(0xffeccce3),g2: Color(0xffc69889),colorfortext: Color(0xff6d4161)),
    fraction_FunctionWidget(text1: "Chat With CJ\nMitra",Imageurl: Talent_Icon_Home_ReferFriend,g1: Color(0xffcaed83),g2:Color(0xffafd397),colorfortext: Color(0xff435E32)),
    fraction_FunctionWidget(text1: "Refer a friends & get rewarded",Imageurl: Talent_Icon_Home_CJMitra,g1: Color(0xffeccce3),g2: Color(0xffc69889),colorfortext: Color(0xff6d4161)),
  ];
}

fraction_FunctionWidget({text1,Imageurl,g1,g2,colorfortext})
{

  return  Column(
    children: [
      Container(
        margin: EdgeInsets.only(right: 20),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            // height: 100,
            width: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [g1, g2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        text1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: listTitle_FontSize,
                            fontFamily: robotoFontFamily,
                            fontWeight: bold_FontWeight,
                            color: colorfortext
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Image(image: AssetImage(Imageurl))
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    ],
  );
}

}



