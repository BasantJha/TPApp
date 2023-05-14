import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Employers/Controller/Employer_TabBarController/Employer_TabBarController.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Employer_SignUpKYC extends StatefulWidget
{
  const Employer_SignUpKYC({Key? key, this.selectRegistrationType}) : super(key: key);
  final selectRegistrationType;

  @override
  State<Employer_SignUpKYC> createState() => _Employer_SignUpKYC(selectRegistrationType);

}

class _Employer_SignUpKYC extends State<Employer_SignUpKYC>
{

  static const raisinBlackColor = Color(0xff262626);
  static const stormGreyColor = Color(0xff838282);
  static const dimGreyColor = Color(0xff6C6C6C);
  static const forTressGreyColor = Color(0xffB8B8B8);
  TextEditingController aadharcontrollerone = TextEditingController();
  TextEditingController aadharcontrollertwo = TextEditingController();
  TextEditingController aadharcontrollerthree = TextEditingController();
  bool isvisibleAadharNumber = true;

  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  FocusNode nodeThree = FocusNode();

  FocusNode nodeoneotp = FocusNode();
  FocusNode nodetwootp = FocusNode();
  FocusNode nodethreeotp = FocusNode();
  FocusNode nodefourotp = FocusNode();
  FocusNode nodefiveotp = FocusNode();
  FocusNode nodesixotp = FocusNode();

  var selectRegistrationType;
  _Employer_SignUpKYC(selectRegistrationType)
  {
    this.selectRegistrationType=selectRegistrationType;
  }

