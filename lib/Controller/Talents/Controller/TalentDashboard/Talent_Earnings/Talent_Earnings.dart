import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/ModelClass/EarningCardData.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_Passbook/Talent_Passbook.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/Messages/Talent_TextMessages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


class Talent_Earnings extends StatefulWidget {
  const Talent_Earnings({super.key});

  @override
  State<Talent_Earnings> createState() => _Talent_Earnings();
}

class _Talent_Earnings extends State<Talent_Earnings> {

  var earning_cards=getEarningCardList;

  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
        appBar:CJAppBar(getTalent_EarningsTitle, appBarBlock: AppBarBlock(appBarAction: ()
    {
      print("show the action type");
      Navigator.pop(context);
    })) ,
   body: Container(color: whiteColor,padding: EdgeInsets.symmetric(horizontal: 15.0,),
     child: ListView(
    children: earning_cards.map((ecd)
    {
     return Column(
         children: [
         SizedBox(height: 15,),
         earningCard(ecd.title.toString(), ecd.subtitle.toString(),
         ecd.image.toString(), ecd.buttontxt.toString(), ecd.page!)
                   ],
                  );
               }).toList(),
               ) ,));

  }

  Card earningCard(String title, String subtitle, String image,
      String button_txt, Widget page) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: darkGreyColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: 180,
        // width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Color(0xffE4EFF5),
              Color(0xff9AC2D8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: darkBlueColor,
                        fontWeight: bold_FontWeight,
                        fontFamily: robotoFontFamily,
                        fontSize: listTitle_FontSize,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontWeight: semiBold_FontWeight,
                        fontFamily: robotoFontFamily,
                        fontSize: listSubTitle_FontSize,
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: 40,
                        width: 170,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              backgroundColor: Color(0xff0F7D9B)),
                          onPressed: ()
                          {

                            TalentNavigation().pushTo(context, page);
                          },
                          child: Wrap(
                            children: [
                              Text(
                                button_txt,
                                style: TextStyle(
                                    fontWeight: bold_FontWeight,
                                    fontSize: 14,fontFamily: robotoFontFamily),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.double_arrow,
                                size: 16.0,
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
                flex: 1,
                child: Padding(padding: EdgeInsets.only(left: 50),child: Image(width: 70,height: 70,
                  image: AssetImage(image),
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
