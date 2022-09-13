import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class patientRegistrationModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? mode;
  String? name;

  patientRegistrationModel(
      {this.email, this.firstName, this.secondName, this.uid});
  // receiving data from server
  factory patientRegistrationModel.fromMap(map) {
    return patientRegistrationModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }
  // sending data to our server
  Map<String, dynamic> toMap(
      patientRegistrationModel patientregistrationmodel) {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'mode': mode,
      'name': name
    };
  }
}
