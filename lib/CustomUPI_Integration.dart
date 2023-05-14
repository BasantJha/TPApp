
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class customUPIintegration extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _customUPIintegration();

}

class _customUPIintegration extends State<customUPIintegration>
{

  String upiUrl = 'upi://pay';
  List<String> upiApps = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getAllAvailableUPIApp();
  }

  void _launchURL() async {
    String _url='Bhim://pay?pa=9569734648@ybl&pn=Navin&am=1&tn=Test Payment&cu=INR';
    //var result = await launchUrl(Uri.parse(_url));
    var result = true;
    var bhim = await canLaunchUrl(Uri.parse("zaakpay://"));
    print("MobikWik can Launch $bhim");
    debugPrint(result.toString());
    if (result ==true) {
      print("Done");
    } else if (result ==false){
      print("Fail");
    }
  }

  // getAllAvailableUPIApp() async
  // {
  //   bool isUpiAvailable = await canLaunchUrl(Uri.parse(upiUrl));
  //
  //   if (isUpiAvailable) {
  //     var installedApps = await (upiUrl);
  //     print("Install App $installedApps");
  //     //upiApps = installedApps.split('|');
  //     for(var v=0;v<upiApps.length;v++)
  //       {
  //         print("UPI APP ${upiApps[v]}");
  //       }
  //   }
  // }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Custom UPI"),
         centerTitle: true,
       ),
       body: Center(
         child: ElevatedButton(
           onPressed: _launchURL,
           child: Text("Open UPI App"),
         ),
       ),
     );
  }

}


