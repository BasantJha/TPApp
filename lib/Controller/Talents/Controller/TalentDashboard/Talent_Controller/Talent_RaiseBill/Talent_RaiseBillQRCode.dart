
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:contractjobs/CustomView/ButtonDecoration/CustomButtonAction.dart';
import 'package:contractjobs/CustomView/MarginSizeBox/MarginSizeBox.dart';
import 'package:contractjobs/CustomView/ViewHint/CustomViewHint.dart';
import 'package:contractjobs/CustomView/ViewHint/ViewHintText.dart';
//import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:qr_flutter/qr_flutter.dart';

class Talent_RaiseBillQRCode extends StatefulWidget
{
  const Talent_RaiseBillQRCode({Key? key}) : super(key: key);

  @override
  State<Talent_RaiseBillQRCode> createState() => _Talent_RaiseBillQRCode();
}

class _Talent_RaiseBillQRCode extends State<Talent_RaiseBillQRCode>
{
  final String data="123456";

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar:CJAppBar(getTalent_RaiseABillTitle, appBarBlock: AppBarBlock(appBarAction: ()
        {
          print("show the action type");
          Navigator.pop(context);
        })),
        body:getResponsiveUI(),
        bottomNavigationBar: elevatedButtonBottomBar()

    );
  }

  Responsive getResponsiveUI()
  {
    return Responsive(
      mobile: MainfunctionUi(),
      tablet: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(),
        ),
      ),
      desktop: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(),
        ),
      ),
    );
  }

  Container MainfunctionUi()
  {
    return Container(color: whiteColor,child: SingleChildScrollView (

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child:getViewHintTextBlue(getTalent_Passbook_GenerateBillQRCodeHint),),
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Scan the QR code using any UPI app on your\nphone like BHIM, PhonePE, Google Pay etc.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),),
          ),

          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(Talent_Icon_Bhim),),
              SizedBox(width: 20,),
              Image(image: AssetImage(Talent_Icon_PhonePe),),
              SizedBox(width: 20,),
              Image(image: AssetImage(Talent_Icon_GooglePay),),
              SizedBox(width: 20,),
              Image(image: AssetImage(Talent_Icon_Paytm),),
            ],
          ),

          SizedBox(height: 30),
        /*-----------17-11-2022 start(use issue the library)--------------*/
         /* DottedBorder(
            child: QrImage(data: data,
              size: 200,
            ),
            borderType: BorderType.Rect,
            color: Colors.grey,
            strokeWidth: 3,
            padding: EdgeInsets.all(10),

            dashPattern: [120,50,130,50,160,70],

          ),*/
          /*-----------17-11-2022 end--------------*/

          SizedBox(height: 200),


          /* Padding(
            padding: const EdgeInsets.all(40),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 30,
              ),
              child: const Center(child: Text("Share QR Code",
                style: TextStyle(fontSize: 19,color: Colors.white),
              ),
              ),
            ),
          )*/
        ],

      ),

    ) ,);

  }

  Container elevatedButtonBottomBar()
  {
    return CJElevatedBlueButton("Share QR Code", elevatedButtonBlock: ElevatedButtonBlock(elevatedButtonAction: ()
    {
      print("show the continue action");

      //TalentNavigation().pushTo(context, Talent_RaiseBillInvoice());

    }
    )) ;

  }
}
