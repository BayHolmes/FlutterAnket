import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(HealthApp());
}

class HealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroductionScreen(),
    );
  }
}

class IntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sağlıklı mısınız?',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Başla',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => QuestionScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _questionIndex = 0;
  List<String> _answers = List.filled(10, '');
  List<bool> positiveQuestions = [false, true, false, true, false, true, false, false, false, true];
  int _positiveCounter = 0;
  int _negativeCounter = 0;

  void answerQuestion(String answer) {
    String previousAnswer = _answers[_questionIndex];
    if (previousAnswer == 'Evet') {
      if (positiveQuestions[_questionIndex]) {
        _positiveCounter--;
      } else {
        _negativeCounter--;
      }
    } else if (previousAnswer == 'Hayır') {
      if (positiveQuestions[_questionIndex]) {
        _negativeCounter--;
      } else {
        _positiveCounter--;
      }
    }

    if (answer == 'Evet') {
      if (positiveQuestions[_questionIndex]) {
        _positiveCounter++;
      } else {
        _negativeCounter++;
      }
    } else if (answer == 'Hayır') {
      if (positiveQuestions[_questionIndex]) {
        _negativeCounter++;
      } else {
        _positiveCounter++;
      }
    }

    _answers[_questionIndex] = answer;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  void previousQuestion() {
    if (_questionIndex <= 0) {
      return;
    }
    setState(() {
      _questionIndex = _questionIndex - 1;
    });
  }
  @override
  Widget build(BuildContext context) {
    const questions = [
      'Her gün hamburger yer misiniz?',
      'Günlük 2 litre su içer misiniz?',
      '6 saatten az mı uyursunuz?',
      'Günlük yeşillik tüketir misiniz?',
      'Çok şeker tüketir misiniz?',
      'Spor yapıyor musunuz?',
      'Sigara içiyor musunuz?',
      'Alkol alıyor musunuz?',
      'Çok stresli misiniz?',
      'Hijyenik birisi misiniz?',
    ];

    const animations = [
      'https://assets1.lottiefiles.com/packages/lf20_xzp76fg7.json',
      'https://assets8.lottiefiles.com/packages/lf20_gnfU3G.json',
      'https://assets10.lottiefiles.com/packages/lf20_xa9j5lkk.json',
      'https://assets4.lottiefiles.com/private_files/lf30_fcotb6bb.json',
      'https://assets9.lottiefiles.com/packages/lf20_gW8vUv.json',
      'https://assets6.lottiefiles.com/packages/lf20_ezwv0556.json',
      'https://assets9.lottiefiles.com/packages/lf20_PdtuTJ3d4n.json',
      'https://assets5.lottiefiles.com/packages/lf20_RFHPja.json',
      'https://assets2.lottiefiles.com/packages/lf20_yjctgQFZqI.json',
      'https://assets1.lottiefiles.com/packages/lf20_6v5h4ckl.json',
    ];

    if (_questionIndex >= questions.length) {
      Future.microtask(() =>
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              isHealthy: _positiveCounter > _negativeCounter,
            ),
          ),
        ),
      );
      return Container();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Soru ${_questionIndex + 1}'),
        backgroundColor: Colors.blue,
      ),
  body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        height: 300,
        child: Lottie.network(animations[_questionIndex]),
      ),
      Center(
        child: Text(
          questions[_questionIndex],
          style: TextStyle(fontSize: 28),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            onPressed: () => answerQuestion('Evet'),
            child: Text('Evet'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => answerQuestion('Hayır'),
            child: Text('Hayır'),
          ),
        ],
      ),
      if (_questionIndex > 0)
      ElevatedButton(
        onPressed: previousQuestion,
        child: Text('Önceki soruya dön'),
      ),
    ],
  ),
);
  }
}
class ResultScreen extends StatefulWidget {
  final bool isHealthy;
  final animations = [
    'https://assets2.lottiefiles.com/packages/lf20_odbacomn.json', // Sağlıklı sonucu
    'https://assets1.lottiefiles.com/packages/lf20_ccxfskpm.json', // Sağlıksız sonucu
  ];

  ResultScreen({required this.isHealthy});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sonuç'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 300,
              child: Lottie.network(widget.isHealthy ? widget.animations[0] : widget.animations[1]),
            ),
            Center(
              child: Text(
                widget.isHealthy ? 'Sağlıklısınız' : 'Sağlıksızsınız',
                style: TextStyle(fontSize: 36, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => IntroductionScreen()),
                  );
                },
                child: Text(
                  'Başa Dön',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
