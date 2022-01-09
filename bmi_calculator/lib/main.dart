import 'package:bmi_calculator/screens/calculator/bmi_calculator_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // font license addition
  LicenseRegistry.addLicense(() async* {
    final license =
        await rootBundle.loadString('assets/fonts/quicksand/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: const MaterialColor(0xFF03A9F4, <int, Color>{
            50: Color(0xFF03A9F4),
            100: Color(0xFF03A9F4),
            200: Color(0xFF03A9F4),
            300: Color(0xFF03A9F4),
            400: Color(0xFF03A9F4),
            500: Color(0xFF03A9F4),
            600: Color(0xFF03A9F4),
            700: Color(0xFF03A9F4),
            800: Color(0xFF03A9F4),
            900: Color(0xFF03A9F4),
          }),
          dividerColor: const Color(0xFFBDBDBD),
          fontFamily: 'Quicksand'),
      home: const BMICalculator(),
    );
  }
}
