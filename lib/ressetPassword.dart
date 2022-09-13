import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ressetPassword extends StatefulWidget {
  const ressetPassword({Key? key}) : super(key: key);

  @override
  State<ressetPassword> createState() => _ressetPasswordState();
}

class _ressetPasswordState extends State<ressetPassword> {
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    final TextEditingController emailController = new TextEditingController();
    final _auth = FirebaseAuth.instance; //to call our firebase

    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.purpleAccent,
      title:Text(
        AppLocalizations.of(context)!.resetPassword,
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
    ),
    body:SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 22,),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(child: Image.asset('images/forgetPas.png',)),
            ),
            SizedBox(height: 26,),
            Text(
              AppLocalizations.of(context)!.forgetPassword,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black87),),
            SizedBox(height: 20,),
            Text(
              AppLocalizations.of(context)!.enterEmailToResetPass,
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black54),),
            SizedBox(height: 16,),
            Divider(
      color:Color(0xff673AB7),
  thickness: 3,
              indent: 35, // empty space to the leading edge of divider.
              endIndent: 35,

            ),
            SizedBox(height: 16,),

            Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
              autofocus: false,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                //this validator has a value
                if (value!.isEmpty) {
                  return (
                      AppLocalizations.of(context)!.pleaseEnterYourEmail
                  );
                }
                // reg expression for email validation
                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value)) {
                  return (
                      AppLocalizations.of(context)!.validEmail
                  );
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
                hintText: AppLocalizations.of(context)!.email,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              )),
        ),
            SizedBox(height: 14,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                   color: Colors.purpleAccent,
                  onPressed: (){
                    _auth.sendPasswordResetEmail(email: emailController.text );
                    Navigator.of(context).pop();              },
                  child: Text(
                    AppLocalizations.of(context)!.sendRequest,

                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                )

              ],
            ),
          ],
        ),
      ),
    ) ,

  );
  }

}
