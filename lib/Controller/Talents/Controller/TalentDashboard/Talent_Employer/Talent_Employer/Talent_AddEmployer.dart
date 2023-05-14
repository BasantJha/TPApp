import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../Constant/ValidationClass.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:contractjobs/CustomView/TextField/TextFieldDecoration.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';

import '../../../../../../CustomView/CustomRow/AstricRow.dart';
import '../../../../../../CustomView/Messages/Validation_Messages.dart';

class Talent_AddEmployer extends StatefulWidget {
  const Talent_AddEmployer({Key? key}) : super(key: key);

  @override
  State<Talent_AddEmployer> createState() => _Talent_AddEmployerState();
}

class _Talent_AddEmployerState extends State<Talent_AddEmployer> {

  static const mediumDarkGreyColor = Color(0xff636363);

  List<String> state = ['New Delhi','Odisha'];
  String selectedstate = 'New Delhi';

  List<String> city = ['New Delhi','demo'];
  String selectedcity = 'New Delhi';

  List<String> pincode = ['110049','110092'];
  String selectedpincode = '110049';

  String selectedValue="";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  late String _name;
  late String _mobile;
  late String _address;
  late String _state;
  late String _city;
  late String _pincode;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CJAppBar(getTalent_AddEmployerTitle, appBarBlock: AppBarBlock(appBarAction: () {
          print("show the action type");
          Navigator.pop(context);
        })),
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
  SingleChildScrollView MainfunctionUi()
  {
    return SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child:Container(color: whiteColor,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                SizedBox(height: 10),
                Center(child:getViewHintTextBlue(getTalent_AddEmployerHint),),
                SizedBox(height: 60),
                Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:getAstricRow('Employer Name'),
                    )
                ),
                SizedBox(height: 8),
                Container(
                    child:TextFormField(
                      cursorColor: mediumDarkGreyColor,
                      style: TextStyle(
                        color: textFieldHeadingColor,
                      ),
                      decoration: getTextFieldDecoration('Anju Butta'),
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp(r'[a-zA-Z\s]*'), allow: true)
                      ],
                      validator: validateToName,
                      onChanged: (String val)
                      {
                        _name = val;
                      },
                    )
                ),
                SizedBox(height: 20),
                Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:getAstricRow('Company Name (if any)'),
                    )
                ),
                SizedBox(height: 8),
                Container(
                    child:TextFormField(
                      cursorColor: Colors.grey,
                      style: TextStyle(
                        color: textFieldHeadingColor,
                      ),
                      decoration: getTextFieldDecoration('Akal Information Systems Ltd.'),
                      keyboardType: TextInputType.text,
                    )
                ),
                SizedBox(height: 20),
                Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:getAstricRow('Mobile Number'),
                    )
                ),
                SizedBox(height: 8),
                Container(
                    child:TextFormField(
                      cursorColor: Colors.grey,
                      style: TextStyle(
                        color: textFieldHeadingColor,
                      ),
                      decoration: getTextFieldDecoration('9811128592'),
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      maxLength: 10,
                      validator: validateToMobileNo,
                      onChanged: ( val) {
                        _mobile = val!;
                      },
                    )
                ),
                SizedBox(height: 20),
                Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:getAstricRow('Address'),
                    )
                ),
                SizedBox(height: 8),
                Container(
                    child:TextFormField(
                      cursorColor: mediumDarkGreyColor,
                      style: TextStyle(
                        color: textFieldHeadingColor,
                      ),
                      decoration: getTextFieldDecorationWithPrefixIcon(locationGrey_Icon,"13 community center, yusuf sarai, New Delhi, Delhi 110049"),
                      // decoration: getTextFieldDecoration('13 community center, yusuf sarai, New Delhi, Delhi 110049'),
                      maxLines: 2,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp(r'[a-z A-Z0-9.\-/=,\;\s]*'), allow: true)
                      ],
                      validator: validateToAddress,
                      onChanged: (val) {
                        _address = val!;
                      },
                    )
                ),
                SizedBox(height: 15),
                Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:getAstricRow('State'),
                    )
                ),
                SizedBox(height: 8),
                Container(
                  // child:dropdown('Choose Your State', locationGrey_Icon, state, selectedstate),
                  child: dropdown('Choose Your State', locationGrey_Icon,
                      selectedstate, state, validateMsg_state),
                ),
                SizedBox(height: 15),
                Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:getAstricRow('City'),
                    )
                ),
                SizedBox(height: 8),
                Container(
                  child:dropdown('Choose Your City', locationGrey_Icon,  selectedcity,city, validateMsg_city),
                ),
                SizedBox(height: 15),
                Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:getAstricRow('Pin Code'),
                    )
                ),
                SizedBox(height: 8),
                Container(
                  child:dropdown('Choose Your Pin Code', locationGrey_Icon, selectedpincode,pincode, validate_Pincode),
                ),
              ],
            ),
          ),
        )

    );

  }

  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Submit", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      _validateInputs();
      //TalentNavigation().pushTo(context, Talent_RaiseBillQRCode());

    }
    )) ;

  }

  void _validateInputs() {
    if (_formKey.currentState!.validate()) {
      print(_name);
      print(_mobile);
      print(_address);
      print(selectedcity);
      print(selectedstate);
      print(selectedpincode);
      print("show the continue action");

    }
  }

  dropdown(String text, String icon, String val, List list, message) {
    return DropdownButtonFormField2(
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
      validator: (value) {
        if (value == null) {
          return message;
        }
      },
      onChanged: (value) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onSaved: (value)
      {
        selectedValue = value!;
      },
    );
  }
}
