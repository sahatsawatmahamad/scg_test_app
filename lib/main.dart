import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scg_test_app/app_module.dart';
import 'package:scg_test_app/modules/main/views/main_screen.dart';

void main() {
  runApp(
    ModularApp(
      module: MainModule(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      theme: ThemeData.light(),
      home: const MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}
