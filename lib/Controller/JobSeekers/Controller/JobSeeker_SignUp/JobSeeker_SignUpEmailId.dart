import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeeker_SignUp/JobSeeker_SignUpWorkExperience.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:contractjobs/CustomView/TextField/TextFieldDecoration.dart';
import 'package:contractjobs/CustomView/TextField/TextMethod.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class JobSeeker_SignUpEmailId extends StatefulWidget {
 // const seeker2({Key key}) : super(key: key);

  @override
  State<JobSeeker_SignUpEmailId> createState() => _JobSeeker_SignUpEmailId();
}

class _JobSeeker_SignUpEmailId extends State<JobSeeker_SignUpEmailId>
{

  static const mediumDarkGreyColor = Color(0xff636363);


  String statevalue = 'New Delhi';
  List<String> state = [
    'New Delhi',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  String districtvalue = 'New Delhi';
  List<String> district = [
    'New Delhi',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  String selectedValue="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CJAppBar(getJobSeeker_SignUpTitle, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),
      body: getResponsiveUI(),
      bottomSheet: elevatedButtonWithDotBottomBar(),
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
  SingleChildScrollView MainfunctionUi() {
    return SingleChildScrollView(
      child: Container(color: whiteColor,
        height: 700,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child:getViewHintTextBlue(getJobSeeker_SignUpRoleTypeHint),),
            SizedBox(height: 45),
            getAstricRow("Email Id"),
            SizedBox(height: 7),
            Container(
              //padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: TextField(
                  cursorColor: mediumDarkGreyColor,
                  style: TextStyle(
                  ),
                  decoration: getTextFieldDecorationWithPrefixIcon(emailGrey_Icon,"navin.yadav@akalinfosys.com"),
                )),

            SizedBox(height: 20),
            getAstricRow("State"),
            SizedBox(height: 7),
            Container(
              child: dropDownButton('Accountant', locationGrey_Icon,
                  statevalue, state),
            ),
            SizedBox(height: 20),

            getAstricRow("District"),
            SizedBox(height: 7),
            Container(
              child: dropDownButton('Finance', locationGrey_Icon,
                  districtvalue, district),
            ),
            SizedBox(height: 20),

            getAstricRow("Pincode"),
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


  dropDownButton(String text, String icon, String val, List list) {
    return DropdownButtonFormField2(
      value: val,
      isExpanded: true,
      dropdownWidth:webResponsive_TD_Width-35,
      dropdownMaxHeight: 200,
      scrollbarRadius: const Radius.circular(40),
      scrollbarThickness: 6,
      scrollbarAlwaysShow: true,
      offset: Offset(-45, -15),
      decoration: getTextFieldDecorationWithPrefixIcon(icon,text),
      //buttonPadding: const EdgeInsets.only(left: 18, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: list
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
              fontFamily: viewHeadingFontfamily,
              color: mediumDarkGreyColor,
              fontSize: large_FontSize,
              fontWeight: normal_FontWeight),
        ),
      ))
          .toList(),
      onChanged: (value) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onSaved: (value)
      {
        selectedValue = value!;
      },
    );
  }
  Container elevatedButtonWithDotBottomBar()
  {
    return CJElevatedBlueButtonWithDotJobSeeker("Next >>", 2,elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action 1");

      TalentNavigation().pushTo(context, JobSeeker_SignUpWorkExperience());

    }
    )) ;

  }

}

