import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Favorites/fav_provider.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditFav extends StatefulWidget {
  final int count;
  final List type;
  final String mode;
  const EditFav(
      {Key? key, required this.count, required this.type, required this.mode})
      : super(key: key);
  @override
  _EditFavState createState() => _EditFavState();
}

class _EditFavState extends State<EditFav> {
  List<TextEditingController> placesCont = [];

  void initTextConts(List data) {
    for (int i = 0; i < widget.count; i++) {
      placesCont.add(TextEditingController(text: data[i]));
    }
    if (mounted) {
      setState(() {});
    }
  }

  void disposeTextCont() {
    for (int i = 0; i < placesCont.length; i++) {
      placesCont[i].dispose();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      var _favPlacesData = Provider.of<FavPlaces>(context, listen: false);
      initTextConts(_favPlacesData.places);
    });
  }

  @override
  void dispose() {
    super.dispose();
    disposeTextCont();
  }

  @override
  build(BuildContext context) {
    int countData = widget.count;
    var _favPlaces = Provider.of<FavPlaces>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height *
              ((widget.type.length / 10) + 0.5),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var cont in placesCont)
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child: TextFormField(
                          controller: cont,
                          autofocus: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              InkWell(
                onTap: () async {
                  for (int i = 0; i < placesCont.length; i++) {
                    if (placesCont[i].text.isNotEmpty) {
                      showLoading(context);
                      await _favPlaces.editPlaces(
                          placesCont[i].text, i, widget.mode);
                      hideLoading(context);
                    }
                  }

                  Navigator.pop(context);
                },
                child: Ink(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Center(
                    child: Text(
                      AppLocalizations.of(context)!.save,
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
