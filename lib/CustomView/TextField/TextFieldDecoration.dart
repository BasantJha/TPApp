import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_RaiseBill/Talent_RaiseBillChooseEmployer.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:flutter/material.dart';


InputDecoration getTextFieldDecoration(String hintText)
{
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(fontFamily: robotoFontFamily,
          color: textFieldHintTextColor, fontSize: medium_FontSize),

      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: darkGreyColor,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ));
}
InputDecoration getTextFieldDecorationWithDisable(String hintText)
{
  return InputDecoration(fillColor: lightGreyColor,
      filled: true,
      hintText: hintText,
      hintStyle: TextStyle(fontFamily: robotoFontFamily,
          color: textFieldHintTextColor, fontSize: medium_FontSize),

      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: darkGreyColor,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ));
}


InputDecoration getTextFieldDecorationWithPrefixIcon(String iconName,String hintText)
{
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(fontFamily: robotoFontFamily,
          color: darkGreyColor, fontSize: 16.0),
      prefixIcon:IconButton(
        icon: new Image.asset(iconName,width: 18.0,height: 18.0,),
        onPressed: null,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: textFieldBorderColor,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ));
}
InputDecoration getTextFieldDecorationWithSuffixIcon<T>(String iconName,String hintText,BuildContext context, T navigationView){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(fontFamily: robotoFontFamily,
      color: Colors.grey,fontWeight: bold_FontWeight,),
    suffixIcon: Container(
      height: 30.0,
      width: 30.0,
     /* decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(iconName),
        ),
      ),*/
      child: IconButton(
        icon: Image.asset(iconName),
        onPressed: ()
        {
          TalentNavigation().pushTo(context, navigationView);

        },
      ),

    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 2.0),
      borderRadius: BorderRadius.circular(20.0),
    ),
  );
}
//
InputDecoration getLoginTextFieldDecoration()
{
  return InputDecoration(
      labelText: 'Mobile Number',
      labelStyle: TextStyle(fontSize: 18, fontWeight: bold_FontWeight, color: Colors.grey,fontFamily: robotoFontFamily,),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: textFieldBorderColor,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      hintText: 'Mobile Number',
      prefixIcon: Container(/*color: Colors.red,*/padding: EdgeInsets.only(left: 5),width: 60,child: Row(children:
      [
        Container(width: 20,child: Image(image: AssetImage("ind.png"),),),
        Container(/*color: Colors.red,*/width: 34,child: Text("+91",textAlign: TextAlign.center,style: TextStyle(fontWeight: bold_FontWeight,fontSize: 12),),),
        //Container(/*color: Colors.blue,*/width: 25,child: Icon(Icons.arrow_drop_down_sharp,color: Colors.black))

      ],),

      ),

  );
}

