import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/Talent_SignUp/Talent_KYCDetails.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/DropDownHint/DropdownHintViewMethod.dart';
import 'package:contractjobs/CustomView/NavigationView/NavigationView.dart';
import 'package:contractjobs/CustomView/TextField/TextFieldDecoration.dart';
import 'package:contractjobs/CustomView/TextField/TextFieldHeadingText.dart';
import 'package:contractjobs/CustomView/TextField/TextMethod.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../CustomView/CustomRow/AstricRow.dart';

class Talent_UserProfile extends StatefulWidget {

  const Talent_UserProfile({Key? key}) : super(key: key);


  @override
  State<Talent_UserProfile> createState() => _Talent_UserProfile();
}

class _Talent_UserProfile extends State<Talent_UserProfile> {
  // List of items in our dropdown menu
  var items1 = [
    'Accountant',
    'Developer',
    'Manager',
    'HR',
    'CA',
  ];

  var items2 = [
    'Finanace',
    'Human Resource',
    'IT',
    'Banking',
    'Civil',
  ];

  var years = [
    '1 year',
    '2 year',
    '3 year',
    '4 year',
    '5 year',
    '6 year',
    '7 year',
    '8 year',
    '9 year',
    '10 year',
    '11 year',
    '12 year',
  ];

  var months = [
    '1 month',
    '2 month',
    '3 month',
    '4 month',
    '5 month',
    '6 month',
    '7 month',
    '8 month',
    '9 month',
    '10 month',
    '11 month',
  ];

  var salary = [
    "0 - 10000",
    "10000 - 20000",
    "20000 - 40000",
    "40000 - 60000",
    "60000 - 80000",
    "80000 - 100000",
    "100000 - 120000",
  ];

