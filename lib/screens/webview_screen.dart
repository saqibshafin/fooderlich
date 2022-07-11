import 'dart:io';
import '../models/models.dart';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  // WebViewScreen MaterialPage Helper
  static MaterialPage page() {
    return MaterialPage(
      name: FooderlichPages.raywenderlich,
      key: ValueKey(FooderlichPages.raywenderlich),
      child: const WebViewScreen(),
    );
  }
  // Here, you create a static MaterialPage that wraps a WebView screen widget.

  const WebViewScreen({Key? key}) : super(key: key);

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('raywenderlich.com'),
      ),
      body: const WebView(
          // initialUrl: 'https://www.raywenderlich.com/',
          // initialUrl: 'https://www.nickbostrom.com/',
          // initialUrl: 'https://www.wikipedia.org/',
          //?? how tf does the raywenderlich website launch? all links are
          //commented...
          ),
    );
  }
}