  @override
  void dispose()
  {
    super.dispose();

    nodeOne.dispose();
    nodeTwo.dispose();
    nodeThree.dispose();
    nodeoneotp.dispose();
    nodetwootp.dispose();
    nodethreeotp.dispose();
    nodefourotp.dispose();
    nodefiveotp.dispose();
    nodesixotp.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: whiteColor,
      appBar:CJAppBar(getEmployer_SignUpKYCTitle, appBarBlock: AppBarBlock(appBarAction: ()
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
        child: Center(
          child: Container(
            height: 800,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Center(child:getViewHintTextBlue(getEmployer_SignUpKYCHint),),

              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Text(
                      "Aadhaar Number",
                      style: TextStyle(
                          fontSize: small_FontSize,
                          fontFamily: robotoFontFamily,
                          color: raisinBlackColor,
                          fontWeight: semiBold_FontWeight),
                    ),
                    SizedBox(width: 10),
                    Image(image: AssetImage(checkGreen_Icon))
                  ],
                ),
              ),
              SizedBox(height: 3),
              Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: AdharInput(
                                controller: aadharcontrollerone,
                                FocusNodeno: nodeOne,
                                FocusNodeforward: nodeTwo,
                                FocusNobackward: nodeOne)),
                        SizedBox(width: 10),
                        Expanded(
                            child: AdharInput(
                                controller: aadharcontrollertwo,
                                FocusNodeno: nodeTwo,
                                FocusNodeforward: nodeThree,
                                FocusNobackward: nodeOne)),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: AdharInput(
                                controller: aadharcontrollerthree,
                                FocusNodeno: nodeThree,
                                FocusNodeforward: nodeThree,
                                FocusNobackward: nodeTwo)),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            height: 50,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isvisibleAadharNumber = !isvisibleAadharNumber;
                                  });
                                },
                                icon: Icon(
                                  isvisibleAadharNumber
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: dimGreyColor,
                                ),
                              ),
                            ))
                      ],
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      "Enter OTP",
                      style: TextStyle(
                          fontSize: small_FontSize,
                          fontFamily: robotoFontFamily,
                          color: blackColor,
                          fontWeight: semiBold_FontWeight),
                    ),
                    SizedBox(width: 10),
                    Image(image: AssetImage(checkGreen_Icon))
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'OTP Was Sent on Registered Mobile Number ******8029',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: stormGreyColor,
                      fontFamily: robotoFontFamily,
                      fontWeight: normal_FontWeight,
                      fontSize: medium_FontSize,
                      letterSpacing: 0,
                      height: 1),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: TextFormField(
                        autofocus: true,
                        maxLength: 1,
                        focusNode: nodeoneotp,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).requestFocus(nodetwootp);
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(counterText: " "),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextFormField(
                        autofocus: true,
                        maxLength: 1,
                        focusNode: nodetwootp,
                        onEditingComplete: () {
                          nodeoneotp.previousFocus();
                        },
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).requestFocus(nodethreeotp);
                          } else if (value.length == 0) {
                            FocusScope.of(context).requestFocus(nodeoneotp);
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(counterText: " "),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextFormField(
                        autofocus: true,
                        maxLength: 1,
                        focusNode: nodethreeotp,
                        onEditingComplete: () {
                          nodetwootp.previousFocus();
                        },
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).requestFocus(nodefourotp);
                          } else if (value.length == 0) {
                            FocusScope.of(context).requestFocus(nodetwootp);
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(counterText: " "),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextFormField(
                        autofocus: true,
                        maxLength: 1,
                        focusNode: nodefourotp,
                        onEditingComplete: () {
                          nodethreeotp.previousFocus();
                        },
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).requestFocus(nodefiveotp);
                          } else if (value.length == 0) {
                            FocusScope.of(context).requestFocus(nodethreeotp);
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(counterText: " "),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextFormField(
                        autofocus: true,
                        maxLength: 1,
                        focusNode: nodefiveotp,
                        onEditingComplete: () {
                          nodefourotp.previousFocus();
                        },
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).requestFocus(nodesixotp);
                          } else if (value.length == 0) {
                            FocusScope.of(context).requestFocus(nodefourotp);
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(counterText: " "),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextFormField(
                        autofocus: true,
                        maxLength: 1,
                        focusNode: nodesixotp,
                        onChanged: (value) {
                          if (value.length == 0) {
                            FocusScope.of(context).requestFocus(nodefiveotp);
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(counterText: " "),
                      )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                          // color: Colors.greenAccent,
                          width: 80,
                          height: 35,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Expires in 60 Second',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: forTressGreyColor,
                                    fontFamily: robotoFontFamily,
                                    fontSize: medium_FontSize,
                                    letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: bold_FontWeight,
                                    height: 1),
                              )),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 35,
                      child: TextButton(
                        onPressed: () {
                          var aadharnumber = aadharcontrollerone.text.toString() +
                              aadharcontrollertwo.text.toString() +
                              aadharcontrollerthree.text.toString();
                          print("Aadhar Number : {$aadharnumber}");
                        },
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(
                            color: darkBlueColor,
                            fontSize: medium_FontSize,
                            fontWeight: bold_FontWeight,
                            fontFamily: robotoFontFamily,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Congratulations!",
                      style: TextStyle(
                        color: darkBlueColor,
                        fontWeight: semiBold_FontWeight,
                        fontFamily: robotoFontFamily,
                        fontSize: large_FontSize,
                      ),
                    ),
                    SizedBox(width: 8),
                    Image(image: AssetImage(congratulations_Icon))
                  ],
                ),
              ),
              SizedBox(height: 18),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Registration is now complete. Get started to find the best matches for all your contractual needs hjgjhgjj hjgkhgj hjgjhgklkhjk hjhgkhkbmnbm!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: blackColor,
                        fontWeight: normal_FontWeight,
                        fontFamily: robotoFontFamily,
                        fontSize: small_FontSize,
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ));


  }
  Widget AdharInput({FocusNodeno,FocusNodeforward,FocusNobackward,required TextEditingController controller}) {
    return Container(
      height: 70,
      child: TextField(
        controller: controller,
        obscureText: isvisibleAadharNumber,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        maxLength: 4,
        autofocus: true,
        focusNode: FocusNodeno,
        onChanged: (value)
        {
          print("show enter value $value");
          if (value.length == 4)
          {
            FocusScope.of(context).requestFocus(FocusNodeforward);
          }
          else if (value.length == 0)
          {
            FocusScope.of(context).requestFocus(FocusNobackward);
          }

          var calLenght=aadharcontrollerone.text+aadharcontrollertwo.text+aadharcontrollerthree.text;
          if(calLenght.length==12)
            {
              TalentNavigation().pushTo(context, Employer_TabBarController());
            }
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: " ",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
        //style: TextStyle(fontSize: 15),
      ),
    );
  }

  Container elevatedButtonWithDotBottomBar()
  {
    return CJWithoutElevatedBlueButtonWithDotJobSeeker("", 3,elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action 1");

    }
    )) ;

  }
}
