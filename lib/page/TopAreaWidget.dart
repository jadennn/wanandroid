import 'package:flutter/material.dart';
import 'dart:math' as math;

class TopAreaWidget extends StatelessWidget{
  final Widget child;
  final Color color;

  TopAreaWidget({@required this.child, this.color=Colors.blueGrey});

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = MediaQuery.of(context).padding;
    double top = math.max(padding.top , 0);

    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: top,
          color: color,
        ),
        Expanded(child: child),
      ],
    );
  }

}
