import 'package:contractjobs/Constant/Constants.dart';
import 'package:flutter/material.dart';
import '../../Constant/ConstantIcon.dart';
import '../../Services/Messages/Message.dart';


alertViewWithAction(BuildContext context,String message)
{
  var alertDialog = AlertDialog(
    content: Text(message,
      textAlign: TextAlign.center,),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0.0))
    ),

    actions: [
//
      TextButton(onPressed: () {

        Navigator.of(context).pop();
        //Navigator.
      },

        child: Text("OK",style:TextStyle(fontSize: 15,color: Color(0xff00BFFF),),),),
    ],

  );
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => alertDialog

  );
}
//
alertViewWithoutAction(BuildContext context,String message,Color colorType)
{
  var alertDialog = AlertDialog(
    content: Text(message, textAlign: TextAlign.center,style: TextStyle(color: colorType),),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0.0))
    ),

  );
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => alertDialog

  );
}

Dialog successDialogMethod(BuildContext context, message)
{
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 0,
    child:
    successBuildChild(context, message),
  );
}
//
successBuildChild(BuildContext context, message) =>
    Container(
        width: 300,
        height: 200,
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Congratulations!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: Image(
                  image: AssetImage(celebration_Icon),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 25, top: 8),
            child: Container(
              width: 200,
              height: 80,
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black,fontFamily: robotoFontFamily,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Center(
              child: InkWell(
                onTap: ()
                {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      color: Colors.blueAccent),
                ),
              ))
        ]));

Dialog failedDialogMethod(BuildContext context, message,Color color)
{
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 0,
    child: failedBuildChild(context, message,color),
  );
}
failedBuildChild(BuildContext context, message,Color color) =>
    Container(
      height: 200,
      decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(children: <Widget>[
        SizedBox(
          width: 70,
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image(
              image: AssetImage(warning_Icon),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35.0, right: 25),
          child: SizedBox(
            width: 200,
            height: 100,
            child: Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: color,fontFamily: robotoFontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ]),
    );


/*-----------use for the snack bar start 26-12-2022------------*/
Dialog successDialogMethodForAllMessages(BuildContext context, message)
{
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 0,
    child:
    successBuildChildForAllMessages(context, message),
  );
}
//
successBuildChildForAllMessages(BuildContext context, message) =>
    Container(
        width: 300,
        height: 180,
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Alert!",
                style: TextStyle(fontSize: 25,color: blackColor),
              ),
              /*SizedBox(
                width: 30,
                height: 30,
                child: Image(
                  image: AssetImage(celebration_Icon),
                ),
              ),*/
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 25, top: 8),
            child: Container(
              width: 200,
              height: 80,
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black,fontFamily: robotoFontFamily,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Center(
              child: InkWell(
                onTap: ()
                {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                      fontWeight: bold_FontWeight,
                      fontSize: 16,
                      color: Colors.blueAccent),
                ),
              ))
        ]));
/*-----------use for the snack bar end 26-12-2022------------*/