  String statevalue = 'New Delhi';
  List<String> state = [
    'New Delhi',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  String cityvalue = 'New Delhi';
  List<String> city = [
    'New Delhi',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(

      appBar: CJAppBar(getTalent_ProfileTitle, appBarBlock: AppBarBlock(appBarAction: ()
        {
        print("show the action type");
        Navigator.pop(context);

        })),

      backgroundColor: Colors.white,
      body:getResponsiveUI(context),
        bottomNavigationBar: elevatedButtonBottomBar()

    );
  }
  Responsive getResponsiveUI(BuildContext context)
  {
    return Responsive(
      mobile: MainfunctionUi(context),
      tablet: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(context),
        ),
      ),
      desktop: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(context),
        ),
      ),
    );
  }

  SingleChildScrollView MainfunctionUi(BuildContext context)
  {

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: mainUILeftRightPadding, right: mainUILeftRightPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Center(child:getViewHintTextBlue(getTalent_ProfileHint),),
            SizedBox(height: 35,),
            getAstricRow(getTalentH_ProfileName),
            SizedBox(height: spacingBetween_TextFieldandTextHeading,),
            TextField(
              decoration:getTextFieldDecorationWithPrefixIcon("usericon.png", "Enter Full Name"),
              onChanged: (value)
              {

              },
            ) ,
            SizedBox(height: 25,),
            getAstricRow(getTalentH_ProfileJob),
            SizedBox(height: spacingBetween_TextFieldandTextHeading,),
            DropdownButtonFormField(
              isExpanded: true,
              menuMaxHeight: 200,
              hint:getDropDownHintViewMethod("Choose Job Role"),
              items: items1.map((String items)
              {
                return DropdownMenuItem(child: Text(items), value: items);
              }).toList(),
              onChanged: (value)
              {
                FocusScope.of(context).requestFocus(FocusNode());

              },
              decoration:getTextFieldDecorationWithPrefixIcon("account.png",""),

            ),
            SizedBox(height: 15,),
            getAstricRow(getTalentH_ProfileSubJob),
            SizedBox(height: spacingBetween_TextFieldandTextHeading,),
            DropdownButtonFormField(isExpanded: true, menuMaxHeight: 200,
              hint:getDropDownHintViewMethod("Choose Sub Role"),
              items: items2.map((String items)
              {
                return DropdownMenuItem(child: Text(items), value: items);
              }).toList(),
              onChanged: (value)
              {
                FocusScope.of(context).requestFocus(FocusNode());

              },
              decoration:getTextFieldDecorationWithPrefixIcon("department.png",""),
            ),
            SizedBox(height: 25,),
            getAstricRow(getTalentH_ProfileExperience),
            SizedBox(height: spacingBetween_TextFieldandTextHeading,),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    menuMaxHeight: 200,
                    hint:getDropDownHintViewMethod("Years"),
                    items: years.map((String items) {
                      return DropdownMenuItem(
                          child: Text(items), value: items);
                    }).toList(),
                    onChanged: (value)
                    {
                      FocusScope.of(context).requestFocus(FocusNode());

                    },
                    decoration:getTextFieldDecorationWithPrefixIcon("calendar.png",""),

                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    menuMaxHeight: 200,
                    hint:getDropDownHintViewMethod("Months"),
                    items: months.map((String items) {
                      return DropdownMenuItem(
                          child: Text(items), value: items);
                    }).toList(),
                    onChanged: (value)
                    {
                      FocusScope.of(context).requestFocus(FocusNode());

                    },
                    decoration:getTextFieldDecorationWithPrefixIcon("calendar.png",""),

                  ),
                ),
              ],
            ),
            SizedBox(height: 25,),
            getAstricRow(getTalentH_ProfileIncome),
            SizedBox(height: spacingBetween_TextFieldandTextHeading,),
            DropdownButtonFormField(
              isExpanded: true,
              menuMaxHeight: 200,
              hint:getDropDownHintViewMethod("Select Your Monthly Income"),
              items: salary.map((String items)
              {
                return DropdownMenuItem(child: Text(items), value: items);
              }).toList(),
              onChanged: (value)
              {
                FocusScope.of(context).requestFocus(FocusNode());

              },
              decoration:getTextFieldDecorationWithPrefixIcon("rupee.png",""),
            ),
            SizedBox(height: 20,),


            /*--------------------*/

            getAstricRow(getTalentH_ProfileAddress),
            SizedBox(height: 7),
            Container(
              //padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: TextField(
                  maxLines: 2,
                  cursorColor: darkGreyColor,
                  style: TextStyle(),

                  decoration: getTextFieldDecorationWithPrefixIcon(locationGrey_Icon,"13 Community Centre, Yusuf Sarai, New Delhi, Delhi 110049"),

                )),
            SizedBox(height: 20),
            getAstricRow(getTalentH_ProfileState),
            SizedBox(height: 7),
            Container(
              child:
              dropdownbutton('New Delhi', locationGrey_Icon, statevalue, state),
            ),
            SizedBox(height: 20),
            getAstricRow(getTalentH_ProfileCity),
            SizedBox(height: 7),
            Container(
              child: dropdownbutton('New Delhi', locationGrey_Icon, cityvalue, city),
            ),

            /*---------------------*/
            SizedBox(height: 20),

            getAstricRow(getTalentH_ProfilePinCode),
            SizedBox(height: 7),
            Container(
              //padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: TextField(
                  //cursorColor: mediumDarkGreyCol,
                  style: TextStyle(),
                  decoration: getTextFieldDecorationWithPrefixIcon(locationGrey_Icon,"110049"),

                )),

          ],
        ),
      ),
    );
  }
  dropdownbutton(String text, String icon, String val, List list) {
    return DropdownButtonFormField2(
      value: val,
      isExpanded: true,
      dropdownWidth: kIsWeb==true?webResponsive_TD_Width-40:MediaQuery.of(context).size.width-50,
      dropdownMaxHeight: 200,
      scrollbarRadius: const Radius.circular(40),
      scrollbarThickness: 6,
      scrollbarAlwaysShow: true,
      offset: Offset(-40, -15),
      decoration: decorationimage(text, icon),

      buttonPadding: const EdgeInsets.only(left: 18, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: list
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
              fontFamily: robotoFontFamily,
              color: darkGreyColor,
              fontSize: large_FontSize,
              fontWeight: normal_FontWeight),
        ),
      ))
          .toList(),
      onChanged: (value)
      {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onSaved: (value) {
        //selectedValue = value!;
      },
    );
  }

  InputDecoration decorationimage(String hintimage, String Icon)
  {
    return InputDecoration(
      hintText: hintimage,
      hintStyle: TextStyle(
          color: darkGreyColor,
          fontSize: large_FontSize,
          fontWeight: normal_FontWeight,
          fontFamily: robotoFontFamily),
      prefixIcon: Iconimg(Icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }

  Container Iconimg(String icon) {
    return Container(
      //padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
      margin: EdgeInsets.fromLTRB(11, 11, 11, 11),
      height: 5.0,
      width: 5.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(icon,),
        ),
      ),
    );
  }

  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Continue", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");
      TalentNavigation().pushTo(context, Talent_KYCDetails());
    }
    )) ;

  }
}
