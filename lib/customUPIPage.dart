
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:upi_india/upi_india.dart';
import 'package:url_launcher/url_launcher_string.dart';






class cutomUPIPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _cutomUPIPage();

}

class _cutomUPIPage extends State<cutomUPIPage>
{


  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;
  List<String> availableApp = [];


  void openUPIApps() async {



    List<String> UpiApp = [
      "phonepe",
      "gpay",
      "paytmmp",
      "freecharge",
      "upi",
      "whatsapp",
      "Bhim",
      "Zaakpay",
      "paypal"
    ];

    //phonepe://upi/pay?
    //gpay://upi/pay?
    //bhim://upi/pay?
    //paytmmp://upi/pay?

    /*---
     1. Paytm
     2. AmazonPay
     3. GPay
     4. Phonepe
     5. Bhim

     <string>phonepe</string>(Done)
        <string>freecharge</string>
        <string>gpay</string>(Done)
        <string>paytm</string>(Done)
        <string>whatsapp</string>
        <string>BHIM</string>


        static const String PayTM = "net.one97.paytm";
  static const String GooglePay = "com.google.android.apps.nbu.paisa.user";
  static const String BHIMUPI = "in.org.npci.upiapp";
  static const String PhonePe = "com.phonepe.app";
  static const String MiPay = "com.mipay.wallet.in";
  static const String AmazonPay = "in.amazon.mShop.android.shopping";
  static const String TrueCallerUPI = "com.truecaller";
  static const String MyAirtelUPI = "com.myairtelapp";

     ------*/



    for(var i = 0; i<UpiApp.length;i++)
    {

      // if(UpiApp[i] == "whatsapp")
      //   {
      //     bool isAppInstalled = await canLaunchUrl(Uri.parse("${UpiApp[i]}://upi/pay?"));
      //     //canLaunchUrl(Uri.parse("${UpiApp[i]}://upi/pay?"));
      //     print("${UpiApp[i]}://upi/pay? $isAppInstalled");
      //     if(isAppInstalled)
      //       {
      //         availableApp.add("whatsapp");
      //       }
      //   }
      bool isAppInstalled = UpiApp[i] == "gpay" ? await canLaunchUrl(Uri.parse("${UpiApp[i]}://upi/pay?")):
      await canLaunchUrl(Uri.parse("${UpiApp[i]}://pay?"));
      //canLaunchUrl(Uri.parse("${UpiApp[i]}://upi/pay?"));
     // print("${UpiApp[i]}://upi/pay? $isAppInstalled");
      if(isAppInstalled)
      {
        if( i == 0)
        {
          availableApp.add("phonepe");
        }
        else if(i == 1)
        {
          availableApp.add("gpay");
        }
        else if(i == 2)
        {
          availableApp.add("paytmmp");
        }
        else if(i == 3)
        {
          availableApp.add("freecharge");
        }
        else if(i == 4)
        {
          availableApp.add("upi");
        }
        else if(i == 5)
        {
          availableApp.add("Whatsapp");
        }
        else if(i == 6)
        {
          availableApp.add("bhim");
        }
        else if(i == 8)
        {
          availableApp.add("paypal");
        }
      }
    }
     setState(() {

     });

    //in.org.npci.upiapp
    //BHIM
    //in.org.npci.upiapp

    bool isFreeChargeInstalled = await canLaunchUrlString('paypal://upi//pay?');
    print("Freecharge Installation $isFreeChargeInstalled");

    // final String bhimUrl = "whatsapp://upi://pay?pa=dinesh@dlanzer&pn=Dinesh&am=1&tn=Test Payment&cu=INR";
    // // //launchUrlString(bhimUrl);
    // if (await canLaunchUrl(Uri.parse(bhimUrl))) {
    //   //launchUrl(Uri.parse(bhimUrl));
    //   print('BHIM app is installed on the device');
    // }
    // else {
    //   print('BHIM app is not installed on the device');
    // }

   // print("Available App $availableApp");

  }



  @override
  void initState() {
    super.initState();
    openUPIApps();
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("CustomUPI page"),
       ),
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
            Container(
              height: 450,
              width: MediaQuery.of(context).size.width *0.8,
              child:
              ListView.builder(
                  itemCount: availableApp.length,
                  shrinkWrap: true,
                  itemBuilder: (context,i){
                    return datePresets1(availableApp[i]);
                  }
              ),
            ),
         ],
       ),
     );
  }

}


var dateRadioValue;

String getUPIString(String payeeAddress, String payeeName, String payeeMCC, String trxnID, String trxnRefId,
    String trxnNote, String payeeAmount, String currencyCode, String refUrl) {
  String UPI = "BHIM://upi://pay?pa=" + payeeAddress + "&pn=" + payeeName
      + "&mc=" + payeeMCC + "&tid=" + trxnID + "&tr=" + trxnRefId
      + "&tn=" + trxnNote + "&am=" + payeeAmount + "&cu=" + currencyCode
      + "&refUrl=" + refUrl;
  return UPI.replaceAll(" ", "+");
}

StatefulBuilder datePresets1(String upiApp) {
  print("UPIApp $upiApp");
  return StatefulBuilder(
      builder: (BuildContext context, StateSetter state) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Radio(
                          value: 0,
                          groupValue: upiApp,
                        onChanged: (v){
                            dateRadioValue = v;
                        },
                      ),
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () async{
                              var status = await canLaunchUrl(Uri.parse("Bhim://pay?"));
                              print("Bhim App Available? $status");
                              if(upiApp == "gpay" || upiApp == "upi")
                                launchUrl(Uri.parse("$upiApp://upi//pay?pa=9569734648@ybl&pn=Navin&am=1&tn=Test Payment&cu=INR"));
                              else if(upiApp == "bhim")
                                {
                                  print("Bhim App Clicked");
                                  launchUrl(Uri.parse("$upiApp://upi//pay?pa=9569734648@ybl&pn=Navin&am=1&tn=Test Payment&cu=INR"));
                                }
                              else
                                launchUrl(Uri.parse("$upiApp://pay?pa=9569734648@ybl&pn=Navin&am=1&tn=Test Payment&cu=INR"));
                            },
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.72,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text( upiApp == "upi"? "AmazonPay": upiApp, textAlign: TextAlign
                                    .center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),),
                              ),
                            ),
                          )
                      ),
                    ],
                  )
              ),
            ],
          ),
        );
      });


}

