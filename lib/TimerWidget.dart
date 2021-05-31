import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'theme_base.dart';

import 'common.dart';

class TimerWidget extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    var state = new _TimerWidgetState();
    state.startClock();
    return state;
  }
}

class _TimerWidgetState extends ClockBaseState<TimerWidget> {

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
            text: " 当前时间：",
            style: TextStyle(
              height: 1.5,
            )),
        TextSpan(
            text:
            "${now.year}-${now.month}-${now.day} ${pad0(now.hour)}:${pad0(now.minute)}:${pad0(now.second)}",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.lightBlue,
              height: 1.5,
            ))
      ]),
    );
  }
}
