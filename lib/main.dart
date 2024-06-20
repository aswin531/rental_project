import 'package:flutter/material.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/core/constants/screen_util_setup.dart';
import 'package:rentit/core/navigation/approutes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilSetup(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
