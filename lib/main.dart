import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbdp/UserTypePage.dart';
import 'package:provider/provider.dart';

import 'Services/AuthenticationService.dart';
import 'Services/DataStoreService.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance)),
        Provider<DataStoreService>(
            create: (_) => DataStoreService(FirebaseFirestore.instance)),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanages,
            initialData: FirebaseAuth.instance.currentUser)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Baby Digital Platform ',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserTypePage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
