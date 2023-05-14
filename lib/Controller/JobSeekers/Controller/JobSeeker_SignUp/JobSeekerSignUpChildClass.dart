import 'package:flutter/cupertino.dart';

class DotClassForJobSeekerSignUp
{
  dotUI(int nocontainer, int colorcontainer, double padding)
  {
    int NumberofContainer = nocontainer;
    int NumberofcolorContainer = colorcontainer;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < NumberofcolorContainer; i++) ...[
          Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),

              color: Color(0xffAFAEAE),
            ),

          ),
          SizedBox(
            width: padding,
          )
        ],
        for (var i = 0;
        i < NumberofContainer - NumberofcolorContainer;
        i++) ...[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffD9D9D9),
            ),
            alignment: Alignment.center,
            height: 14,
            width: 14,
          ),
          SizedBox(
            width: padding,
          )
        ],
      ],
    );
  }
}
