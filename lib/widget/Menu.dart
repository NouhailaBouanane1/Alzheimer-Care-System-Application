import 'package:flutter/material.dart';
import 'Move.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Menu extends StatelessWidget {

  Function reset;
  int move;
  int secondsPassed;
  var size;

  Menu(this.reset, this.move, this.secondsPassed, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Move(move),
        ],
      ),
    );
  }
}