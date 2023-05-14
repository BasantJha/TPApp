
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_TabBarController/Talent_TabBarController.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:flutter/material.dart';


class Talent_VerifyBankAccountDetails extends StatefulWidget {

  const Talent_VerifyBankAccountDetails({Key? key}) : super(key: key);

  @override
  VerifyBankState createState() => VerifyBankState();

}

class VerifyBankState extends State<Talent_VerifyBankAccountDetails>{

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: getResponsiveUI(),
        bottomNavigationBar: elevatedButtonBottomBar()

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

  SingleChildScrollView MainfunctionUi(){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: mainUILeftRightPadding,right: mainUILeftRightPadding,top: 20,bottom: 40),
        child: Column(
          children: [
            Container(
                height: 150,
                width: 150,
                child:Image.asset(Talent_SP_GIF) /*Image.network("https://tenor.com/view/verified-verified-instagram-verified-blue-gif-26305004.gif")*/

            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text("Your Bank Account is Valid",
                style: TextStyle(color: appBarTitleForegroundColor,fontSize: appBarTitleFontWeight,fontFamily: robotoFontFamily),),
            ),
            SizedBox(
              height: 35,
            ),
            card("Name On Bank Account", "Lokesh Agrawal"),
            SizedBox(
              height: 12,
            ),
            card("Bank Name", "Yes Bank"),
            SizedBox(
              height: 12,
            ),
            card("Branch", "Kriti Nagar"),
            SizedBox(
              height: 12,
            ),
            card("City", "New Delhi"),
            SizedBox(
              height: 12,
            ),
            card("Amount", "50000"),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Well Done, Lokesh",
                  style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: robotoFontFamily),),
                SizedBox(
                  width: 5,
                ),
                ImageIcon(
                  AssetImage("smily.png"),
                  color: Color(0xffDBDBDB),
                  size: 25,
                )
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Center(
              child: Column(
                children: [
                  Text("Your Account has been Successfully setup,you",style: TextStyle(color: Colors.black),),
                  SizedBox(
                    height: 1,
                  ),
                  Text("may start taking payment now",style: TextStyle(color: Colors.black),)
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      //),
    );
  }

  Widget card(String heading, String subheading)
  {
    return Container(
        width: 381,
        decoration: BoxDecoration(
            color: Color(0xffF0F0F0),
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        child:  Padding(
          padding: EdgeInsets.only(top: 10.0,left: 20.0,bottom: 10.0,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$heading",
                  style: TextStyle(color: textKeyColor,fontSize: textKeyFontWeight,fontFamily: robotoFontFamily)
              ),
              SizedBox(
                height: 5,
              ),
              Text("$subheading",
                style: TextStyle(color: textValueColor,fontSize: textValueFontWeight,fontFamily: robotoFontFamily),
              )
            ],
          ),
        )
    );
  }

  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Let's Go", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");

      //TalentNavigation().pushTo(context, Talent_VerifyBankAccountDetails());

      TalentNavigation().pushTo(context, Talent_TabBarController());


    }
    )) ;

  }

}