import 'dart:math';

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:flutter/material.dart';

//import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../CustomView/CommonViews/CommonViewClass.dart';
import '../../../../Talents/Controller/CJHubSupport/HrConnect.dart';
import '../../../../Talents/TalentNavigation/TalentNavigation.dart';

class Employer_Profile extends StatefulWidget {

  const Employer_Profile({Key? key, this.selectRegistrationType}) : super(key: key);
  final selectRegistrationType;

  @override
  State<Employer_Profile> createState() => _Employer_Profile(selectRegistrationType);
}

class _Employer_Profile extends State<Employer_Profile> {

  static const yellowGreenColor = Color(0xffe0e0d4);
  static const blueColor = Color(0xff0f87c3);
  static const editColor = Color(0xff0097e5);
  static const buttonColor= Color(0xff12addd);
  static const borderColor= Color(0xffD3D3D3);
  static const buttonborderColor= Color(0xffCCCBCB);


  bool business_Visibility=false;
  bool home_Visibility=false;

  _Employer_Profile(selectRegistrationType)
  {
    print("show the selected status $selectRegistrationType");
    if(selectRegistrationType==kEmployerRegistrationType_Business)
    {
      //use for business
      business_Visibility=true;
      home_Visibility=false;

    }else
    {
      //use for home
      business_Visibility=false;
      home_Visibility=true;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return  Scaffold(
      backgroundColor: whiteColor,
      appBar:CJAppBar(getEmployer_Profile, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })) ,
        body: getResponsiveUI(),
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

  MainfunctionUi()
  {
    return  SingleChildScrollView(
      child: Column(
        children: [

          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 17, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: medium_FontSize,
                    color: editColor,),
                ),
                IconButton(
                  icon: Image.asset(Edit_Icon),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: borderColor,
              ),
            ),
            child: SizedBox(
              width: webResponsive_TD_Width-30,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),

                        Visibility(visible: home_Visibility,child:Expanded(
                          flex: 1,
                          child:  CircleAvatar(child: Text("NY"),
                              backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)]),
                        ),),

                        Visibility(visible: business_Visibility,child:Expanded(
                          flex: 1,
                          child:Image.asset(Wipro_Icon) ,
                        ),),

                        SizedBox(
                          width: 20,
                        ),

