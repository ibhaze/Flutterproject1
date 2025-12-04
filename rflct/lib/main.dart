import 'package:flutter/material.dart';
import 'package:rflct/pages/home_page.dart';
import 'package:rflct/pages/loading_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REFLECT',

      home: const LoadingPage(),
       routes: {
        '/lib/pages/home_page.dart': (context) => const HomePage(),
      },
    );
  }
}
