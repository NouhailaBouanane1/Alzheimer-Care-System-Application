import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:graduation_project/models/TileModel.dart';

String selectedTile = "";
int selectedIndex =0;
bool selected = true;
int points = 0;

List<TileModel> myPairs = <TileModel>[];
List<bool> clicked = <bool>[];

List<bool> getClicked(){


  List<bool> yoClicked = <bool>[];
  List<TileModel> myairs = <TileModel>[];
  myairs = getPairs();
  for(int i=0;i<myairs.length;i++){
    yoClicked[i] = false;
  }

  return yoClicked;
}

List<TileModel>  getPairs(){

  List<TileModel> pairs = <TileModel>[];

  TileModel tileModel = TileModel('',false);

  //1
  tileModel.setImageAssetPath("images/Game1Patient/flower.jpg");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/flower.jpg",false);

  //2
  tileModel.setImageAssetPath("images/Game1Patient/girrafe.jpg");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/girrafe.jpg",false);

  //3
  tileModel.setImageAssetPath("images/Game1Patient/hawaei.jpg");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/hawaei.jpg",false);

  //4
  tileModel.setImageAssetPath("images/Game1Patient/MoonLamp.jpg");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/MoonLamp.jpg",false);
  //5
  tileModel.setImageAssetPath("images/Game1Patient/nature-water.jpg");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/nature-water.jpg",false);

  //6
  tileModel.setImageAssetPath("images/Game1Patient/paris.jpg");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/paris.jpg",false);

  //7
  tileModel.setImageAssetPath("images/Game1Patient/ship.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/ship.png",false);

  //8
  tileModel.setImageAssetPath("images/Game1Patient/shutterstock.jpg");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/shutterstock.jpg",false);

  return pairs;
}

List<TileModel>  getQuestionPairs(){

  List<TileModel> pairs = <TileModel>[];

  TileModel tileModel = TileModel('',false);

  //1
  tileModel.setImageAssetPath("images/Game1Patient/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/question.png",false);

  //2
  tileModel.setImageAssetPath("images/Game1Patient/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/question.png",false);

  //3
  tileModel.setImageAssetPath("images/Game1Patient/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/question.png",false);

  //4
  tileModel.setImageAssetPath("images/Game1Patient/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/question.png",false);
  //5
  tileModel.setImageAssetPath("images/Game1Patient/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/question.png",false);

  //6
  tileModel.setImageAssetPath("images/Game1Patient/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/question.png",false);

  //7
  tileModel.setImageAssetPath("images/Game1Patient/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/question.png",false);

  //8
  tileModel.setImageAssetPath("images/Game1Patient/question.png");
  tileModel.setIsSelected(false);
  pairs.add(tileModel);
  pairs.add(tileModel);
  tileModel = new TileModel("images/Game1Patient/question.png",false);

  return pairs;
}