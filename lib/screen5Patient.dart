import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/ressetPassword.dart';
import 'package:graduation_project/non_patient/home_page.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:graduation_project/screen1Patient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/screen6Patient.dart';
import 'package:graduation_project/screen7Patient.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'mode_model.dart';

class screen5Patient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => screen5PatientState();
}

class screen5PatientState extends State<screen5Patient> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _auth = FirebaseAuth.instance; //to call our firebase
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    var _modeProv = Provider.of<Mode>(context, listen: false);
    final emailField = TextFormField(
        style: TextStyle(fontSize: 30),
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          //this validator has a value
          if (value!.isEmpty) {
            return (  AppLocalizations.of(context)!.pleaseEnterYourEmail);
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ( AppLocalizations.of(context)!.validEmail);
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText:AppLocalizations.of(context)!.email,hintStyle: TextStyle(fontSize: 40),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
////////////////////////////////////////////////////////////////////////
    final passwordField = TextFormField(
        style: TextStyle(fontSize: 30),
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return (  AppLocalizations.of(context)!.passwordRequired);
          }
          if (!regex.hasMatch(value)) {
            return (AppLocalizations.of(context)!.numOfCharInPass);
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText:
          AppLocalizations.of(context)!.password,hintStyle: TextStyle(fontSize: 40),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
                    SizedBox(
                        height: 260,
                        child: Image.asset(
                          "images/logo.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 10),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 35),
                    firebaseUIButton(context,   AppLocalizations.of(context)!.signIn, () {
                      signIn(emailController.text, passwordController.text,
                          _modeProv);
                    }),
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              AppLocalizations.of(context)!.dontHaveAccount,
                            style: TextStyle(fontSize: 24),),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => screen6Patient()));
                            },
                            child: Text(
                                AppLocalizations.of(context)!.signUp,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          )
                        ]),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                         onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ressetPassword()));},

                               child: Text(
                                 AppLocalizations.of(context)!.resetPassword,

                              style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    /*return Scaffold(
          body: SingleChildScrollView(
            child: Container(

                      child: Column(
                          children: <Widget>[
                            Container(
                             child: Image.asset(*/
    /*    "images/login.jpg",
                                height: size.height * 0.34,
                                width: double.infinity,
                                fit: BoxFit.cover,

                              ),
                            ),

                        Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        20, MediaQuery.of(context).size.height * 0.06, 16, 0),
                                    child: Container(
                                      height: size.height * 0.40,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30)),
                                      ),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ////////////////////////////////
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: emailField,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: passwordField,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),


                                          firebaseUIButton(context, "Sign In", () {
                                            signIn(emailController.text,passwordController.text);}),


                                          signUpOption()


                                        ],
                                      ),


                                    ),
                                  ),
                                ]

                            ),
                          ),



                        )


                    ]  )
                ),
          ),
      );*/
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(

            AppLocalizations.of(context)!.dontHaveAccount,

            style: TextStyle(color: Colors.black,fontSize: 18)
        ),
        GestureDetector(
          //it detects when user click on this
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => screen6Patient()));
          },
          child:  Text(
            AppLocalizations.of(context)!.signUp,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child:  Text(
          AppLocalizations.of(context)!.forgetPassword,

          style: TextStyle(color: Colors.black,fontSize: 24),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen6Patient())),
      ),
    );
  }

  ///////////////////////////////////////////
///////login function
  void signIn(String email, String password, Mode prov) async {
    if (_formKey.currentState!.validate()) {
      try {
        showLoading(context);
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) {
          hideLoading(context);
          Fluttertoast.showToast(msg:
          AppLocalizations.of(context)!.loginSuccessful,
          );
          if (prov.userMode == 'Patients') {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => screen7Patient()));
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false);
          }
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
}
