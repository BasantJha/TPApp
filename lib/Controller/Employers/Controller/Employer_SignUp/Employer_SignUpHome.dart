import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Employers/Controller/Employer_SignUp/Employer_SignUpInfo.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../CustomView/TextField/TextFieldDecoration.dart';

class Employer_SignUpHome extends StatefulWidget
{
  const Employer_SignUpHome({Key? key}) : super(key: key);

  @override
  State<Employer_SignUpHome> createState() => _Employer_SignUpHome();
}

class _Employer_SignUpHome extends State<Employer_SignUpHome> with TickerProviderStateMixin
{

  static const lightBlueColor = Color(0xff33B8FD);
  static const mediumDarkGreyColor = Color(0xff636363);
  static const darkGreyColor = Color(0xff434343);

  PageController _controller = PageController();
  late TabController tabController;

  /*-------------22-11-2022(tab code comment here)-------------*/

  //  var selectRegistrationType=0;
  //var checkRegistrationTypeVisibility=false;
        var checkRegistrationTypeVisibility=true;
        var selectRegistrationType=1;



  /*-------------22-11-2022(tab code comment here)-------------*/


  String selectEmployerType = 'Company';
  List<String> employerTypeList = [
    'Company',
    'Shop',
    'e-commerce',
    'Factory',
  ];
  @override
  void initState()
  {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(()
    {
      print("show the selected index ${tabController.index}");

      /*-------------22-11-2022(tab code comment here)-------------*/

     /* if(tabController.index==kEmployerRegistrationType_Business)
        {
          //use for the business
          selectRegistrationType=tabController.index;

          setState(() {
            checkRegistrationTypeVisibility=true;

          });


        }
       else
        {
          //use for the home
          selectRegistrationType=tabController.index;

          setState(() {
            checkRegistrationTypeVisibility=false;

          });


        }

*/

      /*-------------22-11-2022(tab code comment here)-------------*/

    });

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

  SafeArea MainfunctionUi()
  {
    return SafeArea(
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Column(children: [
                Center(child:getViewHintTextBlue(getEmployer_SignUpHomeHint),),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*-------------22-11-2022(tab code comment here)-------------*/
                      /*  SizedBox(height: 50),

                        getAstricRow("User"),
                      SizedBox(height: 7),

                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          //color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: Colors.grey
                              //color: Projectconst.darkGreyColor
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TabBar(
                            controller: tabController,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: lightBlueColor,
                            ),
                            labelColor: whiteColor,
                            unselectedLabelColor: darkGreyColor,
                            tabs: [
                              Text(
                                "Home",
                                style: TextStyle(
                                    fontSize: large_FontSize,
                                    fontFamily: robotoFontFamily,
                                    fontWeight: normal_FontWeight),
                              ),
                              Text(
                                "Business",
                                style: TextStyle(
                                    fontSize: large_FontSize,
                                    fontFamily: robotoFontFamily,
                                    fontWeight: normal_FontWeight),
                              ),
                            ],
                          ),
                        ),
                      ),
*/

                      /*-------------22-11-2022(tab code comment here)-------------*/

                    ],
                  ),
                ),
                SizedBox(
                    height: 400,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Container(
                          //height: 600,
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Visibility(visible: checkRegistrationTypeVisibility,child: SizedBox(height: 40)),
                              Visibility(visible: checkRegistrationTypeVisibility,child:getAstricRow("Employer Type")),
                              Visibility(visible: checkRegistrationTypeVisibility,child:SizedBox(height: 7)),
                              Visibility(visible: checkRegistrationTypeVisibility,child:Container(
                                child: dropDownButton('Select Employer Type', Employer_Icon_SelectEmployerType, selectEmployerType, employerTypeList),
                              )),


                           Visibility(visible: !checkRegistrationTypeVisibility,child:SizedBox(height: 20)),
                              SizedBox(height: 20),
                              getAstricRow("Name"),

                              SizedBox(height: 7),
                              Container(
                                  child: TextField(
                                    cursorColor: mediumDarkGreyColor,
                                    style: TextStyle(),

                                    decoration: getTextFieldDecorationWithPrefixIcon(user_Icon,"Enter Full Name"),

                                  )),
                              SizedBox(height: 20),
                              getAstricRow("Email ID"),
                              SizedBox(height: 7),
                              Container(
                                  child: TextField(
                                    cursorColor: mediumDarkGreyColor,
                                    style: TextStyle(),
                                    decoration: getTextFieldDecorationWithPrefixIcon(emailGrey_Icon,"Enter Email ID"),

                                  )),
                            ],
                          ),
                        ),
                       /* Container(
                          //height: 600,
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 50),
                              getAstricRow("Name"),

                              SizedBox(height: 7),
                              Container(
                                  child: TextField(
                                    cursorColor: mediumDarkGreyColor,
                                    style: TextStyle(),
                                    decoration: getTextFieldDecorationWithPrefixIcon(user_Icon,"Navin"),

                                  )),
                              SizedBox(height: 20),
                              getAstricRow("Email Id"),

                              SizedBox(height: 7),
                              Container(
                                  child: TextField(
                                    cursorColor: mediumDarkGreyColor,
                                    style: TextStyle(),
                                  *//*  decoration: decoration('anshu@akalinfosys.com',
                                        Employer_Icon_EmailGrey),*//*
                                    decoration: getTextFieldDecorationWithPrefixIcon(emailGrey_Icon,"navin.yadav@akalinfosys.com"),

                                  )),
                            ],
                          ),
                        ),*/
                      ],
                    ))
              ]),
            )));
  }
  dropDownButton(String text, String icon, String jobroleval, List list)
  {
    return DropdownButtonFormField2(
      isExpanded: true,
      value: jobroleval,
      dropdownWidth: kIsWeb==true?webResponsive_TD_Width-40:MediaQuery.of(context).size.width-50,
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
        //selectedValue = value.toString();
      },
    );
  }

  Container elevatedButtonWithDotBottomBar()
  {
    return CJElevatedBlueButtonWithDotJobSeeker("Next >>", 1,elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action 1");

      TalentNavigation().pushTo(context, Employer_SignUpInfo());

    }
    )) ;

  }

}

