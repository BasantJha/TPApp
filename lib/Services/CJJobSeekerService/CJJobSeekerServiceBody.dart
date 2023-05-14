
import 'dart:convert';
import 'package:contractjobs/Services/AESAlgo/Keys.dart';
import 'package:contractjobs/Services/AESAlgo/encrypt.dart';
import 'package:contractjobs/Services/LocalizationFile/LocalizationFile.dart';
import '../AESAlgo/EncryptedMapBody.dart';
import 'CJJobSeekerServiceKey.dart';


Map getJS_Intro_RequestBody(String introType,String localizationType)
{
  var dummyBody=Map();
  dummyBody[kJS_ServiceKey_IntroDisplayName]=introType;
  dummyBody[kLoclizationKey]=localizationType;

  return getEncrypted_MapBody(dummyBody);
}
Map getJS_LoginVerifyMobile_RequestBody(String mobileNo)
{
  var dummyBody=Map();
  dummyBody[kJS_ServiceKey_Mobile]=mobileNo;
  return getEncrypted_MapBody(dummyBody);
}

