
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../Constant/ConstantIcon.dart';
import '../../../../../../Constant/Constants.dart';
import '../../../../../Talents/TalentNavigation/TalentNavigation.dart';
import '../../../../../TankhaPayModule/Controller/ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfileChild.dart';
import 'Employer_NewWorkPlaceAddEmployee.dart';



/*var textStyle_GREY= TextStyle(fontFamily: robotoFontFamily, fontSize: small_FontSize,
  color: addBlackColor, fontWeight: normal_FontWeight,);*/

TextStyle textStyle_GREY()
{
  return TextStyle(fontFamily: robotoFontFamily, fontSize: small_FontSize,
    color: addBlackColor, fontWeight: normal_FontWeight,);
}

TextStyle textStyle_BLACK()
{
  return TextStyle(fontFamily: robotoFontFamily,
    fontSize: small_FontSize,
    color: blackColor,
    fontWeight: normal_FontWeight,);
}

TextStyle textStyle_Orange()
{
  return TextStyle(fontFamily: robotoFontFamily,
    fontSize: small_FontSize,
    color: Colors.orange,
    fontWeight: normal_FontWeight,);
}
/*var textStyle_BLACK=
TextStyle(fontFamily: robotoFontFamily,
  fontSize: small_FontSize,
  color: addBlackColor,
  fontWeight: normal_FontWeight,);*/


Container addEmployeeButton(BuildContext context)
{
  return Container(
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 60,
          width: 190,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
              onPressed: ()
              {
                TalentNavigation().pushTo(context, Employer_NewWorkPlaceAddEmployee());
              },
              label: Text(
                "Add Employee",
                style: TextStyle(
                    fontWeight: bold_FontWeight,
                    color: lightBlueColor,
                    fontSize: medium_FontSize,
                    fontFamily: robotoFontFamily),
              ),

              icon: Image.asset(user_plus_Icon,color: lightBlueColor),
              style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    width: 1.0,
                    color: lightBlueColor,
                  ),
                  backgroundColor: whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20),
                  )),
            ),
          ),
        ),
      ],
    ),
  );
}

var getTheCustomLeaveTemplateForAddEmployee=ListTile(trailing: Text("Create Custom Leave Template",
style: TextStyle(fontSize: 15,
color: darkBlueColor,
fontWeight: semiBold_FontWeight,
fontFamily: robotoFontFamily),),);


var employeeInfoDecoration=BoxDecoration(
    color: whiteColor,
    border: Border(
      bottom: BorderSide(
          width: 3,
          color: darkBlueColor
      ),
      left: BorderSide(
          width: 1,
          color: darkGreyColor
      ),
      right: BorderSide(
          width: 1,
          color: darkGreyColor
      ),
      top: BorderSide(
          width: 1,
          color: darkGreyColor
      ),
    )
);

Padding getTheEmployeeInfoCard(String empName,String empTpCode,String empMobileNo,String profileURL)
{
  String phoneImage_Icon = "assets/cjhubappicons/call.png";

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: Container(
      //height: 150,
        decoration: employeeInfoDecoration,
        padding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 2),
        child: Row(

          children: [
            Expanded(
              child: Container(
                // color: Colors.red,
                padding: EdgeInsets.only(right: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CircleAvatar(
                      child: (profileURL == null || profileURL == "")?
                      Text(getProfileEmpName(empName)):
                      ClipOval(child:Image.network(profileURL, width: 30, height: 30,
                        fit: BoxFit.cover,) ,),
                    ),


                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children:  [
                              Image(image: AssetImage(Employer_Icon_ProfileGrey),width: 20,height: 20,),
                              SizedBox(
                                width: 3,
                              ),
                              Expanded(child: Text("$empName ($empTpCode)",
                                maxLines: 2,
                                style: TextStyle(
                                    color: darkBlueColor,
                                    fontSize: medium_FontSize,
                                    fontFamily: robotoFontFamily,
                                    fontWeight: semiBold_FontWeight
                                ),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Image.asset(phoneImage_Icon,
                                height: 15,width: 15,color: darkGreyColor,),
                              SizedBox(
                                width: 5,
                              ),
                              Text(empMobileNo,
                                style: TextStyle(
                                    fontSize: medium_FontSize,
                                    fontFamily: robotoFontFamily,
                                    color: darkGreyColor
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),)
                  ],
                ),
              ),
            ),
          ],
        )
    ),
  );
}