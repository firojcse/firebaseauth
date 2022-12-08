import 'package:firebase_core/firebase_core.dart';
import 'package:firojfirebase/pages/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'pages/image_upload/image_upload.dart';
import 'pages/splash_screen/splesh_screan01.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splesh_Screan(),
    );
  }
}