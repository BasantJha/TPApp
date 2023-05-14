
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../Constant/Responsive.dart';
import 'SharedPreference.dart';

Timer? _rootTimer;

 class AutoLogout {


 static BuildContext? context_obj;

 static void initializeTimer(BuildContext context) {
    context_obj = context;
    if (_rootTimer != null) _rootTimer!.cancel();
    const time = const Duration(minutes: 5);
    // //print('time:$time');
    _rootTimer = Timer(time, () {
      logOutUser(context);
    });
  }

 static void logOutUser(BuildContext context) async {
    // Log out the user if they're logged in, then cancel the timer.

    // //print("user Logout");

    SharedPreference.setLoginStatus("false");

/*
    Navigator.push(context, MaterialPageRoute(builder: (_) =>

        Responsive(
          mobile: login(),
          tablet: Center(
            child: Container(
              width: login_tabletWidth,
              child: login(),
            ),
          ),
          desktop: Center(
            child: Container(
              width: login_desktopWidth,
              child: login(),
            ),
          ),
        ),

        // login()

    ));
*/

    _rootTimer?.cancel();
  }



}