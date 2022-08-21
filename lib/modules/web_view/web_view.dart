import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class webViewScreen extends StatelessWidget {
  final url;
  webViewScreen(this.url, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
