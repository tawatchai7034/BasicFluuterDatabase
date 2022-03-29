import 'package:basic_sqflite/Screen/catPro_screen.dart';
import 'package:basic_sqflite/Screen/home_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../Camera/camera_screen.dart';

late List<CameraDescription> cameras = [];

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Qsflite Demo",
      theme: ThemeData(primarySwatch:Colors.blue),
      home:const CatProScreen(),
    );
  }
}
