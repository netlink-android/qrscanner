import 'package:flutter/material.dart';
import 'package:qr_scanner/const.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Privacy Policy', style: textType,)),
    body: WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: 'https://netlink.vn/privacy_policy.php',
    ));
  }
}