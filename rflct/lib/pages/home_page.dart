import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  VoidCallback? get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 1,
              child: ListTile(
                leading: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFF663366),
                  ),

                  child: Icon(Icons.settings, size: 20, color: Colors.white),
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(fontSize: 20, color: Color(0xFF663366)),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,

        title: RichText(
          text: TextSpan(
            style: GoogleFonts.nunitoSans(
              fontSize: 25,
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
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      width: double.infinity,

                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                    // The drag handle
                    Container(
                      width: 40,
                      height: 5,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // Your content
                     Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
                elevation: 0,
              child: ListTile(
                leading: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFF663366),
                  ),

                  child: Icon(Icons.mic, size: 20, color: Colors.white),
                ),
                title: Text(
                  'Record session',
                  style: TextStyle(fontSize: 20, color: Color(0xFF663366)),
                ),
              ),
            ),
                  ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF663366),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: Colors.white, size: 35),
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
