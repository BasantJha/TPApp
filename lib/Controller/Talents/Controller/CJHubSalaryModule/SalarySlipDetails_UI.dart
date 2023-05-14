
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Constant/Constants.dart';

class SalarySlipDetails_UI
{

  static SizedBox create_uperDownSpace(){
    return SizedBox(
      height: 7,
    );
  }


  static SizedBox create_SpaceBetweenWords(){
    return SizedBox(
      height: 2,
    );
  }

  static Column create_dataTableSub1(String key, String value,double fontsize){

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          create_uperDownSpace(),

          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Text(key, style: TextStyle(color: Color(0xff32AAE0),fontSize: fontsize)),
          ),

          create_SpaceBetweenWords(),

          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Text(value,style: TextStyle(fontWeight: FontWeight.normal,fontSize: fontsize),),
          ),


          create_uperDownSpace(),
        ]);
  }

  static Container create_subHeadAmount(String key1, String value1,String value2,String value3, String key2, String value){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 10,right: 10),
      child: Table(
        textDirection: TextDirection.ltr,
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.symmetric(inside: BorderSide(width: 1, color: twoHunGreyColor),
          outside: BorderSide(width: 1, color: twoHunGreyColor),),
        children: [
          TableRow(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: <Widget>[
                      create_uperDownSpace(),

                      Padding(
                        padding: EdgeInsets.only(left: 3.0),
                        child: Text(key1, style: TextStyle(color: Color(0xff32AAE0),fontSize: 10)),
                      ),



                      create_uperDownSpace(),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 3.0),
                        child: Text(value1,style: TextStyle(fontSize: 10),),
                      ),
                      create_uperDownSpace(),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 3.0),
                        child: Text(value2,style: TextStyle(fontSize: 10),),
                      ),
                      create_uperDownSpace(),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 3.0),
                        child: Text(value3,style: TextStyle(fontSize: 10),),
                      ),
                      create_uperDownSpace(),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 3.0),
                        child: Text(key2, style: TextStyle(color: Color(0xff32AAE0),fontSize: 10)),
                      ),
                      create_uperDownSpace(),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 3.0),
                        child: Text(value,style: TextStyle(fontSize: 10),),
                      ),
                      create_uperDownSpace(),
                    ]),

              ]),
        ],
      ),
    );
  }

  static Container create_totalEarn(String key1,String value1,String value2,String value3, String key2, String value){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 10,right: 10),
      child: Table(
        textDirection: TextDirection.ltr,
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.symmetric(inside: BorderSide(width: 1, color: twoHunGreyColor),
          outside: BorderSide(width: 1, color: twoHunGreyColor),),
        children: [
          TableRow(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(key1,textAlign: TextAlign.center ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                      ),
                      create_uperDownSpace(),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0,top: 5),
                        child: Text(value1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                      ),
                      create_uperDownSpace(),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0,top: 5),
                        child: Text(value2,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                      ),
                      create_uperDownSpace(),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0,top: 5),
                        child: Text(value3,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                      ),
                      create_uperDownSpace(),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(key2, textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                      ),
                      create_uperDownSpace(),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0,top: 5),
                        child: Text(value,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                      ),
                      create_uperDownSpace(),
                    ]),

              ]),
        ],
      ),
    );
  }

  static Container create_headAmount(String head1,String monthlyRate,String amonut1,String arrears, String head2, String amount2){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 10,right: 10),
      child: Table(
        border: TableBorder.symmetric(inside: BorderSide(width: 1, color: twoHunGreyColor),
          outside: BorderSide(width: 1, color: twoHunGreyColor),),
        children: [
          TableRow(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(head1, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                      ),
                      create_uperDownSpace(),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(monthlyRate, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                      ),
                      create_uperDownSpace(),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(amonut1,  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                      ),
                      create_uperDownSpace(),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(arrears,  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                      ),
                      create_uperDownSpace(),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(head2, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                      ),
                      create_uperDownSpace(),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      create_uperDownSpace(),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(amount2, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                      ),
                      create_uperDownSpace(),
                    ]),

              ]),
        ],
      ),
    );
  }

  static Container create_earnDed(String key, String value){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 10,right: 10,top: 10),
      child: Table(
        border: TableBorder.symmetric(inside: BorderSide(width: 1, color: twoHunGreyColor),
          outside: BorderSide(width: 1, color: twoHunGreyColor),),

        columnWidths: {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(2),
        },

        children: [
          TableRow(children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  create_uperDownSpace(),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(key, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                  ),
                  create_uperDownSpace(),
                ]),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  create_uperDownSpace(),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(value, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                  ),
                  create_uperDownSpace(),
                ]),
          ]),
        ],
      ),
    );
  }

  static Container create_bankDetail(String key, String value){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 10,right: 10),
      child: Table(
        border: TableBorder.symmetric(inside: BorderSide(width: 1, color: twoHunGreyColor),
          outside: BorderSide(width: 1, color: twoHunGreyColor),),
        children: [
          TableRow(children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  create_uperDownSpace(),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(key, style: TextStyle(color: Color(0xff32AAE0),fontSize: 10)),
                  ),
                  create_uperDownSpace(),
                ]),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  create_uperDownSpace(),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(value, textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                  ),
                  create_uperDownSpace(),
                ]),
          ]),
        ],
      ),
    );
  }

  static Container create_disclaimer(String key){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 10,right: 10),
      child: Table(
        border: TableBorder.symmetric(inside: BorderSide(width: 1, color: twoHunGreyColor),
          outside: BorderSide(width: 1, color: twoHunGreyColor),),
        children: [
          TableRow(children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  create_uperDownSpace(),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(key, style: TextStyle(color:Colors.black,fontSize: 10,fontWeight: FontWeight.bold)),
                  ),
                  create_uperDownSpace(),
                ]),
          ]),
        ],
      ),
    );
  }
}

