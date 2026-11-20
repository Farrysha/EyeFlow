import 'package:flutter/material.dart';

import 'pages/login.dart';

void main() {
  runApp(const EyeFlowApp());
}

class EyeFlowApp extends StatelessWidget {
  const EyeFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EYE FLOW',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF1A1A),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      home: const LoginPage(),
    );
  }
}
