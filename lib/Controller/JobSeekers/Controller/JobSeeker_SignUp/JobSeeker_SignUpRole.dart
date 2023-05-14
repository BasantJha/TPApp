import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeeker_SignUp/JobSeeker_SignUpEmailId.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:contractjobs/CustomView/TextField/TextFieldDecoration.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JobSeeker_SignUpRole extends StatefulWidget
{
  const JobSeeker_SignUpRole({Key});

  @override
  State<JobSeeker_SignUpRole> createState() => _JobSeeker_SignUpRole();
}

class _JobSeeker_SignUpRole extends State<JobSeeker_SignUpRole> {


  static const mediumDarkGreyColor = Color(0xff636363);

  String jobroledropdownvalue = 'Accountant';
  List<String> jobrole = [
    'Accountant',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  String subroledropdownvalue = 'Finance';
  List<String> subrole = [
    'Finance',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  late String selectedValue;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar:CJAppBar(getJobSeeker_SignUpTitle, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),
      body: getResponsiveUI(),
      bottomNavigationBar:elevatedButtonWithDotBottomBar(),
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
  SingleChildScrollView MainfunctionUi()
  {
    return SingleChildScrollView(
      child: Container(color: whiteColor,
        height: 700,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child:getViewHintTextBlue(getJobSeeker_SignUpRoleTypeHint),),

            SizedBox(height: 45),
            getAstricRow("What is your name?"),
            SizedBox(height: 7),
            Container(
                child: TextField(
                  cursorColor: mediumDarkGreyColor,
                  style: TextStyle(),
                  decoration: getTextFieldDecorationWithPrefixIcon(user_Icon,"Navin"),
                )),
            SizedBox(height: 20),
            getAstricRow("Select Job Role"),
            SizedBox(height: 7),
            Container(
              child: dropDownButton(
                  'Accountant',
                  role_Icon,
                  jobroledropdownvalue,
                  jobrole),
            ),
            SizedBox(height: 20),
            getAstricRow("Select Sub Role"),
            SizedBox(height: 7),
            Container(
              child: dropDownButton('Finance', subRole_Icon, subroledropdownvalue, subrole),
            ),
          ],
        ),
      ),
    );
  }

  dropDownButton(String text, String icon, String jobroleval, List list)
  {
    return DropdownButtonFormField2(
      isExpanded: true,
      value: jobroleval,
      dropdownWidth: webResponsive_TD_Width-40,
      dropdownMaxHeight: 200,
      scrollbarRadius: const Radius.circular(40),
      scrollbarThickness: 6,
      scrollbarAlwaysShow: true,
      offset: Offset(-45, -16),
      decoration: getTextFieldDecorationWithPrefixIcon(icon,text),
     // buttonPadding: const EdgeInsets.only(left: 18, right: 10),
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
      onChanged: (value)
      {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onSaved: (value)
      {
        selectedValue = value.toString();
      },
    );
  }


  Container elevatedButtonWithDotBottomBar()
  {
    return CJElevatedBlueButtonWithDotJobSeeker("Next >>", 1,elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action 1");

      TalentNavigation().pushTo(context, JobSeeker_SignUpEmailId());

    }
    )) ;

  }
}

