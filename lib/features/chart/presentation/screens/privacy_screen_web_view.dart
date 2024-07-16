import 'package:flutter/material.dart';
import 'package:webview_universal/webview_universal.dart';

class PrivacyScreen extends StatefulWidget {
  final String url;

  const PrivacyScreen({super.key, required this.url});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  final WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    _webViewController.init(
        context: context, setState: setState, uri: Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: double.minPositive,
      ),
      body: WebView(controller: _webViewController),
    );
  }
}
