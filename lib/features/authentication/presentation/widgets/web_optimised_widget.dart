import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WebOptimisedWidget extends StatelessWidget {
  final Widget web;
  final Widget mobile;

  const WebOptimisedWidget({
    super.key,
    required this.web,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return web;
    } else {
      return mobile;
    }
  }

  static EdgeInsets getWebOptimisedHorizonatalPadding(
      {double web = 12, double mobile = 12}) {
    if (kIsWeb) {
      return EdgeInsets.all(web);
    } else {
      return EdgeInsets.all(mobile);
    }
  }
}
