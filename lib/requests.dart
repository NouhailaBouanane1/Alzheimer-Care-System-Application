import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Requests extends StatefulWidget {
  final String mode;
  const Requests({Key? key, required this.mode}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> reqStream;

  @override
  void initState() {
    super.initState();
    reqStream = FirebaseFirestore.instance
        .collection('Requests')
        .where('receiverUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(
          AppLocalizations.of(context)!.requests,
          style: TextStyle(fontSize: 29),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.center,
            child: Material(
              elevation: 5,
              child: Container(
                height: 170,
                width: 140,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/addfrinds.jpg')),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: StreamBuilder(
            stream: reqStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.size > 0) {
                  return ListView.builder(
                    itemCount: snapshot.data!.size,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xffF1DBFF),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.docs[index]['name'],
                                style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  const Spacer(),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                    ),
                                    onPressed: () async {
                                      await delReq(
                                          snapshot.data!.docs[index].id);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.delete,
                                      style: TextStyle(fontSize: 32),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color(0xffB262E2),
                                      ),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                    ),
                                    onPressed: () async {
                                      await acceptReq(
                                          snapshot.data!.docs[index].id,
                                          snapshot.data!.docs[index]['name'],
                                          snapshot.data!.docs[index]
                                              ['senderUId'],
                                          snapshot.data!.docs[index]['email']);
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.accept,
                                    style: TextStyle(fontSize: 32),),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Text(
                    AppLocalizations.of(context)!.noRequest,
                    style: TextStyle(fontSize: 18),
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    height: 150,
                    width: 150,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.purple[200],
                    )));
              } else if (snapshot.hasError) {
                errorDialog(context, snapshot.error.toString());
                return const SizedBox();
              } else {
                return const SizedBox();
              }
            },
          ))
        ],
      ),
    );
  }

  Future delReq(String docId) async {
    try {
      showLoading(context);
      await FirebaseFirestore.instance
          .collection('Requests')
          .doc(docId)
          .delete();
      hideLoading(context);
    } catch (e) {
      hideLoading(context);
      errorDialog(
        context,
        AppLocalizations.of(context)!.errorOccuredTryLater,
      );
    }
  }

  Future acceptReq(
      String docId, String name, String patId, String email) async {
    try {
      showLoading(context);
      //To save the patient to the patients collection, inside the caregiver or the doctor.
      await FirebaseFirestore.instance
          .collection(widget.mode)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Patients')
          .doc(patId)
          .set({'name': name, 'email': email, 'uid': patId});

      //To delete the request from the collection.
      await FirebaseFirestore.instance
          .collection('Requests')
          .doc(docId)
          .delete();

      if (widget.mode == 'Doctors') {
        //To set the doc ID in the patient document.
        await FirebaseFirestore.instance.collection('Patients').doc(patId).set(
            {'doctorId': FirebaseAuth.instance.currentUser!.uid},
            SetOptions(merge: true));
        //To get the caregivers that are associated with the patient.
        var tempCareGiverData = await FirebaseFirestore.instance
            .collection('Patients')
            .doc(patId)
            .collection('CareGivers')
            .get();
        //To save the caregiver that are associated with the patient to the doctor so they can chat
        //with each other.
        for (var careGiver in tempCareGiverData.docs) {
          await FirebaseFirestore.instance
              .collection(widget.mode)
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('CareGivers')
              .doc(careGiver.id)
              .set(careGiver.data());
        }
      } else {
        //To save the caregiver inisde the patient caregivers Collection
        await FirebaseFirestore.instance
            .collection('Patients')
            .doc(patId)
            .collection('CareGivers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'name': FirebaseAuth.instance.currentUser!.displayName,
          'email': FirebaseAuth.instance.currentUser!.email,
          'uid': FirebaseAuth.instance.currentUser!.uid
        });
        hideLoading(context);
      }
    } catch (e) {
      hideLoading(context);
      errorDialog(
        context,
        AppLocalizations.of(context)!.errorOccuredTryLater,
      );
    }
  }
}
