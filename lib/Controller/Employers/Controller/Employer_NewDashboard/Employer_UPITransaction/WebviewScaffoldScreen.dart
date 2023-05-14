import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScaffoldScreen extends StatefulWidget {
  @required
  final String url;
  final String appBarTitle;
  final bool? withJavascript;

  const WebviewScaffoldScreen({
    required this.url,
    required this.appBarTitle,
    this.withJavascript,
    Key? key,
  }) : super(key: key);

  @override
  State<WebviewScaffoldScreen> createState() => _WebviewScaffoldScreenState();
}

class _WebviewScaffoldScreenState extends
State<WebviewScaffoldScreen>
{
  late final WebViewController webViewController;
  final userId = "333";
  final token = "abc";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.appBarTitle)),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webController) {
          webViewController = webController;
        },
        navigationDelegate: (NavigationRequest request) {

          if (request.url.contains('callback:close')) {
            Navigator.of(context).pop();
            return NavigationDecision.prevent;
          }

          if (request.url.contains('messages')) {
            // I was tring to use webviewController to reload the url, but this creates a loop that kept reloading the webview :(

            //String updatedUrl = request.url + "&" + "user_id=$userId&" + "token=$token&";

            String updatedUrl=request.url;
            webViewController.loadUrl(updatedUrl);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}