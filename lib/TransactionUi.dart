
import 'package:flutter/material.dart';

import 'Constant/ConstantIcon.dart';
import 'Constant/Constants.dart';
import 'Constant/Responsive.dart';
import 'package:url_launcher/url_launcher.dart';




class TransactionStatusUI extends StatefulWidget

{
  @override
  TransactionStatusUIState createState() => TransactionStatusUIState();

}


class TransactionStatusUIState extends State<TransactionStatusUI>

{

  var transactionStatusCase = 1;
  List<String> availableApp = [];

  String whatsapp = '+918789271003';
  // "whatsapp://send?phone=$whatsapp&text=hello";


  void openUPIApps() async {
    // List of available UPI apps
    List<String> UpiApp = [
      "phonepe",
      "gpay",
      "paytmmp",
      "freecharghe",
      "amazonpay",
      "BHIM",
    ];

    //phone=$whatsapp&text=hello
    bool isApp = await canLaunchUrl(Uri.parse("whatsapp://pay?"));
    print("Can Whatsapp Launched $isApp");
    launchUrl(Uri.parse("whatsapp://pay?pa=9569734648@ybl&pn=Navin&am=1&tn=Test Payment&cu=INR"));



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
        bool isAppInstalled = await canLaunchUrl(Uri.parse("${UpiApp[i]}://upi/pay?"));
        print("${UpiApp[i]}://upi/pay? $isAppInstalled");
        if(isAppInstalled)
          {
            if( i == 0)
              {
                availableApp.add("PhonePe");
              }
            else if(i == 1)
              {
                availableApp.add("GPay");
              }
            else if(i == 2)
            {
              availableApp.add("PayTm");
            }
            else if(i == 3)
            {
              availableApp.add("Frecharge");
            }
            else if(i == 1)
            {
              availableApp.add("AmazonPay");
            }
            else if(i == 4)
            {
              availableApp.add("BHIM");
            }
          }
      }

    print("Available App $availableApp");

  }


  @override
  void initState()
  {
    super.initState();
    openUPIApps();
  }

  @override
  Widget build(BuildContext context) {



    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              title: Text("Transaction Details"),
              backgroundColor: lightBlueColor,
              centerTitle: true,
              leading: Icon( Icons.arrow_back_outlined,color: whiteColor),
            ),
            body: Responsive(
                mobile: MainfunctionUI(),
                tablet: MainfunctionUI(),
                desktop: Center(
                  child: Container(
                    width: webResponsive_TD_Width,
                    child: MainfunctionUI(),
                  ),
                )

            )
        )
    );

  }

  SingleChildScrollView MainfunctionUI()
  {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Column(
            children: [
              transactionStatusCase ==1 ?
              Image.asset(Employer_Icon_VerifiedPaymentGreen,
                height: 80,
                width: 80,
              ) :
              transactionStatusCase ==2 ?
              Image.asset("transactionfailure.png",
                height: 80,
                width: 80,
              ) :
              Image.asset("transactionfailure.png",
                height: 80,
                width: 80,
              ),
              SizedBox(
                height: 20,
              ),
              transactionStatusCase == 1?
              TransactionStatusText("Transaction Successful",greenColor):
              transactionStatusCase == 2?
              TransactionStatusText("Transaction Failed",redColor):
              TransactionStatusText("Transaction Pending",Colors.orange),
              SizedBox(
                height: 10,
              ),
              Text(
                "\u{20B9} ${4500}",
                style: TextStyle(
                    fontWeight: bold_FontWeight,
                    fontSize: large_FontSize),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Payment_CheckMark_Icon
                  Image(
                    image: AssetImage(Payment_CheckMark_Icon),
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Completed",
                   style: TextStyle(
                       color: darkGreyColor
                   ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                child: Divider(
                  height: 5,
                  color: darkGreyColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Jan 15 2023 5:11PM",
                style: TextStyle(
                    fontWeight: normal_FontWeight,
                     color: darkGreyColor
                    ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15,right: 15),
                child: Container(
                  padding: EdgeInsets.only(top: 5,bottom: 5,left: 20,right: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color:  Color(0xffE5E5E5),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "UPI transaction ID",
                            style: TextStyle(
                                fontWeight: bold_FontWeight,
                                fontSize: medium_FontSize),
                          ),
                          Text("kkfkfkfllllll"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "To:Akal Information System ltd.",
                            style: TextStyle(
                                fontWeight: bold_FontWeight,
                                fontSize: medium_FontSize),
                          ),
                          Text("ldjdjjjfjfjfjjf"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "From: Lokesh Aggarwal(HDFC Bank)",
                            style: TextStyle(
                                fontWeight: bold_FontWeight,
                                fontSize: medium_FontSize),
                          ),
                          Text("54677rhhffhfhnf"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TankhaPay transaction ID",
                            style: TextStyle(
                                fontWeight: bold_FontWeight,
                                fontSize: medium_FontSize),
                          ),
                          Text("HDFC"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }





  TransactionStatusText(String TransationStatus, Color transactioncolor)
  {
    return Text(TransationStatus,
      style: TextStyle(
          fontFamily: robotoFontFamily,
          fontSize: large_FontSize,
          fontWeight: normal_FontWeight,
          color: transactioncolor
      ),
    );
  }




}

