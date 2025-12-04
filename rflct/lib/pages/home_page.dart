import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: GoogleFonts.nunito()),
      ),
      body: Center(
        child: Text(
          "Welcome to RFLCT",
          style: GoogleFonts.nunito(fontSize: 24),
        ),
      
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:   const Color(0xFF663366),
          selectedItemColor: Color.fromARGB(255, 158, 108, 158),    
  unselectedItemColor: Colors.white,
          items: const [
       
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
