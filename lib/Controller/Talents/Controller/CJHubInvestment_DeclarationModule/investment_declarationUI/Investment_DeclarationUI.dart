import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../Constant/CJHub_ConstantIcon.dart';
import '../../../../../Constant/Constants.dart';

class Investment_DeclarationUI
{


  static  Column create_dataTableSub1(String value){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          create_uperDownSpace(),

          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(value, style: TextStyle(color: Colors.black,fontSize: 12)),
          ),

          create_uperDownSpace(),
        ]);
  }

  static SizedBox create_uperDownSpace(){
    return SizedBox(
      height: 10,
    );
  }
  SizedBox create_SpaceBetweenWords(){
    return SizedBox(
      height: 2,
    );
  }
  static Container create_Text(String value){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,0,10,15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(value,style: TextStyle(color: Colors.grey[500],fontSize: 12),),
          ],
        ),
      ),
    );
  }

  static Container create_headingContainer(String value){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,20,0,0),
        child: Row(
          children: [
            SizedBox(
              width: 20.0,
              height: 20.0,
              child: Image.asset(getCJHub_LineIcon,
              ),
            ),
            SizedBox(
                width: 1.0),
            Expanded(
              flex: 1,
              child: Text(value,
                style: TextStyle(color: Colors.black,fontSize: 15),),
            ),
          ],
        ),
      ),
    );
  }

  static Container create_salaryBannerContainer(String value,Color bannerTextColorType){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,10,10,10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: double.maxFinite,
                // color: bannerColor,
                decoration: BoxDecoration(
                  color: bannerColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 5,top: 7,bottom: 7,right: 5),
                  child: Text(value,style: TextStyle(color: bannerTextColorType),),
                )
            )
          ],
        ),
      ),
    );
  }

  static Container create_empCodePanTxtContainer(String key1, String key2){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,0,10,5),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Expanded(
          flex: 1,
          child:  Container(
            color: Colors.lightGreenAccent,
            width: 500,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(key1,style: TextStyle(color: primaryColor,fontSize: 15),),
                  ),
                ]
            ),
          )

          ),

            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 90),
                    child:Text(key2,style: TextStyle(color: primaryColor,fontSize: 15),) ,
                  )
                ],
              ),


          ],
        ),
      ),
    );
  }
  static Container create_empCodePanButtonContainer(String value1, String value2){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,0,10,10),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.grey[300],
              child:MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  minWidth: 160,
                  // padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {},
                  child: Padding(
                      padding: EdgeInsets.only(right: 80),
                      child:Text(value1,
                          style: TextStyle(fontFamily: 'Vonique',color: Colors.black,fontSize: 14))
                  )
              ),
            ),
            Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.grey[300],
              child:MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  minWidth: 160,
                  // padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {},
                  child: Padding(
                      padding: EdgeInsets.only(right: 50),
                      child:Text(value2,
                          style: TextStyle(fontFamily: 'Vonique',color: Colors.black,fontSize: 14))
                  )
                /*child:Text(value2,textAlign: TextAlign.left,
                          style: TextStyle(fontFamily: 'Vonique',color: Colors.black,fontSize: 14))
*/

              ),
            ),
          ],
        ),
      ),
    );
  }

  static Container create_TaxCalculated(String value){
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,10,10,15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }

}