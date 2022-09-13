import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/patientRegistrationModel.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:graduation_project/screen1Patient.dart';
import 'package:graduation_project/screen5Patient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;

class screen8Patient extends StatefulWidget {
  final String mode;
  const screen8Patient({Key? key, required this.mode}) : super(key: key);

  @override
  State<StatefulWidget> createState() => screen8PatientState();
}

class screen8PatientState extends State<screen8Patient> {
  late CollectionReference dataRef;

  CollectionReference patientsRef =
      FirebaseFirestore.instance.collection('Patients');

  User user = FirebaseAuth.instance.currentUser!;

  final _auth = FirebaseAuth.instance; //to call our firebase
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataRef = FirebaseFirestore.instance.collection(widget.mode);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.alzheimerCareSystem,style: TextStyle(fontSize: 29),
        ),
        backgroundColor: Colors.purpleAccent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
        //  Image.asset("images/pu.webp"),
          Center(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0,left: 15,top: 12),
                  child: FutureBuilder<QuerySnapshot>(
                    future: dataRef.get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: size.height,
                          width: size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.white70,
                                child: ListTile(
                                  title:
                                      Text(snapshot.data!.docs[index]['name'],style: TextStyle(fontSize: 38,fontWeight: FontWeight.bold),),
                                  subtitle:
                                      Text(snapshot.data!.docs[index]['email'],style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                  trailing: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.purpleAccent[200]),
                                    child: IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () async {
                                        showLoading(context);
                                        await sendReq(
                                          snapshot.data!.docs[index]['uid'],
                                          user.displayName!,
                                          user.email!,
                                          user.uid,
                                        );
                                        hideLoading(context);
                                        Navigator.pop(context);
                                      },
                                      color: Colors.white,
                                      splashRadius: 25,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
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
            ),
          ),
        ],
      ),
    );
  }
//to register the user to database


  Future sendReq(
      String docId, String name, String email, String userUid) async {
    FirebaseFirestore.instance.collection('Requests').add({
      'name': name,
      'email': email,
      'senderUId': userUid,
      'receiverUid': docId
    });
  }
}
