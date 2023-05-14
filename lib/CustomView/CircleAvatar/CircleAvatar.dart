

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constant/Constants.dart';
import '../../Controller/TankhaPayModule/Controller/ThankhaPayLeftSlider/ThankhaPayProfile/TankhaPayProfileChild.dart';

SizedBox getCircleAvatarJoiner(String empName)
{
  return SizedBox(
    child: CircleAvatar(
      radius: 50.0,
      backgroundColor: darkBlueColor,
      child: CircleAvatar(
        child: getProfileName(getProfileEmpName(empName)),
        radius: 48.0,
        backgroundColor: darkBlueColor,
        // backgroundImage:
        //AssetImage(Employer_Icon_SelectEmployeeListIcon),
      ),
    ),
  );
}
Text getProfileName(String? userName)
{
  return Text(
    userName != "" && userName != null
        ? userName.toUpperCase()
        : "",
    style: TextStyle(fontSize: 30,color: whiteColor),
  );
}