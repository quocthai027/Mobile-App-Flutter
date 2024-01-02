import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:AdsaxShop/realtime.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:intl/intl.dart';

import 'calendar.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl: 'http://i9betapp.online/',
          javascriptMode:
              JavascriptMode.unrestricted, // Để kích hoạt JavaScript
        ),
      ),
    );
  }
}
