import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = []; //Maintains score
  QuizBrain quizBrain = QuizBrain();
  void checkAnswer(bool userAnswer) {
    bool answer = quizBrain.getAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(context: context, title: 'Quiz Compleated', buttons: [
          DialogButton(
            child: Text('Play Again'),
            onPressed: () => Navigator.pop(context),
          )
        ]).show();

        quizBrain.reset();
        scoreKeeper = [];
      } else if (userAnswer == answer)
        scoreKeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      else
        scoreKeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );

      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
            child: Text(
              'QUIZZY QUIZZLER',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontFamily: 'Pacifico',
                letterSpacing: 7.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          //Displaying Question
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestion(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          //Response when TRUE button clicked
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  checkAnswer(true);
                  //The user picked true.
                },
              ),
            ),
          ),

          //Response when FALSE button clicked
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                color: Colors.red,
                child: Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  checkAnswer(false);
                  //The user picked false.
                },
              ),
            ),
          ),

          // Displaying the ScoreKeeper
          Row(
            children: scoreKeeper,
          ),
        ],
      ),
    );
  }
}

/*
question1:
*/
