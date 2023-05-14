

import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../Talents/Controller/CJHubSupport/HrConnect.dart';
import '../../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../../../../../CustomView/CommonViews/CommonViewClass.dart';
import '../../CJHubPDF/pdf_id_ui.dart';

class Talent_Profile extends StatefulWidget
{
  const Talent_Profile({Key? key}) : super(key: key);

  @override
  State<Talent_Profile> createState() => _Talent_Profile();

}

class _Talent_Profile extends State<Talent_Profile>{


  @override
  Widget build(BuildContext context)
  {
    return  Scaffold(

      backgroundColor: Colors.white,
      appBar:CJAppBar(getTalent_TabProfileTitle, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        Navigator.pop(context);
      })),
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


  SingleChildScrollView MainfunctionUi(){
    return SingleChildScrollView(
     /* child: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),*/
              child: Column(
                children: [

                  Center(
                    child: SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(Talent_Icon_profileDrawer),
                          ),
                          Positioned(
                            bottom: 0,
                            right: -8,
                            child: Card(
                                elevation: 20,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(150),
                                ),
                                child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white
                                    ),
                                    child: ImageIcon(
                                      AssetImage(Talent_Icon_cameraDrawer),
                                      color: Colors.grey,
                                    )
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  GestureDetector(
                    onTap: ()
                    {
                      print("Download Id Card");
                      TalentNavigation().pushTo(context, pdf_id_ui());

                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text( "Download id Card",
                            style: TextStyle(color: darkBlueColor,
                              fontSize: 16,
                              fontFamily: robotoFontFamily,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          ImageIcon(
                            AssetImage(Talent_Icon_AddressCard),
                            color: darkBlueColor,
                          )
                        ],
                      ),
                    ),
                  ),


                  SizedBox(
                    height: 5,
                  ),


                  Padding(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Color(0xffF6F6F6),
                          elevation: 4.0,
                          child: Container(
                              padding: EdgeInsets.only(left: 40,top: 20,bottom: 20),
                              child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Expanded(
                                        flex: 1,
                                        child: Column(

                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: [

                                            Wrap(
                                              crossAxisAlignment: WrapCrossAlignment.center,
                                              alignment: WrapAlignment.center,
                                              spacing: 5,
                                              children: [
                                                Text("Kamla Devi",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: bold_FontWeight,
                                                      fontFamily: robotoFontFamily,
                                                      fontSize: 22
                                                  ),
                                                ),
                                                ImageIcon(
                                                  AssetImage(Verification_Icon),
                                                  color: Color(0xff38B9FB),
                                                  size: 25,
                                                )
                                              ],
                                            ),

                                            SizedBox(
                                              height: 1,
                                            ),

                                            Wrap(
                                              crossAxisAlignment: WrapCrossAlignment.center,
                                              alignment: WrapAlignment.center,
                                              children: [
                                                Text("House Help",
                                                  style: TextStyle(
                                                      fontSize: large_FontSize,
                                                      fontFamily: robotoFontFamily,
                                                      color: Color(0xff090909)
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(
                                              height: 1,
                                            ),

                                            Wrap(
                                              crossAxisAlignment: WrapCrossAlignment.center,
                                              alignment: WrapAlignment.center,
                                              children: [
                                                Text("Cj Code:",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: normal_FontWeight,
                                                      fontFamily: robotoFontFamily,
                                                      fontSize: large_FontSize
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "688578",
                                                  style: TextStyle(
                                                    color: Color(0xff303030),
                                                    fontFamily: robotoFontFamily,
                                                  )
                                                  ,
                                                )
                                              ],
                                            ),

                                            SizedBox(
                                              height: 1,
                                            ),

                                            Wrap(
                                              crossAxisAlignment: WrapCrossAlignment.center,
                                              alignment: WrapAlignment.center,
                                              children: [
                                                Text("Mob:",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: robotoFontFamily,
                                                      fontSize: 18
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "9777777778",
                                                  style: TextStyle(
                                                    color: Color(0xff303030),
                                                    fontFamily: robotoFontFamily,
                                                  )
                                                  ,
                                                )
                                              ],
                                            ),

                                            SizedBox(
                                              height: 1,
                                            ),

                                            Wrap(
                                              crossAxisAlignment: WrapCrossAlignment.center,
                                              alignment: WrapAlignment.center,
                                              children: [
                                                Text("Email:",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: robotoFontFamily,
                                                      fontSize: 18
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "kamlajii@gmail.com",
                                                  style: TextStyle(
                                                    color: Color(0xff303030),
                                                    fontFamily: robotoFontFamily,
                                                  )
                                                  ,
                                                )
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        width: 10,
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(bottom: 20),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: IconButton(
                                              onPressed: (){},
                                              icon: ImageIcon(
                                                AssetImage(Talent_Icon_Profile_Edit),
                                                color: Colors.blue,
                                              )
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              )
                          ),
                        )
                    ),
                  ),


                  SizedBox(
                    height: 10,
                  ),


                  /*  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QrImage(
                          data: "SwaraJII",
                          size: 170,
                        ),
                      ],
                    ),
                  ),*/

                  Image.asset(Talent_Icon_qrCodeDrawer),


                  SizedBox(
                    height: 10,
                  ),


                  Container(
                      height: 38,
                      width: 140,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Color(0xffCCCBCB),
                          ),
                        ),
                        color: Color(0xffFFFFFF),
                        elevation: 4.0,
                        margin: EdgeInsets.only(left: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Share Qr Code",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: robotoFontFamily,
                                  color: Color(0xff0F87C3)
                              ),
                            ),
                            IconButton(
                                onPressed: (){},
                                icon: ImageIcon(
                                  AssetImage(Share_Icon),
                                  color: Colors.blue,
                                )

                            )



                          ],
                        ),
                      )
                  ),


                  SizedBox(
                    height: 10,
                  ),


                  GestureDetector(child:profileSupportUI() ,onTap: ()
                  {
                    TalentNavigation().pushTo(context, HrConnect(pendingQueryValue: 0,));

                  },),
                  /*-----------22-11-2022 end(use for the Help $ Support)--------------*/

                ],
              ),
      /* ),
          )
      ),*/
    );
  }

}


