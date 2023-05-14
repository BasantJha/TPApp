
//import 'dart:html';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/Employers/Controller/EmployerDashboard/Employees_Payments/Employees_SelectEmployeePayment.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
import 'package:flutter/material.dart';


class Employees_SelectEmployeesList extends StatefulWidget
{
  @override
  State<Employees_SelectEmployeesList> createState() => _Employees_SelectEmployeesList();
}

class _Employees_SelectEmployeesList extends State<Employees_SelectEmployeesList>{

  String imagegecontact = Employer_Icon_SelectEmployeeListIcon;
  String usericon = Employer_Icon_ProfileGrey;
  String emailicon = Employer_Icon_EmailGrey;
  String phoneicon = phone_Icon_Grey;

  late  List<Card> usercard = [
    contactUi(imagegecontact,"Sukhdeep Singh","CJ09488888585","57575467567","bafafsf@g.com"),
    contactUi(imagegecontact,"Sukhdeep Singh","CJ09488888585","57575467567","bafafsf@g.com"),
    contactUi(imagegecontact,"Sukhdeep Singh","CJ09488888585","57575467567","bafafsf@g.com"),
  ];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar:CJAppBar(getEmployer_SelectEmployeePayments, appBarBlock: AppBarBlock(appBarAction: ()
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

  SingleChildScrollView MainfunctionUi(){
    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [

              Center(child:getViewHintTextBlue(getEmployer_SelectEmployeeListHint),),

              SizedBox(
                height: 20,
              ),
              Card(
                child: TextField(
                  textAlign: TextAlign.left,
                  onChanged: (value){
                    // _runFilter(value);
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: twoHunGreyColor,
                      suffixIcon: Container(
                          child:  IconButton(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: Align(
                              alignment: Alignment.centerLeft,
                              child: ImageIcon(
                                AssetImage(search_Icon),
                              ),
                            ),
                          )
                      ),
                      hintText: 'Search Employee',
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  itemCount: usercard.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index)
                  {
                    return InkWell(onTap: ()
                      {
                        TalentNavigation().pushTo(context, Employees_SelectEmployeePayment());

                      },child:Column(
                      children: [
                        usercard[index],
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ) ,);
                   /* return Column(
                      children: [
                        usercard[index],
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );*/
                  }
              )
            ],
          ),
        )
    );
  }
  contactUi(String image,String name,String id,String mobilenumber,String email)
  {
    return Card(
      elevation: 2,
      child: Container(
        height: 70,
        child: ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(image)
          ),
          title: Row(
            children: [
              Image.asset(usericon),
              SizedBox(
                width: 2,
              ),
              Expanded(
                  child: Text("$name ($id)",
                    style: TextStyle(
                        fontFamily: robotoFontFamily,
                        fontSize: small_FontSize,
                        fontWeight: semiBold_FontWeight,
                        color: darkBlueColor
                    ),
                  )
              )
            ],
          ),
          subtitle: Padding(padding: EdgeInsets.only(top: 6),child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(phoneicon,height: 12,width: 12,color:Color(0xff969696),),
                    SizedBox(
                      width: 1,
                    ),
                    Text("$mobilenumber",
                      style: TextStyle(color:Color(0xff969696),fontSize: 12,
                          fontWeight: normal_FontWeight,
                          fontFamily: robotoFontFamily
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Image.asset(emailicon,height: 20,width: 20,color:Color(0xff969696),),
                    SizedBox(
                      width: 1,
                    ),
                    Expanded(
                      child: Text("$email",
                        style: TextStyle(color:Color(0xff969696),fontSize: 12,
                            fontWeight: normal_FontWeight,
                            fontFamily: robotoFontFamily
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),),
        ),
      ),
    );
  }


}