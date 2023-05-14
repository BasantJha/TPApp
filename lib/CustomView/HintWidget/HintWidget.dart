import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:showcaseview/showcaseview.dart';

class HintWidget extends StatelessWidget
{
  const HintWidget({
    Key? key,
    required this.globalKey,
    required this.title,
    required this.description,
    required this.child,
    this.shapeBorder = const CircleBorder(),
  }) : super(key: key);

  final GlobalKey globalKey;
  final String title;
  final String description;
  final Widget child;
  final ShapeBorder shapeBorder;

  @override
  Widget build(BuildContext context) {
    return Showcase(
      // disableMovingAnimation: true,
      // disableScaleAnimation: true,
      key: globalKey,
      title: title,
      description: description,
      targetShapeBorder: shapeBorder,
      child: child,
    );
  }
}
