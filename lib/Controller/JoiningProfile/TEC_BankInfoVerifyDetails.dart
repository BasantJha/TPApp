
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_TabBarController/Talent_TabBarController.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/Controller/TankhaPayModule/Controller/ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfileChild.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:flutter/material.dart';

import '../Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';
import 'JoiningProfileModelClass/EmployeeBankAccountVerifyModelClass.dart';
import 'TEC_JoiningProfileDashboard.dart';


class TEC_BankInfoVerifyDetails extends StatefulWidget {


  const TEC_BankInfoVerifyDetails({Key? key, this.verifyOTP_ModelResponse, this.bankAccountDetailsObj}) : super(key: key);

  final VerifyOTP_ModelResponse? verifyOTP_ModelResponse;
  final EmployeeBankAccountVerifyModelClass? bankAccountDetailsObj;


  @override
  _TEC_BankInfoVerifyDetails createState() => _TEC_BankInfoVerifyDetails();

}

class _TEC_BankInfoVerifyDetails extends State<TEC_BankInfoVerifyDetails>{


  String empName="",bankName="",branchName="",cityName="",amount="";

  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();

    empName=widget.bankAccountDetailsObj!.fullname!;
    bankName=widget.bankAccountDetailsObj!.bankname!;
    branchName=widget.bankAccountDetailsObj!.bankbranch!;
    cityName="";


  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: getResponsiveUI(),
        bottomNavigationBar: Padding(padding: EdgeInsets.only(left: 80,right: 80),
          child: elevatedButtonBottomBar(),)

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
            card("Name On Bank Account", empName),
            SizedBox(
              height: 12,
            ),
            card("Bank Name", bankName),
            SizedBox(
              height: 12,
            ),
            card("Branch", branchName),
            SizedBox(
              height: 12,
            ),
            card("City", cityName),
            SizedBox(
              height: 12,
            ),
            card("Amount", "Rs. 1"),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Well Done, ${getEmpNameBehalfOfBank(empName)}",
                  style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: robotoFontFamily),),
                SizedBox(
                  width: 5,
                ),
                /* ImageIcon(
                  AssetImage(congratulations_Icon),
                  //color: Color(0xffDBDBDB),
                  size: 25,
                ),*/
                Container(child: Image.asset(congratulations_Icon))

              ],
            ),
            SizedBox(
              height: 6,
            ),
            Center(
              child: Column(
                children: [
                  Text("Your bank account has been successfully setup.",style: TextStyle(color: Colors.black),),
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
    return CJElevatedBlueButton("Proceed", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");


      TalentNavigation().pushTo(context, TEC_JoiningProfileDashboard(verifyOTP_ModelResponse: widget.verifyOTP_ModelResponse,));
//
    }
    )) ;

  }

}
