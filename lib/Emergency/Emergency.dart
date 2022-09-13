import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:graduation_project/Emergency/next_pill.dart';
import 'package:graduation_project/mode_model.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Emergency extends StatelessWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _modeProv = Provider.of<Mode>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.fastmessages,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.purpleAccent,
          elevation: 0,

        ),
        body: Column(children: [
          Opacity(
            opacity: 0.5,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 15.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.purple,
                      Colors.indigo,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        await callMeFunction(context, _modeProv, "call me");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 25.h,
                        width: 50.w,
                        child: Text(
                          AppLocalizations.of(context)!.callMe,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.pinkAccent,
                                Colors.indigo,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))),
                          builder: (context) => const NextPillTime(),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 12.h,
                        width: 96.w,
                        child: Text(
                          AppLocalizations.of(context)!.whatIsMyNextPill,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.pinkAccent,
                                Colors.indigo,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await callMeFunction(context, _modeProv, "home");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 16.h,
                        width: 96.w,
                        child: Text(
                          AppLocalizations.of(context)!.findWayToHome,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.pinkAccent,
                                Colors.indigo,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),

                    /* Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 10,
                        primary: false,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: InkWell(
                              onTap: () {
                                /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            screen16Patient())
                                );*/
                              },
                              child: Container(

                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: InkWell(
                              onTap: () {
                               /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            screen19Patient()));*/
                              },

                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: InkWell(
                              onTap: () {
                               /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            screen17Patient()));*/
                              },

                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: InkWell(
                              onTap: () {
                               /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            screen20Patient()));*/
                              },

                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: InkWell(
                              onTap: () {
                               /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            screen18Patient()));*/
                              },

                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        );
              */
                  ]))
        ]));
  }

  Future callMeFunction(
      BuildContext context, Mode userMode, String mode) async {
    CollectionReference emergency =
        FirebaseFirestore.instance.collection('Emergency');
    final User user = FirebaseAuth.instance.currentUser!;
    Map<String, dynamic> firestoreData = {
      "mode": mode,
      "name": user.displayName,
      "senderUid": user.uid,
    };
    try {
      showLoading(context);
      var careGivers = await userMode.collectionRefMode!
          .doc(user.uid)
          .collection("CareGivers")
          .get();
      for (var careGiver in careGivers.docs) {
        firestoreData["receiverUid"] = careGiver.get('uid');
        await emergency.add(firestoreData);
      }

      hideLoading(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Done ...!'),
        duration: Duration(seconds: 5),
      ));
    } catch (e) {
      hideLoading(context);
      errorDialog(context, e.toString());
    }
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    debugPrint(size.width.toString());
    var path = new Path();
    path.lineTo(0, size.height);
    var firstStart = Offset(size.width / 5, size.height);
    var firstEnd = Offset(size.width / 2.25, size.height - 50);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    var secondEnd = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
