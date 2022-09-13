import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'add_plcases.dart';
import 'edit_fav.dart';
import 'fav_provider.dart';

class FavInfo extends StatefulWidget {
  final String name;
  final List data;
  const FavInfo({Key? key, required this.name, required this.data})
      : super(key: key);

  @override
  _FavInfoState createState() => _FavInfoState();
}

class _FavInfoState extends State<FavInfo> {
  @override
  Widget build(BuildContext context) {
    var _favPlacesProv = Provider.of<FavPlaces>(context, listen: true);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(AppLocalizations.of(context)!.favorites ,
          style: const TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: height * 1,
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
        child: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              for (var fav in widget.data)
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 300,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 250,
                            child: Center(
                              child: Text(
                                fav,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                try {
                                  showLoading(context);
                                  await _favPlacesProv.deletePlace(
                                      fav, widget.name);
                                  hideLoading(context);
                                } catch (e) {
                                  hideLoading(context);
                                  errorDialog(context, e.toString());
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color:                 Color(0xFF9C27B0,)
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              SizedBox(
                height: widget.data.isNotEmpty ? 40 : 0,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => AddPlace(
                            mode: widget.name,
                          ));
                },
                child: Center(
                  child: Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color:                Color(0xFF9C27B0,)
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.add,
                        style: const TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              widget.data.isNotEmpty
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditFav(
                                      count: widget.data.length,
                                      type: widget.data,
                                      mode: widget.name,
                                    )));
                      },
                      child: Center(
                        child: Container(
                          width: 250,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color:                Color(0xFF9C27B0,)
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.edit,
                              style: TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