                        Visibility(visible: home_Visibility,child:Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: EdgeInsets.only(left: 5),child:  Row(
                                children: [
                                  Text(
                                    'Navin Yadav',
                                    style: TextStyle(
                                      fontSize: medium_FontSize,
                                      fontWeight: bold_FontWeight,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  //Image.asset(Verification_Icon),
                                  ImageIcon(
                                    AssetImage(Verification_Icon),
                                    color: Color(0xff38B9FB),
                                    size: medium_FontSize,
                                  )
                                ],
                              ),),
                              SizedBox(height: 4),
                              labelText('Aadhaar:', '4545 5454 6565'),
                              SizedBox(height: 4),

                              labelText('PAN:', 'AAJPN8365N'),
                             // labelText('Email:', 'admin@wipro.com'),
                              //labelText('Phone:', '9569734648'),


                              Container(child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ImageIcon(
                                      AssetImage(email_Icon)
                                  ),
                                  Flexible(
                                    child: Text("n@gmail.com",
                                      style: TextStyle(
                                          color: Color(0xff2E2E2E),
                                          fontSize: small_FontSize,
                                          fontFamily: robotoFontFamily,
                                          fontWeight:normal_FontWeight
                                      ),
                                    ),
                                  ),

                                ],
                              ),)
                               ,
                               Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ImageIcon(
                                        AssetImage(phone_Icon)
                                    ),
                                    Flexible(
                                      child: Text("0994884858  ",
                                        style: TextStyle(
                                            color: Color(0xff2E2E2E),
                                            fontSize: small_FontSize,
                                            fontFamily: robotoFontFamily,
                                            fontWeight: normal_FontWeight
                                        ),
                                      ),
                                    ),

                                  ],
                                ),


                            ],
                          ),
                        ) ,),

                        Visibility(visible: business_Visibility,child:Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Wipro Ltd.',
                                    style: TextStyle(
                                      fontSize: medium_FontSize,
                                      fontWeight: bold_FontWeight,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  //Image.asset(Verification_Icon),
                                  ImageIcon(
                                    AssetImage(Verification_Icon),
                                    color: Color(0xff38B9FB),
                                    size: medium_FontSize,
                                  )
                                ],
                              ),
                              SizedBox(height: 4),
                              labelTextForCompany('GSTIN:', '688578'),
                              labelTextForCompany('PAN:', 'AAJPN8365N'),
                              labelTextForCompany('Email:', 'admin@wipro.com'),
                            ],
                          ),
                        ) ,),

                      ],
                    ),
                    SizedBox(height: 10),
                   /* QrImage(
                      data: "1234567890",
                      version: QrVersions.auto,
                      size: 130.0,
                    ),*/
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Text(
                        "Share QR Code",
                        style: TextStyle(
                          fontSize: smallLess_FontSize,
                          color: blueColor,
                        ),
                      ),
                      // icon: Icon( Icons., color: Colors.white,),
                      label: Image.asset(
                        Share_Icon,
                        width: 12,
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(100, 50),
                          primary: Colors.white,
                          onPrimary: Colors.blue,
                          side: BorderSide(
                            width: 1,
                            color: buttonborderColor,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            //border radius equal to or more than 50% of width
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            color: yellowGreenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: yellowGreenColor,
              ),
            ),
            child: SizedBox(
              width: webResponsive_TD_Width-30,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Complete Verification Process',
                            style: TextStyle(
                              fontSize: large_FontSize,
                              color: blueColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Text(
                              "Click Here",
                              style: TextStyle(
                                fontSize: medium_FontSize,
                              ),
                            ),
                            label: Image.asset(
                              doubleRightArrow_White_Icon,
                              width: 12,height: 12,
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(yellowTick_Icon,width: 60,height: 70,),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),

        /*-----------22-11-2022 start(use for the Help $ Support)--------------*/
        GestureDetector(child:profileSupportUI() ,onTap: ()
          {
            TalentNavigation().pushTo(context, HrConnect(pendingQueryValue: 0,));

          },),
          /*-----------22-11-2022 end(use for the Help $ Support)--------------*/

        ],
      ),
    );
  }

  Padding labelText(String label, String astrick)
  {
   return Padding(padding: EdgeInsets.only(left: 6),child:RichText(
      text: TextSpan(
          text: label,
          style: TextStyle(
            fontSize: small_FontSize,
            fontWeight: FontWeight.bold,
            color: blackColor,
            fontFamily: viewHeadingFontfamily,
          ),
          children: [
            WidgetSpan(
                child: SizedBox(
                  width: 3, // your of space
                )),
            TextSpan(
              text: astrick,
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontWeight: textFieldFontWeightType,
                fontSize: small_FontSize,
                fontFamily: viewHeadingFontfamily,
              ),
            )
          ]),
    ) ,);
  }

  Padding labelTextForCompany(String label, String astrick)
  {
    return Padding(padding: EdgeInsets.only(left: 6),child:RichText(
      text: TextSpan(
          text: label,
          style: TextStyle(
            fontSize: small_FontSize,
            fontWeight: FontWeight.bold,
            color: blackColor,
            fontFamily: viewHeadingFontfamily,
          ),
          children: [
            WidgetSpan(
                child: SizedBox(
                  width: 3, // your of space
                )),
            TextSpan(
              text: astrick,
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontWeight: textFieldFontWeightType,
                fontSize: small_FontSize,
                fontFamily: viewHeadingFontfamily,
              ),
            )
          ]),
    ) ,);
  }
}
