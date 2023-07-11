import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anket Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuestionScreen(questionIndex: 0, answers: []),
    );
  }
}

class QuestionScreen extends StatefulWidget {
  final int questionIndex;
  final List<bool> answers;

  QuestionScreen({required this.questionIndex, required this.answers});

  @override
  _QuestionScreenState createState() =>
      _QuestionScreenState(questionIndex, answers);
}

class _QuestionScreenState extends State<QuestionScreen> {
  int questionIndex;
  List<bool> answers;
  List<String> questions = [
    'Her gün hamburger yiyor musun?',
    'Her gün pepsi içiyor musun?',
    'Günde 6 saatten az mı uyuyorsun?',
    'Gereğinden az mı yeşillik tüketiyorsun?',
    'Gündelik şeker tüketimin çok mu?'
  ];

  _QuestionScreenState(this.questionIndex, this.answers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anket - Soru ${questionIndex + 1}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              questions[questionIndex],
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  child: Text('EVET'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () => answerQuestion(true),
                ),
                SizedBox(width: 20),
                TextButton(
                  child: Text('HAYIR'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () => answerQuestion(false),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void answerQuestion(bool answer) {
    answers.add(answer);
    if (questionIndex >= questions.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(isHealthy: countYesAnswers() < 3),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionScreen(questionIndex: questionIndex + 1, answers: answers),
        ),
      );
    }
  }

  int countYesAnswers() {
    return answers.where((element) => element).length;
  }
}

class ResultScreen extends StatelessWidget {
  final bool isHealthy;

  ResultScreen({required this.isHealthy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sonuç'),
      ),
      body: Center(
        child: Text(
          isHealthy ? 'Sağlıklısın' : 'Sağlıksızsın',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
