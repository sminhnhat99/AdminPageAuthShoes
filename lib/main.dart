import 'package:admin_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:admin_flutter/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Shoes Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme
          .apply(bodyColor: Colors.white)),
        canvasColor: secondaryColor,
      ),
      home: LoginPage(),
    );
  }
}
