import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: GoogleFonts.nunito()),
        backgroundColor: const Color(0xFFCABDE6),
      ),
      body: Center(
        child: Text(
          "Welcome to RFLCT",
          style: GoogleFonts.nunito(fontSize: 24),
        ),
        
      ),
    );
  }
}
