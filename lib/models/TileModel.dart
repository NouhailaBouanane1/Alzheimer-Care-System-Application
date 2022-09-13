import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TileModel{

  String imageAssetPath;
  bool isSelected;

  TileModel( this.imageAssetPath, this.isSelected);

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  void setIsSelected(bool getIsSelected){
    isSelected = getIsSelected;
  }

  bool getIsSelected(){
    return isSelected;
  }
}