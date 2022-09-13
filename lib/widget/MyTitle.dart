import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyTitle extends StatelessWidget {
  var size;

  MyTitle(this.size);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Material(
        child: Container(
          height: size.height * 0.06,
          color: Colors.purpleAccent,
          child: Row(
            children: [
              InkWell(
                  child: Icon(Icons.arrow_back,size: 28,color: Colors.white,),
                onTap: (){Navigator.pop(context);},
                
              ),
              SizedBox(
                width: 18,
              ),

              Text(
                "Sliding Puzzle",
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,

                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
        ),
      ),

    );
  }
}