import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data/data.dart';
import 'models/TileModel.dart';

class HomeGame1 extends StatefulWidget {
  @override
  _HomeGame1State createState() => _HomeGame1State();
}

class _HomeGame1State extends State<HomeGame1> {
  List<TileModel> gridViewTiles = <TileModel>[];
  List<TileModel> questionPairs = <TileModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reStart();
  }
  void reStart() {

    myPairs = getPairs();
    myPairs.shuffle();

    gridViewTiles = myPairs;
    Future.delayed(const Duration(seconds: 6), () {
// Here you can write your code
      setState(() {
        print("20 seconds done");
        // Here you can write your code for open new view
        questionPairs = getQuestionPairs();
        gridViewTiles = questionPairs;
        selected = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flipping Cards",style: TextStyle(fontSize: 27),),
        backgroundColor: Colors.purpleAccent,
      ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
    child: Column(
    children: <Widget>[
    SizedBox(
    height: 40,
    ),
            points != 800 ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "$points/800",
                  style: TextStyle(
                      fontSize: 27, fontWeight: FontWeight.w500),
                ),
                Text(
                  AppLocalizations.of(context)!.points,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 27, fontWeight: FontWeight.w500),
                ),
              ],
            ) : Container(),
            SizedBox(
              height: 20,
            ),
            points != 800 ? GridView(
              shrinkWrap: true,
              //physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisSpacing: 0.0, maxCrossAxisExtent: 100.0),
              children: List.generate(gridViewTiles.length, (index) {
                return Tile(
                  imagePathUrl: gridViewTiles[index].getImageAssetPath(),
                  tileIndex: index,
                  parent: this,
                );
              }),
            ) : Container(
              child: Column(
                  children: <Widget>[
                  GestureDetector(
                  onTap: (){
            setState(() {
            points = 0;
            reStart();
            });
            },
              child: Container(
                height: 50,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  AppLocalizations.of(context)!.replay,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                ),),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
                onTap: (){
                  // TODO
                },
              child: Container(
                height: 50,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.blue,
                      width: 2
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  AppLocalizations.of(context)!.exit,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                ),),
              ),
            ),
    ])
        )
   ] )
    )
        )
    );
  }
}



class Tile extends StatefulWidget {
  String imagePathUrl;
  int tileIndex;
  _HomeGame1State parent;

  Tile({required this.imagePathUrl, required this.tileIndex, required this.parent});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!selected) {
          setState(() {
            myPairs[widget.tileIndex].setIsSelected(true);
          });
          if (selectedTile != "") {
            if (selectedTile == myPairs[widget.tileIndex].getImageAssetPath()) {
              print("add point");
              points = points + 100;
              print(selectedTile + " " + widget.imagePathUrl);

              TileModel tileModel = new TileModel('',false);
              print(widget.tileIndex);
              selected = true;
              Future.delayed(const Duration(seconds: 1), () {
                tileModel.setImageAssetPath("");
                myPairs[widget.tileIndex] = tileModel;
                print(selectedIndex);
                myPairs[selectedIndex] = tileModel;
                this.widget.parent.setState(() {});
                setState(() {
                  selected = false;
                });
                selectedTile = "";
              });
            } else {
              print(selectedTile +
                  "  " +
                  myPairs[widget.tileIndex].getImageAssetPath());
              print(
                  AppLocalizations.of(context)!.wrongChoice,
              );
              print(widget.tileIndex);
              print(selectedIndex);
              selected = true;
              Future.delayed(const Duration(seconds: 1), () {
                this.widget.parent.setState(() {
                  myPairs[widget.tileIndex].setIsSelected(false);
                  myPairs[selectedIndex].setIsSelected(false);
                });
                setState(() {
                  selected = false;
                });
              });

              selectedTile = "";
            }
          } else {
            setState(() {
              selectedTile = myPairs[widget.tileIndex].getImageAssetPath();
              selectedIndex = widget.tileIndex;
            });

            print(selectedTile);
            print(selectedIndex);
          }
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: myPairs[widget.tileIndex].getImageAssetPath() != ""
            ? ClipRRect(
          borderRadius: BorderRadius.circular(45),
          child: Image.asset(myPairs[widget.tileIndex].getIsSelected()
              ? myPairs[widget.tileIndex].getImageAssetPath()
              : widget.imagePathUrl,fit: BoxFit.fill,),
        )
            : Container(
          child: Image.asset("images/Game1Patient/correct.png",fit: BoxFit.fitHeight,),
        ),
      ),
    );
  }
}