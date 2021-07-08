import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class Trigger extends StatefulWidget {
  const Trigger({Key? key}) : super(key: key);

  @override
  _TriggerState createState() => _TriggerState();
}

class _TriggerState extends State<Trigger> {
  CountDownController _controller = CountDownController();
  int _duration = 10;

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency !",
        style: TextStyle(
            color: Color(0xFFEDF0DA),
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
        ),),
        backgroundColor: Color(0xFF0077B6),
      ),
      body: Center(
        child: CircularCountDownTimer(
          duration: _duration,
          initialDuration: 0,
          controller: _controller,
          width: MediaQuery
          .of(context)
          .size
          .width/2,
          height: MediaQuery
          .of(context)
          .size
          .height/2,
          ringColor: Colors.black12,
          ringGradient: null,
          fillColor: Colors.red,
          fillGradient: null,
          backgroundColor: Colors.white,
          backgroundGradient: null,
          strokeWidth: 50.0,
          strokeCap: StrokeCap.round,
          textStyle: TextStyle(
            fontSize: 60.0,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
          textFormat: CountdownTextFormat.S,
          isReverse:true,
          isReverseAnimation: false,
          isTimerTextShown: true,
          autoStart: true,
          onComplete: () {
            Navigator.pushReplacementNamed(context, '/final', arguments: data);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
            Icons.cancel,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
