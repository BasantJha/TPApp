import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class  JobSeeker_PersonalDetails extends StatefulWidget
{
  const JobSeeker_PersonalDetails({key});

  @override
  State<JobSeeker_PersonalDetails> createState() => _JobSeeker_PersonalDetails();
}

class _JobSeeker_PersonalDetails extends State<JobSeeker_PersonalDetails>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  late String _name;
  late String _email;
  late String _mobile;

  var textFieldColor = Color(0xff000000);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CJAppBar(getJobSeeker_Profile_PersonalDetails, appBarBlock: AppBarBlock(appBarAction: () {
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
                SizedBox(height: 60),
                Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:labeltext('Full Name'),
                    )
                ),
                SizedBox(height: 8),
                Container(
                    child:TextFormField(
                      cursorColor: Colors.grey,
                      style: TextStyle(
                        color: textFieldColor,
                      ),
                      decoration: decorationimage('Lokesh Aggarwal',user_Icon,''),
                      keyboardType: TextInputType.text,
                     // validator: validateName,
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
                      child:labeltext('Phone No.'),
                    )
                ),
                SizedBox(height: 8),
                Container(
                    child:TextFormField(
                      cursorColor: Colors.grey,
                      style: TextStyle(
                        color: textFieldColor,
                      ),
                      decoration: decorationimage('8765937689',phone_Icon_Grey,'Verify'),
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      maxLength: 10,
                      //validator: validateMobile,
                      onChanged: (String val)
                      {
                        _mobile = val;
                      },
                    )
                ),
                SizedBox(height: 20),
                Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:labeltext('Email Address'),
                    )
                ),
                SizedBox(height: 8),
                Container(
                    child:TextFormField(
                      cursorColor: Colors.grey,
                      style: TextStyle(
                        color: textFieldColor,
                      ),
                      decoration: decorationimage('lokesh@gmail.com',emailGrey_Icon,'Verify'),
                      keyboardType: TextInputType.emailAddress,
                      //validator: validateEmail,
                      onChanged: (String val)
                      {
                        _email = val;
                      },
                    )
                ),

              ],
            ),
          ),
        )

    );

  }


/*
  String validateName(String value)
  {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp= new RegExp(pattern);
    if (value.length ==0){
      return 'Name is required';
    }else if(!regExp.hasMatch(value)){
      return 'Name must be a-z and A-Z';
    }
    return null;
  }

  String validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp= new RegExp(pattern);
    if (value.length ==0){
      return 'Mobile Number is required';
    }else if(value.length!=10){
      return 'Mobile Number must be 10 digit';
    }else if(!regExp.hasMatch(value)){
      return 'Mobile Number must be  digits';
    }
    return null;
  }

  String validateEmail(String value)
  {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate())
    {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }*/

  RichText labeltext(String label){
    return RichText(
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontSize: medium_FontSize,
          fontWeight: semiBold_FontWeight,
          fontFamily: robotoFontFamily,
          color: textFieldHeadingColor,
        ),
      ),
    );
  }


  InputDecoration decorationimage(String hinttext, String preicon, String suffixtext){
    return InputDecoration(
      hintText: hinttext,
      hintStyle: TextStyle(
        color: textFieldHintTextColor,fontSize: textFieldHeadingFontWeight,fontFamily: viewHeadingFontfamily,),
      prefixIcon:IconButton(color: lightGreyColor,
        icon: new Image.asset(preicon,width: 18.0,height: 18.0,),
        onPressed: null,
      ),
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(25),
            child:Text(suffixtext,
              style: TextStyle(
                color: Colors.blue,
                fontSize: small_FontSize,
                fontFamily: robotoFontFamily,
                fontWeight: semiBold_FontWeight,
              ),
            ),
          ),
        ],
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
            color: Colors.grey,
            width: 2.0
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  Container Iconimg(String icon){
    return Container(
      height: 18.0,
      width: 18.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(icon),
        ),
      ),
    );
  }

  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Save >>", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");

      //TalentNavigation().pushTo(context, Talent_RaiseBillQRCode());

    }
    )) ;

  }

}
