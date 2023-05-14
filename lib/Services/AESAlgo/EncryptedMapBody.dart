import 'dart:convert';

import 'Keys.dart';
import 'encrypt.dart';

Map getEncrypted_MapBody(Map dummyBody)
{
  var jsonEncodeData=json.encode(dummyBody);
  String encodedBody = getEncryptedData(jsonEncodeData) ;

  print("show the json encoded data $jsonEncodeData");
  var originalBody=Map();
  originalBody["encrypted"]=encodedBody;

  print("show the request $originalBody");
  return originalBody;
}

String getEncrypted_EmpCodeTankhaPay(String mobileNo,String empCode,String dateOfBirth)
{
  var completeEmpCode=mobileNo+getCJHUBKey+empCode+getCJHUBKey+dateOfBirth;
  return getEncrypted_EmpCode(completeEmpCode);
}
String getEncrypted_EmpCodeByLiveObjectTankhaPay(String completeEmpCode)
{
  return getEncrypted_EmpCode(completeEmpCode);
}
String getEncrypted_EmpCodeSalaryDetailsTankhaPay(String completeEmpCode,String month,String year)
{
  var salaryDetailsEmpCode=completeEmpCode+getCJHUBKey+month+getCJHUBKey+year;

  print("show the salary details $salaryDetailsEmpCode");
  return getEncrypted_EmpCode(salaryDetailsEmpCode);
}