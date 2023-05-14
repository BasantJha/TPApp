import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Employers/Controller/Employer_SignUp/Employer_Business_SignUpKYC.dart';
import 'package:contractjobs/Controller/Employers/Controller/Employer_SignUp/Employer_SignUpKYC.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:contractjobs/CustomView/TextField/TextFieldDecoration.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'Employer_Congratulations.dart';

class Employer_SignUpInfo extends StatefulWidget
{
  const Employer_SignUpInfo({Key? key}) : super(key: key);

  @override
  State<Employer_SignUpInfo> createState() => _Employer_SignUpInfo();
}

class _Employer_SignUpInfo extends State<Employer_SignUpInfo>
{

  static const regularFontWeight = FontWeight.w400;
  static const mediumDarkGreyColor = Color(0xff636363);


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

  late String selectedValue;
  var selectRegistrationType;
  bool companyName_Visibility=false;
  bool companyWebsite_Visibility=false;

  _Employer_SignUpInfo()
  {
    //this.selectRegistrationType=selectedRegistrationType;

   // print("show the selected status $selectedRegistrationType");
    if(selectRegistrationType==kEmployerRegistrationType_Business)
      {
        //use for business
        companyName_Visibility=true;
        companyWebsite_Visibility=true;

      }else
        {
          //use for home
          companyName_Visibility=false;
          companyWebsite_Visibility=false;
        }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor: whiteColor,
      appBar:CJAppBar(getEmployer_SignUpTitle, appBarBlock: AppBarBlock(appBarAction: ()
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

  SingleChildScrollView MainfunctionUi()
  {
    return SingleChildScrollView(
      child: Container(
        height: 790,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child:getViewHintTextBlue(getEmployer_SignUpHomeHint),),

            Visibility(visible: companyName_Visibility,child:SizedBox(height: 20),),
            Visibility(visible: companyName_Visibility,child: getAstricRow("Company Name"),),
            Visibility(visible: companyName_Visibility,child:SizedBox(height: 7),),
            Visibility(visible: companyName_Visibility,child:Container(
              //padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: TextField(
                  cursorColor: mediumDarkGreyColor,
                  style: TextStyle(),
                  decoration: getTextFieldDecorationWithPrefixIcon(Employer_Icon_CompanyIcon,"Akal Information Systems Ltd."),

                )),),

            SizedBox(height: 20),

            getAstricRow("Address Line"),
            SizedBox(height: 7),
            Container(
              //padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: TextField(
                  maxLines: 2,
                  cursorColor: mediumDarkGreyColor,
                  style: TextStyle(),

                  decoration: getTextFieldDecorationWithPrefixIcon(locationGrey_Icon,"13 Community Centre, Yusuf Sarai, New Delhi, Delhi 110049"),

                )),
            SizedBox(height: 20),
            getAstricRow("State"),
            SizedBox(height: 7),
            Container(
              child:
              dropdownbutton('New Delhi', locationGrey_Icon, statevalue, state),
            ),
            SizedBox(height: 20),
            getAstricRow("City"),
            SizedBox(height: 7),
            Container(
              child: dropdownbutton('New Delhi', locationGrey_Icon, cityvalue, city),
            ),

            SizedBox(height: 20),
            getAstricRow("Pincode"),
            SizedBox(height: 7),
            Container(
              //padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: TextField(
                  cursorColor: mediumDarkGreyColor,
                  style: TextStyle(),
                  decoration: getTextFieldDecorationWithPrefixIcon(locationGrey_Icon,"110049"),

                )),

            Visibility(visible: companyWebsite_Visibility,child:SizedBox(height: 20),),
            Visibility(visible: companyWebsite_Visibility,child:getAstricRow("Company Website"),),
            Visibility(visible: companyWebsite_Visibility,child:SizedBox(height: 7),),
            Visibility(visible: companyWebsite_Visibility,child:Container(
                child: TextField(
                  cursorColor: mediumDarkGreyColor,
                  style: TextStyle(),
                  /*decoration: decoration('anshu@akalinfosys.com',
                                        Employer_Icon_EmailGrey),*/
                  decoration: getTextFieldDecorationWithPrefixIcon(Employer_Icon_WebsiteGrey,"www.akalinfosys.com"),

                )),)
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
              color: mediumDarkGreyColor,
              fontSize: large_FontSize,
              fontWeight: regularFontWeight),
        ),
      ))
          .toList(),
      onChanged: (value)
      {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onSaved: (value) {
        selectedValue = value!;
      },
    );
  }

  InputDecoration decorationimage(String hintimage, String Icon)
  {
    return InputDecoration(
      hintText: hintimage,
      hintStyle: TextStyle(
          color: mediumDarkGreyColor,
          fontSize: large_FontSize,
          fontWeight: regularFontWeight,
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


  Container elevatedButtonWithDotBottomBar()
  {
    return CJElevatedBlueButtonWithDotJobSeeker("Next >>", 2,elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action 11");

      if(this.selectRegistrationType==kEmployerRegistrationType_Business)
      {
        //use for business
        //Employer_Business_SignUpKYC
        //TalentNavigation().pushTo(context, Employer_Business_SignUpKYC(selectRegistrationType: selectRegistrationType,));

        TalentNavigation().pushTo(context, Employer_Congratulations());

      }else
      {
        //use for home
        //TalentNavigation().pushTo(context, Employer_SignUpKYC(selectRegistrationType: selectRegistrationType,));


      }

    }
    )) ;

  }
}

