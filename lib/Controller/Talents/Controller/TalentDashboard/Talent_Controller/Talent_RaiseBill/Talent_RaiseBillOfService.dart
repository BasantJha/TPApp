
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_RaiseBill/Talent_RaiseBillChooseEmployer.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_RaiseBill/Talent_RaiseBillInvoice.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:contractjobs/CustomView/TextField/TextFieldDecoration.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';


  class Talent_RaiseBillOfService extends StatefulWidget
  {

  const Talent_RaiseBillOfService({Key? key}) : super(key: key);

  @override
  State<Talent_RaiseBillOfService> createState() => _Talent_RaiseBillOfService();

  }

  class _Talent_RaiseBillOfService extends State<Talent_RaiseBillOfService>
  {

  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner:false,

      home: Scaffold(
        appBar:CJAppBar(getTalent_RaiseABillTitle, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),
        body: getResponsiveUI(),
          bottomNavigationBar: elevatedButtonBottomBar()

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
  Container MainfunctionUi(){

    return Container(height: MediaQuery.of(context).size.height,color: whiteColor,child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Center(child:getViewHintTextBlue(getTalent_Passbook_GenerateBosHint),),
            Center(child:getViewHintTextBlack(getTalent_Passbook_GenerateBillOfServiceHint),),

            SizedBox(height: 30),
            getAstricRow('Employer Name'),
            SizedBox(height: spacingBetween_TextFieldandTextHeading),
            Container(
                child:TextField(
                  cursorColor: Colors.grey,
                  style: geTextStyle,
                  //decoration: getTextFieldDecorationWithSuffixIcon(Talent_Icon_Passbook_RiseBill,'Enter Employer Name',context),

                )
            ),
            SizedBox(height: 20),
            getAstricRow('Mobile Number'),
            SizedBox(height: spacingBetween_TextFieldandTextHeading),
            Container(
                child:TextField(
                  cursorColor: Colors.grey,
                  style: geTextStyle,
                  decoration: getTextFieldDecoration('Enter Employer Mobile Number'),
                )
            ),
            SizedBox(height: 20),
            getAstricRow('Amount to be Received'),
            SizedBox(height: spacingBetween_TextFieldandTextHeading),
            Container(
                child:TextField(
                  cursorColor: Colors.grey,
                  style: geTextStyle,
                  decoration: getTextFieldDecoration('Enter Amount'),
                )
            ),
            SizedBox(height: 20),
            getAstricRow('Purpose'),
            SizedBox(height: spacingBetween_TextFieldandTextHeading),
            Container(
                child:TextField(
                  cursorColor: Colors.grey,
                  style:geTextStyle ,
                  decoration: getTextFieldDecoration('Enter Purpose'),
                )
            ),
            // Expanded(

          ],
        ),
      )
    ),);

  }


  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Generate BOS", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");

      TalentNavigation().pushTo(context, Talent_RaiseBillInvoice());

    }
    )) ;

  }

}


var geTextStyle=TextStyle(
  color: blackColor,
);





