
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telephony/telephony.dart';

backgrounMessageHandler(SmsMessage message) async {
  //Handle background message
  // You can also call other plugin in here
}

class TelephonyUI extends StatefulWidget
{
  @override
  TelwphonyUiState createState() => TelwphonyUiState();

}


class TelwphonyUiState extends State<TelephonyUI>
{



  final _controller  = TextEditingController();

  final Telephony telephony = Telephony.instance;
  FocusNode? myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        print("Massage Received ${message.body}");
        setState(() {
          //_controller.text = message.body!;
          Clipboard.setData(ClipboardData(text: message.body!));
          myFocusNode?.requestFocus();
        });
      },
      listenInBackground: true,
      onBackgroundMessage: backgrounMessageHandler,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SMS Listemer"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              focusNode: myFocusNode,
            )
          ],
        ),
      ),
    );
  }
  

}