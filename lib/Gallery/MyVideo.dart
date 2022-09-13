import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Gallery/play_video.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as Path;
import '../reusable_widgets/reusable_widget.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';


class MyVideo extends StatefulWidget {
  @override
  _MyVideoState createState() => _MyVideoState();
}

class _MyVideoState extends State<MyVideo> {
  final _auth = FirebaseAuth.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? video;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text(
          AppLocalizations.of(context)!.videos,   style: TextStyle(fontSize: 25),     ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff9C27B0), Color(0xffBA68C8)],
              stops: [0.5, 1.0],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickVideo(ImageSource.gallery, context);
        },
        backgroundColor: Colors.transparent,
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.purple,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
          future: getVideos(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List images = snapshot.data as List;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.2),
                shrinkWrap: true,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlayVideo(
                                videoUrl: images[index]['videoUrl']))),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: 220,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          File(images[index]['thmbnail']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * .8,
                width: MediaQuery.of(context).size.width * 1,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.purpleAccent,
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height * .8,
                width: MediaQuery.of(context).size.width * 1,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future getVideos(BuildContext context) async {
    User? user = _auth.currentUser;
    final storageRef =
        FirebaseStorage.instance.ref(user!.uid).child('Videos').child('new/');
    final listResult = await storageRef.listAll();
    List videos = [];
    for (var item in listResult.items) {
      await item.getDownloadURL().then((value) async {
        videos.add({
          'thmbnail': await saveThumbnailPhoto(context, value),
          'videoUrl': value
        });
      });
    }

    return videos;
  }

  Future pickVideo(ImageSource source, BuildContext context) async {
    try {
      final video = await ImagePicker().pickVideo(source: source);
      if (video == null) return;
      // final ImageTemprorary=File(image.path);
      final videoPermenant = await saveVideoPermanently(video.path);
      setState(() {
        this.video = videoPermenant;
      });
      await postDetailsToFirestore(context);
    } on PlatformException catch (e) {
      print(AppLocalizations.of(context)!.errorOccuredTryLater,);
    }
  }

  Future<File> saveVideoPermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    String name = Path.basename(imagePath);
    final video = File('${directory.absolute}/$name');

    return File(imagePath);
  }

//////////////////////////////////////////////////////////////////////////
  postDetailsToFirestore(BuildContext context) async {
    User? user = _auth.currentUser;
    //User pic ref
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/${user?.uid}')
        .child('Videos')
        .child('new/${basename(video!.path)}');

    if (video != null) {
      try {
        showLoading(context);

        //To upload the user profile to firebase Storage
        await ref.putFile(video!);
        hideLoading(context);

        //show toastval text

        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.videoSaved,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
        setState(() {});
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> saveThumbnailPhoto(
      BuildContext context, String videoUrl) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      maxHeight:
          220, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      maxWidth: 220,
      quality: 100,
    );
    return fileName.toString();
  }
}
