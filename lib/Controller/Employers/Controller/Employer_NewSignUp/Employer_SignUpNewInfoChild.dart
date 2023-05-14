
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Constant/Constants.dart';
import '../../../LoginView/Controller/LoginViewController.dart';

Row employerSignUpInfoBottomBar(BuildContext context)
{
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Already have an account? ',
        style: TextStyle(fontSize: small_FontSize, fontWeight: FontWeight.bold),
      ),
      TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
          onPressed: ()
          {
            Navigator.pop(context,[LoginViewController]);
          },
          child: Text(
            'Sign In',
            style: TextStyle(
                color: lightBlueColor,
                fontSize: medium_FontSize,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
          ))
    ],
  );

}