import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  VoidCallback? get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

  drawer: Drawer(
    child: Center(child: Text("Your menu here")),
  ),appBar: AppBar(
  automaticallyImplyLeading: false,
  title: RichText(
    text: TextSpan(
      style: GoogleFonts.nunitoSans(
        fontSize: 22,
        color: Colors.black, // default color for RF
        fontWeight: FontWeight.w600,
      ),
      children: [
        TextSpan(text: "RF"),
        TextSpan(
          text: "LCT",
          style: TextStyle(
            color: const Color(0xFF663366),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ),
  ),


      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF663366),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                 color: Colors.white,
                 size: 35),
            ),
            
          ),SizedBox(height: 30,)
        ],
      ), 
    );
  }
}
