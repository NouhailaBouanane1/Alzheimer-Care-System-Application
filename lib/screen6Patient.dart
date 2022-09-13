import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/non_patient/home_page.dart';
import 'package:graduation_project/patientRegistrationModel.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/screen7Patient.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';
import 'mode_model.dart';

class screen6Patient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => screen6PatientState();
}

class screen6PatientState extends State<screen6Patient> {
  //Storage instance
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? image;
  final _auth = FirebaseAuth.instance; //to call our firebase
  String? errorMessage;
  Widget bottomSheet() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 150,
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          Text(
            AppLocalizations.of(context)!.selectProfilePicture,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Row(
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Text(
                    AppLocalizations.of(context)!.camera,
                    style: TextStyle(
                      fontSize: 26,

                    ),
                  )),
              FlatButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text(
                    AppLocalizations.of(context)!.gallery,
                    style: TextStyle(
                      fontSize: 26,

                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      // final ImageTemprorary=File(image.path);
      final ImagePermenant = await saveImagePermanently(image.path);
      setState(() {
        this.image = ImagePermenant;
      });
    } on PlatformException catch (e) {
      print(""
          "Failed to pick Image:"
          " $e");
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    String name = Path.basename(imagePath);
    final image = File('${directory.absolute}/$name');

    return File(imagePath);
  }

  Widget imageProfile() {
    return Center(
      //we put it center in order to see the cam icon above the image
      child: Stack(children: <Widget>[
        image != null
            ? ClipOval(
                child: Image.file(
                  image!,
                  fit: BoxFit.fill,
                  width: 140.0,
                  height: 140.0,
                ),
              )
            : const CircleAvatar(
                backgroundImage: AssetImage("images/profile.png"),
                radius: 70,
              ),
        Positioned(
          //to add another bottom image
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            //we rap the icon with inkwell widget to see bottom options when we click on the image
            onTap: () {
              showModalBottomSheet(
                //this is a widget to provide a bottomsheet
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.purple,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _modeProv = Provider.of<Mode>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    final firstNameField = TextFormField(
        style: TextStyle(fontSize: 30),
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return (AppLocalizations.of(context)!.firstNameCannotBeEmpty);
          }
          if (!regex.hasMatch(value)) {
            return (AppLocalizations.of(context)!.validName);
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: AppLocalizations.of(context)!.firstName,hintStyle: TextStyle(fontSize: 28),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //second name field
    final secondNameField = TextFormField(
        style: TextStyle(fontSize: 30),
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return (AppLocalizations.of(context)!.secondNameCannotBeEmpty);
          }
          return null;
        },
        onSaved: (value) {
          secondNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: AppLocalizations.of(context)!.secondName,hintStyle: TextStyle(fontSize: 28),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //email field
    final emailField = TextFormField(
        style: TextStyle(fontSize: 30),
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return (AppLocalizations.of(context)!.pleaseEnterYourEmail);
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return (AppLocalizations.of(context)!.validEmail);
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: AppLocalizations.of(context)!.email,hintStyle: TextStyle(fontSize: 28),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        style: TextStyle(fontSize: 30),
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return (AppLocalizations.of(context)!.passwordRequired);
          }
          if (!regex.hasMatch(value)) {
            return (AppLocalizations.of(context)!.numOfCharInPass);
          }
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: AppLocalizations.of(context)!.password,hintStyle: TextStyle(fontSize: 28),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        style: TextStyle(fontSize: 30),
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return AppLocalizations.of(context)!.passMatch;
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: AppLocalizations.of(context)!.confirmPassword,hintStyle: TextStyle(fontSize: 28),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.purple,size: 22,),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 8,
                    ),
                    imageProfile(),
                    SizedBox(height: 45),
                    firstNameField,
                    SizedBox(height: 20),
                    secondNameField,
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    confirmPasswordField,
                    SizedBox(height: 20),
                    firebaseUIButton(
                        context, AppLocalizations.of(context)!.signUp, () {
                      signUp(emailEditingController.text,
                          passwordEditingController.text, _modeProv);
                    }),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    /* return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },

        ),
      ),
      backgroundColor: Colors.purple[200],
        body: SafeArea(
          child: ListView(
          children:[Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                        child: Container(
                          height: size.height*0.9,
                          width: size.width*0.87,
                          color: Colors.white,
                          child:Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              imageProfile(),

                              const SizedBox(
                                height: 30,
                              ),


                              Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8),
                                child: firstNameField,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8),
                                child: secondNameField,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8),
                                child: emailField,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8),
                                child: passwordField,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8),
                                child: confirmPasswordField,
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              firebaseUIButton(context, "Sign Up", () {
                                signUp(emailEditingController.text, passwordEditingController.text);
                              })
                            ],
                          ),
                        ))),

              ]
          )]

    )
                              )

    );*/
  }
//to register the user to database

  void signUp(String email, String password, Mode prov) async {
    if (_formKey.currentState!.validate()) {
      try {
        String? fcm;
        await FirebaseMessaging.instance
            .getToken()
            .then((value) => fcm = value!)
            .onError((error, stackTrace) => fcm = '');
        showLoading(context);
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          await postDetailsToFirestore(prov, fcm!);
          if (prov.userMode == 'Patients') {
            Navigator.pushAndRemoveUntil(
                (context),
                MaterialPageRoute(builder: (context) => screen7Patient()),
                (route) => false);
          } else {
            if (prov.userMode == 'Caregiver') {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);
            }
          }
        }).catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        hideLoading(context);
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  Future postDetailsToFirestore(Mode prov, String fcm) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    patientRegistrationModel patientregistrationmodel =
        patientRegistrationModel();
    patientregistrationmodel.email = user?.email;
    patientregistrationmodel.uid = user?.uid;
    patientregistrationmodel.firstName = firstNameEditingController.text;
    patientregistrationmodel.secondName = secondNameEditingController.text;
    patientregistrationmodel.mode = prov.userMode;
    patientregistrationmodel.name = firstNameEditingController.text;
    showLoading(context);
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .set(patientregistrationmodel.toMap(patientregistrationmodel));

    /*
    To set the user userName directly from firebaseAuth, so you don't need to get the user name from
    Firestore
    */
    user!.updateDisplayName(firstNameEditingController.text);
    if (mounted) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.accountCreatedSuccessfully,
      );
    }

    await firebaseFirestore.collection(prov.userMode!).doc(user.uid).set({
      'uid': user.uid,
      'name': firstNameEditingController.text,
      'email': emailEditingController.text
    });

    //Save the fcm token in the Tokens collection
    await firebaseFirestore.collection('Tokens').doc(user.uid).set({
      'uid': user.uid,
      'name': firstNameEditingController.text,
      'email': emailEditingController.text,
      'fcm': fcm,
    });

    if (prov.userMode == 'Patients') {
      await firebaseFirestore.collection('Drugs').doc(user.uid).set({
        'uid': user.uid,
        'name': firstNameEditingController.text,
        'email': emailEditingController.text
      });

      await firebaseFirestore.collection('To Do').doc(user.uid).set({
        'uid': user.uid,
        'name': firstNameEditingController.text,
        'email': emailEditingController.text
      });
    }

    //User profile pic ref
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/${user.uid}')
        .child('ProfilePicture')
        .child('ProfilePic.png');

    String? photoUrl;
    if (image != null) {
      try {
        //To upload the user profile to firebase Storage
        await ref.putFile(image!);
        /*
        To set the user profile pic directly from firebaseAuth, so you don't have to get the photo from
        Firestore
        */
        photoUrl = await ref.getDownloadURL();
        _auth.currentUser!.updatePhotoURL(photoUrl);
        hideLoading(context);
        Navigator.pushAndRemoveUntil(
            (context),
            MaterialPageRoute(builder: (context) => screen7Patient()),
            (route) => false);
      } catch (e) {
        if (mounted) {
          hideLoading(context);
        }
        print(e);
      }
    }
  }
}
