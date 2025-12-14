import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parity_app/profilepage.dart';
import 'homepage.dart';

class HistoryPage extends StatelessWidget {
  final String name;
  final String age;
  final String avatar;
  final List<QuestionAnswer> questionHistory;
  final String todayQuestion;

  const HistoryPage({
    super.key,
    required this.name,
    required this.age,
    required this.avatar,
    required this.questionHistory,
    required this.todayQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFE8D5),
      appBar: AppBar(
        title: Text(
          "History",
          style: GoogleFonts.gloock(
            fontSize: 30,
            color: const Color(0xFF313B40),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFEFE8D5),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: questionHistory.length,
        itemBuilder: (context, index) {
          final qa = questionHistory[index];
          return Card(
            color: const Color(0xFFF26A35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                qa.question,
                style: GoogleFonts.nunitoSans(fontSize: 16),
              ),
              subtitle: Text(
                qa.answer ?? "No answer provided",
                style: GoogleFonts.nunitoSans(fontSize: 14),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFEFE8D5),
        elevation: 4.0,
        selectedItemColor: const Color(0xFF313B40),
        unselectedItemColor: const Color(0xFF313B40),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          name: name,
                          age: age,
                          avatar: avatar,
                          questionHistory: questionHistory,
                          todayQuestion: todayQuestion,
                        )),
              );
              break;
            case 1:
              // Already on History Page
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          name: name,
                          age: age,
                          avatar: avatar,
                          questionHistory: questionHistory,
                          todayQuestion: todayQuestion,
                        )),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
