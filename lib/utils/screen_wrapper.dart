import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.appBar,
    this.statusBarStyle = SystemUiOverlayStyle.dark,
  }) : super(key: key);

  final Widget child;
  final Color backgroundColor;
  final PreferredSizeWidget? appBar;
  final SystemUiOverlayStyle statusBarStyle;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusBarStyle,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(child: child),
          appBar: appBar,
          key: key,
        ),
      ),
    );
  }
}
