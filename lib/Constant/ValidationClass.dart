

import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import '../CustomView/Messages/Validation_Messages.dart';


 String? validateToAddress(value)
 {
  String pattern = r'(^[0-9,a-z A-Z.\-/=\;]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value == null || value.trim().length == 0) {
    return validateMsg_address;
  } else if (value.length <= 3) {
    return validateMsg_validAddress;
  } else if (!regExp.hasMatch(value)) {
    return validateMsgmatch_address;
  }
  return null;
 }

  String? validateToName(fullName)
  {

   /* String pattternforspace = r'^([A-Za-z]+ )+[A-Za-z]+$|^[A-Za-z]+$';
    RegExp regExpforspace = new RegExp(pattternforspace);
    var name = fullName!.trim();


    if (name.length == 0 || name.length < 3) {
      return validateMsg_validName;
    }

    else if (fullName.contains(" ")) {
      if (!regExpforspace.hasMatch(fullName) ||
          !regExpwithoutspace.hasMatch(fullName)) {
        return validateMsg_validName;
      }

      else {
        return null;
      }
    }

    else if (fullName.contains("")) {
      if (!regExpwithoutspace.hasMatch(fullName)) {
        return validateMsg_validName;
      }
      else {
        return null;
      }
    }

    else {
      return null;
    }*/

    String pattternforspace = r'^([A-Za-z]+ )+[A-Za-z]+$|^[A-Za-z]+$';


    RegExp regExpforspace = new RegExp(pattternforspace);

    var name = fullName!.trim();

    print("Name entered : $name");


    if (name.length == 0 || name.length<3)
    {
      return "Enter Valid Name";
    }

    else if(fullName!.contains(" "))
    {
      fullName=fullName.toString().trim();
      if (!regExpforspace.hasMatch(fullName))
      {
        return "Enter Valid Name";

      }
      else
      {
        return null;
      }
    }
  }

String? validateToLastName(fullName)
{


  String pattternforspace = r'^([A-Za-z]+ )+[A-Za-z]+$|^[A-Za-z]+$';


  RegExp regExpforspace = new RegExp(pattternforspace);

  var name = fullName!.trim();

  print("Name entered : $name");


  if (name.length == 0 || name.length<3)
  {
    return "Enter Valid Last Name";
  }

  else if(fullName!.contains(" "))
  {
    fullName=fullName.toString().trim();
    if (!regExpforspace.hasMatch(fullName))
    {
      return "Enter Valid Last Name";

    }
    else
    {
      return null;
    }
  }
}

String? validateToJobRole(fullName)
{



  String pattternforspace = r'^([A-Za-z]+ )+[A-Za-z]+$|^[A-Za-z]+$';


  RegExp regExpforspace = new RegExp(pattternforspace);

  var name = fullName!.trim();

  print("Name entered : $name");


  if (name.length == 0 || name.length<3)
  {
    return "Enter Job Role";
  }

  else if(fullName!.contains(" "))
  {
    fullName=fullName.toString().trim();
    if (!regExpforspace.hasMatch(fullName))
    {
      return "Enter Valid Job Role";

    }
    else
    {
      return null;
    }
  }
}
//
String? validateToJoiningDateOld(String? value)
{
  String errorMsg="Please enter the Salary Start Date current month\nand 30 days after the present date";
  if(value!.isEmpty)
  {
    return errorMsg;
  }
  print("value ${value!.length}");
  var dayMonthYear = value!.split('/');
  var day = dayMonthYear[0];
  var month = dayMonthYear[1];
  var year = dayMonthYear[2];
  var dateTimeNow  = DateTime.now();
  var currentDay = dateTimeNow.day<10 ? "0${dateTimeNow.day}": "${dateTimeNow.day}";
  var currentMonth = dateTimeNow.month<10 ? "0${dateTimeNow.month}": "${dateTimeNow.month}";
  var currentYear = "${dateTimeNow.year}";
  var lastDayOfCurrentMonth = DateTime(dateTimeNow.year,dateTimeNow.month+1,0).day;

  if(int.parse(year)> int.parse(currentYear) || int.parse(year) < int.parse(currentYear))
  {
    return errorMsg;
  }
  else if(int.parse(year) == int.parse(currentYear))
  {
    if(int.parse(month) > int.parse(currentMonth) || int.parse(month) < int.parse(currentMonth))
    {
      return errorMsg;
    }
    else if(int.parse(day) < 1 || int.parse(day)> lastDayOfCurrentMonth)
    {
      return errorMsg;
    }
  }

  return null;
}

