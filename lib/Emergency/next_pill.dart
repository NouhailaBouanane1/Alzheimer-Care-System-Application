import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NextPillTime extends StatefulWidget {
  const NextPillTime({Key? key}) : super(key: key);

  @override
  State<NextPillTime> createState() => _NextPillTimeState();
}

class _NextPillTimeState extends State<NextPillTime> {
  late CollectionReference _durgsRef;

  final User _user = FirebaseAuth.instance.currentUser!;

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  @override
  void initState() {
    super.initState();
    _durgsRef = FirebaseFirestore.instance
        .collection('Drugs')
        .doc(_user.uid)
        .collection('Drugs');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.only(top: 6.h, left: 3.5.w, right: 3.5.w),
      child: FutureBuilder(
        future: _durgsRef.get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.size > 0) {
              Map pill = {};
              List data = [];
              double timeNow = toDouble(TimeOfDay.now());

              for (var pill in snapshot.data!.docs) {
                data.add(pill.data());
              }
              double diff =
                  toDouble(stringToTimeOfDay(data[0]['time'])) - timeNow;
              pill = data[0];
              for (var pills in data) {
                if (timeNow < toDouble(stringToTimeOfDay(pills['time']))) {
                  if (toDouble(stringToTimeOfDay(pills['time'])) - timeNow <
                      diff) {
                    diff = toDouble(stringToTimeOfDay(pills['time']));
                    pill = pills;
                  }
                }
              }

              return Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.yourNextPill,
                    style: const TextStyle(fontSize: 24


                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Card(
                    elevation: 3,
                    child: ListTile(
                      leading: Image.asset(pill['type']),
                      title: Text(pill['name'],style: TextStyle(fontSize: 22),),
                      subtitle: Text(pill['duration'] + ' ' + pill['time'],style: TextStyle(fontSize: 22)),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.youDontHaveAnyPill,
                  style: const TextStyle(fontSize: 24),
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            errorDialog(context, 'An error occurred');
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
