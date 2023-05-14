
import 'dart:async';

import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/Talent_SignUp/Talent_KYCDetailsVerified.dart';
import 'package:contractjobs/Controller/Talents/Controller/Talent_SignUp/Talent_VerifyBankAccount.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/NavigationView/NavigationView.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class Talent_KYCDetails extends StatefulWidget
{

  const Talent_KYCDetails({Key? key}) : super(key: key);

  @override
  _Talent_KYCDetails createState() => _Talent_KYCDetails();

}

class _Talent_KYCDetails extends State<Talent_KYCDetails> {

  bool isvisibleAadharNumber = true;

  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  FocusNode nodethree = FocusNode();

  FocusNode nodeoneotp = FocusNode();
  FocusNode nodetwootp = FocusNode();
  FocusNode nodethreeotp = FocusNode();
  FocusNode nodefourotp = FocusNode();
  FocusNode nodefiveotp = FocusNode();
  FocusNode nodesixotp = FocusNode();

  String aadharnumber = " ";

  TextEditingController aadharcontrollerone = TextEditingController();
  TextEditingController aadharcontrollertwo = TextEditingController();
  TextEditingController aadharcontrollerthree = TextEditingController();

  bool visibility_EnterOTPUI=false;

  /*-----------------------Start Timer-------------------------*/

  bool isvisibleresendotp = false;
  bool isvisibletimertext = true;

  int start = 60;

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if(start == 0 ) {
        setState(() {
          timer.cancel();
          isvisibleresendotp = true;
          isvisibletimertext = false;
        });
      }
      else{
        setState(() {
          start--;
        });
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }


