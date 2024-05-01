import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taskmanager/auth/login.dart';
import 'package:taskmanager/auth/sign.dart';
import 'package:taskmanager/screens/admin/pages/bottomNavigationBarAdmin.dart';
import 'package:taskmanager/screens/admin/pages/adminHome.dart';
import 'package:taskmanager/screens/users/pages/bottomNavigation.dart';
import 'package:taskmanager/screens/users/pages/home.dart';
import 'package:taskmanager/splash.dart';

import 'firebase_options.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Permission.locationWhenInUse.isDenied.then((valueOfPermission)
  {
    if(valueOfPermission){
      Permission.locationWhenInUse.request();
    }

  });

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseDatabase database = FirebaseDatabase.instance;


    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      title: 'Task Manager',
      home: FirebaseAuth.instance.currentUser == null ? LoginPage() :  LoginPage(),
      //SplashScreen(),

      //BottomNavigationBarAdminPage(),
      /// FirebaseAuth.instance.currentUser == null ? LoginPage() :  LoginPage(),
    );
  }
}

