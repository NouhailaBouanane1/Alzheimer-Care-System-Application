import 'package:flutter/material.dart';
import 'package:graduation_project/Favorites/fav_provider.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddPlace extends StatefulWidget {
  final String mode;
  const AddPlace({Key? key, required this.mode}) : super(key: key);

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  TextEditingController textCont = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _favPlaces = Provider.of<FavPlaces>(context, listen: false);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: TextField(
        controller: textCont,
        autofocus: true,
        onSubmitted: (val) async {
          if (textCont.text.isNotEmpty) {
            showLoading(context);
            await _favPlaces.addPlace(val, widget.mode);
            hideLoading(context);
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        },
        decoration:  InputDecoration(
          contentPadding: EdgeInsets.all(8),
          hintText: AppLocalizations.of(context)!.addPlaces,
        ),
      ),
    );
  }
}
