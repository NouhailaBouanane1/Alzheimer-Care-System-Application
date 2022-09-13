import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graduation_project/Emergency/Emergency.dart';
import 'package:graduation_project/Favorites/favorite_menu.dart';
import 'package:graduation_project/Favorites/edit_fav.dart';
import 'package:graduation_project/Gallery/video.dart';
import 'package:graduation_project/Settings/settings.dart';
import 'package:graduation_project/ToDo/ToDoMain.dart';
import 'package:graduation_project/ToDo/task_data.dart';
import 'package:graduation_project/ToDoPatient/ToDoMainPatient.dart';
import 'package:graduation_project/changePassword.dart';
import 'package:graduation_project/chatbot/chatbot.dart';
import 'package:graduation_project/drugReminder/addDrug.dart';
import 'package:graduation_project/drugReminder/drugReminder.dart';
import 'package:graduation_project/drugReminder/drug_prov.dart';
import 'package:graduation_project/l10n/l10n.dart';
import 'package:graduation_project/mode_model.dart';
import 'package:graduation_project/models/lang_model.dart';
import 'package:graduation_project/non_patient/Diseases/diseases_prov.dart';
import 'package:graduation_project/non_patient/home_page.dart';
import 'package:graduation_project/ressetPassword.dart';
import 'package:graduation_project/requests.dart';
import 'package:graduation_project/screen15Patient.dart';
import 'package:graduation_project/screen16Patient.dart';
import 'package:graduation_project/screen17Patient.dart';
import 'package:graduation_project/screen1Patient.dart';
import 'package:graduation_project/screen3Patient.dart';
import 'package:graduation_project/screen4Patient.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graduation_project/screen5Patient.dart';
import 'package:graduation_project/screen6Patient.dart';
import 'package:graduation_project/screen7Patient.dart';
import 'package:graduation_project/screen8Patient.dart';
import 'package:graduation_project/users_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'QUIIZ/mainQuizPage.dart';
import 'ToDo/add_task_screen.dart';
import 'chatMessages/chatScreen.dart';
import 'onBoarding/onboardingPage.dart';
import 'package:provider/provider.dart';
import 'Favorites/fav_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sizer/sizer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
}

User? _user;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (FirebaseAuth.instance.currentUser != null) {
    _user = FirebaseAuth.instance.currentUser;
  }
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => FavPlaces()),
    ChangeNotifierProvider(create: (_) => DrugProv()),
    ChangeNotifierProvider(create: (_) => Mode()),
    ChangeNotifierProvider(create: (_) => DiseaseProv()),
    ChangeNotifierProvider(create: (_) => Lang())
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var _langProv = Provider.of<Lang>(context, listen: true);
    var _modeProv = Provider.of<Mode>(context, listen: false);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return ChangeNotifierProvider(
          create: (context) => taskData(),
          child: FutureBuilder<String>(
              future: _modeProv.getMode(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Flutter Demo',
                      supportedLocales: L10n.all,
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],
                      locale: _langProv.lang,
                      theme: ThemeData(primaryColor: Colors.purpleAccent),
                      home: _user == null
                          ? OnBoardingPage()
                          : snapshot.data == 'Patients'
                              ? screen15Patient()
                              : const HomePage());
                } else {
                  return  MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: Scaffold(
                      backgroundColor: Colors.white,
                      body:Center(child: CircularProgressIndicator()),
                      //
                    ),
                  );
                }
              }),
        );
      },
    );
    //ToDoMain
    //ToDoMainPatient
    //proofOfLife
    //Emergency
    //screen17Patient
  }
}
//Setting page doc&caregiver, Notifications, Change lang function, shared pref, call me, send home location.
//Add task notification add done!
