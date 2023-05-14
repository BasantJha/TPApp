
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:circles_background/circles_background/circles_background.dart';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_Passbook/Talent_Passbook.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_RaiseBill/Talent_RaiseBillOfService.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_HomeView/Talent_HomeChild.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_LeftDrawer/Talent_LeftDrawer.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_TabBarController/Talent_TabBarController.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class Talent_Home extends StatefulWidget {

  const Talent_Home({super.key});

  @override
  _Talent_Home createState() => _Talent_Home();
}

class _Talent_Home extends State<Talent_Home>{

  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<CircleInfo> circles = getCircleInfoForHome;
  late final List<Widget>lstcard = Talent_HomeChild().fractionSwipListCardForHome();

  var iconWidth_Height=70.0;

  var row_Height=190.0;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer:  Navigation_Drawer(),
      backgroundColor: Colors.white,
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
  CirclesBackground MainfunctionUi()
  {
    return CirclesBackground(
        circles:circles,child: SingleChildScrollView(
        child: SafeArea(
          child: Center(
              child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: ListView.builder(shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                  itemCount: 1,itemBuilder: (BuildContext context,int index)
    {
      return Column(
        children: [
          //------------use for the profile card start 15-10-2022 start------------
          Container(
            height: 216.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 0.0,
                child: Container(
                  //color: Color(0xffDFDFDF),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: LinearGradient(
                      colors: [Color(0xfffefefe), Color(0xffe6e6e6)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Welcome Navin!",
                          style: TextStyle(
                            color: Color(0xff5C5C5C),
                            fontSize: large_FontSize,
                            fontFamily: robotoFontFamily,
                            fontWeight: bold_FontWeight,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: ShapeDecoration(
                            shape: CircleBorder(), color: Colors.white),
                        child: DecoratedBox(
                          decoration: ShapeDecoration(
                              shape: CircleBorder(),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                  AssetImage(Talent_Icon_BoyImage))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.0, left: 60.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "KYC Verified",
                                            style: TextStyle(
                                                color: Color(0xff2E2E2E),
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.normal,
                                                fontFamily:
                                                robotoFontFamily),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Image.asset(
                                            Verification_Icon,
                                            height: 20,
                                            width: 20,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "CJ Code: 45655",
                                        style: TextStyle(
                                            fontWeight:
                                            semiBold_FontWeight,
                                            fontSize: 12,
                                            color: Color(0xff2E2E2E),
                                            fontFamily: robotoFontFamily),
                                      )
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5.0),
                              child: Image.asset(
                                Talent_Icon_KYC,
                                height: 36,
                                width: 56,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),

          //------------use for the profile card start 15-10-2022 end------------

          SizedBox(
            height: 20,
          ),

          // /*------------use for the raise bill start 15-10-2022 start------------*/
          Container(
            height: row_Height,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: darkGreyColor),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: row_Height - 10,
                // width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [Color(0xffDBD4A6), Color(0xffDBD4A6)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Make Your First Transaction Now",
                              style: TextStyle(
                                color: Color(0xff837C4D),
                                fontWeight: bold_FontWeight,
                                fontFamily: robotoFontFamily,
                                fontSize: listTitle_FontSize,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),

                            Text(
                              "Raise bill and Share it With Your Employer",
                              style: TextStyle(
                                color: Color(0xff373529),
                                fontWeight: semiBold_FontWeight,
                                fontFamily: robotoFontFamily,
                                fontSize: listSubTitle_FontSize,
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            InkWell(
                              onTap: () {
                                TalentNavigation().pushTo(
                                    context, Talent_RaiseBillOfService());
                              },
                              child: Image.asset(
                                Talent_Icon_Raisebill,
                                height: 40,
                                width: 130,
                              ),
                            ),
                            //)
                          ],
                        ),
                      ),
                      Container(
                        child: Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Image(
                              width: iconWidth_Height + 20,
                              height: iconWidth_Height + 20,
                              image: AssetImage(Talent_Icon_RupayImage),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),

          ///*------------use for the passbook start 15-10-2022 start------------*/
          Container(
            height: row_Height,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color(0xff6CB2D4),
                elevation: 0.0,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(
                        colors: [Color(0xff8bc3de), Color(0xff63aed1)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                              EdgeInsets.only(top: 15.0, left: 10.0,right: 40),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Passbook",
                                    style: TextStyle(
                                        fontSize: listTitle_FontSize,
                                        color: Color(0xff194960),
                                        fontFamily: robotoFontFamily,
                                        fontWeight: bold_FontWeight),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "All Your transactions in one place",
                                    style: TextStyle(
                                        fontSize: listSubTitle_FontSize,
                                        color: Color(0xff292926),
                                        fontFamily: robotoFontFamily,
                                        fontWeight: semiBold_FontWeight),
                                  ),

                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Available Balance",
                                    style: TextStyle(
                                        fontSize:
                                        listSubTitle_FontSize - 2,
                                        color: Color(0xff292926),
                                        fontFamily: robotoFontFamily,
                                        fontWeight: semiBold_FontWeight),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        Rupees_Icon,
                                        height: 20,
                                        width: 20,
                                      ),
                                      Text(
                                        "1,00,000",
                                        style: TextStyle(
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(2.0, 2.0),
                                              blurRadius: 3.0,
                                              color: Color.fromARGB(
                                                  255, 0, 0, 0),
                                            ),
                                            Shadow(
                                              offset: Offset(2.0, 2.0),
                                              blurRadius: 8.0,
                                              color: Colors.grey,
                                            ),
                                          ],
                                          color: whiteColor,
                                          fontSize:
                                          listSubTitle_FontSize + 4,
                                          fontWeight: bold_FontWeight,
                                          fontFamily: robotoFontFamily,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //Image.asset(Talent_Icon_EarningPassbook,height: 97,width: 93,),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Image(
                                      width: iconWidth_Height,
                                      height: iconWidth_Height,
                                      image: AssetImage(
                                          Talent_Icon_EarningPassbook),
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(bottom: 25),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: InkWell(
                                    onTap: () {
                                      TalentNavigation().pushTo(
                                          context, Talent_Passbook());
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'View',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 1),
                                              fontFamily:
                                              robotoFontFamily,
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight:
                                              semiBold_FontWeight,
                                              height: 1),
                                        ),
                                        SizedBox(width: 6),
                                        Image(
                                          image: AssetImage(
                                              DoubleArrowBlack_Icon),
                                          width: 12,
                                          height: 12,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ))),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 200,
              child: ListView(
                children: [
                  CarouselSlider(
                    items: lstcard,
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: true,
                        padEnds: false,
                        enlargeCenterPage: false,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.7,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                ],
              )),
          //bottom horizontal scroll view start
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: lstcard.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: (Theme.of(context).brightness ==
                            Brightness.dark
                            ? Colors.white
                            : Colors.grey)
                            .withOpacity(
                            _current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      );
     }))
          ),
        )
    ),);
  }


}


/*------Rajat code start----*/
/*
class Talent_Home extends StatefulWidget {
  const Talent_Home({super.key});

  @override
  State<Talent_Home> createState() => _mainHomeState();
}

class _mainHomeState extends State<Talent_Home>
{
  static const proflieCardHeadingColor = Color(0xff5C5C5C);
  static const profileCardHeadingSize = 20.0;
  static const profileCardCodeSize = 16.0;
  static const cardHeight = 216.0;
  static const cardWidth = 355.0;
  static const carsousalCardWidth = 280.0;


  late final List<Widget>lstcard = Talent_HomeChild().fractionSwipListCardForHome();


  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<CircleInfo> circles = [
    CircleInfo(
        size: Size(500, 100),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff93d9fd), Color(0xff3cbbfb)]),
        alignment: Alignment.topCenter),
  ];


  @override
  Widget build(BuildContext context) {
    return CirclesBackground(
      circles: circles,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    profile_card("Navin Yadav", "45655"),
                    SizedBox(
                      height: 10,
                    ),
                    raise_bill_card(
                        "Make Your First Transaction Now",
                        "Raise bill and share it with your employer Raise Bill",
                        "assets/images/earning_screen_transaction.png",
                        "Raise Bill"),
                    SizedBox(
                      height: 10,
                    ),
                    passbook_card("Passbook",
                        "All your transactions in one place", "₹ 100,000"),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 200,
                  width: 360,
                  child: ListView(
                    children: [
                      CarouselSlider(
                        items: lstcard,
                        carouselController: _controller,
                        options: CarouselOptions(
                            autoPlay: true,
                            padEnds: false,
                            enlargeCenterPage: false,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.7,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: lstcard.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color:
                            (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.grey)
                                .withOpacity(
                                _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
    
  }

  Card passbook_card(String title, String subtitle, String amount) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: darkGreyColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: cardHeight,
        width: cardWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                Color(0xff8BC3DE),
                Color(0xff63AED1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 15, 20, 0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: ListTile(
                      title: Text(
                        title,
                        style: TextStyle(
                          color: Color(0xff194960),
                          fontWeight: bold_FontWeight,
                          fontFamily: robotoFontFamily,
                          fontSize: listTitle_FontSize,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: bold_FontWeight,
                            fontFamily: robotoFontFamily,
                            fontSize: listSubTitle_FontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image(
                       width: 100.0,
                       height: 100.0,
                      image: AssetImage(Talent_Icon_EarningPassbook),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.only(left: 15.0, right: 0.0),
                  title: Text(
                    "Available Balance",
                    style: TextStyle(
                      fontSize: listSubTitle_FontSize,
                      fontWeight: bold_FontWeight,
                      fontFamily: robotoFontFamily,
                    ),
                  ),
                  subtitle: Text(
                    amount,
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 8.0,
                          color: Colors.grey,
                        ),
                      ],
                      color: whiteColor,
                      fontSize: listSubTitle_FontSize,
                      fontWeight: bold_FontWeight,
                      fontFamily: robotoFontFamily,
                    ),
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.transparent,
                      // minimumSize: Size(150, 40),
                    ),
                    onPressed: ()
                    {

                    },
                    child: Wrap(
                      children: [
                        Text(
                          "View",
                          style: TextStyle(
                              color: blackColor,
                              fontWeight: bold_FontWeight,
                              fontSize: listSubTitle_FontSize+3),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.double_arrow,
                          size: listSubTitle_FontSize+5,
                          color: blackColor,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
           
          ),
        ),
      ),
    );
  }

  Card raise_bill_card(
      String title, String subtitle, String image, String btnText) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: darkGreyColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: cardHeight,
        width: cardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xffDBD4A6),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Color(0xff837C4D),
                        fontWeight: FontWeight.bold,
                        fontFamily: viewHeadingFontfamily,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Color(0xff373529),
                        fontWeight: FontWeight.bold,
                        fontFamily: viewHeadingFontfamily,
                        fontSize: textFieldHeadingFontWeight,
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: 40,
                        width: 180,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              backgroundColor: Color(0xff4A451D)),
                          onPressed: () {},
                          child: Wrap(
                            children: [
                              Text(
                                btnText,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ElevatedButtonTextFontWeight),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.double_arrow,
                                size: 22.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Image(width: 100,height: 100,
                  image: AssetImage(Talent_Icon_RupayImage),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Card profile_card(String name, String cjcode) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: darkGreyColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: cardHeight,
        width: cardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Color(0xffFEFEFE),
              Color(0xffE6E6E6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Text(
                "Welcome $name!",
                style: TextStyle(
                  fontFamily: viewHeadingFontfamily,
                  color: proflieCardHeadingColor,
                  fontSize: profileCardHeadingSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CircleAvatar(
              radius: 53.0,
              backgroundImage: AssetImage("assets/images/boyimage.png"),
            ),
            ListTile(
              leading: SizedBox(
                width: 85,
              ),
              title: Row(
                children: [
                  Text(
                    "KYC Verified:",
                    style: TextStyle(
                      fontFamily: viewHeadingFontfamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(width: 5),
                  ImageIcon(
                    AssetImage("assets/icons/tick_icon.png"),
                    color: Colors.blue,
                  )
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "CJ Code: $cjcode",
                  style: TextStyle(
                    fontFamily: viewHeadingFontfamily,
                    fontWeight: FontWeight.bold,
                    fontSize: profileCardCodeSize,
                    color: Colors.black,
                  ),
                ),
              ),
              trailing: Image(
                image: AssetImage("assets/images/kycicon.png"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container carsousal_card(String title, String image, Color g1, Color g2) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: darkGreyColor),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          // height: 100,
          width: carsousalCardWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                g1,
                g2,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: viewHeadingFontfamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Image(image: AssetImage(image))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/
/*------Rajat code end----*/
