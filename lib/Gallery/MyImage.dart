import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyImage extends StatefulWidget {
  @override
  _MyImageState createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  dynamic fb;
  final _auth = FirebaseAuth.instance; //to call our firebase
  List<String> itemList = [];
  File? image;

  @override
  Widget build(BuildContext context) {
    // get height and width
    double width;
    double height;

    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text(
          AppLocalizations.of(context)!.images,
          style: TextStyle(fontSize: 27),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff9C27B0), Color(0xffBA68C8)],
              stops: [0.5, 1.0],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickImage(ImageSource.gallery, context);
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
          future: getImages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List images = snapshot.data as List;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.2),
                shrinkWrap: true,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    height: 260,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
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
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              errorDialog(
                context,
                AppLocalizations.of(context)!.errorOccuredTryLater,
              );
              return const SizedBox();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Future getImages() async {
    User? user = _auth.currentUser;
    final storageRef =
        FirebaseStorage.instance.ref(user!.uid).child('Images').child('new/');
    try {
      final listResult = await storageRef.listAll();
      List images = [];
      for (var item in listResult.items) {
        await item.getDownloadURL().then((value) => images.add(value));
      }

      return images;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future pickImage(ImageSource source, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      // final ImageTemprorary=File(image.path);
      final ImagePermenant = await saveImagePermanently(image.path);
      setState(() {
        this.image = ImagePermenant;
      });
      await postDetailsToFirestore(context);
    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    String name = Path.basename(imagePath);
    final image = File('${directory.absolute}/$name');

    return File(imagePath);
  }

//////////////////////////////////////////////////////////////////////////
  postDetailsToFirestore(BuildContext context) async {
    User? user = _auth.currentUser;
    //User pic ref
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/${user?.uid}')
        .child('Images')
        .child('new/${basename(image!.path)}');

    if (image != null) {
      try {
        showLoading(context);

        //To upload the user profile to firebase Storage
        await ref.putFile(image!);
        hideLoading(context);

        //show toastval text

        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.imageSaved,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
        setState(() {});
      } catch (e) {
        print(e);
      }
    }
  }

///////////////////////////////////////////////////////////////////////////
/*Future<void> getImage() async {
  User? user =_auth.currentUser;
  await _picker.pickImage(source: ImageSource.gallery).then((img){
    //store image in image
    image=img as File;
  });
  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      .ref('/${user?.uid}')
      .child('myImage')
      .child('new/${basename(image.path)}}');
//
  //UploadTask uploadTask = ref.putFile(image);

  //await uploadTask.onComplete;

  ref.getDownloadURL().then((fileURL) {
    _uploadedFileURL = fileURL;
    if(_uploadedFileURL!=null){
      dynamic key=CreateCryptoRandomString(32);
      fb.child(key).set({
        "id": key,
        "link": _uploadedFileURL,
      }).then((value) {
        ShowToastNow();
      });
    }else{
      print("url is null");
    }
  });
}
ShowToastNow(){
  //show toastval text

  Fluttertoast.showToast(msg:"Image saved",toastLength:Toast.LENGTH_LONG,gravity:ToastGravity.BOTTOM);
}*/
}
