import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({Key? key}) : super(key: key);

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Timer? countDownTimer;
  Duration myDuration = Duration(days: 5);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void startTimer() {
    countDownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() {
      countDownTimer!.cancel();
    });
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      myDuration = Duration(days: 5);
    });
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;

      if (seconds < 0) {
        countDownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Container(
      child: Text(
        '$days:$hours:$minutes:$seconds',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 50),
      ),
    );
  }
}
