import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Move extends StatelessWidget {

  int move;

  Move(this.move);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(

        "Move: ${move}",
        style: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
            fontSize: 34
        ),
      ),
    );
  }
}