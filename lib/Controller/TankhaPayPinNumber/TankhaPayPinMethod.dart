

import 'package:contractjobs/Services/AESAlgo/encrypt.dart';

String createTheTankhaPayEmployeePin(String mobileNumber,String pinNumber)
{
  //T means 20=2+0=2(last 2nd element), Y means 25=2+5=7 (start 7th element)==279

 /* String totalNo="1234567890";
  String pinnumber="1234";*/

  var mobileList=mobileNumber.split("");

  var y_number=mobileList[6];
  var t_number=mobileList[8];

  var pinNumberList=pinNumber.split("");
  var firstObj=pinNumberList[2];
  var secondObj=pinNumberList[3];

  pinNumberList[2]=y_number;
  pinNumberList[3]=t_number;

  mobileList[6]=firstObj;
  mobileList[8]=secondObj;

  int i=0;
  String finalMobileNo="";
  String finalPinNo="";

  for(i=0;i<mobileList.length;i++)
  {
    finalMobileNo=finalMobileNo+mobileList[i];

    if(i<=3)
    {
      finalPinNo=finalPinNo+pinNumberList[i];
    }
  }

  //finalMobileNo=finalMobileNo+"TP279"+finalPinNo;

  return finalMobileNo+"TP279"+finalPinNo;
/*//
  print('show the split pinNumberList $pinNumberList');
  print('show the split mobileList $mobileList');

  print('show the  finalMobileNo $finalMobileNo');*/
}

String getDecryptedTankhaPayMobileNo(String mobileNo)
{
  /*========reverse function start=======*/

  int i=0;
  String finalMobileNo=getDecryptedData(mobileNo);
  String revFinalMobileNo = "";

  if(finalMobileNo.length>=19)
  {
    var splitLenght = finalMobileNo.split("TP279");
    var getMobileNoList = splitLenght[0].split("");
    var getPinNoList = splitLenght[1].split("");
    var getFirstPinTempObj = getPinNoList[2];
    var getSecondPinTempObj = getPinNoList[3];

    getMobileNoList[6] = getFirstPinTempObj;
    getMobileNoList[8] = getSecondPinTempObj;

    for (i = 0; i < getMobileNoList.length; i++) {
      revFinalMobileNo = revFinalMobileNo + getMobileNoList[i];
    }
    /*========reverse function end=======*/
  }
  return revFinalMobileNo;
}

/*-----------------15-2-2023 start(use for the employer)-------------*/
String createTheEmployerPin(String mobileNumber,String pinNumber)
{
  //T means 20=2+0=2(first 2nd element), Y means 25=2+5=7 (start 7th element)==275---7-2==5


  var mobileList=mobileNumber.split("");

  var y_number=mobileList[6];
  var t_number=mobileList[8];
  var yt_number=mobileList[4];


  var pinNumberList=pinNumber.split("");
  var firstPinObj=pinNumberList[2];
  var secondPinObj=pinNumberList[3];
  var thirdPinObj=pinNumberList[1];

  int sPinInt=int.parse(secondPinObj);

  pinNumberList[2]=y_number;
  pinNumberList[3]=t_number;
  pinNumberList[1]=yt_number;


  mobileList[6]=firstPinObj;
  mobileList[8]=secondPinObj;
  mobileList[4]=thirdPinObj;


  int i=0;
  String finalMobileNo="";
  String finalPinNo="";

  for(i=0;i<mobileList.length;i++)
  {
    finalMobileNo=finalMobileNo+mobileList[i];

    if(i<=3)
    {
      finalPinNo=finalPinNo+pinNumberList[i];
    }
  }

  finalMobileNo=finalMobileNo+"TP275"+finalPinNo;
  return finalMobileNo;

}

String getDecryptedEmployerMobileNo(String mobileNo)
{
  /*========reverse function start=======*/

  int i=0;
  String finalMobileNo=getDecryptedData(mobileNo);
  String revFinalMobileNo = "";

  if(finalMobileNo.length>=19)
  {
    var splitLenght = finalMobileNo.split("TP275");
    var getMobileNoList = splitLenght[0].split("");
    var getPinNoList = splitLenght[1].split("");
    var getFirstPinTempObj = getPinNoList[2];
    var getSecondPinTempObj = getPinNoList[3];
    var getThirdPinTempObj = getPinNoList[1];

    getMobileNoList[6] = getFirstPinTempObj;
    getMobileNoList[8] = getSecondPinTempObj;
    getMobileNoList[4] = getThirdPinTempObj;


    for (i = 0; i < getMobileNoList.length; i++) {
      revFinalMobileNo = revFinalMobileNo + getMobileNoList[i];
    }
    /*========reverse function end=======*/
  }
  return revFinalMobileNo;
}

/*-----------------15-2-2023 end-------------*/
