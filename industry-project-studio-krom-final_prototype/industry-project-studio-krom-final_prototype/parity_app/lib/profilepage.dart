import 'package:flutter/material.dart';
import 'homepage.dart';
import 'history.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String age;
  final String avatar;
  final List<QuestionAnswer> questionHistory;
  final String todayQuestion;

  const ProfilePage(
      {super.key,
      required this.name,
      required this.age,
      required this.avatar,
      required this.questionHistory,
      required this.todayQuestion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFE8D5),
      appBar: AppBar(
        title: const Text("Profile Page"),
        backgroundColor: const Color(0xFFEFE8D5),
        elevation: 0,
      ),
      body: Center(
        child: const Text(
          "This is the Profile Page.",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF313B40),
          ),
        ),
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
                          todayQuestion: todayQuestion,
                          questionHistory: questionHistory,
                        )),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HistoryPage(
                          name: name,
                          age: age,
                          avatar: avatar,
                          todayQuestion: todayQuestion,
                          questionHistory: questionHistory,
                        )),
              );
              break;
            case 2:
              // Already on Profile Page
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
