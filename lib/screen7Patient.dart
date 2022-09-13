import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Favorites/fav_provider.dart';
import 'package:graduation_project/screen15Patient.dart';
import 'package:graduation_project/screen5Patient.dart';
import 'package:graduation_project/screen8Patient.dart';
import 'package:provider/provider.dart';

class screen7Patient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => screen7PatientState();
}

class screen7PatientState extends State<screen7Patient> {
  late FavPlaces _favPlaces;

  void initData() async {
    await _favPlaces.initData();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _favPlaces = Provider.of<FavPlaces>(context, listen: false);
      initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.alzheimerCareSystem,
          style: TextStyle(
            fontSize: 29,
          ),
        ),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Image.asset("images/pu.webp"),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FlatButton(
                      padding: EdgeInsets.all(25),
                      color: Colors.purpleAccent,
                      child: Row(
                        children: [
                          Icon(Icons.add_box_rounded,
                              size: 50, color: Colors.white),
                          Text(
                            AppLocalizations.of(context)!.addDoctor,
                            style: TextStyle(
                                fontSize: 34,
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => screen8Patient(
                                      mode: 'Doctors',
                                    )));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FlatButton(
                      padding: EdgeInsets.all(25),
                      color: Colors.purpleAccent,
                      child: Row(
                        children: [
                          const Icon(Icons.add_box_rounded,
                              size: 50, color: Colors.white),
                          Text(
                            AppLocalizations.of(context)!.addCaregiver,
                            style: const TextStyle(
                                fontSize: 34,
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const screen8Patient(mode: 'Caregiver')));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: const Icon(
          Icons.skip_next,
          color: Colors.black87,
        ),
        label: Text(
          AppLocalizations.of(context)!.skip,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => screen15Patient()),
              (route) => false);
        },
      ),
    );
  }
}

/*class WaveClipper extends CustomClipper {  @override
  getClip(Size size) {
   debugPrint(size.width.toString());
   var path=new Path();
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
(Path) {

}*/