import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Grid extends StatelessWidget {
  var numbers = [];
  var size;
  Function clickGrid;

  Grid(this.numbers, this.size, this.clickGrid);

  @override
  Widget build(BuildContext context) {
    var height = size.height;

    return Container(
        height: height * 0.60,
        child: Padding(
          padding: const EdgeInsets.only(top:65,left: 15,right: 15),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              return numbers[index] != 0
                  ?GestureDetector(
                onTap: (){
                  clickGrid(index);
                },
                child:  Card(
                  child: Container(
                    height:20,
                    width:20,
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          numbers[index].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),


                ),
              ) : SizedBox.shrink();
            },
          ),
        ),
      );

  }
}