import 'dart:io';
import 'package:advanced_project/res/assets_res.dart';
import 'package:advanced_project/shared/cubit/Appcubit/appcubit.dart';
import 'package:advanced_project/shared/cubit/bloc_observer.dart';
import 'package:advanced_project/shared/cubit/loginCubit/logincubit.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamcubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zego_zimkit/services/services.dart';



import 'Screens/authScreen.dart';
String? defaultImagePath;
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  ZIMKit().init(
    appID: 1250794916, // your appid
    appSign: '7acbef41316953ff041fc6bb361e218931d6c3a441011cddc4f1adc22516ef61', // your appSign
  );
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  defaultImagePath = await saveAssetImageToDevice();
  runApp(const MyApp());
}

XFile ImageFile = XFile(defaultImagePath!);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<Logincubit>(
          create: (context) => Logincubit()..imageFile = ImageFile,
        ),
        BlocProvider<AppCubit>(
          create: (context) => AppCubit()..loadUserData(),
        ),
        BlocProvider<TeamCubit>(
          create: (context) => TeamCubit()..getTeamsData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthScreen(),
      ),
    );
  }
}

Future<String> saveAssetImageToDevice() async {
  // Get the directory for the app's document path
  Directory? appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;

  // Create the image file path
  String imagePath = '$appDocPath/default.png';

  // Check if the image file already exists
  File imageFile = File(imagePath);
  if (await imageFile.exists()) {
    return imagePath;
  }

  // Read the image data from assets
  ByteData imageData = await rootBundle.load(AssetsRes.DEFAULT);

  // Save the image data to the device
  await imageFile.writeAsBytes(imageData.buffer.asUint8List());

  return imagePath;
}
