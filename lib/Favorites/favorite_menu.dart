import 'package:flutter/material.dart';
import 'package:graduation_project/Favorites/fav_info.dart';
import 'package:graduation_project/Favorites/fav_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _favProv = Provider.of<FavPlaces>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.favorites,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.purpleAccent,
          elevation: 0,

        ),
        body: Stack(children: <Widget>[
          Container(
            height: 700,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFFE1BEE7,),
                    Colors.white10,
                    Color(0xFF9C27B0,)
                  ]),
            ),
          ),
          Column(
            children: [
              INkwellMethod(
                name: AppLocalizations.of(context)!.places,
                image: "images/place.jpg",
                wid: FavInfo(name: AppLocalizations.of(context)!.places, data: _favProv.places),
              ),
              const SizedBox(height: 30),
              InkwelRightMethod(
                name: AppLocalizations.of(context)!.colors,
                image: "images/colors.jpg",
                wid: FavInfo(name: AppLocalizations.of(context)!.colors, data: _favProv.colors),
              ),
              const SizedBox(height: 30),
              INkwellMethod(
                  name: AppLocalizations.of(context)!.food,
                  image: "images/food.jpg",
                  wid: FavInfo(name: AppLocalizations.of(context)!.food, data: _favProv.food)),
              const SizedBox(height: 30),
              InkwelRightMethod(
                name: AppLocalizations.of(context)!.drinks,
                image: "images/drinks.jpg",
                wid: FavInfo(name: AppLocalizations.of(context)!.drinks, data: _favProv.drinks),
              ),
            ],
          ),
        ]));
  }
}

class InkwelRightMethod extends StatelessWidget {
  const InkwelRightMethod({
    Key? key,
    required this.name,
    required this.image,
    required this.wid,
  }) : super(key: key);
  final String name;
  final String image;
  final Widget wid;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => wid));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        child: Stack(clipBehavior: Clip.none, children: [
          Positioned(
              child: Container(
            height: 100,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(200),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 45)),
                const Spacer(),
                SizedBox(
                  width: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(70.0),
                      child: Image.asset(
                        image,
                        width: 160,
                        height: 200,
                        fit: BoxFit.fill,
                      )),
                ),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}

class INkwellMethod extends StatelessWidget {
  const INkwellMethod({
    Key? key,
    required this.name,
    required this.image,
    required this.wid,
  }) : super(key: key);
  final String name;
  final String image;
  final Widget wid;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => wid));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Stack(children: [
          Positioned(
              child: Container(
            height: 100,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(200),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(70.0),
                      child: Image.asset(
                        image,
                        width: 160,
                        height: 200,
                        fit: BoxFit.fill,
                      )),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 45)),
                ),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
