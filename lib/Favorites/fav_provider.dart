import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavPlaces extends ChangeNotifier {
  List placesData = [];

  List foodData = [];

  List colorsData = [];

  List drinksData = [];

  // ignore: prefer_final_fields
  bool _isInit = false;

  final String _userUid = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference favPlacesRef =
      FirebaseFirestore.instance.collection('Patients');

  List get places => placesData;

  List get food => foodData;

  List get drinks => drinksData;

  List get colors => colorsData;

  bool get isInitialized => _isInit;

  late Map _placesKeys;

  late Map _foodKeys;

  late Map _drinksKeys;

  late Map _colorsKeys;

  Future initData() async {
    try {
      _placesKeys = (await favPlacesRef
                  .doc(_userUid)
                  .collection('fav')
                  .doc('Places')
                  .get())
              .data() ??
          {};
      _foodKeys =
          (await favPlacesRef.doc(_userUid).collection('fav').doc('Food').get())
                  .data() ??
              {};

      _drinksKeys = (await favPlacesRef
                  .doc(_userUid)
                  .collection('fav')
                  .doc('Drinks')
                  .get())
              .data() ??
          {};

      _colorsKeys = (await favPlacesRef
                  .doc(_userUid)
                  .collection('fav')
                  .doc('Colors')
                  .get())
              .data() ??
          {};

      _placesKeys.forEach((key, value) {
        placesData.add(value);
      });

      _colorsKeys.forEach(((key, value) {
        colorsData.add((value));
      }));

      _drinksKeys.forEach(((key, value) {
        drinksData.add((value));
      }));

      _foodKeys.forEach(((key, value) {
        foodData.add((value));
      }));

      _isInit = true;

      notifyListeners();
    } catch (e) {
      return Future.error('An error occurred, Please try again later!');
    }
  }

  Future addPlace(String place, String mode) async {
    switch (mode) {
      case 'Places':
        placesData.add(place);

        _placesKeys['place${placesData.length}'] = place;

        await favPlacesRef
            .doc(_userUid)
            .collection('fav')
            .doc(mode)
            .set({'place${placesData.length}': place}, SetOptions(merge: true));

        notifyListeners();
        break;
      case 'Colors':
        colorsData.add(place);

        _colorsKeys['color${colorsData.length}'] = place;

        await favPlacesRef
            .doc(_userUid)
            .collection('fav')
            .doc(mode)
            .set({'color${colorsData.length}': place}, SetOptions(merge: true));

        notifyListeners();
        break;
      case 'Food':
        foodData.add(place);

        _foodKeys['food${foodData.length}'] = place;

        await favPlacesRef
            .doc(_userUid)
            .collection('fav')
            .doc(mode)
            .set({'food${foodData.length}': place}, SetOptions(merge: true));

        notifyListeners();
        break;
      case 'Drinks':
        drinksData.add(place);

        _drinksKeys['drink${drinksData.length}'] = places;

        await favPlacesRef
            .doc(_userUid)
            .collection('fav')
            .doc(mode)
            .set({'drink${drinksData.length}': place}, SetOptions(merge: true));

        notifyListeners();
        break;
    }
  }

  Future deletePlace(String place, String mode) async {
    switch (mode) {
      case 'Places':
        try {
          placesData.removeWhere((element) => element == place);
          _placesKeys.removeWhere((key, value) => value == place);
          Map<String, String> temp = {};
          for (int i = 0; i < placesData.length; i++) {
            temp['place${i + 1}'] = placesData[i];
          }
          _placesKeys.clear();
          _placesKeys = temp;
          await favPlacesRef
              .doc(_userUid)
              .collection('fav')
              .doc('Places')
              .delete();
          await favPlacesRef
              .doc(_userUid)
              .collection('fav')
              .doc('Places')
              .set(temp);

          notifyListeners();
        } catch (e) {
          return Future.error('An error occurred, please try again later!');
        }

        break;

      case 'Colors':
        try {
          colorsData.removeWhere((element) => element == place);
          _colorsKeys.removeWhere((key, value) => value == place);
          Map<String, String> temp = {};
          for (int i = 0; i < colorsData.length; i++) {
            temp['color${i + 1}'] = colorsData[i];
          }
          _colorsKeys.clear();
          _colorsKeys = temp;
          await favPlacesRef.doc(_userUid).collection('fav').doc(mode).delete();
          await favPlacesRef
              .doc(_userUid)
              .collection('fav')
              .doc(mode)
              .set(temp);

          notifyListeners();
        } catch (e) {
          return Future.error('An error occurred, please try again later!');
        }

        break;
      case 'Drinks':
        try {
          drinksData.removeWhere((element) => element == place);
          _drinksKeys.removeWhere((key, value) => value == place);
          Map<String, String> temp = {};
          for (int i = 0; i < drinksData.length; i++) {
            temp['drink${i + 1}'] = drinksData[i];
          }
          _drinksKeys.clear();
          _drinksKeys = temp;
          await favPlacesRef.doc(_userUid).collection('fav').doc(mode).delete();
          await favPlacesRef
              .doc(_userUid)
              .collection('fav')
              .doc(mode)
              .set(temp);

          notifyListeners();
        } catch (e) {
          return Future.error('An error occurred, please try again later!');
        }
        break;

      case 'Food':
        try {
          foodData.removeWhere((element) => element == place);
          _foodKeys.removeWhere((key, value) => value == place);
          Map<String, String> temp = {};
          for (int i = 0; i < foodData.length; i++) {
            temp['food${i + 1}'] = foodData[i];
          }
          _foodKeys.clear();
          _foodKeys = temp;
          await favPlacesRef.doc(_userUid).collection('fav').doc(mode).delete();
          await favPlacesRef
              .doc(_userUid)
              .collection('fav')
              .doc(mode)
              .set(temp);

          notifyListeners();
        } catch (e) {
          return Future.error('An error occurred, please try again later!');
        }

        break;
    }
  }

  Future editPlaces(String place, int index, String mode) async {
    switch (mode) {
      case 'Places':
        placesData[index] = place;

        await favPlacesRef
            .doc(_userUid)
            .collection('fav')
            .doc(mode)
            .update({'place${index + 1}': place});
        notifyListeners();

        break;
      case 'Drinks':
        drinksData[index] = place;

        await favPlacesRef
            .doc(_userUid)
            .collection('fav')
            .doc(mode)
            .update({'drink${index + 1}': place});
        notifyListeners();
        break;
      case 'Food':
        foodData[index] = place;

        await favPlacesRef
            .doc(_userUid)
            .collection('fav')
            .doc(mode)
            .update({'food${index + 1}': place});
        notifyListeners();
        break;
      case 'Colors':
        colorsData[index] = place;

        await favPlacesRef
            .doc(_userUid)
            .collection('fav')
            .doc(mode)
            .update({'color${index + 1}': place});
        notifyListeners();
        break;
    }
  }
}
