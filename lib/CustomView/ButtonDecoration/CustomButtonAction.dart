

import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeeker_SignUp/JobSeekerSignUpChildClass.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeeker_SignUp/JobSeeker_SignUpRole.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ElevatedButtonBlock
{
  final void Function() elevatedButtonAction;
  ElevatedButtonBlock({required this.elevatedButtonAction});
}

 /* ElevatedButton getElevatedBlueButton(String textType,{required ElevatedButtonBlock elevatedButtonBlock})
  {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: ElevatedButtonBgBlueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ) // NEW
      ),
      onPressed: ()
      {
        elevatedButtonBlock.elevatedButtonAction();
      },
      child: Text(
        textType,
        style: TextStyle(fontSize: ElevatedButtonTextFontWeight ),
      ),
    );
  }*/

Container CJElevatedBlueButton(String textType,{required ElevatedButtonBlock elevatedButtonBlock})
{
 return Container(color: whiteColor,child:Padding(padding:
      EdgeInsets.only(
      bottom: elevatedButtonBottomPadding,top: elevatedButtonTopPadding),

       child:Container(height: ElevatedButtonHeight,width: ElevatedButtonWidth,color: whiteColor,
         child: ElevatedButton(
           style: ElevatedButton.styleFrom(
               backgroundColor: ElevatedButtonBgBlueColor,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(17),
               ) // NEW
           ),
           onPressed: ()
           {
             elevatedButtonBlock.elevatedButtonAction();
           },
           child: Text(
             textType,
             style: TextStyle(fontWeight:bold_FontWeight,fontSize: ElevatedButtonTextFontWeight,fontFamily: robotoFontFamily),
           ),
         ))));
}

ElevatedButton CJElevatedGrayButton(String textType,{required ElevatedButtonBlock elevatedButtonBlock})
{
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: ElevatedButtonBgGrayColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ) // NEW
    ),
    onPressed: ()
    {
      elevatedButtonBlock.elevatedButtonAction();
    },
    child: Text(
      textType,
      style: TextStyle(fontWeight:bold_FontWeight,fontFamily: robotoFontFamily,fontSize: ElevatedButtonTextFontWeight,color: ElevatedButtonTextColorDarkGray),
    ),
  );
}

Container CJElevatedBlueButtonWithDotJobSeeker(String textType,int selectedDot,{required ElevatedButtonBlock elevatedButtonBlock})
{
  return Container(color: whiteColor,
      height: 110,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(1, 0, 0, 0),
        child: Column(
          children: [
            DotClassForJobSeekerSignUp().dotUI(3, selectedDot, 10),
            SizedBox(height: 20),
            Container(
              height: 50,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ElevatedButtonBgBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ) // NEW
                ),
                onPressed: ()
                {
                  elevatedButtonBlock.elevatedButtonAction();
                },
                child: Text(
                  textType,
                  style: TextStyle(fontWeight:bold_FontWeight,fontFamily: robotoFontFamily,fontSize: ElevatedButtonTextFontWeight,color: whiteColor),
                ),
              ),
            )
          ],
        ),
      ));

}

Container CJWithoutElevatedBlueButtonWithDotJobSeeker(String textType,int selectedDot,{required ElevatedButtonBlock elevatedButtonBlock})
{
  return Container(color: whiteColor,
      height: 110,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(1, 10, 0, 0),
        child: Column(
          children: [
            DotClassForJobSeekerSignUp().dotUI(3, selectedDot, 10),

          ],
        ),
      ));

}

ElevatedButton CJElevatedPassbookButton({required ElevatedButtonBlock elevatedButtonBlock})
{
  return ElevatedButton(
    onPressed: () {
      elevatedButtonBlock.elevatedButtonAction();

    },
    style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: darkGreyColor,
        minimumSize: Size.zero,
        padding: EdgeInsets.all(-12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
        maximumSize: Size.zero),
    child: Icon(
      Icons.arrow_back_ios_rounded,
      size: 25,
      color: Colors.black,
    ),
  );
}
