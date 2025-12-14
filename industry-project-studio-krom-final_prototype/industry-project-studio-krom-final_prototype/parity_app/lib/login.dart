import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'info.dart'; // Import the InfoPage class

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  bool isAgreed = false;

  bool get isFormValid =>
      nameController.text.isNotEmpty &&
      ageController.text.isNotEmpty &&
      isAgreed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFE8D5),
      resizeToAvoidBottomInset: false, // Prevent resizing
      body: GestureDetector(
        onTap: () =>
            FocusScope.of(context).unfocus(), // Dismiss keyboard on tap outside
        child: Stack(
          children: [
            Positioned(
              top: 60,
              left: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'who',
                    style: GoogleFonts.gloock(
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF313B40),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: Text(
                      'are',
                      style: GoogleFonts.gloock(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF313B40),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'you?',
                      style: GoogleFonts.gloock(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF313B40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                // Allows content to scroll when keyboard opens
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            'Name',
                            style: GoogleFonts.quicksand(
                              color: const Color(0xFF313B40),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    const BorderSide(color: Color(0xFFF3B340)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                    color: Color(0xFFF3B340), width: 2.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                            style: GoogleFonts.quicksand(
                                color: const Color(0xFF313B40)),
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            'Age',
                            style: GoogleFonts.quicksand(
                              color: const Color(0xFF313B40),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    const BorderSide(color: Color(0xFFF3B340)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                    color: Color(0xFFF3B340), width: 2.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                            style: const TextStyle(color: Color(0xFF313B40)),
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 220),
                    ElevatedButton(
                      onPressed: isFormValid
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InfoPage(
                                    name: nameController.text,
                                    age: ageController.text,
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        // ignore: deprecated_member_use
                        shadowColor: Colors.black.withOpacity(0.5),
                        elevation: 5,
                        backgroundColor: const Color(0xFFF3B340),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ),
                      child: Text(
                        'Continue',
                        style: GoogleFonts.nunitoSans(
                          color: const Color(0xFF313B40),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isAgreed,
                          onChanged: (value) {
                            setState(() {
                              isAgreed = value ?? false;
                            });
                          },
                          activeColor: const Color(0xFFF3B340),
                          checkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        Text(
                          'I agree to allow PARITY store my data',
                          style: GoogleFonts.quicksand(
                            color: const Color(0xFF313B40),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
