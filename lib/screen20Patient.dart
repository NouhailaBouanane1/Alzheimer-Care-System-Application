import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/Favorites/fav_provider.dart';
import 'package:graduation_project/Favorites/favorite_menu.dart';
import 'package:graduation_project/Gallery/video.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:graduation_project/screen15Patient.dart';
import 'package:graduation_project/testGames.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class screen20Patient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => screen20PatientState();
}

class screen20PatientState extends State<screen20Patient> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _favProv = Provider.of<FavPlaces>(context, listen: false);

    Future initFavData() async {
      if (_favProv.isInitialized) {
        return;
      } else {
        showLoading(context);
        await _favProv.initData();
        hideLoading(context);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title:  Text(
            AppLocalizations.of(context)!.aboutYou,
            style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.purpleAccent,
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                color: Colors.white,
              ),
              Container(
                width: size.width / 3,
                height: size.height,
                color: Colors.purple[200],
              ),
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: ListView(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationBarvideo()));
                        },
                        child: testGames(
                          name: AppLocalizations.of(context)!.memories,
                          image: "images/screen20Img/memories.jpg",
                        )),
                    InkWell(
                        onTap: () async {
                          try {
                            await initFavData();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Favorites()));
                          } catch (e) {
                            hideLoading(context);
                            errorDialog(context, e.toString());
                          }
                        },
                        child: testGames(
                          name: AppLocalizations.of(context)!.favorites,
                          image: "images/screen20Img/favorite.jpg",
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
