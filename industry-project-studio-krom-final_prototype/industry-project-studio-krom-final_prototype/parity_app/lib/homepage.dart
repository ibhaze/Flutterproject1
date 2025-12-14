import 'dart:async'; // Import to use Timer
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'history.dart';
import 'profilepage.dart';
import 'responsescreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuestionAnswer {
  final String question;
  final String? answer;
  QuestionAnswer(this.question, [this.answer]);
}

class HomePage extends StatefulWidget {
  final String name;
  final String age;
  final String avatar;
  final List<QuestionAnswer> questionHistory;
  final String todayQuestion;

  const HomePage({
    super.key,
    required this.name,
    required this.age,
    required this.avatar,
    required this.questionHistory,
    required this.todayQuestion,
  });

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _answerController = TextEditingController();
  int _characterCount = 0;
  final int _maxCharacters = 200;

  String? _submittedAnswer; // Store submitted answer
  String todayQuestion = ""; // Dynamically selected question
  List<QuestionAnswer> questionHistory = []; // History of questions and answers
  List<String>? bestResponses; // Voeg dit toe als klassevariabele

  // List of questions
  final List<String> questions = [
    "Would you rather live in a bustling city or a quiet countryside? What draws you to that choice?",
    // "What is your favorite color?",
    // "What would you like to achieve in the future?",
    // "What is your favorite food?",
    // "What makes you happy?",
    // "What is your biggest dream?",
    // "What is the best gift you've ever received?",
  ];

  List<String> positiveComments = [
    "i'd definitely choose the city. I love the energy and the endless things to do—it's so exciting!",
    "Living in a city is amazing. Everything is so close, and there's always something happening.",
    "The city just feels alive. The variety of people and opportunities really draw me in.",
  ];
  List<String> neutralComments = [
    "Honestly, both have their perks. Cities are convenient, but the countryside is so peaceful.",
    "It really depends on where I am in life. Right now, maybe the city, but later on, I might want the quiet of the countryside.",
    "I don't think I could pick one. They each have their pros and cons.",
  ];
  List<String> negativeComments = [
    "The city's too crowded and overwhelming for me. I'd feel stressed all the time.",
    "The countryside sounds nice in theory, but it might get boring after a while.",
    "I don't think I'd feel completely happy in either. Both have things that would bother me.",
  ];

  // Lijst met gebruikersreacties (om deze uit te sluiten)
  List<String> userComments = [];

