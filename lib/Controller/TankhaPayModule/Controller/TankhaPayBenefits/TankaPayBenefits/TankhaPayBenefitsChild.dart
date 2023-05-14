

import 'package:flutter/material.dart';

import '../../../../../Constant/Constants.dart';
import '../../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../TankhaPaySocialSecurityBenefits/TankhaPaySocialSecurityBenefits.dart';

class TankhaBenifitModel {
  String? index;
  String? title;
  String? number;
  String? hint;


  TankhaBenifitModel({this.index, this.title, this.number,this.hint});

  TankhaBenifitModel.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    title = json['title'];
    number = json['number'];
    hint = json['hint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['title'] = this.title;
    data['number'] = this.number;
    data['hint'] = this.hint;
    return data;
  }
}


var uanHint="UAN is a 12-digit identification number allotted to a PF member. It is a permanent number, valid for lifetime. If you were previously enrolled in PF and already have a UAN number, please enter it here. You can find your UAN number by visiting the website: https://unifiedportal-mem.epfindia.gov.in/memberinterface/ and clicking on ‘Know Your UAN’. Enter your basic details to get your UAN. ";
var esicHint="A unique number allotted to every insured person who can avail ESIC benefits ";
var dispensaryHint="The dispensary allotted to you and your family member where you can get treatment as per the ESIC scheme. If you wish to change your dispensary, kindly refer to the FAQs.";

var getThankaPayData=[
  TankhaBenifitModel(title: "UAN", number: "",index: "1",hint:uanHint),
  TankhaBenifitModel(title: "ESIC IP no.", number: "", index: "2",hint:esicHint ),
  TankhaBenifitModel(title: "Dispensary", number: "", index: "3",hint:dispensaryHint),
];

Card raise_bill_card(BuildContext context,
    String title, String subtitle, String image, String btnText)
{
  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: whiteColor),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Container(
      height: 200,
      //width: cardWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Color(0xffE4EEF4)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Color(0xff194960),
                      fontWeight: FontWeight.bold,
                      fontFamily: viewHeadingFontfamily,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Color(0xff373529),
                      fontWeight: FontWeight.bold,
                      fontFamily: viewHeadingFontfamily,
                      fontSize: textFieldHeadingFontWeight,
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: 40,
                      width: 180,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: Color(0xff107C9F)),
                        onPressed: ()
                        {
                          TalentNavigation().pushTo(context, TankhaPaySocialSecurityBenefits());
                        },
                        child: Wrap(
                          children: [
                            Text(
                              btnText,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ElevatedButtonTextFontWeight),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.double_arrow,
                              size: 22.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Transform.scale(
                scale: 0.6,
                child: Image.asset(
                  image,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
