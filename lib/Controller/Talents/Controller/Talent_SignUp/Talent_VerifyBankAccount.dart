import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/Talent_SignUp/Talent_VerifyBankAccountDetails.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:contractjobs/CustomView/NavigationView/NavigationView.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Talent_VerifyBankAccount extends StatefulWidget
{
  const Talent_VerifyBankAccount({Key? key}) : super(key: key);

  @override
  State<Talent_VerifyBankAccount> createState() => _VerifyAccountItemState();

}

class _VerifyAccountItemState extends State<Talent_VerifyBankAccount> {
  final formGlobalKey = GlobalKey < FormState > ();

  @override
  Widget build(BuildContext context)
  {
    return(
        Scaffold(
          backgroundColor: Colors.white,
          appBar: CJAppBar(getTalent_VerifyYourBankAccountTitle, appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show the action type");
            Navigator.pop(context);
          })),

            body: getResponsiveUI(),
            bottomNavigationBar: elevatedButtonBottomBar()

        )
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
  Container  MainfunctionUi()
    {
      return Container(
          child: SingleChildScrollView(child: Padding(padding: EdgeInsets.only(left:mainUILeftRightPadding,right: mainUILeftRightPadding ),
            child:Column(
              children: <Widget>[

                SizedBox(height: 5,),
                Center(child:getViewHintTextBlue(getTalent_VerifyBankDetailsHint),),
                SizedBox(height: 35,),

                getAstricRow("Account Number"),
                SizedBox(height: spacingBetween_TextFieldandTextHeading),
                Column(
                  children: [
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (value) {
                        //Validator
                      },
                      validator: (value){
                        if (value!.isEmpty)
                        {
                          return 'Enter a valid Account Number!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        // prefixIcon: Icon(Icons.ac_unit),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                getAstricRow("IFSC"),
                SizedBox(height: spacingBetween_TextFieldandTextHeading),
                Container(
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      //Validator
                    },
                    validator: (value){
                      if (value!.isEmpty) {
                        return 'Enter a valid IFSC Code!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      // prefixIcon: Icon(Icons.ac_unit),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                getAstricRow("Account Holder Name"),
                SizedBox(height: spacingBetween_TextFieldandTextHeading),
                Container(
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      //Validator
                    },
                    validator: (value){
                      if (value!.isEmpty) {
                        return 'Enter a valid Account Holder Name!';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[A-Za-z ]")),
                    ],
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      // prefixIcon: Icon(Icons.ac_unit),
                    ),
                  ),
                ),
                SizedBox(height: 30),

              ],
            ) ,),),

        );

      //);
    }

  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Verify", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");

      TalentNavigation().pushTo(context, Talent_VerifyBankAccountDetails());

    }
    )) ;

  }

  void _submit()
  {
    final isValid = formGlobalKey.currentState!.validate();
    if (!isValid)
    {
      return;
    }
    formGlobalKey.currentState!.save();
  }
}