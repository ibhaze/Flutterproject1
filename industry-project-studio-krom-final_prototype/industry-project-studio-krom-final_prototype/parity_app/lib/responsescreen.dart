import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parity_app/homepage.dart';
import 'history.dart';
import 'profilepage.dart';

class ResponseScreen extends StatefulWidget {
  final String userAnswer;
  final String name;
  final String age;
  final String avatar; // Avatar URL for the user
  final Function(String) onBack; // Callback to pass the answer back
  final String todayQuestion;
  final List<QuestionAnswer> questionHistory;
  
  final List<String> bestResponses;

  const ResponseScreen({
    super.key,
    required this.userAnswer,
    required this.avatar,
    required this.onBack,
    required this.name,
    required this.age,
    required this.todayQuestion,
    required this.questionHistory, required this.bestResponses,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ResponseScreenState createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  Map<int, bool> showReactions =
      {}; // Map om te volgen welke reacties zichtbaar zijn

  void toggleReactions(int index) {
    setState(() {
      showReactions[index] = !(showReactions[index] ?? false);
    });
  }

  void showFeedbackDialog(BuildContext context, String reaction) {
    TextEditingController feedbackController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color(0xFFEFE8D5),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Why did you find this $reaction?",
                style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: feedbackController,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Type your response here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showReactions.entries
                        // ignore: avoid_function_literals_in_foreach_calls
                        .forEach((entry) => showReactions[entry.key] = false);
                  });
                  Navigator.of(context).pop();
                  showThankYouDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF26A35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(
                  "Send",
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showThankYouDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color(0xFFEFE8D5),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close, color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Thanks for your feedback",
                style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFE8D5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 65),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF26A35),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/horse_icon.png',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Question Of The Day",
                          style: GoogleFonts.nunitoSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.todayQuestion,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Transform.rotate(
              angle: -3.5 * (3.14159265359 / 180),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3B340),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0x000000ff),
                      backgroundImage: AssetImage(widget.avatar),
                      radius: 30,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "You",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.userAnswer,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            for (int i = 0; i < 3; i++) // Itereren over reacties
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Transform.rotate(
                  angle: (i % 2 == 0 ? 3.5 : -3.5) * (3.14159265359 / 180),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF313B40),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0x000000ff),
                          backgroundImage: AssetImage(
                              'assets/images/${i == 0 ? 'girl5' : i == 1 ? 'man3' : 'girl3'}.png'),
                          radius: 30,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.bestResponses[i],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunitoSans(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        showReactions[i] == true
                            ? Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () => showFeedbackDialog(
                                          context, "interesting"),
                                      child: ReactionIcon(
                                          icon: "🤔", label: "Interesting"),
                                    ),
                                    GestureDetector(
                                      onTap: () => showFeedbackDialog(
                                          context, "unexpected"),
                                      child: ReactionIcon(
                                          icon: "😲", label: "Unexpected"),
                                    ),
                                    GestureDetector(
                                      onTap: () => showFeedbackDialog(
                                          context, "relatable"),
                                      child: ReactionIcon(
                                          icon: "🤝", label: "Relatable"),
                                    ),
                                  ],
                                ),
                              )
                            : Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () => toggleReactions(i),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side:
                                          const BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: Text(
                                    "React",
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
          ]),
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
              widget.onBack(widget.userAnswer);
              Navigator.pop(context);
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HistoryPage(
                          name: widget.name,
                          age: widget.age,
                          avatar: widget.avatar,
                          questionHistory: widget.questionHistory,
                          todayQuestion: widget.todayQuestion,
                        )),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          name: widget.name,
                          age: widget.age,
                          avatar: widget.avatar,
                          questionHistory: widget.questionHistory,
                          todayQuestion: widget.todayQuestion,
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

class ReactionIcon extends StatelessWidget {
  final String icon;
  final String label;

  const ReactionIcon({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          icon,
          style: const TextStyle(fontSize: 30),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: GoogleFonts.nunitoSans(fontSize: 12, color: Colors.white),
        ),
      ],
    );
  }
}
