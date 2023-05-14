import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'format_UpperCaseText.dart';


GlobalKey<FormState> formkey_mobile = GlobalKey<FormState>();
GlobalKey<FormState> formkey_bankAccountNumber = GlobalKey<FormState>();
GlobalKey<FormState> formkey_ifscCode = GlobalKey<FormState>();
GlobalKey<FormState> formkey_panCard = GlobalKey<FormState>();
GlobalKey<FormState> formkey_firstFourNumber = GlobalKey<FormState>();

bool validate_mobile(String value)
{
  if (formkey_mobile.currentState!.validate())
  {
    // No any error in validation
    formkey_mobile.currentState!.save();
    return true;
  } else {
    // validation error
    return false;
  }
}

 validate_Mobile(String value) {
  String patttern = r"^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[6789]\d{9}$";
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Mobile is Required";
  }
  else if (!regExp.hasMatch(value)) {
    return "Please enter valid number";
  }
  return null;
}


validate_name(){
  return [
    FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s",)),
  ];
}

validate_bankAccountNumber(){
  return <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly
  ];
}

validate_ifscCode(){
  return  [
    UpperCaseText(),
    FilteringTextInputFormatter.allow(RegExp(r"[A-Z0-9]",)),
  ];
}

validate_panCard(){
  return  [
    UpperCaseText(),
    FilteringTextInputFormatter.allow(RegExp(r"[A-Z0-9]",),
    ),
    LengthLimitingTextInputFormatter(10),
  ];
}

validate_aadharNumber(){
  return
    [FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(4),
    ];
}

validate_aadharNumberFor_Nominee(){
  return
    [FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(4),
    ];
}

asteriskText(String name) {
  return Text.rich(
    TextSpan(
      text: name,
      children: <InlineSpan>[
        TextSpan(
          text: '*',
          style: TextStyle(color: Colors.red,fontSize: 13),
        ),
      ],
      style: TextStyle(color: Colors.black,fontSize: 13),
    ),
  );
}


/*bool validate_PAN(String value){
  RegExp regex=RegExp(r"^[A-Z]{5}[0-9]{4}[A-Z]{1}");

  if(value.isEmpty){
    return false;
  }
  else if(!regex.hasMatch(value)){
    return false;
  }
  else{
    return true;
  }
}*/

String? validate_PAN(String? value) {
  String patttern = r"^[A-Z]{5}[0-9]{4}[A-Z]{1}";
  RegExp regExp = new RegExp(patttern);

  if (!regExp.hasMatch(value!)) {
    return "Please enter valid PAN Card";
  }
  return null;
}

bool validate_PANCard()
{

  if (formkey_panCard.currentState!.validate())
  {
    // No any error in validation
    formkey_panCard.currentState!.save();
    return true;
  }
  else
  {
    // validation error
    return false;
  }
}

 validate_firstFourAadharNumber(String? value)
 {
  String patttern = r"^[2-9]{1}[0-9]{3}$";
  RegExp regExp = new RegExp(patttern);

  if (!regExp.hasMatch(value!)) {
    //return "Enter valid Aadhaar";
    return "";

  }
  return null;
}

bool validate_firstFourAadharNo(String value) {
  if (formkey_firstFourNumber.currentState!.validate()) {
    // No any error in validation
    formkey_firstFourNumber.currentState!.save();
    return true;
  } else {
    // validation error
    return false;
  }
}

/*bool validate_bankAccno(String value) {
  if (formkey_bankAccountNumber.currentState.validate()) {
    // No any error in validation
    formkey_bankAccountNumber.currentState?.save();
    return true;
  } else {
    // validation error
    return false;
  }
}*/

 validate_bankAccNumber(String value) {
  String patttern = r"^\d{9,18}$";
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Bank Account Number is Required";
  }
  else if (!regExp.hasMatch(value)) {
    return "Please enter valid account number";
  }
  return null;
}

/*bool validate_IFSC(String value) {
  if (formkey_ifscCode.currentState.validate()) {
    // No any error in validation
    formkey_ifscCode.currentState.save();
    return true;
  } else {
    // validation error
    return false;
  }
}*/

 validate_IFSCCode(String value) {
  String patttern = r"^[A-Z]{4}0[A-Z0-9]{6}$";
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "IFSC Code is Required";
  }
  else if (!regExp.hasMatch(value)) {
    return "Please enter valid IFSC Code";
  }
  return null;
}

