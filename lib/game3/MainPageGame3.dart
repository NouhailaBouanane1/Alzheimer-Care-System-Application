

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/game3/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPageGame3 extends StatefulWidget {
  final String title;

  const MainPageGame3({
    required this.title,

  });

  @override
  _MainPageGame3State createState() => _MainPageGame3State();
}

class Player {
  static const none = '';
  static const X = 'X';
  static const O = 'O';
}

class _MainPageGame3State extends State<MainPageGame3> {
  static final countMatrix = 3;
  static final double size = 92;

  String lastMove = Player.none;
  late List<List<String>> matrix;

  @override
  void initState() {
    super.initState();

    setEmptyFields();
  }

  void setEmptyFields() => setState(() => matrix = List.generate(
    countMatrix,
        (_) => List.generate(countMatrix, (_) => Player.none),
  ));

  Color getBackgroundColor() {
    final thisMove = lastMove == Player.X ? Player.O : Player.X;

    return getFieldColor(thisMove).withAlpha(150);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: getBackgroundColor(),
    appBar: AppBar(
      title: Text("Tic Tac Toe",style: TextStyle(fontSize: 29),),
      backgroundColor: Colors.purpleAccent,
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Utils.modelBuilder(matrix, (x, value) => buildRow(x)),
    ),
  );

  Widget buildRow(int x) {
    final values = matrix[x];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Utils.modelBuilder(
        values,
            (y, value) => buildField(x, y),
      ),
    );
  }

  Color getFieldColor(String value) {
    switch (value) {
      case Player.O:
        return Colors.redAccent;
      case Player.X:
        return Colors.green;
      default:
        return Colors.white;
    }
  }

  Widget buildField(int x, int y) {
    final value = matrix[x][y];
    final color = getFieldColor(value);

    return Container(
      margin: EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(size, size),
          primary:color,
        ),
        child: Text(value, style: TextStyle(fontSize: 32)),
        onPressed: () => selectField(value, x, y,context),
      ),
    );
  }

  void selectField(String value, int x, int y,BuildContext context) {
    if (value == Player.none) {
      final newValue = lastMove == Player.X ? Player.O : Player.X;

      setState(() {
        lastMove = newValue;
        matrix[x][y] = newValue;
      });

      if (isWinner(x, y)) {
        showEndDialog(AppLocalizations.of(context)!.player +' $newValue '+AppLocalizations.of(context)!.won);
      } else if (isEnd()) {
        showEndDialog(AppLocalizations.of(context)!.undecidedGame,);
      }
    }
  }

  bool isEnd() =>
      matrix.every((values) => values.every((value) => value != Player.none));

  bool isWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    final player = matrix[x][y];
    final n = countMatrix;

    for (int i = 0; i < n; i++) {
      if (matrix[x][i] == player) col++;
      if (matrix[i][y] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i - 1] == player) rdiag++;
    }

    return row == n || col == n || diag == n || rdiag == n;
  }

  Future showEndDialog(String title) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(
          AppLocalizations.of(context)!.pressToRestartTheGame,style: TextStyle(fontSize: 32),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            setEmptyFields();
            Navigator.of(context).pop();
          },
          child: Text(
              AppLocalizations.of(context)!.restart,style: TextStyle(fontSize: 32)
          ),
        )
      ],
    ),
  );
}