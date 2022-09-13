import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:graduation_project/ToDo/ToDoMain.dart';
import 'package:graduation_project/ToDo/task_data.dart';
import 'package:graduation_project/chatMessages/chatScreen.dart';
import 'package:graduation_project/drugReminder/drug_prov.dart';
import 'package:graduation_project/non_patient/Diseases/diseases.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'drugReminder/drugReminder.dart';
import 'mode_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UsersList extends StatefulWidget {
  final String mode;
  final Mode userMode;
  final String nav;
  const UsersList(
      {Key? key, required this.mode, required this.userMode, required this.nav})
      : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final User user = FirebaseAuth.instance.currentUser!;

  late Future<QuerySnapshot<Object?>> functionMode;

  Future getAllUsers() async {
    List allUsersData = [];

    if (widget.userMode.userMode != 'Patients') {
      if (widget.userMode.userMode == 'Doctors') {
        var patData = await widget.userMode.collectionRefMode!
            .doc(user.uid)
            .collection('Patients')
            .get();
        for (var patinent in patData.docs) {
          allUsersData.add(patinent.data());
        }
        var careGiversData = await widget.userMode.collectionRefMode!
            .doc(user.uid)
            .collection('CareGivers')
            .get();
        for (var careGiver in careGiversData.docs) {
          allUsersData.add(careGiver.data());
        }
        return allUsersData;
      } else {
        var patData = await widget.userMode.collectionRefMode!
            .doc(user.uid)
            .collection('Patients')
            .get();
        for (var patinent in patData.docs) {
          allUsersData.add(patinent.data());
          Map temp = patinent.data();
          String patUid = temp['uid'];
          var tempPatDoc = await FirebaseFirestore.instance
              .collection('Patients')
              .doc(patUid)
              .get();
          Map tempPatDocInfo = tempPatDoc.data() as Map;
          if (tempPatDocInfo.containsKey('doctorId')) {
            var tempDocDocument = await FirebaseFirestore.instance
                .collection('Doctors')
                .doc(tempPatDocInfo['doctorId'])
                .get();
            allUsersData.add(tempDocDocument.data());
          }
          return allUsersData;
        }
      }
    } else {
      var careGiversData = await widget.userMode.collectionRefMode!
          .doc(user.uid)
          .collection('CareGivers')
          .get();
      for (var careGiver in careGiversData.docs) {
        allUsersData.add(careGiver.data());
      }
      DocumentSnapshot<Object?> patInfo =
          await widget.userMode.collectionRefMode!.doc(user.uid).get();

      Map patIndoData = patInfo.data() as Map;

      if (patIndoData.containsKey('doctorId')) {
        DocumentSnapshot<Object?> docInfo = await FirebaseFirestore.instance
            .collection('Doctors')
            .doc(patIndoData['doctorId'])
            .get();

        Map docInfoData = docInfo.data() as Map;
        allUsersData.add(docInfoData);
      }

      return allUsersData;
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.mode == 'Patients') {
      functionMode = widget.userMode.collectionRefMode!
          .doc(user.uid)
          .collection('Patients')
          .get();
    }
  }

  @override
  Widget build(BuildContext context) {
    var _drugProv = Provider.of<DrugProv>(context, listen: false);
    var _userMode = Provider.of<Mode>(context, listen: false);
    var _toDoProv = Provider.of<taskData>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.usersList,
          style: TextStyle(fontSize: 29),
        ),
        backgroundColor: Colors.purpleAccent,
      ),
      body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top:4.h,left: 1.w, right: 1.w),
                  child: widget.mode == 'Patients'
                      ? FutureBuilder<QuerySnapshot>(
                          future: functionMode,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.size > 0) {
                                return SizedBox(
                                  height: 250.h,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          switch (widget.nav) {
                                            case 'Drugs':
                                              showLoading(context);
                                              await _drugProv.initData(
                                                  snapshot.data!.docs[index]
                                                      ['uid'],
                                                  true);
                                              hideLoading(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DrugMainCareDoctor(
                                                    patUid: snapshot.data!
                                                        .docs[index]['uid'],
                                                  ),
                                                ),
                                              );
                                              break;
                                            case 'Disease':
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PatientDiseases(
                                                          patUid: snapshot.data!
                                                                  .docs[index]
                                                              ['uid']),
                                                ),
                                              );
                                              break;
                                            case 'Chat':
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatScreen(
                                                    reciver: snapshot.data!
                                                        .docs[index]['uid'],
                                                    sender: FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid,
                                                    userMode: _userMode,
                                                  ),
                                                ),
                                              );
                                              break;
                                            case 'ToDo':
                                              showLoading(context);
                                              await _toDoProv.initData(
                                                  snapshot.data!.docs[index]
                                                      ['uid'],
                                                  true);
                                              hideLoading(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ToDoMain(
                                                          patUid: snapshot.data!
                                                                  .docs[index]
                                                              ['uid']),
                                                ),
                                              );
                                              break;
                                          }
                                        },
                                        child: Card(
                                          color: Colors.white70,
                                          child: ListTile(
                                              title: Text(snapshot
                                                  .data!.docs[index]['name'],style: TextStyle(fontSize:36 ,fontWeight: FontWeight.bold),),
                                              subtitle: Text(snapshot
                                                  .data!.docs[index]['email'],style: TextStyle(fontSize:24 ,fontWeight: FontWeight.bold),),
                                              trailing: const Icon(Icons
                                                  .arrow_forward_ios_outlined)),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .noPatientToBeDisplayed,
                                    style: TextStyle(fontSize: 32),
                                  ),
                                );
                              }
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LoadingIndicator();
                            } else {
                              return const SizedBox();
                            }
                          },
                        )
                      : FutureBuilder(
                          future: getAllUsers(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List data = snapshot.data as List;
                              if (data.isNotEmpty) {
                                return SizedBox(
                                  height: 100.h,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          switch (widget.nav) {
                                            case 'Drugs':
                                              showLoading(context);
                                              await _drugProv.initData(
                                                  data[index]['uid'], true);
                                              hideLoading(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DrugMainCareDoctor(
                                                    patUid: data[index]['uid'],
                                                  ),
                                                ),
                                              );
                                              break;
                                            case 'Disease':
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PatientDiseases(
                                                          patUid: data[index]
                                                              ['uid']),
                                                ),
                                              );
                                              break;
                                            case 'Chat':
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatScreen(
                                                    reciver: data[index]['uid'],
                                                    sender: FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid,
                                                    userMode: _userMode,
                                                  ),
                                                ),
                                              );
                                              break;
                                          }
                                        },
                                        child: Card(
                                          color: Colors.white70,
                                          child: ListTile(
                                              title: Text(data[index]['name'],style: TextStyle(fontSize:36 ,fontWeight: FontWeight.bold),),
                                              subtitle:
                                                  Text(data[index]['email'],style: TextStyle(fontSize:24 ,fontWeight: FontWeight.w500,color:Colors.deepPurple),),
                                              trailing: const Icon(Icons
                                                  .arrow_forward_ios_outlined)),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .noPatientToBeDisplayed,
                                    style: TextStyle(fontSize: 38),
                                  ),
                                );
                              }
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LoadingIndicator();
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                ),
              ),
            ));



}
  }