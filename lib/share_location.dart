import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

class ShareLocation extends StatefulWidget {
  const ShareLocation({Key? key}) : super(key: key);

  @override
  State<ShareLocation> createState() => _ShareLocationState();
}

class _ShareLocationState extends State<ShareLocation> {
  late GoogleMapController _controller;
  final CameraPosition _initCamera =
      const CameraPosition(target: LatLng(31.989222, 35.870361), zoom: 14);

  Marker _tappedMarker = const Marker(markerId: MarkerId('My Location'));
  Location location = Location();
  late LocationData _locationData;

  final _auth = FirebaseAuth.instance.currentUser!;

  final careGiverRef = FirebaseFirestore.instance.collection('Caregiver');

  @override
  void initState() {
    super.initState();
    checkLocationServices();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: getCurrentLocation(),
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(
          AppLocalizations.of(context)!.tapDownToShareLocation,
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: _initCamera,
        onMapCreated: (cont) async {
          _controller = cont;
          _locationData = await location.getLocation();
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target:
                      LatLng(_locationData.latitude!, _locationData.longitude!),
                  zoom: 16)));
        },
        markers: {_tappedMarker},
        onLongPress: (pos) => addMarker(pos),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
      ),
    );
  }

  void addMarker(LatLng pos) {
    setState(() {
      _tappedMarker = Marker(
        markerId: MarkerId(
          AppLocalizations.of(context)!.myLocation,
        ),
        position: pos,
        icon: BitmapDescriptor.defaultMarker,
      );
    });
  }

  Widget getCurrentLocation() {
    return InkWell(
      onTap: () async {
        _locationData = await location.getLocation();
        _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(_locationData.latitude!, _locationData.longitude!),
            zoom: 16)));
        var tempCareGivers = await FirebaseFirestore.instance
            .collection('Patients')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('CareGivers')
            .get();
        for (var careGiver in tempCareGivers.docs) {
          await FirebaseFirestore.instance.collection('LocationUpdates').add({
            'receiverUid': careGiver.id,
            'name': _auth.displayName,
            'senderUid': _auth.uid,
          });

          await careGiverRef
              .doc(careGiver.id)
              .collection('Locations')
              .doc(_auth.uid)
              .set(
            {
              'Last Location':
                  GeoPoint(_locationData.latitude!, _locationData.longitude!),
              'time': Timestamp.now(),
              'name': _auth.displayName,
            },
            SetOptions(merge: true),
          );
        }
      },
      child: Container(
        height: 7.2.h,
        width: 16.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.purpleAccent,
        ),
        child:
            const Icon(Icons.location_searching_rounded, color: Colors.white),
      ),
    );
  }

  void checkLocationServices() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }
}
