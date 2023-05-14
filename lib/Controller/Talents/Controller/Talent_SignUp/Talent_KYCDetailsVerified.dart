import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/Talent_SignUp/Talent_VerifyBankAccount.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';

class Talent_KYCDetailsVerified extends StatefulWidget
{

  const Talent_KYCDetailsVerified({Key? key}) : super(key: key);

  @override
  _Talent_KYCDetailsVerified createState() => _Talent_KYCDetailsVerified();

}

class _Talent_KYCDetailsVerified extends State<Talent_KYCDetailsVerified> {

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
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
  Container MainfunctionUi()
 {
  return Container( color: whiteColor,height:MediaQuery.of(context).size.height,
     child: SingleChildScrollView(child: Column(
       children: [
         SizedBox(height: 40),

         Center(child:getViewHintTextBlue(getTalent_KYCDetailsVerifiedHint),),

         SizedBox(height: 30),
         Text('Your identity has been\nverified',textAlign: TextAlign.center,
           style: TextStyle(fontWeight: FontWeight.normal,
             fontSize: 14,color: blackColor,
             fontFamily: viewHeadingFontfamily,

             //fontWeight: bold_FontWeight,
           ),
         ),
         Container(
           margin: EdgeInsets.all(30),
           height: 150,
           width: 150,
           child:Image.asset(Talent_SP_GIF) /*Image.network('https://tenor.com/view/verified-verified-instagram-verified-blue-gif-26305004.gif')*/,
         ),
         Container(
           //width:500,
           margin: EdgeInsets.all(30),
           child: Center(
             child: Column(
               // mainAxisAlignment: MainAxisAlignment.center,
               // crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Text('Verifying your bank account details ensures that the correct information is available to us to process payments.',textAlign: TextAlign.center,
                   style: TextStyle(fontFamily: robotoFontFamily,
                     fontSize: 12,
                   ),
                 ),
               ],
             ),
           ),
         ),


       ],
     ),),
   );
 }

  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Enter Bank Details", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");

      TalentNavigation().pushTo(context, Talent_VerifyBankAccount());
    }
    ));
  }



}