String? validateToJoiningDate(String? value)
{

  String errorMsg="Please enter a salary start date within the current\nmonth or up to 30 days after today.";
  if(value!.isEmpty)
  {
    return errorMsg;
  }
  print("value ${value!.length}");
  var dayMonthYear = value!.split('/');
  var day = int.parse(dayMonthYear[0]);
  var month = int.parse(dayMonthYear[1]);
  var year = int.parse(dayMonthYear[2]);
  var enteredDay = DateTime(year,month,day);
  var dateTimeNow  = DateTime.now();
  var currentMonthFirstDay = DateTime(dateTimeNow.year,dateTimeNow.month,1);
  var dateTimeLastThirtyDay = DateTime(dateTimeNow.year,dateTimeNow.month,dateTimeNow.day).add(Duration(days: 30));
  print("Current Month firstDay $currentMonthFirstDay");

  print("Entered Day is less than current Month Day ${enteredDay.isBefore(currentMonthFirstDay)}");
  print("Entered Day is greater than last Thirty Day ${enteredDay.isAfter(dateTimeLastThirtyDay)}");

  if(enteredDay.isBefore(currentMonthFirstDay) || enteredDay.isAfter(dateTimeLastThirtyDay))
  {
    return errorMsg;
  }

  return null;
}

String? validateEmailForAddEmployee(String? value) {
  const pattern =r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final regex = RegExp(pattern);

  return value!.isNotEmpty && !regex.hasMatch(value)
      ? 'Enter valid email address'
      : null;
}

String? validateEmailId(value)
{

  //const pattern=r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  const pattern=r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-a-z]+\.[a-zA-Z]+";
//~!$%^&*_=+}{'?-

  final regex = RegExp(pattern);

  print("show the email address $value");

  if (value.length == 0 || value==null)
  {
    return "Enter Email Address";
  }
  else  if (!regex.hasMatch(value))
    {
      return "Enter Valid Email Address";
    }
    else
    {
      return null;
    }


}
String? validateToCompanyName(value)
{

  String pattternforspace = r'^([A-Za-z.0-9]+ )+[A-Za-z.0-9]+$|^[A-Za-z.0-9]+$';
  RegExp regExpforspace = new RegExp(pattternforspace);
  var name = value!.trim();
  print("Name entered : $name");
  if (name.length == 0 || name.length<5)
  {
    return "Enter Valid CompanyName";
  }
  else if(value!.contains(" "))
  {
    if (!regExpforspace.hasMatch(value))
    {
      return "Enter Valid CompanyName";
    }
    else
    {
      return null;
    }
  }
}

String? validateToWebsite( value) {
  // String pattern = r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
  String pattern = r'[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
  RegExp regExp = new RegExp(pattern);
  if (value == null || value.length == 0) {
    return validateMsg_companyWebsite;
  }
  else if (!regExp.hasMatch(value)) {
    return validateMsg_validCompanyWebsite;
  }
  return null;
}

