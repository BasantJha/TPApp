
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeeker_SignUp/JobSeeker_SignUpDetailsVerify.dart';
import 'package:contractjobs/Controller/Talents/Controller/Talent_SignUp/Talent_VerifyBankAccount.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/CustomRow/AstricRow.dart';
import 'package:contractjobs/CustomView/TextField/TextFieldDecoration.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class  JobSeeker_SignUpWorkExperience extends StatefulWidget
{
 // const JobSeeker_SignUpWorkExperience({key});

  @override
  State<JobSeeker_SignUpWorkExperience> createState() => _JobSeeker_SignUpWorkExperience();
}

class _JobSeeker_SignUpWorkExperience extends State<JobSeeker_SignUpWorkExperience> {

  PageController _controller = PageController();

  List<String> items = ['item 1','item 2', 'item 3'];
  String selectedItem= 'item 1';

  List<String> year = ['2019','2020','2021','2022'];
  String selectedYear = '2020';

  List<String> month = ['September','January','October','March'];
  String selectedmonth = 'January';

  List<String> education = ['Bachelor','B.Tech'];
  String selectededu = 'Bachelor';

  List<String> specialization = ['B.Sc','B.Tech','MBA'];
  String selectedspec = 'MBA';



  @override
  Widget build(BuildContext context) {

    return  Scaffold(
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
  SingleChildScrollView MainfunctionUi()
  {
    return SingleChildScrollView(
        child:Container(height: 700,color: whiteColor,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            children: [
              Center(child:getViewHintTextBlue(getJobSeeker_SignUpRoleTypeHint),),
              SizedBox( height: 45,),

              getAstricRow("Work Experience"),

              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child:month_yeardropdown('Year',subRole_Icon, year, selectedYear),

                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child:month_yeardropdown('Month',subRole_Icon, month, selectedmonth),

                  ),
                ],
              ),
              SizedBox(height: 20),

              getAstricRow("Education"),

              SizedBox(height: 8),
              Container(
                child:dropDownButton('Choose Your Education',capGrey_Icon, education, selectededu),
              ),
              SizedBox(height: 15),

              getAstricRow("Specialization"),

              SizedBox(height: 8),
              Container(
                child:dropDownButton('Choose Your Specialization',capGrey_Icon,specialization , selectedspec),
              ),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular(28.0),
                        side: BorderSide(
                          // width: 10,
                            color: Colors.grey
                        )
                    )
                ),
                child: Column(
                    children: [
                      SizedBox(height: 25,),
                      IconButton(
                        icon: new Icon(Icons.cloud_upload_outlined,size: 40.0),
                        color: Colors.grey,
                        onPressed: ()
                        {
                         /* final act = CupertinoActionSheet(
                            // title: Text('Select Option'),
                            // message: Text('Which option?'),
                              actions: <Widget>[
                                CupertinoActionSheetAction(
                                  child:Icon(Icons.add_a_photo,
                                    size: 24.0,
                                  ),
                                  // child: Text('1'),
                                  onPressed: ()
                                  {
                                    print('pressed');
                                  },
                                )
                              ],
                              cancelButton: CupertinoActionSheetAction(
                                child:Icon(Icons.account_balance_wallet_rounded,
                                  size: 24.0,
                                ),
                                // child: Text('Cancel'),
                                onPressed: () {
                                  print('pressed');
                                  // Navigator.pop(context);
                                },
                              ));
                          showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) => act);*/
                        },
                      ),
                      Text(
                        'Upload Your Resume',
                        style: TextStyle(
                          color: textFieldHintTextColor, fontSize: textFieldHeadingFontWeight, fontFamily: viewHeadingFontfamily, fontWeight: textFieldFontWeightType,),
                      ),
                    ]
                ),
              ),
            ],
          ),
        )
    );

  }


  month_yeardropdown(String text, String icon, List year_month, String selectedVal){
    return DropdownButtonFormField2(
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        dropdownWidth: webResponsive_TD_Width/2-17,
        dropdownMaxHeight: 200,
        isExpanded: true,
        offset: Offset(-42, -15),

        //offset: Offset(-42, -15),
        // offset: Offset(16,-15),
        decoration: getTextFieldDecorationWithPrefixIcon(icon,text),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        // value: selectedItem,
        items: year_month.map((year_month)=> DropdownMenuItem(
            value: year_month,
            child: Text(year_month,style: TextStyle(color: blackColor,fontSize: textFieldHeadingFontWeight),)
        )).toList(),
        // onChanged: (items)=> setState(()=>selectedItem=items),
        onChanged: (year_month)
        {
          FocusScope.of(context).requestFocus(FocusNode());
         // setState(() => selectedVal = year_month);
        }
    );
  }

  dropDownButton(String text, String icon, List education, String selectededucation)
  {
    return DropdownButtonFormField2(
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        dropdownWidth:webResponsive_TD_Width-35,
        // dropdownWidth: MediaQuery.of(context).size.width / 0.001,
        dropdownMaxHeight: 200,
        isExpanded: true,
        offset: Offset(-42, -15),
        // offset: Offset(16,-15),
        decoration: getTextFieldDecorationWithPrefixIcon(icon,text),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        // value: selectedItem,
        items: education.map((education)=> DropdownMenuItem(
          value: education,
          child: Container(
              width: 200,
              child: Text(education,style: TextStyle(fontSize: textFieldHeadingFontWeight),)
          ),
          // child: Text(items,style: TextStyle(fontSize: textFieldHeadingFontWeight),)
        ))
            .toList(),
        // onChanged: (items)=> setState(()=>selectedItem=items),
        onChanged: (education)
        {
          FocusScope.of(context).requestFocus(FocusNode());
          //setState(() => selectededucation = education);
        }
    );
  }

  Container elevatedButtonWithDotBottomBar()
  {
    return CJElevatedBlueButtonWithDotJobSeeker("Finish", 3,elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action 1");

      TalentNavigation().pushTo(context, JobSeeker_SignUpDetailsVerify());

    }
    )) ;

  }


}
