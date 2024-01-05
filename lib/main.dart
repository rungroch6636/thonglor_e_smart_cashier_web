import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thonglor_e_smart_cashier_web/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'e-SMART CASHIER',
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData(
            useMaterial3: false,
            primarySwatch: Colors.green,
            // colorScheme: ColorScheme.fromSwatch(),
            textTheme: GoogleFonts.mitrTextTheme()),
        debugShowCheckedModeBanner: false,
        home: const LoginScreen());
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