String? validateToAccountNo(value) {
  String patttern = r"[0-9]{9,18}";
  RegExp regExp = new RegExp(patttern);

  if (value.length == 0) {
    return validAccNoMsg;
  } else if (!regExp.hasMatch(value)) {
    return validAccNo_validateMsg;
  }
  return null;
}
String? validateToIFSC(value) {
  String patttern = r"^[A-Z]{4}0[A-Z0-9]{6}$";
  RegExp regExp = new RegExp(patttern);

  if (value.length == 0) {
    return validIFSC;
  } else if (!regExp.hasMatch(value)) {
    return validIFSC_validmsg;
  }
  return null;
}
  /*String? validateToMobileNo(value)
  {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

    RegExp regExp = new RegExp(patttern);

    if (value.length == 0) {
      return validateMsg_mobileNo;
    }
    else if (!regExp.hasMatch(value)) {
      return validateMsg_validMobileNo;
    }
    return null;
  }*/
//
String? validateToMobileNo(value)
{
  //String patttern = r'(^[0-9]*$)';
  String patttern = r"^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[6789]\d{9}$";

  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
   // return "Mobile Number is Required";
    return validateMsg_mobileNo;

  } else if(value.length != 10){
    return "Mobile number must be 10 digits";
  }else if (!regExp.hasMatch(value))
  {
   // return "Please enter valid mobile number";
    return validateMsg_validMobileNo;
  }
  return null;
}

  bool  validateToEmailId(String val)
  {
    if (val.isEmpty)
    {
      print(val);
      print(validateMsg_email);
      return false;
    }
    else if (EmailValidator.validate(val, true))
    {
      print(val);
      print(validateMsg_email);
      return false;
    }
    return true;
  }

String? validateToPan( value)
{
  String pattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
  RegExp regExp = new RegExp(pattern);
  if (value == null || value.length == 0) {
    return validateMsg_panNumber;
  }
  else if (!regExp.hasMatch(value)) {
    return validateMsg_validPanNumber;
  }
  return null;
}


String? validateToUANNumber( value)
{
  String pattern = r'^[0-9]{12}$';
  RegExp regExp = new RegExp(pattern);
  if (value == null || value.length == 0)
  {
    return validateMsg_UANNumber;
  }
  else if (!regExp.hasMatch(value))
  {
    return validateMsg_ValidUANNumber;
  }
  return null;
}
String? validateToPincode( value) {
  String pattern = r'^[0-9]{6}$';
  RegExp regExp = new RegExp(pattern);
  if (value == null || value.length == 0) {
    return validateMsg_PinCode;
  }
  else if (!regExp.hasMatch(value)) {
    return validateMsg_ValidPinCode;
  }
  return null;
}

String? validateToGst( value) {
  String pattern = r'(^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$)';
  RegExp regExp = new RegExp(pattern);
  if (value == null || value.length == 0)
  {
    return validateMsg_gstNumber;
  }
  else if (!regExp.hasMatch(value))
  {
    return validateMsg_validGstNumber;
  }
  return null;
}

class UpperCaseTxt extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue txtOld, TextEditingValue txtNew){
    return txtNew.copyWith(text: txtNew.text.toUpperCase());
  }


}

class UpperCaseTxt1 extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue txtOld, TextEditingValue txtNew){
    return txtNew.copyWith(text: txtNew.text.toLowerCase());
  }


}





class UANValidatorClass
{
  var UANMulti = [
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
    [2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
    [3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
    [4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
    [5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
    [6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
    [7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
    [8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
    [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
  ];
  var UANPerm = [
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
    [5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
    [8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
    [9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
    [4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
    [2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
    [7, 0, 4, 6, 9, 1, 3, 2, 5, 8]
  ];
  var i, j, x;

  bool validateUAN(String UANNum)
  {
    if (UANNum.length == 12 && RegExp(r'^[0-9]+$').hasMatch(UANNum)) {
      try {
        i = UANNum.length;
        j = 0;
        x = 0;
        print("i$i");
        while (i > 0) {
          i -= 1;
          String curr = UANNum[i];
          var index = int.parse(curr);
          x = UANMulti[x][UANPerm[(j % 8)][index]];
          j += 1;
        }
        print("x$x");
        if (x == 0) {
          return true;
        } else {
          return false;
        }
      } on Exception catch (_)
      {
        print("Invalid UAN Number");
      }
    }
    return false;
  }


}