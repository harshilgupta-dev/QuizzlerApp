import 'package:flutter/material.dart';
import 'defination/QuizzBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizzBrain quizzBrain = QuizzBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  int currentScore=0;

  void checkAnswer(bool userAnswer){
    bool correctAnswer=quizzBrain.getQuestionAnswer();
    if(correctAnswer==userAnswer){
      scoreKepper.add(Icon(Icons.check,color: Colors.green,));
      currentScore++;
    }
    else {
      scoreKepper.add(Icon(Icons.close,color: Colors.red,));
      if(currentScore==0){
        currentScore=0;
      }
    }
  }

  List<Icon> scoreKepper=[];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizzBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
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
                setState(() {
                  if(!quizzBrain.isFinished()){
                    checkAnswer(true);
                    quizzBrain.nextQuestion();
                  }
                  else{
                    Alert(
                        context: context,
                        title: 'Test Finished',
                        type: AlertType.success,
                        content: Text('Score is $currentScore/12 '),
                        style: AlertStyle(
                            isCloseButton: false,
                            titleStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0)),
                        buttons: [
                          DialogButton(child: Text(
                            'Give It Again',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white
                            ),), onPressed: (){
                            setState(() {
                              quizzBrain.reset();
                              scoreKepper.clear();
                              currentScore=0;
                              return Navigator.pop(context);
                            });
                          })
                        ]

                    ).show();
                  }
                }
                );
              },
            ),
          ),
        ),
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
                setState(() {
                  if(!quizzBrain.isFinished()){
                    checkAnswer(false);
                    quizzBrain.nextQuestion();
                  }
                  else{
                    Alert(
                        context: context,
                        title: 'Test Finished',
                        type: AlertType.success,
                        content: Text('Score is $currentScore/12 '),
                        style: AlertStyle(
                            isCloseButton: false,
                            titleStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0)),
                        buttons: [
                          DialogButton(child: Text(
                            'Give It Again',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white
                            ),), onPressed: (){
                            setState(() {
                              quizzBrain.reset();
                              scoreKepper.clear();
                              currentScore=0;
                              return Navigator.pop(context);
                            });
                          })
                        ]

                    ).show();
                  }
                  }
                );
              },
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: scoreKepper,
        ),
      ],
    );
  }
}




/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/