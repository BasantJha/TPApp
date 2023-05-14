

import 'dart:io';
import 'dart:typed_data';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info/device_info.dart';
//import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:file_picker/file_picker.dart';

import '../../Services/Messages/Message.dart';



class Method {


  static showNetworConnectionAlert(BuildContext context)
  {
    var alertDialog = AlertDialog(
      content: Text(Message.get_NetworkConnectionMessage,
        textAlign: TextAlign.left,),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))
      ),

      actions: [

        TextButton(onPressed: () {

          Navigator.of(context).pop();
        },

          child: Text("OK",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
      ],

    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog

    );
  }


  static snackBar_OkText(BuildContext context, String message){
    /*------SnackBar-----21-07-2022--------start-----------*/

    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    /*-----SnackBar------21-07-2022--------end-----------*/
  }

  static snackBar_failureForVerifyMobile(BuildContext context, String message){
    /*------SnackBar-----21-07-2022--------start-----------*/

    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    /*-----SnackBar------21-07-2022--------end-----------*/
  }

  static Future<String> getDeviceId() async
  {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS)
    { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    }
    else
    {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  static Future<String> getIPAddress() async
  {
    final ipv4 = await Ipify.ipv4();
    // //print(ipv4); // 98.207.254.136

    //final ipv6 = await Ipify.ipv64();
    ////print(ipv6); // 98.207.254.136 or 2a00:1450:400f:80d::200e

    //final ipv4json = await Ipify.ipv64(format: Format.JSON);
    ////print(ipv4json); //{"ip":"98.207.254.136"} or {"ip":"2a00:1450:400f:80d::200e"}

    // The response type can be text, json or jsonp

    return ipv4;

  }

  //USE FOR THE Employer list(suspended,exit,resume)
  static String getCurrentDateYear()
  {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy');
    String currentYear = formatter.format(now);
    return currentYear;
  }

  static String getCurrentYear()
  {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    String currentYear = formatter.format(now);
    return currentYear;
  }

  static String getRelationType(String check)
  {
    String value="";
    if (check=="Spouse")
    {
      value="SPSE";
    }else  if (check=="Son")
    {
      value="SONM";
    }
    else  if (check=="Daughter")
    {
      value="UDTR";
    }
    return value;
  }


  static String getAge_ByDateOfBirth(String birthDateString) {
    String datePattern = "dd/MM/yyyy";

    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    return yearDiff.toString();

  }

  static String changeTheDateFormat_ForInvestmentDeclaration(String parseDate)
  {
    String strDate="";

    String datePattern = "dd/MM/yyyy";
    var birthDate = DateFormat(datePattern).parse(parseDate);

    var outputFormat=  DateFormat("yyyyMMdd");
    strDate= outputFormat.format(birthDate);

    return strDate;

  }

  static String getTheCurrentDate_ForInvestmentDeclaration()
  {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyyMMdd');
    String currentYear = formatter.format(now);
    return currentYear;
  }

  static String getTheCurrentDate_ForManualBankTransfer()
  {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd MMM yyyy,hh:mm aa');
    String currentYear = formatter.format(now);
    return currentYear;
  }

  static String changeTheDateFormat_ForUploadInvestmentDeclaration(String parseDate)
  {
    String strDate="";

    String datePattern = "MM/dd/yyyy";
    var birthDate = DateFormat(datePattern).parse(parseDate);

    var outputFormat=  DateFormat("dd/MM/yyyy");
    strDate= outputFormat.format(birthDate);

    return strDate;

  }
  static String changeTheDateFormat_ForInsuranceIdCardExpiredDate(String parseDate)
  {
    String strDate="";

    String datePattern = "dd MMM yyyy";
    var birthDate = DateFormat(datePattern).parse(parseDate);

    var outputFormat=  DateFormat("yyyyMMdd");
    strDate= outputFormat.format(birthDate);

    return strDate;

  }
  static String changeTheDateFormat_ForAadhaarCard(String parseDate)
  {
    String strDate="";

    String datePattern = "yyyy-MM-dd";
    var birthDate = DateFormat(datePattern).parse(parseDate);

    var outputFormat=  DateFormat("dd/MM/yyyy");
    strDate= outputFormat.format(birthDate);

    return strDate;

  }

  static int getStartYear()
  {
    return 2021;
  }
  static int getEndYear()
  {
    return 2030;
  }

  static int getStartYearFor_HomeLoan()
  {
    return 2000;
  }
  static int getEndYearFor_HomeLoan()
  {
    return 2060;
  }
/*------------------every download use for whole app start 29-11-2021 start--------------*/
  static double fontSize_DropDownItem()
  {
    return 13;
  }
/*------------------every download use for whole app start 29-11-2021 end--------------*/


/*-------------7-12-2021 start---------------*/

  static String getUpload_checkDefaultCase()
  {
    return "DefaultLoadAdd";
  }
  static String getUpload_UserArriveFromView_ToAddHouseLoan()
  {
    return "DynamicLoadAddHouseLoan";
  }
  static String getUpload_UserArriveFromView_ToAddRentDetails()
  {
    return "DynamicLoadAddRentDetails";
  }

  static String getUpload_UserArriveFromView_ToAddChapterVI()
  {
    return "DynamicLoadAddChapterVI";
  }
  static String getUpload_UserArriveFromView_ToAddUS80C()
  {
    return "DynamicLoadAddUS80C";
  }
/*-------------7-12-2021 end---------------*/

/*-------29-1-2022 START-----------*/
  static int getImageQuality()
  {
    return 50;
  }

/*-------29-1-2022 END-----------*/

}