  Future<String> analyzeSentiment(String userInput) async {
    final apiKey =
        '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'; // Vul hier je OpenAI API-sleutel in
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "system",
              "content":
                  "Je bent een sentiment-analyse tool. Je classificeert teksten in één woord: 'Positief', 'Neutraal' of 'Negatief'. Je geeft nooit een vraag terug of vraagt om meer context. Als een reactie te kort is, beoordeel je deze alsnog op basis van de intentie. Dus geef ALTIJD een antwoord 'Positief', 'Neutraal' of 'Negatief'. Gebruik dus ook geen symbolen zoals een punt('.') achteraan. Geef altijd antwoord in het Nederlands, ook wanneer de reactie in een andere taal is."
            },
            {"role": "user", "content": userInput}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['choices'][0]['message']['content']
            .trim(); // Sentiment teruggeven
      } else {
        throw Exception("API Error: ${response.body}");
      }
    } catch (e) {
      return "error";
    }
  }

  Future<List<String>> getBestResponses(
      String userComment,
      List<String> positiveComments,
      List<String> neutralComments,
      List<String> negativeComments) async {
    final apiKey =
        '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'; // Vul hier je OpenAI API-sleutel in
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    String userCommentsToExclude =
        userComments.map((comment) => '"$comment"').join(', ');

    String prompt = '''
De vraag is: "$todayQuestion".
De gebruiker heeft de volgende reactie gegeven: "$userComment".

Hier zijn enkele reacties gegroepeerd per emotie:
- Positieve reacties: ${positiveComments.map((c) => '"$c"').join(', ')}
- Neutrale reacties: ${neutralComments.map((c) => '"$c"').join(', ')}
- Negatieve reacties: ${negativeComments.map((c) => '"$c"').join(', ')}

Belangrijke regels:
1. Kies één reactie van elk type (positief, neutraal, negatief) die het beste past bij zowel de vraag als de reactie van de gebruiker.
2. De reactie van de gebruiker zelf ("$userComment") en eerdere reacties van de gebruiker ($userCommentsToExclude) mogen nooit gekozen worden als antwoord.
3. Zorg ervoor dat elke reactie op zichzelf staat en geen combinatie bevat van meerdere reacties.
4. Maak nooit zelf een reactie aan. Gebruik altijd reacties uit de lijst.

Geef alleen het resultaat terug in het volgende formaat (geen extra tekst of uitleg!):
POSITIEF: [Reactie]
NEUTRAAL: [Reactie]
NEGATIEF: [Reactie]
  ''';

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "system",
              "content": "Je bent een empathische reactie-selector."
            },
            {"role": "user", "content": prompt}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        String bestResponses =
            result['choices'][0]['message']['content'].trim();

        final regex = RegExp(r"POSITIEF: (.*)\nNEUTRAAL: (.*)\nNEGATIEF: (.*)",
            dotAll: true);
        final match = regex.firstMatch(bestResponses);

        if (match != null) {
          String positiveResponse = match.group(1)!.trim();
          String neutralResponse = match.group(2)!.trim();
          String negativeResponse = match.group(3)!.trim();

          if (userComments.contains(positiveResponse) ||
              userComments.contains(neutralResponse) ||
              userComments.contains(negativeResponse)) {
            return await getBestResponses(userComment, positiveComments,
                neutralComments, negativeComments);
          }

          return [positiveResponse, neutralResponse, negativeResponse];
        } else {
          throw Exception("Reacties niet in het verwachte formaat ontvangen.");
        }
      } else {
        throw Exception("API Error: ${response.body}");
      }
    } catch (e) {
      return ["Error", "Error", "Error"];
    }
  }

  bool _isLightBulbOn = false; // Track light bulb state

  @override
  void initState() {
    super.initState();
    fetchQuestion();
  }

  // Fetch the question of the day
  void fetchQuestion() {
    final DateTime today = DateTime.now();
    final DateTime startDate = DateTime(2024, 12, 1);
    final int daysDifference = today.difference(startDate).inDays;
    int questionIndex = daysDifference % questions.length;

    setState(() {
      todayQuestion = questions[questionIndex];
      if (!questionHistory.any((qa) => qa.question == todayQuestion)) {
        questionHistory.add(QuestionAnswer(todayQuestion));
      }
    });
  }

  void handleAnswerSubmission(String userAnswer) {
    setState(() {
      _submittedAnswer = userAnswer;
      questionHistory.removeWhere((qa) => qa.question == todayQuestion);
      questionHistory.add(QuestionAnswer(todayQuestion, userAnswer));
    });
  }

  void toggleLightBulb() {
    setState(() {
      _isLightBulbOn = true; // Turn on the light bulb
    });

    Timer(const Duration(milliseconds: 500), () {
      // Show popup after 0.5 seconds
      setState(() {
        _isLightBulbOn = false; // Turn off the light bulb
      });
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12), // Optional: Add rounded corners
          ),
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxHeight: 400), // Cap the height to 280px
            child: Padding(
              padding:
                  const EdgeInsets.all(16.0), // Add padding for better layout
              child: Column(
                mainAxisSize: MainAxisSize.min, // Shrink-wrap the dialog
                children: [
                  Center(
                    child: Text(
                      "The horse icon means the question is more personal.",
                      textAlign: TextAlign.center, // Align text horizontally
                      style: const TextStyle(
                          fontSize: 16), // Optional: Adjust font size
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFE8D5),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Center(
              child: Image.asset(
                'assets/images/paritylogo.png',
                width: 60,
                height: 60,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF26A35),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Padding(
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
                          todayQuestion,
                          style: GoogleFonts.nunitoSans(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: toggleLightBulb,
                      child: Image.asset(
                        _isLightBulbOn
                            ? 'assets/images/lighton.png'
                            : 'assets/images/lightoff.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: _submittedAnswer == null
                    ? TextField(
                        controller: _answerController,
                        maxLength: _maxCharacters,
                        onChanged: (text) {
                          setState(() {
                            _characterCount = text.length;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Type your answer here...",
                          hintStyle: GoogleFonts.nunitoSans(
                            fontSize: 16,
                            color: const Color(0xFFB0B0B0),
                          ),
                          border: InputBorder.none,
                          counterText: "",
                        ),
                        style: GoogleFonts.nunitoSans(
                          fontSize: 16,
                          color: const Color(0xFF313B40),
                        ),
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _submittedAnswer!,
                          style: GoogleFonts.nunitoSans(
                            fontSize: 16,
                            color: const Color(0xFF313B40),
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _submittedAnswer == null
              ? Text(
                  "$_characterCount/$_maxCharacters",
                  style: GoogleFonts.nunitoSans(
                    fontSize: 14,
                    color: const Color(0xFF313B40),
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_submittedAnswer == null) {
                  final userInput = _answerController.text.trim();

                  if (userInput.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please enter your answer.")),
                    );
                    return;
                  }


                  // Toevoegen aan gebruikersreacties als deze nog niet bestaat
                  setState(() {
                    if (!userComments.contains(userInput)) {
                      userComments.add(userInput);
                    }
                  });

                  // Sentimentanalyse uitvoeren
                  String sentiment = await analyzeSentiment(userInput);


                  // Reacties sorteren op sentimentcategorieën
                  setState(() {
                    if (sentiment == "Positief") {
                      if (!positiveComments.contains(userInput)) {
                        positiveComments.add(userInput);
                      }
                    } else if (sentiment == "Neutraal") {
                      if (!neutralComments.contains(userInput)) {
                        neutralComments.add(userInput);
                      }
                    } else if (sentiment == "Negatief") {
                      if (!negativeComments.contains(userInput)) {
                        negativeComments.add(userInput);
                      }
                    }
                  });


                  // Genereer beste antwoorden
                  bestResponses = await getBestResponses(
                    userInput,
                    positiveComments,
                    neutralComments,
                    negativeComments,
                  );

                  _answerController.clear();

                  // Navigeren naar ResponseScreen met bijgewerkte data
                  Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResponseScreen(
                        userAnswer: userInput,
                        name: widget.name,
                        age: widget.age,
                        onBack: (answer) {
                          setState(() {
                            _submittedAnswer = answer;
                          });
                        },
                        avatar: widget.avatar,
                        todayQuestion: todayQuestion,
                        questionHistory: questionHistory,
                        bestResponses: bestResponses!,
                      ),
                    ),
                  );
                } else {
                  // Als er al een antwoord is ingediend, direct naar ResponseScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResponseScreen(
                        userAnswer: _submittedAnswer!,
                        name: widget.name,
                        age: widget.age,
                        onBack: (answer) {
                          setState(() {
                            _submittedAnswer = answer;
                          });
                        },
                        avatar: widget.avatar,
                        todayQuestion: todayQuestion,
                        questionHistory: questionHistory,
                        bestResponses: bestResponses!,
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF26A35),
                // ignore: deprecated_member_use
                shadowColor: Colors.black.withOpacity(0.5),
                elevation: 5,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                _submittedAnswer == null ? "Send & Continue" : "Continue",
                style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFEFE8D5),
        elevation: 4.0,
        selectedItemColor: const Color(0xFF313B40),
        unselectedItemColor: const Color(0xFF313B40),
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryPage(
                    name: widget.name,
                    age: widget.age,
                    avatar: widget.avatar,
                    questionHistory: questionHistory,
                    todayQuestion: todayQuestion,
                  ),
                ),
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
                    questionHistory: questionHistory,
                    todayQuestion: todayQuestion,
                  ),
                ),
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
