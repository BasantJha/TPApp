import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/CJAnimationClass/CJAnimationClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TalentNavigation
{
  pushTo<T>(BuildContext context,navigateView)
  {
    Navigator.push(context, MaterialPageRoute(builder: (_)=>

        Responsive(
            mobile: navigateView,
            tablet: Center(
              child: Container(
                width: webResponsive_TD_Width,
                child: navigateView,
              ),
            ),

            desktop: Center(
              child: Container(
                width: webResponsive_TD_Width,
                child: navigateView,
              ),
            )
        )
    )
    );
  }
}

class TalentAnimationNavigation
{
  pushBottomToTop<T>(BuildContext context, navigateView)
  {
    Navigator.push(context, SlideBottomToTopRoute(page: Responsive(
        mobile: navigateView,
        tablet: Center(
          child: Container(
            width: webResponsive_TD_Width,
            child: navigateView,
          ),
        ),

        desktop: Center(
          child: Container(
            width: webResponsive_TD_Width,
            child: navigateView,
          ),
        )
    ) ));
  }

  pushTopToBottom<T>(BuildContext context, navigateView)
  {
    Navigator.push(context, SlideTopToBottomRoute(page: Responsive(
        mobile: navigateView,
        tablet: Center(
          child: Container(
            width: webResponsive_TD_Width,
            child: navigateView,
          ),
        ),

        desktop: Center(
          child: Container(
            width: webResponsive_TD_Width,
            child: navigateView,
          ),
        )
    ) ));
  }
}

