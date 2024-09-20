import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'view/login_view.dart';



void main() {
  runApp(
      DevicePreview(enabled: true, builder: (context) => const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginView(),
      },
    );
  }
}

