import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mode_model.dart';

class PatientDrugHome extends StatefulWidget {
  const PatientDrugHome({Key? key}) : super(key: key);

  @override
  State<PatientDrugHome> createState() => _PatientDrugHomeState();
}

class _PatientDrugHomeState extends State<PatientDrugHome> {
  final User _user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    var _userMode = Provider.of<Mode>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        color:Colors.purpleAccent
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child:
                          Icon(Icons.arrow_back_ios_new, color: Colors.white)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("images/pill1.jpg"),
                      ),
                      SizedBox(width: 16),
                      Text(
                        AppLocalizations.of(context)!.drugsReminder,

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Drugs')
                          .doc(_user.uid)
                          .collection('Drugs')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> streamSnap) {
                        if (streamSnap.hasData) {
                          var tempList = streamSnap.data!.docs;
                          List data = [];
                          for (var element in tempList) {
                            data.add(element.data());
                          }
                          return data.isNotEmpty
                              ? ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: streamSnap.data!.size,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: 3,
                                      child: ListTile(
                                        leading:
                                            Image.asset(data[index]['type'],width: 50),
                                        title: Text(data[index]['name'],style:TextStyle(fontSize: 40,fontWeight: FontWeight.bold)),
                                        subtitle: Text(data[index]['duration'] +
                                            '\nAt: ' +
                                            data[index]['time'],style:TextStyle(fontSize: 38,color: Colors.deepPurple,fontWeight: FontWeight.w500)),
                                      

                                      ),
                                    );
                                  })
                              : Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.noDrugsYet,
                                    style: TextStyle(
                                      fontSize: 36
                                    ),
                                      ),
                                );
                        } else if (streamSnap.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                              color: Colors.purpleAccent);
                        } else if (streamSnap.hasError) {
                          errorDialog(context,
                              AppLocalizations.of(context)!.errorOccuredTryLater,
                          );
                          return const SizedBox();
                        } else {
                          return const SizedBox();
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
