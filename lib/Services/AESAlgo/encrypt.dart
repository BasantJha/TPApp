import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:contractjobs/Services/AESAlgo/Keys.dart';
import 'package:encrypt/encrypt.dart';

import '../../Controller/Talents/ModelClasses/CJHubModelClasses/VerifyOTP_ModelResponse.dart';



String getEncryptedData(String textType)
{
  final encrypter = Encrypter(AES(getSecretKey(),mode: AESMode.ecb,padding: 'PKCS7'));
  final encrypted = encrypter.encrypt(textType, iv: getVectorValue());
  String encryptedData=encrypted.base64.toString();
  return encryptedData;
}

String getDecryptedData(String encryptedDataStr)
{
  Encrypted encrypted = Encrypted(base64Decode(encryptedDataStr));
  final encrypter = Encrypter(AES(getSecretKey(),mode: AESMode.ecb,padding: 'PKCS7'));
  final decrypted = encrypter.decrypt(encrypted, iv: getVectorValue());
  String decryptedData=decrypted.toString();
  return decryptedData;
}

Key getSecretKey()
{
  String key = Keys.get_SecretKey;
  final secretKey = Key.fromUtf8(key);
  return secretKey;
}

IV getVectorValue()
{
  String iv = Keys.get_VectorValue;
  final vectorValue = IV.fromUtf8(iv);
  return vectorValue;
}
// ignore: non_constant_identifier_names
String getEncrypted_EmpCode(String empCode)
{
  String encryptedEmpCode=getEncryptedData(empCode);
  return encryptedEmpCode;
}
getTheCompletedEmpCodeByLiveObject(VerifyOTP_ModelResponse liveModelObject)
{
  String completedEmpCode=liveModelObject!.data!.empMobile+getCJHUBKey+liveModelObject!.data!.empCode+getCJHUBKey+liveModelObject!.data!.empDob;
  return completedEmpCode;
}
//
// ignore: missing_return





