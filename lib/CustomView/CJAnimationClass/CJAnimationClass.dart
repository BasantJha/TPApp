import 'package:flutter/cupertino.dart';

class SlideTopToBottomRoute extends PageRouteBuilder
{
  final Widget  page;
  SlideTopToBottomRoute({required this.page})
      : super(
    transitionDuration: Duration(seconds: 2),
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}
class SlideBottomToTopRoute extends PageRouteBuilder
{
  final Widget  page;
  SlideBottomToTopRoute({required this.page})
      : super(
    //transitionDuration: Duration(seconds: 1),
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}