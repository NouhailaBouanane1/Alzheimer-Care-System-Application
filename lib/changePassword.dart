import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/patientRegistrationModel.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/screen1Patient.dart';
import 'package:graduation_project/screen7Patient.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class changePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => changePasswordState();
}

class changePasswordState extends State<changePassword> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final currentUser=FirebaseAuth.instance.currentUser;
  final passwordEditingController = TextEditingController();
  final NewPasswordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  var newPassword='';
  String? errorMessage;
  void dispose(){
    NewPasswordEditingController.dispose();
    super.dispose();
  }
changePassword() async{
  try{
    await currentUser?.updatePassword(newPassword);
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>screen1Patient()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black54,
      content: Text(
        AppLocalizations.of(context)!.passHasBeenChanged,
        style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),),
    ),);

  }catch(error){}
}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return (
                AppLocalizations.of(context)!.passwordRequired);
          }
          if (!regex.hasMatch(value)) {
            return (
                AppLocalizations.of(context)!.numOfCharInPass);
          }
        },
        onSaved: (value) {
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: AppLocalizations.of(context)!.currentPassword,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final NewPasswordField = TextFormField(
        autofocus: false,
        controller: NewPasswordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return (
                AppLocalizations.of(context)!.passwordRequired);
          }
          if (!regex.hasMatch(value)) {
            return (
                AppLocalizations.of(context)!.numOfCharInPass
            );
          }
        },
        onSaved: (value) {
          NewPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText:AppLocalizations.of(context)!.enterNewPass,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));


    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              NewPasswordEditingController.text) {
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
          hintText: AppLocalizations.of(context)!.confirmPassword,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.purpleAccent,
        title:Text(
          AppLocalizations.of(context)!.changePass,

          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
      ),
      body:SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("images/changePassword.png",width: size.width*0.5,height: size.height*0.6,),
                    passwordField,
                    SizedBox(height: 20),
                    NewPasswordField,
                    SizedBox(height: 20),
                    confirmPasswordField,
                    SizedBox(height: 20),
                    RaisedButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          newPassword=NewPasswordEditingController.text;
                        });
                        changePassword();
                      }
                    }, child: Text(
                      AppLocalizations.of(context)!.changePass,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),)

                  ],
                ),
              ),
            ),
          ),
        ),

    );
  }
}