  @override
  void dispose()
  {
    super.dispose();

    nodeOne.dispose();
    nodeTwo.dispose();
    nodethree.dispose();
    nodeoneotp.dispose();
    nodetwootp.dispose();
    nodethreeotp.dispose();
    nodefourotp.dispose();
    nodefiveotp.dispose();
    nodesixotp.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return(
        Scaffold(
          backgroundColor: Colors.white,
          appBar: CJAppBar(getTalent_VerifyYourIdentityTitle, appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show the action type");
            Navigator.pop(context);
          })),

          body: getResponsiveUI(),
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

  SingleChildScrollView  MainfunctionUi(){
    return SingleChildScrollView(
        child:
        Container(
            child: Padding(padding: EdgeInsets.only(left: mainUILeftRightPadding,right: mainUILeftRightPadding,top: mainUILeftRightPadding),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child:getViewHintTextBlue(getTalent_KYCDetailsHint),),
                    SizedBox(height: 60,),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("Aadhar Number",
                        style: TextStyle(
                            fontSize: textFieldHeadingFontWeight,fontFamily: viewHeadingFontfamily ,
                            color: textFieldHeadingColor,
                            fontWeight: textFieldFontWeightType
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Container(
                                    height: 70,
                                    child: TextField(
                                      controller: aadharcontrollerone,
                                      obscureText: isvisibleAadharNumber,
                                      keyboardType: TextInputType. number,
                                      maxLength: 4,
                                      autofocus: true,
                                      focusNode: nodeOne,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (value) {
                                        if (value.length == 4) {
                                          FocusScope.of(context).requestFocus(nodeTwo);
                                        }
                                        calculateAadhaarNo();

                                      },
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        counterText: " ",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                                        ),
                                      ),
                                      //style: TextStyle(fontSize: 15),
                                    ),
                                  )
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                  child: Container(
                                    height: 70,
                                    child: TextField(
                                      controller: aadharcontrollertwo,
                                      obscureText: isvisibleAadharNumber,
                                      keyboardType: TextInputType. number,
                                      maxLength: 4,
                                      focusNode: nodeTwo,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      autofocus: true,
                                      onChanged: (value)
                                      {
                                        if (value.length == 4) {
                                          FocusScope.of(context).requestFocus(nodethree);
                                        }
                                        else if(value.length ==0){
                                          FocusScope.of(context).requestFocus(nodeOne);
                                        }
                                        calculateAadhaarNo();

                                      },
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        counterText: " ",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                                        ),
                                      ),
                                      //style: TextStyle(fontSize: 15),
                                    ),
                                  )
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                    height: 70,
                                    child: TextField(
                                      controller: aadharcontrollerthree,
                                      obscureText: isvisibleAadharNumber,
                                      keyboardType: TextInputType. number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      maxLength: 4,
                                      autofocus: true,
                                      focusNode: nodethree,
                                      onChanged: (value) {
                                        print("AAdhar Number : {$aadharnumber}");
                                        if (value.length == 0)
                                        {
                                          FocusScope.of(context).requestFocus(nodeTwo);
                                        }
                                        calculateAadhaarNo();
                                      },
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        counterText: " ",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                                        ),
                                      ),
                                      //style: TextStyle(fontSize: 15),
                                    ),
                                  )
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  height: 50,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 20.0),
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          isvisibleAadharNumber = !isvisibleAadharNumber;
                                        });
                                      },
                                      child: Icon(
                                        isvisibleAadharNumber ?
                                        Icons.visibility_off :Icons.visibility,
                                        color: Color(0xff626161),
                                      ),
                                    ),
                                  )
                              )
                            ],
                          ),
                        )
                    ),
                    SizedBox(
                      height: 30,
                    ),


                    /*----------Enter OTP START UI 6-10-2022-------------*/

                    Visibility(visible: visibility_EnterOTPUI,child:Column(children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Enter OTP",
                          style: TextStyle(fontSize: textFieldHeadingFontWeight,fontFamily: viewHeadingFontfamily,
                              fontWeight: textFieldFontWeightType,
                              color: textFieldHeadingColor
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('OTP Was Sent on Registered Mobile Number ******8029', textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(130, 129, 129, 1),
                              fontFamily: viewHeadingFontfamily,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              letterSpacing: 0 ,
                              height: 1),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      /*-----------SET 6 digit pin number UI start--------------*/


                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Expanded(
                      //         child: TextFormField(
                      //           autofocus: true,
                      //           maxLength: 1,
                      //           focusNode: nodeoneotp,
                      //           onChanged: (value)
                      //           {
                      //             if (value.length == 1)
                      //             {
                      //               FocusScope.of(context).requestFocus(nodetwootp);
                      //             }
                      //           },
                      //           textAlign: TextAlign.center,
                      //           decoration: InputDecoration(
                      //               counterText: " "
                      //           ),
                      //         )
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Expanded(
                      //         child: TextFormField(
                      //           autofocus: true,
                      //           maxLength: 1,
                      //           focusNode: nodetwootp,
                      //           onEditingComplete: () {
                      //             nodeoneotp.previousFocus();
                      //           },
                      //           onChanged: (value)
                      //           {
                      //             if (value.length == 1) {
                      //               FocusScope.of(context).requestFocus(nodethreeotp);
                      //             }
                      //             else if(value.length == 0){
                      //               FocusScope.of(context).requestFocus(nodeoneotp);
                      //             }
                      //
                      //           },
                      //           textAlign: TextAlign.center,
                      //           decoration: InputDecoration(
                      //               counterText: " "
                      //           ),
                      //         )
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Expanded(
                      //         child: TextFormField(
                      //           autofocus: true,
                      //           maxLength: 1,
                      //           focusNode: nodethreeotp,
                      //           onEditingComplete: () {
                      //             nodetwootp.previousFocus();
                      //           },
                      //           onChanged: (value) {
                      //             if (value.length == 1) {
                      //               FocusScope.of(context).requestFocus(nodefourotp);
                      //             }
                      //             else if(value.length == 0){
                      //               FocusScope.of(context).requestFocus(nodetwootp);
                      //             }
                      //           },
                      //           textAlign: TextAlign.center,
                      //           decoration: InputDecoration(
                      //               counterText: " "
                      //           ),
                      //         )
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Expanded(
                      //         child: TextFormField(
                      //           autofocus: true,
                      //           maxLength: 1,
                      //           focusNode: nodefourotp,
                      //           onEditingComplete: () {
                      //             nodethreeotp.previousFocus();
                      //           },
                      //           onChanged: (value) {
                      //             if (value.length == 1) {
                      //               FocusScope.of(context).requestFocus(nodefiveotp);
                      //             }
                      //             else if(value.length == 0){
                      //               FocusScope.of(context).requestFocus(nodethreeotp);
                      //             }
                      //           },
                      //           textAlign: TextAlign.center,
                      //           decoration: InputDecoration(
                      //               counterText: " "
                      //           ),
                      //         )
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Expanded(
                      //         child: TextFormField(
                      //           autofocus: true,
                      //           maxLength: 1,
                      //           focusNode: nodefiveotp,
                      //           onEditingComplete: () {
                      //             nodefourotp.previousFocus();
                      //           },
                      //           onChanged: (value) {
                      //             if (value.length == 1) {
                      //               FocusScope.of(context).requestFocus(nodesixotp);
                      //             }
                      //             else if(value.length == 0){
                      //               FocusScope.of(context).requestFocus(nodefourotp);
                      //             }
                      //           },
                      //           textAlign: TextAlign.center,
                      //           decoration: InputDecoration(
                      //               counterText: " "
                      //           ),
                      //         )
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Expanded(
                      //         child: TextFormField(
                      //           autofocus: true,
                      //           maxLength: 1,
                      //           focusNode: nodesixotp,
                      //           onChanged: (value) {
                      //             if (value.length == 0) {
                      //               FocusScope.of(context).requestFocus(nodefiveotp);
                      //             }
                      //           },
                      //           textAlign: TextAlign.center,
                      //           decoration: InputDecoration(
                      //               counterText: " "
                      //           ),
                      //         )
                      //     ),
                      //   ],
                      // ),


                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        cursorColor: Colors.blue,
                        textStyle: TextStyle(
                            fontSize: large_FontSize,
                            color: Color(0xff6C6C6C),
                            fontWeight: normal_FontWeight,
                            fontFamily: robotoFontFamily
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (String value) {},
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            inactiveColor: Colors.grey,
                            activeColor: Colors.blue
                        ),
                      ),


                      SizedBox(
                        height: 15,
                      ),

                      /*-----------SET timer and Resend  UI start--------------*/

                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Visibility(
                                  visible: isvisibletimertext,
                                  child: Container(
                                    // color: Colors.greenAccent,
                                    width: 80,
                                    height: 35,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Expires in $start Second', textAlign: TextAlign.center, style: TextStyle(
                                            color: Color.fromRGBO(183, 183, 183, 1),
                                            fontFamily: viewHeadingFontfamily,
                                            fontSize: 18,
                                            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.w500,
                                            height: 1
                                        ),)
                                    ),
                                  ),
                                )
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Visibility(
                                visible: isvisibleresendotp,
                                child: Container(
                                  height: 35,
                                  child: TextButton(
                                    onPressed: (){
                                      var aadharnumber = aadharcontrollerone.text.toString() + aadharcontrollertwo.text.toString() + aadharcontrollerthree.text.toString();
                                      print("Aadhar Number : {$aadharnumber}");

                                      setState(() {
                                        start = 60;
                                        isvisibletimertext = true;
                                        isvisibleresendotp = false;
                                      });
                                      startTimer();

                                      // TalentNavigation().pushTo(context, Talent_KYCDetailsVerified());

                                    },
                                    child: Text("Resend OTP",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: viewHeadingFontfamily,
                                      ),
                                    ),
                                  ),
                                )
                            )
                          ],
                        ),),

                      /*----------Enter OTP END UI-------------*/
                    ],) ,)


                  ]
              ),)
        )
    );
  }


  calculateAadhaarNo()
  {
    var aadhaarNo=aadharcontrollerone.text+aadharcontrollertwo.text+aadharcontrollerthree.text;
    if(aadhaarNo.length==12)
    {
      setState(() {
        visibility_EnterOTPUI=true;
        TalentNavigation().pushTo(context, Talent_KYCDetailsVerified());
      });
    }else
    {
      setState(() {
        visibility_EnterOTPUI=false;
      });
    }
  }




}
